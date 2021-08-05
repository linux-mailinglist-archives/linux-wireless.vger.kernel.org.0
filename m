Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0E4B3E0F97
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Aug 2021 09:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236191AbhHEHup (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Aug 2021 03:50:45 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:52974 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229674AbhHEHuo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Aug 2021 03:50:44 -0400
X-UUID: 09012ca01f6e4b8d93495502ba24a715-20210805
X-UUID: 09012ca01f6e4b8d93495502ba24a715-20210805
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1570785462; Thu, 05 Aug 2021 15:50:26 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 5 Aug 2021 15:50:03 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 5 Aug 2021 15:50:03 +0800
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
Subject: Re: [PATCH v2] mt76: connac: add support maximum regulatory Tx power
Date:   Thu, 5 Aug 2021 15:50:02 +0800
Message-ID: <1628149802-26387-1-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <YQuI/Zf8vYjKx9LR@lore-desk--annotate>
References: <YQuI/Zf8vYjKx9LR@lore-desk--annotate>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

>> From: YN Chen <YN.Chen@mediatek.com>
>>
>> Consider .max_reg_power in struct ieee80211_channel to limit the
>> maximum power the wireless device allowed to transmit on the
>> corresponding channel according to the regulatory domain.
>>
>> Co-developed-by: Sean Wang <sean.wang@mediatek.com>
>> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>> Signed-off-by: YN Chen <YN.Chen@mediatek.com>
>> ---
>> v2: consider the power limit that can be allowed on mt7663
>> ---
>>  .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 43
>> ++++++++++++++++++-
>>  1 file changed, 41 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
>> b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
>> index d71393b1c5e6..80987af03efe 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
>> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
>> @@ -1773,6 +1773,43 @@ static s8 mt76_connac_get_sar_power(struct mt76_phy *phy,
>>	return target_power;
>>  }
>>
>> +static s8 mt76_connac_get_ch_power(struct mt76_phy *phy,
>> +				   struct ieee80211_channel *chan,
>> +				   s8 target_power)
>> +{
>> +	struct mt76_dev *dev = phy->dev;
>> +	struct ieee80211_supported_band *sband;
>> +	int i;
>> +
>> +	switch (chan->band) {
>> +	case NL80211_BAND_2GHZ:
>> +		sband = &phy->sband_2g.sband;
>> +		break;
>> +	case NL80211_BAND_5GHZ:
>> +		sband = &phy->sband_5g.sband;
>> +		break;
>> +	default:
>> +		return target_power;
>> +	}
>> +
>> +	for (i = 0; i < sband->n_channels; i++) {
>> +		struct ieee80211_channel *ch = &sband->channels[i];
>> +
>> +		if (ch->hw_value == chan->hw_value) {
>> +			if (!(ch->flags & IEEE80211_CHAN_DISABLED)) {
>> +				int power = 2 * ch->max_reg_power;
>> +
>> +				if (is_mt7663(dev) && (power > 63 || power < -64))
>> +					power = 63;
>
>I guess now you are missing the value for mt7921. What I mean is something similar to mt76_connac_mcu_build_sku()
>
>int max_power = is_mt7921(dev) ? 127 : 63;

the power limit that can be allowed on mt7921 would be -128 to 127 and target_power is s8 type

so I think the boundary check for mt7921 case is unnecessary

>Regards,
>Lorenzo
>
>> +				target_power = min_t(s8, power, target_power);
>> +			}
>> +			break;
>> +		}
>> +	}
>> +
>> +	return target_power;
>> +}
>> +
>>  static int
>>  mt76_connac_mcu_rate_txpower_band(struct mt76_phy *phy,
>>				  enum nl80211_band band)
>> @@ -1840,10 +1877,12 @@ mt76_connac_mcu_rate_txpower_band(struct mt76_phy *phy,
>>				.hw_value = ch_list[idx],
>>				.band = band,
>>			};
>> -			s8 sar_power;
>> +			s8 reg_power, sar_power;
>>
>> +			reg_power = mt76_connac_get_ch_power(phy, &chan,
>> +							     tx_power);
>>			sar_power = mt76_connac_get_sar_power(phy, &chan,
>> -							      tx_power);
>> +							      reg_power);
>>
>>			mt76_get_rate_power_limits(phy, &chan, &limits,
>>						   sar_power);
>> --
>> 2.25.1
>>
>
