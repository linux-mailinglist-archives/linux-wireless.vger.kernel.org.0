Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A872F57B7F4
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Jul 2022 15:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240629AbiGTNwO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Jul 2022 09:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240624AbiGTNwN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Jul 2022 09:52:13 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE0B31935
        for <linux-wireless@vger.kernel.org>; Wed, 20 Jul 2022 06:52:12 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26KCx2JP008669;
        Wed, 20 Jul 2022 13:52:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=qOOxBFQUbJD5CfYghys+G8PGAtbBAD71SQQUTuHEQB0=;
 b=hJPBo1N8P8nEz3PkYlovL9A/qKsazQ6JsDLpklrANflX/v/92Qv0wHD+4KxVxkdR9cis
 qKqKOakvo8X0/qHEBzwZl84RzVo4j4r63snNYeX8HBpmGd2ouHKJvi5r8zomZpHsgN6z
 Ks+5HEtC9KhOjzuSHOmWrvh2RIXnY6cdGbDLC+FAj8ayZ/Q6u5eUnXMEy5hU2pU3fJL/
 INP99JOZBCD+ORgE7w+OT0amhQHS7QRj3Z+Yy0XU7QBkh3T9gSbeDg4tZosA3EzaECTT
 it0xyGdqOhqGZDPKJSLSp9vtJuYPHpugbhnUcpLGnB+Mdu+sg8yidSS0U0a3NctUC0gp uw== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hej60g4kv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 13:52:10 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 26KDq9Q0017896
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 13:52:09 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Jul 2022 06:52:09 -0700
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Jul 2022 06:52:07 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH 2/2] ath11k: Fix hardware restart failure due to twt debugfs failure
Date:   Wed, 20 Jul 2022 19:21:50 +0530
Message-ID: <20220720135150.22193-3-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220720135150.22193-1-quic_mpubbise@quicinc.com>
References: <20220720135150.22193-1-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AdRdubyBQLXDmejr7HBvIYUiFN6_Ogi_
X-Proofpoint-ORIG-GUID: AdRdubyBQLXDmejr7HBvIYUiFN6_Ogi_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_08,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 suspectscore=0 impostorscore=0 adultscore=0 mlxlogscore=944 mlxscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200057
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently, creation of debugfs entries for TWT is failing during
hardware restart because of the residual TWT files which were
created during add_interface(). Since, struct arvif{} is memset
to zero upon add_interface() invocation, when the hardware restart
is triggered, arvif is memset to 0 and TWT files are attempted to
create again which will fail because of the residual TWT files
already in place, this leads to hardware restart failure.

Also, it is not a good idea to return error from add_interface()
because of debugfs file creation failures. Moreover, debugfs
framework can very well handle the errors in it's create file &
remove file APIs and the errors returned by these APIs are not
checked in most usecases.

Fix the HW restart failure by ignoring the errors returned from
the debugfs APIs.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1

Fixes: fe98a6137d03 ("ath11k: add debugfs for TWT debug calls")
Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/debugfs.c | 37 +++++++++--------------
 drivers/net/wireless/ath/ath11k/debugfs.h |  5 ++-
 drivers/net/wireless/ath/ath11k/mac.c     | 11 +++++--
 3 files changed, 25 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
index 3861616b48c8..8dcc5f7baf5f 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs.c
@@ -1673,42 +1673,35 @@ static const struct file_operations ath11k_fops_twt_resume_dialog = {
 	.open = simple_open
 };
 
-int ath11k_debugfs_add_interface(struct ath11k_vif *arvif)
+void ath11k_debugfs_add_interface(struct ath11k_vif *arvif)
 {
 	struct ath11k_base *ab = arvif->ar->ab;
 
 	if (arvif->vif->type != NL80211_IFTYPE_AP &&
 	    !(arvif->vif->type == NL80211_IFTYPE_STATION &&
 	      test_bit(WMI_TLV_SERVICE_STA_TWT, ab->wmi_ab.svc_map)))
-		return 0;
-
-	if (!arvif->debugfs_twt) {
-		arvif->debugfs_twt = debugfs_create_dir("twt",
-							arvif->vif->debugfs_dir);
-		if (!arvif->debugfs_twt || IS_ERR(arvif->debugfs_twt)) {
-			ath11k_warn(ab, "failed to create directory %p\n",
-				    arvif->debugfs_twt);
-			arvif->debugfs_twt = NULL;
-			return -1;
-		}
+		return;
 
-		debugfs_create_file("add_dialog", 0200, arvif->debugfs_twt,
-				    arvif, &ath11k_fops_twt_add_dialog);
+	arvif->debugfs_twt = debugfs_create_dir("twt",
+						arvif->vif->debugfs_dir);
+	debugfs_create_file("add_dialog", 0200, arvif->debugfs_twt,
+			    arvif, &ath11k_fops_twt_add_dialog);
 
-		debugfs_create_file("del_dialog", 0200, arvif->debugfs_twt,
-				    arvif, &ath11k_fops_twt_del_dialog);
+	debugfs_create_file("del_dialog", 0200, arvif->debugfs_twt,
+			    arvif, &ath11k_fops_twt_del_dialog);
 
-		debugfs_create_file("pause_dialog", 0200, arvif->debugfs_twt,
-				    arvif, &ath11k_fops_twt_pause_dialog);
+	debugfs_create_file("pause_dialog", 0200, arvif->debugfs_twt,
+			    arvif, &ath11k_fops_twt_pause_dialog);
 
-		debugfs_create_file("resume_dialog", 0200, arvif->debugfs_twt,
-				    arvif, &ath11k_fops_twt_resume_dialog);
-	}
-	return 0;
+	debugfs_create_file("resume_dialog", 0200, arvif->debugfs_twt,
+			    arvif, &ath11k_fops_twt_resume_dialog);
 }
 
 void ath11k_debugfs_remove_interface(struct ath11k_vif *arvif)
 {
+	if (!arvif->debugfs_twt)
+		return;
+
 	debugfs_remove_recursive(arvif->debugfs_twt);
 	arvif->debugfs_twt = NULL;
 }
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.h b/drivers/net/wireless/ath/ath11k/debugfs.h
index 30c00cb28311..15edca8e0aec 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.h
+++ b/drivers/net/wireless/ath/ath11k/debugfs.h
@@ -306,7 +306,7 @@ static inline int ath11k_debugfs_rx_filter(struct ath11k *ar)
 	return ar->debug.rx_filter;
 }
 
-int ath11k_debugfs_add_interface(struct ath11k_vif *arvif);
+void ath11k_debugfs_add_interface(struct ath11k_vif *arvif);
 void ath11k_debugfs_remove_interface(struct ath11k_vif *arvif);
 void ath11k_debugfs_add_dbring_entry(struct ath11k *ar,
 				     enum wmi_direct_buffer_module id,
@@ -386,9 +386,8 @@ static inline int ath11k_debugfs_get_fw_stats(struct ath11k *ar,
 	return 0;
 }
 
-static inline int ath11k_debugfs_add_interface(struct ath11k_vif *arvif)
+static inline void ath11k_debugfs_add_interface(struct ath11k_vif *arvif)
 {
-	return 0;
 }
 
 static inline void ath11k_debugfs_remove_interface(struct ath11k_vif *arvif)
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 3746c839efe0..cc98c0c9b7e0 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -6236,6 +6236,13 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 		goto err;
 	}
 
+	/* In the case of hardware recovery, debugfs files are
+	 * not deleted since ieee80211_ops.remove_interface() is
+	 * not invoked. In such cases, try to delete the files.
+	 * These will be re-created later.
+	 */
+	ath11k_debugfs_remove_interface(arvif);
+
 	memset(arvif, 0, sizeof(*arvif));
 
 	arvif->ar = ar;
@@ -6417,9 +6424,7 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 		}
 	}
 
-	ret = ath11k_debugfs_add_interface(arvif);
-	if (ret)
-		goto err_peer_del;
+	ath11k_debugfs_add_interface(arvif);
 
 	mutex_unlock(&ar->conf_mutex);
 
-- 
2.35.1

