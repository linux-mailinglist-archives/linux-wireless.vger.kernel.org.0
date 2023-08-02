Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC3476C8E3
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Aug 2023 11:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjHBJAM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Aug 2023 05:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbjHBJAL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Aug 2023 05:00:11 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4032721
        for <linux-wireless@vger.kernel.org>; Wed,  2 Aug 2023 02:00:09 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3724MRM9014667;
        Wed, 2 Aug 2023 09:00:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=Wk4hq+6eu2PlB1HSXuD/GuvakDHvYqsRv33yHeeROKg=;
 b=N6goUYgxiL6ZQd776aXAM1F2f4VO6vGvTqsENTym7Jn7DU2g72qhY3mslsyKEc01u9ro
 pf9dqlqdr4SsfRKOY8uoGfPKYTvnSl4m7Mi4fnaIX2tZCQIA91QDklAoWW0UrcXarSTl
 VzFJC4cZR88J5PH6WfJC8PFbcmmSWrcco28EjwJl9DhVTB+17FgAD2FyX5Wwicv6d76s
 ceKgA51BZPvUYs1Ewrh5qIdzOAJE+i0DE8W6tb3Xj6FIG6snm1RsrhtpYIPlkqarMDNg
 /SymSlLBHP/nZ+mKqX9ImIsyFThlALuczV5eYOWHSaT19JwJeEZKdQjv6FOGsGzmA6Ww IQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s6rhaun5b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 09:00:06 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 372905GP015800
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Aug 2023 09:00:05 GMT
Received: from mdharane-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 2 Aug 2023 02:00:03 -0700
From:   Manish Dharanenthiran <quic_mdharane@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manish Dharanenthiran <quic_mdharane@quicinc.com>
Subject: [PATCH 2/2] wifi: ath12k: fix radar detection in 160 MHz
Date:   Wed, 2 Aug 2023 14:28:52 +0530
Message-ID: <20230802085852.19821-3-quic_mdharane@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230802085852.19821-1-quic_mdharane@quicinc.com>
References: <20230802085852.19821-1-quic_mdharane@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Gk8iFmFdeh5p9nlUn4L9Uf-njCM-eDuq
X-Proofpoint-ORIG-GUID: Gk8iFmFdeh5p9nlUn4L9Uf-njCM-eDuq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_03,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308020080
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Radar detection fails in the secondary 80 MHz when the
the AP's primary 80 MHz is in non-DFS region in 160 MHz.

This is due to WMI channel flag WMI_CHAN_INFO_DFS_FREQ2 is not set
properly in case of the primary 80 MHz is in non-DFS region.
HALPHY detects the radar pulses in the secondary 80 MHz only when
WMI_CHAN_INFO_DFS_FREQ2 is set.

Fix this issue by setting WMI channel flag WMI_CHAN_INFO_DFS_FREQ2
based on the radar_enabled flag from the channel context.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Manish Dharanenthiran <quic_mdharane@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 0ab95e138d1d..78177861e38f 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5450,12 +5450,13 @@ static void ath12k_mac_op_remove_chanctx(struct ieee80211_hw *hw,
 
 static int
 ath12k_mac_vdev_start_restart(struct ath12k_vif *arvif,
-			      const struct cfg80211_chan_def *chandef,
+			      struct ieee80211_chanctx_conf *ctx,
 			      bool restart)
 {
 	struct ath12k *ar = arvif->ar;
 	struct ath12k_base *ab = ar->ab;
 	struct wmi_vdev_start_req_arg arg = {};
+	const struct cfg80211_chan_def *chandef = &ctx->def;
 	int he_support = arvif->vif->bss_conf.he_support;
 	int ret;
 
@@ -5488,6 +5489,8 @@ ath12k_mac_vdev_start_restart(struct ath12k_vif *arvif,
 		/* For now allow DFS for AP mode */
 		arg.chan_radar = !!(chandef->chan->flags & IEEE80211_CHAN_RADAR);
 
+		arg.freq2_radar = ctx->radar_enabled;
+
 		arg.passive = arg.chan_radar;
 
 		spin_lock_bh(&ab->base_lock);
@@ -5595,15 +5598,15 @@ static int ath12k_mac_vdev_stop(struct ath12k_vif *arvif)
 }
 
 static int ath12k_mac_vdev_start(struct ath12k_vif *arvif,
-				 const struct cfg80211_chan_def *chandef)
+				 struct ieee80211_chanctx_conf *ctx)
 {
-	return ath12k_mac_vdev_start_restart(arvif, chandef, false);
+	return ath12k_mac_vdev_start_restart(arvif, ctx, false);
 }
 
 static int ath12k_mac_vdev_restart(struct ath12k_vif *arvif,
-				   const struct cfg80211_chan_def *chandef)
+				   struct ieee80211_chanctx_conf *ctx)
 {
-	return ath12k_mac_vdev_start_restart(arvif, chandef, true);
+	return ath12k_mac_vdev_start_restart(arvif, ctx, true);
 }
 
 struct ath12k_mac_change_chanctx_arg {
@@ -5702,7 +5705,7 @@ ath12k_mac_update_vif_chan(struct ath12k *ar,
 		 * If vdev is down then it expect vdev_stop->vdev_start.
 		 */
 		if (arvif->is_up) {
-			ret = ath12k_mac_vdev_restart(arvif, &vifs[i].new_ctx->def);
+			ret = ath12k_mac_vdev_restart(arvif, vifs[i].new_ctx);
 			if (ret) {
 				ath12k_warn(ab, "failed to restart vdev %d: %d\n",
 					    arvif->vdev_id, ret);
@@ -5716,7 +5719,7 @@ ath12k_mac_update_vif_chan(struct ath12k *ar,
 				continue;
 			}
 
-			ret = ath12k_mac_vdev_start(arvif, &vifs[i].new_ctx->def);
+			ret = ath12k_mac_vdev_start(arvif, vifs[i].new_ctx);
 			if (ret)
 				ath12k_warn(ab, "failed to start vdev %d: %d\n",
 					    arvif->vdev_id, ret);
@@ -5792,7 +5795,8 @@ static void ath12k_mac_op_change_chanctx(struct ieee80211_hw *hw,
 	if (WARN_ON(changed & IEEE80211_CHANCTX_CHANGE_CHANNEL))
 		goto unlock;
 
-	if (changed & IEEE80211_CHANCTX_CHANGE_WIDTH)
+	if (changed & IEEE80211_CHANCTX_CHANGE_WIDTH ||
+	    changed & IEEE80211_CHANCTX_CHANGE_RADAR)
 		ath12k_mac_update_active_vif_chan(ar, ctx);
 
 	/* TODO: Recalc radar detection */
@@ -5812,7 +5816,7 @@ static int ath12k_start_vdev_delay(struct ieee80211_hw *hw,
 	if (WARN_ON(arvif->is_started))
 		return -EBUSY;
 
-	ret = ath12k_mac_vdev_start(arvif, &arvif->chanctx.def);
+	ret = ath12k_mac_vdev_start(arvif, &arvif->chanctx);
 	if (ret) {
 		ath12k_warn(ab, "failed to start vdev %i addr %pM on freq %d: %d\n",
 			    arvif->vdev_id, vif->addr,
@@ -5890,7 +5894,7 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 		goto out;
 	}
 
-	ret = ath12k_mac_vdev_start(arvif, &ctx->def);
+	ret = ath12k_mac_vdev_start(arvif, ctx);
 	if (ret) {
 		ath12k_warn(ab, "failed to start vdev %i addr %pM on freq %d: %d\n",
 			    arvif->vdev_id, vif->addr,
-- 
2.17.1

