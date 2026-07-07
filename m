Return-Path: <linux-wireless+bounces-38735-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CmM5IGfGTGo9pgEAu9opvQ
	(envelope-from <linux-wireless+bounces-38735-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 11:27:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B55719BF0
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 11:27:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=Ng8aSstR;
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38735-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38735-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2896831AB1FB
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jul 2026 09:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E42739182A;
	Tue,  7 Jul 2026 09:12:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DA7390C95
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jul 2026 09:12:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415553; cv=none; b=oCIOsSrkDaNl5Zy8IwsoGF9Deyj0thYFqZCINY6eVzn16O610jtjRkHp5TQUz2b0NVijo4QHhsr2wSZ42JVa0P8L8gNc3PdtvrLcVmx8k2yGnEocoheKUDzJTlFOSrPU7+yeH2JDEIiklPFaYokQjsbhDh2qUxjShNYsWlmbzMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415553; c=relaxed/simple;
	bh=OxRvz97g9nIjID/VcZWQw1h8gGw+QkKXxwospyZ/jWU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gmem3NFGJqYhNpkCFh/OHNX8WyU59GiHcWrXoztaZOw85xejSDfITmzgbMctwY3qTqQg7bIckQCFXk5rWi96UR8ZAgDAQOCYdZOf3Y3ffYysIKSRKeAOkKqLULgqa8e7tUZV2PB5htBiN1Z9OD8T8Zm8VzfRCjDYTuKkDrt2sFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Ng8aSstR; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6679CTEp81359557, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783415549; bh=ohIqd588dDLzu3Fauk8FrSMAFgy60Il0ciEmX5CVTew=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Ng8aSstR4Xh/y2AQAcPNOtRtK0KKh3/2yZy90Oj2N4LXYxbsXfy6U0VbAW9rKhAbF
	 9SjJZ4eJXFPMSzjAGLFh0ZToo8EF5OX5M/5EnD43SBIxUW3YmOXeTkc8x7buDkb9Qf
	 P3JW1XtToOHV5H3KW8BrVvarhFFtvR5h/CQ8Nmo2S3YIzmmcYeBVtehEkeMEoddMu8
	 4y2A/cBzegopCOTyGZxL9eQ0GJJzkdHNFpqr/z/ezQkBzuZ/G1MP8M+CFSwwyz5JD6
	 YqTRj1xVSTy/mREcAD+ajdfOBi2Rt5bPNaVb2ex5pS2eGmLJHcgEb3/fcME2m25cbe
	 QMFbULhQ2MP4Q==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6679CTEp81359557
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Tue, 7 Jul 2026 17:12:29 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 7 Jul 2026 17:12:29 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 7 Jul 2026 17:12:29 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <echuang@realtek.com>
Subject: [PATCH rtw-next 07/15] wifi: rtw89: efuse: read thermal calibration value for RTL8922D
Date: Tue, 7 Jul 2026 17:10:48 +0800
Message-ID: <20260707091056.42771-8-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38735-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,realtek.com:from_mime,realtek.com:email,realtek.com:mid,realtek.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F0B55719BF0

The thermal calibration value programmed in efuse is the offset to adjust
thermal value read from hardware, so that output will be accurate.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  2 ++
 drivers/net/wireless/realtek/rtw89/efuse.h    |  6 ++++
 drivers/net/wireless/realtek/rtw89/efuse_be.c | 29 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.c      |  2 ++
 drivers/net/wireless/realtek/rtw89/mac.h      | 11 +++++++
 drivers/net/wireless/realtek/rtw89/mac_be.c   |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8922d.c |  2 ++
 7 files changed, 53 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 9a4d42b60bbb..888a09fb2a9a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5884,6 +5884,8 @@ struct rtw89_power_trim_info {
 	u8 pa_bias_trim[RF_PATH_MAX];
 	u8 pad_bias_trim[RF_PATH_MAX];
 	u8 vco_trim[RF_PATH_MAX];
+
+	s16 thermal_k;
 };
 
 enum rtw89_regd_func {
diff --git a/drivers/net/wireless/realtek/rtw89/efuse.h b/drivers/net/wireless/realtek/rtw89/efuse.h
index a14a9dfed8e8..c6415da749a3 100644
--- a/drivers/net/wireless/realtek/rtw89/efuse.h
+++ b/drivers/net/wireless/realtek/rtw89/efuse.h
@@ -16,6 +16,11 @@
 #define EF_CV_MASK GENMASK(7, 4)
 #define EF_CV_INV 15
 
+#define EFUSE_THERMAL_K_OFFSET_BE 0x17CC
+#define EFUSE_THERMAL_K_VALID_BE BIT(9)
+#define EFUSE_THERMAL_K_SIGN_BE BIT(8)
+#define EFUSE_THERMAL_K_VAL_BE GENMASK(7, 0)
+
 struct rtw89_efuse_block_cfg {
 	u32 offset;
 	u32 size;
@@ -32,5 +37,6 @@ int rtw89_efuse_recognize_mss_info_v1(struct rtw89_dev *rtwdev, u8 b1, u8 b2);
 int rtw89_efuse_read_fw_secure_ax(struct rtw89_dev *rtwdev);
 int rtw89_efuse_read_fw_secure_be(struct rtw89_dev *rtwdev);
 int rtw89_efuse_read_ecv_be(struct rtw89_dev *rtwdev);
+int rtw89_efuse_read_thermal_k_be(struct rtw89_dev *rtwdev);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/efuse_be.c b/drivers/net/wireless/realtek/rtw89/efuse_be.c
index a716ad54fce5..67036c89883f 100644
--- a/drivers/net/wireless/realtek/rtw89/efuse_be.c
+++ b/drivers/net/wireless/realtek/rtw89/efuse_be.c
@@ -537,3 +537,32 @@ int rtw89_efuse_read_ecv_be(struct rtw89_dev *rtwdev)
 
 	return 0;
 }
+
+int rtw89_efuse_read_thermal_k_be(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_power_trim_info *info = &rtwdev->pwr_trim;
+	u32 dump_addr = EFUSE_THERMAL_K_OFFSET_BE;
+	u8 buff[4]; /* efuse access must be multiple of 4 bytes in size */
+	bool no_k;
+	u16 val16;
+	int ret;
+
+	ret = rtw89_dump_physical_efuse_map_be(rtwdev, buff, dump_addr, 4, false);
+	if (ret)
+		return ret;
+
+	val16 = buff[0] | buff[1] << 8;
+
+	no_k = !!u16_get_bits(val16, EFUSE_THERMAL_K_VALID_BE);
+	if (no_k) {
+		info->thermal_k = 0;
+		return -ENOENT;
+	}
+
+	info->thermal_k = u16_get_bits(val16, EFUSE_THERMAL_K_VAL_BE);
+
+	if (u16_get_bits(val16, EFUSE_THERMAL_K_SIGN_BE))
+		info->thermal_k *= -1;
+
+	return 0;
+}
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 99de1b202976..3d3f683046a7 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1558,6 +1558,7 @@ static int rtw89_mac_power_switch(struct rtw89_dev *rtwdev, bool on)
 		if (!test_bit(RTW89_FLAG_PROBE_DONE, rtwdev->flags)) {
 			rtw89_mac_efuse_read_ecv(rtwdev);
 			mac->efuse_read_fw_secure(rtwdev);
+			rtw89_mac_efuse_read_thermal_k(rtwdev);
 		}
 
 		set_bit(RTW89_FLAG_POWERON, rtwdev->flags);
@@ -7500,6 +7501,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_ax = {
 	.cnv_efuse_state = rtw89_cnv_efuse_state_ax,
 	.efuse_read_fw_secure = rtw89_efuse_read_fw_secure_ax,
 	.efuse_read_ecv = NULL,
+	.efuse_read_thermal_k = NULL,
 
 	.cfg_plt = rtw89_mac_cfg_plt_ax,
 	.get_plt_cnt = rtw89_mac_get_plt_cnt_ax,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 539061fc15e8..7256d64ea07f 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1132,6 +1132,7 @@ struct rtw89_mac_gen_def {
 	int (*cnv_efuse_state)(struct rtw89_dev *rtwdev, bool idle);
 	int (*efuse_read_fw_secure)(struct rtw89_dev *rtwdev);
 	int (*efuse_read_ecv)(struct rtw89_dev *rtwdev);
+	int (*efuse_read_thermal_k)(struct rtw89_dev *rtwdev);
 
 	int (*cfg_plt)(struct rtw89_dev *rtwdev, struct rtw89_mac_ax_plt *plt);
 	u16 (*get_plt_cnt)(struct rtw89_dev *rtwdev, u8 band);
@@ -1735,6 +1736,16 @@ static inline int rtw89_mac_efuse_read_ecv(struct rtw89_dev *rtwdev)
 	return mac->efuse_read_ecv(rtwdev);
 }
 
+static inline int rtw89_mac_efuse_read_thermal_k(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+
+	if (!mac->efuse_read_thermal_k)
+		return -ENOENT;
+
+	return mac->efuse_read_thermal_k(rtwdev);
+}
+
 static inline
 void rtw89_mac_fwdl_preconfig(struct rtw89_dev *rtwdev)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 14f1e30066e9..077ddf4f77c5 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -3312,6 +3312,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_be = {
 	.cnv_efuse_state = rtw89_cnv_efuse_state_be,
 	.efuse_read_fw_secure = rtw89_efuse_read_fw_secure_be,
 	.efuse_read_ecv = rtw89_efuse_read_ecv_be,
+	.efuse_read_thermal_k = rtw89_efuse_read_thermal_k_be,
 
 	.cfg_plt = rtw89_mac_cfg_plt_be,
 	.get_plt_cnt = rtw89_mac_get_plt_cnt_be,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d.c b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
index e8267173bd4c..8b91c552a309 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
@@ -3006,6 +3006,7 @@ static void rtw8922d_bb_cfg_txrx_path(struct rtw89_dev *rtwdev)
 
 static u8 rtw8922d_get_thermal(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path)
 {
+	struct rtw89_power_trim_info *info = &rtwdev->pwr_trim;
 	u8 val;
 
 	rtw89_phy_write32_mask(rtwdev, R_TC_EN_BE4, B_TC_EN_BE4, 0x1);
@@ -3015,6 +3016,7 @@ static u8 rtw8922d_get_thermal(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_p
 	fsleep(100);
 
 	val = rtw89_phy_read32_mask(rtwdev, R_TC_VAL_BE4, B_TC_VAL_BE4);
+	val = clamp_t(int, val + info->thermal_k, 0, 255);
 
 	return val;
 }
-- 
2.25.1


