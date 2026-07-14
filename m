Return-Path: <linux-wireless+bounces-39092-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LdTGOld4VmqQ6QAAu9opvQ
	(envelope-from <linux-wireless+bounces-39092-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 19:56:39 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5067F757A77
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 19:56:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=ZUcUMW5d;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39092-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39092-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1572C3152010
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 17:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE7F314B76;
	Tue, 14 Jul 2026 17:52:16 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19ABB30F938
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 17:52:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784051535; cv=none; b=jbd+57eSyDKli1t/rzZ8/VLyKKKHHmnCoOe7jzZJUImpPO6vfJEA8n2Jiafw6LN0dfsPpXusObmu3uzqVxMXk3UaCy0Sh2wMnRbnUwcmOthGpF9eqvavPTxRzm41B72io1MfbYvAwEzK+xHUaMa5eO14Emo8ku1mPRQUJT+W5EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784051535; c=relaxed/simple;
	bh=bU59Gr3cO7R6DYfqq2Y/fv4J3EuUUEEbJIp8o8iqM2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DPyTOhC1Xx0d+2ql9RrKd5akfEhqvbWNJl779LZ33wHvIJ9W5/rmXIwwQzFLkJsv5rfmkjAobzyQZ0yTbX8EZkb61hzwkZyblUVIy3dHb5tTsJfIItW55NFh2y6OWB4s8StGwFpvLpRlNI2R/l68ZBancO+ooBtbUS5SnfLBm+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZUcUMW5d; arc=none smtp.client-ip=95.215.58.182
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784051529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ZuTqnsVWFUZJIcBjOJC7F0AnByfZL4Ph4INj0vduDg=;
	b=ZUcUMW5dXTLLOs5xS1qvPXXoQfNFipArUCp0Hhb7D+QdkxAmpIhpA7av2OMh0s4tecOHh+
	/4cpkI3+9Ar9EKc4a98Z0/KOOyLdrJHfW63+yssfxCUFAic5b4MW7fEp13swJDbI9tbOJO
	jvWdfitT3HYv5RUUV3FSgOcdMpGl4lw=
From: luka.gejak@linux.dev
To: linux-wireless@vger.kernel.org
Cc: pkshih@realtek.com,
	straube.linux@gmail.com,
	luka.gejak@linux.dev
Subject: [RFC PATCH v1 6/9] wifi: rtw88: 8723bs: add scan, calibration and rate-adaptation handling
Date: Tue, 14 Jul 2026 19:51:04 +0200
Message-ID: <57a84a0d3097c02073ade627c21391e66f159025.1784047561.git.luka.gejak@linux.dev>
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
	TAGGED_FROM(0.00)[bounces-39092-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 5067F757A77

From: Luka Gejak <luka.gejak@linux.dev>

Add the RTL8723BS SDIO chip-management glue in the core: lower the scan
initial gain so the site survey hears the AP, restore the per-rate TXAGC
bytes after each channel change, run the power-on IQK once (not on every
IPS leave) and finalise coex with the vendor init H2C toggle, and defer the
connect media-status report until the station is actually associated.

The chip does not append an RX FCS, so do not advertise RX_INCLUDES_FCS;
otherwise mac80211 trims four bytes of real frame data and corrupts the
last beacon/probe-response IE. The firmware also has no hardware-feature
report, so derive the stream and antenna count from the RF-path count and
advertise at least the single-stream MCS 0-7 set. An empty MCS set makes
APs drop the station immediately after association.

Also gate low-power-save entry on sustained idle: the firmware's per-packet
wake latency out of LPS throttles bursty traffic hard, so only sleep after
the smoothed throughput has dropped rather than after a single quiet
window.

Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
---
 drivers/net/wireless/realtek/rtw88/main.c | 191 +++++++++++++++++++++-
 1 file changed, 183 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index cd9254370fcc..5cbd52146041 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -43,6 +43,108 @@ MODULE_PARM_DESC(disable_lps_deep, "Set Y to disable Deep PS");
 MODULE_PARM_DESC(support_bf, "Set Y to enable beamformee support");
 MODULE_PARM_DESC(debug_mask, "Debugging mask");
 
+#define RTW8723BS_REG_BB_SEL_BTG	0x0948
+#define RTW8723BS_SCAN_IGI		0x1e
+
+struct rtw8723bs_txagc_entry {
+	u8 rate;
+	u8 pwr_idx;
+};
+
+/* Vendor/staging per-rate TXAGC PG bytes for 8723BS 2.4 GHz. */
+static const struct rtw8723bs_txagc_entry rtw8723bs_pg_txagc[] = {
+	{ DESC_RATE1M, 0x38 }, { DESC_RATE2M, 0x36 },
+	{ DESC_RATE5_5M, 0x34 }, { DESC_RATE11M, 0x32 },
+	{ DESC_RATE6M, 0x44 }, { DESC_RATE9M, 0x44 },
+	{ DESC_RATE12M, 0x42 }, { DESC_RATE18M, 0x40 },
+	{ DESC_RATE24M, 0x38 }, { DESC_RATE36M, 0x36 },
+	{ DESC_RATE48M, 0x32 }, { DESC_RATE54M, 0x28 },
+	{ DESC_RATEMCS0, 0x44 }, { DESC_RATEMCS1, 0x42 },
+	{ DESC_RATEMCS2, 0x40 }, { DESC_RATEMCS3, 0x38 },
+	{ DESC_RATEMCS4, 0x36 }, { DESC_RATEMCS5, 0x34 },
+	{ DESC_RATEMCS6, 0x30 }, { DESC_RATEMCS7, 0x26 },
+};
+
+/* Lower the scan-time initial gain so the 8723BS SDIO site-survey hears the AP. */
+static void rtw_scan_set_8723bs_igi(struct rtw_dev *rtwdev)
+{
+	if (!rtw_is_8723bs_sdio(rtwdev))
+		return;
+
+	rtw_write32_mask(rtwdev, REG_RXIGI_A, MASKBYTE0, RTW8723BS_SCAN_IGI);
+}
+
+/* rtw_load_table() only populates the by-rate cache; restore the staging
+ * 8723BS PG bytes after the generic channel power update and push them to the
+ * chip TXAGC registers.
+ */
+static void rtw8723bs_reapply_pg_txagc(struct rtw_dev *rtwdev)
+{
+	struct rtw_hal *hal = &rtwdev->hal;
+	u8 path;
+	int i;
+
+	if (!rtw_is_8723bs_sdio(rtwdev) || hal->current_band_type != RTW_BAND_2G)
+		return;
+
+	mutex_lock(&hal->tx_power_mutex);
+	for (path = 0; path < hal->rf_path_num && path < RTW_RF_PATH_MAX; path++)
+		for (i = 0; i < ARRAY_SIZE(rtw8723bs_pg_txagc); i++)
+			hal->tx_pwr_tbl[path][rtw8723bs_pg_txagc[i].rate] =
+				rtw8723bs_pg_txagc[i].pwr_idx;
+	rtwdev->chip->ops->set_tx_power_index(rtwdev);
+	mutex_unlock(&hal->tx_power_mutex);
+}
+
+/* Staging runs PHY_IQCalibrate_8723B() only during initial hal_init, never on
+ * IPS leave. Match that: run IQK once on the first power-on, then on later
+ * (IPS-leave) power-ons just restore the PTA antenna path and reset RF_WLINT.
+ */
+static void rtw_power_on_8723bs_sdio_rfk(struct rtw_dev *rtwdev)
+{
+	const struct rtw_chip_info *chip = rtwdev->chip;
+	struct rtw_efuse *efuse = &rtwdev->efuse;
+	u32 pta_path;
+	u32 saved_path;
+
+	if (!rtw_is_8723bs_sdio(rtwdev) || !chip->ops->phy_calibration)
+		return;
+
+	pta_path = (efuse->bt_setting & BIT(6)) ? 0x80 : 0x200;
+
+	if (rtwdev->initial_rfk_done) {
+		rtw_write32(rtwdev, RTW8723BS_REG_BB_SEL_BTG, pta_path);
+		rtw_write_rf(rtwdev, RF_PATH_A, RF_WLINT, RFREG_MASK, 0x0780);
+		return;
+	}
+
+	saved_path = rtw_read32(rtwdev, RTW8723BS_REG_BB_SEL_BTG);
+	rtw_write32(rtwdev, RTW8723BS_REG_BB_SEL_BTG, pta_path);
+	chip->ops->phy_calibration(rtwdev);
+	rtwdev->need_rfk = false;
+	rtw_write32(rtwdev, RTW8723BS_REG_BB_SEL_BTG, saved_path);
+	rtwdev->initial_rfk_done = true;
+}
+
+static bool rtw8723bs_station_media_status(struct rtw_dev *rtwdev,
+					   struct ieee80211_sta *sta,
+					   struct ieee80211_vif *vif)
+{
+	return rtw_is_8723bs_sdio(rtwdev) &&
+	       vif->type == NL80211_IFTYPE_STATION && !sta->tdls;
+}
+
+/* 8723BS SDIO: defer the connect MEDIA_STATUS_RPT until the STA is actually
+ * associated (the vendor firmware sends it at assoc completion, not sta-add).
+ */
+static bool rtw8723bs_defer_sta_media_status(struct rtw_dev *rtwdev,
+					     struct ieee80211_sta *sta,
+					     struct ieee80211_vif *vif)
+{
+	return rtw8723bs_station_media_status(rtwdev, sta, vif) &&
+	       !vif->cfg.assoc;
+}
+
 static struct ieee80211_channel rtw_channeltable_2g[] = {
 	{.center_freq = 2412, .hw_value = 1,},
 	{.center_freq = 2417, .hw_value = 2,},
@@ -299,6 +401,18 @@ static void rtw_watch_dog_work(struct work_struct *work)
 	 * get that vif and check if device is having traffic more than the
 	 * threshold.
 	 */
+
+	/* On 8723BS SDIO the firmware's per-packet wake latency out of LPS
+	 * throttles bursty traffic hard. The stock check enters LPS after a
+	 * single quiet 2s window, which a normal bursty session hits
+	 * constantly. Gate LPS on the smoothed throughput instead so the chip
+	 * only sleeps after sustained idle and stays awake through an active
+	 * session. Other chips keep the normal behaviour.
+	 */
+	if (rtw_is_8723bs_sdio(rtwdev) &&
+	    (stats->tx_throughput || stats->rx_throughput))
+		ps_active = true;
+
 	if (rtwdev->ps_enabled && data.rtwvif && !ps_active &&
 	    !rtwdev->beacon_loss && !rtwdev->ap_active)
 		rtw_enter_lps(rtwdev, data.rtwvif->port);
@@ -367,7 +481,13 @@ int rtw_sta_add(struct rtw_dev *rtwdev, struct ieee80211_sta *sta,
 	INIT_WORK(&si->rc_work, rtw_sta_rc_work);
 
 	rtw_update_sta_info(rtwdev, si, true);
-	rtw_fw_media_status_report(rtwdev, si->mac_id, true);
+	if (rtw8723bs_defer_sta_media_status(rtwdev, sta, vif)) {
+		rtwvif->fw_media_connected = false;
+	} else {
+		rtw_fw_media_status_report(rtwdev, si->mac_id, true);
+		if (rtw8723bs_station_media_status(rtwdev, sta, vif))
+			rtwvif->fw_media_connected = true;
+	}
 
 	rtwdev->sta_cnt++;
 	rtwdev->beacon_loss = false;
@@ -382,14 +502,21 @@ void rtw_sta_remove(struct rtw_dev *rtwdev, struct ieee80211_sta *sta,
 {
 	struct rtw_sta_info *si = (struct rtw_sta_info *)sta->drv_priv;
 	struct ieee80211_vif *vif = si->vif;
+	struct rtw_vif *rtwvif = (struct rtw_vif *)vif->drv_priv;
 	int i;
 
 	cancel_work_sync(&si->rc_work);
 
 	if (vif->type != NL80211_IFTYPE_STATION || sta->tdls)
 		rtw_release_macid(rtwdev, si->mac_id);
-	if (fw_exist)
+	if (fw_exist && rtw8723bs_station_media_status(rtwdev, sta, vif) &&
+	    !rtwvif->fw_media_connected) {
+		/* connect status was deferred and never sent; nothing to undo */
+	} else if (fw_exist) {
 		rtw_fw_media_status_report(rtwdev, si->mac_id, false);
+		if (rtw8723bs_station_media_status(rtwdev, sta, vif))
+			rtwvif->fw_media_connected = false;
+	}
 
 	for (i = 0; i < ARRAY_SIZE(sta->txq); i++)
 		rtw_txq_cleanup(rtwdev, sta->txq[i]);
@@ -904,6 +1031,8 @@ void rtw_set_channel(struct rtw_dev *rtwdev)
 
 	rtw_phy_set_tx_power_level(rtwdev, center_chan);
 
+	rtw8723bs_reapply_pg_txagc(rtwdev);
+
 	/* if the channel isn't set for scanning, we will do RF calibration
 	 * in ieee80211_ops::mgd_prepare_tx(). Performing the calibration
 	 * during scanning on each channel takes too long.
@@ -1429,6 +1558,34 @@ int rtw_power_on(struct rtw_dev *rtwdev)
 	rtw_fw_send_phydm_info(rtwdev);
 
 	wifi_only = !rtwdev->efuse.btcoex;
+
+	/* 8723BS SDIO: on an IPS-leave power-on (IQK already done once) skip the
+	 * BT-path coex init entirely - scan_workaround re-establishes the PTA /
+	 * coex state. Run the once-only IQK via the RFK helper; on the first
+	 * power-on, finalise coex with the vendor init H2C toggle that enables
+	 * the 8051 management TX scheduler.
+	 */
+	if (rtw_is_8723bs_sdio(rtwdev)) {
+		bool ips_wake = rtwdev->initial_rfk_done;
+
+		if (!ips_wake)
+			rtw_coex_power_on_setting(rtwdev);
+
+		rtw_power_on_8723bs_sdio_rfk(rtwdev);
+
+		if (!ips_wake) {
+			rtw_coex_init_hw_config(rtwdev, wifi_only);
+			rtw_fw_coex_tdma_type(rtwdev, 0x08, 0x00, 0x00, 0x00, 0x00);
+			rtw_fw_set_gnt_bt(rtwdev, 1);
+			rtw_fw_coex_ant_sel_rsv(rtwdev, 0, 0);
+			rtw_fw_query_bt_info(rtwdev);
+			rtw_fw_coex_tdma_type(rtwdev, 0x08, 0x00, 0x00, 0x00, 0x00);
+			rtw_fw_set_gnt_bt(rtwdev, 0);
+		}
+
+		return 0;
+	}
+
 	rtw_coex_power_on_setting(rtwdev);
 	rtw_coex_init_hw_config(rtwdev, wifi_only);
 
@@ -1485,6 +1642,7 @@ void rtw_core_scan_start(struct rtw_dev *rtwdev, struct rtw_vif *rtwvif,
 	set_bit(RTW_FLAG_SCANNING, rtwdev->flags);
 
 	rtw_phy_dig_set_max_coverage(rtwdev);
+	rtw_scan_set_8723bs_igi(rtwdev);
 }
 
 void rtw_core_scan_complete(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
@@ -1575,7 +1733,7 @@ static void rtw_init_ht_cap(struct rtw_dev *rtwdev,
 {
 	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
-	int i;
+	u8 nss;
 
 	ht_cap->ht_supported = true;
 	ht_cap->cap = 0;
@@ -1596,10 +1754,12 @@ static void rtw_init_ht_cap(struct rtw_dev *rtwdev,
 	ht_cap->ampdu_density = chip->ampdu_density;
 	ht_cap->mcs.tx_params = IEEE80211_HT_MCS_TX_DEFINED;
 
-	for (i = 0; i < efuse->hw_cap.nss; i++)
-		ht_cap->mcs.rx_mask[i] = 0xFF;
+	nss = max_t(u8, efuse->hw_cap.nss, 1);
+	ht_cap->mcs.rx_mask[0] = 0xff;
+	if (nss > 1)
+		ht_cap->mcs.rx_mask[1] = 0xff;
 	ht_cap->mcs.rx_mask[4] = 0x01;
-	ht_cap->mcs.rx_highest = cpu_to_le16(150 * efuse->hw_cap.nss);
+	ht_cap->mcs.rx_highest = cpu_to_le16(150 * min_t(u8, nss, 2));
 }
 
 static void rtw_init_vht_cap(struct rtw_dev *rtwdev,
@@ -1965,8 +2125,16 @@ static int rtw_dump_hw_feature(struct rtw_dev *rtwdev)
 	u8 bw;
 	int i;
 
-	if (!rtwdev->chip->hw_feature_report)
+	if (!rtwdev->chip->hw_feature_report) {
+		/* Without a firmware feature report hw_cap is otherwise left at
+		 * zero. A zero stream count produces an HT capability with no usable
+		 * RX MCS rates, which makes APs drop the station immediately after a
+		 * successful association.
+		 */
+		efuse->hw_cap.nss = rtwdev->hal.rf_path_num ? : 1;
+		efuse->hw_cap.ant_num = rtwdev->hal.rf_path_num ? : 1;
 		return 0;
+	}
 
 	id = rtw_read8(rtwdev, REG_C2HEVT);
 	if (id != C2H_HW_FEATURE_REPORT) {
@@ -2174,11 +2342,13 @@ int rtw_core_init(struct rtw_dev *rtwdev)
 
 	spin_lock_init(&rtwdev->txq_lock);
 	spin_lock_init(&rtwdev->tx_report.q_lock);
+	spin_lock_init(&rtwdev->auth_sync.lock);
 
 	mutex_init(&rtwdev->mutex);
 	mutex_init(&rtwdev->hal.tx_power_mutex);
 
 	init_waitqueue_head(&rtwdev->coex.wait);
+	init_waitqueue_head(&rtwdev->auth_sync.wait);
 	init_completion(&rtwdev->lps_leave_check);
 	init_completion(&rtwdev->fw_scan_density);
 
@@ -2270,7 +2440,12 @@ int rtw_register_hw(struct rtw_dev *rtwdev, struct ieee80211_hw *hw)
 	hw->vif_data_size = sizeof(struct rtw_vif);
 
 	ieee80211_hw_set(hw, SIGNAL_DBM);
-	ieee80211_hw_set(hw, RX_INCLUDES_FCS);
+	/* RTL8723BS keeps BIT_APP_FCS clear, so received frames do not contain
+	 * the FCS. Advertising RX_INCLUDES_FCS would make mac80211 trim four
+	 * bytes of frame data and corrupt the tail IE in beacons/probe responses.
+	 */
+	if (!rtw_is_8723bs_sdio(rtwdev))
+		ieee80211_hw_set(hw, RX_INCLUDES_FCS);
 	ieee80211_hw_set(hw, AMPDU_AGGREGATION);
 	ieee80211_hw_set(hw, MFP_CAPABLE);
 	ieee80211_hw_set(hw, REPORTS_TX_ACK_STATUS);
-- 
2.55.0


