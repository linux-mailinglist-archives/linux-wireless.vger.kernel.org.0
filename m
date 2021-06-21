Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B3F3AF8C7
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jun 2021 00:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbhFUWte (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Jun 2021 18:49:34 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:35837 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230438AbhFUWte (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Jun 2021 18:49:34 -0400
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Jun 2021 18:49:33 EDT
X-UUID: 6aab15fc1c504a0c89887413bfe7e43f-20210622
X-UUID: 6aab15fc1c504a0c89887413bfe7e43f-20210622
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2142100021; Tue, 22 Jun 2021 06:42:14 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 22 Jun 2021 06:42:12 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 22 Jun 2021 06:42:12 +0800
From:   <sean.wang@mediatek.com>
To:     <lorenzo.bianconi@redhat.com>
CC:     <nbd@nbd.name>, <sean.wang@mediatek.com>,
        <Soul.Huang@mediatek.com>, <YN.Chen@mediatek.com>,
        <Leon.Yen@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <jemele@google.com>, <yenlinlai@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] mt76: mt7921: add .set_sar_specs support
Date:   Tue, 22 Jun 2021 06:42:11 +0800
Message-ID: <1624315331-16608-1-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <YM8NBUZp+/97kiIH@lore-desk--annotate>
References: <YM8NBUZp+/97kiIH@lore-desk--annotate>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

>> From: YN Chen <YN.Chen@mediatek.com>
>>
>> add .set_sar_specs to allow configuring SAR power limitations on the
>> frequency ranges from the userland.
>>
>> Co-developed-by: Sean Wang <sean.wang@mediatek.com>
>> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>> Signed-off-by: YN Chen <YN.Chen@mediatek.com>
>> ---
>>  drivers/net/wireless/mediatek/mt76/mt76.h     |  3 ++
>>  .../net/wireless/mediatek/mt76/mt76_connac.h  |  5 +++
>> .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 24 +++++++++-
>> .../net/wireless/mediatek/mt76/mt7921/init.c  | 21 +++++++++
>> .../net/wireless/mediatek/mt76/mt7921/main.c  | 45 +++++++++++++++++++
>>  5 files changed, 97 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h
>> b/drivers/net/wireless/mediatek/mt76/mt76.h
>> index 25c5ceef5257..63ce5242c4d5 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt76.h
>> +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
>> @@ -636,6 +636,9 @@ struct mt76_phy {
>>		struct sk_buff **tail;
>>		u16 seqno;
>>	} rx_amsdu[__MT_RXQ_MAX];
>> +
>> +	void *frp_data;
>> +	u8 num_frps;
>>  };
>>
>>  struct mt76_dev {
>> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
>> b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
>> index f49d97d0a1c5..95c7d1cac7c4 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
>> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
>> @@ -83,6 +83,11 @@ struct mt76_connac_coredump {
>>	unsigned long last_activity;
>>  };
>>
>> +struct mt76_connac_freq_range_power {
>> +	const struct cfg80211_sar_freq_ranges *range;
>> +	s8 power;
>> +};
>> +
>>  extern const struct wiphy_wowlan_support mt76_connac_wowlan_support;
>>
>>  static inline bool is_mt7921(struct mt76_dev *dev) diff --git
>> a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
>> b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
>> index 5c3a81e5f559..07f45cb4f500 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
>> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
>> @@ -1749,6 +1749,24 @@ mt76_connac_mcu_build_sku(struct mt76_dev *dev, s8 *sku,
>>	}
>>  }
>>
>> +static s8 mt76_connac_get_sar_power(struct mt76_phy *phy,
>> +				    struct ieee80211_channel *chan,
>> +				    s8 target_power)
>> +{
>> +	struct mt76_connac_freq_range_power *frp = phy->frp_data;
>> +	int freq, i;
>> +
>> +	freq = ieee80211_channel_to_frequency(chan->hw_value, chan->band);
>> +	for (i = 0 ; i < phy->num_frps; i++) {
>> +		if (frp[i].range &&
>> +		    freq >= frp[i].range->start_freq &&
>> +		    freq < frp[i].range->end_freq)
>> +			target_power = min_t(s8, frp[i].power, target_power);
>
>can we have overlapping freq range? if not I guess you can add a break here.

It is supposed to be there is no overlapping freq range for the real use case. I will add a break in the next version.
>
>
>> +	}
>> +
>> +	return target_power;
>> +}
>> +
>>  static int
>>  mt76_connac_mcu_rate_txpower_band(struct mt76_phy *phy,
>>				  enum nl80211_band band)
>> @@ -1816,9 +1834,13 @@ mt76_connac_mcu_rate_txpower_band(struct mt76_phy *phy,
>>				.hw_value = ch_list[idx],
>>				.band = band,
>>			};
>> +			s8 sar_power;
>> +
>> +			sar_power = mt76_connac_get_sar_power(phy, &chan,
>> +							      tx_power);
>>
>>			mt76_get_rate_power_limits(phy, &chan, &limits,
>> -						   tx_power);
>> +						   sar_power);
>>
>>			tx_power_tlv.last_msg = ch_list[idx] == last_ch;
>>			sku_tlbv.channel = ch_list[idx];
>> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
>> b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
>> index a9ce10b98827..e7f66d988a49 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
>> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
>> @@ -24,6 +24,20 @@ static const struct ieee80211_iface_combination if_comb[] = {
>>	}
>>  };
>>
>> +const struct cfg80211_sar_freq_ranges mt7921_sar_freq_ranges[] = {
>> +	{ .start_freq = 2402, .end_freq = 2494, },
>> +	{ .start_freq = 5150, .end_freq = 5350, },
>> +	{ .start_freq = 5350, .end_freq = 5470, },
>> +	{ .start_freq = 5470, .end_freq = 5725, },
>> +	{ .start_freq = 5725, .end_freq = 5950, }, };
>> +
>> +static const struct cfg80211_sar_capa mt7921_sar_capa = {
>> +	.type = NL80211_SAR_TYPE_POWER,
>> +	.num_freq_ranges = ARRAY_SIZE(mt7921_sar_freq_ranges),
>> +	.freq_ranges = &mt7921_sar_freq_ranges[0], };
>> +
>>  static void
>>  mt7921_regd_notifier(struct wiphy *wiphy,
>>		     struct regulatory_request *request) @@ -75,6 +89,13 @@
>> mt7921_init_wiphy(struct ieee80211_hw *hw)
>>	wiphy->max_sched_scan_reqs = 1;
>>	wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH;
>>	wiphy->reg_notifier = mt7921_regd_notifier;
>> +	wiphy->sar_capa = &mt7921_sar_capa;
>> +
>> +	phy->mt76->frp_data = devm_kcalloc(dev->mt76.dev,
>> +					   wiphy->sar_capa->num_freq_ranges,
>> +					   sizeof(struct mt76_connac_freq_range_power),
>> +					   GFP_KERNEL);
>
>Here I guess we need to check if devm_kcalloc fails returning an int from
>mt7921_init_wiphy()

Sure, will do it.

>
>> +	phy->mt76->num_frps = wiphy->sar_capa->num_freq_ranges;
>>
>>	wiphy->features |= NL80211_FEATURE_SCHED_SCAN_RANDOM_MAC_ADDR |
>>			   NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR;
>> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
>> b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
>> index 7fd21049ff5a..e9b5d79e139f 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
>> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
>> @@ -1171,6 +1171,50 @@ static void mt7921_sta_set_decap_offload(struct ieee80211_hw *hw,
>>					     MCU_UNI_CMD_STA_REC_UPDATE);  }
>>
>> +static int mt7921_set_sar_specs(struct ieee80211_hw *hw,
>> +				const struct cfg80211_sar_specs *sar) {
>> +	const struct cfg80211_sar_capa *capa = hw->wiphy->sar_capa;
>> +	struct mt76_connac_freq_range_power *frp_data, *frp;
>> +	struct mt7921_dev *dev = mt7921_hw_dev(hw);
>> +	struct mt76_phy *mphy = hw->priv;
>> +	int err;
>> +	u32 i;
>> +
>> +	mt7921_mutex_acquire(dev);
>> +
>> +	if (!sar || sar->type != NL80211_SAR_TYPE_POWER ||
>> +	    sar->num_sub_specs == 0) {
>> +		err = -EINVAL;
>> +		goto out;
>> +	}
>
>I guess you can move this out of the lock
>

Sure, will do it.

>> +
>> +	frp_data = mphy->frp_data;
>> +
>> +	for (i = 0; i < sar->num_sub_specs; i++) {
>> +		u32 index = sar->sub_specs[i].freq_range_index;
>> +		/* SAR specifies power limitaton in 0.25dbm */
>> +		s32 power = sar->sub_specs[i].power >> 1;
>> +
>> +		if (power > 127 || power < -127)
>> +			power = 127;
>> +
>> +		if (index >= mphy->num_frps)
>> +			continue;
>> +
>> +		frp = &frp_data[index];
>> +		frp->range = &capa->freq_ranges[index];
>
>I guess there is an use-after-free here since sar is freed at the end of nl80211_set_sar_specs, right?
>

Nope, there is no use-after-free case happens here because frp->range just points to an entry of const struct cfg80211_sar_specs table, not the one created from nl80211_set_sar_specs.

>Regards,
>Lorenzo
>
>> +		frp->power = power;
>> +	}
>> +
>> +	err = mt76_connac_mcu_set_rate_txpower(mphy);
>> +
>> +out:
>> +	mt7921_mutex_release(dev);
>> +
>> +	return err;
>> +}
>> +
>>  const struct ieee80211_ops mt7921_ops = {
>>	.tx = mt7921_tx,
>>	.start = mt7921_start,
>> @@ -1209,4 +1253,5 @@ const struct ieee80211_ops mt7921_ops = {
>>	.set_rekey_data = mt7921_set_rekey_data,  #endif /* CONFIG_PM */
>>	.flush = mt7921_flush,
>> +	.set_sar_specs = mt7921_set_sar_specs,
>>  };
>> --
>> 2.25.1
>>
