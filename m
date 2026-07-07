Return-Path: <linux-wireless+bounces-38736-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AnN4NWjFTGrkpQEAu9opvQ
	(envelope-from <linux-wireless+bounces-38736-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 11:22:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B15719B0E
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 11:22:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=ab6BqVE2;
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38736-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38736-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C43C31AC473
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jul 2026 09:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D7B390229;
	Tue,  7 Jul 2026 09:12:38 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A091C13D53C
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jul 2026 09:12:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415558; cv=none; b=KlYjSBX3vrH6nEngKUU6GH9tBPVh4MbhhaYQ8DY++6SL2tMVvHKbZe5N0Ruk5bDLXh7nVFZBueY9Hbw2wQ0dKsoXubDuaWJMXO4dO5vf5E1cNqqOZ7+RD44IfCQxbWPYJk5spIEY3gj+S5+AcdZLsl7JTkRv/cPZ4UnglOoOP54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415558; c=relaxed/simple;
	bh=JIJlIBFrXE/hPpHQzv70nJHq1cS6UuIB4g8fkYl93e8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pmX9BmYHQiIrEzA3a7x03ZUJINcwP9yruP4BVw21K+BIT8rcwsxNfHlXy4e3Cgm07wLMe1MDYFBCkWGggm2kBdKXQT13WAeqKBjSyiBl7rn06fhwD3W+Kdfb+iQPuLbpiXZV+SfWDPzesCuLt6ciCv+NlUTZ01xaE/DuVFQt1Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ab6BqVE2; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6679CYu941359574, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783415554; bh=ZpYeqSaMDQTRqBQ0brDzFvFVoAMXE3uNfgmYHQf2jg8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=ab6BqVE2xAcfC+THVrWyau4kXtrNDsAwA9vlbNlPB95mpsplZySPNM+STdz60SvA6
	 rHadII+2QbpGy6l7Km8MrzNBorpTQPEMcgpvr4nFgPAxDsbNwc7CiICJBKC2yyE4Pa
	 j02k9YvieLkx0PnfhrVDKDXXgNwn+gicEGQXLXb7PdwzeFjktuSCX5K6NTeBZXqfis
	 e/OA91/b5LTa3jUb0Rlga2miaJn5LO4mEVhSSoNZjDT3NcxfhMOCGwy7OvJwBWDqHV
	 V6a2xh6S11BUrCqpgwFBXq7hXQCp9TpbgbDgivQtTPOkPUUrhuSwPWRFSK8n990jzb
	 +hQSOCTAgpVNg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6679CYu941359574
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Tue, 7 Jul 2026 17:12:34 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 7 Jul 2026 17:12:34 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 7 Jul 2026 17:12:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <echuang@realtek.com>
Subject: [PATCH rtw-next 08/15] wifi: rtw89: 8922d: read default digital voltage calibration values
Date: Tue, 7 Jul 2026 17:10:49 +0800
Message-ID: <20260707091056.42771-9-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38736-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:from_mime,realtek.com:email,realtek.com:mid,realtek.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 58B15719B0E

In order to lower temperature when WiFi is running, reduce the digital
voltage for the purpose.

The calibration values of digital voltage are programmed in efuse. One is
for normal use, which driver stores it into hal->thermal_prot_vmax. The
other is the minimum voltage, which is stored into hal->thermal_prot_vmin.
These two values define a range of supported voltage, which latter patch
uses them to adjust voltage depends on thermal value (temperature).

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  7 ++
 drivers/net/wireless/realtek/rtw89/efuse.h    |  1 +
 drivers/net/wireless/realtek/rtw89/efuse_be.c | 87 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.c      |  2 +
 drivers/net/wireless/realtek/rtw89/mac.h      | 11 +++
 drivers/net/wireless/realtek/rtw89/mac_be.c   |  1 +
 drivers/net/wireless/realtek/rtw89/reg.h      | 17 ++++
 drivers/net/wireless/realtek/rtw89/rtw8922d.c | 24 +++++
 8 files changed, 150 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 888a09fb2a9a..7729e7d4a792 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3661,6 +3661,8 @@ struct rtw89_sta_link {
 struct rtw89_efuse {
 	bool valid;
 	bool power_k_valid;
+	bool vcore_valid;
+	bool dswr_valid;
 	u8 xtal_cap;
 	u8 addr[ETH_ALEN];
 	u8 rfe_type;
@@ -3670,6 +3672,8 @@ struct rtw89_efuse {
 	u8 bt_setting_3;
 	u8 sn[RTW89_EFUSE_SN_LEN];
 	u8 uuid[RTW89_EFUSE_UUID_LEN];
+	u8 vcore_vmax_reduce;
+	u8 dswr_vmin;
 };
 
 struct rtw89_phy_rate_pattern {
@@ -5382,6 +5386,9 @@ struct rtw89_hal {
 	u8 thermal_prot_th;
 	u8 thermal_prot_lv; /* 0 ~ RTW89_THERMAL_PROT_LV_MAX */
 
+	u8 thermal_prot_vmax;
+	u8 thermal_prot_vmin;
+
 	u8 fixed_dig_pd_th; /* v = (X(dBm) + 102)/2 */
 	s8 fixed_dig_cck_pd_th; /* dBm */
 };
diff --git a/drivers/net/wireless/realtek/rtw89/efuse.h b/drivers/net/wireless/realtek/rtw89/efuse.h
index c6415da749a3..4eb629273ab9 100644
--- a/drivers/net/wireless/realtek/rtw89/efuse.h
+++ b/drivers/net/wireless/realtek/rtw89/efuse.h
@@ -38,5 +38,6 @@ int rtw89_efuse_read_fw_secure_ax(struct rtw89_dev *rtwdev);
 int rtw89_efuse_read_fw_secure_be(struct rtw89_dev *rtwdev);
 int rtw89_efuse_read_ecv_be(struct rtw89_dev *rtwdev);
 int rtw89_efuse_read_thermal_k_be(struct rtw89_dev *rtwdev);
+int rtw89_efuse_read_pwr_data_be(struct rtw89_dev *rtwdev);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/efuse_be.c b/drivers/net/wireless/realtek/rtw89/efuse_be.c
index 67036c89883f..825274bd7c41 100644
--- a/drivers/net/wireless/realtek/rtw89/efuse_be.c
+++ b/drivers/net/wireless/realtek/rtw89/efuse_be.c
@@ -16,6 +16,15 @@
 #define EFUSE_SEC_BE_START 0x1580
 #define EFUSE_SEC_BE_SIZE 4
 
+#define EFUSE_VCORE_PWR_BE 0x17D6
+#define EFUSE_VCORE_PWR_BE_VALID BIT(12)
+#define EFUSE_VCORE_PWR_BE_VAL GENMASK(11, 0)
+#define SWR_DIG_MIN 860
+#define EFUSE_DIG_K_STEP 0xC
+#define EFUSE_DSWR_V0_86_BE 0x17DA
+#define EFUSE_DSWR_V0_86_BE_VALID BIT(5)
+#define EFUSE_DSWR_V0_86_BE_VAL GENMASK(4, 0)
+
 static const u32 sb_sel_mgn[SB_SEL_MGN_MAX_SIZE] = {
 	0x8000100, 0xC000180
 };
@@ -392,6 +401,17 @@ int rtw89_parse_efuse_map_be(struct rtw89_dev *rtwdev)
 		goto out_free;
 	}
 
+	if (rtwdev->chip->chip_id != RTL8922D)
+		goto out_free;
+
+	ret = rtw89_parse_logical_efuse_block_be(rtwdev, phy_map, phy_size,
+						 RTW89_EFUSE_BLOCK_SYS);
+	if (ret) {
+		rtw89_warn(rtwdev, "failed to parse efuse logic block %d\n",
+			   RTW89_EFUSE_BLOCK_SYS);
+		goto out_free;
+	}
+
 out_free:
 	kfree(dav_phy_map);
 	kfree(phy_map);
@@ -566,3 +586,70 @@ int rtw89_efuse_read_thermal_k_be(struct rtw89_dev *rtwdev)
 
 	return 0;
 }
+
+static int rtw89_efuse_read_pwr_data_vcore_be(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_efuse *efuse = &rtwdev->efuse;
+	u32 dump_addr;
+	u8 buff[4]; /* efuse access must 4 bytes align */
+	u16 val16;
+	int ret;
+
+	dump_addr = ALIGN_DOWN(EFUSE_VCORE_PWR_BE, 4);
+
+	ret = rtw89_dump_physical_efuse_map_be(rtwdev, buff, dump_addr, 4, false);
+	if (ret)
+		return ret;
+
+	val16 = buff[EFUSE_VCORE_PWR_BE - dump_addr] |
+		buff[EFUSE_VCORE_PWR_BE - dump_addr + 1] << 8;
+
+	if (val16 & EFUSE_VCORE_PWR_BE_VALID)
+		return 0;
+
+	efuse->vcore_valid = true;
+	efuse->vcore_vmax_reduce =
+		(u16_get_bits(val16, EFUSE_VCORE_PWR_BE_VAL) - SWR_DIG_MIN) /
+		EFUSE_DIG_K_STEP;
+
+	return 0;
+}
+
+static int rtw89_efuse_read_pwr_data_dswr_be(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_efuse *efuse = &rtwdev->efuse;
+	u32 dump_addr;
+	u8 buff[4]; /* efuse access must 4 bytes align */
+	u8 val8;
+	int ret;
+
+	dump_addr = ALIGN_DOWN(EFUSE_DSWR_V0_86_BE, 4);
+
+	ret = rtw89_dump_physical_efuse_map_be(rtwdev, buff, dump_addr, 4, false);
+	if (ret)
+		return ret;
+
+	val8 = buff[EFUSE_DSWR_V0_86_BE - dump_addr];
+
+	if (val8 & EFUSE_DSWR_V0_86_BE_VALID)
+		return 0;
+
+	efuse->dswr_valid = true;
+	efuse->dswr_vmin = u8_get_bits(val8, EFUSE_DSWR_V0_86_BE_VAL);
+
+	return 0;
+}
+
+int rtw89_efuse_read_pwr_data_be(struct rtw89_dev *rtwdev)
+{
+	int ret;
+
+	if (rtwdev->chip->chip_id != RTL8922D)
+		return 0;
+
+	ret = rtw89_efuse_read_pwr_data_vcore_be(rtwdev);
+	if (ret)
+		return ret;
+
+	return rtw89_efuse_read_pwr_data_dswr_be(rtwdev);
+}
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 3d3f683046a7..f5e55e6be119 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1559,6 +1559,7 @@ static int rtw89_mac_power_switch(struct rtw89_dev *rtwdev, bool on)
 			rtw89_mac_efuse_read_ecv(rtwdev);
 			mac->efuse_read_fw_secure(rtwdev);
 			rtw89_mac_efuse_read_thermal_k(rtwdev);
+			rtw89_mac_efuse_read_pwr_data(rtwdev);
 		}
 
 		set_bit(RTW89_FLAG_POWERON, rtwdev->flags);
@@ -7502,6 +7503,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_ax = {
 	.efuse_read_fw_secure = rtw89_efuse_read_fw_secure_ax,
 	.efuse_read_ecv = NULL,
 	.efuse_read_thermal_k = NULL,
+	.efuse_read_pwr_data = NULL,
 
 	.cfg_plt = rtw89_mac_cfg_plt_ax,
 	.get_plt_cnt = rtw89_mac_get_plt_cnt_ax,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 7256d64ea07f..8bbe49492d4c 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1133,6 +1133,7 @@ struct rtw89_mac_gen_def {
 	int (*efuse_read_fw_secure)(struct rtw89_dev *rtwdev);
 	int (*efuse_read_ecv)(struct rtw89_dev *rtwdev);
 	int (*efuse_read_thermal_k)(struct rtw89_dev *rtwdev);
+	int (*efuse_read_pwr_data)(struct rtw89_dev *rtwdev);
 
 	int (*cfg_plt)(struct rtw89_dev *rtwdev, struct rtw89_mac_ax_plt *plt);
 	u16 (*get_plt_cnt)(struct rtw89_dev *rtwdev, u8 band);
@@ -1746,6 +1747,16 @@ static inline int rtw89_mac_efuse_read_thermal_k(struct rtw89_dev *rtwdev)
 	return mac->efuse_read_thermal_k(rtwdev);
 }
 
+static inline int rtw89_mac_efuse_read_pwr_data(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+
+	if (!mac->efuse_read_pwr_data)
+		return -ENOENT;
+
+	return mac->efuse_read_pwr_data(rtwdev);
+}
+
 static inline
 void rtw89_mac_fwdl_preconfig(struct rtw89_dev *rtwdev)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 077ddf4f77c5..0fe317929b1b 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -3313,6 +3313,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_be = {
 	.efuse_read_fw_secure = rtw89_efuse_read_fw_secure_be,
 	.efuse_read_ecv = rtw89_efuse_read_ecv_be,
 	.efuse_read_thermal_k = rtw89_efuse_read_thermal_k_be,
+	.efuse_read_pwr_data = rtw89_efuse_read_pwr_data_be,
 
 	.cfg_plt = rtw89_mac_cfg_plt_be,
 	.get_plt_cnt = rtw89_mac_get_plt_cnt_be,
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 3908f9729736..72f7b80fe1fb 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -4573,6 +4573,23 @@
 #define R_BE_UDM2 0x01F8
 #define B_BE_UDM2_EPC_RA_MASK GENMASK(31, 0)
 
+#define R_BE_SPS_DIG_ON_CTRL0 0x0200
+#define B_BE_PFMCMP_IQ BIT(31)
+#define B_BE_FREQ_MASK GENMASK(30, 27)
+#define B_BE_OFF_END_SEL BIT(26)
+#define B_BE_POW_MINOFF_L BIT(25)
+#define B_BE_REG_BYPASS_L BIT(24)
+#define B_BE_VREFPFM_L_MASK GENMASK(23, 19)
+#define B_BE_REG_ZCDC_H_MASK GENMASK(18, 17)
+#define B_BE_FORCE_ZCD_BIAS BIT(16)
+#define B_BE_ZCD_SDZ_L_MASK GENMASK(15, 14)
+#define B_BE_ISAW_MASK GENMASK(13, 10)
+#define B_BE_SS_DIVSEL_MASK GENMASK(9, 8)
+#define B_BE_REG_BG_H BIT(7)
+#define B_BE_FPWM_L1 BIT(6)
+#define B_BE_POW_ZCD_L BIT(5)
+#define B_BE_PWMTUNE_MASK GENMASK(4, 0)
+
 #define R_BE_SPS_DIG_ON_CTRL1 0x0204
 #define B_BE_SN_N_L_MASK GENMASK(31, 28)
 #define B_BE_SP_N_L_MASK GENMASK(27, 24)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d.c b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
index 8b91c552a309..a6693c8413d5 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
@@ -881,6 +881,28 @@ static int rtw8922d_read_efuse_rf(struct rtw89_dev *rtwdev, u8 *log_map)
 	return 0;
 }
 
+static int rtw8922d_read_sys(struct rtw89_dev *rtwdev, u8 *log_map)
+{
+	struct rtw89_efuse *efuse = &rtwdev->efuse;
+	struct rtw89_hal *hal = &rtwdev->hal;
+	u16 digk;
+	u8 vmin;
+
+	digk = log_map[0x200] | log_map[0x201] << 8;
+	hal->thermal_prot_vmax = u16_get_bits(digk, B_BE_PWMTUNE_MASK);
+
+	if (efuse->dswr_valid)
+		vmin = efuse->dswr_vmin;
+	else if (efuse->vcore_valid)
+		vmin = hal->thermal_prot_vmax - efuse->vcore_vmax_reduce;
+	else
+		vmin = hal->thermal_prot_vmax - 3;
+
+	hal->thermal_prot_vmin = vmin;
+
+	return 0;
+}
+
 static int rtw8922d_read_efuse(struct rtw89_dev *rtwdev, u8 *log_map,
 			       enum rtw89_efuse_block block)
 {
@@ -891,6 +913,8 @@ static int rtw8922d_read_efuse(struct rtw89_dev *rtwdev, u8 *log_map,
 		return rtw8922d_read_efuse_usb(rtwdev, log_map);
 	case RTW89_EFUSE_BLOCK_RF:
 		return rtw8922d_read_efuse_rf(rtwdev, log_map);
+	case RTW89_EFUSE_BLOCK_SYS:
+		return rtw8922d_read_sys(rtwdev, log_map);
 	default:
 		return 0;
 	}
-- 
2.25.1


