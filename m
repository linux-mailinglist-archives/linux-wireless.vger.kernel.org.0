Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14A4722563
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jun 2023 14:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbjFEMRx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Jun 2023 08:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbjFEMRw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Jun 2023 08:17:52 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3BFA1
        for <linux-wireless@vger.kernel.org>; Mon,  5 Jun 2023 05:17:51 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 355AWF6I002952;
        Mon, 5 Jun 2023 12:17:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=etSRraY+YlwDG1Jy9nTdUcmr3fLuE/bD49cuaIRm+Xo=;
 b=gq4m0dcnEt/h1xGeNbGMP19inDV6PKmcCXv78yooMMShTm9ZQEwX0ktL1Aw0nNcckT+U
 0rVQhb216LXDePoDvFa5UIeuqu+MUzs0NjlrD1PxpdiPDbJpMwZWsxLpWkQ9FEBch7y3
 s7Si496QwCrsAgQDlR0eJzoHGSMcepWRR0SdeSXzMYH5ZEaU+w5PWw1y7M0+HzVd05lT
 /HH0Ov7jHwMMcP4JbfWiJ9H0a8JLhtRim1Bxt+0KkJEqaWRuVMkOInuUQ5oBgJVyMvUb
 3Z5z2mtvDW3NY4EpfDCtM9q/pQA0uebmPPoVPIRMnyZYFVPXyfDF96jSrci7jeiFdzTY rQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qyw46bjrk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jun 2023 12:17:47 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 355CHk42015706
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 5 Jun 2023 12:17:46 GMT
Received: from aarasahu-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 5 Jun 2023 05:17:44 -0700
From:   Aaradhana Sahu <quic_aarasahu@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>,
        Aaradhana Sahu <quic_aarasahu@quicinc.com>
Subject: [PATCH 2/3] wifi: ath11k: Fix tkip encryption traffic failure
Date:   Mon, 5 Jun 2023 17:47:21 +0530
Message-ID: <20230605121722.20797-3-quic_aarasahu@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230605121722.20797-1-quic_aarasahu@quicinc.com>
References: <20230605121722.20797-1-quic_aarasahu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eDz2ibQvLeqanXmnCfzSHXZ3nIgJmxA8
X-Proofpoint-GUID: eDz2ibQvLeqanXmnCfzSHXZ3nIgJmxA8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-03_08,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306050109
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>

Currently, we are getting NULL value for fast_rx because
fast_rx is not assigned in case of TKIP cipher and hence
packets are dropped in fast path.

Fix this issue by handling the rx decap for TKIP so frames
will be handled in normal rx path.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Signed-off-by: Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>
Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.h  |  2 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c | 15 ++++++++++-----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 0830276e5028..bb9acdda5aa8 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -122,7 +122,7 @@ struct ath11k_skb_rxcb {
 	bool is_last_msdu;
 	bool is_continuation;
 	bool is_mcbc;
-	bool is_eapol;
+	bool skip_decap;
 	struct hal_rx_desc *rx_desc;
 	u8 err_rel_src;
 	u8 err_code;
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 99859b59138e..03eeb3dfbb15 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -2168,9 +2168,14 @@ static void ath11k_dp_rx_h_undecap(struct ath11k *ar, struct sk_buff *msdu,
 	case DP_RX_DECAP_TYPE_ETHERNET2_DIX:
 		ehdr = (struct ethhdr *)msdu->data;
 
-		/* mac80211 allows fast path only for authorized STA */
-		if (ehdr->h_proto == cpu_to_be16(ETH_P_PAE)) {
-			ATH11K_SKB_RXCB(msdu)->is_eapol = true;
+		/* Fast_rx expects the STA to be authorized and
+		 * its not assigned for TKIP cipher. Hence, set
+		 * this flag to handle the EAPOL and TKIP packets
+		 * in the normal path.
+		 */
+		if (ehdr->h_proto == cpu_to_be16(ETH_P_PAE) ||
+		    enctype == HAL_ENCRYPT_TYPE_TKIP_MIC) {
+			ATH11K_SKB_RXCB(msdu)->skip_decap = true;
 			ath11k_dp_rx_h_undecap_eth(ar, msdu, first_hdr,
 						   enctype, status);
 			break;
@@ -2423,7 +2428,7 @@ static void ath11k_dp_rx_deliver_msdu(struct ath11k *ar, struct napi_struct *nap
 	struct ath11k_skb_rxcb *rxcb = ATH11K_SKB_RXCB(msdu);
 	u8 decap = DP_RX_DECAP_TYPE_RAW;
 	bool is_mcbc = rxcb->is_mcbc;
-	bool is_eapol = rxcb->is_eapol;
+	bool skip_decap = rxcb->skip_decap;
 
 	if (status->encoding == RX_ENC_HE &&
 	    !(status->flag & RX_FLAG_RADIOTAP_HE) &&
@@ -2479,7 +2484,7 @@ static void ath11k_dp_rx_deliver_msdu(struct ath11k *ar, struct napi_struct *nap
 	 * Also, fast_rx expects the STA to be authorized, hence
 	 * eapol packets are sent in slow path.
 	 */
-	if (decap == DP_RX_DECAP_TYPE_ETHERNET2_DIX && !is_eapol &&
+	if (decap == DP_RX_DECAP_TYPE_ETHERNET2_DIX && !skip_decap &&
 	    !(is_mcbc && rx_status->flag & RX_FLAG_DECRYPTED))
 		rx_status->flag |= RX_FLAG_8023;
 
-- 
2.17.1

