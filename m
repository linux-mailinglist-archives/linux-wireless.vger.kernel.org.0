Return-Path: <linux-wireless+bounces-39090-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xj/8OlF3Vmr66AAAu9opvQ
	(envelope-from <linux-wireless+bounces-39090-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 19:52:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 625DC7579FF
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 19:52:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=C3g4Iph2;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39090-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39090-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2F8C030054CD
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 17:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916A430E84F;
	Tue, 14 Jul 2026 17:52:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6031330D416
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 17:52:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784051534; cv=none; b=n2zURdfe4JhwJEk7x1VHN/ZIXi9iBdVPYshtRoP8g9rNcBrD9CGJ7J7XX5vt2HxUf5OjTqFjEcVxzqung7c9RADRBq6AIkDrBOTnpftbphr7WcUUUO58GPovxWjFmi+2ifHbvDzHxpxBwe0rb//Q7Pk6CuJ2UnHc3MiRJnZwZys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784051534; c=relaxed/simple;
	bh=2l6k1tDmPIeesZLJbTLgVMVyZfpGtebGZfEt02TZUdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oQPq3w61XlUjqOYFRTjUBF0yYzY04DSoLo9njA7btm+3E511Kgdw+1B4E3KXjbnWUbf5IpMVInmFj8aCDF6WUklyF+20Bf0KZ+QhBCchpFPwgRhM4lirRJQJOFWqFkXUAt5hEJK/YI1PQJUjpgq70efo7txwFGCMeHNpQ+UHDfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C3g4Iph2; arc=none smtp.client-ip=95.215.58.187
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784051527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4L5U6Yd3DyZO330yBEkA2k88mf2F5i9MLHgKwqO/084=;
	b=C3g4Iph2pTs8tA/pqTNmwWjXLrkaSGAjHhdo0gu8j2EEYNPO3Us0yWTZ7p08DA4mfI/X2f
	AWDWL3mGhAFyXb8oDh9mkgmiu8YxaKj9lDFmgRUdWnDmQoPEEDVzja/CNx/kADmfYqKpgb
	nFUC7j8UKi4PWfCy78JKG/vNL7PiEvQ=
From: luka.gejak@linux.dev
To: linux-wireless@vger.kernel.org
Cc: pkshih@realtek.com,
	straube.linux@gmail.com,
	luka.gejak@linux.dev
Subject: [RFC PATCH v1 2/9] wifi: rtw88: 8723bs: handle SDIO management and data TX
Date: Tue, 14 Jul 2026 19:51:00 +0200
Message-ID: <1ac8fad97e3fcdea41f20963f771fbf5efbe6f6a.1784047561.git.luka.gejak@linux.dev>
In-Reply-To: <cover.1784047561.git.luka.gejak@linux.dev>
References: <cover.1784047561.git.luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-39090-lists,linux-wireless=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[realtek.com,gmail.com,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[luka.gejak@linux.dev,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:pkshih@realtek.com,m:straube.linux@gmail.com,m:luka.gejak@linux.dev,m:straubelinux@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:from_mime,linux.dev:mid,linux.dev:email,linux.dev:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 625DC7579FF

From: Luka Gejak <luka.gejak@linux.dev>

The RTL8723BS SDIO firmware expects the vendor TX-descriptor contract for
management frames: SPE_RPT set so the 8051 schedules the frame on air, a
fixed data retry limit, and management frames carried on the shared BCMC
station context. Program the descriptor accordingly and select the
management rate (CCK on 2.4 GHz, following the BSS basic-rate set), and add
rtw_tx_report_handle_8723b() to consume the vendor CCX TX reports.

Mark non-management packets as complete first/last segments and transmit
EAPOL at the lowest basic rate so the four-way handshake follows the
vendor data descriptor contract.

Also apply the firmware-reported TX rate through the descriptor: on this
chip the hardware otherwise keys the CCK floor on air regardless of the
rate mask, so force the rate the firmware last reported via C2H while
leaving rate fallback enabled for recovery after a power-save wake.

Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
---
 drivers/net/wireless/realtek/rtw88/tx.c | 225 +++++++++++++++++++++++-
 drivers/net/wireless/realtek/rtw88/tx.h |   5 +
 2 files changed, 223 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
index 9d747a060b98..5b4d4713be6f 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -37,14 +37,20 @@ void rtw_tx_fill_tx_desc(struct rtw_dev *rtwdev,
 {
 	struct rtw_tx_desc *tx_desc = (struct rtw_tx_desc *)skb->data;
 	bool more_data = false;
+	bool first_seg = false;
 
 	if (pkt_info->qsel == TX_DESC_QSEL_HIGH)
 		more_data = true;
 
+	if (rtw_is_8723bs_sdio(rtwdev) &&
+	    pkt_info->qsel != TX_DESC_QSEL_MGMT)
+		first_seg = true;
+
 	tx_desc->w0 = le32_encode_bits(pkt_info->tx_pkt_size, RTW_TX_DESC_W0_TXPKTSIZE) |
 		      le32_encode_bits(pkt_info->offset, RTW_TX_DESC_W0_OFFSET) |
 		      le32_encode_bits(pkt_info->bmc, RTW_TX_DESC_W0_BMC) |
 		      le32_encode_bits(pkt_info->ls, RTW_TX_DESC_W0_LS) |
+		      le32_encode_bits(first_seg, RTW_TX_DESC_W0_FS) |
 		      le32_encode_bits(pkt_info->dis_qselseq, RTW_TX_DESC_W0_DISQSELSEQ);
 
 	tx_desc->w1 = le32_encode_bits(pkt_info->mac_id, RTW_TX_DESC_W1_MACID) |
@@ -68,9 +74,15 @@ void rtw_tx_fill_tx_desc(struct rtw_dev *rtwdev,
 
 	tx_desc->w4 = le32_encode_bits(pkt_info->rate, RTW_TX_DESC_W4_DATARATE);
 
-	if (rtwdev->chip->old_datarate_fb_limit)
+	if (rtwdev->chip->old_datarate_fb_limit &&
+	    !pkt_info->disable_data_rate_fb_limit)
 		tx_desc->w4 |= le32_encode_bits(0x1f, RTW_TX_DESC_W4_DATARATE_FB_LIMIT);
 
+	if (pkt_info->retry_limit_en)
+		tx_desc->w4 |= le32_encode_bits(true, RTW_TX_DESC_W4_RETRY_LIMIT_EN) |
+			       le32_encode_bits(pkt_info->data_retry_limit,
+						RTW_TX_DESC_W4_DATA_RETRY_LIMIT);
+
 	tx_desc->w5 = le32_encode_bits(pkt_info->short_gi, RTW_TX_DESC_W5_DATA_SHORT) |
 		      le32_encode_bits(pkt_info->bw, RTW_TX_DESC_W5_DATA_BW) |
 		      le32_encode_bits(pkt_info->ldpc, RTW_TX_DESC_W5_DATA_LDPC) |
@@ -262,6 +274,36 @@ void rtw_tx_report_handle(struct rtw_dev *rtwdev, struct sk_buff *skb, int src)
 	spin_unlock_irqrestore(&tx_report->q_lock, flags);
 }
 
+/* 8723BS SDIO v41 firmware reports management TX through the vendor CCX C2H
+ * (0x12 for auth/assoc/data, 0x32 for scan probe). Payload byte 0 is the
+ * report type/status (bit 6 lifetime-over, bit 7 retry-over); byte 6 is the
+ * W6 SW_DEFINE (sequence number) the vendor driver reads back.
+ */
+void rtw_tx_report_handle_8723b(struct rtw_dev *rtwdev, u8 report_type,
+				u8 *payload, u8 len)
+{
+	struct rtw_tx_report *tx_report = &rtwdev->tx_report;
+	struct sk_buff *cur, *tmp;
+	unsigned long flags;
+	bool failed = len > 0 && (payload[0] & (BIT(6) | BIT(7)));
+	u8 sn = len >= 7 ? payload[6] : 0xff;
+	u8 *n;
+
+	if (len < 7)
+		return;
+
+	spin_lock_irqsave(&tx_report->q_lock, flags);
+	skb_queue_walk_safe(&tx_report->queue, cur, tmp) {
+		n = (u8 *)IEEE80211_SKB_CB(cur)->status.status_driver_data;
+		if (*n == sn) {
+			__skb_unlink(cur, &tx_report->queue);
+			rtw_tx_report_tx_status(rtwdev, cur, !failed);
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&tx_report->q_lock, flags);
+}
+
 static u8 rtw_get_mgmt_rate(struct rtw_dev *rtwdev, struct sk_buff *skb,
 			    u8 lowest_rate, bool ignore_rate)
 {
@@ -275,15 +317,118 @@ static u8 rtw_get_mgmt_rate(struct rtw_dev *rtwdev, struct sk_buff *skb,
 	return __ffs(vif->bss_conf.basic_rates) + lowest_rate;
 }
 
+static bool rtw_tx_8723bs_sdio_2g(struct rtw_dev *rtwdev)
+{
+	return rtw_is_8723bs_sdio(rtwdev) &&
+	       rtwdev->hal.current_band_type == RTW_BAND_2G;
+}
+
+static bool rtw_tx_8723bs_rates_have_cck(const u8 *ie)
+{
+	int i;
+
+	if (!ie)
+		return false;
+
+	for (i = 2; i < ie[1] + 2; i++) {
+		switch (ie[i] & 0x7f) {
+		case 2:  /* 1 Mbps */
+		case 4:  /* 2 Mbps */
+		case 11: /* 5.5 Mbps */
+		case 22: /* 11 Mbps */
+			return true;
+		default:
+			break;
+		}
+	}
+
+	return false;
+}
+
+static bool rtw_tx_8723bs_bss_has_cck(struct rtw_dev *rtwdev,
+				      struct ieee80211_vif *vif,
+				      const u8 *bssid,
+				      bool *known)
+{
+	struct cfg80211_bss *bss;
+	const u8 *rates;
+	const u8 *ext_rates;
+	bool has_cck = false;
+
+	*known = false;
+
+	if (!vif || !bssid || !is_valid_ether_addr(bssid))
+		return false;
+
+	bss = cfg80211_get_bss(rtwdev->hw->wiphy, NULL, bssid, NULL, 0,
+			       IEEE80211_BSS_TYPE_ESS, IEEE80211_PRIVACY_ANY);
+	if (!bss)
+		return false;
+
+	rcu_read_lock();
+	rates = ieee80211_bss_get_ie(bss, WLAN_EID_SUPP_RATES);
+	ext_rates = ieee80211_bss_get_ie(bss, WLAN_EID_EXT_SUPP_RATES);
+	if (rates || ext_rates) {
+		*known = true;
+		has_cck = rtw_tx_8723bs_rates_have_cck(rates) ||
+			  rtw_tx_8723bs_rates_have_cck(ext_rates);
+	}
+	rcu_read_unlock();
+
+	cfg80211_put_bss(rtwdev->hw->wiphy, bss);
+
+	return has_cck;
+}
+
+/* 8723BS SDIO follows the vendor driver's tx_rate rule: the initial scan
+ * default is 1 Mbps CCK, and join-time update_wireless_mode() keeps 1 Mbps
+ * whenever the selected BSS rate set includes CCK; only pure-G BSSes use 6
+ * Mbps OFDM.
+ */
+static void rtw_tx_8723bs_sdio_rate(struct rtw_dev *rtwdev,
+				    struct rtw_tx_pkt_info *pkt_info,
+				    struct sk_buff *skb)
+{
+	struct ieee80211_tx_info *tx_info = IEEE80211_SKB_CB(skb);
+	struct ieee80211_vif *vif = tx_info->control.vif;
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	const u8 *bssid = NULL;
+	bool known = false;
+	bool has_cck = true;
+
+	if (ieee80211_is_data(hdr->frame_control) ||
+	    ieee80211_is_mgmt(hdr->frame_control))
+		bssid = hdr->addr1;
+
+	has_cck = rtw_tx_8723bs_bss_has_cck(rtwdev, vif, bssid, &known);
+	if (!known && vif && vif->bss_conf.basic_rates)
+		has_cck = vif->bss_conf.basic_rates & 0xf;
+	else if (!known)
+		has_cck = true;
+
+	if (has_cck) {
+		pkt_info->rate_id = RTW_RATEID_B_20M;
+		pkt_info->rate = DESC_RATE1M;
+	} else {
+		pkt_info->rate_id = RTW_RATEID_G;
+		pkt_info->rate = DESC_RATE6M;
+	}
+}
+
 static void rtw_tx_pkt_info_update_rate(struct rtw_dev *rtwdev,
 					struct rtw_tx_pkt_info *pkt_info,
 					struct sk_buff *skb,
 					bool ignore_rate)
 {
 	if (rtwdev->hal.current_band_type == RTW_BAND_2G) {
-		pkt_info->rate_id = RTW_RATEID_B_20M;
-		pkt_info->rate = rtw_get_mgmt_rate(rtwdev, skb, DESC_RATE1M,
-						   ignore_rate);
+		if (rtw_tx_8723bs_sdio_2g(rtwdev)) {
+			rtw_tx_8723bs_sdio_rate(rtwdev, pkt_info, skb);
+		} else {
+			pkt_info->rate_id = RTW_RATEID_B_20M;
+			pkt_info->rate = rtw_get_mgmt_rate(rtwdev, skb,
+							   DESC_RATE1M,
+							   ignore_rate);
+		}
 	} else {
 		pkt_info->rate_id = RTW_RATEID_G;
 		pkt_info->rate = rtw_get_mgmt_rate(rtwdev, skb, DESC_RATE6M,
@@ -292,6 +437,12 @@ static void rtw_tx_pkt_info_update_rate(struct rtw_dev *rtwdev,
 
 	pkt_info->use_rate = true;
 	pkt_info->dis_rate_fallback = true;
+
+	/* 8723BS SDIO 2.4 GHz: the vendor path leaves dis_rate_fallback=0 for
+	 * MGNT_FRAMETAG and EAPOL/ARP data frames.
+	 */
+	if (rtw_tx_8723bs_sdio_2g(rtwdev))
+		pkt_info->dis_rate_fallback = false;
 }
 
 static void rtw_tx_pkt_info_update_sec(struct rtw_dev *rtwdev,
@@ -326,7 +477,30 @@ static void rtw_tx_mgmt_pkt_info_update(struct rtw_dev *rtwdev,
 					struct ieee80211_sta *sta,
 					struct sk_buff *skb)
 {
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+
 	rtw_tx_pkt_info_update_rate(rtwdev, pkt_info, skb, false);
+
+	if (rtw_is_8723bs_sdio(rtwdev)) {
+		/* The vendor v41 firmware requires SPE_RPT=1 in the TX
+		 * descriptor to schedule a management frame for air
+		 * transmission (report=true), with SW_DEFINE/sn=0. Keep the
+		 * retry limit and rate-fallback control aligned with the
+		 * vendor rtl8723b_fill_default_txdesc() contract.
+		 */
+		pkt_info->seq = (le16_to_cpu(hdr->seq_ctrl) &
+				 IEEE80211_SCTL_SEQ) >> 4;
+		pkt_info->en_hwseq = true;
+		pkt_info->hw_ssn_sel = 0;
+		pkt_info->dis_rate_fallback = false;
+		pkt_info->retry_limit_en = true;
+		pkt_info->data_retry_limit = 6;
+		pkt_info->disable_data_rate_fb_limit = true;
+		pkt_info->report = true;
+		pkt_info->sn = 0;
+		return;
+	}
+
 	pkt_info->dis_qselseq = true;
 	pkt_info->en_hwseq = true;
 	pkt_info->hw_ssn_sel = 0;
@@ -396,6 +570,30 @@ static void rtw_tx_data_pkt_info_update(struct rtw_dev *rtwdev,
 	pkt_info->stbc = stbc;
 	pkt_info->ldpc = ldpc;
 
+	/* 8723BS SDIO keys the CCK floor on air regardless of the rate mask
+	 * unless the firmware-reported rate is forced through the descriptor.
+	 * Apply the rate the firmware last reported via C2H as the initial TX
+	 * rate. Leave rate fallback enabled (dis_rate_fallback stays 0): the
+	 * applied rate is only the initial one, so a transiently-stale value -
+	 * e.g. right after a power-save wake - can still step down and recover.
+	 */
+	if (sta && rtw_is_8723bs_sdio(rtwdev)) {
+		si = (struct rtw_sta_info *)sta->drv_priv;
+		if (si->ra_report.desc_rate >= DESC_RATEMCS0 &&
+		    si->ra_report.desc_rate < DESC_RATE_MAX) {
+			pkt_info->rate = si->ra_report.desc_rate;
+			pkt_info->use_rate = true;
+		}
+	}
+
+	if (skb->protocol == cpu_to_be16(ETH_P_PAE)) {
+		rtw_tx_pkt_info_update_rate(rtwdev, pkt_info, skb, true);
+
+		if (rtw_is_8723bs_sdio(rtwdev) && info->control.vif &&
+		    info->control.vif->bss_conf.use_short_preamble)
+			pkt_info->short_gi = true;
+	}
+
 	fix_rate = dm_info->fix_rate;
 	if (fix_rate < DESC_RATE_MAX) {
 		pkt_info->rate = fix_rate;
@@ -416,6 +614,7 @@ void rtw_tx_pkt_info_update(struct rtw_dev *rtwdev,
 	struct rtw_sta_info *si;
 	struct rtw_vif *rtwvif;
 	__le16 fc = hdr->frame_control;
+	bool is_mgmt = ieee80211_is_mgmt(fc);
 	bool bmc;
 
 	if (sta) {
@@ -426,7 +625,14 @@ void rtw_tx_pkt_info_update(struct rtw_dev *rtwdev,
 		pkt_info->mac_id = rtwvif->mac_id;
 	}
 
-	if (ieee80211_is_mgmt(fc) || ieee80211_is_any_nullfunc(fc))
+	/* The vendor 8723BS SDIO path sends management frames through the
+	 * shared BCMC station context (macid 1 in station mode). Data frames
+	 * keep the normal peer/vif macid.
+	 */
+	if (rtw_is_8723bs_sdio(rtwdev) && is_mgmt)
+		pkt_info->mac_id = 1;
+
+	if (is_mgmt || ieee80211_is_any_nullfunc(fc))
 		rtw_tx_mgmt_pkt_info_update(rtwdev, pkt_info, sta, skb);
 	else if (ieee80211_is_data(fc))
 		rtw_tx_data_pkt_info_update(rtwdev, pkt_info, sta, skb);
@@ -434,7 +640,12 @@ void rtw_tx_pkt_info_update(struct rtw_dev *rtwdev,
 	bmc = is_broadcast_ether_addr(hdr->addr1) ||
 	      is_multicast_ether_addr(hdr->addr1);
 
-	if (info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS)
+	/* 8723BS SDIO management frames carry the vendor SPE_RPT/sn=0 contract
+	 * set above; skip rtw_tx_report_enable() so the sn stays 0. Data
+	 * frames still use the normal CCX TX-report path.
+	 */
+	if (info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS &&
+	    !(rtw_is_8723bs_sdio(rtwdev) && is_mgmt))
 		rtw_tx_report_enable(rtwdev, pkt_info);
 
 	pkt_info->bmc = bmc;
@@ -442,7 +653,7 @@ void rtw_tx_pkt_info_update(struct rtw_dev *rtwdev,
 	pkt_info->tx_pkt_size = skb->len;
 	pkt_info->offset = chip->tx_pkt_desc_sz;
 	pkt_info->qsel = skb->priority;
-	pkt_info->ls = true;
+	pkt_info->ls = !(rtw_is_8723bs_sdio(rtwdev) && is_mgmt);
 
 	/* maybe merge with tx status ? */
 	rtw_tx_stats(rtwdev, vif, skb);
diff --git a/drivers/net/wireless/realtek/rtw88/tx.h b/drivers/net/wireless/realtek/rtw88/tx.h
index d34cdeca16f1..d7e1fa83bbae 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.h
+++ b/drivers/net/wireless/realtek/rtw88/tx.h
@@ -26,6 +26,7 @@ struct rtw_tx_desc {
 #define RTW_TX_DESC_W0_OFFSET GENMASK(23, 16)
 #define RTW_TX_DESC_W0_BMC BIT(24)
 #define RTW_TX_DESC_W0_LS BIT(26)
+#define RTW_TX_DESC_W0_FS BIT(27)
 #define RTW_TX_DESC_W0_DISQSELSEQ BIT(31)
 #define RTW_TX_DESC_W1_MACID GENMASK(7, 0)
 #define RTW_TX_DESC_W1_QSEL GENMASK(12, 8)
@@ -45,6 +46,8 @@ struct rtw_tx_desc {
 #define RTW_TX_DESC_W3_MAX_AGG_NUM GENMASK(21, 17)
 #define RTW_TX_DESC_W4_DATARATE GENMASK(6, 0)
 #define RTW_TX_DESC_W4_DATARATE_FB_LIMIT GENMASK(12, 8)
+#define RTW_TX_DESC_W4_RETRY_LIMIT_EN BIT(17)
+#define RTW_TX_DESC_W4_DATA_RETRY_LIMIT GENMASK(23, 18)
 #define RTW_TX_DESC_W4_RTSRATE GENMASK(28, 24)
 #define RTW_TX_DESC_W5_DATA_SHORT BIT(4)
 #define RTW_TX_DESC_W5_DATA_BW GENMASK(6, 5)
@@ -99,6 +102,8 @@ void rtw_tx_fill_tx_desc(struct rtw_dev *rtwdev,
 			 struct rtw_tx_pkt_info *pkt_info, struct sk_buff *skb);
 void rtw_tx_report_enqueue(struct rtw_dev *rtwdev, struct sk_buff *skb, u8 sn);
 void rtw_tx_report_handle(struct rtw_dev *rtwdev, struct sk_buff *skb, int src);
+void rtw_tx_report_handle_8723b(struct rtw_dev *rtwdev, u8 report_type,
+				u8 *payload, u8 len);
 void rtw_tx_rsvd_page_pkt_info_update(struct rtw_dev *rtwdev,
 				      struct rtw_tx_pkt_info *pkt_info,
 				      struct sk_buff *skb,
-- 
2.55.0


