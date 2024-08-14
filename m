Return-Path: <linux-wireless+bounces-11411-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4F39517F8
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 11:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C2DE1F233EE
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 09:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDCD16B72E;
	Wed, 14 Aug 2024 09:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dryQXxNB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18B516C426
	for <linux-wireless@vger.kernel.org>; Wed, 14 Aug 2024 09:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723628686; cv=none; b=JXzxidz03HRHLLIJ1lV5ivReJIlBMJiiWVCuyj1377BkDxTNvM1+Sq8d/4i/EL7dBn6ONGn2x61bZE6KwmWfUfV77hHVo9hddCAgNujouvhSqFDs9saJrA4bHTQr6Bnhn3DfS7h7k2wxbPH95o6bEhQhoIHSlsS3giJOprSnXVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723628686; c=relaxed/simple;
	bh=KQZYxxleeaqN/Yeo4kXO23Grk8djSkHSwwZOQ2yCUqQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ljB8ulNqE5Kn8vIOEdLr7L52eFrzgxEXt1AEBx6+9a0j85Hgs4NOJ8ksa8yRN27YL335prP5iKjeCeYV7Io8g+NR1jGAX5ArB77KfJB1Fq+gzIrre3VZAo1H8KbO3RPhA2lFy4vAN5UgyDs5qPpkTqfjqlZaUPv4v5X5i/0ILj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dryQXxNB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47DNd3UM007278;
	Wed, 14 Aug 2024 09:44:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vaG34PLFmFjs0BgR6last4NA6RmV2h3wv6Npu2jPVz4=; b=dryQXxNBBrm7zaVD
	9/r+bHhIi1qTdls2Xvgi1+zOjGOLgfCjOkMhdGuI3tZ4k3Fp7INGOBGfh56zqQhB
	ZBA1rqL6EydfJad74mz8QkWYVccFDywRKMD1KvWR2TYKEB3VZhn+q5xlGTEp5iYh
	NobRYqrESoxo6rBq+D41mXMEw+UZE5e+0zp1hE+o3g/SLk3hXzbX/jtIOu4BgDGR
	ZU6+OWUd96WGizgNwsPAfDSy0Hn18H/5MuBgV0IUMvGsT6OuCePSG68deKgyX9mY
	9Ijg4RpQ/gt4mNkf/krH0qZ87MVzitTAGHK4CwbDlNqeYermszClFNPzDFM3aDxt
	T7UiUQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40x1682ghw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 09:44:42 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47E9if6O010565
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 09:44:41 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 14 Aug 2024 02:44:39 -0700
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Balamurugan S
	<quic_bselvara@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>,
        "Raj
 Kumar Bhagat" <quic_rajkbhag@quicinc.com>
Subject: [RFC PATCH 10/18] wifi: ath12k: add new CMEM read-write ath12k_hif_ops
Date: Wed, 14 Aug 2024 15:13:15 +0530
Message-ID: <20240814094323.3927603-11-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814094323.3927603-1-quic_rajkbhag@quicinc.com>
References: <20240814094323.3927603-1-quic_rajkbhag@quicinc.com>
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
X-Proofpoint-GUID: Q-u8xfJQ3OpOYpxT557hyXzzWtJxQH9a
X-Proofpoint-ORIG-GUID: Q-u8xfJQ3OpOYpxT557hyXzzWtJxQH9a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_07,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=864 impostorscore=0 malwarescore=0 spamscore=0
 mlxscore=0 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408140067

From: Balamurugan S <quic_bselvara@quicinc.com>

In IPQ5332 AHB device, CMEM region is outside of WCSS register block.
Hence, add new ath12k_hif_ops (cmem_read32 and cmem_write32) for
accessing CMEM register.

In PCI devices (QCN9274 and WCN7850), these cmem_read32/cmem_write32
are same as read32/write32 ath12k_hif_ops. Hence, use the same
functions for these new ath12k_hif_ops cmem_read32/cmem_write32.

Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1

Signed-off-by: Balamurugan S <quic_bselvara@quicinc.com>
Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.c  | 10 ++++++----
 drivers/net/wireless/ath/ath12k/hif.h | 13 +++++++++++++
 drivers/net/wireless/ath/ath12k/pci.c |  2 ++
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 61aa78d8bd8c..86cb3aa33e69 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -1468,7 +1468,7 @@ static int ath12k_dp_cmem_init(struct ath12k_base *ab,
 			       struct ath12k_dp *dp,
 			       enum ath12k_dp_desc_type type)
 {
-	u32 cmem_base;
+	u32 cmem_base, data;
 	int i, start, end;
 
 	cmem_base = ab->qmi.dev_mem[ATH12K_QMI_DEVMEM_CMEM_INDEX].start;
@@ -1489,9 +1489,11 @@ static int ath12k_dp_cmem_init(struct ath12k_base *ab,
 	}
 
 	/* Write to PPT in CMEM */
-	for (i = start; i < end; i++)
-		ath12k_hif_write32(ab, cmem_base + ATH12K_PPT_ADDR_OFFSET(i),
-				   dp->spt_info[i].paddr >> ATH12K_SPT_4K_ALIGN_OFFSET);
+	for (i = start; i < end; i++) {
+		data = dp->spt_info[i].paddr >> ATH12K_SPT_4K_ALIGN_OFFSET;
+		ath12k_hif_cmem_write32(ab, cmem_base + ATH12K_PPT_ADDR_OFFSET(i),
+					data);
+	}
 
 	return 0;
 }
diff --git a/drivers/net/wireless/ath/ath12k/hif.h b/drivers/net/wireless/ath/ath12k/hif.h
index 0e53ec269fa4..44e42065b551 100644
--- a/drivers/net/wireless/ath/ath12k/hif.h
+++ b/drivers/net/wireless/ath/ath12k/hif.h
@@ -12,6 +12,8 @@
 struct ath12k_hif_ops {
 	u32 (*read32)(struct ath12k_base *ab, u32 address);
 	void (*write32)(struct ath12k_base *ab, u32 address, u32 data);
+	u32 (*cmem_read32)(struct ath12k_base *sc, u32 address);
+	void (*cmem_write32)(struct ath12k_base *sc, u32 address, u32 data);
 	void (*irq_enable)(struct ath12k_base *ab);
 	void (*irq_disable)(struct ath12k_base *ab);
 	int (*start)(struct ath12k_base *ab);
@@ -132,6 +134,17 @@ static inline void ath12k_hif_write32(struct ath12k_base *ab, u32 address,
 	ab->hif.ops->write32(ab, address, data);
 }
 
+static inline u32 ath12k_hif_cmem_read32(struct ath12k_base *ab, u32 address)
+{
+	return ab->hif.ops->cmem_read32(ab, address);
+}
+
+static inline void ath12k_hif_cmem_write32(struct ath12k_base *ab, u32 address,
+					   u32 data)
+{
+	ab->hif.ops->cmem_write32(ab, address, data);
+}
+
 static inline int ath12k_hif_power_up(struct ath12k_base *ab)
 {
 	if (!ab->hif.ops->power_up)
diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index bd269aa1740b..0c393bc30f92 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -1316,6 +1316,8 @@ static const struct ath12k_hif_ops ath12k_pci_hif_ops = {
 	.stop = ath12k_pci_stop,
 	.read32 = ath12k_pci_read32,
 	.write32 = ath12k_pci_write32,
+	.cmem_read32 = ath12k_pci_read32,
+	.cmem_write32 = ath12k_pci_write32,
 	.power_down = ath12k_pci_power_down,
 	.power_up = ath12k_pci_power_up,
 	.suspend = ath12k_pci_hif_suspend,
-- 
2.34.1


