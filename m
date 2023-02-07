Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E7D68D5D8
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Feb 2023 12:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjBGLmm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Feb 2023 06:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbjBGLm2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Feb 2023 06:42:28 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835271285B
        for <linux-wireless@vger.kernel.org>; Tue,  7 Feb 2023 03:42:14 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 317BTIlJ005245;
        Tue, 7 Feb 2023 11:42:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=Z6R2AwWpvH2rHLQ4wG9MZ1aEO5qqWyK1EnBRyIcp5Dk=;
 b=XUozPto6Hc4QYIsQe79kXTnFYrqBZqdCUv5oeT5iP6cmMxjp8LFkgD8rVbljWe7HiQbd
 s4w1cCm3S1COoBOc3yju3RtTAPOnZ+c6RD6zg06OoiJmGx8bnbU6gZS7ONgRl/B1OXJN
 5C/JOkYWEVdaAQA7HIemfbf3pVBNNgCBc+BImJ3Lrk9ZBJ3JzqvjKtYiF0mr744UAXWV
 igLBHOSykDZT+m4epBNvxzkAS0jJ3dBZdEZIH4veHrvRMpYZLCoMNSJklMDpg4Ce0MVs
 4cPmWs1VwMqOnQdoQx/rU3jBfHdzSjNxUjTgLB2wVri45vfvYvArl9Db0iyQCHbUjHbR Cw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nkdun94nw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Feb 2023 11:42:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 317BgAbD025772
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Feb 2023 11:42:10 GMT
Received: from ramess-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 7 Feb 2023 03:42:08 -0800
From:   Rameshkumar Sundaram <quic_ramess@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Subject: [PATCH v2] wifi: mac80211: Allow NSS change only up to capability
Date:   Tue, 7 Feb 2023 17:11:46 +0530
Message-ID: <20230207114146.10567-1-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: juCZ5BHUjAmANU2GKA2vyV5FhRWRxq_E
X-Proofpoint-ORIG-GUID: juCZ5BHUjAmANU2GKA2vyV5FhRWRxq_E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-07_02,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 bulkscore=0 clxscore=1015
 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302070104
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
During fuzz testing, by forcefully sending VHT Op. mode notif.
frames from STA with random rx_nss values, it is found that AP
accepts rx_nss values greater that APs maximum NSS instead of
discarding such NSS change.

Hence allow NSS change only up to maximum NSS that is negotiated
and capped to AP's capability during association.

Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
---
Changes since v1:
- Updated commmit log
- Added comment to specify nss reset logic
---
 net/mac80211/vht.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
index 803de5881485..c1250aa47808 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -625,7 +625,7 @@ u32 __ieee80211_vht_handle_opmode(struct ieee80211_sub_if_data *sdata,
 	enum ieee80211_sta_rx_bandwidth new_bw;
 	struct sta_opmode_info sta_opmode = {};
 	u32 changed = 0;
-	u8 nss;
+	u8 nss, cur_nss;
 
 	/* ignore - no support for BF yet */
 	if (opmode & IEEE80211_OPMODE_NOTIF_RX_NSS_TYPE_BF)
@@ -636,10 +636,25 @@ u32 __ieee80211_vht_handle_opmode(struct ieee80211_sub_if_data *sdata,
 	nss += 1;
 
 	if (link_sta->pub->rx_nss != nss) {
-		link_sta->pub->rx_nss = nss;
-		sta_opmode.rx_nss = nss;
-		changed |= IEEE80211_RC_NSS_CHANGED;
-		sta_opmode.changed |= STA_OPMODE_N_SS_CHANGED;
+		cur_nss = link_sta->pub->rx_nss;
+		/* Reset rx_nss and call ieee80211_sta_set_rx_nss() which
+		 * will set the same to max nss value calculated based on capability.
+		 */
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

base-commit: 4ca69027691a0039279b64cfa0aa511d9c9fde59
-- 
2.17.1

