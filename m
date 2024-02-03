Return-Path: <linux-wireless+bounces-3075-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7AC848008
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Feb 2024 05:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88F0BB27098
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Feb 2024 04:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F46F9E6;
	Sat,  3 Feb 2024 04:00:17 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from out198-184.us.a.mail.aliyun.com (out198-184.us.a.mail.aliyun.com [47.90.198.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F090F9E4
	for <linux-wireless@vger.kernel.org>; Sat,  3 Feb 2024 04:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706932817; cv=none; b=OXE5mHmZhrsUYh5RzUILhXHrgEnAGf+uZe7+p9wngdPllWvqoSFvGMVg689+OxvYe2nf8mHY8YsVT4fjhwGf70elKdlX1YPAtmWbf5vC3ofODBfwXZOoPzhc6AgkafET78E6kib7rSPKGuF86BLobAlFDQTAlgu2sHzed/uG9zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706932817; c=relaxed/simple;
	bh=i2JS5CNAlAS2KDXyghfgzjDdySz4oWcQwgTcEtFlRHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p837mFE/957T34PqutgRC6RGmYKpECi39dTsrZE2A5Ue+pNXSD/1xSIS+DgygXXk2qkIf6tkEnB/1UZPwd28ULSIvSeE5w2IQWt7SuueA+MEHopty7FbfTVqgPtgsdPs2NjretQr3GDVlxY+2XjYjVmM4ifhK37TEgDWs9oZmho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aibsd.com; spf=pass smtp.mailfrom=aibsd.com; arc=none smtp.client-ip=47.90.198.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aibsd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aibsd.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.0743626|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0302729-0.00655141-0.963176;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047201;MF=aiden.leong@aibsd.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.WMIfISS_1706932793;
Received: from 192.168.31.5(mailfrom:aiden.leong@aibsd.com fp:SMTPD_---.WMIfISS_1706932793)
          by smtp.aliyun-inc.com;
          Sat, 03 Feb 2024 11:59:55 +0800
Message-ID: <e69d5b6a-6355-438b-87c2-c2596e048103@aibsd.com>
Date: Sat, 3 Feb 2024 11:59:53 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] wifi: iwlwifi: pcie: fix the order of scanning
 iwl_dev_info_table
To: "Greenman, Gregory" <gregory.greenman@intel.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 arnd@arndb.de, nathan@kernel.org, kvalo@codeaurora.org,
 johannes.berg@intel.com, luciano.coelho@intel.com
Cc: "edumazet@google.com" <edumazet@google.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
References: <20230119175657.9205-1-aiden.leong@aibsd.com>
 <51e9eeb2cd84f0f8ff92981b47a8e77e11047847.camel@intel.com>
 <5815091.MhkbZ0Pkbq@eq59> <4811051.31r3eYUQgx@eq59>
 <41704272e91ede88e49a61d7943d4e1c6c88e9c4.camel@intel.com>
From: Aiden Leong <aiden.leong@aibsd.com>
In-Reply-To: <41704272e91ede88e49a61d7943d4e1c6c88e9c4.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

It has been a year since the first time I submitted a patch on AX101.

We didn't have a nice conversation due to many reasons and 
misunderstandings.

Since the device is working well now, I believe this might be a 
relatively proper timing to

explain a bit more about the whole story.

Previous emails are important any more, so I just write on top.

This is absolutely not any sort of complaint but just a simple and 
hopefully friendly additional information.


Let's get start.

The story begins when we traverse a configuration look-up table of a 
long list of devices.

E.g.

     if we have devices [a1, a2, a3] of series A, [b1, b2, b3] of series B.

     we may have future devices a4, b4, so we have fall back config for 
series A and B

Then the table should be like this: [a1, a2, a3, A(fallback), b1, b2, 
b3, B(fallback)].

The original correct version was:

     for (i = 0; i < ARRAY_SIZE(iwl_dev_info_table); i++) {
         const struct iwl_dev_info *dev_info = &iwl_dev_info_table[i];
         if ((dev_info->device == (u16)IWL_CFG_ANY ||
              ...
             goto found;
         }
     }

It's a simple top-down search and break with `goto found`. So far so good.


Then there was not 1 but 3 refactorings. The former one introduced a bug 
and made a chaos

in the config table as well.

commit 32ed101aa140 ("iwlwifi: convert all Qu with Jf devices to the new 
 >  config table")

Refactor version 1 wrong code:

     for (i = 0; i < ARRAY_SIZE(iwl_dev_info_table); i++) {
         const struct iwl_dev_info *dev_info = &iwl_dev_info_table[i];
         if ((dev_info->device == (u16)IWL_CFG_ANY ||
              ...
         }
     }

It removed `goto found` with no reason, so the last match will always be 
the A(fallback) or B(fallback).

This patch was commited on Mar 27, 2020

Again, the table was NEVER reversed.


Then the second refactor was commited on Oct 28, 2021

commit 0a1f96d571c8 (iwlwifi: pcie: refactor dev_info lookup)

Refactor version 2 code:

     for (i = 0; i < ARRAY_SIZE(iwl_dev_info_table); i++) {
         const struct iwl_dev_info *dev_info = &iwl_dev_info_table[i];
         if (dev_info->device != (u16)IWL_CFG_ANY &&
             dev_info->device != device)
             continue;
         ...
         ret = dev_info;
     }

It was a good refactoring but he didn't notice the bug introduced by the 
former patch.


Then the third refactor was commited on Nov 23, 2021

commit fe785f56ad58 (iwlwifi: pcie: fix constant-conversion warning)

Refactor version 3 code:

     for (i = num_devices - 1; i >= 0; i--) {
         const struct iwl_dev_info *dev_info = &iwl_dev_info_table[i];

         if (dev_info->device != (u16)IWL_CFG_ANY &&
             dev_info->device != device)
             continue;
         ...

         return dev_info;
     }

     return NULL;

This time somebody found the weirdness: why do we traverse a table 
top-down but logically down-top?

Unfortunately again, he didn't find the bug buried deep in the git 
history years ago.


It's now Feb 3, 2024. 4 years later after the first wrong patch.

The config table `iwl_dev_info_table` is still mixed with fallback-last 
and fallback-first entries.

[a1, a2, a3, A, b1, b2, b3, B, C, c1, c2, c3]

Some devices works. Some devices don't work. Some issues are reported. 
Some are not.

That's why my patch was not even possible to pass Intel's mysterious 
internal testing process.


I'm not opinionated on top-down or down-top traverse, the 
big-little-endian story,

but we need to write logically correct code.


Aiden Leong



On 2023/3/12 17:47, Greenman, Gregory wrote:

> On Fri, 2023-03-10 at 13:14 +0800, Aiden Leong wrote:
>> On Wednesday, February 8, 2023 5:14:50 AM CST Aiden Leong wrote:
>>> On Wednesday, February 8, 2023 1:44:39 AM CST Greenman, Gregory wrote:
>>>> On Fri, 2023-01-20 at 01:56 +0800, Aiden Leong wrote:
>>>>> Fix a bug introduced by:
>>>>> commit 32ed101aa140 ("iwlwifi: convert all Qu with Jf devices to the new
>>>>>
>>>>>   config table"), so now we pick the FIRST matching config.
>>>>>
>>>>> Signed-off-by: Aiden Leong <aiden.leong@aibsd.com>
>>>>> ---
>>>>>
>>>>>   drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 2 +-
>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
>>>>> b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
>>>   index
>>>
>>>>> 99768d6a6032..05764eef15a7 100644
>>>>> --- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
>>>>> +++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
>>>>> @@ -1456,7 +1456,7 @@ iwl_pci_find_dev_info(u16 device, u16
>>>>> subsystem_device,
>>>   if (!num_devices)
>>>
>>>>>                  return NULL;
>>>>>
>>>>> -       for (i = num_devices - 1; i >= 0; i--) {
>>>>> +       for (i = 0; i < num_devices; i++) {
>>>>>
>>>>>                  const struct iwl_dev_info *dev_info =
>>>>>
>>>>> &iwl_dev_info_table[i];
>>>>>
>>>>>                  if (dev_info->device != (u16)IWL_CFG_ANY &&
>>>> It failed or internal testing, so it's more complicated. To traverse this
>>>> table
>>>   from the beginning to the end requires some changes to the table
>>>
>>>> itself and the "goto" wasn't omitted by a mistake, but for a reason...
>>>> For the device that you have (device id 0x4DF0, sub-device id 0x0244,
>>>> right?)
>>>   is it enough to have the first fix (disable
>>>
>>>> tx_with_siso_diversity)?
>>> Hi Gregory,
>>> That's exactly why I put a warning in previous emails.
>>> My opinion will be a little different than yours in this situation.
>>> 1. We SHOULD traverse this table from top to bottom to keep our source tree
>>> as clean as possible.
>>> 2. One simple option is to reverse every config items in this table so the
>>> logic keep the same.
>>> 3. Your team(I assume Luca Coelho is your colleague) may need to provide
>>> further explaination about the `goto` line, since each change in kernel
>>> should have a reason.
>>> 4. 0x4DF0, 0x0244 is correct. The question is: Will Intel release products
>>> with same pid+subID but differenct STEP/RF_TYPE/RF_ID etc? If so, pid+subID
>>> won't be enough.
>>>
>>> To sum up, there will be three patches:
>>> 1. This patch still fixes the BUG introduced by the `goto` change.
>>> 2. Patch 2 should be [PATCH 1/2] in previous email.
>>> 3. Patch 3 reverses every items in this table. Your team can fine-tune the
>>> order of each items. I won't submit this patch.
>>>
>>> If you like my ideas, please merge patch1&2 along with another ident fix
>>> patch.
>>>
>>> BTW, it has been a month since the first email. I'd appreciate if you reply
>>> soon.
>>>
>>> Cheers,
>>> Aiden
>> Hi Gregory,
>>
>> PING
>>
>> You should let us know if you are not actively maintaining the community part
>> of the driver. If you are only working on the close source firmware, we should
>> have someone else do the open source job.
>> We should not waste our life for months on such a small patch.
>>
>> Have a nice day,
>> Aiden
> Hi,
>
> You’re coming across as rather accusatory and demanding. I’d appreciate if you could
> tone it down a bit. Regarding the table order, we’ve made a decision in the code way
> back to walk the table from the back – that may not match your personal expectation of
> “clean”, but that’s really your problem, not ours.
> Also, we cannot comment on future product releases in general.
>
> If you’re willing to work with us to fix the issue you’re encountering within the
> framework of how the driver is written now, I can give you a patch with more logs
> to understand why your second patch doesn't fix the issue.
>
> Regards,
> Gregory

