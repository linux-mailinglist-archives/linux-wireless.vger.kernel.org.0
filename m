Return-Path: <linux-wireless+bounces-13115-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C234398438F
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2024 12:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F30C31C228B0
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2024 10:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4CB17BB2A;
	Tue, 24 Sep 2024 10:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SZyLajKB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF2A17BB0A
	for <linux-wireless@vger.kernel.org>; Tue, 24 Sep 2024 10:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727173471; cv=none; b=b9eW2FX7CjhmK5VNyrYfzdYMOBWrbz834GppqzfVUejHcV1oBToz7OZzbAY//9deJqCQfk9zr1I+/edoDEw5vgl0Hi1RjTsT7saqCY7DMy+53K2t3cB57iGXEfgpymehW+djkHxgO9rZZkAHDZBO8yy6uh2E4yvvjKLfu9pKnME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727173471; c=relaxed/simple;
	bh=MiiOd45xSOAIWRO5ngcTTR4qaDpknJ1R7K51gvfLfnk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IbyfowBlyMiPAn15hA9SvH9Ol/ZLYypH/Gg29nEvJvg40UUY/XVz/Au5VW5mw2dm4hUJ6h/IYzLzj+5oqa67REV6W23d7W12x0mMQzEgwu2XSOqty5O3R0lEtGTfsISkBgEXTP4q+yYx4Rq/XirzFWpq1qBhBCvzOqRCOHN1wsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SZyLajKB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48O9fjMJ023720;
	Tue, 24 Sep 2024 10:24:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U1SZmxIT+4HfYQdxW3ohXjKxXq2anXPfHDwjAiGWhmg=; b=SZyLajKBysUaSoOW
	5LGbPdAw7HZe+OPez8vJcCvKle4KKjW8TNsLpNww/C5fIhZW53hpimn76eKFL5oi
	w50ws32oCrGMhZibMAGJgSGdh2LaGGvtBRdOO32FDFNmL4ELnbd8VXj0/GxZuzWA
	xpE93AOWWlQ16a1OBOhxX2PxjgzuWkHXEBdmRpcRFeIR1iEa4nGIo2TUAP43YU2U
	JNhfmqi95g1mOnnoZioW9YTteF7ncmIlj6TFr13RB36W0H/buO2BSorm9bNYOJPP
	fsZUUr00znLh2tgdjrEeTX94j919Q/0LjR4UonE35WjNj/wceNpZuAIFlQZDFmd6
	eu1Q4Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41skgn8m4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 10:24:26 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48OAOP7I015952
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 10:24:25 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 24 Sep 2024 03:24:23 -0700
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v2 1/2] wifi: ath11k: fix RCU stall while reaping monitor destination ring
Date: Tue, 24 Sep 2024 18:23:44 +0800
Message-ID: <20240924102345.811-2-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20240924102345.811-1-quic_kangyang@quicinc.com>
References: <20240924102345.811-1-quic_kangyang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hCTwDJA6kdbe3kLLL2r7E90DpR-2sSVm
X-Proofpoint-GUID: hCTwDJA6kdbe3kLLL2r7E90DpR-2sSVm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0 impostorscore=0
 spamscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409240072

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
……

Fix this by skipping the problematic buf_id and reaping the next entry,
replacing the break with the next MSDU processing.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
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


