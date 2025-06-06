Return-Path: <linux-wireless+bounces-23792-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7662ACFC0D
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 06:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58C447A6A96
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 04:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D681D5160;
	Fri,  6 Jun 2025 04:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i2Zdaco+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494171FB3
	for <linux-wireless@vger.kernel.org>; Fri,  6 Jun 2025 04:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749185409; cv=none; b=ktGw9B/VcrDCF4jKHodLL+T5r/uPemgIxeIBhl/scsW0ify4pobpAG7gZqFRUxPkJmf28Im/RxnQYWEvg+mHWYvzyNwT6A9O9BaSEqm8jiJJ8sUmHbjAf6BB6vTyof9SBV1hDu6agfXTgz5+9V6JsBYgmrJTq1lw6S1y/SBziB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749185409; c=relaxed/simple;
	bh=na8xMFL2jooZAspxjCBVxBtaw4yblQk0diE4Mh2k5qU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sBHKGVZVOZgBL1K/v94vudqofwdyn523A5AybpC9mpe3Eyb5KkrxEbksyIFSyOCDDKvvENZuV8ADsNygUEz5pKtqFpM3zbbJZnUxxZ0LfYDK9fEQjcJ9vby+KWlOKIGVvFsHRzwDHeod9kgNKwYjCtLgOHe6qs5naXIYTvUaAOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i2Zdaco+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555HSJIn027548;
	Fri, 6 Jun 2025 04:49:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=si8Ol2NHn3T48qKxxqD1shQN7MimbwuEOdm
	5ZpS/HKU=; b=i2Zdaco+DnVyg1SD5+Bi8gSDIjT+zXcfFET/+y/PL8fM5/FqiUd
	3FV2RPqO2Gd74OJS0bhmeaonkmGlOioe/Zyf2bnQfscqyxta2GKfdBWBRBUeh8j8
	uIrEWubQyNp+kt/wNnKvp3hpt6jFICkUQq63dalvoaUGPBlFNFVjb2nqpvgVWNRH
	yjoIPzrZnSnJeZIhqv00byvTPADbw3kIvW6j5+xdTjLEyUG3J2RRKgWdqBoVG4iS
	9JPe5/8bGdVbyuGsnpFaHGivfmrMGTLXishmbfcpzujNTtAAsIrOyyxN8kJouqRq
	mphxgBKQHrZ8mHe4PhC802DJYExS+3Rx8XQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8tbfdt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Jun 2025 04:49:49 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5564niWt026082;
	Fri, 6 Jun 2025 04:49:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 46ytumx7qr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Jun 2025 04:49:44 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5564nirN026071;
	Fri, 6 Jun 2025 04:49:44 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-tamizhr-blr.qualcomm.com [10.190.110.180])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 5564niUU026070
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Jun 2025 04:49:44 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 380741)
	id 2C8A041143; Fri,  6 Jun 2025 10:19:43 +0530 (+0530)
From: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: Pass ab pointer directly to ath12k_dp_tx_get_encap_type()
Date: Fri,  6 Jun 2025 10:19:36 +0530
Message-Id: <20250606044936.3989400-1-tamizh.raja@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=eJQTjGp1 c=1 sm=1 tr=0 ts=6842736e cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=fH4NpVBEuyB-FspdvbcA:9
X-Proofpoint-ORIG-GUID: YTBlyS9_HmLsArGjvQRpOY4K-m2vJv3I
X-Proofpoint-GUID: YTBlyS9_HmLsArGjvQRpOY4K-m2vJv3I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDA0MiBTYWx0ZWRfXwYSNyAuI6bom
 jndIuO68O2r4tfBkDzK/uJlj8ol3mHWBNKM6EooRQCC1AJngv6bqWQQUFR+fof1bZPd30OqJBG/
 lMTTBzUoEBUn7H8tA0j9MEYVQUSp2vpYH2KhMcvDg25J+Ltjyxfx8SmciQ6CBEbGCp29pYiqnXp
 Ma46v7YS7Uk9mY1JzMitbGHER+UzmsugMLo4aKAxV7DywFl4a221duKOwjyn/R9hmTPzTigjylW
 xDVL2CvJeYlLDoBKcqG8tRZqbqu4JgGs+3ay2sGOYDvKPybsTMMLpL9LthuNTKrvNfuLToCVqmA
 BFlJhwCWsFULWd/ki9hbD8jNA9LOD1d3UhESgsXpy9okgi6PupNIR08dLed12AZK1FQqR5t4+o+
 Xi8x9hCT4K6Dke07bcu6IjcFPZhlzvJ1m2znTzfT+6pcT6gR1M6TlpB5U/SjyI20Ee1iuZYH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_01,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 bulkscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 phishscore=0 mlxscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506060042

In ath12k_dp_tx_get_encap_type(), the arvif parameter is only used to
retrieve the ab pointer. In vdev delete sequence the arvif->ar could
become NULL and that would trigger kernel panic.
Since the caller ath12k_dp_tx() already has a valid ab pointer, pass it
directly to avoid panic and unnecessary dereferencing.

PC points to "ath12k_dp_tx+0x228/0x988 [ath12k]"
LR points to "ath12k_dp_tx+0xc8/0x988 [ath12k]".
The Backtrace obtained is as follows:
ath12k_dp_tx+0x228/0x988 [ath12k]
ath12k_mac_tx_check_max_limit+0x608/0x920 [ath12k]
ieee80211_process_measurement_req+0x320/0x348 [mac80211]
ieee80211_tx_dequeue+0x9ac/0x1518 [mac80211]
ieee80211_tx_dequeue+0xb14/0x1518 [mac80211]
ieee80211_tx_prepare_skb+0x224/0x254 [mac80211]
ieee80211_xmit+0xec/0x100 [mac80211]
__ieee80211_subif_start_xmit+0xc50/0xf40 [mac80211]
ieee80211_subif_start_xmit+0x2e8/0x308 [mac80211]
netdev_start_xmit+0x150/0x18c
dev_hard_start_xmit+0x74/0xc0

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Fixes: e93bbd65547e ("wifi: ath12k: fix packets are sent in native wifi mode while we set raw mode")
Signed-off-by: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp_tx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index b6816b6c2c04..075912eacfaa 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -13,10 +13,9 @@
 #include "mac.h"
 
 static enum hal_tcl_encap_type
-ath12k_dp_tx_get_encap_type(struct ath12k_link_vif *arvif, struct sk_buff *skb)
+ath12k_dp_tx_get_encap_type(struct ath12k_base *ab, struct sk_buff *skb)
 {
 	struct ieee80211_tx_info *tx_info = IEEE80211_SKB_CB(skb);
-	struct ath12k_base *ab = arvif->ar->ab;
 
 	if (test_bit(ATH12K_FLAG_RAW_MODE, &ab->dev_flags))
 		return HAL_TCL_ENCAP_TYPE_RAW;
@@ -305,7 +304,7 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
 			u32_encode_bits(mcbc_gsn, HTT_TCL_META_DATA_GLOBAL_SEQ_NUM);
 	}
 
-	ti.encap_type = ath12k_dp_tx_get_encap_type(arvif, skb);
+	ti.encap_type = ath12k_dp_tx_get_encap_type(ab, skb);
 	ti.addr_search_flags = arvif->hal_addr_search_flags;
 	ti.search_type = arvif->search_type;
 	ti.type = HAL_TCL_DESC_TYPE_BUFFER;

base-commit: 1b98f357dadd6ea613a435fbaef1a5dd7b35fd21
-- 
2.34.1


