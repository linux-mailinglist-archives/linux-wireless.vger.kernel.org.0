Return-Path: <linux-wireless+bounces-33676-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPmPMQyzwGm5KAQAu9opvQ
	(envelope-from <linux-wireless+bounces-33676-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 04:27:08 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8592EC33E
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 04:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14832300CE59
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 03:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BB514A8B;
	Mon, 23 Mar 2026 03:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Bm+L5V+j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722871514F8
	for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2026 03:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774236399; cv=none; b=WiFtXsFhJ5fKmuyGluuqUexQKkY4/DkH9JAr+A/bHyO3sOq6YSd2w12W26vrOVb6fl7PRLdZhujkfv5jrjDbUy5Jg9ulpVhJ8ZBLpss6kAN2wot32ELDpHbV4G8eje9q/hFvI0b4O93KbPM1IG+D9bBjVbhwWOUSnQiIexWmHe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774236399; c=relaxed/simple;
	bh=EwNA612C5mE/b5q4pE+BFq6bwo7GNlLbQId70Ek5H8Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oSEMsLoewctUYNGaCLdC7zd35EWiFrhwkuPO13DKxjv4FVF/sGr+ra5cPmE4E70BaIdWJAIvT04hKF2RjO5y/DUn6VNtoUVh8FyaU4niN2lAkoMXp/C5CKAREO6QDvqyXA89gGdJmYAtreukY34WQFD9d14iPLbz6Y3OvLTuO88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Bm+L5V+j; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62N3QY2802375626, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774236394; bh=DC2DXgH3FiXcbDWsdbNWxX30N19JTVtMDYx3FLeGYS0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Bm+L5V+jKqGV1x8B/wCsEzmxyvYJGTbZq9RHh7rDNnI6pbsPQ/uU/E72xSJHZbMj0
	 7GT43PcYlluKpSet5uME8HyUrKHql13DU80JPlmhVD482wGQQjDSdOHi/3RuqwEEg2
	 U+6o1vaoDaZJ2Z7Qz54+6n9PwLUkVezB0MvWrNITd1qcg4aETMctcGtCjCHXJp62I/
	 qNff/jS/uM3Brr6pltKjf57AiwaztpME7s6skGWoF50Gl5ciQV3XgzCavWewBP921D
	 gLbTJ/DUUEvzrL8frVKnHYjFlqfYAYcSBt49MoSgxi/XA4ZxYMRCzr9BMIgX8vrggy
	 diqueo0ekL7hA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62N3QY2802375626
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2026 11:26:34 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 23 Mar 2026 11:26:35 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 23 Mar 2026 11:26:35 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 23 Mar 2026 11:26:35 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 4/7] wifi: rtw89: 8922d: read and configure RF by calibration data from efuse physical map
Date: Mon, 23 Mar 2026 11:25:53 +0800
Message-ID: <20260323032556.19825-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260323032556.19825-1-pkshih@realtek.com>
References: <20260323032556.19825-1-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33676-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:dkim,realtek.com:email,realtek.com:mid];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4F8592EC33E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The calibration data is from physical map, including 1) thermal trim to
align output thermal value across chips, and 2) PA bias to transmit
expected power by controller.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |   2 +
 drivers/net/wireless/realtek/rtw89/reg.h      |   2 +
 drivers/net/wireless/realtek/rtw89/rtw8922d.c | 205 ++++++++++++++++++
 3 files changed, 209 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index d0ae3e15253b..cde46ed21d32 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5595,9 +5595,11 @@ struct rtw89_tssi_info {
 struct rtw89_power_trim_info {
 	bool pg_thermal_trim;
 	bool pg_pa_bias_trim;
+	bool pg_vco_trim;
 	u8 thermal_trim[RF_PATH_MAX];
 	u8 pa_bias_trim[RF_PATH_MAX];
 	u8 pad_bias_trim[RF_PATH_MAX];
+	u8 vco_trim[RF_PATH_MAX];
 };
 
 enum rtw89_regd_func {
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index b6fd7b434de9..179006c8e499 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -8517,6 +8517,7 @@
 #define RR_LUTWD0_LB GENMASK(5, 0)
 #define RR_TM 0x42
 #define RR_TM_TRI BIT(19)
+#define RR_TM_TRM GENMASK(17, 11)
 #define RR_TM_VAL_V1 GENMASK(7, 0)
 #define RR_TM_VAL GENMASK(6, 1)
 #define RR_TM2 0x43
@@ -8649,6 +8650,7 @@
 #define RR_LDO 0xb1
 #define RR_LDO_SEL GENMASK(8, 6)
 #define RR_VCO 0xb2
+#define RR_VCO_VAL GENMASK(18, 14)
 #define RR_VCO_SEL GENMASK(9, 8)
 #define RR_VCI 0xb3
 #define RR_VCI_ON BIT(7)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d.c b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
index 0ae34a4f8d79..cbe8e067ae55 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
@@ -630,6 +630,211 @@ static int rtw8922d_read_efuse(struct rtw89_dev *rtwdev, u8 *log_map,
 	}
 }
 
+static void rtw8922d_phycap_parsing_vco_trim(struct rtw89_dev *rtwdev,
+					     u8 *phycap_map)
+{
+	static const u32 vco_trim_addr[RF_PATH_NUM_8922D] = {0x175E, 0x175F};
+	struct rtw89_power_trim_info *info = &rtwdev->pwr_trim;
+	u32 addr = rtwdev->chip->phycap_addr;
+	const u32 vco_check_addr = 0x1700;
+	u8 val;
+
+	val = phycap_map[vco_check_addr - addr];
+	if (val & BIT(1))
+		return;
+
+	info->pg_vco_trim = true;
+
+	info->vco_trim[0] = u8_get_bits(phycap_map[vco_trim_addr[0] - addr], GENMASK(4, 0));
+	info->vco_trim[1] = u8_get_bits(phycap_map[vco_trim_addr[1] - addr], GENMASK(4, 0));
+}
+
+static void rtw8922d_vco_trim(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_power_trim_info *info = &rtwdev->pwr_trim;
+
+	if (!info->pg_vco_trim)
+		return;
+
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_VCO, RR_VCO_VAL, info->vco_trim[0]);
+	rtw89_write_rf(rtwdev, RF_PATH_B, RR_VCO, RR_VCO_VAL, info->vco_trim[1]);
+}
+
+#define THM_TRIM_POSITIVE_MASK BIT(6)
+#define THM_TRIM_MAGNITUDE_MASK GENMASK(5, 0)
+#define THM_TRIM_MAX (15)
+#define THM_TRIM_MIN (-15)
+
+static void rtw8922d_phycap_parsing_thermal_trim(struct rtw89_dev *rtwdev,
+						 u8 *phycap_map)
+{
+	static const u32 thm_trim_addr[RF_PATH_NUM_8922D] = {0x1706, 0x1732};
+	struct rtw89_power_trim_info *info = &rtwdev->pwr_trim;
+	u32 addr = rtwdev->chip->phycap_addr;
+	bool pg = true;
+	u8 pg_th;
+	s8 val;
+	u8 i;
+
+	for (i = 0; i < RF_PATH_NUM_8922D; i++) {
+		pg_th = phycap_map[thm_trim_addr[i] - addr];
+		if (pg_th == 0xff) {
+			memset(info->thermal_trim, 0, sizeof(info->thermal_trim));
+			pg = false;
+			goto out;
+		}
+
+		val = u8_get_bits(pg_th, THM_TRIM_MAGNITUDE_MASK);
+
+		if (!(pg_th & THM_TRIM_POSITIVE_MASK))
+			val *= -1;
+
+		if (val <= THM_TRIM_MIN || val >= THM_TRIM_MAX) {
+			val = 0;
+			info->thermal_trim[i] = 0;
+		} else {
+			info->thermal_trim[i] = pg_th;
+		}
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[THERMAL][TRIM] path=%d thermal_trim=0x%x (%d)\n",
+			    i, pg_th, val);
+	}
+
+out:
+	info->pg_thermal_trim = pg;
+}
+
+static void rtw8922d_thermal_trim(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_power_trim_info *info = &rtwdev->pwr_trim;
+	u8 thermal;
+	int i;
+
+	for (i = 0; i < RF_PATH_NUM_8922D; i++) {
+		thermal = info->pg_thermal_trim ? info->thermal_trim[i] : 0;
+		rtw89_write_rf(rtwdev, i, RR_TM, RR_TM_TRM, thermal & 0x7f);
+	}
+}
+
+static void rtw8922d_phycap_parsing_pa_bias_trim(struct rtw89_dev *rtwdev,
+						 u8 *phycap_map)
+{
+	static const u32 pabias_trim_addr[RF_PATH_NUM_8922D] = {0x1707, 0x1733};
+	static const u32 check_pa_pad_trim_addr = 0x1700;
+	struct rtw89_power_trim_info *info = &rtwdev->pwr_trim;
+	u32 addr = rtwdev->chip->phycap_addr;
+	bool pg = true;
+	u8 val;
+	u8 i;
+
+	val = phycap_map[check_pa_pad_trim_addr - addr];
+	if (val == 0xff) {
+		pg = false;
+		goto out;
+	}
+
+	for (i = 0; i < RF_PATH_NUM_8922D; i++) {
+		info->pa_bias_trim[i] = phycap_map[pabias_trim_addr[i] - addr];
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[PA_BIAS][TRIM] path=%d pa_bias_trim=0x%x\n",
+			    i, info->pa_bias_trim[i]);
+	}
+
+out:
+	info->pg_pa_bias_trim = pg;
+}
+
+static void rtw8922d_pa_bias_trim(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_power_trim_info *info = &rtwdev->pwr_trim;
+	u8 pabias_2g, pabias_5g;
+	u8 i;
+
+	if (!info->pg_pa_bias_trim) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[PA_BIAS][TRIM] no PG, do nothing\n");
+
+		return;
+	}
+
+	for (i = 0; i < RF_PATH_NUM_8922D; i++) {
+		pabias_2g = FIELD_GET(GENMASK(3, 0), info->pa_bias_trim[i]);
+		pabias_5g = FIELD_GET(GENMASK(7, 4), info->pa_bias_trim[i]);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[PA_BIAS][TRIM] path=%d 2G=0x%x 5G=0x%x\n",
+			    i, pabias_2g, pabias_5g);
+
+		rtw89_write_rf(rtwdev, i, RR_BIASA, RR_BIASA_TXG_V1, pabias_2g);
+		rtw89_write_rf(rtwdev, i, RR_BIASA, RR_BIASA_TXA_V1, pabias_5g);
+	}
+}
+
+static void rtw8922d_phycap_parsing_pad_bias_trim(struct rtw89_dev *rtwdev,
+						  u8 *phycap_map)
+{
+	static const u32 pad_bias_trim_addr[RF_PATH_NUM_8922D] = {0x1708, 0x1734};
+	struct rtw89_power_trim_info *info = &rtwdev->pwr_trim;
+	u32 addr = rtwdev->chip->phycap_addr;
+	u8 i;
+
+	if (!info->pg_pa_bias_trim)
+		return;
+
+	for (i = 0; i < RF_PATH_NUM_8922D; i++) {
+		info->pad_bias_trim[i] = phycap_map[pad_bias_trim_addr[i] - addr];
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[PAD_BIAS][TRIM] path=%d pad_bias_trim=0x%x\n",
+			    i, info->pad_bias_trim[i]);
+	}
+}
+
+static void rtw8922d_pad_bias_trim(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_power_trim_info *info = &rtwdev->pwr_trim;
+	u8 pad_bias_2g, pad_bias_5g;
+	u8 i;
+
+	if (!info->pg_pa_bias_trim) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[PAD_BIAS][TRIM] no PG, do nothing\n");
+		return;
+	}
+
+	for (i = 0; i < RF_PATH_NUM_8922D; i++) {
+		pad_bias_2g = u8_get_bits(info->pad_bias_trim[i], GENMASK(3, 0));
+		pad_bias_5g = u8_get_bits(info->pad_bias_trim[i], GENMASK(7, 4));
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[PAD_BIAS][TRIM] path=%d 2G=0x%x 5G=0x%x\n",
+			    i, pad_bias_2g, pad_bias_5g);
+
+		rtw89_write_rf(rtwdev, i, RR_BIASA, RR_BIASD_TXG_V1, pad_bias_2g);
+		rtw89_write_rf(rtwdev, i, RR_BIASA, RR_BIASD_TXA_V1, pad_bias_5g);
+	}
+}
+
+static int rtw8922d_read_phycap(struct rtw89_dev *rtwdev, u8 *phycap_map)
+{
+	rtw8922d_phycap_parsing_vco_trim(rtwdev, phycap_map);
+	rtw8922d_phycap_parsing_thermal_trim(rtwdev, phycap_map);
+	rtw8922d_phycap_parsing_pa_bias_trim(rtwdev, phycap_map);
+	rtw8922d_phycap_parsing_pad_bias_trim(rtwdev, phycap_map);
+
+	return 0;
+}
+
+static void rtw8922d_power_trim(struct rtw89_dev *rtwdev)
+{
+	rtw8922d_vco_trim(rtwdev);
+	rtw8922d_thermal_trim(rtwdev);
+	rtw8922d_pa_bias_trim(rtwdev);
+	rtw8922d_pad_bias_trim(rtwdev);
+}
+
 MODULE_FIRMWARE(RTW8922D_MODULE_FIRMWARE);
 MODULE_FIRMWARE(RTW8922DS_MODULE_FIRMWARE);
 MODULE_AUTHOR("Realtek Corporation");
-- 
2.25.1


