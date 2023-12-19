Return-Path: <linux-wireless+bounces-1045-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2809881938F
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 23:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D301828599F
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 22:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B423D0C5;
	Tue, 19 Dec 2023 22:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAVAuJcm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAEC3D0A2
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 22:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40c29f7b068so55857885e9.0
        for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 14:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703024966; x=1703629766; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1EIz6PJr4Nb8wXnXKpqw4u5wstlTp8HoxEIsnaMYVFc=;
        b=nAVAuJcmRDpVZdVHyh35XNcp14OlAeRYLyA8LXBqKG9DJZd+ZvgeQ/WSU8VuMggYlJ
         ecgNBbqrJhFt4PhASix85KuptLLix7gMEqfsd5ZbtbrQTPxMX5+iK5JdL41xq1Zdsq3d
         0F4NYmKhCwLmKmVeMlgt+1uhdtuLwoYpiVQPKKj022PmGJ3T9dThs1KGFPPyYGDueS7y
         /FMBiSux8/kS0HiuCf0HVHG6XeNnx28jNPFGS3RUgcOckvfQUteWFR5sNpfA36S+88mY
         pa1Pvyp5otAIp5AkmpMXfZ219a8hGJA/VQjbGDiFE4A8mlrRm6dMN9Xbc9KkEFkCWm9i
         ZO1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703024966; x=1703629766;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1EIz6PJr4Nb8wXnXKpqw4u5wstlTp8HoxEIsnaMYVFc=;
        b=ozlKQ+ASGQ3Ib6H/cobdSxeoxoRJTZQuTYo4fQGxcXQjj905B/g2q8iZEnlvqw7WvL
         lmD0bJMeZKdIXl+DS9aR9hOO1oG9G86X1uVxRNt0XIUQG0i58yeVWGdD4+fHtk8jorYo
         U5Xuf69xw0CNZUM9z+CNtpPKqbMWjEGKrGYhyYjZ8S0sZFegggJjXa3oBGv1hVStyybr
         kA5N0g83XVo2CnTjcSAsG1RuU7gQ/SaJyLsf/SQ7OG6zjRWj4gsbr6C9jN36WDCjKQ68
         2VY6vykyqxkSULQbA+Oo3WprI48VRp2OrBJKPuAn3uYanWCwXzDKCfLkiB1jAo80eyeD
         316g==
X-Gm-Message-State: AOJu0YyLocklKV8Ohh6/TEt6fXR2DgGyIJXH681ew7NX3iR4Dl5bOKvX
	s7sw47HCLYHXpKQ9ki1bgnc=
X-Google-Smtp-Source: AGHT+IFfAwzFxbXNQSWoM9QUZSq5Ev3wQv/eCTrizPTUK/pSkH5uyiadKs1cqp24P7RCVCCD+CePOg==
X-Received: by 2002:a05:600c:2e0c:b0:40c:2c73:a4f8 with SMTP id o12-20020a05600c2e0c00b0040c2c73a4f8mr9416212wmf.179.1703024965853;
        Tue, 19 Dec 2023 14:29:25 -0800 (PST)
Received: from [192.168.1.50] ([81.196.40.51])
        by smtp.gmail.com with ESMTPSA id s20-20020a05600c45d400b0040b36ad5413sm4668834wmo.46.2023.12.19.14.29.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 14:29:25 -0800 (PST)
Message-ID: <f73b5afc-d69f-4a7c-8bf0-877a45327e0b@gmail.com>
Date: Wed, 20 Dec 2023 00:29:23 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH 18/20] wifi: rtl8xxxu: add hw crypto support for AP mode
To: Martin Kaistra <martin.kaistra@linutronix.de>,
 linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
 Ping-Ke Shih <pkshih@realtek.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20231218143645.433356-1-martin.kaistra@linutronix.de>
 <20231218143645.433356-19-martin.kaistra@linutronix.de>
Content-Language: en-US
In-Reply-To: <20231218143645.433356-19-martin.kaistra@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/12/2023 16:36, Martin Kaistra wrote:
> Add a custom function for allocating entries in the sec cam. This allows
> us to store multiple keys with the same keyidx.
> 
> The maximum number of sec cam entries (for 8188f) is 16 according to the
> vendor driver.

The other chips seem to support more:

RTL8723BU, RTL8192EU, RTL8192FU: 64
RTL8188EU: 32
RTL8710BU: 32 (even though it supports only 16 macid)

I'm not sure about the RTL8723AU and RTL8192CU. Those drivers are
older and different.

Perhaps this should be a member of struct rtl8xxxu_fileops, like
max_macid_num?

> 
> Set the bssid as mac address for group keys instead of just using the
> ethernet broadcast address and use BIT(6) in the sec cam ctrl entry
> for differentiating them from pairwise keys like in the vendor driver.
> 
> Add the TXDESC_EN_DESC_ID bit and the hw_key_idx to tx
> broadcast/multicast packets in AP mode.
> 
> Finally, allow the usage of rtl8xxxu_set_key() for AP mode.
> 
> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
> ---
>  .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  4 ++
>  .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 48 +++++++++++++++----
>  2 files changed, 42 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> index 889ef7217f142..a0222d2666000 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> @@ -498,6 +498,7 @@ struct rtl8xxxu_txdesc40 {
>  #define DESC_RATE_ID_SHIFT		16
>  #define DESC_RATE_ID_MASK		0xf
>  #define TXDESC_NAVUSEHDR		BIT(20)
> +#define TXDESC_EN_DESC_ID		BIT(21)
>  #define TXDESC_SEC_RC4			0x00400000
>  #define TXDESC_SEC_AES			0x00c00000
>  #define TXDESC_PKT_OFFSET_SHIFT		26
> @@ -1774,6 +1775,7 @@ struct rtl8xxxu_cfo_tracking {
>  #define RTL8XXXU_HW_LED_CONTROL	2
>  #define RTL8XXXU_MAX_MAC_ID_NUM	128
>  #define RTL8XXXU_BC_MC_MACID	0
> +#define RTL8XXXU_MAX_SEC_CAM_NUM	16
>  
>  struct rtl8xxxu_priv {
>  	struct ieee80211_hw *hw;
> @@ -1907,6 +1909,7 @@ struct rtl8xxxu_priv {
>  	char led_name[32];
>  	struct led_classdev led_cdev;
>  	DECLARE_BITMAP(mac_id_map, RTL8XXXU_MAX_MAC_ID_NUM);
> +	DECLARE_BITMAP(cam_map, RTL8XXXU_MAX_SEC_CAM_NUM);
>  };
>  
>  struct rtl8xxxu_sta_info {
> @@ -1918,6 +1921,7 @@ struct rtl8xxxu_sta_info {
>  
>  struct rtl8xxxu_vif {
>  	int port_num;
> +	u8 hw_key_idx;
>  };
>  
>  struct rtl8xxxu_rx_urb {
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> index c2a577ebd061e..88730791091a7 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> @@ -4558,8 +4558,10 @@ static void rtl8xxxu_cam_write(struct rtl8xxxu_priv *priv,
>  	 * This is a bit of a hack - the lower bits of the cipher
>  	 * suite selector happens to match the cipher index in the CAM
>  	 */
> -	addr = key->keyidx << CAM_CMD_KEY_SHIFT;
> +	addr = key->hw_key_idx << CAM_CMD_KEY_SHIFT;
>  	ctrl = (key->cipher & 0x0f) << 2 | key->keyidx | CAM_WRITE_VALID;
> +	if (!(key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
> +		ctrl |= BIT(6);
>  
>  	for (j = 5; j >= 0; j--) {
>  		switch (j) {
> @@ -5545,13 +5547,14 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
>  	struct rtl8xxxu_tx_urb *tx_urb;
>  	struct ieee80211_sta *sta = NULL;
>  	struct ieee80211_vif *vif = tx_info->control.vif;
> +	struct rtl8xxxu_vif *rtlvif = (struct rtl8xxxu_vif *)vif->drv_priv;
>  	struct device *dev = &priv->udev->dev;
>  	u32 queue, rts_rate;
>  	u16 pktlen = skb->len;
>  	int tx_desc_size = priv->fops->tx_desc_size;
>  	u8 macid;
>  	int ret;
> -	bool ampdu_enable, sgi = false, short_preamble = false;
> +	bool ampdu_enable, sgi = false, short_preamble = false, bmc = false;
>  
>  	if (skb_headroom(skb) < tx_desc_size) {
>  		dev_warn(dev,
> @@ -5593,10 +5596,14 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
>  		tx_desc->txdw0 =
>  			TXDESC_OWN | TXDESC_FIRST_SEGMENT | TXDESC_LAST_SEGMENT;
>  	if (is_multicast_ether_addr(ieee80211_get_DA(hdr)) ||
> -	    is_broadcast_ether_addr(ieee80211_get_DA(hdr)))
> +	    is_broadcast_ether_addr(ieee80211_get_DA(hdr))) {
>  		tx_desc->txdw0 |= TXDESC_BROADMULTICAST;
> +		bmc = true;
> +	}
> +
>  
>  	tx_desc->txdw1 = cpu_to_le32(queue << TXDESC_QUEUE_SHIFT);
> +	macid = rtl8xxxu_get_macid(priv, sta);
>  
>  	if (tx_info->control.hw_key) {
>  		switch (tx_info->control.hw_key->cipher) {
> @@ -5611,6 +5618,10 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
>  		default:
>  			break;
>  		}
> +		if (bmc && rtlvif->hw_key_idx != 0xff) {
> +			tx_desc->txdw1 |= TXDESC_EN_DESC_ID;
> +			macid = rtlvif->hw_key_idx;
> +		}

cpu_to_le32(TXDESC_EN_DESC_ID)

The vendor drivers only do this for data frames. Is it the same here?

>  	}
>  
>  	/* (tx_info->flags & IEEE80211_TX_CTL_AMPDU) && */
> @@ -5654,7 +5665,6 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
>  	else
>  		rts_rate = 0;
>  
> -	macid = rtl8xxxu_get_macid(priv, sta);
>  	priv->fops->fill_txdesc(hw, hdr, tx_info, tx_desc, sgi, short_preamble,
>  				ampdu_enable, rts_rate, macid);
>  
> @@ -6656,6 +6666,7 @@ static int rtl8xxxu_add_interface(struct ieee80211_hw *hw,
>  
>  	priv->vifs[port_num] = vif;
>  	rtlvif->port_num = port_num;
> +	rtlvif->hw_key_idx = 0xff;
>  
>  	rtl8xxxu_set_linktype(priv, vif->type, port_num);
>  	ether_addr_copy(priv->mac_addr, vif->addr);
> @@ -6832,11 +6843,19 @@ static int rtl8xxxu_set_rts_threshold(struct ieee80211_hw *hw, u32 rts)
>  	return 0;
>  }
>  
> +static int rtl8xxxu_get_free_sec_cam(struct ieee80211_hw *hw)
> +{
> +	struct rtl8xxxu_priv *priv = hw->priv;
> +
> +	return find_first_zero_bit(priv->cam_map, RTL8XXXU_MAX_SEC_CAM_NUM);
> +}
> +
>  static int rtl8xxxu_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
>  			    struct ieee80211_vif *vif,
>  			    struct ieee80211_sta *sta,
>  			    struct ieee80211_key_conf *key)
>  {
> +	struct rtl8xxxu_vif *rtlvif = (struct rtl8xxxu_vif *)vif->drv_priv;
>  	struct rtl8xxxu_priv *priv = hw->priv;
>  	struct device *dev = &priv->udev->dev;
>  	u8 mac_addr[ETH_ALEN];
> @@ -6848,9 +6867,6 @@ static int rtl8xxxu_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
>  	dev_dbg(dev, "%s: cmd %02x, cipher %08x, index %i\n",
>  		__func__, cmd, key->cipher, key->keyidx);
>  
> -	if (vif->type != NL80211_IFTYPE_STATION)
> -		return -EOPNOTSUPP;
> -
>  	if (key->keyidx > 3)
>  		return -EOPNOTSUPP;
>  
> @@ -6874,7 +6890,7 @@ static int rtl8xxxu_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
>  		ether_addr_copy(mac_addr, sta->addr);
>  	} else {
>  		dev_dbg(dev, "%s: group key\n", __func__);
> -		eth_broadcast_addr(mac_addr);
> +		ether_addr_copy(mac_addr, vif->bss_conf.bssid);
>  	}
>  
>  	val16 = rtl8xxxu_read16(priv, REG_CR);
> @@ -6888,16 +6904,28 @@ static int rtl8xxxu_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
>  
>  	switch (cmd) {
>  	case SET_KEY:
> -		key->hw_key_idx = key->keyidx;
> +
> +		retval = rtl8xxxu_get_free_sec_cam(hw);
> +		if (retval < 0)
> +			return -EOPNOTSUPP;
> +
> +		key->hw_key_idx = retval;
> +
> +		if (vif->type == NL80211_IFTYPE_AP && !(key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
> +			rtlvif->hw_key_idx = key->hw_key_idx;
> +
>  		key->flags |= IEEE80211_KEY_FLAG_GENERATE_IV;
>  		rtl8xxxu_cam_write(priv, key, mac_addr);
> +		set_bit(key->hw_key_idx, priv->cam_map);
>  		retval = 0;
>  		break;
>  	case DISABLE_KEY:
>  		rtl8xxxu_write32(priv, REG_CAM_WRITE, 0x00000000);
>  		val32 = CAM_CMD_POLLING | CAM_CMD_WRITE |
> -			key->keyidx << CAM_CMD_KEY_SHIFT;
> +			key->hw_key_idx << CAM_CMD_KEY_SHIFT;
>  		rtl8xxxu_write32(priv, REG_CAM_CMD, val32);
> +		rtlvif->hw_key_idx = 0xff;
> +		clear_bit(key->hw_key_idx, priv->cam_map);
>  		retval = 0;
>  		break;
>  	default:


