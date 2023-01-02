Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D9765B359
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Jan 2023 15:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbjABOcq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Jan 2023 09:32:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjABOcp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Jan 2023 09:32:45 -0500
Received: from out20-99.mail.aliyun.com (out20-99.mail.aliyun.com [115.124.20.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDB0627E
        for <linux-wireless@vger.kernel.org>; Mon,  2 Jan 2023 06:32:42 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1688144|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0144125-0.000623363-0.984964;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047204;MF=aiden.leong@aibsd.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.QiiGHhp_1672669958;
Received: from 192.168.31.192(mailfrom:aiden.leong@aibsd.com fp:SMTPD_---.QiiGHhp_1672669958)
          by smtp.aliyun-inc.com;
          Mon, 02 Jan 2023 22:32:39 +0800
Message-ID: <b5b67842-17a2-f2b8-3c58-b6242b77e5b7@aibsd.com>
Date:   Mon, 2 Jan 2023 22:32:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] iwlwifi: pcie: add support for AX101NGW
Content-Language: en-US
To:     "Greenman, Gregory" <gregory.greenman@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
References: <20230102024021.2900-1-aiden.leong@aibsd.com>
 <b1e7aabf9f1543fda0919a41ca97ead23b298225.camel@intel.com>
From:   Aiden Leong <aiden.leong@aibsd.com>
In-Reply-To: <b1e7aabf9f1543fda0919a41ca97ead23b298225.camel@intel.com>
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

1. I know nothing about what `tx_with_siso_diversity` is. It's just a 
hardware flag to me. Main line.

2. I have the real device. Tested. Two photos was sent to Luca Coelho as 
well.

3. /drivers/net/wireless/intel/iwlwifi/pcie/drv.c#L623

 > IWL_DEV_INFO(0x4DF0, 0x1651, killer1650s_2ax_cfg_qu_b0_hr_b0, NULL),

The device I have is 0x4DF0, 0x0244. They share the same device ID.

4. I have narrowed down my code with _mac_step, _rf_type, _rf_id, 
_no_160 and _cores, so it should be safe to other devices.

Happy New Year

Aiden

On 2023/1/2 21:32, Greenman, Gregory wrote:
> On Mon, 2023-01-02 at 10:40 +0800, Aiden Leong wrote:
>> AX101NGW(0x4DF0, 0x0244) should have tx_with_siso_diversity unset.
> Why it should be unset? Which kernel do you have?
> Commit 3f910a25839b13436bf0a22186f1698b23eafb91 added AX101 device.
>
>> Signed-off-by: Aiden Leong <aiden.leong@aibsd.com>
>> ---
>> Ref Commit: 9352ed0165ff4313ab340c979446c3d64c531f7a
>> Tested on my own device.
>> ---
>>   drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
>> index 99768d6a6032..a46df1320372 100644
>> --- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
>> +++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
>> @@ -986,6 +986,11 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
>>                        iwl_qu_c0_hr_b0, iwl_ax201_name),
>>   
>>          /* QuZ */
>> +       _IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
>> +                     IWL_CFG_MAC_TYPE_QUZ, SILICON_B_STEP,
>> +                     IWL_CFG_RF_TYPE_HR1, IWL_CFG_RF_ID_HR1,
>> +                     IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_NO_JACKET,
>> +                     iwl_cfg_quz_a0_hr_b0, iwl_ax101_name),
>>          _IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
>>                        IWL_CFG_MAC_TYPE_QUZ, IWL_CFG_ANY,
>>                        IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY,
