Return-Path: <linux-wireless+bounces-32077-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6UvjDyktmmmzZQMAu9opvQ
	(envelope-from <linux-wireless+bounces-32077-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Feb 2026 23:09:45 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D42016E117
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Feb 2026 23:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1410E301D327
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Feb 2026 22:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2F6274FEB;
	Sat, 21 Feb 2026 22:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Opbw5OcW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15E014A8E
	for <linux-wireless@vger.kernel.org>; Sat, 21 Feb 2026 22:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771711780; cv=none; b=BVnjvYD8YtBakq+snKzEiaccv9f815Xn0Y+OxYhohnF9wECYulpdPeZufxUiU0h50p2BEmlH6qRVJnVp1RbhdNU7Rxyct8wvj5hzj0vdndjClGVaIlAtZ6jkM7eFpJSHPrMaH0C8eAvs8XEJLuwOiecRqfY/zz+sTFe0JJLyPbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771711780; c=relaxed/simple;
	bh=b+PGWBUeaDStCeIMFE07E5ZJoJ9GidwoCaCLkVXGTVw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QIgBNdNRolRUZ8abgpFMzuXrDLLjEe3OpjWBnra0sowVwL8G0rKGQsuYaMCYqBkxnBQbpXHR5deQJMTIZkBwcbMLs2d8EWl1hLfisYnOb9X+ehLZ/zReX7kOnPsFr761dt4AjkgQn9TYpcykV/OqJHEJjr3c2mM70cQmwv5ZHdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Opbw5OcW; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-436e8758b91so2233536f8f.0
        for <linux-wireless@vger.kernel.org>; Sat, 21 Feb 2026 14:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771711777; x=1772316577; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B4zILwid9wWjFNakPuUDYiY+OVOGHxzx404RkOX+sw4=;
        b=Opbw5OcWgDuSJPmlon6kmVugO0jzAnSn57+HzPHXKceaa0ZA3ZjM9/gzhtV4zHCVYS
         QKK7P/ZVsHsX3u09wp9+ZVeCWcX2CG7ZemD0IFbadSTg78aCBuyYZccTOlA4pwHUN+Zx
         loxv1LrdqEwO+tYxJxp/EmF3zH+Grr++u8cwhbKszdT2hwUbug8I4k9eyvdJnY86uN08
         mmVLaUnulkDnffc91WZB1DHaKZNEywjAhAOXEiEUDH1vUJAEsEWUtFcWheoTS0wIKXf2
         KI4qRXprLS6bial9BO97Rxul/ig1IfL3JgRouDJLVKtssOu8QIaGSREJUw15vdL2s9W7
         rTzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771711777; x=1772316577;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B4zILwid9wWjFNakPuUDYiY+OVOGHxzx404RkOX+sw4=;
        b=CekcVddNjCIwbVdQyohBJ02Sqeq32u6t5i/BF7wY+thCAATY+jpDxq0P7jvGi5Db7j
         GdkDahnk9+9pGp5uiZtcvp97Chd9A4Fw666rBy+/uTmGPGAUYQ2dK04Tn5anh/FdKDJp
         Sec6Kl1fn2EgraVDJuI00/oEoJF9Z+UAumhjyUTO7zx/e33t5EUsZ80OEW7PaU5gp/c7
         EzkKLM67UH/dPr5pQtO3KPsyBz05SO/OU/Q78TMOcAWtk4426fSTO+owvzGsVnvCn3o+
         yxFIORT2vnCgRRhGJQ+LUjCCsH5hfE334xc/egyOyndEeYbKmdf4GsInlEYu8Ei15BfF
         7lxg==
X-Forwarded-Encrypted: i=1; AJvYcCU87uVNuO+5oIKpAVEozMiGgAtirIpwhUzCQtUzDIQbGdtCfY3yQ+vuvNVAsOt1k0dfidg2n689MYBuc9fspg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXIE2risQTmnDgvyZqqrdNBHB3ss2E+bwDKHDFsaqsDai5Gl98
	8rh8XAX8UJmbvUrc5ixXP5RB4MaVqoDrCOz75RD7oA8cSWX4bFNpiRLbN+N4pw==
X-Gm-Gg: AZuq6aJKTYWZQBflNbhWe79adi/AcYX4DCbNb3yUe0KNDIoWjwCXIgWeLUum2iqDFYr
	hOmf9Bw/ZCWXem/iFjTn9pUpMYnfspyZTEGC9KFi4bMS7unCdFwdeEUywhU5YSIYWgDsi1VjPiP
	PmL0StD3vclZH+SC8w/vVAP31CgL4yfMrumlYiD20ygTQzJ6gpxQdYZMgJYAAJoW16d0780QbvQ
	hwZuENnwpZV+uPF3djlUyrfD1zt4/RwUJM/Kw00Yqo7n7F2DXr4RBfG3ZYt+f5iVuV1oBKxPmyc
	Wl9qJFSysI33/wKmktNFsSenyVAsIOytE1eqCPYME9ycqGuRChZs6ZZyBAZH4S2dsvP8mA86c4j
	Y81rpbJj94q1O0UFJLTrvFrxLEP0Ay6UuNkL0r61vKsrsHIB+r9CKZPc0WI82oWnK1H745F73do
	NNGOoGEova1eMbccW0VAXX+iuWge2Q
X-Received: by 2002:a5d:4c42:0:b0:436:8f7e:a479 with SMTP id ffacd0b85a97d-4396f15b32cmr5252841f8f.17.1771711776811;
        Sat, 21 Feb 2026 14:09:36 -0800 (PST)
Received: from [192.168.1.8] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970c00d95sm7751741f8f.13.2026.02.21.14.09.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Feb 2026 14:09:36 -0800 (PST)
Message-ID: <b47a1c95-60c4-468d-9944-c59546e082bf@gmail.com>
Date: Sun, 22 Feb 2026 00:09:35 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH v3 19/21] wifi: rtl8xxxu: add hw crypto support for AP
 mode
To: Martin Kaistra <martin.kaistra@linutronix.de>,
 linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20231222101442.626837-1-martin.kaistra@linutronix.de>
 <20231222101442.626837-20-martin.kaistra@linutronix.de>
Content-Language: en-US
In-Reply-To: <20231222101442.626837-20-martin.kaistra@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32077-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,linutronix.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,realtek.com:email]
X-Rspamd-Queue-Id: 8D42016E117
X-Rspamd-Action: no action

On 22/12/2023 12:14, Martin Kaistra wrote:
> Add a custom function for allocating entries in the sec cam. This allows
> us to store multiple keys with the same keyidx.
> 
> The maximum number of sec cam entries for 8188f is 16 according to the
> vendor driver. Add the number to rtl8xxxu_fileops, so that other chips
> which might support more entries, can set a different number there.
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
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  5 ++
>  .../realtek/rtl8xxxu/rtl8xxxu_8188f.c         |  1 +
>  .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 48 +++++++++++++++----
>  3 files changed, 44 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> index c5e6d8f7d26bd..62e6318bc0924 100644
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
> @@ -1775,6 +1776,7 @@ struct rtl8xxxu_cfo_tracking {
>  #define RTL8XXXU_MAX_MAC_ID_NUM	128
>  #define RTL8XXXU_BC_MC_MACID	0
>  #define RTL8XXXU_BC_MC_MACID1	1
> +#define RTL8XXXU_MAX_SEC_CAM_NUM	64
>  
>  struct rtl8xxxu_priv {
>  	struct ieee80211_hw *hw;
> @@ -1908,6 +1910,7 @@ struct rtl8xxxu_priv {
>  	char led_name[32];
>  	struct led_classdev led_cdev;
>  	DECLARE_BITMAP(mac_id_map, RTL8XXXU_MAX_MAC_ID_NUM);
> +	DECLARE_BITMAP(cam_map, RTL8XXXU_MAX_SEC_CAM_NUM);
>  };
>  
>  struct rtl8xxxu_sta_info {
> @@ -1919,6 +1922,7 @@ struct rtl8xxxu_sta_info {
>  
>  struct rtl8xxxu_vif {
>  	int port_num;
> +	u8 hw_key_idx;
>  };
>  
>  struct rtl8xxxu_rx_urb {
> @@ -1993,6 +1997,7 @@ struct rtl8xxxu_fileops {
>  	u16 max_aggr_num;
>  	u8 supports_ap:1;
>  	u16 max_macid_num;
> +	u16 max_sec_cam_num;
>  	u32 adda_1t_init;
>  	u32 adda_1t_path_on;
>  	u32 adda_2t_path_on_a;
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
> index 1e1c8fa194cb8..574a5fe951543 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
> @@ -1751,6 +1751,7 @@ struct rtl8xxxu_fileops rtl8188fu_fops = {
>  	.max_aggr_num = 0x0c14,
>  	.supports_ap = 1,
>  	.max_macid_num = 16,
> +	.max_sec_cam_num = 16,
>  	.adda_1t_init = 0x03c00014,
>  	.adda_1t_path_on = 0x03c00014,
>  	.trxff_boundary = 0x3f7f,
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> index ecf54eb8dba61..7aafae9fe76b8 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> @@ -4559,8 +4559,10 @@ static void rtl8xxxu_cam_write(struct rtl8xxxu_priv *priv,
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
> @@ -5546,13 +5548,14 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
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
> @@ -5594,10 +5597,14 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
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
> @@ -5612,6 +5619,10 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
>  		default:
>  			break;
>  		}
> +		if (bmc && rtlvif->hw_key_idx != 0xff) {
> +			tx_desc->txdw1 |= TXDESC_EN_DESC_ID;
> +			macid = rtlvif->hw_key_idx;
> +		}
>  	}
>  
>  	/* (tx_info->flags & IEEE80211_TX_CTL_AMPDU) && */
> @@ -5655,7 +5666,6 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
>  	else
>  		rts_rate = 0;
>  
> -	macid = rtl8xxxu_get_macid(priv, sta);
>  	priv->fops->fill_txdesc(hw, hdr, tx_info, tx_desc, sgi, short_preamble,
>  				ampdu_enable, rts_rate, macid);
>  
> @@ -6667,6 +6677,7 @@ static int rtl8xxxu_add_interface(struct ieee80211_hw *hw,
>  
>  	priv->vifs[port_num] = vif;
>  	rtlvif->port_num = port_num;
> +	rtlvif->hw_key_idx = 0xff;
>  
>  	rtl8xxxu_set_linktype(priv, vif->type, port_num);
>  	ether_addr_copy(priv->mac_addr, vif->addr);
> @@ -6843,11 +6854,19 @@ static int rtl8xxxu_set_rts_threshold(struct ieee80211_hw *hw, u32 rts)
>  	return 0;
>  }
>  
> +static int rtl8xxxu_get_free_sec_cam(struct ieee80211_hw *hw)
> +{
> +	struct rtl8xxxu_priv *priv = hw->priv;
> +
> +	return find_first_zero_bit(priv->cam_map, priv->fops->max_sec_cam_num);
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
> @@ -6859,9 +6878,6 @@ static int rtl8xxxu_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
>  	dev_dbg(dev, "%s: cmd %02x, cipher %08x, index %i\n",
>  		__func__, cmd, key->cipher, key->keyidx);
>  
> -	if (vif->type != NL80211_IFTYPE_STATION)
> -		return -EOPNOTSUPP;
> -
>  	if (key->keyidx > 3)
>  		return -EOPNOTSUPP;
>  
> @@ -6885,7 +6901,7 @@ static int rtl8xxxu_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
>  		ether_addr_copy(mac_addr, sta->addr);
>  	} else {
>  		dev_dbg(dev, "%s: group key\n", __func__);
> -		eth_broadcast_addr(mac_addr);
> +		ether_addr_copy(mac_addr, vif->bss_conf.bssid);
>  	}
>  
>  	val16 = rtl8xxxu_read16(priv, REG_CR);
> @@ -6899,16 +6915,28 @@ static int rtl8xxxu_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
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

Hi Martin,

It turns out RTL8188CUS and RTL8192CU don't like this patch, specifically
when we use iwd. After the WPA2 handshake no more data is transmitted.

Before this patch, key->hw_key_idx was the same as key->keyidx. After
this patch, when we use iwd, the group key is installed first. It has
key->keyidx = 1, but it gets key->hw_key_idx = 0. The pairwise key is
installed second. It has key->keyidx = 0, but it gets key->hw_key_idx = 1.
Both keyidx and hw_key_idx are passed to the chip in rtl8xxxu_cam_write().

It's fine with wpa_supplicant. wpa_supplicant installs the pairwise key
first, with key->keyidx = 0, then the group key, with key->keyidx = 1.

This patch imitating rtw88 makes the old chips work again with iwd.
What do you think?

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index ee278f0548e4..f7b35655bec5 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -6942,7 +6942,8 @@ static int rtl8xxxu_get_free_sec_cam(struct ieee80211_hw *hw)
 {
 	struct rtl8xxxu_priv *priv = hw->priv;
 
-	return find_first_zero_bit(priv->cam_map, priv->fops->max_sec_cam_num);
+	return find_next_zero_bit(priv->cam_map, priv->fops->max_sec_cam_num,
+				  RTL8XXXU_SEC_DEFAULT_KEY_NUM);
 }
 
 static int rtl8xxxu_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
@@ -6999,12 +7000,15 @@ static int rtl8xxxu_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 
 	switch (cmd) {
 	case SET_KEY:
+		if (key->flags & IEEE80211_KEY_FLAG_PAIRWISE) {
+			retval = rtl8xxxu_get_free_sec_cam(hw);
+			if (retval < 0)
+				return -EOPNOTSUPP;
 
-		retval = rtl8xxxu_get_free_sec_cam(hw);
-		if (retval < 0)
-			return -EOPNOTSUPP;
-
-		key->hw_key_idx = retval;
+			key->hw_key_idx = retval;
+		} else {
+			key->hw_key_idx = key->keyidx;
+		}
 
 		if (vif->type == NL80211_IFTYPE_AP && !(key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
 			rtlvif->hw_key_idx = key->hw_key_idx;
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index 4b05dba22e67..188f4bbe99cd 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1788,6 +1788,7 @@ struct rtl8xxxu_cfo_tracking {
 #define RTL8XXXU_BC_MC_MACID	0
 #define RTL8XXXU_BC_MC_MACID1	1
 #define RTL8XXXU_MAX_SEC_CAM_NUM	64
+#define RTL8XXXU_SEC_DEFAULT_KEY_NUM	4
 
 struct rtl8xxxu_priv {
 	struct ieee80211_hw *hw;

