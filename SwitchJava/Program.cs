using System;
using System.Collections;
using System.Collections.Generic;
using System.Security.Principal;
using System.Text.RegularExpressions;

namespace SwitchJava
{
    class Program
    {
        // version -- path
        static Dictionary<int,string> envs;

        private static bool CheckPrivilege()
        {
            WindowsIdentity identity = WindowsIdentity.GetCurrent();
            WindowsPrincipal principal = new WindowsPrincipal(identity);

            return principal.IsInRole(WindowsBuiltInRole.Administrator);
        }

        public static void GetAll()
        {
            envs = new Dictionary<int, string>();
            // 获取所有系统环境变量
            IDictionary environmentVariables = Environment.GetEnvironmentVariables();
            Regex regex = new Regex(@"JAVA\d+_HOME");
            Regex versionRegex = new Regex(@"\d+");

            // 遍历环境变量
            foreach (DictionaryEntry variable in environmentVariables)
            {
                if (regex.IsMatch((string)variable.Key))
                {
                    envs[int.Parse(versionRegex.Match((string)variable.Key).Value)]= (string)variable.Value;
                }
            }
        }

        public static void Select()
        {
            foreach(var dic in envs)
            {
                Console.WriteLine("Java {0}: {1}", dic.Key, dic.Value);
            }
            Console.Write("选择需要切换的版本号:");
            try
            {
                int option = int.Parse(Console.ReadLine());
                Change(envs[option]);
            }
            catch
            {
                Console.WriteLine("当前输入不合法.");
                Environment.Exit(-1);
            }
                
        }

        public static void Change(string path)
        {
            Environment.SetEnvironmentVariable("JAVA_HOME", path, EnvironmentVariableTarget.Machine);
            Console.WriteLine("[+]Java版本切换成功");
            Console.ReadKey();
        }

        static void Main(string[] args)
        {
            if (!CheckPrivilege())
            {
                Console.WriteLine("[-]当前程序需要以管理员身份运行.");
                Environment.Exit(0);
            }
            GetAll();
            Select();
        }
     }
}
