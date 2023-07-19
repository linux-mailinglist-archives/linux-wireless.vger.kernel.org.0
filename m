Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127D6758E0F
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jul 2023 08:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjGSGos (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Jul 2023 02:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjGSGor (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Jul 2023 02:44:47 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53EE1BF3
        for <linux-wireless@vger.kernel.org>; Tue, 18 Jul 2023 23:44:46 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36J6Orfl031221;
        Wed, 19 Jul 2023 06:44:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=Cb6DvDrWEBxB94sYgoPejnVukAljeQUEaVmedz+ukXs=;
 b=HlsLQn2xD6HtBIZQEthzpKSeXZESRkddcAQiD5Oet3J6n55JVq3tnt2Fltoacsq7U8ma
 mmFBf/yyjci1Eu73cUnKZ05gHLNNrZAZaTJxVyh65GtZLkGNGqmPaMVsRhWO7INU2lPc
 vMzerK6MpD8+PCi+OTDDP/dbJY353lwthfC45aVxxIpNENf/4Tix5ynFswDXandtgA0D
 7fBFWNHs/mGqptmX8Cc5m1TNgs3mlxEyRiMT69IKAOO8UkIi0Ce8hzbsQbwkvWuIYZXq
 bwuhPG79g6OCN5L/DteSDn5fm5LG+mpp9W0s9J/rbWwiBMPF/OkxKDpI6tDSjiqhYUGV KA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rwpphjjt3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 06:44:42 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36J6igxP018181
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 06:44:42 GMT
Received: from haric-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 18 Jul 2023 23:44:40 -0700
From:   Hari Chandrakanthan <quic_haric@quicinc.com>
To:     <quic_kvalo@quicinc.com>, <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Hari Chandrakanthan <quic_haric@quicinc.com>
Subject: wifi: ath12k: do not drop data frames from unassociated stations
Date:   Wed, 19 Jul 2023 12:14:34 +0530
Message-ID: <1689749074-14676-1-git-send-email-quic_haric@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HoYQ6VSeFuLvzvFq17LZrP-95rri9Ztz
X-Proofpoint-ORIG-GUID: HoYQ6VSeFuLvzvFq17LZrP-95rri9Ztz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_03,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1011
 bulkscore=0 mlxlogscore=834 malwarescore=0 mlxscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307190063
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From 'IEEE Std 802.11-2020 section 11.3.4.1':
If STA A in an infrastructure BSS receives a Class 2 or Class 3 frame
from STA B that is not authenticated with STA A
(i.e., the state for STA B is State 1), STA A shall discard the frame.
If the frame has an individual address in the Address 1 field,
the MLME of STA A shall send a Deauthentication frame to STA B.

When data frames from unassociated stations are received by an AP,
the AP is supposed to send a deauthentication/disassociation frame with
reason code "Class 2 frame received from nonauthenticated STA" or
"Class 3 frame received from nonassociated STA".

But ath12k AP doesn't send deauthentication/disassociation frames,
when it receives data frames from unassociated stations.

The ath12k driver drops the data frames from unassociated
station and the upper layer(mac80211/hostapd) is not aware of such event.
Hence deauthentication/disassociation frame is not sent to that
particular station by the AP.

To address this issue, allow the data frames from the
unassociated stations to reach mac80211 so that mac80211 can send
NL80211_CMD_UNEXPECTED_FRAME event to userspace(hostapd) and hostapd
upon receiving the event will send the deauthentication/disassociation
frame with proper reason code.

The data frame from unassociated stations gets dropped in mac80211.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0-02903-QCAHKSWPL_SILICONZ-1

Signed-off-by: Hari Chandrakanthan <quic_haric@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 0adcbcf..90eaf2d 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -3485,23 +3485,13 @@ static int ath12k_dp_rx_h_null_q_desc(struct ath12k *ar, struct sk_buff *msdu,
 				      struct sk_buff_head *msdu_list)
 {
 	struct ath12k_base *ab = ar->ab;
-	u16 msdu_len, peer_id;
+	u16 msdu_len;
 	struct hal_rx_desc *desc = (struct hal_rx_desc *)msdu->data;
 	u8 l3pad_bytes;
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
 	u32 hal_rx_desc_sz = ar->ab->hw_params->hal_desc_sz;
 
 	msdu_len = ath12k_dp_rx_h_msdu_len(ab, desc);
-	peer_id = ath12k_dp_rx_h_peer_id(ab, desc);
-
-	spin_lock(&ab->base_lock);
-	if (!ath12k_peer_find_by_id(ab, peer_id)) {
-		spin_unlock(&ab->base_lock);
-		ath12k_dbg(ab, ATH12K_DBG_DATA, "invalid peer id received in wbm err pkt%d\n",
-			   peer_id);
-		return -EINVAL;
-	}
-	spin_unlock(&ab->base_lock);
 
 	if (!rxcb->is_frag && ((msdu_len + hal_rx_desc_sz) > DP_RX_BUFFER_SIZE)) {
 		/* First buffer will be freed by the caller, so deduct it's length */
-- 
2.7.4

