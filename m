Return-Path: <linux-wireless+bounces-38737-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jdFfA0rETGqPpQEAu9opvQ
	(envelope-from <linux-wireless+bounces-38737-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 11:18:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6087199FE
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 11:18:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=C1qgjp5O;
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38737-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38737-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD71030B2347
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jul 2026 09:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF243911CD;
	Tue,  7 Jul 2026 09:12:43 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C608C13D53C
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jul 2026 09:12:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415563; cv=none; b=DKjSaJ0NaMy+jYF/ktNp06PyJg81RNIyO+agjH88PuTDsT7rIl9QQsnmNRDyEKdgqPKBbMPwsny0YLONvl/yKydZGEQa0gXQuRkGyFO/JOLkKtKkkNid4c0uJqT/3FjJbHBlpEbe/jER3XcENFDFy3fz6TIRzK6OtwcIPyk6pYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415563; c=relaxed/simple;
	bh=1AyQnh5ArJNgAZjhx1ZLqLW9Lkr//zox6O8sWb9Rh+Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h32Nor8qaXMW7mNuI9OnSn1c9gSaoYuvKifjuhkrEUdPcspxZ3uP7kKx1HkzEfCOW2xruBJdeEU3LldPrN7NyN3BLNnpJuB4fxJsuUlvNcwYw8lVxyVVPw+mLmSISJDIsX3IAQNEVTau01IEDxqSfoOnGFHefymyhdL0wVTcI+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=C1qgjp5O; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6679Cd1uA1359617, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783415559; bh=qYqiRLeIo7RrVXG0CjUsptij+1I2pg4/Ltxj8GUvSdk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=C1qgjp5O9HXEKQWhcgsr/dphDAkRA/F4oWADBYBPT5aBoL34bVpJlxUFrQ5BhTK0/
	 IIK37vR9toXQsBAqKK2dCmdpAWV5WVmSn9YP2b3sMMVTJvfa/8vWEr7yYbWidBrEdE
	 CPUIzoANL04/k4aVDJLpMxb5D55HQqEPTvaLlI0kqU+ZNfuzrVnHW6M1egJ6ZPxuIj
	 HtFklb5kBq/Rtbr3p74LnD0WGQWodVrMamIKUuhZjrOiNb1S4JrW8Zd2hcusURkkfR
	 UHFV6LJtKkIFyPRzgh5jCBk9JDxeKgsXhMVyq62yTjrmzGPp95LfpL7/6VH+bBM3V+
	 8NSF3CD/s14Bg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6679Cd1uA1359617
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Tue, 7 Jul 2026 17:12:39 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 7 Jul 2026 17:12:39 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 7 Jul 2026 17:12:39 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <echuang@realtek.com>
Subject: [PATCH rtw-next 09/15] wifi: rtw89: add thermal protect by digital voltage reduction
Date: Tue, 7 Jul 2026 17:10:50 +0800
Message-ID: <20260707091056.42771-10-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260707091056.42771-1-pkshih@realtek.com>
References: <20260707091056.42771-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38737-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:gary.chang@realtek.com,m:echuang@realtek.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,realtek.com:from_mime,realtek.com:email,realtek.com:mid,realtek.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9E6087199FE

The temperature is rising when WiFi does high throughput, and reduce
voltage is a way to ease temperature.

The existing method to do thermal protect is to reduce TX duty, which
can affect throughput obviously. Before doing reduce TX duty (with -20
thermal value offset), driver does voltage reduction first, which doesn't
affect throughput but lower power consumption.

The voltage gram of register is 0.01 voltage, and the suggested maximum
reduction is 6 grams, which driver defines 6 as maximum voltage level.
When thermal value is over threshold, driver will try to adjust level and
corresponding register value. It should be adjust grams one by one with
additional 50 ms delay to ensure hardware work properly.

A note that the voltage must reset to normal value before entering power
save mode, otherwise WiFi card might get lost. Since it takes 50 ms delay
for each gram to adjust voltage, we stop to enter power save if protect
level is not zero.

By the way, adjust thermal threshold to 0xB4 as desired.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     |  9 +++++
 drivers/net/wireless/realtek/rtw89/core.h     |  4 ++
 drivers/net/wireless/realtek/rtw89/debug.c    |  1 +
 drivers/net/wireless/realtek/rtw89/mac.c      |  3 ++
 drivers/net/wireless/realtek/rtw89/mac.h      | 24 ++++++++++++
 drivers/net/wireless/realtek/rtw89/mac_be.c   | 38 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/phy.c      | 27 +++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8922d.c |  2 +-
 8 files changed, 107 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 9dbf01e82383..74b9aa8398ff 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -5236,9 +5236,18 @@ static bool rtw89_traffic_stats_track(struct rtw89_dev *rtwdev)
 static void rtw89_enter_lps_track(struct rtw89_dev *rtwdev,
 				  enum rtw89_tfc_interval interval)
 {
+	struct rtw89_hal *hal = &rtwdev->hal;
 	struct ieee80211_vif *vif;
 	struct rtw89_vif *rtwvif;
 
+	/*
+	 * If vcore level is set, temperature is high and voltage is low. As
+	 * entering power save must reset voltage to default, avoid power save
+	 * until vcore decreases to zero resulting from temperature becomes low.
+	 */
+	if (hal->thermal_prot_vlv)
+		return;
+
 	rtw89_for_each_rtwvif(rtwdev, rtwvif) {
 		if (rtwvif->tdls_peer)
 			continue;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 7729e7d4a792..2b388407bf6e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5344,10 +5344,13 @@ enum rtw89_dm_type {
 	RTW89_DM_HW_SCAN,
 	RTW89_DM_INACTIVE_PS,
 	RTW89_DM_DIG_PD,
+	RTW89_DM_VCORE,
 };
 
 #define RTW89_THERMAL_PROT_LV_MAX 5
 #define RTW89_THERMAL_PROT_STEP 5 /* -5% for each level */
+#define RTW89_THERMAL_PROT_VLV_MAX 6
+#define RTW89_THERMAL_PROT_VLV_TH_OFFSET 20
 
 struct rtw89_hal {
 	u32 rx_fltr;
@@ -5388,6 +5391,7 @@ struct rtw89_hal {
 
 	u8 thermal_prot_vmax;
 	u8 thermal_prot_vmin;
+	u8 thermal_prot_vlv; /* 0 ~ RTW89_THERMAL_PROT_VLV_MAX (6) */
 
 	u8 fixed_dig_pd_th; /* v = (X(dBm) + 102)/2 */
 	s8 fixed_dig_cck_pd_th; /* dBm */
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 5786120602ab..e42dc5707576 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -4778,6 +4778,7 @@ static const struct rtw89_disabled_dm_info {
 	DM_INFO(HW_SCAN),
 	DM_INFO(INACTIVE_PS),
 	DM_INFO(DIG_PD),
+	DM_INFO(VCORE),
 };
 
 static ssize_t
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index f5e55e6be119..6e3da5e4a1b3 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1602,6 +1602,8 @@ int rtw89_mac_pwr_on(struct rtw89_dev *rtwdev)
 
 void rtw89_mac_pwr_off(struct rtw89_dev *rtwdev)
 {
+	rtw89_mac_set_vcore_reset(rtwdev);
+
 	rtw89_mac_power_switch(rtwdev, false);
 }
 
@@ -7477,6 +7479,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_ax = {
 	.cfg_ppdu_status = rtw89_mac_cfg_ppdu_status_ax,
 	.cfg_phy_rpt = NULL,
 	.set_edcca_mode = NULL,
+	.set_vcore_cfg = NULL,
 
 	.dle_mix_cfg = dle_mix_cfg_ax,
 	.chk_dle_rdy = chk_dle_rdy_ax,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 8bbe49492d4c..f85c14ca0f35 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1100,6 +1100,7 @@ struct rtw89_mac_gen_def {
 	int (*cfg_ppdu_status)(struct rtw89_dev *rtwdev, u8 mac_idx, bool enable);
 	void (*cfg_phy_rpt)(struct rtw89_dev *rtwdev, u8 mac_idx, bool enable);
 	void (*set_edcca_mode)(struct rtw89_dev *rtwdev, u8 mac_idx, bool normal);
+	void (*set_vcore_cfg)(struct rtw89_dev *rtwdev, u8 vlv);
 
 	int (*dle_mix_cfg)(struct rtw89_dev *rtwdev, const struct rtw89_dle_mem *cfg);
 	int (*chk_dle_rdy)(struct rtw89_dev *rtwdev, bool wde_or_ple);
@@ -1459,6 +1460,29 @@ void rtw89_mac_set_edcca_mode(struct rtw89_dev *rtwdev, u8 mac_idx, bool normal)
 	mac->set_edcca_mode(rtwdev, mac_idx, normal);
 }
 
+static inline
+void rtw89_mac_set_vcore_cfg(struct rtw89_dev *rtwdev, u8 vlv)
+{
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+
+	if (!mac->set_vcore_cfg)
+		return;
+
+	mac->set_vcore_cfg(rtwdev, vlv);
+}
+
+static inline
+void rtw89_mac_set_vcore_reset(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_hal *hal = &rtwdev->hal;
+
+	if (hal->thermal_prot_vlv == 0)
+		return;
+
+	hal->thermal_prot_vlv = 0;
+	rtw89_mac_set_vcore_cfg(rtwdev, 0);
+}
+
 static inline
 void rtw89_mac_set_edcca_mode_bands(struct rtw89_dev *rtwdev, bool normal)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 0fe317929b1b..4bdf20b7ba6d 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -2676,6 +2676,43 @@ void rtw89_mac_set_edcca_mode_be(struct rtw89_dev *rtwdev, u8 mac_idx, bool norm
 	}
 }
 
+static
+void rtw89_mac_set_vcore_cfg_be(struct rtw89_dev *rtwdev, u8 vlv)
+{
+	struct rtw89_hal *hal = &rtwdev->hal;
+	u32 val32;
+	u8 target;
+	u8 vpwm;
+	int i;
+
+	if (rtwdev->chip->chip_id != RTL8922D)
+		return;
+
+	target = clamp(hal->thermal_prot_vmax - vlv,
+		       hal->thermal_prot_vmin, hal->thermal_prot_vmax);
+
+	val32 = rtw89_read32(rtwdev, R_BE_SPS_DIG_ON_CTRL0);
+	vpwm = u32_get_bits(val32, B_BE_PWMTUNE_MASK);
+	val32 &= ~B_BE_PWMTUNE_MASK;
+
+	if (vpwm == target)
+		return;
+
+	for (i = 0; i < RTW89_THERMAL_PROT_VLV_MAX; i++) {
+		if (vpwm > target)
+			vpwm--;
+		else
+			vpwm++;
+
+		rtw89_write32(rtwdev, R_BE_SPS_DIG_ON_CTRL0, val32 | vpwm);
+
+		if (vpwm == target)
+			break;
+
+		mdelay(50);
+	}
+}
+
 static
 int rtw89_mac_cfg_ppdu_status_be(struct rtw89_dev *rtwdev, u8 mac_idx, bool enable)
 {
@@ -3287,6 +3324,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_be = {
 	.cfg_ppdu_status = rtw89_mac_cfg_ppdu_status_be,
 	.cfg_phy_rpt = rtw89_mac_cfg_phy_rpt_be,
 	.set_edcca_mode = rtw89_mac_set_edcca_mode_be,
+	.set_vcore_cfg = rtw89_mac_set_vcore_cfg_be,
 
 	.dle_mix_cfg = dle_mix_cfg_be,
 	.chk_dle_rdy = chk_dle_rdy_be,
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 981c7f02271a..dcd54be58a33 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -5718,6 +5718,32 @@ static void rtw89_phy_antdiv_init(struct rtw89_dev *rtwdev)
 	rtw89_phy_antdiv_reg_init(rtwdev);
 }
 
+static void rtw89_phy_thermal_protect_vcore(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_phy_stat *phystat = &rtwdev->phystat;
+	struct rtw89_hal *hal = &rtwdev->hal;
+	bool vcore_enabled = !!hal->thermal_prot_vmax;
+	u8 th_max = phystat->last_thermal_max;
+	u8 vlv = hal->thermal_prot_vlv;
+	u8 prot_th;
+
+	if (!vcore_enabled || (hal->disabled_dm_bitmap & BIT(RTW89_DM_VCORE)))
+		return;
+
+	prot_th = hal->thermal_prot_th - RTW89_THERMAL_PROT_VLV_TH_OFFSET;
+	if (th_max > prot_th && vlv < RTW89_THERMAL_PROT_VLV_MAX)
+		vlv++;
+	else if (th_max < prot_th - 2 && vlv > 0)
+		vlv--;
+	else
+		return;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK_TRACK, "thermal protection vlv=%d\n", vlv);
+
+	hal->thermal_prot_vlv = vlv;
+	rtw89_mac_set_vcore_cfg(rtwdev, vlv);
+}
+
 static void rtw89_phy_thermal_protect(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_phy_stat *phystat = &rtwdev->phystat;
@@ -6186,6 +6212,7 @@ void rtw89_phy_stat_track(struct rtw89_dev *rtwdev)
 	struct rtw89_bb_ctx *bb;
 
 	rtw89_phy_stat_thermal_update(rtwdev);
+	rtw89_phy_thermal_protect_vcore(rtwdev);
 	rtw89_phy_thermal_protect(rtwdev);
 	rtw89_phy_stat_rssi_update(rtwdev);
 	rtw89_phy_stat_update(rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d.c b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
index a6693c8413d5..36b9b529195d 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
@@ -3451,7 +3451,7 @@ const struct rtw89_chip_info rtw8922d_chip_info = {
 	.wde_qempty_acq_grpnum	= 8,
 	.wde_qempty_mgq_grpsel	= 8,
 	.rf_base_addr		= {0x3e000, 0x3f000},
-	.thermal_th		= {0xac, 0xad},
+	.thermal_th		= {0xac, 0xb4},
 	.pwr_on_seq		= NULL,
 	.pwr_off_seq		= NULL,
 	.bb_table		= NULL,
-- 
2.25.1


