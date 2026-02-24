Return-Path: <linux-wireless+bounces-32142-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MSvDczInWk8SAQAu9opvQ
	(envelope-from <linux-wireless+bounces-32142-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 16:50:36 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5E418954C
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 16:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E40793177D57
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 15:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557013803D1;
	Tue, 24 Feb 2026 15:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zvLwvwRW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8XyzTaii"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB1F3A63F0
	for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 15:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771947808; cv=none; b=BmtU+2nymEVlHK3NsCJ5rDRC/pTpl7Z2Kf38D621NEShcTrslojBNscLfif1pZWTHWTqSbtgFxOFKZ3csMvyONqcDJqUJCFZD0HPqnq2MkajGkQtyIZtdMFBROofhXgu8/xjlt65jT59uzhlLrRGfgGuzjmm+JR4482VlAx23Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771947808; c=relaxed/simple;
	bh=+BVKVpjVkgHtT44KaiuXLXIqT/5lTdmC+FZB7OP1ddg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wc+YUBapdzKqEizu1hz1Lt3QkzDwoOeq+VFlUM1Bk75RF2EU+hGPtm59BtU/vpNydeyqKs3UuRGqTaMqCrVBt4mhUWRkvmmSHMYIP1QmCPtEWA8+W+3uYprYVs0joGJ9mGpW0xToN5tBsBUawJ5/VTMXWjLBBrlfkvYUNdbf2VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zvLwvwRW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8XyzTaii; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <b8e9ad0c-c148-40a2-b114-5558e74942b0@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771947804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UeKh23siBL9NYqcToSZnDSqGzk1QyS7fJxALNXyBy3U=;
	b=zvLwvwRWPyyJoABD49d/WsF/Bcgy28NExR6tlRM2VObN+KclVpfXoyCkU9deV+X6eeloDq
	Q2TTbjIjqNZ41haT82jJHea6WVu3nJum42GvTkfb7fa10EeyZQ965fXEqxfL7/2CdcaSuX
	1rh7cXa5WE9LSwr+ZJ5suZtMd6dFS3mkeY1T4w/7hYJE8/zVNsk2OexXn29mN3u8UjWB8W
	9NzMb+RZ9OEyIZ+yRDPI/iQgF+MN0h36VgM1BHrWEolVAsRGaV2Ej9piRZZ3qhlVgSgkoe
	NKssqeaDovmXmDSohW70Sxg94SGsBIoFmOJklWQiClyssQvgWjmspixRB2B2Yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771947804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UeKh23siBL9NYqcToSZnDSqGzk1QyS7fJxALNXyBy3U=;
	b=8XyzTaii0H861BwWqbAQVcR0LuV2o+Kpq/QaCMBOFnJyrIA1ymyeCRIftXe9RGSrllte7h
	NRdLE1dqgLTrKCCA==
Date: Tue, 24 Feb 2026 16:43:24 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 19/21] wifi: rtl8xxxu: add hw crypto support for AP
 mode
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>, linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20231222101442.626837-1-martin.kaistra@linutronix.de>
 <20231222101442.626837-20-martin.kaistra@linutronix.de>
 <b47a1c95-60c4-468d-9944-c59546e082bf@gmail.com>
Content-Language: de-DE
From: Martin Kaistra <martin.kaistra@linutronix.de>
Autocrypt: addr=martin.kaistra@linutronix.de; keydata=
 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
 fORkcG4WdcVdaVwN
In-Reply-To: <b47a1c95-60c4-468d-9944-c59546e082bf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32142-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,linutronix.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.kaistra@linutronix.de,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:mid,linutronix.de:dkim,linutronix.de:email]
X-Rspamd-Queue-Id: 8C5E418954C
X-Rspamd-Action: no action

Am 21.02.26 um 23:09 schrieb Bitterblue Smith:
> On 22/12/2023 12:14, Martin Kaistra wrote:
>> Add a custom function for allocating entries in the sec cam. This allows
>> us to store multiple keys with the same keyidx.
>>
>> The maximum number of sec cam entries for 8188f is 16 according to the
>> vendor driver. Add the number to rtl8xxxu_fileops, so that other chips
>> which might support more entries, can set a different number there.
>>
>> Set the bssid as mac address for group keys instead of just using the
>> ethernet broadcast address and use BIT(6) in the sec cam ctrl entry
>> for differentiating them from pairwise keys like in the vendor driver.
>>
>> Add the TXDESC_EN_DESC_ID bit and the hw_key_idx to tx
>> broadcast/multicast packets in AP mode.
>>
>> Finally, allow the usage of rtl8xxxu_set_key() for AP mode.
>>
>> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
>> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
>> ---
>>   .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  5 ++
>>   .../realtek/rtl8xxxu/rtl8xxxu_8188f.c         |  1 +
>>   .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 48 +++++++++++++++----
>>   3 files changed, 44 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
>> index c5e6d8f7d26bd..62e6318bc0924 100644
>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
>> @@ -498,6 +498,7 @@ struct rtl8xxxu_txdesc40 {
>>   #define DESC_RATE_ID_SHIFT		16
>>   #define DESC_RATE_ID_MASK		0xf
>>   #define TXDESC_NAVUSEHDR		BIT(20)
>> +#define TXDESC_EN_DESC_ID		BIT(21)
>>   #define TXDESC_SEC_RC4			0x00400000
>>   #define TXDESC_SEC_AES			0x00c00000
>>   #define TXDESC_PKT_OFFSET_SHIFT		26
>> @@ -1775,6 +1776,7 @@ struct rtl8xxxu_cfo_tracking {
>>   #define RTL8XXXU_MAX_MAC_ID_NUM	128
>>   #define RTL8XXXU_BC_MC_MACID	0
>>   #define RTL8XXXU_BC_MC_MACID1	1
>> +#define RTL8XXXU_MAX_SEC_CAM_NUM	64
>>   
>>   struct rtl8xxxu_priv {
>>   	struct ieee80211_hw *hw;
>> @@ -1908,6 +1910,7 @@ struct rtl8xxxu_priv {
>>   	char led_name[32];
>>   	struct led_classdev led_cdev;
>>   	DECLARE_BITMAP(mac_id_map, RTL8XXXU_MAX_MAC_ID_NUM);
>> +	DECLARE_BITMAP(cam_map, RTL8XXXU_MAX_SEC_CAM_NUM);
>>   };
>>   
>>   struct rtl8xxxu_sta_info {
>> @@ -1919,6 +1922,7 @@ struct rtl8xxxu_sta_info {
>>   
>>   struct rtl8xxxu_vif {
>>   	int port_num;
>> +	u8 hw_key_idx;
>>   };
>>   
>>   struct rtl8xxxu_rx_urb {
>> @@ -1993,6 +1997,7 @@ struct rtl8xxxu_fileops {
>>   	u16 max_aggr_num;
>>   	u8 supports_ap:1;
>>   	u16 max_macid_num;
>> +	u16 max_sec_cam_num;
>>   	u32 adda_1t_init;
>>   	u32 adda_1t_path_on;
>>   	u32 adda_2t_path_on_a;
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
>> index 1e1c8fa194cb8..574a5fe951543 100644
>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
>> @@ -1751,6 +1751,7 @@ struct rtl8xxxu_fileops rtl8188fu_fops = {
>>   	.max_aggr_num = 0x0c14,
>>   	.supports_ap = 1,
>>   	.max_macid_num = 16,
>> +	.max_sec_cam_num = 16,
>>   	.adda_1t_init = 0x03c00014,
>>   	.adda_1t_path_on = 0x03c00014,
>>   	.trxff_boundary = 0x3f7f,
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> index ecf54eb8dba61..7aafae9fe76b8 100644
>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> @@ -4559,8 +4559,10 @@ static void rtl8xxxu_cam_write(struct rtl8xxxu_priv *priv,
>>   	 * This is a bit of a hack - the lower bits of the cipher
>>   	 * suite selector happens to match the cipher index in the CAM
>>   	 */
>> -	addr = key->keyidx << CAM_CMD_KEY_SHIFT;
>> +	addr = key->hw_key_idx << CAM_CMD_KEY_SHIFT;
>>   	ctrl = (key->cipher & 0x0f) << 2 | key->keyidx | CAM_WRITE_VALID;
>> +	if (!(key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
>> +		ctrl |= BIT(6);
>>   
>>   	for (j = 5; j >= 0; j--) {
>>   		switch (j) {
>> @@ -5546,13 +5548,14 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
>>   	struct rtl8xxxu_tx_urb *tx_urb;
>>   	struct ieee80211_sta *sta = NULL;
>>   	struct ieee80211_vif *vif = tx_info->control.vif;
>> +	struct rtl8xxxu_vif *rtlvif = (struct rtl8xxxu_vif *)vif->drv_priv;
>>   	struct device *dev = &priv->udev->dev;
>>   	u32 queue, rts_rate;
>>   	u16 pktlen = skb->len;
>>   	int tx_desc_size = priv->fops->tx_desc_size;
>>   	u8 macid;
>>   	int ret;
>> -	bool ampdu_enable, sgi = false, short_preamble = false;
>> +	bool ampdu_enable, sgi = false, short_preamble = false, bmc = false;
>>   
>>   	if (skb_headroom(skb) < tx_desc_size) {
>>   		dev_warn(dev,
>> @@ -5594,10 +5597,14 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
>>   		tx_desc->txdw0 =
>>   			TXDESC_OWN | TXDESC_FIRST_SEGMENT | TXDESC_LAST_SEGMENT;
>>   	if (is_multicast_ether_addr(ieee80211_get_DA(hdr)) ||
>> -	    is_broadcast_ether_addr(ieee80211_get_DA(hdr)))
>> +	    is_broadcast_ether_addr(ieee80211_get_DA(hdr))) {
>>   		tx_desc->txdw0 |= TXDESC_BROADMULTICAST;
>> +		bmc = true;
>> +	}
>> +
>>   
>>   	tx_desc->txdw1 = cpu_to_le32(queue << TXDESC_QUEUE_SHIFT);
>> +	macid = rtl8xxxu_get_macid(priv, sta);
>>   
>>   	if (tx_info->control.hw_key) {
>>   		switch (tx_info->control.hw_key->cipher) {
>> @@ -5612,6 +5619,10 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
>>   		default:
>>   			break;
>>   		}
>> +		if (bmc && rtlvif->hw_key_idx != 0xff) {
>> +			tx_desc->txdw1 |= TXDESC_EN_DESC_ID;
>> +			macid = rtlvif->hw_key_idx;
>> +		}
>>   	}
>>   
>>   	/* (tx_info->flags & IEEE80211_TX_CTL_AMPDU) && */
>> @@ -5655,7 +5666,6 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
>>   	else
>>   		rts_rate = 0;
>>   
>> -	macid = rtl8xxxu_get_macid(priv, sta);
>>   	priv->fops->fill_txdesc(hw, hdr, tx_info, tx_desc, sgi, short_preamble,
>>   				ampdu_enable, rts_rate, macid);
>>   
>> @@ -6667,6 +6677,7 @@ static int rtl8xxxu_add_interface(struct ieee80211_hw *hw,
>>   
>>   	priv->vifs[port_num] = vif;
>>   	rtlvif->port_num = port_num;
>> +	rtlvif->hw_key_idx = 0xff;
>>   
>>   	rtl8xxxu_set_linktype(priv, vif->type, port_num);
>>   	ether_addr_copy(priv->mac_addr, vif->addr);
>> @@ -6843,11 +6854,19 @@ static int rtl8xxxu_set_rts_threshold(struct ieee80211_hw *hw, u32 rts)
>>   	return 0;
>>   }
>>   
>> +static int rtl8xxxu_get_free_sec_cam(struct ieee80211_hw *hw)
>> +{
>> +	struct rtl8xxxu_priv *priv = hw->priv;
>> +
>> +	return find_first_zero_bit(priv->cam_map, priv->fops->max_sec_cam_num);
>> +}
>> +
>>   static int rtl8xxxu_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
>>   			    struct ieee80211_vif *vif,
>>   			    struct ieee80211_sta *sta,
>>   			    struct ieee80211_key_conf *key)
>>   {
>> +	struct rtl8xxxu_vif *rtlvif = (struct rtl8xxxu_vif *)vif->drv_priv;
>>   	struct rtl8xxxu_priv *priv = hw->priv;
>>   	struct device *dev = &priv->udev->dev;
>>   	u8 mac_addr[ETH_ALEN];
>> @@ -6859,9 +6878,6 @@ static int rtl8xxxu_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
>>   	dev_dbg(dev, "%s: cmd %02x, cipher %08x, index %i\n",
>>   		__func__, cmd, key->cipher, key->keyidx);
>>   
>> -	if (vif->type != NL80211_IFTYPE_STATION)
>> -		return -EOPNOTSUPP;
>> -
>>   	if (key->keyidx > 3)
>>   		return -EOPNOTSUPP;
>>   
>> @@ -6885,7 +6901,7 @@ static int rtl8xxxu_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
>>   		ether_addr_copy(mac_addr, sta->addr);
>>   	} else {
>>   		dev_dbg(dev, "%s: group key\n", __func__);
>> -		eth_broadcast_addr(mac_addr);
>> +		ether_addr_copy(mac_addr, vif->bss_conf.bssid);
>>   	}
>>   
>>   	val16 = rtl8xxxu_read16(priv, REG_CR);
>> @@ -6899,16 +6915,28 @@ static int rtl8xxxu_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
>>   
>>   	switch (cmd) {
>>   	case SET_KEY:
>> -		key->hw_key_idx = key->keyidx;
>> +
>> +		retval = rtl8xxxu_get_free_sec_cam(hw);
>> +		if (retval < 0)
>> +			return -EOPNOTSUPP;
>> +
>> +		key->hw_key_idx = retval;
>> +
>> +		if (vif->type == NL80211_IFTYPE_AP && !(key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
>> +			rtlvif->hw_key_idx = key->hw_key_idx;
>> +
>>   		key->flags |= IEEE80211_KEY_FLAG_GENERATE_IV;
>>   		rtl8xxxu_cam_write(priv, key, mac_addr);
>> +		set_bit(key->hw_key_idx, priv->cam_map);
> 
> Hi Martin,

Hi Bitterblue,

> 
> It turns out RTL8188CUS and RTL8192CU don't like this patch, specifically
> when we use iwd. After the WPA2 handshake no more data is transmitted.
> 
> Before this patch, key->hw_key_idx was the same as key->keyidx. After
> this patch, when we use iwd, the group key is installed first. It has
> key->keyidx = 1, but it gets key->hw_key_idx = 0. The pairwise key is
> installed second. It has key->keyidx = 0, but it gets key->hw_key_idx = 1.
> Both keyidx and hw_key_idx are passed to the chip in rtl8xxxu_cam_write().
> 
> It's fine with wpa_supplicant. wpa_supplicant installs the pairwise key
> first, with key->keyidx = 0, then the group key, with key->keyidx = 1.
> 
> This patch imitating rtw88 makes the old chips work again with iwd.
> What do you think?

So you reserve the first 4 entries for group keys and use key->keyidx as 
key->hw_key_idx directly for those, right? Does that work if 2 virtual 
interfaces are used at the same time?
I will do some tests in the next days, but I suspect this be an issue.

> 
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
> index ee278f0548e4..f7b35655bec5 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
> @@ -6942,7 +6942,8 @@ static int rtl8xxxu_get_free_sec_cam(struct ieee80211_hw *hw)
>   {
>   	struct rtl8xxxu_priv *priv = hw->priv;
>   
> -	return find_first_zero_bit(priv->cam_map, priv->fops->max_sec_cam_num);
> +	return find_next_zero_bit(priv->cam_map, priv->fops->max_sec_cam_num,
> +				  RTL8XXXU_SEC_DEFAULT_KEY_NUM);
>   }
>   
>   static int rtl8xxxu_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
> @@ -6999,12 +7000,15 @@ static int rtl8xxxu_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
>   
>   	switch (cmd) {
>   	case SET_KEY:
> +		if (key->flags & IEEE80211_KEY_FLAG_PAIRWISE) {
> +			retval = rtl8xxxu_get_free_sec_cam(hw);
> +			if (retval < 0)
> +				return -EOPNOTSUPP;
>   
> -		retval = rtl8xxxu_get_free_sec_cam(hw);
> -		if (retval < 0)
> -			return -EOPNOTSUPP;
> -
> -		key->hw_key_idx = retval;
> +			key->hw_key_idx = retval;
> +		} else {
> +			key->hw_key_idx = key->keyidx;
> +		}
>   
>   		if (vif->type == NL80211_IFTYPE_AP && !(key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
>   			rtlvif->hw_key_idx = key->hw_key_idx;
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> index 4b05dba22e67..188f4bbe99cd 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> @@ -1788,6 +1788,7 @@ struct rtl8xxxu_cfo_tracking {
>   #define RTL8XXXU_BC_MC_MACID	0
>   #define RTL8XXXU_BC_MC_MACID1	1
>   #define RTL8XXXU_MAX_SEC_CAM_NUM	64
> +#define RTL8XXXU_SEC_DEFAULT_KEY_NUM	4
>   
>   struct rtl8xxxu_priv {
>   	struct ieee80211_hw *hw;


