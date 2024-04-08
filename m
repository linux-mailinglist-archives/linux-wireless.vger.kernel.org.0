Return-Path: <linux-wireless+bounces-5964-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6794189B6B2
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Apr 2024 06:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E3642813BA
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Apr 2024 04:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AB1BA4B;
	Mon,  8 Apr 2024 04:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HxM1DIJp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801378494
	for <linux-wireless@vger.kernel.org>; Mon,  8 Apr 2024 04:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712549174; cv=none; b=c1KlFHz67EHa6gmhQ8GERc/6dMbl6hEJ+Ybth1CT+SKlcocV8SF8RfzNyRS/6a54k1KzPo0UKAQJ+CS3WGo1yllWryXBThnvmqEoJLhr5QZJxbZYLQrnJheX4tg7EtVdDro9kN6+yYhKJeej/zaYYgK2JFrFn4jxSRR9gaqjijs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712549174; c=relaxed/simple;
	bh=r3utNYvlKyZeoGwTKwYFJdIOAOaoPUQFtS+tCf6V95A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mXiSENAYIUwA/brYlT61EYNmrKYKvKYJrO5QQdKj9rC6jTrYjnzkmZfeSIhULCLsfjkTQtnizJiF/Kz13j9AQaXagru09MPtT1jfOH5sXk5phUJu4JnHqr0hFCJcrxf7QkX1fva/Er+SsfbWRzo3q9Imdx8iEagD8gpJrweHeIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HxM1DIJp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4383bZ1l019456;
	Mon, 8 Apr 2024 04:06:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=jP5fIqTKUXYP00EF8O+m9yJxW0BR3NepH5GAd2F4fls=; b=Hx
	M1DIJpnMzyxc+vSO7gV7VPnnl94noRWopGKnGX+6C7lbJeS+JEZzGRGtwP2j5JWB
	cUETuYVVtxYcyyiCqD56UxSzaJVHL4h1kkrBKli8sa8O2oR+JPB+8ISwXne3o3TD
	i8LiDXozigXhPhxJlLyFh3oOvf1O/7FxvX3OttH2Djv/A44hHgNzl9E34NO+WG3O
	X6ww+nwu7kpu81bQsEcPB4+71daQmqmOEf8fEE1eI98tw4NQ66T9egw60iI0z69e
	cSR5T/lnnCkVmDEsnzQh4CCzqduElLkClVIPa/gwFYd9lEKFjqmxn7IvxEumR3Rh
	lPYJI6mzRzj5zh0DXtEA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xaursjsmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 04:06:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 438466TC027773
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Apr 2024 04:06:06 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 7 Apr 2024 21:06:04 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 2/4] wifi: ath12k: Refactor the hardware cookie conversion init
Date: Mon, 8 Apr 2024 09:35:45 +0530
Message-ID: <20240408040547.837639-3-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408040547.837639-1-quic_periyasa@quicinc.com>
References: <20240408040547.837639-1-quic_periyasa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LK0UFZWHEuwC0mZzct0Tl3to519Nmk1R
X-Proofpoint-ORIG-GUID: LK0UFZWHEuwC0mZzct0Tl3to519Nmk1R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_02,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 clxscore=1015 spamscore=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404080029

Currently, the Rx descriptor is placed before the Tx descriptor in the
primary page table of the hardware cookie conversion configuration. The
Tx and Rx descriptor offsets are implicitly hardcoded. To allow for easy
displacement of Tx and Rx descriptors, introduce Tx and Rx offset based
cookie conversion initializationi. Additionally, should consider
validating the respective offset ranges while retrieving the Tx and Rx
descriptors. This change will be utilize by the next patch in the series.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.c | 25 +++++++++++++++++--------
 drivers/net/wireless/ath/ath12k/dp.h |  3 +++
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 796c757c0f58..c8b2eb80b160 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -1344,12 +1344,16 @@ struct ath12k_rx_desc_info *ath12k_dp_get_rx_desc(struct ath12k_base *ab,
 						  u32 cookie)
 {
 	struct ath12k_rx_desc_info **desc_addr_ptr;
-	u16 ppt_idx, spt_idx;
+	u16 start_ppt_idx, end_ppt_idx, ppt_idx, spt_idx;
 
 	ppt_idx = u32_get_bits(cookie, ATH12K_DP_CC_COOKIE_PPT);
 	spt_idx = u32_get_bits(cookie, ATH12K_DP_CC_COOKIE_SPT);
 
-	if (ppt_idx > ATH12K_NUM_RX_SPT_PAGES ||
+	start_ppt_idx = ATH12K_RX_SPT_PAGE_OFFSET;
+	end_ppt_idx = start_ppt_idx + ATH12K_NUM_RX_SPT_PAGES;
+
+	if (ppt_idx < start_ppt_idx ||
+	    ppt_idx >= end_ppt_idx ||
 	    spt_idx > ATH12K_MAX_SPT_ENTRIES)
 		return NULL;
 
@@ -1362,13 +1366,17 @@ struct ath12k_tx_desc_info *ath12k_dp_get_tx_desc(struct ath12k_base *ab,
 						  u32 cookie)
 {
 	struct ath12k_tx_desc_info **desc_addr_ptr;
-	u16 ppt_idx, spt_idx;
+	u16 start_ppt_idx, end_ppt_idx, ppt_idx, spt_idx;
 
 	ppt_idx = u32_get_bits(cookie, ATH12K_DP_CC_COOKIE_PPT);
 	spt_idx = u32_get_bits(cookie, ATH12K_DP_CC_COOKIE_SPT);
 
-	if (ppt_idx < ATH12K_NUM_RX_SPT_PAGES ||
-	    ppt_idx > ab->dp.num_spt_pages ||
+	start_ppt_idx = ATH12K_TX_SPT_PAGE_OFFSET;
+	end_ppt_idx = start_ppt_idx +
+		      (ATH12K_TX_SPT_PAGES_PER_POOL * ATH12K_HW_MAX_QUEUES);
+
+	if (ppt_idx < start_ppt_idx ||
+	    ppt_idx >= end_ppt_idx ||
 	    spt_idx > ATH12K_MAX_SPT_ENTRIES)
 		return NULL;
 
@@ -1397,15 +1405,16 @@ static int ath12k_dp_cc_desc_init(struct ath12k_base *ab)
 			return -ENOMEM;
 		}
 
+		ppt_idx = ATH12K_RX_SPT_PAGE_OFFSET + i;
 		dp->spt_info->rxbaddr[i] = &rx_descs[0];
 
 		for (j = 0; j < ATH12K_MAX_SPT_ENTRIES; j++) {
-			rx_descs[j].cookie = ath12k_dp_cc_cookie_gen(i, j);
+			rx_descs[j].cookie = ath12k_dp_cc_cookie_gen(ppt_idx, j);
 			rx_descs[j].magic = ATH12K_DP_RX_DESC_MAGIC;
 			list_add_tail(&rx_descs[j].list, &dp->rx_desc_free_list);
 
 			/* Update descriptor VA in SPT */
-			rx_desc_addr = ath12k_dp_cc_get_desc_addr_ptr(ab, i, j);
+			rx_desc_addr = ath12k_dp_cc_get_desc_addr_ptr(ab, ppt_idx, j);
 			*rx_desc_addr = &rx_descs[j];
 		}
 	}
@@ -1425,7 +1434,7 @@ static int ath12k_dp_cc_desc_init(struct ath12k_base *ab)
 			}
 
 			tx_spt_page = i + pool_id * ATH12K_TX_SPT_PAGES_PER_POOL;
-			ppt_idx = ATH12K_NUM_RX_SPT_PAGES + tx_spt_page;
+			ppt_idx = ATH12K_TX_SPT_PAGE_OFFSET + tx_spt_page;
 
 			dp->spt_info->txbaddr[tx_spt_page] = &tx_descs[0];
 
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 4939aa41dd87..57aba97cbdce 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -223,6 +223,9 @@ struct ath12k_pdev_dp {
 #define ATH12K_NUM_TX_SPT_PAGES	(ATH12K_TX_SPT_PAGES_PER_POOL * ATH12K_HW_MAX_QUEUES)
 #define ATH12K_NUM_SPT_PAGES	(ATH12K_NUM_RX_SPT_PAGES + ATH12K_NUM_TX_SPT_PAGES)
 
+#define ATH12K_TX_SPT_PAGE_OFFSET ATH12K_NUM_RX_SPT_PAGES
+#define ATH12K_RX_SPT_PAGE_OFFSET 0
+
 /* The SPT pages are divided for RX and TX, first block for RX
  * and remaining for TX
  */
-- 
2.34.1


