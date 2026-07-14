Return-Path: <linux-wireless+bounces-39096-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z8S4J3B4Vmqg6QAAu9opvQ
	(envelope-from <linux-wireless+bounces-39096-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 19:57:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7DB757A82
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 19:57:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=b5KIYJ6w;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39096-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39096-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 614C9319A803
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 17:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B8A2A1B2;
	Tue, 14 Jul 2026 17:52:20 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F0030C366
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 17:52:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784051539; cv=none; b=rtTFb/JJlIHdk4G5gAkDRjePyDOnFVP/LsypY7Hea6lXyWuGhug5XMRrTIkXoZ8cQ87AbuDXDSj4Qxaia1L+KqWTAt8SGiMyLX3jbNyH7KX7SASrlVik++WhaDu9g5Aj+YGQ699Kf8W6pqCiQUBmMiNsfY1yCwWeb7rWVuJezzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784051539; c=relaxed/simple;
	bh=lPHTxEtT2oe+NVhu+9CDOrZpHaALiriG59RbGozQTN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bGPG5vDzhY20fOnKMY0P4E75D/io5G4Hc3YDj7cza5EM5fijnJui8qqbrH0mwc/pB7C+Nng+t5w+P1g45yYSBPDqpbvVZODjn5sUCRpSqSlak/MeAGyQiVxCjIOZDml2NJraa82ymmFSko98wSRoBjf2sGAz1WQoAS+g5pePIEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b5KIYJ6w; arc=none smtp.client-ip=95.215.58.179
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784051530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B2umSC76rl84LTzUS0enU3q72aMEOT4aJyH69vr9Q54=;
	b=b5KIYJ6wimV3jbQEJ+royAu6hTx9dyv/cz78fT55EK36J+zPcXeaemkRF3ki+T1PiHDtVF
	PEYAcTwTw60tLJY6e/7S2K9NQFpeMTwrbK6VmuiO06nYDkgJ+iPo2K1jaurkxveCx7xGIc
	wez2D1drBVKSjZGad6TsEGwOd396qNM=
From: luka.gejak@linux.dev
To: linux-wireless@vger.kernel.org
Cc: pkshih@realtek.com,
	straube.linux@gmail.com,
	luka.gejak@linux.dev
Subject: [RFC PATCH v1 7/9] wifi: rtw88: 8723bs: implement the SDIO association sequence
Date: Tue, 14 Jul 2026 19:51:05 +0200
Message-ID: <2476eb115868b8adb4761a90156acd2cf5ae1f70.1784047561.git.luka.gejak@linux.dev>
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
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[luka.gejak@linux.dev,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[realtek.com,gmail.com,linux.dev];
	TAGGED_FROM(0.00)[bounces-39096-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:pkshih@realtek.com,m:straube.linux@gmail.com,m:luka.gejak@linux.dev,m:straubelinux@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,linux-wireless@vger.kernel.org]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ED7DB757A82

From: Luka Gejak <luka.gejak@linux.dev>

The vendor firmware expects the driver to drive association the way the
vendor start_clnt_join() does. Implement it in mgd_prepare_tx: program the
vendor join register state (MSR, beacon control, response SIFS, retry
limit, RX filter, security config), wait for a beacon from the target BSSID
before authenticating, send a pre-auth deauth, and replay the pre-auth coex
H2Cs. On association send MACID_CFG then the media-status report and the
channel info, matching the vendor mlmeext_joinbss flow.

Reset the pre-auth state whenever the BSSID changes, restore the no-link
opmode when it is cleared, and follow ERP preamble and slot-time changes so
response timing stays synchronized with the associated BSS.

Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
---
 drivers/net/wireless/realtek/rtw88/mac80211.c | 538 +++++++++++++++++-
 1 file changed, 535 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index b01b98d24b0a..280a5a51abc7 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -15,6 +15,459 @@
 #include "wow.h"
 #include "sar.h"
 
+/* 8723BS SDIO: record a beacon/probe-resp seen from the target BSSID during
+ * the pre-auth window so the join sequence (mgd_prepare_tx) can wait for it,
+ * mirroring the vendor start_clnt_join(). Called from the SDIO RX path.
+ */
+void rtw8723bs_auth_sync_rx(struct rtw_dev *rtwdev,
+			    const struct ieee80211_hdr *hdr, u32 len,
+			    const struct rtw_rx_pkt_stat *pkt_stat,
+			    const struct ieee80211_rx_status *rx_status)
+{
+	struct rtw_auth_sync *sync = &rtwdev->auth_sync;
+	unsigned long flags;
+	__le16 fc = hdr->frame_control;
+
+	if (!rtw_is_8723bs_sdio(rtwdev) ||
+	    test_bit(RTW_FLAG_SCANNING, rtwdev->flags) ||
+	    pkt_stat->crc_err || pkt_stat->icv_err)
+		return;
+
+	if (!ieee80211_is_beacon(fc) && !ieee80211_is_probe_resp(fc))
+		return;
+
+	spin_lock_irqsave(&sync->lock, flags);
+	if (sync->active && ether_addr_equal(hdr->addr3, sync->bssid)) {
+		sync->seen = true;
+		sync->seen_count++;
+		wake_up(&sync->wait);
+	}
+	spin_unlock_irqrestore(&sync->lock, flags);
+}
+EXPORT_SYMBOL(rtw8723bs_auth_sync_rx);
+
+/* ---- 8723BS SDIO association sequence (vendor start_clnt_join) ---- */
+
+#define RTW8723BS_JOIN_RETRY_LIMIT		0x30
+#define RTW8723BS_AUTH_SYNC_WAIT_FALLBACK_MS	120
+#define RTW8723BS_AUTH_SYNC_WAIT_MIN_MS		80
+#define RTW8723BS_AUTH_SYNC_WAIT_MAX_MS		160
+#define RTW8723BS_ACK_PREAMBLE_SHORT		BIT(7)
+#define RTW8723BS_SHORT_SLOT_TIME		9
+#define RTW8723BS_LONG_SLOT_TIME		20
+#define RTW8723BS_RRSR_1M			BIT(0)
+#define RTW8723BS_RRSR_2M			BIT(1)
+#define RTW8723BS_RRSR_5_5M			BIT(2)
+#define RTW8723BS_RRSR_11M			BIT(3)
+#define RTW8723BS_RRSR_6M			BIT(4)
+#define RTW8723BS_RRSR_9M			BIT(5)
+#define RTW8723BS_RRSR_12M			BIT(6)
+#define RTW8723BS_RRSR_18M			BIT(7)
+#define RTW8723BS_RRSR_24M			BIT(8)
+#define RTW8723BS_RRSR_36M			BIT(9)
+#define RTW8723BS_RRSR_48M			BIT(10)
+#define RTW8723BS_RRSR_54M			BIT(11)
+#define RTW8723BS_RRSR_CCK_RATES \
+	(RTW8723BS_RRSR_1M | RTW8723BS_RRSR_2M | \
+	 RTW8723BS_RRSR_5_5M | RTW8723BS_RRSR_11M)
+#define RTW8723BS_RRSR_2G_FORCE			RTW8723BS_RRSR_CCK_RATES
+#define RTW8723BS_RRSR_2G_ALLOW \
+	(RTW8723BS_RRSR_CCK_RATES | RTW8723BS_RRSR_6M | \
+	 RTW8723BS_RRSR_12M | RTW8723BS_RRSR_24M)
+
+/* Keep the RCR at the vendor target-only state (AMF + CBSSID) across the whole
+ * connect window, matching the vendor STA path. accept_all is kept only for the
+ * caller's intent; both paths converge the filter to target-only.
+ */
+static void rtw8723bs_auth_rx_filter(struct rtw_dev *rtwdev, bool accept_all)
+{
+	rtwdev->hal.rcr |= BIT_AMF | BIT_CBSSID_DATA | BIT_CBSSID_BCN;
+	rtwdev->hal.rcr &= ~BIT_AAP;
+	rtw_write32(rtwdev, REG_RCR, rtwdev->hal.rcr);
+}
+
+static void rtw8723bs_config_sec_cfg(struct rtw_dev *rtwdev)
+{
+	u16 sec = rtw_read16(rtwdev, RTW_SEC_CONFIG);
+
+	sec |= RTW_SEC_CHK_KEYID | RTW_SEC_TX_DEC_EN | RTW_SEC_RX_DEC_EN;
+	rtw_write16(rtwdev, RTW_SEC_CONFIG, sec);
+}
+
+static void rtw8723bs_config_default_key_search(struct rtw_dev *rtwdev,
+						bool enable)
+{
+	u16 sec = rtw_read16(rtwdev, RTW_SEC_CONFIG);
+
+	if (enable)
+		sec |= RTW_SEC_TX_BC_USE_DK | RTW_SEC_TX_UNI_USE_DK |
+		       RTW_SEC_RX_UNI_USE_DK;
+	else
+		sec &= ~(RTW_SEC_TX_UNI_USE_DK | RTW_SEC_RX_UNI_USE_DK |
+			 RTW_SEC_TX_BC_USE_DK | RTW_SEC_RX_BC_USE_DK);
+	rtw_write16(rtwdev, RTW_SEC_CONFIG, sec);
+}
+
+static void rtw8723bs_enable_tsf_update(struct rtw_dev *rtwdev)
+{
+	rtw_write8_clr(rtwdev, REG_BCN_CTRL, BIT_DIS_TSF_UDT);
+}
+
+static void rtw8723bs_set_ack_preamble(struct rtw_dev *rtwdev,
+				       bool short_preamble)
+{
+	u8 val = rtw_read8(rtwdev, REG_RRSR + 2) & ~RTW8723BS_ACK_PREAMBLE_SHORT;
+
+	if (short_preamble)
+		val |= RTW8723BS_ACK_PREAMBLE_SHORT;
+	rtw_write8(rtwdev, REG_RRSR + 2, val);
+}
+
+static void rtw8723bs_set_slot_time(struct rtw_dev *rtwdev, bool short_slot)
+{
+	rtw_write8(rtwdev, REG_SLOT,
+		   short_slot ? RTW8723BS_SHORT_SLOT_TIME :
+				RTW8723BS_LONG_SLOT_TIME);
+}
+
+static u16 rtw8723bs_rrsr_from_ie_rate(u8 rate)
+{
+	switch (rate & 0x7f) {
+	case 2:   return RTW8723BS_RRSR_1M;
+	case 4:   return RTW8723BS_RRSR_2M;
+	case 11:  return RTW8723BS_RRSR_5_5M;
+	case 22:  return RTW8723BS_RRSR_11M;
+	case 12:  return RTW8723BS_RRSR_6M;
+	case 18:  return RTW8723BS_RRSR_9M;
+	case 24:  return RTW8723BS_RRSR_12M;
+	case 36:  return RTW8723BS_RRSR_18M;
+	case 48:  return RTW8723BS_RRSR_24M;
+	case 72:  return RTW8723BS_RRSR_36M;
+	case 96:  return RTW8723BS_RRSR_48M;
+	case 108: return RTW8723BS_RRSR_54M;
+	default:  return 0;
+	}
+}
+
+static void rtw8723bs_collect_basic_rates(const u8 *ie, u16 *basic_rates,
+					  bool *valid)
+{
+	int i;
+
+	if (!ie)
+		return;
+
+	for (i = 0; i < ie[1]; i++) {
+		u16 r;
+
+		if (!(ie[i + 2] & 0x80))
+			continue;
+		r = rtw8723bs_rrsr_from_ie_rate(ie[i + 2]);
+		if (!r)
+			continue;
+		*basic_rates |= r;
+		*valid = true;
+	}
+}
+
+static void rtw8723bs_reset_response_rates(struct rtw_dev *rtwdev)
+{
+	rtw_write32(rtwdev, REG_RRSR, 0xffff1);
+	rtwdev->dm_info.rrsr_val_init = 0xffff1;
+}
+
+static void rtw8723bs_apply_basic_rates(struct rtw_dev *rtwdev,
+					struct ieee80211_vif *vif,
+					const u8 *bssid)
+{
+	struct ieee80211_bss_conf *conf = &vif->bss_conf;
+	struct cfg80211_bss *lookup_bss = NULL;
+	struct cfg80211_bss *bss = NULL;
+	bool valid = false;
+	u16 basic_rates = 0;
+
+	if (!rtw_is_8723bs_sdio(rtwdev) || vif->type != NL80211_IFTYPE_STATION)
+		return;
+
+	if (conf->bss)
+		bss = conf->bss;
+	else if (bssid && is_valid_ether_addr(bssid))
+		bss = lookup_bss = cfg80211_get_bss(rtwdev->hw->wiphy, NULL,
+						    bssid, NULL, 0,
+						    IEEE80211_BSS_TYPE_ESS,
+						    IEEE80211_PRIVACY_ANY);
+
+	if (bss) {
+		const u8 *rates, *ext;
+
+		rcu_read_lock();
+		rates = ieee80211_bss_get_ie(bss, WLAN_EID_SUPP_RATES);
+		ext = ieee80211_bss_get_ie(bss, WLAN_EID_EXT_SUPP_RATES);
+		rtw8723bs_collect_basic_rates(rates, &basic_rates, &valid);
+		rtw8723bs_collect_basic_rates(ext, &basic_rates, &valid);
+		rcu_read_unlock();
+	}
+
+	if (valid) {
+		basic_rates |= RTW8723BS_RRSR_2G_FORCE;
+		basic_rates &= RTW8723BS_RRSR_2G_ALLOW;
+		rtw_write16(rtwdev, REG_RRSR, basic_rates);
+		rtw_write8(rtwdev, REG_RRSR + 2,
+			   rtw_read8(rtwdev, REG_RRSR + 2) & 0xf0);
+		rtwdev->dm_info.rrsr_val_init = basic_rates;
+	}
+
+	if (lookup_bss)
+		cfg80211_put_bss(rtwdev->hw->wiphy, lookup_bss);
+}
+
+/* Program response slot time (and, when set_preamble, the ACK preamble) from
+ * the selected scan BSS capabilities; the AP capabilities are not yet in
+ * bss_conf at mgd_prepare_tx() time.
+ */
+static void rtw8723bs_apply_bss_cap(struct rtw_dev *rtwdev,
+				    struct ieee80211_vif *vif,
+				    const u8 *bssid, bool set_preamble)
+{
+	struct ieee80211_bss_conf *conf = &vif->bss_conf;
+	struct cfg80211_bss *lookup_bss = NULL;
+	struct cfg80211_bss *bss = NULL;
+	bool short_preamble, short_slot;
+	u16 cap = 0;
+
+	if (!rtw_is_8723bs_sdio(rtwdev) || vif->type != NL80211_IFTYPE_STATION)
+		return;
+
+	if (conf->bss)
+		bss = conf->bss;
+	else if (bssid && is_valid_ether_addr(bssid))
+		bss = lookup_bss = cfg80211_get_bss(rtwdev->hw->wiphy, NULL,
+						    bssid, NULL, 0,
+						    IEEE80211_BSS_TYPE_ESS,
+						    IEEE80211_PRIVACY_ANY);
+
+	if (bss) {
+		cap = bss->capability;
+	} else if (conf->assoc_capability) {
+		cap = conf->assoc_capability;
+	} else {
+		short_preamble = conf->use_short_preamble;
+		short_slot = conf->use_short_slot;
+		goto program;
+	}
+	short_preamble = !!(cap & WLAN_CAPABILITY_SHORT_PREAMBLE);
+	short_slot = !!(cap & WLAN_CAPABILITY_SHORT_SLOT_TIME);
+
+program:
+	if (set_preamble)
+		rtw8723bs_set_ack_preamble(rtwdev, short_preamble);
+	rtw8723bs_set_slot_time(rtwdev, short_slot);
+
+	if (lookup_bss)
+		cfg80211_put_bss(rtwdev->hw->wiphy, lookup_bss);
+}
+
+static unsigned int rtw8723bs_auth_sync_wait_ms(struct ieee80211_vif *vif)
+{
+	u16 beacon_int = vif->bss_conf.beacon_int;
+	unsigned int wait_ms;
+
+	if (!beacon_int)
+		return RTW8723BS_AUTH_SYNC_WAIT_FALLBACK_MS;
+
+	wait_ms = DIV_ROUND_UP(beacon_int * 1024, 1000) + 20;
+	return clamp_t(unsigned int, wait_ms, RTW8723BS_AUTH_SYNC_WAIT_MIN_MS,
+		       RTW8723BS_AUTH_SYNC_WAIT_MAX_MS);
+}
+
+static void rtw8723bs_auth_sync_start(struct rtw_dev *rtwdev, const u8 *bssid)
+{
+	struct rtw_auth_sync *sync = &rtwdev->auth_sync;
+	unsigned long flags;
+
+	spin_lock_irqsave(&sync->lock, flags);
+	ether_addr_copy(sync->bssid, bssid);
+	sync->seen = false;
+	sync->seen_count = 0;
+	sync->active = true;
+	spin_unlock_irqrestore(&sync->lock, flags);
+}
+
+static void rtw8723bs_auth_sync_stop(struct rtw_dev *rtwdev)
+{
+	struct rtw_auth_sync *sync = &rtwdev->auth_sync;
+	unsigned long flags;
+
+	spin_lock_irqsave(&sync->lock, flags);
+	sync->active = false;
+	spin_unlock_irqrestore(&sync->lock, flags);
+}
+
+static bool rtw8723bs_auth_sync_seen(struct rtw_dev *rtwdev)
+{
+	struct rtw_auth_sync *sync = &rtwdev->auth_sync;
+	unsigned long flags;
+	bool seen;
+
+	spin_lock_irqsave(&sync->lock, flags);
+	seen = sync->seen;
+	spin_unlock_irqrestore(&sync->lock, flags);
+
+	return seen;
+}
+
+static bool rtw8723bs_auth_sync_wait(struct rtw_dev *rtwdev,
+				     unsigned int wait_ms)
+{
+	struct rtw_auth_sync *sync = &rtwdev->auth_sync;
+
+	return wait_event_timeout(sync->wait, rtw8723bs_auth_sync_seen(rtwdev),
+				  msecs_to_jiffies(wait_ms)) > 0;
+}
+
+static bool rtw8723bs_mgd_prepare_is_auth(struct rtw_dev *rtwdev,
+					  struct ieee80211_prep_tx_info *info)
+{
+	return rtw_is_8723bs_sdio(rtwdev) && info &&
+	       info->subtype == IEEE80211_STYPE_AUTH;
+}
+
+/* Replicate the vendor start_clnt_join() register programming right before
+ * auth. Returns true for a fresh join (BSSID changed).
+ */
+static bool rtw8723bs_mgd_prepare_join(struct rtw_dev *rtwdev,
+				       struct ieee80211_vif *vif,
+				       const u8 *bssid)
+{
+	struct rtw_vif *rtwvif = (struct rtw_vif *)vif->drv_priv;
+	bool fresh_join;
+	u16 retry_limit;
+
+	if (!is_valid_ether_addr(bssid))
+		return false;
+
+	fresh_join = !ether_addr_equal(rtwvif->bssid, bssid);
+
+	ether_addr_copy(rtwvif->bssid, bssid);
+	rtwvif->aid = 0;
+	rtwvif->net_type = RTW_NET_MGD_LINKED;
+	rtw_vif_port_config(rtwdev, rtwvif,
+			    PORT_SET_BSSID | PORT_SET_AID | PORT_SET_NET_TYPE);
+
+	/* Do not narrow RRSR or switch to short-preamble responses before the
+	 * exchange: the whole auth/assoc runs on the init response set
+	 * (0xffff1, long preamble). Only slot time is programmed early.
+	 */
+	rtw8723bs_apply_bss_cap(rtwdev, vif, bssid, false);
+
+	rtw_fw_beacon_filter_config(rtwdev, false, vif);
+
+	/* Match the vendor start_clnt_join() TX state (Set_MSR directly, keep
+	 * BCN_CTRL / BCNQ_DL set, reassert TBTT/RESP_SIFS every join).
+	 */
+	rtw_write8(rtwdev, REG_BCN_CTRL,
+		   BIT_DIS_TSF_UDT | BIT_EN_BCN_FUNCTION);
+	rtw_write32_set(rtwdev, REG_FWHW_TXQ_CTRL, BIT_EN_BCNQ_DL);
+	rtw_write8(rtwdev, REG_TBTT_PROHIBIT + 1, 0x64 & 0xff);
+	rtw_write8(rtwdev, REG_TBTT_PROHIBIT + 2,
+		   (rtw_read8(rtwdev, REG_TBTT_PROHIBIT + 2) & 0xf0) | (0x64 >> 8));
+	rtw_write16(rtwdev, REG_RESP_SIFS_CCK, 0x0808);
+	rtw_write16(rtwdev, REG_RESP_SIFS_OFDM, 0x0a0a);
+
+	rtw_write16(rtwdev, REG_RXFLTMAP0, 0xffff);
+	rtw_write16(rtwdev, REG_RXFLTMAP2, 0xffff);
+	rtw8723bs_auth_rx_filter(rtwdev, true);
+
+	retry_limit = (RTW8723BS_JOIN_RETRY_LIMIT << 8) |
+		      RTW8723BS_JOIN_RETRY_LIMIT;
+	rtw_write16(rtwdev, REG_RETRY_LIMIT, retry_limit);
+
+	rtw8723bs_config_sec_cfg(rtwdev);
+
+	return fresh_join;
+}
+
+/* The vendor sends a deauth to the target before auth to clear stale AP-side
+ * state; synthesize and TX one, then let the AP settle.
+ */
+static void rtw8723bs_tx_pre_auth_deauth(struct rtw_dev *rtwdev,
+					 struct ieee80211_vif *vif,
+					 const u8 *bssid)
+{
+	struct ieee80211_tx_control control = {};
+	struct ieee80211_tx_info *info;
+	struct ieee80211_mgmt *mgmt;
+	struct sk_buff *skb;
+	unsigned int frame_len, headroom;
+
+	frame_len = sizeof(struct ieee80211_hdr_3addr) + sizeof(mgmt->u.deauth);
+	headroom = rtwdev->chip->tx_pkt_desc_sz + 8;
+
+	skb = dev_alloc_skb(headroom + frame_len);
+	if (!skb)
+		return;
+
+	skb_reserve(skb, headroom);
+	mgmt = skb_put_zero(skb, frame_len);
+	mgmt->frame_control = cpu_to_le16(IEEE80211_FTYPE_MGMT |
+					  IEEE80211_STYPE_DEAUTH);
+	memcpy(mgmt->da, bssid, ETH_ALEN);
+	memcpy(mgmt->sa, vif->addr, ETH_ALEN);
+	memcpy(mgmt->bssid, bssid, ETH_ALEN);
+	mgmt->u.deauth.reason_code = cpu_to_le16(WLAN_REASON_DEAUTH_LEAVING);
+
+	info = IEEE80211_SKB_CB(skb);
+	memset(info, 0, sizeof(*info));
+	info->control.vif = vif;
+
+	rtw_tx(rtwdev, &control, skb);
+	msleep(100);
+}
+
+/* Orchestrate the pre-auth join: program the vendor join state, send the
+ * pre-auth deauth, wait for a beacon from the target, then replay the
+ * pre-auth coex H2Cs - once per fresh BSSID.
+ */
+static void rtw8723bs_mgd_prepare_auth_join(struct rtw_dev *rtwdev,
+					    struct ieee80211_vif *vif,
+					    struct ieee80211_prep_tx_info *info)
+{
+	struct rtw_vif *rtwvif;
+	const u8 *bssid = NULL;
+	bool fresh_join;
+
+	if (!rtw8723bs_mgd_prepare_is_auth(rtwdev, info) || !vif ||
+	    test_bit(RTW_FLAG_SCANNING, rtwdev->flags))
+		return;
+
+	rtwvif = (struct rtw_vif *)vif->drv_priv;
+
+	if (!is_zero_ether_addr(vif->cfg.ap_addr))
+		bssid = vif->cfg.ap_addr;
+	else if (vif->bss_conf.bssid && !is_zero_ether_addr(vif->bss_conf.bssid))
+		bssid = vif->bss_conf.bssid;
+
+	if (!bssid)
+		return;
+
+	fresh_join = rtw8723bs_mgd_prepare_join(rtwdev, vif, bssid);
+
+	if (fresh_join || !rtwvif->pre_auth_join_done) {
+		unsigned int wait_ms = rtw8723bs_auth_sync_wait_ms(vif);
+
+		rtw8723bs_auth_sync_start(rtwdev, bssid);
+		rtw8723bs_tx_pre_auth_deauth(rtwdev, vif, bssid);
+		rtw8723bs_auth_sync_wait(rtwdev, wait_ms);
+		rtw8723bs_auth_sync_stop(rtwdev);
+		rtwvif->pre_auth_join_done = true;
+	}
+
+	if (!rtwvif->pre_auth_h2c_sent) {
+		rtw_coex_8723bs_pre_auth_h2c(rtwdev);
+		rtwvif->pre_auth_h2c_sent = true;
+	}
+}
+
 static void rtw_ops_tx(struct ieee80211_hw *hw,
 		       struct ieee80211_tx_control *control,
 		       struct sk_buff *skb)
@@ -393,6 +846,28 @@ static void rtw_ops_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_ASSOC) {
 		rtw_vif_assoc_changed(rtwvif, conf);
 		if (vif->cfg.assoc) {
+			if (rtw_is_8723bs_sdio(rtwdev) &&
+			    vif->type == NL80211_IFTYPE_STATION) {
+				rtw8723bs_auth_rx_filter(rtwdev, false);
+				rtw8723bs_apply_bss_cap(rtwdev, vif, NULL, true);
+				rtw8723bs_apply_basic_rates(rtwdev, vif, NULL);
+				rtw8723bs_enable_tsf_update(rtwdev);
+				/* Vendor mlmeext_joinbss sends MACID_CFG before
+				 * MEDIA_STATUS_RPT, then WL_CH_INFO.
+				 */
+				rtw_fw_macid_cfg(rtwdev, rtwvif->mac_id,
+						 1, 0, 1, 0x0ff015);
+				if (!rtwvif->fw_media_connected) {
+					rtw_fw_media_status_report(rtwdev,
+								   rtwvif->mac_id,
+								   true);
+					rtwvif->fw_media_connected = true;
+				}
+				rtw_fw_send_wl_ch_info(rtwdev,
+						rtwdev->hal.current_channel,
+						rtwdev->hal.current_band_width);
+			}
+
 			rtw_coex_connect_notify(rtwdev, COEX_ASSOCIATE_FINISH);
 
 			rtw_fw_download_rsvd_page(rtwdev);
@@ -414,6 +889,13 @@ static void rtw_ops_bss_info_changed(struct ieee80211_hw *hw,
 			if (test_bit(RTW_FLAG_SCANNING, rtwdev->flags))
 				rtw_hw_scan_abort(rtwdev);
 
+			if (rtw_is_8723bs_sdio(rtwdev) &&
+			    vif->type == NL80211_IFTYPE_STATION) {
+				rtw8723bs_auth_rx_filter(rtwdev, false);
+				rtw8723bs_reset_response_rates(rtwdev);
+				rtwvif->pre_auth_h2c_sent = false;
+				rtwvif->pre_auth_join_done = false;
+			}
 		}
 
 		config |= PORT_SET_NET_TYPE;
@@ -421,8 +903,26 @@ static void rtw_ops_bss_info_changed(struct ieee80211_hw *hw,
 	}
 
 	if (changed & BSS_CHANGED_BSSID) {
+		bool bssid_cleared = is_zero_ether_addr(conf->bssid);
+		bool bssid_changed = !ether_addr_equal(rtwvif->bssid,
+						       conf->bssid);
+
+		if (rtw_is_8723bs_sdio(rtwdev) &&
+		    vif->type == NL80211_IFTYPE_STATION && bssid_changed) {
+			rtwvif->pre_auth_h2c_sent = false;
+			rtwvif->pre_auth_join_done = false;
+		}
 		ether_addr_copy(rtwvif->bssid, conf->bssid);
 		config |= PORT_SET_BSSID;
+		if (rtw_is_8723bs_sdio(rtwdev) &&
+		    vif->type == NL80211_IFTYPE_STATION && bssid_cleared) {
+			rtwvif->aid = 0;
+			rtwvif->net_type = RTW_NET_NO_LINK;
+			config |= PORT_SET_NET_TYPE | PORT_SET_AID;
+			rtw_write8(rtwdev, REG_BCN_CTRL,
+				   BIT_DIS_TSF_UDT | BIT_EN_BCN_FUNCTION |
+				   BIT_DIS_ATIM);
+		}
 		if (!rtw_core_check_sta_active(rtwdev))
 			rtw_clear_op_chan(rtwdev);
 		else
@@ -454,8 +954,17 @@ static void rtw_ops_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_MU_GROUPS)
 		rtw_chip_set_gid_table(rtwdev, vif, conf);
 
-	if (changed & BSS_CHANGED_ERP_SLOT)
+	if (changed & BSS_CHANGED_ERP_PREAMBLE &&
+	    rtw_is_8723bs_sdio(rtwdev) &&
+	    vif->type == NL80211_IFTYPE_STATION)
+		rtw8723bs_set_ack_preamble(rtwdev, conf->use_short_preamble);
+
+	if (changed & BSS_CHANGED_ERP_SLOT) {
+		if (rtw_is_8723bs_sdio(rtwdev) &&
+		    vif->type == NL80211_IFTYPE_STATION)
+			rtw8723bs_set_slot_time(rtwdev, conf->use_short_slot);
 		rtw_conf_tx(rtwdev, rtwvif);
+	}
 
 	if (changed & BSS_CHANGED_PS)
 		rtw_recalc_lps(rtwdev, NULL);
@@ -615,11 +1124,19 @@ static int rtw_ops_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 		key->hw_key_idx = hw_key_idx;
 		rtw_sec_write_cam(rtwdev, sec, sta, key,
 				  hw_key_type, hw_key_idx);
+		if (rtw_is_8723bs_sdio(rtwdev) && vif &&
+		    vif->type == NL80211_IFTYPE_STATION &&
+		    !(key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
+			rtw8723bs_config_default_key_search(rtwdev, true);
 		break;
 	case DISABLE_KEY:
 		rtw_hci_flush_all_queues(rtwdev, false);
 		rtw_mac_flush_all_queues(rtwdev, false);
 		rtw_sec_clear_cam(rtwdev, sec, key->hw_key_idx);
+		if (rtw_is_8723bs_sdio(rtwdev) && vif &&
+		    vif->type == NL80211_IFTYPE_STATION &&
+		    !(key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
+			rtw8723bs_config_default_key_search(rtwdev, false);
 		break;
 	}
 
@@ -709,8 +1226,23 @@ static void rtw_ops_mgd_prepare_tx(struct ieee80211_hw *hw,
 
 	mutex_lock(&rtwdev->mutex);
 	rtw_leave_lps_deep(rtwdev);
-	rtw_coex_connect_notify(rtwdev, COEX_ASSOCIATE_START);
-	rtw_chip_prepare_tx(rtwdev);
+
+	if (rtw_is_8723bs_sdio(rtwdev)) {
+		/* Wake from soft IPS and run the vendor join sequence. The RFK
+		 * is handled by the once-only power-on IQK plus the ps.c
+		 * post-IPS RF-bus recovery, not a fresh calibration here.
+		 */
+		if (rtw_leave_ips(rtwdev)) {
+			rtw_err(rtwdev, "failed to leave idle state for mgd tx\n");
+			goto out;
+		}
+		rtw_coex_connect_notify(rtwdev, COEX_ASSOCIATE_START);
+		rtw8723bs_mgd_prepare_auth_join(rtwdev, vif, info);
+	} else {
+		rtw_coex_connect_notify(rtwdev, COEX_ASSOCIATE_START);
+		rtw_chip_prepare_tx(rtwdev);
+	}
+out:
 	mutex_unlock(&rtwdev->mutex);
 }
 
-- 
2.55.0


