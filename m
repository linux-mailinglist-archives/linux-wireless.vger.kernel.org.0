Return-Path: <linux-wireless+bounces-17400-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A472BA0B03F
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 08:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3C6818820F4
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 07:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D258723236E;
	Mon, 13 Jan 2025 07:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bQaXp3LJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FD8231A5B
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 07:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736754508; cv=none; b=COClsdFM0rMcB7moL0T0rAUa8hmi2L7yEzC6GnmTjowIY14E4aqopUR5mgGDOEooUDV0UaSaa5eW4fZMCbhgOwuW+8m1EbOwA+RBoBnno+QsXADxDz0wj3M3xts0mH8l94pnyHkFO/6TrH7dCXgpJ5y7j5zAtN4/QIKKg+/mqyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736754508; c=relaxed/simple;
	bh=lxButlPhfMaalE/AZXmj7dxOtTB/T7nJUaNoa2TyaNI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L2FmkD1Gf60Hp6wZb10+43DDGUlPXQLKzukuTBkAR4LpJbffBDBbG0LZsoD1/ZapnD/E1T4I4xo8hM+o3TmmYfCGTiF75iNOofVaSxTmdosFpOX6IKCwLbYT5eOYq88ifze6vExv/1rbU8VnZtZrJ0ooXzY7DBSZm/sf1wqVSlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bQaXp3LJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50CMEo3q004108;
	Mon, 13 Jan 2025 07:48:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6JAXHgAOQ1fDvgScfwrJhuQPM5IJ7ONM/Jl7gkiq8MA=; b=bQaXp3LJBKLD/QJz
	ogZAX6PCTrpUZloq2VS5H8p38MM170YOfH1mzSeN3MM3X0+h3TBjGEyWkg/qTkAs
	o7BVlEj19pHMjXdEUX2S1mVUNW0JW8Gwv/a/uLD4OdGkCI+tLRpxze6jP+fYNW5U
	7CALug1lBWdxM7GbdVrRjZZFiVZk1Q0f+/95WLSyB1ABs6u3eL7SZ59gB8WoXHd9
	06ZF0GcshNlfBFUJ4TZ066GkpLOrAWkSt7lA+xHvw79wQU9Tq3RJq0mZ5xv/Rdm4
	IR31kb7+Rr5MdEhHat8nHxHxuSjjm+ioxYCQ63VUBpKex22BYlXg7V0NsUhqM9bw
	RcPKGw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 444f5bhg5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 07:48:23 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50D7mNU2024070
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 07:48:23 GMT
Received: from lingbok-Birman-PHX.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 12 Jan 2025 23:48:21 -0800
From: Lingbo Kong <quic_lingbok@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_lingbok@quicinc.com>
Subject: [PATCH v4 1/4] wifi: ath12k: Add support for obtaining the buffer type ACPI function bitmap
Date: Mon, 13 Jan 2025 15:48:07 +0800
Message-ID: <20250113074810.29729-2-quic_lingbok@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250113074810.29729-1-quic_lingbok@quicinc.com>
References: <20250113074810.29729-1-quic_lingbok@quicinc.com>
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
X-Proofpoint-GUID: Fmt_88_sKG3Sif0UaoJIbLAhOYGriIiI
X-Proofpoint-ORIG-GUID: Fmt_88_sKG3Sif0UaoJIbLAhOYGriIiI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 mlxlogscore=829 malwarescore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501130066

Currently, ath12k does not support obtaining the buffer type ACPI function
bitmap.

To solve this issue, change the code to support obtaining the buffer type
ACPI function bitmap.

This patch will not affect QCN9274, because only WCN7850 supports ACPI.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
v4:
1.rebase to 0c5fcd9069dd

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


