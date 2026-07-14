Return-Path: <linux-wireless+bounces-39093-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tl0XG1R4VmqP6QAAu9opvQ
	(envelope-from <linux-wireless+bounces-39093-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 19:56:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 031E5757A72
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 19:56:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=LHS9MitT;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39093-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39093-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A89B311CA55
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 17:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD7A3148A7;
	Tue, 14 Jul 2026 17:52:16 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608D530D3EF
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 17:52:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784051535; cv=none; b=UbK/UBm9Qab55jPIXqhDhrjxT67uvG+ZP9lqRk+H3V3lkepfFQJgcxfkjtEN4LG2j97eyTLCoxyjpplVrallN4voymQyxqQ2cbSrZ3H5fF4t2teLWMQDkqT4aJY6IztAlamsL7QqaPAVi8WqY7P0qqES5o4yzCZyRrK8g5b+Cr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784051535; c=relaxed/simple;
	bh=toQAI1zZqUDCZkS74eNF/dY7xWGT/KmpVLxJPamwP1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h4nt+vXkOEqXRGIbhu8HaiSbUYOY86L1pIEYR4j/tKZ+imyPh3fPO33V7BgnCc3tbN+OLg2wU1at8XUQsQODjazDmhvz2re0rW18hxtk0HGi3Phxr5HegseiersAu/r20sjiVjAdrl2Oy4ViLof8davlJ4K/1BCKuuIbvOQraiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LHS9MitT; arc=none smtp.client-ip=95.215.58.189
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784051528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T2C33EMb71ABqI6dO4qZVt8Apf3urMMy5BLxLiHZBOU=;
	b=LHS9MitTLpwX/B0amCE6RkQ4TB64z6pcdSJ0+hAvLPf3P+N4qe2zmMV+bG3noC59c7/6qC
	fuTu5zM919tS1o/a5dyWCkOF58XMR9VA2D7t9/HpWGFLotyPYpvcI+f4JdOemoIP8kyFjj
	Bx6ZbuNd+pS+i8yq95XzinbzCcE8spg=
From: luka.gejak@linux.dev
To: linux-wireless@vger.kernel.org
Cc: pkshih@realtek.com,
	straube.linux@gmail.com,
	luka.gejak@linux.dev
Subject: [RFC PATCH v1 4/9] wifi: rtw88: 8723bs: add WiFi/BT coexistence antenna handling
Date: Tue, 14 Jul 2026 19:51:02 +0200
Message-ID: <d55f51724af10c76d61721b4ce456780908f8bca.1784047561.git.luka.gejak@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[luka.gejak@linux.dev,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[realtek.com,gmail.com,linux.dev];
	TAGGED_FROM(0.00)[bounces-39093-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,linux-wireless@vger.kernel.org]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 031E5757A72

From: Luka Gejak <luka.gejak@linux.dev>

On RTL8723BS SDIO boards the scan and authentication windows route through
the PTA antenna mux even when BT is disabled. Add the vendor-shaped
antenna-path forcing (BB_SEL_BTG / PAD control / CCK priority / GNT_BT) and
the scan- and connect-notify handling that keeps WiFi owning the antenna
across the site survey and the pre-auth window, so directed management
frames reach the air.

Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
---
 drivers/net/wireless/realtek/rtw88/coex.c | 237 ++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/coex.h |   4 +
 2 files changed, 241 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index 37c336def419..c34c283b79b6 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -1443,6 +1443,205 @@ static void rtw_coex_set_ant_path(struct rtw_dev *rtwdev, bool force, u8 phase)
 #define case_ALGO(src) \
 	case COEX_ALGO_##src: return #src
 
+/* 8723BS SDIO WiFi/BT coexistence antenna handling. On BT-disabled boards the
+ * scan/auth window still routes through the PTA mux; these helpers force the
+ * vendor-shaped WiFi-owned antenna path so directed management TX reaches air.
+ */
+#define REG_8723BS_BT_COEX_CTRL		0x0039
+#define REG_8723BS_BB_ANT_CFG		0x0930
+#define REG_8723BS_BB_ANT_CFG1		0x0944
+#define REG_8723BS_BB_ANT_BUF		0x0974
+#define RTW8723BS_COEX_H_WLAN_ACTIVE	0x1800101b
+
+static bool rtw_coex_8723bs_ant_is_aux(struct rtw_dev *rtwdev)
+{
+	return !!(rtwdev->efuse.bt_setting & BIT(6));
+}
+
+static bool rtw_coex_8723bs_bt_disabled(struct rtw_dev *rtwdev)
+{
+	return rtw_is_8723bs_sdio(rtwdev) && rtwdev->coex.stat.bt_disabled;
+}
+
+static u32 rtw_coex_8723bs_pta_ant_path(struct rtw_dev *rtwdev)
+{
+	return rtw_coex_8723bs_ant_is_aux(rtwdev) ? 0x80 : 0x200;
+}
+
+/* Write BB_SEL_BTG (0x948), retrying once with SYS_FUNC BB reset if the first
+ * write does not stick (RF/BB clock may have been gated).
+ */
+static u32 rtw_coex_8723bs_write_bb_sel_btg(struct rtw_dev *rtwdev, u32 value)
+{
+	u8 sys_func_before;
+	u32 readback;
+
+	sys_func_before = rtw_read8(rtwdev, REG_SYS_FUNC_EN);
+	if ((sys_func_before & (BIT(0) | BIT(1))) != (BIT(0) | BIT(1))) {
+		rtw_write8_set(rtwdev, REG_SYS_FUNC_EN, BIT(0) | BIT(1));
+		usleep_range(10, 11);
+	}
+
+	rtw_write32(rtwdev, 0x948, value);
+	readback = rtw_read32(rtwdev, 0x948);
+	if (readback == value)
+		return readback;
+
+	usleep_range(10, 11);
+	rtw_write8_set(rtwdev, REG_SYS_FUNC_EN, BIT(0) | BIT(1));
+	rtw_write32(rtwdev, 0x948, value);
+
+	return rtw_read32(rtwdev, 0x948);
+}
+
+static u32 rtw_coex_8723bs_reassert_pta_ant(struct rtw_dev *rtwdev)
+{
+	return rtw_coex_8723bs_write_bb_sel_btg(rtwdev,
+					rtw_coex_8723bs_pta_ant_path(rtwdev));
+}
+
+static void rtw_coex_8723bs_set_cck_pri(struct rtw_dev *rtwdev, bool high)
+{
+	if (!rtw_coex_8723bs_bt_disabled(rtwdev))
+		return;
+
+	if (high)
+		rtw_write32(rtwdev, REG_BT_COEX_TABLE_H,
+			    RTW8723BS_COEX_H_WLAN_ACTIVE);
+	else {
+		rtw_coex_set_wl_pri_mask(rtwdev, COEX_WLPRI_TX_CCK, false);
+		rtw_coex_set_wl_pri_mask(rtwdev, COEX_WLPRI_RX_CCK, false);
+	}
+}
+
+static void rtw_coex_8723bs_restore_pad_ctrl(struct rtw_dev *rtwdev,
+					     bool keep_pta_owner)
+{
+	u32 before, after;
+
+	before = rtw_read32(rtwdev, REG_PAD_CTRL1);
+	after = before & ~(BIT_LNAON_WLBT_SEL | BIT_SW_DPDT_SEL_DATA);
+	if (keep_pta_owner)
+		after |= BIT_PAPE_WLBT_SEL;
+	else
+		after &= ~BIT_PAPE_WLBT_SEL;
+	if (after != before)
+		rtw_write32(rtwdev, REG_PAD_CTRL1, after);
+}
+
+static void rtw_coex_8723bs_fw_gnt_bt_low(struct rtw_dev *rtwdev)
+{
+	if (!rtw_coex_8723bs_bt_disabled(rtwdev))
+		return;
+
+	if (rtw_read8(rtwdev, 0x765) == 0x00 &&
+	    rtw_read8(rtwdev, 0x76e) == 0x0c)
+		return;
+
+	rtw_fw_set_gnt_bt(rtwdev, 0);
+}
+
+static void rtw_coex_8723bs_force_assoc_pta_ant(struct rtw_dev *rtwdev)
+{
+	u32 ant_target;
+
+	if (!rtw_coex_8723bs_bt_disabled(rtwdev))
+		return;
+
+	ant_target = rtw_coex_8723bs_pta_ant_path(rtwdev);
+
+	rtw_coex_8723bs_fw_gnt_bt_low(rtwdev);
+	rtw_coex_set_ant_switch(rtwdev, COEX_SWITCH_CTRL_BY_PTA,
+				COEX_SWITCH_TO_NOCARE);
+	rtw_coex_8723bs_set_cck_pri(rtwdev, true);
+	rtw_coex_8723bs_write_bb_sel_btg(rtwdev, ant_target);
+	rtw_coex_8723bs_restore_pad_ctrl(rtwdev, true);
+}
+
+static void rtw_coex_8723bs_reassert_ant_buffer(struct rtw_dev *rtwdev)
+{
+	u8 sys_func_before;
+
+	sys_func_before = rtw_read8(rtwdev, REG_SYS_FUNC_EN);
+	if ((sys_func_before & (BIT(0) | BIT(1))) != (BIT(0) | BIT(1))) {
+		rtw_write8_set(rtwdev, REG_SYS_FUNC_EN, BIT(0) | BIT(1));
+		usleep_range(10, 11);
+	}
+
+	rtw_write8_mask(rtwdev, REG_8723BS_BT_COEX_CTRL, BIT(3), 0x1);
+	rtw_write8(rtwdev, REG_8723BS_BB_ANT_BUF, 0xff);
+	rtw_write8_mask(rtwdev, REG_8723BS_BB_ANT_CFG1, 0x3, 0x3);
+	rtw_write8(rtwdev, REG_8723BS_BB_ANT_CFG, 0x77);
+}
+
+static void rtw_coex_8723bs_apply_scan_table(struct rtw_dev *rtwdev)
+{
+	rtwdev->coex.dm.cur_table = 2;
+	rtw_coex_set_table(rtwdev, true, 0x5a5a5a5a, 0x5a5a5a5a);
+}
+
+/* Non-connected scan/auth workaround: PS-TDMA type 8 off, PTA antenna path,
+ * coex table type 2 (matches the vendor non-connected arbitration).
+ */
+void rtw_coex_8723bs_scan_workaround(struct rtw_dev *rtwdev)
+{
+	struct rtw_coex_dm *coex_dm = &rtwdev->coex.dm;
+	struct rtw_coex_stat *coex_stat = &rtwdev->coex.stat;
+
+	if (!rtw_is_8723bs_sdio(rtwdev))
+		return;
+
+	coex_dm->cur_ps_tdma_on = false;
+	coex_dm->cur_ps_tdma = 8;
+	coex_dm->ps_tdma_para[0] = 0x08;
+	coex_dm->ps_tdma_para[1] = 0x00;
+	coex_dm->ps_tdma_para[2] = 0x00;
+	coex_dm->ps_tdma_para[3] = 0x00;
+	coex_dm->ps_tdma_para[4] = 0x00;
+
+	rtw_fw_coex_tdma_type(rtwdev, 0x08, 0x00, 0x00, 0x00, 0x00);
+	rtw_coex_8723bs_fw_gnt_bt_low(rtwdev);
+	rtw_coex_set_ant_path(rtwdev, true, COEX_SET_ANT_2G);
+	rtw_coex_8723bs_reassert_ant_buffer(rtwdev);
+	rtw_coex_8723bs_apply_scan_table(rtwdev);
+	if (coex_stat->bt_disabled)
+		rtw_coex_8723bs_set_cck_pri(rtwdev, true);
+	rtw_coex_8723bs_reassert_pta_ant(rtwdev);
+	rtw_coex_8723bs_restore_pad_ctrl(rtwdev, true);
+}
+
+/* Replayed immediately before start_clnt_join()/auth: BT_INFO + PS-TDMA type 8
+ * then the forced WiFi PTA antenna path, so the auth window is clean.
+ */
+void rtw_coex_8723bs_pre_auth_h2c(struct rtw_dev *rtwdev)
+{
+	lockdep_assert_held(&rtwdev->mutex);
+
+	if (!rtw_coex_8723bs_bt_disabled(rtwdev))
+		return;
+
+	rtw_fw_query_bt_info(rtwdev);
+	rtw_fw_coex_tdma_type(rtwdev, 0x08, 0x00, 0x00, 0x00, 0x00);
+	rtw_fw_coex_tdma_type(rtwdev, 0x08, 0x00, 0x00, 0x00, 0x00);
+	rtw_fw_coex_tdma_type(rtwdev, 0x08, 0x00, 0x00, 0x00, 0x00);
+	rtw_coex_8723bs_fw_gnt_bt_low(rtwdev);
+	rtw_coex_8723bs_force_assoc_pta_ant(rtwdev);
+}
+
+/* Minimal PTA antenna path so RF register writes reach the chip after IPS
+ * leave / power-on (before rtw_set_channel()).
+ */
+void rtw_coex_8723bs_ensure_pta_path(struct rtw_dev *rtwdev)
+{
+	if (!rtw_is_8723bs_sdio(rtwdev))
+		return;
+
+	rtw_coex_8723bs_reassert_ant_buffer(rtwdev);
+	rtw_coex_8723bs_write_bb_sel_btg(rtwdev,
+					 rtw_coex_8723bs_pta_ant_path(rtwdev));
+	rtw_coex_8723bs_restore_pad_ctrl(rtwdev, false);
+}
+
 static const char *rtw_coex_get_algo_string(u8 algo)
 {
 	switch (algo) {
@@ -2877,6 +3076,33 @@ void rtw_coex_scan_notify(struct rtw_dev *rtwdev, u8 type)
 	coex->freeze = false;
 	rtw_coex_write_scbd(rtwdev, COEX_SCBD_ACTIVE | COEX_SCBD_ONOFF, true);
 
+	/* 8723BS SDIO BT-disabled: keep the scan/auth PTA antenna state the
+	 * vendor uses and skip the generic coex run. At scan start (firmware
+	 * has been up long enough for stable RX DMA) replay the vendor BT_MP /
+	 * BT_INFO queries, then re-establish the scan-path PTA setup.
+	 */
+	if (rtw_coex_8723bs_bt_disabled(rtwdev)) {
+		if (type == COEX_SCAN_START_2G || type == COEX_SCAN_START) {
+			struct rtw_coex_info_req req = {};
+
+			coex_stat->cnt_wl[COEX_CNT_WL_SCANAP] = 0;
+			coex_stat->wl_hi_pri_task2 = true;
+
+			req.seq = 0x0e;
+			req.op_code = BT_MP_INFO_OP_SUPP_VER;
+			rtw_fw_query_bt_mp_info(rtwdev, &req);
+			req.seq = 0x0f;
+			req.op_code = BT_MP_INFO_OP_PATCH_VER;
+			rtw_fw_query_bt_mp_info(rtwdev, &req);
+			rtw_fw_query_bt_info(rtwdev);
+
+			rtw_coex_8723bs_scan_workaround(rtwdev);
+		} else {
+			coex_stat->wl_hi_pri_task2 = false;
+		}
+		return;
+	}
+
 	if (type == COEX_SCAN_START_5G) {
 		rtw_dbg(rtwdev, RTW_DBG_COEX,
 			"[BTCoex], SCAN START notify (5G)\n");
@@ -2938,6 +3164,17 @@ void rtw_coex_connect_notify(struct rtw_dev *rtwdev, u8 type)
 	if (coex->manual_control || coex->stop_dm)
 		return;
 
+	/* 8723BS SDIO BT-disabled: the vendor ConnectNotify() early-returns
+	 * without sending H2Cs; scan_workaround already established the PTA
+	 * path / coex table / PS-TDMA. Keep only the register-level PTA
+	 * reassertion at associate-start.
+	 */
+	if (rtw_coex_8723bs_bt_disabled(rtwdev)) {
+		if (type == COEX_ASSOCIATE_START)
+			rtw_coex_8723bs_force_assoc_pta_ant(rtwdev);
+		return;
+	}
+
 	rtw_coex_write_scbd(rtwdev, COEX_SCBD_ACTIVE | COEX_SCBD_ONOFF, true);
 
 	if (type == COEX_ASSOCIATE_5G_START) {
diff --git a/drivers/net/wireless/realtek/rtw88/coex.h b/drivers/net/wireless/realtek/rtw88/coex.h
index c398be8391f7..1f0aa17d4050 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.h
+++ b/drivers/net/wireless/realtek/rtw88/coex.h
@@ -430,4 +430,8 @@ static inline void rtw_coex_active_query_bt_info(struct rtw_dev *rtwdev)
 		rtw_coex_query_bt_info(rtwdev);
 }
 
+void rtw_coex_8723bs_scan_workaround(struct rtw_dev *rtwdev);
+void rtw_coex_8723bs_pre_auth_h2c(struct rtw_dev *rtwdev);
+void rtw_coex_8723bs_ensure_pta_path(struct rtw_dev *rtwdev);
+
 #endif
-- 
2.55.0


