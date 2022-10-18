Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6C3602372
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Oct 2022 06:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiJREof (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Oct 2022 00:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiJREoc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Oct 2022 00:44:32 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE1BEE23
        for <linux-wireless@vger.kernel.org>; Mon, 17 Oct 2022 21:44:29 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29I4c4rp032450;
        Tue, 18 Oct 2022 04:43:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=E63McToEO+5GR1OxrHSfXxxbONbWf6a/sgBNcCkkE6o=;
 b=cQW+89Atl+I13YXeRXu5dAL47bk0Spphv8NmtxAyIo6iTeWinRkbv3DAR3zkfTQGN1D7
 AYipF9fXMerUGal1tEDxpn5pDiVe54yctkH1L8/UesAzJxccYoQpbLqs4O5lUbMBJJt3
 in7tJK7OCoNhSM+o+SRtDpBmX28qPALoUOdqmVIDarVUfwRHVgMS6hmWL8yRcuExgEJl
 atTzZ4+XiSLwTy/0GmWYD3uI8eltDaTknvSvzgcwpDJFCDSZ9atPB9S4c9OEFklNi2DA
 uu+K9aculiLfoyweZA92p9/qzLRTBOKeAnHE0ZkL1gFkpngIDiJNdr5AGfIGikcNi3Ct 4g== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k9jjmraep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 04:43:59 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29I4hxaj007121
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 04:43:59 GMT
Received: from ramess-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 17 Oct 2022 21:43:57 -0700
From:   Rameshkumar Sundaram <quic_ramess@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Subject: [PATCH] wifi: mac80211: Allow NSS change only up to capability
Date:   Tue, 18 Oct 2022 10:13:41 +0530
Message-ID: <20221018044341.5453-1-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vWgs_tLE1i1BmCv-l3HAB_FgdTg0MJx8
X-Proofpoint-ORIG-GUID: vWgs_tLE1i1BmCv-l3HAB_FgdTg0MJx8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_13,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1011
 phishscore=0 priorityscore=1501 mlxlogscore=882 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210180026
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stations can update bandwidth/NSS change in
VHT action frame with action type Operating Mode Notification.
(IEEE Std 802.11-2020 - 9.4.1.53 Operating Mode field)

For Operating Mode Notification, an RX NSS change to a value
greater than AP's maximum NSS should not be allowed.
Hence allow NSS change only up to maximum NSS that is negotiated
and capped to AP's capability during association.

Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
---
 net/mac80211/vht.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
index c804890dc623..fb1c55109884 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -623,7 +623,7 @@ u32 __ieee80211_vht_handle_opmode(struct ieee80211_sub_if_data *sdata,
 	enum ieee80211_sta_rx_bandwidth new_bw;
 	struct sta_opmode_info sta_opmode = {};
 	u32 changed = 0;
-	u8 nss;
+	u8 nss, cur_nss;
 
 	/* ignore - no support for BF yet */
 	if (opmode & IEEE80211_OPMODE_NOTIF_RX_NSS_TYPE_BF)
@@ -634,10 +634,22 @@ u32 __ieee80211_vht_handle_opmode(struct ieee80211_sub_if_data *sdata,
 	nss += 1;
 
 	if (link_sta->pub->rx_nss != nss) {
-		link_sta->pub->rx_nss = nss;
-		sta_opmode.rx_nss = nss;
-		changed |= IEEE80211_RC_NSS_CHANGED;
-		sta_opmode.changed |= STA_OPMODE_N_SS_CHANGED;
+		cur_nss = link_sta->pub->rx_nss;
+		link_sta->pub->rx_nss = 0;
+		ieee80211_sta_set_rx_nss(link_sta);
+		/* Do not allow an nss change to rx_nss greater than max_nss
+		 * negotiated and capped to APs capability during association.
+		 */
+		if (nss <= link_sta->pub->rx_nss) {
+			link_sta->pub->rx_nss = nss;
+			sta_opmode.rx_nss = nss;
+			changed |= IEEE80211_RC_NSS_CHANGED;
+			sta_opmode.changed |= STA_OPMODE_N_SS_CHANGED;
+		} else {
+			link_sta->pub->rx_nss = cur_nss;
+			pr_warn_ratelimited("Ignoring NSS change in VHT Operating Mode Notification from %pM with invalid nss %d",
+					    link_sta->pub->addr, nss);
+		}
 	}
 
 	switch (opmode & IEEE80211_OPMODE_NOTIF_CHANWIDTH_MASK) {
-- 
2.25.1

