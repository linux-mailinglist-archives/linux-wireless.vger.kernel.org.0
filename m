Return-Path: <linux-wireless+bounces-15165-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A22879C38AD
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 07:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61995280FE4
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 06:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED455155352;
	Mon, 11 Nov 2024 06:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="RdKDvVbK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466561487F4
	for <linux-wireless@vger.kernel.org>; Mon, 11 Nov 2024 06:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731307952; cv=none; b=euM/YoF7lMbbsCcOQMe+n7JXVxfKU2PTpCz58382N0MTQhRwSdrAWr9Din4FzYm3LasSFjITpfzLHmfHlgliAgEiV8Kx3qMBktLYBWaoKJCBQO0/95S6yZOJalsMpCQ0a0J6zk5NsjyIfb9id5KaDtxvJDC5UmN7d4Q6Gd2nKJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731307952; c=relaxed/simple;
	bh=773uAfMYq2zIzDIvs9X8ZrGp7PfYd8Q0ODCnKN9PflY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=boldDQ7M/H5K6qXZ4UPk8iW2WMmUyAAqZ7URawIj7w7mPSUpbp4/Cog+yEYjoN+k2XOqinZZYapN8sWeu8gT/hzSeJNbP+TZ7RObWKYvkjMp5BbGLGoqnPtJTsKLtQUT3oukenZ0BFqbJb0htO4G0UrGVPWNV+A7C80nIPaQAZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=RdKDvVbK; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AB6qRJa91779835, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731307947; bh=773uAfMYq2zIzDIvs9X8ZrGp7PfYd8Q0ODCnKN9PflY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=RdKDvVbKglqvZlP9xruI8XNzIjkggOxqf2DW5/sWJ6kSJFEvlt9qcNkauFbExxAiD
	 sRvLBXnwspo/CJDcSDl31cizPw1UqDBQ42MKEIH5avrFgtV5Ml/+/xTSVbvIN10Bjl
	 IVA62TRoEMMvWzw89UyqkI6/HYaWPhetNqnW933Dm1GoZnnYqXBU200l7aDp80XTQf
	 YKh4+QA3DsrIiVmPSODaacMWSo+Y5RkBLQA7aliRq5F0h+4MeLy0gy/u+aLsXMTUAN
	 T6QjNsEawUBuUsCiP1sfx4CgXKQAUxNCfBloW36Ty9c0Uutg8MuqGxFhetQI/PX9mq
	 tAFPhM3MfpXZQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AB6qRJa91779835
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 11 Nov 2024 14:52:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 11 Nov 2024 14:52:28 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 11 Nov
 2024 14:52:27 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>
Subject: [PATCH 2/3] wifi: rtw89: introduce dynamic antenna gain feature
Date: Mon, 11 Nov 2024 14:51:31 +0800
Message-ID: <20241111065132.19587-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241111065132.19587-1-pkshih@realtek.com>
References: <20241111065132.19587-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

From: Kuan-Chung Chen <damon.chen@realtek.com>

Dynamic Antenna Gain (DAG) adjusts the transmit power based on the
platform's antenna gain. This allows for higher transmit power when
the antenna gain is lower, while still complying with regulatory
limits. The driver reads the Realtek Antenna Gain (RTAG) data from
BIOS, and DAG is only enabled when the regulatory domain allows it.
Currently, it only supports 8852BE/8852BTE/8852CE.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/acpi.c     |  47 ++++
 drivers/net/wireless/realtek/rtw89/acpi.h     |   9 +
 drivers/net/wireless/realtek/rtw89/core.c     |   3 +
 drivers/net/wireless/realtek/rtw89/core.h     |  33 +++
 drivers/net/wireless/realtek/rtw89/debug.c    |   4 +
 drivers/net/wireless/realtek/rtw89/phy.c      | 216 +++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/phy.h      |   3 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |   1 +
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |   1 +
 13 files changed, 317 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/acpi.c b/drivers/net/wireless/realtek/rtw89/acpi.c
index 908e980a4b72..f5dedb12c129 100644
--- a/drivers/net/wireless/realtek/rtw89/acpi.c
+++ b/drivers/net/wireless/realtek/rtw89/acpi.c
@@ -148,3 +148,50 @@ int rtw89_acpi_evaluate_dsm(struct rtw89_dev *rtwdev,
 	ACPI_FREE(obj);
 	return ret;
 }
+
+int rtw89_acpi_evaluate_rtag(struct rtw89_dev *rtwdev,
+			     struct rtw89_acpi_rtag_result *res)
+{
+	struct acpi_buffer buf = {ACPI_ALLOCATE_BUFFER, NULL};
+	acpi_handle root, handle;
+	union acpi_object *obj;
+	acpi_status status;
+	u32 buf_len;
+	int ret = 0;
+
+	root = ACPI_HANDLE(rtwdev->dev);
+	if (!root)
+		return -EOPNOTSUPP;
+
+	status = acpi_get_handle(root, (acpi_string)"RTAG", &handle);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	status = acpi_evaluate_object(handle, NULL, NULL, &buf);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	obj = buf.pointer;
+	if (obj->type != ACPI_TYPE_BUFFER) {
+		rtw89_debug(rtwdev, RTW89_DBG_ACPI,
+			    "acpi: expect buffer but type: %d\n", obj->type);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	buf_len = obj->buffer.length;
+	if (buf_len != sizeof(*res)) {
+		rtw89_debug(rtwdev, RTW89_DBG_ACPI, "%s: invalid buffer length: %u\n",
+			    __func__, buf_len);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	*res = *(struct rtw89_acpi_rtag_result *)obj->buffer.pointer;
+
+	rtw89_hex_dump(rtwdev, RTW89_DBG_ACPI, "antenna_gain: ", res, sizeof(*res));
+
+out:
+	ACPI_FREE(obj);
+	return ret;
+}
diff --git a/drivers/net/wireless/realtek/rtw89/acpi.h b/drivers/net/wireless/realtek/rtw89/acpi.h
index d274be1775bf..b43ab106e44d 100644
--- a/drivers/net/wireless/realtek/rtw89/acpi.h
+++ b/drivers/net/wireless/realtek/rtw89/acpi.h
@@ -63,8 +63,17 @@ struct rtw89_acpi_dsm_result {
 	} u;
 };
 
+struct rtw89_acpi_rtag_result {
+	u8 tag[4];
+	u8 revision;
+	__le32 domain;
+	u8 ant_gain_table[RTW89_ANT_GAIN_CHAIN_NUM][RTW89_ANT_GAIN_SUBBAND_NR];
+} __packed;
+
 int rtw89_acpi_evaluate_dsm(struct rtw89_dev *rtwdev,
 			    enum rtw89_acpi_dsm_func func,
 			    struct rtw89_acpi_dsm_result *res);
+int rtw89_acpi_evaluate_rtag(struct rtw89_dev *rtwdev,
+			     struct rtw89_acpi_rtag_result *res);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index f73704fc5f85..34034f44c050 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -211,6 +211,8 @@ static const struct ieee80211_iface_combination rtw89_iface_combs[] = {
 	[RTW89_6GHZ_SPAN_IDX(center_freq)] = { \
 		.sar_subband_low = RTW89_SAR_6GHZ_ ## subband_l, \
 		.sar_subband_high = RTW89_SAR_6GHZ_ ## subband_h, \
+		.ant_gain_subband_low = RTW89_ANT_GAIN_6GHZ_ ## subband_l, \
+		.ant_gain_subband_high = RTW89_ANT_GAIN_6GHZ_ ## subband_h, \
 	}
 
 /* Since 6GHz subbands are not edge aligned, some cases span two subbands.
@@ -4802,6 +4804,7 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
 	rtw89_ser_init(rtwdev);
 	rtw89_entity_init(rtwdev);
 	rtw89_tas_init(rtwdev);
+	rtw89_phy_ant_gain_init(rtwdev);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index f76c05513d3c..bf7aff426896 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4255,6 +4255,7 @@ struct rtw89_chip_info {
 	u16 support_bandwidths;
 	bool support_unii4;
 	bool support_rnr;
+	bool support_ant_gain;
 	bool ul_tb_waveform_ctrl;
 	bool ul_tb_pwr_diff;
 	bool hw_sec_hdr;
@@ -4597,12 +4598,43 @@ struct rtw89_sar_info {
 	};
 };
 
+enum rtw89_ant_gain_subband {
+	RTW89_ANT_GAIN_2GHZ_SUBBAND,
+	RTW89_ANT_GAIN_5GHZ_SUBBAND_1,   /* U-NII-1 */
+	RTW89_ANT_GAIN_5GHZ_SUBBAND_2,   /* U-NII-2 */
+	RTW89_ANT_GAIN_5GHZ_SUBBAND_2E,  /* U-NII-2-Extended */
+	RTW89_ANT_GAIN_5GHZ_SUBBAND_3_4, /* U-NII-3 and U-NII-4 */
+	RTW89_ANT_GAIN_6GHZ_SUBBAND_5_L, /* U-NII-5 lower part */
+	RTW89_ANT_GAIN_6GHZ_SUBBAND_5_H, /* U-NII-5 higher part */
+	RTW89_ANT_GAIN_6GHZ_SUBBAND_6,   /* U-NII-6 */
+	RTW89_ANT_GAIN_6GHZ_SUBBAND_7_L, /* U-NII-7 lower part */
+	RTW89_ANT_GAIN_6GHZ_SUBBAND_7_H, /* U-NII-7 higher part */
+	RTW89_ANT_GAIN_6GHZ_SUBBAND_8,   /* U-NII-8 */
+
+	RTW89_ANT_GAIN_SUBBAND_NR,
+};
+
+enum rtw89_ant_gain_domain_type {
+	RTW89_ANT_GAIN_ETSI = 0,
+
+	RTW89_ANT_GAIN_DOMAIN_NUM,
+};
+
+#define RTW89_ANT_GAIN_CHAIN_NUM 2
+struct rtw89_ant_gain_info {
+	s8 offset[RTW89_ANT_GAIN_CHAIN_NUM][RTW89_ANT_GAIN_SUBBAND_NR];
+	u32 regd_enabled;
+};
+
 struct rtw89_6ghz_span {
 	enum rtw89_sar_subband sar_subband_low;
 	enum rtw89_sar_subband sar_subband_high;
+	enum rtw89_ant_gain_subband ant_gain_subband_low;
+	enum rtw89_ant_gain_subband ant_gain_subband_high;
 };
 
 #define RTW89_SAR_SPAN_VALID(span) ((span)->sar_subband_high)
+#define RTW89_ANT_GAIN_SPAN_VALID(span) ((span)->ant_gain_subband_high)
 
 enum rtw89_tas_state {
 	RTW89_TAS_STATE_DPR_OFF,
@@ -5643,6 +5675,7 @@ struct rtw89_dev {
 	struct rtw89_regulatory_info regulatory;
 	struct rtw89_sar_info sar;
 	struct rtw89_tas_info tas;
+	struct rtw89_ant_gain_info ant_gain;
 
 	struct rtw89_btc btc;
 	enum rtw89_ps_mode ps_mode;
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 6abd88fa80ba..fd86752d86f3 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -9,6 +9,7 @@
 #include "fw.h"
 #include "mac.h"
 #include "pci.h"
+#include "phy.h"
 #include "ps.h"
 #include "reg.h"
 #include "sar.h"
@@ -882,6 +883,9 @@ static int rtw89_debug_priv_txpwr_table_get(struct seq_file *m, void *v)
 	seq_puts(m, "[TAS]\n");
 	rtw89_print_tas(m, rtwdev);
 
+	seq_puts(m, "[DAG]\n");
+	rtw89_print_ant_gain(m, rtwdev, chan);
+
 	tbl = dbgfs_txpwr_tables[chip_gen];
 	if (!tbl) {
 		ret = -EOPNOTSUPP;
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index f24aca663cf0..e9a635c43a81 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2019-2020  Realtek Corporation
  */
 
+#include "acpi.h"
 #include "chan.h"
 #include "coex.h"
 #include "debug.h"
@@ -1854,6 +1855,211 @@ void rtw89_phy_write_reg3_tbl(struct rtw89_dev *rtwdev,
 }
 EXPORT_SYMBOL(rtw89_phy_write_reg3_tbl);
 
+static u8 rtw89_phy_ant_gain_domain_to_regd(struct rtw89_dev *rtwdev, u8 ant_gain_regd)
+{
+	switch (ant_gain_regd) {
+	case RTW89_ANT_GAIN_ETSI:
+		return RTW89_ETSI;
+	default:
+		rtw89_debug(rtwdev, RTW89_DBG_TXPWR,
+			    "unknown antenna gain domain: %d\n",
+			    ant_gain_regd);
+		return RTW89_REGD_NUM;
+	}
+}
+
+/* antenna gain in unit of 0.25 dbm */
+#define RTW89_ANT_GAIN_2GHZ_MIN -8
+#define RTW89_ANT_GAIN_2GHZ_MAX 14
+#define RTW89_ANT_GAIN_5GHZ_MIN -8
+#define RTW89_ANT_GAIN_5GHZ_MAX 20
+#define RTW89_ANT_GAIN_6GHZ_MIN -8
+#define RTW89_ANT_GAIN_6GHZ_MAX 20
+
+#define RTW89_ANT_GAIN_REF_2GHZ 14
+#define RTW89_ANT_GAIN_REF_5GHZ 20
+#define RTW89_ANT_GAIN_REF_6GHZ 20
+
+void rtw89_phy_ant_gain_init(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_ant_gain_info *ant_gain = &rtwdev->ant_gain;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct rtw89_acpi_rtag_result res = {};
+	u32 domain;
+	int ret;
+	u8 i, j;
+	u8 regd;
+	u8 val;
+
+	if (!chip->support_ant_gain)
+		return;
+
+	ret = rtw89_acpi_evaluate_rtag(rtwdev, &res);
+	if (ret) {
+		rtw89_debug(rtwdev, RTW89_DBG_TXPWR,
+			    "acpi: cannot eval rtag: %d\n", ret);
+		return;
+	}
+
+	if (res.revision != 0) {
+		rtw89_debug(rtwdev, RTW89_DBG_TXPWR,
+			    "unknown rtag revision: %d\n", res.revision);
+		return;
+	}
+
+	domain = get_unaligned_le32(&res.domain);
+
+	for (i = 0; i < RTW89_ANT_GAIN_DOMAIN_NUM; i++) {
+		if (!(domain & BIT(i)))
+			continue;
+
+		regd = rtw89_phy_ant_gain_domain_to_regd(rtwdev, i);
+		if (regd >= RTW89_REGD_NUM)
+			continue;
+		ant_gain->regd_enabled |= BIT(regd);
+	}
+
+	for (i = 0; i < RTW89_ANT_GAIN_CHAIN_NUM; i++) {
+		for (j = 0; j < RTW89_ANT_GAIN_SUBBAND_NR; j++) {
+			val = res.ant_gain_table[i][j];
+			switch (j) {
+			default:
+			case RTW89_ANT_GAIN_2GHZ_SUBBAND:
+				val = RTW89_ANT_GAIN_REF_2GHZ -
+				      clamp_t(s8, val,
+					      RTW89_ANT_GAIN_2GHZ_MIN,
+					      RTW89_ANT_GAIN_2GHZ_MAX);
+				break;
+			case RTW89_ANT_GAIN_5GHZ_SUBBAND_1:
+			case RTW89_ANT_GAIN_5GHZ_SUBBAND_2:
+			case RTW89_ANT_GAIN_5GHZ_SUBBAND_2E:
+			case RTW89_ANT_GAIN_5GHZ_SUBBAND_3_4:
+				val = RTW89_ANT_GAIN_REF_5GHZ -
+				      clamp_t(s8, val,
+					      RTW89_ANT_GAIN_5GHZ_MIN,
+					      RTW89_ANT_GAIN_5GHZ_MAX);
+				break;
+			case RTW89_ANT_GAIN_6GHZ_SUBBAND_5_L:
+			case RTW89_ANT_GAIN_6GHZ_SUBBAND_5_H:
+			case RTW89_ANT_GAIN_6GHZ_SUBBAND_6:
+			case RTW89_ANT_GAIN_6GHZ_SUBBAND_7_L:
+			case RTW89_ANT_GAIN_6GHZ_SUBBAND_7_H:
+			case RTW89_ANT_GAIN_6GHZ_SUBBAND_8:
+				val = RTW89_ANT_GAIN_REF_6GHZ -
+				      clamp_t(s8, val,
+					      RTW89_ANT_GAIN_6GHZ_MIN,
+					      RTW89_ANT_GAIN_6GHZ_MAX);
+			}
+			ant_gain->offset[i][j] = val;
+		}
+	}
+}
+
+static
+enum rtw89_ant_gain_subband rtw89_phy_ant_gain_get_subband(struct rtw89_dev *rtwdev,
+							   u32 center_freq)
+{
+	switch (center_freq) {
+	default:
+		rtw89_debug(rtwdev, RTW89_DBG_TXPWR,
+			    "center freq: %u to antenna gain subband is unhandled\n",
+			    center_freq);
+		fallthrough;
+	case 2412 ... 2484:
+		return RTW89_ANT_GAIN_2GHZ_SUBBAND;
+	case 5180 ... 5240:
+		return RTW89_ANT_GAIN_5GHZ_SUBBAND_1;
+	case 5250 ... 5320:
+		return RTW89_ANT_GAIN_5GHZ_SUBBAND_2;
+	case 5500 ... 5720:
+		return RTW89_ANT_GAIN_5GHZ_SUBBAND_2E;
+	case 5745 ... 5885:
+		return RTW89_ANT_GAIN_5GHZ_SUBBAND_3_4;
+	case 5955 ... 6155:
+		return RTW89_ANT_GAIN_6GHZ_SUBBAND_5_L;
+	case 6175 ... 6415:
+		return RTW89_ANT_GAIN_6GHZ_SUBBAND_5_H;
+	case 6435 ... 6515:
+		return RTW89_ANT_GAIN_6GHZ_SUBBAND_6;
+	case 6535 ... 6695:
+		return RTW89_ANT_GAIN_6GHZ_SUBBAND_7_L;
+	case 6715 ... 6855:
+		return RTW89_ANT_GAIN_6GHZ_SUBBAND_7_H;
+
+	/* freq 6875 (ch 185, 20MHz) spans RTW89_ANT_GAIN_6GHZ_SUBBAND_7_H
+	 * and RTW89_ANT_GAIN_6GHZ_SUBBAND_8, so directly describe it with
+	 * struct rtw89_6ghz_span.
+	 */
+
+	case 6895 ... 7115:
+		return RTW89_ANT_GAIN_6GHZ_SUBBAND_8;
+	}
+}
+
+static s8 rtw89_phy_ant_gain_query(struct rtw89_dev *rtwdev,
+				   enum rtw89_rf_path path, u32 center_freq)
+{
+	struct rtw89_ant_gain_info *ant_gain = &rtwdev->ant_gain;
+	enum rtw89_ant_gain_subband subband_l, subband_h;
+	const struct rtw89_6ghz_span *span;
+
+	span = rtw89_get_6ghz_span(rtwdev, center_freq);
+
+	if (span && RTW89_ANT_GAIN_SPAN_VALID(span)) {
+		subband_l = span->ant_gain_subband_low;
+		subband_h = span->ant_gain_subband_high;
+	} else {
+		subband_l = rtw89_phy_ant_gain_get_subband(rtwdev, center_freq);
+		subband_h = subband_l;
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_TXPWR,
+		    "center_freq %u: antenna gain subband {%u, %u}\n",
+		    center_freq, subband_l, subband_h);
+
+	return min(ant_gain->offset[path][subband_l],
+		   ant_gain->offset[path][subband_h]);
+}
+
+static s8 rtw89_phy_ant_gain_offset(struct rtw89_dev *rtwdev, u8 band, u32 center_freq)
+{
+	struct rtw89_ant_gain_info *ant_gain = &rtwdev->ant_gain;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	u8 regd = rtw89_regd_get(rtwdev, band);
+	s8 offset_patha, offset_pathb;
+
+	if (!chip->support_ant_gain)
+		return 0;
+
+	if (!(ant_gain->regd_enabled & BIT(regd)))
+		return 0;
+
+	offset_patha = rtw89_phy_ant_gain_query(rtwdev, RF_PATH_A, center_freq);
+	offset_pathb = rtw89_phy_ant_gain_query(rtwdev, RF_PATH_B, center_freq);
+
+	return max(offset_patha, offset_pathb);
+}
+
+void rtw89_print_ant_gain(struct seq_file *m, struct rtw89_dev *rtwdev,
+			  const struct rtw89_chan *chan)
+{
+	struct rtw89_ant_gain_info *ant_gain = &rtwdev->ant_gain;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	u8 regd = rtw89_regd_get(rtwdev, chan->band_type);
+	s8 offset_patha, offset_pathb;
+
+	if (!chip->support_ant_gain || !(ant_gain->regd_enabled & BIT(regd))) {
+		seq_puts(m, "no DAG is applied\n");
+		return;
+	}
+
+	offset_patha = rtw89_phy_ant_gain_query(rtwdev, RF_PATH_A, chan->freq);
+	offset_pathb = rtw89_phy_ant_gain_query(rtwdev, RF_PATH_B, chan->freq);
+
+	seq_printf(m, "ChainA offset: %d dBm\n", offset_patha);
+	seq_printf(m, "ChainB offset: %d dBm\n", offset_pathb);
+}
+
 static const u8 rtw89_rs_idx_num_ax[] = {
 	[RTW89_RS_CCK] = RTW89_RATE_CCK_NUM,
 	[RTW89_RS_OFDM] = RTW89_RATE_OFDM_NUM,
@@ -2027,7 +2233,7 @@ s8 rtw89_phy_read_txpwr_limit(struct rtw89_dev *rtwdev, u8 band,
 	u8 ch_idx = rtw89_channel_to_idx(rtwdev, band, ch);
 	u8 regd = rtw89_regd_get(rtwdev, band);
 	u8 reg6 = regulatory->reg_6ghz_power;
-	s8 lmt = 0, sar;
+	s8 lmt = 0, sar, offset;
 	s8 cstr;
 
 	switch (band) {
@@ -2059,7 +2265,8 @@ s8 rtw89_phy_read_txpwr_limit(struct rtw89_dev *rtwdev, u8 band,
 		return 0;
 	}
 
-	lmt = rtw89_phy_txpwr_rf_to_mac(rtwdev, lmt);
+	offset = rtw89_phy_ant_gain_offset(rtwdev, band, freq);
+	lmt = rtw89_phy_txpwr_rf_to_mac(rtwdev, lmt + offset);
 	sar = rtw89_query_sar(rtwdev, freq);
 	cstr = rtw89_phy_get_tpe_constraint(rtwdev, band);
 
@@ -2286,7 +2493,7 @@ s8 rtw89_phy_read_txpwr_limit_ru(struct rtw89_dev *rtwdev, u8 band,
 	u8 ch_idx = rtw89_channel_to_idx(rtwdev, band, ch);
 	u8 regd = rtw89_regd_get(rtwdev, band);
 	u8 reg6 = regulatory->reg_6ghz_power;
-	s8 lmt_ru = 0, sar;
+	s8 lmt_ru = 0, sar, offset;
 	s8 cstr;
 
 	switch (band) {
@@ -2318,7 +2525,8 @@ s8 rtw89_phy_read_txpwr_limit_ru(struct rtw89_dev *rtwdev, u8 band,
 		return 0;
 	}
 
-	lmt_ru = rtw89_phy_txpwr_rf_to_mac(rtwdev, lmt_ru);
+	offset = rtw89_phy_ant_gain_offset(rtwdev, band, freq);
+	lmt_ru = rtw89_phy_txpwr_rf_to_mac(rtwdev, lmt_ru + offset);
 	sar = rtw89_query_sar(rtwdev, freq);
 	cstr = rtw89_phy_get_tpe_constraint(rtwdev, band);
 
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index c683f4d7d29b..2720cabfafe4 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -826,6 +826,9 @@ s8 *rtw89_phy_raw_byr_seek(struct rtw89_dev *rtwdev,
 			   const struct rtw89_rate_desc *desc);
 s8 rtw89_phy_read_txpwr_byrate(struct rtw89_dev *rtwdev, u8 band, u8 bw,
 			       const struct rtw89_rate_desc *rate_desc);
+void rtw89_phy_ant_gain_init(struct rtw89_dev *rtwdev);
+void rtw89_print_ant_gain(struct seq_file *m, struct rtw89_dev *rtwdev,
+			  const struct rtw89_chan *chan);
 void rtw89_phy_load_txpwr_byrate(struct rtw89_dev *rtwdev,
 				 const struct rtw89_txpwr_table *tbl);
 s8 rtw89_phy_read_txpwr_limit(struct rtw89_dev *rtwdev, u8 band,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 68c67a763f4d..29c697a251d3 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2479,6 +2479,7 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 				  BIT(NL80211_CHAN_WIDTH_40) |
 				  BIT(NL80211_CHAN_WIDTH_80),
 	.support_unii4		= true,
+	.support_ant_gain	= false,
 	.ul_tb_waveform_ctrl	= true,
 	.ul_tb_pwr_diff		= false,
 	.hw_sec_hdr		= false,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index e647759ebd69..fd59ee9f3626 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2196,6 +2196,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 				  BIT(NL80211_CHAN_WIDTH_40) |
 				  BIT(NL80211_CHAN_WIDTH_80),
 	.support_unii4		= false,
+	.support_ant_gain	= false,
 	.ul_tb_waveform_ctrl	= false,
 	.ul_tb_pwr_diff		= false,
 	.hw_sec_hdr		= false,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 49a319128316..76667d4f3631 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -834,6 +834,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 				  BIT(NL80211_CHAN_WIDTH_40) |
 				  BIT(NL80211_CHAN_WIDTH_80),
 	.support_unii4		= true,
+	.support_ant_gain	= true,
 	.ul_tb_waveform_ctrl	= true,
 	.ul_tb_pwr_diff		= false,
 	.hw_sec_hdr		= false,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index 876725133228..d8c0fb87b625 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -767,6 +767,7 @@ const struct rtw89_chip_info rtw8852bt_chip_info = {
 				  BIT(NL80211_CHAN_WIDTH_40) |
 				  BIT(NL80211_CHAN_WIDTH_80),
 	.support_unii4		= true,
+	.support_ant_gain	= true,
 	.ul_tb_waveform_ctrl	= true,
 	.ul_tb_pwr_diff		= false,
 	.hw_sec_hdr		= false,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index cde34f8e1e67..b63971010751 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2976,6 +2976,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 				  BIT(NL80211_CHAN_WIDTH_80) |
 				  BIT(NL80211_CHAN_WIDTH_160),
 	.support_unii4		= true,
+	.support_ant_gain	= true,
 	.ul_tb_waveform_ctrl	= false,
 	.ul_tb_pwr_diff		= true,
 	.hw_sec_hdr		= true,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 9a4db04a1967..b3879b485918 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2746,6 +2746,7 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 				  BIT(NL80211_CHAN_WIDTH_80) |
 				  BIT(NL80211_CHAN_WIDTH_160),
 	.support_unii4		= true,
+	.support_ant_gain	= false,
 	.ul_tb_waveform_ctrl	= false,
 	.ul_tb_pwr_diff		= false,
 	.hw_sec_hdr		= true,
-- 
2.25.1


