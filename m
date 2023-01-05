Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7CE65E5CA
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jan 2023 08:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjAEHCz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Jan 2023 02:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjAEHCv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Jan 2023 02:02:51 -0500
Received: from out20-109.mail.aliyun.com (out20-109.mail.aliyun.com [115.124.20.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B451F53708
        for <linux-wireless@vger.kernel.org>; Wed,  4 Jan 2023 23:02:47 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09697764|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0842021-0.00375534-0.912043;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047203;MF=aiden.leong@aibsd.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.QksBvxt_1672902162;
Received: from 192.168.31.192(mailfrom:aiden.leong@aibsd.com fp:SMTPD_---.QksBvxt_1672902162)
          by smtp.aliyun-inc.com;
          Thu, 05 Jan 2023 15:02:43 +0800
Message-ID: <becf35b8-df98-7e19-bf26-1a288cd0ddd0@aibsd.com>
Date:   Thu, 5 Jan 2023 15:02:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/2] iwlwifi: pcie: add support for AX101NGW
Content-Language: en-US
To:     "Greenman, Gregory" <gregory.greenman@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
References: <20230102024038.2915-1-aiden.leong@aibsd.com>
 <00a7a47051ead3032f383868248d89e56d3617f4.camel@intel.com>
 <708fad8b-0419-ae7f-8586-7da58b50d925@aibsd.com>
 <ae38f167ef5f16cac767db4b7a20984731e8b874.camel@intel.com>
From:   Aiden Leong <aiden.leong@aibsd.com>
In-Reply-To: <ae38f167ef5f16cac767db4b7a20984731e8b874.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2023/1/5 14:21, Greenman, Gregory wrote:
> On Mon, 2023-01-02 at 22:00 +0800, Aiden Leong wrote:
>> 1. Please have a look at the second commit:
>> https://lore.kernel.org/linux-wireless/iwlwifi.20200323151304.ec4f463bde60.I14e9146a99621ff11ce50bc746a4b88af508fee0@changeid/
>>
>> Find the `goto found;` statement.
>>
>> The logic was to find the FIRST match then break with `goto found`. The
>> refactor code removed the `goto` statement which is incorrect.
>>
>>
>> 2. Let's go back to the first commit:
>> https://lore.kernel.org/linux-wireless/iwlwifi.20211024165252.abd85e1391cb.I7681fe90735044cc1c59f120e8591b7ac125535d@changeid/
>>
>>   > We don't want to change the semantics ("most generic entry must come
>> first")
>>
>> That `semantics` was mislead by the previous commit.
>>
>>
>> On 2023/1/2 21:35, Greenman, Gregory wrote:
>>> On Mon, 2023-01-02 at 10:40 +0800, Aiden Leong wrote:
>>>> Revert:
>>>> commit 3f7320428fa4 ("iwlwifi: pcie: simplify iwl_pci_find_dev_info()")
>>>>
>>>> A bug was introduced by:
>>>> commit 32ed101aa140 ("iwlwifi: convert all Qu with Jf devices to the new
>>>> config table"),
>>>> where a goto statement was removed.
>>> Not sure I undestand what problem reversing the "for" loop solves.
>>>
>>>> Signed-off-by: Aiden Leong <aiden.leong@aibsd.com>
>>>> ---
>>>> Notice:
>>>> Please run further tests before merging. I'm NOT familiar with device
>>>> drivers.
>>>> ---
>>>>    drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
>>>> index a46df1320372..5d74adbd49cf 100644
>>>> --- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
>>>> +++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
>>>> @@ -1461,7 +1461,7 @@ iwl_pci_find_dev_info(u16 device, u16 subsystem_device,
>>>>           if (!num_devices)
>>>>                   return NULL;
>>>>    
>>>> -       for (i = num_devices - 1; i >= 0; i--) {
>>>> +       for (i = 0; i < num_devices; i++) {
>>>>                   const struct iwl_dev_info *dev_info = &iwl_dev_info_table[i];
>>>>    
>>>>                   if (dev_info->device != (u16)IWL_CFG_ANY &&
> So, the fix itself is correct (thanks for fixing it!).
> The commit message should be a bit changed, the "goto" removal is not relevant
> in the current code since now this for loop is in a separate function. Also, all
> wifi commits should have prefix "wifi: " to separate them from the rest of netdev.
> Tell me if you want to resend this commit or I can fix it by myself.
>
I'm a kernel newbie. Thank you for your patience.

I'd like to resend the commit so I can learn more about how to do it right.

The title of the patchset will be "wifi: iwlwifi: pcie: add support for 
AX101NGW",

and the commit message will be "Fix a bug introduced by: commit 
32ed101aa140 ("iwlwifi: convert all Qu with Jf devices to the new config 
table"), so now we pick the FIRST matching config."

Would it be all right?


Have a nice day!

Aiden Leong

