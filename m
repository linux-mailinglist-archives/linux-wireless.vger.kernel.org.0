Return-Path: <linux-wireless+bounces-316-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1368017DF
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Dec 2023 00:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EEC71C209D1
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 23:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F463F8F5;
	Fri,  1 Dec 2023 23:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="l8YwvBuh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F4D1A4
	for <linux-wireless@vger.kernel.org>; Fri,  1 Dec 2023 15:40:33 -0800 (PST)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 650BD240071;
	Fri,  1 Dec 2023 23:40:30 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 9B74F13C2B0;
	Fri,  1 Dec 2023 15:40:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 9B74F13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1701474029;
	bh=6xmydaKfNOwZDzoXAvf6X0X1JmBWLT0SK2Yn4Bw27bc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=l8YwvBuh1cN0oexTmp/hq143OwyZrUAplw04BL+k32OLT3VgxIcKZwMF81hUo6AyI
	 fWzA8PM+Jaib3+o2x+OqifTrinJZDkWwZ4ovZka30X4HgVLl3+zy4dWi9B4GQ8HIyb
	 59IG2sFZ00NycXiBgDvjz9iqr3L8WmbmS8aHKrPc=
Message-ID: <bbf8fe7e-1098-5b33-8ed6-dee38329edf6@candelatech.com>
Date: Fri, 1 Dec 2023 15:40:29 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/8] wifi: mt76: mt7996: add txpower setting support
Content-Language: en-US
To: Shayne Chen <shayne.chen@mediatek.com>, Felix Fietkau <nbd@nbd.name>
Cc: linux-wireless <linux-wireless@vger.kernel.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
 Evelyn Tsai <evelyn.tsai@mediatek.com>,
 linux-mediatek <linux-mediatek@lists.infradead.org>,
 Allen Ye <allen.ye@mediatek.com>,
 StanleyYP Wang <StanleyYP.Wang@mediatek.com>
References: <20231102100302.22160-1-shayne.chen@mediatek.com>
 <20231102100302.22160-2-shayne.chen@mediatek.com>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <20231102100302.22160-2-shayne.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1701474031-mC5k0b4r3GGJ
X-MDID-O:
 us5;at1;1701474031;mC5k0b4r3GGJ;<greearb@candelatech.com>;0a87ce8853dfc5be48bfe846d29ed5d9

On 11/2/23 03:02, Shayne Chen wrote:
> Add support for setting txpower from upper layer and configuring per-rate
> txpower limit table.

Hello Shayne,

 From what I can tell, this patch causes STA vdevs to no longer send probe
requests when trying to associate.  I bisected to this in Felix's tree that holds
this patch.

Tested on x86-64, mtk7996 radio.  Specifically
debugged on 2.4Ghz radio, but I think it affects 5Ghz too.

Thanks,
Ben

> 
> Co-developed-by: Allen Ye <allen.ye@mediatek.com>
> Signed-off-by: Allen Ye <allen.ye@mediatek.com>
> Co-developed-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
> Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
> Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
> ---
>   .../net/wireless/mediatek/mt76/mt7996/main.c  |  8 +++
>   .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 58 +++++++++++++++++++
>   .../net/wireless/mediatek/mt76/mt7996/mcu.h   | 16 +++++
>   .../wireless/mediatek/mt76/mt7996/mt7996.h    |  3 +
>   4 files changed, 85 insertions(+)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> index 9f12b47eb2bf..7336eaa7b9ae 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> @@ -396,6 +396,13 @@ static int mt7996_config(struct ieee80211_hw *hw, u32 changed)
>   		ieee80211_wake_queues(hw);
>   	}
>   
> +	if (changed & (IEEE80211_CONF_CHANGE_POWER |
> +		       IEEE80211_CONF_CHANGE_CHANNEL)) {
> +		ret = mt7996_mcu_set_txpower_sku(phy);
> +		if (ret)
> +			return ret;
> +	}
> +
>   	mutex_lock(&dev->mt76.mutex);
>   
>   	if (changed & IEEE80211_CONF_CHANGE_MONITOR) {
> @@ -965,6 +972,7 @@ mt7996_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
>   	mt76_set_stream_caps(phy->mt76, true);
>   	mt7996_set_stream_vht_txbf_caps(phy);
>   	mt7996_set_stream_he_eht_caps(phy);
> +	mt7996_mcu_set_txpower_sku(phy);
>   
>   	mutex_unlock(&dev->mt76.mutex);
>   
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
> index 8097924d460b..8141c24ade50 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
> @@ -4353,3 +4353,61 @@ int mt7996_mcu_wed_rro_reset_sessions(struct mt7996_dev *dev, u16 id)
>   	return mt76_mcu_send_msg(&dev->mt76, MCU_WM_UNI_CMD(RRO), &req,
>   				 sizeof(req), true);
>   }
> +
> +int mt7996_mcu_set_txpower_sku(struct mt7996_phy *phy)
> +{
> +#define TX_POWER_LIMIT_TABLE_RATE	0
> +	struct mt7996_dev *dev = phy->dev;
> +	struct mt76_phy *mphy = phy->mt76;
> +	struct ieee80211_hw *hw = mphy->hw;
> +	struct tx_power_limit_table_ctrl {
> +		u8 __rsv1[4];
> +
> +		__le16 tag;
> +		__le16 len;
> +		u8 power_ctrl_id;
> +		u8 power_limit_type;
> +		u8 band_idx;
> +	} __packed req = {
> +		.tag = cpu_to_le16(UNI_TXPOWER_POWER_LIMIT_TABLE_CTRL),
> +		.len = cpu_to_le16(sizeof(req) + MT7996_SKU_RATE_NUM - 4),
> +		.power_ctrl_id = UNI_TXPOWER_POWER_LIMIT_TABLE_CTRL,
> +		.power_limit_type = TX_POWER_LIMIT_TABLE_RATE,
> +		.band_idx = phy->mt76->band_idx,
> +	};
> +	struct mt76_power_limits la = {};
> +	struct sk_buff *skb;
> +	int i, tx_power;
> +
> +	tx_power = mt7996_get_power_bound(phy, hw->conf.power_level);
> +	tx_power = mt76_get_rate_power_limits(mphy, mphy->chandef.chan,
> +					      &la, tx_power);
> +	mphy->txpower_cur = tx_power;
> +
> +	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL,
> +				 sizeof(req) + MT7996_SKU_RATE_NUM);
> +	if (!skb)
> +		return -ENOMEM;
> +
> +	skb_put_data(skb, &req, sizeof(req));
> +	/* cck and ofdm */
> +	skb_put_data(skb, &la.cck, sizeof(la.cck) + sizeof(la.ofdm));
> +	/* ht20 */
> +	skb_put_data(skb, &la.mcs[0], 8);
> +	/* ht40 */
> +	skb_put_data(skb, &la.mcs[1], 9);
> +
> +	/* vht */
> +	for (i = 0; i < 4; i++) {
> +		skb_put_data(skb, &la.mcs[i], sizeof(la.mcs[i]));
> +		skb_put_zero(skb, 2);  /* padding */
> +	}
> +
> +	/* he */
> +	skb_put_data(skb, &la.ru[0], sizeof(la.ru));
> +	/* eht */
> +	skb_put_data(skb, &la.eht[0], sizeof(la.eht));
> +
> +	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
> +				     MCU_WM_UNI_CMD(TXPOWER), true);
> +}
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
> index a3eae32c8f10..1562c8a6a821 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
> @@ -762,6 +762,18 @@ enum {
>   #define MT7996_MAX_BSS_OFFLOAD_SIZE	(MT7996_MAX_BEACON_SIZE +		\
>   					 MT7996_BEACON_UPDATE_SIZE)
>   
> +static inline s8
> +mt7996_get_power_bound(struct mt7996_phy *phy, s8 txpower)
> +{
> +	struct mt76_phy *mphy = phy->mt76;
> +	int n_chains = hweight16(mphy->chainmask);
> +
> +	txpower = mt76_get_sar_power(mphy, mphy->chandef.chan, txpower * 2);
> +	txpower -= mt76_tx_power_nss_delta(n_chains);
> +
> +	return txpower;
> +}
> +
>   enum {
>   	UNI_BAND_CONFIG_RADIO_ENABLE,
>   	UNI_BAND_CONFIG_RTS_THRESHOLD = 0x08,
> @@ -830,6 +842,10 @@ enum {
>   	UNI_CMD_THERMAL_PROTECT_DUTY_CONFIG,
>   };
>   
> +enum {
> +	UNI_TXPOWER_POWER_LIMIT_TABLE_CTRL = 4,
> +};
> +
>   enum {
>   	UNI_CMD_ACCESS_REG_BASIC = 0x0,
>   	UNI_CMD_ACCESS_RF_REG_BASIC,
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
> index d3eb564623ae..c62a42512bd6 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
> @@ -42,6 +42,8 @@
>   #define MT7996_CFEND_RATE_DEFAULT	0x49	/* OFDM 24M */
>   #define MT7996_CFEND_RATE_11B		0x03	/* 11B LP, 11M */
>   
> +#define MT7996_SKU_RATE_NUM		417
> +
>   #define MT7996_MAX_TWT_AGRT		16
>   #define MT7996_MAX_STA_TWT_AGRT		8
>   #define MT7996_MAX_QUEUE		(__MT_RXQ_MAX +	__MT_MCUQ_MAX + 3)
> @@ -471,6 +473,7 @@ int mt7996_mcu_get_chan_mib_info(struct mt7996_phy *phy, bool chan_switch);
>   int mt7996_mcu_get_temperature(struct mt7996_phy *phy);
>   int mt7996_mcu_set_thermal_throttling(struct mt7996_phy *phy, u8 state);
>   int mt7996_mcu_set_thermal_protect(struct mt7996_phy *phy, bool enable);
> +int mt7996_mcu_set_txpower_sku(struct mt7996_phy *phy);
>   int mt7996_mcu_rdd_cmd(struct mt7996_dev *dev, int cmd, u8 index,
>   		       u8 rx_sel, u8 val);
>   int mt7996_mcu_rdd_background_enable(struct mt7996_phy *phy,

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



