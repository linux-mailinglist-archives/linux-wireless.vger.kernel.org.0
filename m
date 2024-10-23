Return-Path: <linux-wireless+bounces-14344-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8659ABBC3
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 04:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 793B51C20CC5
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 02:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE6617F7;
	Wed, 23 Oct 2024 02:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dAXcHY4g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B6B2B9AA
	for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 02:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729651632; cv=none; b=fzg1gWuiHs7jBePLG8orv6+0IC+QlcLAN/tMMVHKc0qo5kJkoKT64pPoMtInCAd3JK1BYxPhh4harMnoiu5Ul9J8FeQ7kXitnYpvNfhStyJVqtuoiHLm2mjJWrOYd6x4FojzqwpHac01kbjm/teotmZ5NaS/pMn6F+0e+48w2Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729651632; c=relaxed/simple;
	bh=PhzjAopMkl4b+H6ERkyAMTZchRTie6nT+coCqTVDJ10=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pNxeapd3+/aQ0XDyEIX2qtk/U62LuJy92UZU///NdolXQsRIN6nt/R3Ufjrls1211RkrGlB9ClpIqnzjbhcKis1by9BESUC9CSJa58sKBKQYoHMIgwxBWx6lWsN37lp6zH+nVQpG0aXeTlPNVaMzHbX4I3/AwaGqkdsQxRIvtsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dAXcHY4g; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MLahHa026325;
	Wed, 23 Oct 2024 02:47:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cw5lBtaPAPQS/vJigshoz4QBWzMoow3BT8PGI69v+mA=; b=dAXcHY4gkLMl/yM2
	kxs3Kv+eFoEj1tcL5K55lgfQ8aH8kE74Ss793Fx+WF0rgL7lly6lIiwCtSgb37vg
	NDK+PUlUegiqw1DT1kSQH9omVGoD90GJ15uPXm+mndQNNsQkASJ52+tpWFjTIt/z
	bkFcJOuNessKXAMIp6vVzDElW/u76fsnpqQO9xBcnrSBVKHAb/QR93bfJH+3vbNN
	UXzMEOltCZ172pqLCAjhaZwMfAFqTWsxLZCdPwbLTD65UVvS1Fel+FoFhWAf+K1s
	xZbLkFeZP7LXoofSPEKi74klpPHTo5P7C7yS3m5KyeNmHC0zpO5Vh4q+zy6n5EG3
	f1ocHg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em408kpd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 02:47:07 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49N2l6PL019213
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 02:47:06 GMT
Received: from lingbok-Birman-PHX.lan (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 22 Oct 2024 19:47:05 -0700
From: Lingbo Kong <quic_lingbok@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_lingbok@quicinc.com>
Subject: [PATCH v3 1/4] wifi: ath12k: Add support for obtaining the buffer type ACPI function bitmap
Date: Wed, 23 Oct 2024 10:45:48 +0800
Message-ID: <20241023024551.18966-2-quic_lingbok@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023024551.18966-1-quic_lingbok@quicinc.com>
References: <20241023024551.18966-1-quic_lingbok@quicinc.com>
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
X-Proofpoint-ORIG-GUID: dby0BWi_BLfQp5IFPn9y7nhQ0kAGFGQ8
X-Proofpoint-GUID: dby0BWi_BLfQp5IFPn9y7nhQ0kAGFGQ8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 impostorscore=0 spamscore=0 phishscore=0 mlxlogscore=793
 lowpriorityscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410230014

Currently, ath12k does not support obtaining the buffer type ACPI function
bitmap.

To solve this issue, change the code to support obtaining the buffer type
ACPI function bitmap.

This patch will not affect QCN9274, because only WCN7850 supports ACPI.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
v3:
no change

v2:
no change

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


