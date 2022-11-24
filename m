Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F09D6372F5
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Nov 2022 08:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiKXHil (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Nov 2022 02:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiKXHij (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Nov 2022 02:38:39 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3A01FCD6
        for <linux-wireless@vger.kernel.org>; Wed, 23 Nov 2022 23:38:38 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AO50vce002619;
        Thu, 24 Nov 2022 07:11:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=fUML10oIFcsrJ9IIruiSHpVcKJrFxMy4Kjx2DgB0DpE=;
 b=iIjpGg9OzLAjQsupkv+u4sL6CRDDUMWgvXE5k92AROdr+pi+sReDKWdArMARBQqPFEAm
 +yTFKn5swopUlUPxdVGJ4eXQOzMIbfgsGOLcgCqoV+dytDV8ajr2R5sTfscc5PkZnW+K
 DyLupJlkItNjh7QOwUXZeNMzilMqGKSSUJySGUcc8lKVAm0wg0mf/gKprZdUV9xfcc0V
 uGWihGWiVZbk4JDwecgDTrap+Kzql7xejztZJKykBYvhq47WrMMZHLNwz9H7+stfJdlR
 eSUMeSIeKdzzbRs2JVaCJpq31Bj2ffkEZJ380frpFRIgSu4Gr+fngQd1GTN7EQ4N5PAS fQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m15sechnw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Nov 2022 07:11:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AO7BS0o017864
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Nov 2022 07:11:28 GMT
Received: from kathirve-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 23 Nov 2022 23:11:26 -0800
From:   Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Govindaraj Saminathan <quic_gsaminat@quicinc.com>,
        Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
Subject: [PATCHv2] wifi: ath11k: Fix race condition with htt_ppdu_stats_info
Date:   Thu, 24 Nov 2022 12:41:04 +0530
Message-ID: <20221124071104.22506-1-quic_kathirve@quicinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _7b0VElMQ9MKOQf7OcKUdb_TmW64jJVs
X-Proofpoint-GUID: _7b0VElMQ9MKOQf7OcKUdb_TmW64jJVs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-24_04,2022-11-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 impostorscore=0 spamscore=0 clxscore=1015 mlxlogscore=959 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211240055
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Govindaraj Saminathan <quic_gsaminat@quicinc.com>

The below crash happens when running the traffic with multiple clients

Crash Signature : Unable to handle kernel paging request at
virtual address ffffffd700970918 During the crash, PC points to
"ieee80211_tx_rate_update+0x30/0x68 [mac80211]"
LR points to "ath11k_dp_htt_htc_t2h_msg_handler+0x5a8/0x8a0 [ath11k]".

ppdu_stats_info is allocated and accessed from event callback via copy
engine tasklet, this has a problem when freeing it from ath11k_mac_op_stop.

Add spin lock to protect htt_ppdu_stats_info and to avoid race condition
when accessing it from ath11k_mac_op_stop.

Tested-on : IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Signed-off-by: Govindaraj Saminathan <quic_gsaminat@quicinc.com>
Co-developed-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
---
v2:
	Rebased and Modified the author details

 drivers/net/wireless/ath/ath11k/dp_rx.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index c5a4c34d7749..2384c8c3c55c 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -1535,11 +1535,11 @@ struct htt_ppdu_stats_info *ath11k_dp_htt_get_ppdu_desc(struct ath11k *ar,
 {
 	struct htt_ppdu_stats_info *ppdu_info;
 
-	spin_lock_bh(&ar->data_lock);
+	lockdep_assert_held(&ar->data_lock);
+
 	if (!list_empty(&ar->ppdu_stats_info)) {
 		list_for_each_entry(ppdu_info, &ar->ppdu_stats_info, list) {
 			if (ppdu_info->ppdu_id == ppdu_id) {
-				spin_unlock_bh(&ar->data_lock);
 				return ppdu_info;
 			}
 		}
@@ -1553,16 +1553,13 @@ struct htt_ppdu_stats_info *ath11k_dp_htt_get_ppdu_desc(struct ath11k *ar,
 			kfree(ppdu_info);
 		}
 	}
-	spin_unlock_bh(&ar->data_lock);
 
 	ppdu_info = kzalloc(sizeof(*ppdu_info), GFP_ATOMIC);
 	if (!ppdu_info)
 		return NULL;
 
-	spin_lock_bh(&ar->data_lock);
 	list_add_tail(&ppdu_info->list, &ar->ppdu_stats_info);
 	ar->ppdu_stat_list_depth++;
-	spin_unlock_bh(&ar->data_lock);
 
 	return ppdu_info;
 }
@@ -1586,16 +1583,17 @@ static int ath11k_htt_pull_ppdu_stats(struct ath11k_base *ab,
 	ar = ath11k_mac_get_ar_by_pdev_id(ab, pdev_id);
 	if (!ar) {
 		ret = -EINVAL;
-		goto exit;
+		goto out;
 	}
 
 	if (ath11k_debugfs_is_pktlog_lite_mode_enabled(ar))
 		trace_ath11k_htt_ppdu_stats(ar, skb->data, len);
 
+	spin_lock_bh(&ar->data_lock);
 	ppdu_info = ath11k_dp_htt_get_ppdu_desc(ar, ppdu_id);
 	if (!ppdu_info) {
 		ret = -EINVAL;
-		goto exit;
+		goto out_unlock_data;
 	}
 
 	ppdu_info->ppdu_id = ppdu_id;
@@ -1604,10 +1602,13 @@ static int ath11k_htt_pull_ppdu_stats(struct ath11k_base *ab,
 				     (void *)ppdu_info);
 	if (ret) {
 		ath11k_warn(ab, "Failed to parse tlv %d\n", ret);
-		goto exit;
+		goto out_unlock_data;
 	}
 
-exit:
+out_unlock_data:
+	spin_unlock_bh(&ar->data_lock);
+
+out:
 	rcu_read_unlock();
 
 	return ret;

base-commit: d87a77cb16ca7c51f5ea67f345137ade24245153
-- 
2.38.0

