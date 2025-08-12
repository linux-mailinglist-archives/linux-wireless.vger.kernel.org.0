Return-Path: <linux-wireless+bounces-26337-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A59CDB22EC8
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 19:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86E11682C34
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 17:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E538B2FE570;
	Tue, 12 Aug 2025 17:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fYtFuyPs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582252FD1A4
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 17:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755018773; cv=none; b=K7VHw0JpMTEuv0nBKmMT5W5BGCVxSdrm1k7Rvm8BMO8tezgQE16r+85E9PyYvV4mNMMWn5HSex6GM7tHJbe55AessuUyy88rFPN/LmqxphmCL4TbK5aCU8qkONKzqmX0Ay4+yAIzSiavPBMWu3AS8ufzsFH0zhGAdTK3HmZLfPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755018773; c=relaxed/simple;
	bh=lv5VEjjadHPk0lceAg/1ugrQ0jFE5k/o9BMH+X8tWZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=kAok5exn0FCAikuS9s6e/nLENBQEsEBqRcmU8tpUY7GqlFIoWtGuygt/+KlWWsw+bu7dO5kqt0/lYjM/ZuKa5OAZUIC/ooMqnME8QT6tbgugEp8UnT4z1zqgIwRX2fQFcV0szwYYTGs0dimUnWB8oCgLHZr9caXGhcG4NG1MiX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fYtFuyPs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CAvonf029782;
	Tue, 12 Aug 2025 17:12:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PvDWRKsB93euhELcNiy7exdUlcSWVbo3RCdpLDI4fmg=; b=fYtFuyPsVfw+nrD6
	1tolp1fKoRdsOHIfPW+ufzsYu5gqLTiih6kCzhb/OfvUVBTnKHsG+haqKHtBGGZV
	oV6fcGTWKfaZ6gnV67b5mH3JEzsE5P1fK8Rj3SS6ToqTf2w7Fj9dMv7ixocV+67f
	NEgI0uEvyWU+w6wkr/JOHd/E2YKsADjY4HarXXg/GmCIJlorPypolTzDqEIbv0Aq
	7rPWgtSJO3M2vt7aIsYF9v9p3YBkAPfKRXgYhWmV28w5yLZfUyerYnOzE2/D9S2m
	sCKB/SmqfoVX1eiNNovwAOZC71G9lDZ2otV2cSkatw5BZt0l6SRrZhfymjvFrfYl
	98HbSg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dy3g8x49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 17:12:50 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57CHCn8V008415
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 17:12:49 GMT
Received: from hu-kiranv-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 12 Aug 2025 10:12:48 -0700
From: Kiran Venkatappa <quic_kiranv@quicinc.com>
Date: Tue, 12 Aug 2025 22:39:38 +0530
Subject: [PATCH ath12k-ng 12/13] wifi: ath12k: Remove HAL defines from
 shared PCI code
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250812-ath12k-mod-v1-12-8c9b0eb9335d@quicinc.com>
References: <20250812-ath12k-mod-v1-0-8c9b0eb9335d@quicinc.com>
In-Reply-To: <20250812-ath12k-mod-v1-0-8c9b0eb9335d@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
X-Mailer: b4 0.15-dev-1b0d6
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=X4lSKHTe c=1 sm=1 tr=0 ts=689b7612 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8
 a=J4BUbrmoJvxzxEsK8LsA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzMSBTYWx0ZWRfX1FFBZQXtaAtp
 REL9yJ2SKzx7Q1W1LWuoMTR8mkc2Ik0GXBQXg7Azdmj6AsxiEzmPpvgBaghDmGrAmPxmNyWyhWf
 j9h+2vdyYuhnx9lTQbOvi38wx2MqMPVN4gnRwi1JY9REBRA0/JOi3iF84Voa6GK6FNOHAXOnMpI
 doij6ALnStDZ1fs/GnIRqj/jCo7w4z2EoPVy17lt9edOUE8hW8dCd8A42viQupKy2VObSCAEeO6
 NC/R5iZSso8uqaeXTaOE8Yn+SBdjyZiiLohjELHGhW+gWXeMluGlFP+bzfSCx0LFSeFerIHNj/q
 3v8oozETpp9Rot8q9eIXL1jeYzpLOuGPO1Tu00T2j+kMECqc3ljR6Aia2WBCeJq4rF2eBKPCDYW
 9AOJESUO
X-Proofpoint-GUID: wgwSOtBhcuGgO8e4mql6TMbiuh6iKApQ
X-Proofpoint-ORIG-GUID: wgwSOtBhcuGgO8e4mql6TMbiuh6iKApQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090031

Eliminate use of HAL-specific defines in the shared PCI implementation.
Pass required register offsets during PCI registration and store them in
the PCI context structure. Access offsets directly from the context to
improve modularity and remove hardware-specific dependencies in the
common code path.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Kiran Venkatappa <quic_kiranv@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/pci.c       | 12 ++++++++----
 drivers/net/wireless/ath/ath12k/pci.h       |  7 +++++++
 drivers/net/wireless/ath/ath12k/wifi7/pci.c |  6 ++++++
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index fbe6359ec74cf121d2d08d94297585eaa423d5ad..72bcaab6f5420945d79bc2bf2adc8afe57b563ac 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -132,10 +132,12 @@ static void ath12k_pci_select_window(struct ath12k_pci *ab_pci, u32 offset)
 
 static void ath12k_pci_select_static_window(struct ath12k_pci *ab_pci)
 {
-	u32 umac_window = u32_get_bits(HAL_SEQ_WCSS_UMAC_OFFSET, WINDOW_VALUE_MASK);
-	u32 ce_window = u32_get_bits(HAL_CE_WFSS_CE_REG_BASE, WINDOW_VALUE_MASK);
+	u32 umac_window;
+	u32 ce_window;
 	u32 window;
 
+	umac_window = u32_get_bits(ab_pci->reg_base->umac_base, WINDOW_VALUE_MASK);
+	ce_window = u32_get_bits(ab_pci->reg_base->ce_reg_base, WINDOW_VALUE_MASK);
 	window = (umac_window << 12) | (ce_window << 6);
 
 	spin_lock_bh(&ab_pci->window_lock);
@@ -148,13 +150,14 @@ static void ath12k_pci_select_static_window(struct ath12k_pci *ab_pci)
 static u32 ath12k_pci_get_window_start(struct ath12k_base *ab,
 				       u32 offset)
 {
+	struct ath12k_pci *ab_pci = ath12k_pci_priv(ab);
 	u32 window_start;
 
 	/* If offset lies within DP register range, use 3rd window */
-	if ((offset ^ HAL_SEQ_WCSS_UMAC_OFFSET) < WINDOW_RANGE_MASK)
+	if ((offset ^ ab_pci->reg_base->umac_base) < WINDOW_RANGE_MASK)
 		window_start = 3 * WINDOW_START;
 	/* If offset lies within CE register range, use 2nd window */
-	else if ((offset ^ HAL_CE_WFSS_CE_REG_BASE) < WINDOW_RANGE_MASK)
+	else if ((offset ^ ab_pci->reg_base->ce_reg_base) < WINDOW_RANGE_MASK)
 		window_start = 2 * WINDOW_START;
 	else
 		window_start = WINDOW_START;
@@ -1553,6 +1556,7 @@ static int ath12k_pci_probe(struct pci_dev *pdev,
 	ath12k_dbg(ab, ATH12K_DBG_PCI, "PCI device family id: %d\n", device_id);
 
 	ab_pci->device_family_ops = &ath12k_pci_family_drivers[device_id]->ops;
+	ab_pci->reg_base = ath12k_pci_family_drivers[device_id]->reg_base;
 
 	/* Call device specific probe. This is the callback that can
 	 * be used to override any ops in future
diff --git a/drivers/net/wireless/ath/ath12k/pci.h b/drivers/net/wireless/ath/ath12k/pci.h
index 1b7ecc329a017cafa84780f3f6e634163ead59bb..5af33e5deacfd8acfc62afc17cb9e63d74df23d5 100644
--- a/drivers/net/wireless/ath/ath12k/pci.h
+++ b/drivers/net/wireless/ath/ath12k/pci.h
@@ -99,6 +99,11 @@ struct ath12k_pci_device_family_ops {
 	int (*probe)(struct pci_dev *pdev, const struct pci_device_id *pci_dev);
 };
 
+struct ath12k_pci_reg_base {
+	u32 umac_base;
+	u32 ce_reg_base;
+};
+
 struct ath12k_pci {
 	struct pci_dev *pdev;
 	struct ath12k_base *ab;
@@ -122,6 +127,7 @@ struct ath12k_pci {
 	u32 qmi_instance;
 	u64 dma_mask;
 	const struct ath12k_pci_device_family_ops *device_family_ops;
+	const struct ath12k_pci_reg_base *reg_base;
 };
 
 struct ath12k_pci_driver {
@@ -129,6 +135,7 @@ struct ath12k_pci_driver {
 	const struct pci_device_id *id_table;
 	struct ath12k_pci_device_family_ops ops;
 	struct pci_driver driver;
+	const struct ath12k_pci_reg_base *reg_base;
 };
 
 static inline struct ath12k_pci *ath12k_pci_priv(struct ath12k_base *ab)
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/pci.c b/drivers/net/wireless/ath/ath12k/wifi7/pci.c
index 608669a83ea7561b9a464f44b8dae14500d0a1d9..9b1acf6c7aa3121a53358a72a51aa21ead572a09 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/pci.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/pci.c
@@ -155,10 +155,16 @@ static int ath12k_wifi7_pci_probe(struct pci_dev *pdev,
 	return 0;
 }
 
+static const struct ath12k_pci_reg_base ath12k_wifi7_reg_base = {
+	.umac_base = HAL_SEQ_WCSS_UMAC_OFFSET,
+	.ce_reg_base = HAL_CE_WFSS_CE_REG_BASE,
+};
+
 static struct ath12k_pci_driver ath12k_wifi7_pci_driver = {
 	.name = "ath12k_wifi7_pci",
 	.id_table = ath12k_wifi7_pci_id_table,
 	.ops.probe = ath12k_wifi7_pci_probe,
+	.reg_base = &ath12k_wifi7_reg_base,
 };
 
 int ath12k_wifi7_pci_init(void)

-- 
2.34.1


