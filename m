Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F08A65B306
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Jan 2023 15:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbjABOAT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Jan 2023 09:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjABOAR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Jan 2023 09:00:17 -0500
Received: from out20-63.mail.aliyun.com (out20-63.mail.aliyun.com [115.124.20.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A39E263
        for <linux-wireless@vger.kernel.org>; Mon,  2 Jan 2023 06:00:15 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.235798|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0487568-0.0152389-0.936004;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047203;MF=aiden.leong@aibsd.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.QihWJey_1672668011;
Received: from 192.168.31.192(mailfrom:aiden.leong@aibsd.com fp:SMTPD_---.QihWJey_1672668011)
          by smtp.aliyun-inc.com;
          Mon, 02 Jan 2023 22:00:12 +0800
Message-ID: <708fad8b-0419-ae7f-8586-7da58b50d925@aibsd.com>
Date:   Mon, 2 Jan 2023 22:00:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/2] iwlwifi: pcie: add support for AX101NGW
To:     "Greenman, Gregory" <gregory.greenman@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
References: <20230102024038.2915-1-aiden.leong@aibsd.com>
 <00a7a47051ead3032f383868248d89e56d3617f4.camel@intel.com>
Content-Language: en-US
From:   Aiden Leong <aiden.leong@aibsd.com>
In-Reply-To: <00a7a47051ead3032f383868248d89e56d3617f4.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

1. Please have a look at the second commit: 
https://lore.kernel.org/linux-wireless/iwlwifi.20200323151304.ec4f463bde60.I14e9146a99621ff11ce50bc746a4b88af508fee0@changeid/

Find the `goto found;` statement.

The logic was to find the FIRST match then break with `goto found`. The 
refactor code removed the `goto` statement which is incorrect.


2. Let's go back to the first commit: 
https://lore.kernel.org/linux-wireless/iwlwifi.20211024165252.abd85e1391cb.I7681fe90735044cc1c59f120e8591b7ac125535d@changeid/

 > We don't want to change the semantics ("most generic entry must come 
first")

That `semantics` was mislead by the previous commit.


On 2023/1/2 21:35, Greenman, Gregory wrote:
> On Mon, 2023-01-02 at 10:40 +0800, Aiden Leong wrote:
>> Revert:
>> commit 3f7320428fa4 ("iwlwifi: pcie: simplify iwl_pci_find_dev_info()")
>>
>> A bug was introduced by:
>> commit 32ed101aa140 ("iwlwifi: convert all Qu with Jf devices to the new
>> config table"),
>> where a goto statement was removed.
> Not sure I undestand what problem reversing the "for" loop solves.
>
>> Signed-off-by: Aiden Leong <aiden.leong@aibsd.com>
>> ---
>> Notice:
>> Please run further tests before merging. I'm NOT familiar with device
>> drivers.
>> ---
>>   drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
>> index a46df1320372..5d74adbd49cf 100644
>> --- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
>> +++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
>> @@ -1461,7 +1461,7 @@ iwl_pci_find_dev_info(u16 device, u16 subsystem_device,
>>          if (!num_devices)
>>                  return NULL;
>>   
>> -       for (i = num_devices - 1; i >= 0; i--) {
>> +       for (i = 0; i < num_devices; i++) {
>>                  const struct iwl_dev_info *dev_info = &iwl_dev_info_table[i];
>>   
>>                  if (dev_info->device != (u16)IWL_CFG_ANY &&
