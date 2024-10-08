Return-Path: <linux-wireless+bounces-13684-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5618993E67
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 07:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48DCDB20BD2
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 05:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C848144D0C;
	Tue,  8 Oct 2024 05:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="S/H0+z0p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8B1143895
	for <linux-wireless@vger.kernel.org>; Tue,  8 Oct 2024 05:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728365911; cv=none; b=SH8izXsxdt7+K32PjeXZq8DFXkjDdoCJlWOOWnXQ1OreGs+LDBkcHwhLdYo9yISkpLUK6UUvuzjZUBvgnMIFX2miTw5lxrn7rTRVCI0teAm+0sxxsvBlfde2pBUoFFwxRNJ5CFZIMXph5j+0XFTl3YvGxv2wrsuvRYcWjFCFPKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728365911; c=relaxed/simple;
	bh=YRhFTU/QBu0gFn5QRZPXu0k3AQFapImD8pKEz430aro=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k62J7tqPJOwPf34wrDIvpIw9neUY2xT3n1ycGyUFpTbRVWMmW/MzlyG7nOERAndIteF7ooPgmFn7vZf2vyTLc0KqRfcxn2G7joAaXrKxrqtLXENS9JxNkCDLFK7v86JpANNXIKs6KzO6c5//T4GtNlQTNvJRkDb68mXPgXxBzEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=S/H0+z0p; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497F5nSk025512;
	Tue, 8 Oct 2024 05:38:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TE73lGoQ1NcUKCnwJ0KJ/vs9nnyALSG6hcMec1hCGKI=; b=S/H0+z0pNCZIpkLM
	AdpOqC3nywTbigWh15svyYrzIxxT+SzWHuL42ttRkiG4T2v37isZZW5YAfJeK1Y7
	ZYLYvSzxsU0vHA5bbEoAoDsWQDqTG1u419z6yPDwq1qo6Sl2oeXbJKcL5X8LOJUM
	QT8IC2YqfmfdcLAFat9oRyZ8cSfWCrDJm/hr+pMSZthekt6T6frzSiqDwDX6JS7p
	Sl+EzUMbvhjM7TiTeJWsTJgc8yXdcq1sOW9ok+e1gurbQxPowmIjP8qQToVq7G8W
	8NCV+lv8j/gaZvkcpiK9uTbFVhl6SIwG6XHkZNMO9aOkE9UXvnOYQNnS0PMYZfLw
	QFvPuw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 422xs8685u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 05:38:27 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4985cQrs030382
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 8 Oct 2024 05:38:26 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 7 Oct 2024 22:38:25 -0700
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v3 1/2] wifi: ath11k: fix RCU stall while reaping monitor destination ring
Date: Tue, 8 Oct 2024 13:37:43 +0800
Message-ID: <20241008053744.1070-2-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20241008053744.1070-1-quic_kangyang@quicinc.com>
References: <20241008053744.1070-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-GUID: a1er5T8D5djG_C-2Z5Y6oOT4fFNS9uK9
X-Proofpoint-ORIG-GUID: a1er5T8D5djG_C-2Z5Y6oOT4fFNS9uK9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080035

From: P Praneesh <quic_ppranees@quicinc.com>

While processing the monitor destination ring, MSDUs are reaped from the
link descriptor based on the corresponding buf_id.

However, sometimes the driver cannot obtain a valid buffer corresponding
to the buf_id received from the hardware. This causes an infinite loop
in the destination processing, resulting in a kernel crash.

kernel log:
ath11k_pci 0000:58:00.0: data msdu_pop: invalid buf_id 309
ath11k_pci 0000:58:00.0: data dp_rx_monitor_link_desc_return failed
ath11k_pci 0000:58:00.0: data msdu_pop: invalid buf_id 309
ath11k_pci 0000:58:00.0: data dp_rx_monitor_link_desc_return failed

Fix this by skipping the problematic buf_id and reaping the next entry,
replacing the break with the next MSDU processing.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index c087d8a0f5b2..072963d3396c 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -4781,7 +4781,7 @@ ath11k_dp_rx_mon_mpdu_pop(struct ath11k *ar, int mac_id,
 			if (!msdu) {
 				ath11k_dbg(ar->ab, ATH11K_DBG_DATA,
 					   "msdu_pop: invalid buf_id %d\n", buf_id);
-				break;
+				goto next_msdu;
 			}
 			rxcb = ATH11K_SKB_RXCB(msdu);
 			if (!rxcb->unmapped) {
@@ -5405,7 +5405,7 @@ ath11k_dp_rx_full_mon_mpdu_pop(struct ath11k *ar,
 					   "full mon msdu_pop: invalid buf_id %d\n",
 					    buf_id);
 				spin_unlock_bh(&rx_ring->idr_lock);
-				break;
+				goto next_msdu;
 			}
 			idr_remove(&rx_ring->bufs_idr, buf_id);
 			spin_unlock_bh(&rx_ring->idr_lock);
-- 
2.34.1


