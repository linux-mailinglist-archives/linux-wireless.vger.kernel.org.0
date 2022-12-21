Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F6B652FFE
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Dec 2022 11:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbiLUK4d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Dec 2022 05:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234660AbiLUK4P (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Dec 2022 05:56:15 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FC920375
        for <linux-wireless@vger.kernel.org>; Wed, 21 Dec 2022 02:56:15 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BL9piL0018756;
        Wed, 21 Dec 2022 10:56:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=B0WEfYUu/OhdP110qIuduHHYNIqjaV3osrD/8Dm8GHk=;
 b=c5ML7zbdQv8dxZ6yBcFcTnA8hsIQ/sqhWnv269gB7ExMqDUJUcpzGby+IxHKOL5rQoS/
 +MN2W+Lkn3uvnSlxS9Fachb75HqfQ5kgLEDOyA360ZL5HO+DNA6Le8GeOgbN+M6x0nNS
 WG58nUYtNKdBcB8bhyRoMk8l/f3H0NY50K/esnp/mNwMK6pE8kygw9n13JJMxMApEWYl
 Jol8I+aqXqxhyP63QMhMnDHmTmo3fvisMmDSxpkfhjE8X2DjjRTXCR2JYAUF4DVWGOnz
 bAc8s9N6DOz6BgVvk6NhZdr34b8rbikhY90lWdUtKE07ej/3bTAvqAEXlwdYa+4YhZBf bQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mkmvt9dnb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Dec 2022 10:56:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BLAuBMF016776
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Dec 2022 10:56:11 GMT
Received: from tmariyap-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 21 Dec 2022 02:56:09 -0800
From:   Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>
Subject: [PATCH 1/4] wifi: ath12k: Fix uninitilized variable clang warnings
Date:   Wed, 21 Dec 2022 16:25:26 +0530
Message-ID: <20221221105529.19345-2-quic_tmariyap@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221221105529.19345-1-quic_tmariyap@quicinc.com>
References: <20221221105529.19345-1-quic_tmariyap@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WRuCY8tKNVmzeO7Ixq_aypzevkd3qZ1G
X-Proofpoint-GUID: WRuCY8tKNVmzeO7Ixq_aypzevkd3qZ1G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-21_05,2022-12-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 impostorscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212210088
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix uninitilized variable warnings spotted during clang compilation.

Warnings:
drivers/net/wireless/ath/ath12k/mac.c:1076:8: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
drivers/net/wireless/ath/ath12k/dbring.c:272:7: warning: variable 'ring' is used uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
drivers/net/wireless/ath/ath12k/dp_rx.c:2690:34: warning: variable 'i' is uninitialized when used here [-Wuninitialized]

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0-03171-QCAHKSWPL_SILICONZ-1
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dbring.c | 2 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c  | 3 +--
 drivers/net/wireless/ath/ath12k/mac.c    | 4 ++--
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dbring.c b/drivers/net/wireless/ath/ath12k/dbring.c
index 9aa2631be1a8..8fbf868e6f7e 100644
--- a/drivers/net/wireless/ath/ath12k/dbring.c
+++ b/drivers/net/wireless/ath/ath12k/dbring.c
@@ -230,7 +230,7 @@ int ath12k_dbring_get_cap(struct ath12k_base *ab,
 int ath12k_dbring_buffer_release_event(struct ath12k_base *ab,
 				       struct ath12k_dbring_buf_release_event *ev)
 {
-	struct ath12k_dbring *ring;
+	struct ath12k_dbring *ring = NULL;
 	struct hal_srng *srng;
 	struct ath12k *ar;
 	struct ath12k_dbring_element *buff;
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index d6835d13f7ec..83a43ad48c51 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -2582,7 +2582,6 @@ int ath12k_dp_rx_process(struct ath12k_base *ab, int ring_id,
 	struct sk_buff *msdu;
 	bool done = false;
 	int mac_id;
-	int i;
 	u64 desc_va;
 
 	__skb_queue_head_init(&msdu_list);
@@ -2687,7 +2686,7 @@ int ath12k_dp_rx_process(struct ath12k_base *ab, int ring_id,
 		goto exit;
 
 	/* TODO: Move to implicit BM? */
-	ath12k_dp_rx_bufs_replenish(ab, i, rx_ring, num_buffs_reaped,
+	ath12k_dp_rx_bufs_replenish(ab, 0, rx_ring, num_buffs_reaped,
 				    ab->hw_params->hal_params->rx_buf_rbm, true);
 
 	ath12k_dp_rx_process_received_packets(ab, napi, &msdu_list,
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index ac6548c087ba..bf7e5b6977b2 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1057,7 +1057,7 @@ static int ath12k_mac_op_config(struct ieee80211_hw *hw, u32 changed)
 {
 	struct ath12k *ar = hw->priv;
 	struct ieee80211_conf *conf = &hw->conf;
-	int ret;
+	int ret = 0;
 
 	mutex_lock(&ar->conf_mutex);
 
@@ -1089,7 +1089,7 @@ static int ath12k_mac_op_config(struct ieee80211_hw *hw, u32 changed)
 err_mon_del:
 	ath12k_mac_monitor_vdev_delete(ar);
 	mutex_unlock(&ar->conf_mutex);
-	return 0;
+	return ret;
 }
 
 static int ath12k_mac_setup_bcn_tmpl(struct ath12k_vif *arvif)
-- 
2.17.1

