# UserManage
To Use In KBTC

1. Manage လုပ်ချင်တဲ့ group တွေကို allgroup.csv တွင်ထည့် ပါ
2. "allgroup.csv" တွင် "id" နေရာတွင် Group ID ထည့်ပေးရမည် "DisplayName" နေရာတွင် Group Display Name ထည့်ပေးရမည်
3. Initial ကို run ပါ

## Adding new users to different groups

1. Run **UpdateUserLists.ps1**
2. **lists** folder အောက်တွင် **(newMember).csv** နှင့်ဆုံးသည့် file တွင် အသစ်ထည့်မည့် new MEMBER users များ ထည့်ပေးရမည် CSV တွင် User ခေါင်းစဉ်ထည့်ပေးရမည်
3. **lists** folder အောက်တွင် **newOwner.csv** နှင့်ဆုံးသည့် file တွင် အသစ်ထည့်မည့် new Owner users များ ထည့်ပေးရမည် CSV တွင် User ခေါင်းစဉ်ထည့်ပေးရမည်
4. Run **AddingNewUsers.ps1**
5. **UpdateUserLists.ps1** ကိုပြန် run ပေးရမည် နောက်ဆုံးထည့်ထားတဲ့ users များရဲ့ lists update ဖြစ်နေရန်အတွက်
