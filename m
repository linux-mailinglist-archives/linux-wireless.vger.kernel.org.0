Return-Path: <linux-wireless+bounces-32069-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id rb9LOvbGmGlgMAMAu9opvQ
	(envelope-from <linux-wireless+bounces-32069-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 21:41:26 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5903816AB3B
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 21:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 81F4E3004D05
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 20:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046542FD1DA;
	Fri, 20 Feb 2026 20:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Z3IwoiBs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail1.manjaro.org (mail1.manjaro.org [142.132.176.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE16422DFA5
	for <linux-wireless@vger.kernel.org>; Fri, 20 Feb 2026 20:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.176.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771620081; cv=none; b=Ii2mNQsFqrMLTOplxL7tSU5ym0Ruh+lzX/kZ38NXjGPJtEwdeMpnsOJ9oVepapwep7kMPlyHUmqMyROrKJBTqpkozyjKRJ0FsZnPOh66XHf9qFMdhnihP/SEfU42K9fWlvKlprpUn9e6kSVeIO/j0MrOGAJVlSKN76SiH3o7L6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771620081; c=relaxed/simple;
	bh=YjQgUwNIBiX1QJp5oC45Ni/TBzTQadK2hEIVjA6CCx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HtBlG6fJPj6kM3AMON5ElHAjty02sWUmT4Nx9TK0n3oijOCWYzeIhvNkSMhqEKgQfBpH3qziCIfTHGQAJsqKFftW3ltn3iyvMUq3iQs6oF402sIrWtdJEgKt4PaY7IKBlYppA+O8L3md/jERcaQja6AB9G+6XUou940S48vaj34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Z3IwoiBs; arc=none smtp.client-ip=142.132.176.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C5C9141F93;
	Fri, 20 Feb 2026 21:41:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
	t=1771620077; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references:
	 disposition-notification-to; bh=zJAJz4As+dY2YvWTSGNfjXWs1izAe46KTiADqUeQoFM=;
	b=Z3IwoiBssdUWyxaJ3Z+AfKVDU+C+3egfr2l/bFeyQhrMZShF6N2JNY45Apz8hI0pod+480
	zZllqWH+UBqxPtpD6J4xRdxlT5yUWunQcEOoZpvfvj1wVmidiJm4Cs8kYu/yDank+UnBdM
	i1i7EUBPJDdxXcCSOex+mN5RyrzHvasGsQGJJfkqoCAnna3a3YU/mj7X8HX7hrhD+i5rLW
	C+tLrjj7PLkfvkoIaRVVeHiCTFw6wUAgfZPR0rm0I4N/7EGNlV1C83y9We5+CgUpgDUEmq
	2VXhYLn6R2PTlM/ujdn1OcMGUPhi6mXv8fxIxvGYghryimp9+UsFAxVJ5EngZA==
Message-ID: <cab3c9a6-5563-40f5-9389-42ae3ac877ac@manjaro.org>
Date: Fri, 20 Feb 2026 21:41:13 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] wifi: mt76: connac: use is_connac2() to replace
 is_mt7921() checks
To: sean.wang@kernel.org, nbd@nbd.name, lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
 Sean Wang <sean.wang@mediatek.com>
References: <20260219004007.19733-1-sean.wang@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
Organization: Manjaro Community
Disposition-Notification-To: =?UTF-8?Q?Philip_M=C3=BCller?=
 <philm@manjaro.org>
In-Reply-To: <20260219004007.19733-1-sean.wang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	HEADER_FORGED_MDN(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[manjaro.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[manjaro.org:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32069-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[philm@manjaro.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[manjaro.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,manjaro.org:mid,manjaro.org:dkim]
X-Rspamd-Queue-Id: 5903816AB3B
X-Rspamd-Action: no action

Hi Sean,

this patch needed the following lines additionally to compile cleanly:

drivers/net/wireless/mediatek/mt76/mt792x_core.c

@@ -691,7 +691,7 @@ int mt792x_init_wiphy(struct ieee80211_h
      ieee80211_hw_set(hw, SUPPORTS_MULTI_BSSID);
      ieee80211_hw_set(hw, SUPPORTS_ONLY_HE_MULTI_BSSID);

-    if (is_mt7921(&dev->mt76)) {
+    if (is_connac2(&dev->mt76)) {
          ieee80211_hw_set(hw, CHANCTX_STA_CSA);
      }

On 2/19/26 01:39, sean.wang@kernel.org wrote:
> From: Sean Wang <sean.wang@mediatek.com>
>
> Unify all per-chip conditionals under the new is_connac2() helper. This
> avoids confusion caused by the previous is_mt7921() check, which
> implicitly covered multiple connac2 chipsets and no longer reflected its
> actual scope. This is a clean-up only change with no functional impact.
>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>   .../net/wireless/mediatek/mt76/mt76_connac.h  |  2 +-
>   .../wireless/mediatek/mt76/mt76_connac_mac.c  | 16 ++++++------
>   .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 26 +++++++++----------
>   .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  2 +-
>   .../net/wireless/mediatek/mt76/mt792x_core.c  |  2 +-
>   .../net/wireless/mediatek/mt76/mt792x_dma.c   |  2 +-
>   6 files changed, 25 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
> index 813d61bffc2c..02bea67d37c3 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
> @@ -187,7 +187,7 @@ static inline bool is_mt7922(struct mt76_dev *dev)
>   	return mt76_chip(dev) == 0x7922;
>   }
>   
> -static inline bool is_mt7921(struct mt76_dev *dev)
> +static inline bool is_connac2(struct mt76_dev *dev)
>   {
>   	return mt76_chip(dev) == 0x7961 || is_mt7922(dev) || is_mt7920(dev);
>   }
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
> index 4ef44514d48d..e76f6e28b7f0 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
> @@ -173,7 +173,7 @@ void mt76_connac_write_hw_txp(struct mt76_dev *dev,
>   
>   	txp->msdu_id[0] = cpu_to_le16(id | MT_MSDU_ID_VALID);
>   
> -	if (is_mt7663(dev) || is_mt7921(dev) || is_mt7925(dev))
> +	if (is_mt7663(dev) || is_connac2(dev) || is_mt7925(dev))
>   		last_mask = MT_TXD_LEN_LAST;
>   	else
>   		last_mask = MT_TXD_LEN_AMSDU_LAST |
> @@ -217,7 +217,7 @@ mt76_connac_txp_skb_unmap_hw(struct mt76_dev *dev,
>   	u32 last_mask;
>   	int i;
>   
> -	if (is_mt7663(dev) || is_mt7921(dev) || is_mt7925(dev))
> +	if (is_mt7663(dev) || is_connac2(dev) || is_mt7925(dev))
>   		last_mask = MT_TXD_LEN_LAST;
>   	else
>   		last_mask = MT_TXD_LEN_MSDU_LAST;
> @@ -309,7 +309,7 @@ u16 mt76_connac2_mac_tx_rate_val(struct mt76_phy *mphy,
>   	chandef = mvif->ctx ? &mvif->ctx->def : &mphy->chandef;
>   	band = chandef->chan->band;
>   
> -	if (is_mt7921(mphy->dev)) {
> +	if (is_connac2(mphy->dev)) {
>   		rateidx = ffs(conf->basic_rates) - 1;
>   		goto legacy;
>   	}
> @@ -547,7 +547,7 @@ void mt76_connac2_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
>   	val = MT_TXD1_LONG_FORMAT |
>   	      FIELD_PREP(MT_TXD1_WLAN_IDX, wcid->idx) |
>   	      FIELD_PREP(MT_TXD1_OWN_MAC, omac_idx);
> -	if (!is_mt7921(dev))
> +	if (!is_connac2(dev))
>   		val |= MT_TXD1_VTA;
>   	if (phy_idx || band_idx)
>   		val |= MT_TXD1_TGID;
> @@ -556,7 +556,7 @@ void mt76_connac2_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
>   	txwi[2] = 0;
>   
>   	val = FIELD_PREP(MT_TXD3_REM_TX_COUNT, 15);
> -	if (!is_mt7921(dev))
> +	if (!is_connac2(dev))
>   		val |= MT_TXD3_SW_POWER_MGMT;
>   	if (key)
>   		val |= MT_TXD3_PROTECT_FRAME;
> @@ -598,7 +598,7 @@ void mt76_connac2_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
>   		txwi[6] |= cpu_to_le32(val);
>   		txwi[3] |= cpu_to_le32(MT_TXD3_BA_DISABLE);
>   
> -		if (!is_mt7921(dev)) {
> +		if (!is_connac2(dev)) {
>   			u8 spe_idx = mt76_connac_spe_idx(mphy->antenna_mask);
>   
>   			if (!spe_idx)
> @@ -830,7 +830,7 @@ mt76_connac2_mac_decode_he_mu_radiotap(struct mt76_dev *dev, struct sk_buff *skb
>   	};
>   	struct ieee80211_radiotap_he_mu *he_mu;
>   
> -	if (is_mt7921(dev)) {
> +	if (is_connac2(dev)) {
>   		mu_known.flags1 |= HE_BITS(MU_FLAGS1_SIG_B_COMP_KNOWN);
>   		mu_known.flags2 |= HE_BITS(MU_FLAGS2_PUNC_FROM_SIG_A_BW_KNOWN);
>   	}
> @@ -1046,7 +1046,7 @@ int mt76_connac2_mac_fill_rx_rate(struct mt76_dev *dev,
>   		stbc = FIELD_GET(MT_PRXV_HT_STBC, v0);
>   		gi = FIELD_GET(MT_PRXV_HT_SGI, v0);
>   		*mode = FIELD_GET(MT_PRXV_TX_MODE, v0);
> -		if (is_mt7921(dev))
> +		if (is_connac2(dev))
>   			dcm = !!(idx & MT_PRXV_TX_DCM);
>   		else
>   			dcm = FIELD_GET(MT_PRXV_DCM, v0);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> index 3f583e2a1dc1..d7fbf3454bb8 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> @@ -65,7 +65,7 @@ int mt76_connac_mcu_init_download(struct mt76_dev *dev, u32 addr, u32 len,
>   	int cmd;
>   
>   	if ((!is_connac_v1(dev) && addr == MCU_PATCH_ADDRESS) ||
> -	    (is_mt7921(dev) && addr == 0x900000) ||
> +	    (is_connac2(dev) && addr == 0x900000) ||
>   	    (is_mt7925(dev) && (addr == 0x900000 || addr == 0xe0002800)) ||
>   	    (is_mt799x(dev) && addr == 0x900000))
>   		cmd = MCU_CMD(PATCH_START_REQ);
> @@ -402,7 +402,7 @@ void mt76_connac_mcu_sta_basic_tlv(struct mt76_dev *dev, struct sk_buff *skb,
>   	switch (vif->type) {
>   	case NL80211_IFTYPE_MESH_POINT:
>   	case NL80211_IFTYPE_AP:
> -		if (vif->p2p && !is_mt7921(dev))
> +		if (vif->p2p && !is_connac2(dev))
>   			conn_type = CONNECTION_P2P_GC;
>   		else
>   			conn_type = CONNECTION_INFRA_STA;
> @@ -410,7 +410,7 @@ void mt76_connac_mcu_sta_basic_tlv(struct mt76_dev *dev, struct sk_buff *skb,
>   		basic->aid = cpu_to_le16(link_sta->sta->aid);
>   		break;
>   	case NL80211_IFTYPE_STATION:
> -		if (vif->p2p && !is_mt7921(dev))
> +		if (vif->p2p && !is_connac2(dev))
>   			conn_type = CONNECTION_P2P_GO;
>   		else
>   			conn_type = CONNECTION_INFRA_AP;
> @@ -874,7 +874,7 @@ void mt76_connac_mcu_sta_tlv(struct mt76_phy *mphy, struct sk_buff *skb,
>   		struct sta_rec_vht *vht;
>   		int len;
>   
> -		len = is_mt7921(dev) ? sizeof(*vht) : sizeof(*vht) - 4;
> +		len = is_connac2(dev) ? sizeof(*vht) : sizeof(*vht) - 4;
>   		tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_VHT, len);
>   		vht = (struct sta_rec_vht *)tlv;
>   		vht->vht_cap = cpu_to_le32(sta->deflink.vht_cap.cap);
> @@ -885,7 +885,7 @@ void mt76_connac_mcu_sta_tlv(struct mt76_phy *mphy, struct sk_buff *skb,
>   	/* starec uapsd */
>   	mt76_connac_mcu_sta_uapsd(skb, vif, sta);
>   
> -	if (!is_mt7921(dev))
> +	if (!is_connac2(dev))
>   		return;
>   
>   	if (sta->deflink.ht_cap.ht_supported || sta->deflink.he_cap.has_he)
> @@ -1778,7 +1778,7 @@ int mt76_connac_mcu_hw_scan(struct mt76_phy *phy, struct ieee80211_vif *vif,
>   	req->ssid_type_ext = n_ssids ? BIT(0) : 0;
>   	req->ssids_num = n_ssids;
>   
> -	duration = is_mt7921(phy->dev) ? 0 : MT76_CONNAC_SCAN_CHANNEL_TIME;
> +	duration = is_connac2(phy->dev) ? 0 : MT76_CONNAC_SCAN_CHANNEL_TIME;
>   	/* increase channel time for passive scan */
>   	if (!sreq->n_ssids)
>   		duration *= 2;
> @@ -1821,7 +1821,7 @@ int mt76_connac_mcu_hw_scan(struct mt76_phy *phy, struct ieee80211_vif *vif,
>   		req->ies_len = cpu_to_le16(sreq->ie_len);
>   	}
>   
> -	if (is_mt7921(phy->dev))
> +	if (is_connac2(phy->dev))
>   		req->scan_func |= SCAN_FUNC_SPLIT_SCAN;
>   
>   	memcpy(req->bssid, sreq->bssid, ETH_ALEN);
> @@ -1897,7 +1897,7 @@ int mt76_connac_mcu_sched_scan_req(struct mt76_phy *phy,
>   		get_random_mask_addr(addr, sreq->mac_addr,
>   				     sreq->mac_addr_mask);
>   	}
> -	if (is_mt7921(phy->dev)) {
> +	if (is_connac2(phy->dev)) {
>   		req->mt7921.bss_idx = mvif->idx;
>   		req->mt7921.delay = cpu_to_le32(sreq->delay);
>   	}
> @@ -2037,7 +2037,7 @@ mt76_connac_mcu_build_sku(struct mt76_dev *dev, s8 *sku,
>   			  struct mt76_power_limits *limits,
>   			  enum nl80211_band band)
>   {
> -	int max_power = is_mt7921(dev) ? 127 : 63;
> +	int max_power = is_connac2(dev) ? 127 : 63;
>   	int i, offset = sizeof(limits->cck);
>   
>   	memset(sku, max_power, MT_SKU_POWER_LIMIT);
> @@ -2065,7 +2065,7 @@ mt76_connac_mcu_build_sku(struct mt76_dev *dev, s8 *sku,
>   		offset += 12;
>   	}
>   
> -	if (!is_mt7921(dev))
> +	if (!is_connac2(dev))
>   		return;
>   
>   	/* he */
> @@ -2121,7 +2121,7 @@ mt76_connac_mcu_rate_txpower_band(struct mt76_phy *phy,
>   				  enum nl80211_band band)
>   {
>   	struct mt76_dev *dev = phy->dev;
> -	int sku_len, batch_len = is_mt7921(dev) ? 8 : 16;
> +	int sku_len, batch_len = is_connac2(dev) ? 8 : 16;
>   	static const u8 chan_list_2ghz[] = {
>   		1, 2,  3,  4,  5,  6,  7,
>   		8, 9, 10, 11, 12, 13, 14
> @@ -2162,7 +2162,7 @@ mt76_connac_mcu_rate_txpower_band(struct mt76_phy *phy,
>   	if (!limits)
>   		return -ENOMEM;
>   
> -	sku_len = is_mt7921(dev) ? sizeof(sku_tlbv) : sizeof(sku_tlbv) - 92;
> +	sku_len = is_connac2(dev) ? sizeof(sku_tlbv) : sizeof(sku_tlbv) - 92;
>   	tx_power = 2 * phy->hw->conf.power_level;
>   	if (!tx_power)
>   		tx_power = 127;
> @@ -3080,7 +3080,7 @@ static u32 mt76_connac2_get_data_mode(struct mt76_dev *dev, u32 info)
>   {
>   	u32 mode = DL_MODE_NEED_RSP;
>   
> -	if ((!is_mt7921(dev) && !is_mt7925(dev)) || info == PATCH_SEC_NOT_SUPPORT)
> +	if ((!is_connac2(dev) && !is_mt7925(dev)) || info == PATCH_SEC_NOT_SUPPORT)
>   		return mode;
>   
>   	switch (FIELD_GET(PATCH_SEC_ENC_TYPE_MASK, info)) {
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> index f44977f9093d..1ef25385f3c6 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> @@ -1866,7 +1866,7 @@ mt76_connac_mcu_gen_dl_mode(struct mt76_dev *dev, u8 feature_set, bool is_wa)
>   
>   	ret |= feature_set & FW_FEATURE_SET_ENCRYPT ?
>   	       DL_MODE_ENCRYPT | DL_MODE_RESET_SEC_IV : 0;
> -	if (is_mt7921(dev) || is_mt7925(dev))
> +	if (is_connac2(dev) || is_mt7925(dev))
>   		ret |= feature_set & FW_FEATURE_ENCRY_MODE ?
>   		       DL_CONFIG_ENCRY_MODE_SEL : 0;
>   	ret |= FIELD_PREP(DL_MODE_KEY_IDX,
> diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
> index f318a53e4deb..2142fcc4ae27 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
> @@ -151,7 +151,7 @@ void mt792x_stop(struct ieee80211_hw *hw, bool suspend)
>   	cancel_work_sync(&dev->reset_work);
>   	mt76_connac_free_pending_tx_skbs(&dev->pm, NULL);
>   
> -	if (is_mt7921(&dev->mt76)) {
> +	if (is_connac2(&dev->mt76)) {
>   		mt792x_mutex_acquire(dev);
>   		mt76_connac_mcu_set_mac_enable(&dev->mt76, 0, false, false);
>   		mt792x_mutex_release(dev);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_dma.c b/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
> index 1ddec7788b66..34f07bd3097d 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
> @@ -356,7 +356,7 @@ EXPORT_SYMBOL_GPL(mt792x_poll_rx);
>   
>   int mt792x_wfsys_reset(struct mt792x_dev *dev)
>   {
> -	u32 addr = is_mt7921(&dev->mt76) ? 0x18000140 : 0x7c000140;
> +	u32 addr = is_connac2(&dev->mt76) ? 0x18000140 : 0x7c000140;
>   
>   	mt76_clear(dev, addr, WFSYS_SW_RST_B);
>   	msleep(50);


-- 
Best, Philip


