Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC454D4F8E
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Mar 2022 17:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242905AbiCJQpA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Mar 2022 11:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236683AbiCJQo7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Mar 2022 11:44:59 -0500
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769921587BF
        for <linux-wireless@vger.kernel.org>; Thu, 10 Mar 2022 08:43:58 -0800 (PST)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.26])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 08298A0072;
        Thu, 10 Mar 2022 16:43:57 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id F2B6694008D;
        Thu, 10 Mar 2022 16:43:55 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 6987F13C2B1;
        Thu, 10 Mar 2022 08:43:55 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 6987F13C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1646930635;
        bh=ptKo2MpaJcGo46VjFN/g8ZWbbd38wHV7bCs1tKxi+nY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HYKypX8Yqrk2MNODJW1WsERPFEMd48zUzEFCUMp4J+8Jw4kX8YE4SEsuGtkzUWrGf
         ocYLK0cx4VhydoF9Jp5gQBdW5SylSSBouf7fTzE7y5ZPLCJ6rXnvqCe6AT/Xo/6AQX
         2C7zwGJw7aeCl41xnQAntDPC4K1Fx1VlDfx2ib9U=
Subject: Re: [PATCH v2 1/2] mac80211: extend current rate control tx status
 API
To:     =?UTF-8?Q?Thomas_H=c3=bchn?= <thomas@inet.tu-berlin.de>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Jonas Jelonek <jelonek.jonas@gmail.com>
Cc:     Kalle Valo <kvalo@kernel.org>, "nbd@nbd.name" <nbd@nbd.name>,
        johannes@sipsolutions.net
References: <20220309195759.1494-1-jelonek.jonas@gmail.com>
 <20220309195759.1494-2-jelonek.jonas@gmail.com>
 <bc398c48-b5b2-8037-a8c6-712b2e191202@candelatech.com>
 <8FC6B734-4D4A-4D91-A38E-DE36E415A36E@inet.tu-berlin.de>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <22a43538-a2ad-f3a7-2909-5ef6a0d2ab27@candelatech.com>
Date:   Thu, 10 Mar 2022 08:43:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <8FC6B734-4D4A-4D91-A38E-DE36E415A36E@inet.tu-berlin.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-MDID: 1646930637-hZQlDust57Wm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/10/22 8:07 AM, Thomas Hühn wrote:
> Hiho
> 
>> On 9. Mar 2022, at 21:38, Ben Greear <greearb@candelatech.com> wrote:
>>
>> On 3/9/22 11:57 AM, Jonas Jelonek wrote:
>>> This patch adds the new struct ieee80211_rate_status and replaces
>>> 'struct rate_info *rate' in ieee80211_tx_status with pointer and length
>>> annotation.
>>> The struct ieee80211_rate_status allows to:
>>> (1)	receive tx power status feedback for transmit power control (TPC)
>>> 	per packet or packet retry
>>> (2)	dynamic mapping of wifi chip specific multi-rate retry (mrr)
>>> 	chains with different lengths
>>> (3)	increase the limit of annotatable rate indices to support
>>> 	IEEE802.11ac rate sets and beyond
>>> ieee80211_tx_info, control and status buffer, and ieee80211_tx_rate
>>> cannot be used to achieve these goals due to fixed size limitations.
>>> Our new struct contains a struct rate_info to annotate the rate that was
>>> used, retry count of the rate and tx power. It is intended for all
>>> information related to RC and TPC that needs to be passed from driver to
>>> mac80211 and its RC/TPC algorithms like Minstrel_HT. It corresponds to
>>> one stage in an mrr. Multiple subsequent instances of this struct can be
>>> included in struct ieee80211_tx_status via a pointer and a length variable.
>>> Those instances can be allocated on-stack. The former reference to a single
>>> instance of struct rate_info is replaced with our new annotation.
>>> Further mandatory changes in status.c and mt76 driver due to the
>>> removal of 'struct rate_info *rate' are also included.
>>> status.c already uses the information in ieee80211_tx_status->rate in
>>> radiotap, this is now changed to use ieee80211_rate_status->rate_idx.
>>> mt76 driver already uses struct rate_info to pass the tx rate to status
>>> path. It is now enclosed in an instance of struct ieee80211_rate_status
>>> with default values for retry_count and tx_power. The latter should be
>>> adjusted later to pass more accurate values.
>>> Compile-Tested: current wireless-next tree with all flags on
>>> Tested-on: Xiaomi 4A Gigabit (MediaTek MT7603E, MT7612E) with OpenWrt
>>> 		Linux 5.10.83
>>> Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
>>> ---
>>>   drivers/net/wireless/mediatek/mt76/tx.c | 13 +++-
>>>   include/net/mac80211.h                  | 10 ++-
>>>   net/mac80211/status.c                   | 91 ++++++++++++++-----------
>>>   3 files changed, 71 insertions(+), 43 deletions(-)
>>> diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
>>> index 6b8c9dc80542..ed3f3654999f 100644
>>> --- a/drivers/net/wireless/mediatek/mt76/tx.c
>>> +++ b/drivers/net/wireless/mediatek/mt76/tx.c
>>> @@ -62,13 +62,20 @@ mt76_tx_status_unlock(struct mt76_dev *dev, struct sk_buff_head *list)
>>>   		};
>>>   		struct mt76_tx_cb *cb = mt76_tx_skb_cb(skb);
>>>   		struct mt76_wcid *wcid;
>>> +		struct ieee80211_rate_status rate = {0};
>>>     		wcid = rcu_dereference(dev->wcid[cb->wcid]);
>>>   		if (wcid) {
>>>   			status.sta = wcid_to_sta(wcid);
>>> -
>>> -			if (status.sta)
>>> -				status.rate = &wcid->rate;
>>> +			if (status.sta) {
>>> +				rate.rate_idx = wcid->rate;
>>> +				rate.retry_count = 1;
>>> +				/* Default 0 for now, can be used by TPC algorithm */
>>> +				rate.tx_power = 0;
>>> +
>>> +				status.rates = &rate;
>>> +				status.n_rates = 1;
>>> +			}
>>>   		}
>>>     		hw = mt76_tx_status_get_hw(dev, skb);
>>> diff --git a/include/net/mac80211.h b/include/net/mac80211.h
>>> index c50221d7e82c..1e98ed04b446 100644
>>> --- a/include/net/mac80211.h
>>> +++ b/include/net/mac80211.h
>>> @@ -1131,6 +1131,12 @@ ieee80211_info_get_tx_time_est(struct ieee80211_tx_info *info)
>>>   	return info->tx_time_est << 2;
>>>   }
>>>   +struct ieee80211_rate_status {
>>> +	struct rate_info rate_idx;
>>> +	u8 retry_count;
>>> +	s8 tx_power;
>>> +};
>>
>> Please document the units for tx_power.  Many chips can support 1/2 db increments, for instance,
>> so consider that for units...  A zero txpower is still a valid number, so you probably need
>> something other than 0 to be the 'default'.  Like -128?
> 
> Certain 802.11a/g/n Atheros chips provide a 0,5dB tx-power step granularity, while Mediatek 802.11ac chips have 1dB or even 3dB step width. So I would argue that a 1dB step width is a good compromise as the common value for new tpc algorithms.

If you use 0.5db units for that struct, then it will support anything with that granularity or higher.
But, fine with me if you want to just have it be 1db units.

> 
> The ath9k chips I have used so far support a minimum tx-power of -5dBm (=0,32mW), Mediatek has a min of 0dBm (=1mW)… so I would argue to use 0dBm  (=1mW) as common minimum tx-power value, as the any possible spatial reuse gain happens from 0dBm up to max tx-power.

If a chip supports setting to txpower to -5, then why not let the API support that?  Have The value -128
be 'do not set', and anything else will mean 'try to set the chip to this power or the nearest thing to it
that the chip supports'.

Thanks,
Ben

> 
>>
>> And, does 'retry_count' actually mean 'try_count'?  So a single tx would be retry_count = 1?
>> Please document that as well.
>>
>> Thanks,
>> Ben
> 
> Greetings Thomas
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

