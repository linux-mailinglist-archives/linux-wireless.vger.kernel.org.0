Return-Path: <linux-wireless+bounces-17579-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8904BA131C0
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 04:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6A457A1032
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 03:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF12C74059;
	Thu, 16 Jan 2025 03:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RzxOd2of"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB9A225D6
	for <linux-wireless@vger.kernel.org>; Thu, 16 Jan 2025 03:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736998138; cv=none; b=U27v6g3/4wi9wwNq+N8b2PIQ0V5UGMGVXFzNeSNBGtKCgT5nTQZmcIO64h9NHL9IwokATJiKlZ2rU9eQgm265MQYslOydIUp5ixgflJDGYdpAuKt4bI7iZbcgUQAHXDjwfIWmaTTAyA6jV89+Xt2fkYGRYRHyH4FB5HbaibRKkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736998138; c=relaxed/simple;
	bh=3vn1ggLhHsF/D2dyaVyVGkIrViQLCTukvZ+KpA5CGFM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a6JfL69/Xx4Kb/ZZR/NNm2BQj0ms9D+ttaXcnAk+frhhEdWV0aSfP+AUArgbpJ0dkhLSHYchDxgC8Kuo2xmBRlaY7BjuGMgd2d+CuxuwM3JV2Ca/zWSUEDW2AoFo6fIoRpT9c3CTic8YzWwHxPFx58/cYxs4xe7GDJPQf1LAANA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RzxOd2of; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50G02flP023998;
	Thu, 16 Jan 2025 03:28:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=XlOcoiUtT/8Gm+iDSWcpHm
	acHdnhbpbEzthArm4cL/w=; b=RzxOd2ofNUaOxDhIMeBFoMu6YcVR9BYvDKEgXl
	AtXzc+R1XlQURz0KcfBRPK+MR4fx1kxTnxGTaPS9U7Q8j0B3xBR2uoqD2s3t+/mz
	2w04MnfyoR23Dgz2jrrOo8gGGNJpBKaqhNW1ybOFuKNmltcB2lclNJAcjwRvLj0M
	Hjo12llxYd0vaZe0h2rARZ76rQD8UTjAKgPfitxz+0LQlLJxxlNyX2rUdsV1vtVc
	UBrnKY9+ehrX/iZwMSNTCVMCSx0U3Rngdhtx5J2InoYsuf6w61B1dvkDksycvchi
	bp9rGf8Apd4R6ClrMLa9eXLzY3PGmogHX/zZhqzLVWC0anog==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 446q7n0cn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 03:28:53 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50G3Srrf003360
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 03:28:53 GMT
Received: from hu-aarasahu-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 15 Jan 2025 19:28:51 -0800
From: Aaradhana Sahu <quic_aarasahu@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Aaradhana Sahu
	<quic_aarasahu@quicinc.com>
Subject: [PATCH] wifi: ath12k: Fetch regdb.bin file from board-2.bin
Date: Thu, 16 Jan 2025 08:58:35 +0530
Message-ID: <20250116032835.118397-1-quic_aarasahu@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: iLyKlfUZxrHOK1nT9A8b387aYJNdrr0L
X-Proofpoint-ORIG-GUID: iLyKlfUZxrHOK1nT9A8b387aYJNdrr0L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_01,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501160021

Currently, ath12k_core_fetch_regdb() finds regdb.bin file through
board id's but in board-2.bin file regdb.bin file is present with
default board id because of which regdb.bin is not fetched.

Add support to fetch regdb.bin file from board-2.bin through
default board id.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 0606116d6b9c..3eff1fbf8247 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -173,7 +173,7 @@ EXPORT_SYMBOL(ath12k_core_resume);
 
 static int __ath12k_core_create_board_name(struct ath12k_base *ab, char *name,
 					   size_t name_len, bool with_variant,
-					   bool bus_type_mode)
+					   bool bus_type_mode, bool with_default)
 {
 	/* strlen(',variant=') + strlen(ab->qmi.target.bdf_ext) */
 	char variant[9 + ATH12K_QMI_BDF_EXT_STR_LENGTH] = { 0 };
@@ -204,7 +204,9 @@ static int __ath12k_core_create_board_name(struct ath12k_base *ab, char *name,
 			  "bus=%s,qmi-chip-id=%d,qmi-board-id=%d%s",
 			  ath12k_bus_str(ab->hif.bus),
 			  ab->qmi.target.chip_id,
-			  ab->qmi.target.board_id, variant);
+			  with_default ?
+			  ATH12K_BOARD_ID_DEFAULT : ab->qmi.target.board_id,
+			  variant);
 		break;
 	}
 
@@ -216,19 +218,19 @@ static int __ath12k_core_create_board_name(struct ath12k_base *ab, char *name,
 static int ath12k_core_create_board_name(struct ath12k_base *ab, char *name,
 					 size_t name_len)
 {
-	return __ath12k_core_create_board_name(ab, name, name_len, true, false);
+	return __ath12k_core_create_board_name(ab, name, name_len, true, false, false);
 }
 
 static int ath12k_core_create_fallback_board_name(struct ath12k_base *ab, char *name,
 						  size_t name_len)
 {
-	return __ath12k_core_create_board_name(ab, name, name_len, false, false);
+	return __ath12k_core_create_board_name(ab, name, name_len, false, false, true);
 }
 
 static int ath12k_core_create_bus_type_board_name(struct ath12k_base *ab, char *name,
 						  size_t name_len)
 {
-	return __ath12k_core_create_board_name(ab, name, name_len, false, true);
+	return __ath12k_core_create_board_name(ab, name, name_len, false, true, true);
 }
 
 const struct firmware *ath12k_core_firmware_request(struct ath12k_base *ab,

base-commit: 6a5fe6aaedcfadf8e32dd703ec20b1460523c22d
-- 
2.34.1


