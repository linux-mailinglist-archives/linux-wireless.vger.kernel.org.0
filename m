Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B68E4D4EBD
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Mar 2022 17:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241524AbiCJQRF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Mar 2022 11:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239900AbiCJQRB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Mar 2022 11:17:01 -0500
X-Greylist: delayed 510 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Mar 2022 08:15:47 PST
Received: from mail.net.t-labs.tu-berlin.de (mail.net.t-labs.tu-berlin.de [130.149.152.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64175190C08
        for <linux-wireless@vger.kernel.org>; Thu, 10 Mar 2022 08:15:47 -0800 (PST)
Received: from smtpclient.apple (unknown [109.73.30.34])
        by mail.net.t-labs.tu-berlin.de (Postfix) with ESMTPSA id 0EB5320291;
        Thu, 10 Mar 2022 17:07:13 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH v2 1/2] mac80211: extend current rate control tx status
 API
From:   =?utf-8?Q?Thomas_H=C3=BChn?= <thomas@inet.tu-berlin.de>
In-Reply-To: <bc398c48-b5b2-8037-a8c6-712b2e191202@candelatech.com>
Date:   Thu, 10 Mar 2022 17:07:13 +0100
Cc:     Kalle Valo <kvalo@kernel.org>, "nbd@nbd.name" <nbd@nbd.name>,
        johannes@sipsolutions.net
Content-Transfer-Encoding: 8BIT
Message-Id: <8FC6B734-4D4A-4D91-A38E-DE36E415A36E@inet.tu-berlin.de>
References: <20220309195759.1494-1-jelonek.jonas@gmail.com>
 <20220309195759.1494-2-jelonek.jonas@gmail.com>
 <bc398c48-b5b2-8037-a8c6-712b2e191202@candelatech.com>
To:     Ben Greear <greearb@candelatech.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Jonas Jelonek <jelonek.jonas@gmail.com>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hiho

> On 9. Mar 2022, at 21:38, Ben Greear <greearb@candelatech.com> wrote:
> 
> On 3/9/22 11:57 AM, Jonas Jelonek wrote:
>> This patch adds the new struct ieee80211_rate_status and replaces
>> 'struct rate_info *rate' in ieee80211_tx_status with pointer and length
>> annotation.
>> The struct ieee80211_rate_status allows to:
>> (1)	receive tx power status feedback for transmit power control (TPC)
>> 	per packet or packet retry
>> (2)	dynamic mapping of wifi chip specific multi-rate retry (mrr)
>> 	chains with different lengths
>> (3)	increase the limit of annotatable rate indices to support
>> 	IEEE802.11ac rate sets and beyond
>> ieee80211_tx_info, control and status buffer, and ieee80211_tx_rate
>> cannot be used to achieve these goals due to fixed size limitations.
>> Our new struct contains a struct rate_info to annotate the rate that was
>> used, retry count of the rate and tx power. It is intended for all
>> information related to RC and TPC that needs to be passed from driver to
>> mac80211 and its RC/TPC algorithms like Minstrel_HT. It corresponds to
>> one stage in an mrr. Multiple subsequent instances of this struct can be
>> included in struct ieee80211_tx_status via a pointer and a length variable.
>> Those instances can be allocated on-stack. The former reference to a single
>> instance of struct rate_info is replaced with our new annotation.
>> Further mandatory changes in status.c and mt76 driver due to the
>> removal of 'struct rate_info *rate' are also included.
>> status.c already uses the information in ieee80211_tx_status->rate in
>> radiotap, this is now changed to use ieee80211_rate_status->rate_idx.
>> mt76 driver already uses struct rate_info to pass the tx rate to status
>> path. It is now enclosed in an instance of struct ieee80211_rate_status
>> with default values for retry_count and tx_power. The latter should be
>> adjusted later to pass more accurate values.
>> Compile-Tested: current wireless-next tree with all flags on
>> Tested-on: Xiaomi 4A Gigabit (MediaTek MT7603E, MT7612E) with OpenWrt
>> 		Linux 5.10.83
>> Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
>> ---
>>  drivers/net/wireless/mediatek/mt76/tx.c | 13 +++-
>>  include/net/mac80211.h                  | 10 ++-
>>  net/mac80211/status.c                   | 91 ++++++++++++++-----------
>>  3 files changed, 71 insertions(+), 43 deletions(-)
>> diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
>> index 6b8c9dc80542..ed3f3654999f 100644
>> --- a/drivers/net/wireless/mediatek/mt76/tx.c
>> +++ b/drivers/net/wireless/mediatek/mt76/tx.c
>> @@ -62,13 +62,20 @@ mt76_tx_status_unlock(struct mt76_dev *dev, struct sk_buff_head *list)
>>  		};
>>  		struct mt76_tx_cb *cb = mt76_tx_skb_cb(skb);
>>  		struct mt76_wcid *wcid;
>> +		struct ieee80211_rate_status rate = {0};
>>    		wcid = rcu_dereference(dev->wcid[cb->wcid]);
>>  		if (wcid) {
>>  			status.sta = wcid_to_sta(wcid);
>> -
>> -			if (status.sta)
>> -				status.rate = &wcid->rate;
>> +			if (status.sta) {
>> +				rate.rate_idx = wcid->rate;
>> +				rate.retry_count = 1;
>> +				/* Default 0 for now, can be used by TPC algorithm */
>> +				rate.tx_power = 0;
>> +
>> +				status.rates = &rate;
>> +				status.n_rates = 1;
>> +			}
>>  		}
>>    		hw = mt76_tx_status_get_hw(dev, skb);
>> diff --git a/include/net/mac80211.h b/include/net/mac80211.h
>> index c50221d7e82c..1e98ed04b446 100644
>> --- a/include/net/mac80211.h
>> +++ b/include/net/mac80211.h
>> @@ -1131,6 +1131,12 @@ ieee80211_info_get_tx_time_est(struct ieee80211_tx_info *info)
>>  	return info->tx_time_est << 2;
>>  }
>>  +struct ieee80211_rate_status {
>> +	struct rate_info rate_idx;
>> +	u8 retry_count;
>> +	s8 tx_power;
>> +};
> 
> Please document the units for tx_power.  Many chips can support 1/2 db increments, for instance,
> so consider that for units...  A zero txpower is still a valid number, so you probably need
> something other than 0 to be the 'default'.  Like -128?

Certain 802.11a/g/n Atheros chips provide a 0,5dB tx-power step granularity, while Mediatek 802.11ac chips have 1dB or even 3dB step width. So I would argue that a 1dB step width is a good compromise as the common value for new tpc algorithms.

The ath9k chips I have used so far support a minimum tx-power of -5dBm (=0,32mW), Mediatek has a min of 0dBm (=1mW)… so I would argue to use 0dBm  (=1mW) as common minimum tx-power value, as the any possible spatial reuse gain happens from 0dBm up to max tx-power.

> 
> And, does 'retry_count' actually mean 'try_count'?  So a single tx would be retry_count = 1?
> Please document that as well.
> 
> Thanks,
> Ben

Greetings Thomas

