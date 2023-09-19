Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C822C7A5AB1
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Sep 2023 09:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjISHRs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Sep 2023 03:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjISHRr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Sep 2023 03:17:47 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B301EFC
        for <linux-wireless@vger.kernel.org>; Tue, 19 Sep 2023 00:17:41 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38J68kOH019141;
        Tue, 19 Sep 2023 07:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=hGyq9ihHkxlut94AhRS/2Mgoj005wpiMbe1t/CRvrmU=;
 b=gVelRH4vYG/8t1ab4IahcaPSKZQkWA8N1+TlBnyOYebZaBc5vkoD+8sD+07D8dXNO4iY
 mImVx6Vannmp2nmDkXOGLRbBm5q48OIFo5yALJM7fp9ViyEd5fG0T6Mwmw0DjejnM2v9
 YMnPRwEtD/tm6jO/Ib+52QAMyzt6P4766wct7i+Tyv2rDrg4lcMdQDDnbzopBbdlP5Qq
 ++1dYJPS/FkppqqIG7j5VzGTMenUruYCxNl93QfW5ggdbiI7wZ9OT1uoBSOgpcwvKy7R
 EB/h5vUuLVmt3fu3ySub56Pbuvt/RVgydLvaPQv9Hu1sy2l/AFWRJt/Pz3/vc3ZOqBxC uQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t6nh7a4sh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Sep 2023 07:17:40 +0000
Received: from pps.filterd (NASANPPMTA03.qualcomm.com [127.0.0.1])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 38J7GhD9020364;
        Tue, 19 Sep 2023 07:17:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA03.qualcomm.com (PPS) with ESMTP id 3t7386je0u-1;
        Tue, 19 Sep 2023 07:17:39 +0000
Received: from NASANPPMTA03.qualcomm.com (NASANPPMTA03.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38J7Hdwa022206;
        Tue, 19 Sep 2023 07:17:39 GMT
Received: from aisr-linux.qualcomm.com (aisr-linux.qualcomm.com [10.201.124.194])
        by NASANPPMTA03.qualcomm.com (PPS) with ESMTP id 38J7Hc2k022181;
        Tue, 19 Sep 2023 07:17:39 +0000
Received: by aisr-linux.qualcomm.com (Postfix, from userid 4090849)
        id 333F1E020C5; Tue, 19 Sep 2023 12:47:37 +0530 (IST)
From:   Aishwarya R <quic_aisr@quicinc.com>
To:     ath12k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, Aishwarya R <quic_aisr@quicinc.com>
Subject: [PATCH 3/7] wifi: ath12k: get 6 GHz power type from HE operation element
Date:   Tue, 19 Sep 2023 12:47:20 +0530
Message-Id: <20230919071724.15505-4-quic_aisr@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230919071724.15505-1-quic_aisr@quicinc.com>
References: <20230919071724.15505-1-quic_aisr@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1iP_pd3X1808r2SUCG0TiNF2OJhUNaeX
X-Proofpoint-GUID: 1iP_pd3X1808r2SUCG0TiNF2OJhUNaeX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_01,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 spamscore=0
 adultscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309190060
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When 6 GHz AP or STA is assigned a channel ctx, it needs to
extract the power type from HE operation element.
If unset power type is present, by default IEEE80211_REG_LPI_AP
power mode will be used.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aishwarya R <quic_aisr@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 5b9af264d305..01f81b087fa2 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5823,6 +5823,7 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 	struct ath12k_vif *arvif = (void *)vif->drv_priv;
 	int ret;
 	struct ath12k_wmi_peer_create_arg param;
+	enum ieee80211_ap_reg_power power_type;
 
 	mutex_lock(&ar->conf_mutex);
 
@@ -5830,6 +5831,16 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 		   "mac chanctx assign ptr %pK vdev_id %i\n",
 		   ctx, arvif->vdev_id);
 
+	if (ar->supports_6ghz && ctx->def.chan->band == NL80211_BAND_6GHZ &&
+	    (arvif->vdev_type == WMI_VDEV_TYPE_STA ||
+	     arvif->vdev_type == WMI_VDEV_TYPE_AP)) {
+		power_type = vif->bss_conf.power_type;
+		ath12k_dbg(ab, ATH12K_DBG_MAC, "mac chanctx power type %d\n",
+			   power_type);
+		if (power_type == IEEE80211_REG_UNSET_AP)
+			power_type = IEEE80211_REG_LPI_AP;
+	}
+
 	/* for some targets bss peer must be created before vdev_start */
 	if (ab->hw_params->vdev_start_delay &&
 	    arvif->vdev_type != WMI_VDEV_TYPE_AP &&
-- 
2.17.1

