Return-Path: <linux-wireless+bounces-34998-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJziN4eg5WkqmQEAu9opvQ
	(envelope-from <linux-wireless+bounces-34998-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 05:41:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 583A442694F
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 05:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63FCD300C27B
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 03:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AAB37BE6B;
	Mon, 20 Apr 2026 03:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="qGzdx83f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345FA2BDC0F
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 03:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776656501; cv=none; b=etaGULZ6fYHQp0poWEG76JIblqYN+L2d/oS3PAq/VnNHPInvMtMfcvPDHqZMPoxPDbraeRu1fsFAHJLX45zvHegb5VyI8XvFj88V5J7n6NgAgWfPombBvipPSA9aBCv0ybPCeCM0126dAN8/8Y4OBrTbKzWR7qatigwQZ6KTJUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776656501; c=relaxed/simple;
	bh=0T8y/m3v9HCsdkEQyG16LAJqCpmSjXCcI1bH1MVfuV4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A1X38qxIM1tc4GdSf9Ash5cKOVVR09Pm6AjIOm7kmDavjz1/j3NOC6/waPdm+YmugkmCjBSWoEArkvVxZgkxjzLuHSvlL5bajIVCK56h2tE2FqxzlyYrXgIzUCeQ8M3EBYsTTuF18vNwvlkjL1X4KswF4RyZueaNqT/8/wF/Yto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=qGzdx83f; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63K3faMdB426725, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1776656496; bh=hP1zUlHAN/nEfMFxxiRjYGEcFodWznAPkDm0o1KMgKA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=qGzdx83fsuOaa0lVyZ9o1/mC3BegpKFSb9gZ0S45o2fTc5Ui4OWRHG5CsNjWB+nTK
	 +u3f596dUXS8gJLJtG5AHlMQJIsV7rFlAVviof2qSvbgfxbf6I1VjNZpPC0kKsniL4
	 pU8cHMsjGbRAfikbkSxl5DPRPJJYmnU5JCXhRqu6V/4xZ+gp+mBUOy82klsPu0TzSu
	 BkU2O19WxQzD5pn88u08y0gdddFfPDjNx/J0QN3GnMYSQiy8ou6xFULBMc1SzjOOMu
	 ljVbdTQm3tTu0f/PXGt63pCY0RBe50ObwY/QDmMklQJPe3NO926/Iz9V5dyZ/3Ipuo
	 jFGZ5KjU9DRqg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63K3faMdB426725
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 11:41:36 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 20 Apr 2026 11:41:36 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 20 Apr 2026 11:41:36 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 20 Apr 2026 11:41:36 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <leo.li@realtek.com>, <gary.chang@realtek.com>, <echuang@realtek.com>,
        <wenjie.tsai@realtek.com>, <phhuang@realtek.com>, <isaiah@realtek.com>,
        <kevin_yang@realtek.com>, <mh_chen@realtek.com>
Subject: [PATCH rtw-next 05/16] wifi: rtw89: phy: support static PD level setting
Date: Mon, 20 Apr 2026 11:40:40 +0800
Message-ID: <20260420034051.17666-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260420034051.17666-1-pkshih@realtek.com>
References: <20260420034051.17666-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-34998-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 583A442694F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Eric Huang <echuang@realtek.com>

PD (Packet Detection) threshold is a key parameter in the DIG
(Dynamic Initial Gain) algorithm that determines the sensitivity
of packet detection. Current implementation only supports dynamic
PD adjustment based on environment. This patch adds support for
static PD threshold via debugfs allowing users to set a fixed PD
value for testing or specific scenarios.

Signed-off-by: Eric Huang <echuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h  |  4 +
 drivers/net/wireless/realtek/rtw89/debug.c | 94 ++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/phy.c   | 44 +++++++---
 3 files changed, 131 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 4e920472c8aa..8618a7c30ee0 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5180,6 +5180,7 @@ enum rtw89_dm_type {
 	RTW89_DM_MLO,
 	RTW89_DM_HW_SCAN,
 	RTW89_DM_INACTIVE_PS,
+	RTW89_DM_DIG_PD,
 };
 
 #define RTW89_THERMAL_PROT_LV_MAX 5
@@ -5221,6 +5222,9 @@ struct rtw89_hal {
 
 	u8 thermal_prot_th;
 	u8 thermal_prot_lv; /* 0 ~ RTW89_THERMAL_PROT_LV_MAX */
+
+	u8 fixed_dig_pd_th; /* v = (X(dBm) + 102)/2 */
+	s8 fixed_dig_cck_pd_th; /* dBm */
 };
 
 #define RTW89_MAX_MAC_ID_NUM 128
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index ebe3b1f9c39d..f7672d7e0229 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -87,6 +87,7 @@ struct rtw89_debugfs {
 	struct rtw89_debugfs_priv phy_info;
 	struct rtw89_debugfs_priv stations;
 	struct rtw89_debugfs_priv disable_dm;
+	struct rtw89_debugfs_priv static_pd_th;
 	struct rtw89_debugfs_priv mlo_mode;
 	struct rtw89_debugfs_priv beacon_info;
 	struct rtw89_debugfs_priv diag_mac;
@@ -4349,6 +4350,7 @@ static const struct rtw89_disabled_dm_info {
 	DM_INFO(MLO),
 	DM_INFO(HW_SCAN),
 	DM_INFO(INACTIVE_PS),
+	DM_INFO(DIG_PD),
 };
 
 static ssize_t
@@ -4394,6 +4396,96 @@ rtw89_debug_priv_disable_dm_set(struct rtw89_dev *rtwdev,
 	return count;
 }
 
+#define RTW89_DIG_PD_TH_MIN_DBM		-102
+#define RTW89_DIG_PD_TH_MAX_DBM		-40
+#define RTW89_DIG_PD_TH_STEP		2
+
+static inline s8 rtw89_dig_pd_th_to_dbm(u8 reg_val)
+{
+	return RTW89_DIG_PD_TH_MIN_DBM + RTW89_DIG_PD_TH_STEP * reg_val;
+}
+
+static inline u8 rtw89_dig_pd_th_dbm_to_reg(s8 dbm)
+{
+	return (dbm - RTW89_DIG_PD_TH_MIN_DBM) / RTW89_DIG_PD_TH_STEP;
+}
+
+static ssize_t
+rtw89_debug_priv_static_pd_th_get(struct rtw89_dev *rtwdev,
+				  struct rtw89_debugfs_priv *debugfs_priv,
+				  char *buf, size_t bufsz)
+{
+	struct rtw89_hal *hal = &rtwdev->hal;
+	char *p = buf, *end = buf + bufsz;
+	bool disabled;
+	s8 pd_th_dbm;
+	s8 cck_pd_th;
+
+	disabled = hal->disabled_dm_bitmap & BIT(RTW89_DM_DIG_PD);
+
+	if (disabled) {
+		pd_th_dbm = rtw89_dig_pd_th_to_dbm(hal->fixed_dig_pd_th);
+		cck_pd_th = hal->fixed_dig_cck_pd_th;
+
+		p += scnprintf(p, end - p, "DIG: static\n");
+		p += scnprintf(p, end - p, "OFDM PD threshold: %d dBm\n", pd_th_dbm);
+		p += scnprintf(p, end - p, "CCK PD threshold: %d dBm\n", cck_pd_th);
+	} else {
+		p += scnprintf(p, end - p, "DIG: dynamic\n");
+	}
+
+	p += scnprintf(p, end - p, "\nUsage: echo <mode> [pd_th] > static_pd_th\n");
+	p += scnprintf(p, end - p, "  mode: 0 = dynamic, 1 = static\n");
+	p += scnprintf(p, end - p, "  pd_th: PD threshold in dBm (-102 ~ -40)\n");
+
+	return p - buf;
+}
+
+static ssize_t
+rtw89_debug_priv_static_pd_th_set(struct rtw89_dev *rtwdev,
+				  struct rtw89_debugfs_priv *debugfs_priv,
+				  const char *buf, size_t count)
+{
+	struct rtw89_hal *hal = &rtwdev->hal;
+	int ret;
+	u32 mode;
+	s32 pd_th_dbm;
+
+	ret = sscanf(buf, "%u %d", &mode, &pd_th_dbm);
+	if (ret < 1)
+		return -EINVAL;
+
+	if (mode > 1)
+		return -EINVAL;
+
+	if (mode == 0) {
+		rtw89_core_dm_disable_clr(rtwdev, RTW89_DM_DIG_PD);
+		hal->fixed_dig_pd_th = 0;
+		hal->fixed_dig_cck_pd_th = 0;
+
+		rtw89_debug(rtwdev, RTW89_DBG_DIG,
+			    "DIG static mode disabled\n");
+	} else {
+		if (ret < 2 || pd_th_dbm < RTW89_DIG_PD_TH_MIN_DBM ||
+		    pd_th_dbm > RTW89_DIG_PD_TH_MAX_DBM)
+			return -EINVAL;
+
+		rtw89_core_dm_disable_set(rtwdev, RTW89_DM_DIG_PD);
+		hal->fixed_dig_pd_th = clamp(rtw89_dig_pd_th_dbm_to_reg(pd_th_dbm),
+					     0, 0x1f);
+		/* CCK uses dBm directly */
+		hal->fixed_dig_cck_pd_th = pd_th_dbm;
+
+		rtw89_debug(rtwdev, RTW89_DBG_DIG,
+			    "DIG static mode: PD=0x%02x (%d dBm), CCK=%d dBm\n",
+			    hal->fixed_dig_pd_th,
+			    rtw89_dig_pd_th_to_dbm(hal->fixed_dig_pd_th),
+			    hal->fixed_dig_cck_pd_th);
+	}
+
+	return count;
+}
+
 static void rtw89_debug_mlo_mode_set_mlsr(struct rtw89_dev *rtwdev,
 					  unsigned int link_id)
 {
@@ -4882,6 +4974,7 @@ static const struct rtw89_debugfs rtw89_debugfs_templ = {
 	.phy_info = rtw89_debug_priv_get(phy_info),
 	.stations = rtw89_debug_priv_get(stations, RLOCK),
 	.disable_dm = rtw89_debug_priv_set_and_get(disable_dm, RWLOCK),
+	.static_pd_th = rtw89_debug_priv_set_and_get(static_pd_th, RWLOCK),
 	.mlo_mode = rtw89_debug_priv_set_and_get(mlo_mode, RWLOCK),
 	.beacon_info = rtw89_debug_priv_get(beacon_info),
 	.diag_mac = rtw89_debug_priv_get(diag_mac, RSIZE_16K, RLOCK),
@@ -4930,6 +5023,7 @@ void rtw89_debugfs_add_sec1(struct rtw89_dev *rtwdev, struct dentry *debugfs_top
 	rtw89_debugfs_add_r(phy_info);
 	rtw89_debugfs_add_r(stations);
 	rtw89_debugfs_add_rw(disable_dm);
+	rtw89_debugfs_add_rw(static_pd_th);
 	rtw89_debugfs_add_rw(mlo_mode);
 	rtw89_debugfs_add_r(beacon_info);
 	rtw89_debugfs_add_r(diag_mac);
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index e70d0e283987..f26cbde6bdd0 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -7162,11 +7162,19 @@ static void rtw89_phy_dig_dyn_pd_th(struct rtw89_dev *rtwdev,
 	const struct rtw89_chan *chan = rtw89_mgnt_chan_get(rtwdev, bb->phy_idx);
 	const struct rtw89_dig_regs *dig_regs = rtwdev->chip->dig_regs;
 	struct rtw89_dig_info *dig = &bb->dig;
+	struct rtw89_hal *hal = &rtwdev->hal;
 	u8 final_rssi, under_region = dig->pd_low_th_ofst;
 	s8 cck_cca_th;
 	u32 pd_val;
 
-	pd_val = __rtw89_phy_dig_dyn_pd_th(rtwdev, bb, rssi, enable, chan);
+	if (hal->disabled_dm_bitmap & BIT(RTW89_DM_DIG_PD)) {
+		pd_val = hal->fixed_dig_pd_th;
+
+		rtw89_debug(rtwdev, RTW89_DBG_DIG,
+			    "Fixed DIG: PD_low=%d\n", pd_val);
+	} else {
+		pd_val = __rtw89_phy_dig_dyn_pd_th(rtwdev, bb, rssi, enable, chan);
+	}
 	dig->bak_dig = pd_val;
 
 	rtw89_phy_write32_idx(rtwdev, dig_regs->seg0_pd_reg,
@@ -7174,17 +7182,24 @@ static void rtw89_phy_dig_dyn_pd_th(struct rtw89_dev *rtwdev,
 	rtw89_phy_write32_idx(rtwdev, dig_regs->seg0_pd_reg,
 			      dig_regs->pd_spatial_reuse_en, enable, bb->phy_idx);
 
-	if (!rtwdev->hal.support_cckpd)
+	if (!hal->support_cckpd)
 		return;
 
-	final_rssi = min_t(u8, rssi, dig->igi_rssi);
-	under_region = rtw89_phy_dig_cal_under_region(rtwdev, bb, chan);
-	cck_cca_th = max_t(s8, final_rssi - under_region, CCKPD_TH_MIN_RSSI);
-	pd_val = (u32)(cck_cca_th - IGI_RSSI_MAX);
+	if (hal->disabled_dm_bitmap & BIT(RTW89_DM_DIG_PD)) {
+		pd_val = hal->fixed_dig_cck_pd_th;
 
-	rtw89_debug(rtwdev, RTW89_DBG_DIG,
-		    "igi=%d, cck_ccaTH=%d, backoff=%d, cck_PD_low=((%d))dB\n",
-		    final_rssi, cck_cca_th, under_region, pd_val);
+		rtw89_debug(rtwdev, RTW89_DBG_DIG,
+			    "Fixed DIG: cck_PD_low=((%d))dB\n", pd_val);
+	} else {
+		final_rssi = min_t(u8, rssi, dig->igi_rssi);
+		under_region = rtw89_phy_dig_cal_under_region(rtwdev, bb, chan);
+		cck_cca_th = max_t(s8, final_rssi - under_region, CCKPD_TH_MIN_RSSI);
+		pd_val = (u32)(cck_cca_th - IGI_RSSI_MAX);
+
+		rtw89_debug(rtwdev, RTW89_DBG_DIG,
+			    "igi=%d, cck_ccaTH=%d, backoff=%d, cck_PD_low=((%d))dB\n",
+			    final_rssi, cck_cca_th, under_region, pd_val);
+	}
 
 	rtw89_phy_write32_idx(rtwdev, dig_regs->bmode_pd_reg,
 			      dig_regs->bmode_cca_rssi_limit_en, enable, bb->phy_idx);
@@ -7315,6 +7330,7 @@ static void rtw89_phy_dig_ctrl(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *bb
 {
 	const struct rtw89_dig_regs *dig_regs = rtwdev->chip->dig_regs;
 	struct rtw89_dig_info *dig = &bb->dig;
+	struct rtw89_hal *hal = &rtwdev->hal;
 	bool en_dig;
 	u32 pd_val;
 
@@ -7323,10 +7339,16 @@ static void rtw89_phy_dig_ctrl(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *bb
 
 	if (pause_dig) {
 		en_dig = false;
-		pd_val = 0;
+		if (hal->disabled_dm_bitmap & BIT(RTW89_DM_DIG_PD))
+			pd_val = hal->fixed_dig_pd_th;
+		else
+			pd_val = 0;
 	} else {
 		en_dig = rtwdev->total_sta_assoc > 0;
-		pd_val = restore ? dig->bak_dig : 0;
+		if (hal->disabled_dm_bitmap & BIT(RTW89_DM_DIG_PD))
+			pd_val = hal->fixed_dig_pd_th;
+		else
+			pd_val = restore ? dig->bak_dig : 0;
 	}
 
 	rtw89_debug(rtwdev, RTW89_DBG_DIG, "%s <%s> PD_low=%d", __func__,
-- 
2.25.1


