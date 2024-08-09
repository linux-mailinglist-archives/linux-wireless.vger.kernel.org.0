Return-Path: <linux-wireless+bounces-11160-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9407094C8A6
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 04:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BBD2286719
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 02:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98C911CA0;
	Fri,  9 Aug 2024 02:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ctN6kKAz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DED17BCC
	for <linux-wireless@vger.kernel.org>; Fri,  9 Aug 2024 02:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723171888; cv=none; b=GtdVwOZQgv1cKrWmqvpGD8qqpbvxp/TS0TBrrYhC5DCgpePpnW4+HO7b9kkvtIVd4aXEQgFF8gNPUvQHdh4hKQvBGMEqCl2lE3N0Rmo3mNwo+5tVRblh4IvbMK2FIeoQCbZzkhGzAV8xNob1W4Pf7WAcg+mj4vfotcxiUfbtlTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723171888; c=relaxed/simple;
	bh=PQPKZ75VftFaVjgZOyMv1nvIEK5wAxwlU22LEmTIoBw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jiPdkIUVWirQdKI2058u0W1xHs6Vg+hDk5NEl7cgrUb43fgl0APM3V6zaz8x3+5i4gwp1z7yxq4f0Pl3i8IcG5lRNyJClEuPLaKQb73hY5AHhTPOcIIXspympoLjbWYzAQYSj0xYLPWSoLY9pwjGmI5krrJVe13z1MgE+87xH5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ctN6kKAz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4792dgpq018981;
	Fri, 9 Aug 2024 02:51:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1rKKDIhUgDucybetjY0tAbAKVyXq7NFr1Svvc1YxPWs=; b=ctN6kKAzueQjoLYe
	FOQTdM3Pnr9C0bmnE4XZkqB3NWYSf248MykBhVuYDBA9IS8VPup8XuDpctsqp3Cs
	bc15UQXOgXMx6SYLUEfRfeJw8gvdEG6Eu3ZQm5jGbFgAoy8O+Zg5l3oyuaiZia2q
	MASXbp3EDbSVHCO3MGA7d7nIkGu2yZhhVLUoELAYGzcsS6D/Maad1wldYXr+lp1l
	e0aHwmTv0TVB9/xNBPRYH5ztuWwAb63b45sdhdN8O0/YDt8K/Js5w5fFXl8D9xdg
	LZ0DfaktaTYYN+EEjEIH8aRdMD4Wkc0ASInkblqaWKl9SZa7LXG9gNdjujMo3++l
	iKPI8A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40vvgm24p9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Aug 2024 02:51:23 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4792pMKQ019466
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 9 Aug 2024 02:51:22 GMT
Received: from lingbok-Birman-PHX.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 8 Aug 2024 19:51:20 -0700
From: Lingbo Kong <quic_lingbok@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_lingbok@quicinc.com>
Subject: [PATCH v2 2/4] wifi: ath12k: Add Support for enabling or disabling specific features based on ACPI bitflag
Date: Fri, 9 Aug 2024 10:50:53 +0800
Message-ID: <20240809025055.6495-3-quic_lingbok@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809025055.6495-1-quic_lingbok@quicinc.com>
References: <20240809025055.6495-1-quic_lingbok@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: b2RNJte-ORidSuLhSQoAVV69SR9idnTp
X-Proofpoint-GUID: b2RNJte-ORidSuLhSQoAVV69SR9idnTp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-08_25,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408090020

Currently, ath12k does not support enable or disable specific features by
ACPI bitflag.

To address this issue, obtain the ACPI bitflag value and use it to
selectively enable or disable specific features.

This patch will not affect QCN9274, because only WCN7850 supports ACPI.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
---
v2:
1.support functions for cases where CONFIG_ACPI is disabled

 drivers/net/wireless/ath/ath12k/acpi.c | 41 ++++++++++++++++++++++++--
 drivers/net/wireless/ath/ath12k/acpi.h | 18 +++++++++++
 drivers/net/wireless/ath/ath12k/core.c |  3 ++
 drivers/net/wireless/ath/ath12k/core.h |  3 ++
 drivers/net/wireless/ath/ath12k/mac.c  |  3 +-
 5 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/acpi.c b/drivers/net/wireless/ath/ath12k/acpi.c
index d83f7e58fb7a..a3f3d0712722 100644
--- a/drivers/net/wireless/ath/ath12k/acpi.c
+++ b/drivers/net/wireless/ath/ath12k/acpi.c
@@ -29,7 +29,14 @@ static int ath12k_acpi_dsm_get_data(struct ath12k_base *ab, int func)
 	}
 
 	if (obj->type == ACPI_TYPE_INTEGER) {
-		ab->acpi.func_bit = obj->integer.value;
+		switch (func) {
+		case ATH12K_ACPI_DSM_FUNC_SUPPORT_FUNCS:
+			ab->acpi.func_bit = obj->integer.value;
+			break;
+		case ATH12K_ACPI_DSM_FUNC_DISABLE_FLAG:
+			ab->acpi.bit_flag = obj->integer.value;
+			break;
+		}
 	} else if (obj->type == ACPI_TYPE_BUFFER) {
 		switch (func) {
 		case ATH12K_ACPI_DSM_FUNC_SUPPORT_FUNCS:
@@ -261,24 +268,52 @@ static int ath12k_acpi_set_tas_params(struct ath12k_base *ab)
 	return 0;
 }
 
+bool ath12k_acpi_get_disable_rfkill(struct ath12k_base *ab)
+{
+	return ab->acpi.acpi_disable_rfkill;
+}
+
+bool ath12k_acpi_get_disable_11be(struct ath12k_base *ab)
+{
+	return ab->acpi.acpi_disable_11be;
+}
+
 int ath12k_acpi_start(struct ath12k_base *ab)
 {
 	acpi_status status;
 	u8 *buf;
 	int ret;
 
+	ab->acpi.acpi_tas_enable = false;
+	ab->acpi.acpi_disable_11be = false;
+	ab->acpi.acpi_disable_rfkill = false;
+
 	if (!ab->hw_params->acpi_guid)
 		/* not supported with this hardware */
 		return 0;
 
-	ab->acpi.acpi_tas_enable = false;
-
 	ret = ath12k_acpi_dsm_get_data(ab, ATH12K_ACPI_DSM_FUNC_SUPPORT_FUNCS);
 	if (ret) {
 		ath12k_dbg(ab, ATH12K_DBG_BOOT, "failed to get ACPI DSM data: %d\n", ret);
 		return ret;
 	}
 
+	if (ATH12K_ACPI_FUNC_BIT_VALID(ab->acpi, ATH12K_ACPI_FUNC_BIT_DISABLE_FLAG)) {
+		ret = ath12k_acpi_dsm_get_data(ab, ATH12K_ACPI_DSM_FUNC_DISABLE_FLAG);
+		if (ret) {
+			ath12k_warn(ab, "failed to get ACPI DISABLE FLAG: %d\n", ret);
+			return ret;
+		}
+
+		if (ATH12K_ACPI_CHEK_BIT_VALID(ab->acpi,
+					       ATH12K_ACPI_DSM_DISABLE_11BE_BIT))
+			ab->acpi.acpi_disable_11be = true;
+
+		if (!ATH12K_ACPI_CHEK_BIT_VALID(ab->acpi,
+						ATH12K_ACPI_DSM_DISABLE_RFKILL_BIT))
+			ab->acpi.acpi_disable_rfkill = true;
+	}
+
 	if (ATH12K_ACPI_FUNC_BIT_VALID(ab->acpi, ATH12K_ACPI_FUNC_BIT_TAS_CFG)) {
 		ret = ath12k_acpi_dsm_get_data(ab, ATH12K_ACPI_DSM_FUNC_TAS_CFG);
 		if (ret) {
diff --git a/drivers/net/wireless/ath/ath12k/acpi.h b/drivers/net/wireless/ath/ath12k/acpi.h
index 7ec7a2e72e40..4b154cfdbd39 100644
--- a/drivers/net/wireless/ath/ath12k/acpi.h
+++ b/drivers/net/wireless/ath/ath12k/acpi.h
@@ -9,6 +9,7 @@
 #include <linux/acpi.h>
 
 #define ATH12K_ACPI_DSM_FUNC_SUPPORT_FUNCS	0
+#define ATH12K_ACPI_DSM_FUNC_DISABLE_FLAG	2
 #define ATH12K_ACPI_DSM_FUNC_BIOS_SAR		4
 #define ATH12K_ACPI_DSM_FUNC_GEO_OFFSET		5
 #define ATH12K_ACPI_DSM_FUNC_INDEX_CCA		6
@@ -16,6 +17,7 @@
 #define ATH12K_ACPI_DSM_FUNC_TAS_DATA		9
 #define ATH12K_ACPI_DSM_FUNC_INDEX_BAND_EDGE		10
 
+#define ATH12K_ACPI_FUNC_BIT_DISABLE_FLAG		BIT(1)
 #define ATH12K_ACPI_FUNC_BIT_BIOS_SAR			BIT(3)
 #define ATH12K_ACPI_FUNC_BIT_GEO_OFFSET			BIT(4)
 #define ATH12K_ACPI_FUNC_BIT_CCA			BIT(5)
@@ -25,6 +27,7 @@
 
 #define ATH12K_ACPI_NOTIFY_EVENT			0x86
 #define ATH12K_ACPI_FUNC_BIT_VALID(_acdata, _func)	(((_acdata).func_bit) & (_func))
+#define ATH12K_ACPI_CHEK_BIT_VALID(_acdata, _func)	(((_acdata).bit_flag) & (_func))
 
 #define ATH12K_ACPI_TAS_DATA_VERSION		0x1
 #define ATH12K_ACPI_TAS_DATA_ENABLE		0x1
@@ -51,6 +54,9 @@
 #define ATH12K_ACPI_DSM_FUNC_MIN_BITMAP_SIZE	1
 #define ATH12K_ACPI_DSM_FUNC_MAX_BITMAP_SIZE	4
 
+#define ATH12K_ACPI_DSM_DISABLE_11BE_BIT	BIT(0)
+#define ATH12K_ACPI_DSM_DISABLE_RFKILL_BIT	BIT(2)
+
 #define ATH12K_ACPI_DSM_GEO_OFFSET_DATA_SIZE (ATH12K_ACPI_GEO_OFFSET_DATA_OFFSET + \
 					      ATH12K_ACPI_BIOS_SAR_GEO_OFFSET_LEN)
 #define ATH12K_ACPI_DSM_BIOS_SAR_DATA_SIZE (ATH12K_ACPI_POWER_LIMIT_DATA_OFFSET + \
@@ -62,6 +68,8 @@
 
 int ath12k_acpi_start(struct ath12k_base *ab);
 void ath12k_acpi_stop(struct ath12k_base *ab);
+bool ath12k_acpi_get_disable_rfkill(struct ath12k_base *ab);
+bool ath12k_acpi_get_disable_11be(struct ath12k_base *ab);
 
 #else
 
@@ -74,6 +82,16 @@ static inline void ath12k_acpi_stop(struct ath12k_base *ab)
 {
 }
 
+static inline bool ath12k_acpi_get_disable_rfkill(struct ath12k_base *ab)
+{
+	return false;
+}
+
+static inline bool ath12k_acpi_get_disable_11be(struct ath12k_base *ab)
+{
+	return false;
+}
+
 #endif /* CONFIG_ACPI */
 
 #endif /* ATH12K_ACPI_H */
diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 51252e8bc1ae..bda7d40075c4 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -30,6 +30,9 @@ static int ath12k_core_rfkill_config(struct ath12k_base *ab)
 	if (!(ab->target_caps.sys_cap_info & WMI_SYS_CAP_INFO_RFKILL))
 		return 0;
 
+	if (ath12k_acpi_get_disable_rfkill(ab))
+		return 0;
+
 	for (i = 0; i < ab->num_radios; i++) {
 		ar = ab->pdevs[i].ar;
 
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index cdfd43a7321a..cac6647f2776 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -940,6 +940,9 @@ struct ath12k_base {
 		u32 func_bit;
 		bool acpi_tas_enable;
 		bool acpi_bios_sar_enable;
+		bool acpi_disable_11be;
+		bool acpi_disable_rfkill;
+		u32 bit_flag;
 		u8 tas_cfg[ATH12K_ACPI_DSM_TAS_CFG_SIZE];
 		u8 tas_sar_power_table[ATH12K_ACPI_DSM_TAS_DATA_SIZE];
 		u8 bios_sar_data[ATH12K_ACPI_DSM_BIOS_SAR_DATA_SIZE];
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index a3248d977532..4be88834e62b 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5483,7 +5483,8 @@ static void ath12k_mac_copy_eht_cap(struct ath12k *ar,
 
 	memset(eht_cap, 0, sizeof(struct ieee80211_sta_eht_cap));
 
-	if (!(test_bit(WMI_TLV_SERVICE_11BE, ar->ab->wmi_ab.svc_map)))
+	if (!(test_bit(WMI_TLV_SERVICE_11BE, ar->ab->wmi_ab.svc_map)) ||
+	    ath12k_acpi_get_disable_11be(ar->ab))
 		return;
 
 	eht_cap->has_eht = true;
-- 
2.34.1


