Return-Path: <linux-wireless+bounces-13349-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 441D198B2B9
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 05:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F2D11C21F8A
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 03:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A29193414;
	Tue,  1 Oct 2024 03:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BiNSUds+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E047193096;
	Tue,  1 Oct 2024 03:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727753494; cv=none; b=rxGyfIfr2a3zi1EMwcK74Yyimw1UdpcDfQ10Ijc01ELfsw4/Y8JgNmcJlWxT9CJ8XyWYVxOW6x/SBM/hf5zlIcAgkKR8Ci1H1ksEsZwvXdk9TDBExjDP9l/xCicEuH+CWnw3yiQuWqHDPtOfDbYfx0Wt/jtf4ZhEHwhNWA4VupE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727753494; c=relaxed/simple;
	bh=nCNLezVuP8fOJEVcbltXjdP/Gri8fL6cTqD1m4Bh0oQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PuAiOi/ufjApPHaWmtNez0Gu3bwqY0rrDjbQQcgFX1MIGneuo6K2fN8MQbm3XtsnRooJhwSvoVnzcY99iM3NtguEdlrm/8KSOVwyMC7NpyvIDpzQBuIHJEV0Bo4LJFTYPef7sscjJLqyJOEFgs0s8p6g8g8t5icCoax/dGy0+Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BiNSUds+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4910HM5O025075;
	Tue, 1 Oct 2024 03:31:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FQMEVX0dqad/HEWEyybScIJiZF9i2wSYdOXNnOgONmQ=; b=BiNSUds+ofd72VJt
	kt3CoGXpPTlSdrROGFj/jBJVYWy2tB6IZ/+kQC+c1FrVKZIrL3W0/QhU3JhbMkd6
	BPLf8TIJThNBii1fY0mxd6WH40N5aUpcvXvFCdZkjVBF9TnF/1g9v33vqRp85l/D
	+eczeIX5Ea48McODKCQdWw3BoGebXSCBKNv74GPbuTxMPwg5WyOeIr/Ax8Z6EUps
	wNDbQefFfmjLviD8fikkvIIg/vEPudEcdNLwh5X8hy+PdMx/FoHN2ya5897MzEgg
	iirqJxYyn9ucQ25CRpvfzjZDZDzXP+AoLAzcDHNV6wg7Jfeknk+MBOYDTarXSylN
	KxLCmg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41x8t6pw5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 03:31:26 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4913VOS4026738
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 1 Oct 2024 03:31:24 GMT
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 30 Sep 2024 20:31:22 -0700
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
To: <kvalo@kernel.org>
CC: <quic_jjohnson@quicinc.com>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Miaoqing Pan <quic_miaoqing@quicinc.com>
Subject: [PATCH 2/2] wifi: ath11k: add firmware-name device tree property
Date: Tue, 1 Oct 2024 11:30:52 +0800
Message-ID: <20241001033053.2084360-3-quic_miaoqing@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241001033053.2084360-1-quic_miaoqing@quicinc.com>
References: <20241001033053.2084360-1-quic_miaoqing@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jZC0mlPbWnQtrFdVUijQy7YKQBsBzvWh
X-Proofpoint-ORIG-GUID: jZC0mlPbWnQtrFdVUijQy7YKQBsBzvWh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410010023

QCA6698AQ uses different firmware/bdf/regdb with existing WCN6855
firmware, which is customized for IoE platforms. And the 'pci-device-id +
soc-hw-version + soc-hw-sub-version' may not be enough to identify the
correct firmware directory path.

The device tree allows "firmware-name" to define the firmware path,
    wifi@c000000 {
        firmware-name = "QCA6698AQ";
        status = "okay";
    };

Tested-on: QCA6698AQ hw2.1 PCI WLAN.HSP.1.1-04402-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1

Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 12 ++++++++++++
 drivers/net/wireless/ath/ath11k/core.h | 11 +++--------
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index be67382c00f6..7720f467b11b 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1178,6 +1178,18 @@ static int ath11k_core_create_chip_id_board_name(struct ath11k_base *ab, char *n
 					       ATH11K_BDF_NAME_CHIP_ID);
 }
 
+void ath11k_core_create_firmware_path(struct ath11k_base *ab,
+				      const char *filename,
+				      void *buf, size_t buf_len)
+{	const char *variant = NULL;
+
+	of_property_read_string(ab->dev->of_node, "firmware-name", &variant);
+
+	snprintf(buf, buf_len, "%s/%s/%s", ATH11K_FW_DIR,
+		 variant ? : ab->hw_params.fw.dir, filename);
+}
+EXPORT_SYMBOL(ath11k_core_create_firmware_path);
+
 const struct firmware *ath11k_core_firmware_request(struct ath11k_base *ab,
 						    const char *file)
 {
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 09c37e19a168..ce4102cfed4d 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -1249,6 +1249,9 @@ bool ath11k_core_coldboot_cal_support(struct ath11k_base *ab);
 
 const struct firmware *ath11k_core_firmware_request(struct ath11k_base *ab,
 						    const char *filename);
+void ath11k_core_create_firmware_path(struct ath11k_base *ab,
+				      const char *filename,
+				      void *buf, size_t buf_len);
 
 static inline const char *ath11k_scan_state_str(enum ath11k_scan_state state)
 {
@@ -1295,14 +1298,6 @@ static inline struct ath11k *ath11k_ab_to_ar(struct ath11k_base *ab,
 	return ab->pdevs[ath11k_hw_mac_id_to_pdev_id(&ab->hw_params, mac_id)].ar;
 }
 
-static inline void ath11k_core_create_firmware_path(struct ath11k_base *ab,
-						    const char *filename,
-						    void *buf, size_t buf_len)
-{
-	snprintf(buf, buf_len, "%s/%s/%s", ATH11K_FW_DIR,
-		 ab->hw_params.fw.dir, filename);
-}
-
 static inline const char *ath11k_bus_str(enum ath11k_bus bus)
 {
 	switch (bus) {
-- 
2.25.1


