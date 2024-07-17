Return-Path: <linux-wireless+bounces-10297-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B22933BE5
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 13:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E573C2843EF
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 11:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4745C17F4F0;
	Wed, 17 Jul 2024 11:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PYbH+09s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAABB17F4E4
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jul 2024 11:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721214647; cv=none; b=ua5u2DA2ceEKfROBuTYA0g7X/r364hcutm8feF2q/f99YxH380jYa0vU7ErZPRojdvMJJyEsH5Qoky9LrKYj3ouaEsOV+2AAwBLJIr8/anz/ZCx6WIFChEyt8ZeLnpMCGTpg8ReHcXCEMXurSIjkbXWmDjSDvp2+ksgDCUYQ1pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721214647; c=relaxed/simple;
	bh=AYF36Cxq5NTgmt5Xkru7C4XJ6Qtnmn6JTVYhYVIP7z4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MoveCFdt1vhKX1A+nb73vp+pzl2NPNh/XndrGDybu8gk81Gfya7fPQvBhoqzJxfAUxXzpgYpyldc6fJAS0X7+YphW/almyAVEugktpX4QtKf0cB69HbEjDWbPdlshgQGOJfHO5gdNLfPKnH09loFZQd9W1wHk/Hs6Ob9AHbjOgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PYbH+09s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46H7O7ok029106;
	Wed, 17 Jul 2024 11:10:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	17Zssr5EYiZXtjPyPQRAQVBY4Zlely9AAaHIs+ZPpRY=; b=PYbH+09s8CiIvyg5
	R+7TIGs5o17RPtOHTGDiqDpLOu9Lg8NeMsFyCdgJ2Bdd5Ei0ZswN6w/04a8In1E4
	wcrY0sCkXUBwIsJRAbsRac/Cm4ciU/4jHw5NJmDT7ERYNHfCRPpSfsFM4h5heQnN
	WGubnMT3CS5Ub+ZpvhwL3Nk2WFFBgdltCnRK9m2K/BcrI624WOeBzy6lbXE14WH2
	E4PezWvCOId4gsq8EmfFumcfYXIza/nPf+LBOLlL+3uMRI0wTXLMKiLN+tuKQfZc
	pryK6Jc9J/+hoG17oc2Z01ZY/KyivOL3Yq8hQ5N3amUrUU5taC9Xe5kBAEmLOW9Y
	sSrB6A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40dwj1j4u9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 11:10:37 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46HBAbti028275
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 11:10:37 GMT
Received: from lingbok-Birman-PHX.lan (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 17 Jul 2024 04:10:35 -0700
From: Lingbo Kong <quic_lingbok@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_lingbok@quicinc.com>
Subject: [PATCH 1/4] wifi: ath12k: Add support for obtaining the buffer type ACPI function bitmap
Date: Wed, 17 Jul 2024 19:10:20 +0800
Message-ID: <20240717111023.78798-2-quic_lingbok@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240717111023.78798-1-quic_lingbok@quicinc.com>
References: <20240717111023.78798-1-quic_lingbok@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cNjd7NP0iprwpsv1FvC3ZDzuX1pnBXLZ
X-Proofpoint-ORIG-GUID: cNjd7NP0iprwpsv1FvC3ZDzuX1pnBXLZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_06,2024-07-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=804 phishscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407170086

Currently, ath12k does not support obtaining the buffer type ACPI function
bitmap.

To solve this issue, change the code to support obtaining the buffer type
ACPI function bitmap.

This patch will not affect QCN9274, because only WCN7850 supports ACPI.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/acpi.c | 16 +++++++++++++++-
 drivers/net/wireless/ath/ath12k/acpi.h |  3 +++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/acpi.c b/drivers/net/wireless/ath/ath12k/acpi.c
index 0555d35aab47..d83f7e58fb7a 100644
--- a/drivers/net/wireless/ath/ath12k/acpi.c
+++ b/drivers/net/wireless/ath/ath12k/acpi.c
@@ -12,7 +12,7 @@ static int ath12k_acpi_dsm_get_data(struct ath12k_base *ab, int func)
 {
 	union acpi_object *obj;
 	acpi_handle root_handle;
-	int ret;
+	int ret, i;
 
 	root_handle = ACPI_HANDLE(ab->dev);
 	if (!root_handle) {
@@ -32,6 +32,20 @@ static int ath12k_acpi_dsm_get_data(struct ath12k_base *ab, int func)
 		ab->acpi.func_bit = obj->integer.value;
 	} else if (obj->type == ACPI_TYPE_BUFFER) {
 		switch (func) {
+		case ATH12K_ACPI_DSM_FUNC_SUPPORT_FUNCS:
+			if (obj->buffer.length < ATH12K_ACPI_DSM_FUNC_MIN_BITMAP_SIZE ||
+			    obj->buffer.length > ATH12K_ACPI_DSM_FUNC_MAX_BITMAP_SIZE) {
+				ath12k_warn(ab, "invalid ACPI DSM func size: %d\n",
+					    obj->buffer.length);
+				ret = -EINVAL;
+				goto out;
+			}
+
+			ab->acpi.func_bit = 0;
+			for (i = 0; i < obj->buffer.length; i++)
+				ab->acpi.func_bit += obj->buffer.pointer[i] << (i * 8);
+
+			break;
 		case ATH12K_ACPI_DSM_FUNC_TAS_CFG:
 			if (obj->buffer.length != ATH12K_ACPI_DSM_TAS_CFG_SIZE) {
 				ath12k_warn(ab, "invalid ACPI DSM TAS config size: %d\n",
diff --git a/drivers/net/wireless/ath/ath12k/acpi.h b/drivers/net/wireless/ath/ath12k/acpi.h
index 39e003d86a48..7ec7a2e72e40 100644
--- a/drivers/net/wireless/ath/ath12k/acpi.h
+++ b/drivers/net/wireless/ath/ath12k/acpi.h
@@ -48,6 +48,9 @@
 #define ATH12K_ACPI_DSM_BAND_EDGE_DATA_SIZE		100
 #define ATH12K_ACPI_DSM_TAS_CFG_SIZE			108
 
+#define ATH12K_ACPI_DSM_FUNC_MIN_BITMAP_SIZE	1
+#define ATH12K_ACPI_DSM_FUNC_MAX_BITMAP_SIZE	4
+
 #define ATH12K_ACPI_DSM_GEO_OFFSET_DATA_SIZE (ATH12K_ACPI_GEO_OFFSET_DATA_OFFSET + \
 					      ATH12K_ACPI_BIOS_SAR_GEO_OFFSET_LEN)
 #define ATH12K_ACPI_DSM_BIOS_SAR_DATA_SIZE (ATH12K_ACPI_POWER_LIMIT_DATA_OFFSET + \
-- 
2.34.1


