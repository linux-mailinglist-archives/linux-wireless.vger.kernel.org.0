Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644D75BC149
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Sep 2022 04:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiISCO7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Sep 2022 22:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiISCOz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Sep 2022 22:14:55 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0C765F5
        for <linux-wireless@vger.kernel.org>; Sun, 18 Sep 2022 19:14:48 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28J1g4JU001759;
        Mon, 19 Sep 2022 02:14:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=dnx7UU5L7cbk3eV1KPUpx8CC/iQWX9Rw06hUgMW6Jzo=;
 b=GbSa8EBFAiFMua4ZDw3OfTncJ1K8aROW5u7ZFSF3YEGLTmLkCGzo9EXr2R08RcCmeAha
 HI4Q7EWiYJJXlQpf6/comMj7/GkoxNUbQtoKzDGjYLEt6X+9RQngQmPA6burEHe5tdB+
 xxIFXJVEOWwCypvg0KnrcbAAF4ZOh27QK4bP3aiZQfiw4s0icjz8pZ64agLQxOy+bi3x
 678uXUUgjJldw4yfsG/JF1wbsx33+5dJ5cFbTe2BHPjXZBdF+kLeOmw4guQmyM5uI+M2
 Q86LuU0Sdzii+zcvKsQAfNKcUP/+uWP2dopF70nVHGHEyL69esa+fNBpbJi3eGal5Y9B sA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jn6e5b2hc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 02:14:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28J2EjnI015436
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 02:14:45 GMT
Received: from bqiang-Celadon-RN.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Sun, 18 Sep 2022 19:14:44 -0700
From:   Baochen Qiang <quic_bqiang@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: ath11k: Fix deadlock during WoWLAN suspend
Date:   Mon, 19 Sep 2022 10:14:35 +0800
Message-ID: <20220919021435.2459-1-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fdav0DIsev-DIKS56n8ENNcJdOAF3D7w
X-Proofpoint-ORIG-GUID: fdav0DIsev-DIKS56n8ENNcJdOAF3D7w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_01,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209190014
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We are seeing system hangs during WoWLAN suspend, and get below
two stacks:

Stack1:
[ffffb02cc1557b20] __schedule at ffffffff8bb10860
[ffffb02cc1557ba8] schedule at ffffffff8bb10f24
[ffffb02cc1557bb8] schedule_timeout at ffffffff8bb16d88
[ffffb02cc1557c30] wait_for_completion at ffffffff8bb11778
[ffffb02cc1557c78] __flush_work at ffffffff8b0b30cd
[ffffb02cc1557cf0] __cancel_work_timer at ffffffff8b0b33ad
[ffffb02cc1557d60] ath11k_mac_drain_tx at ffffffffc0c1f0ca [ath11k]
[ffffb02cc1557d70] ath11k_wow_op_suspend at ffffffffc0c5201e [ath11k]
[ffffb02cc1557da8] __ieee80211_suspend at ffffffffc11e2bd3 [mac80211]
[ffffb02cc1557dd8] wiphy_suspend at ffffffffc0f901ac [cfg80211]
[ffffb02cc1557e08] dpm_run_callback at ffffffff8b75118a
[ffffb02cc1557e38] __device_suspend at ffffffff8b751630
[ffffb02cc1557e70] async_suspend at ffffffff8b7519ea
[ffffb02cc1557e88] async_run_entry_fn at ffffffff8b0bf4ce
[ffffb02cc1557ea8] process_one_work at ffffffff8b0b1a24
[ffffb02cc1557ee0] worker_thread at ffffffff8b0b1c4a
[ffffb02cc1557f18] kthread at ffffffff8b0b9cb8
[ffffb02cc1557f50] ret_from_fork at ffffffff8b001d32

Stack2:
[ffffb02cc00b7d18] __schedule at ffffffff8bb10860
[ffffb02cc00b7da0] schedule at ffffffff8bb10f24
[ffffb02cc00b7db0] schedule_preempt_disabled at ffffffff8bb112b4
[ffffb02cc00b7db8] __mutex_lock at ffffffff8bb127ea
[ffffb02cc00b7e38] ath11k_mgmt_over_wmi_tx_work at ffffffffc0c1aa44 [ath11k]
[ffffb02cc00b7ea8] process_one_work at ffffffff8b0b1a24
[ffffb02cc00b7ee0] worker_thread at ffffffff8b0b1c4a
[ffffb02cc00b7f18] kthread at ffffffff8b0b9cb8
[ffffb02cc00b7f50] ret_from_fork at ffffffff8b001d32

From the first stack, ath11k_mac_drain_tx calls
cancel_work_sync(&ar->wmi_mgmt_tx_work) and waits all packets to be sent
out or dropped. However, we find from Stack2 that this work item is blocked
because ar->conf_mutex is already held by ath11k_wow_op_suspend.

Fix this issue by moving ath11k_mac_wait_tx_complete to the start of
ath11k_wow_op_suspend where ar->conf_mutex has not been acquired. And
this change also makes the logic in ath11k_wow_op_suspend match the
logic in ath11k_mac_op_start and ath11k_mac_op_stop.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/wow.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/wow.c b/drivers/net/wireless/ath/ath11k/wow.c
index b3e65cd13d83..6ed6f51e8a85 100644
--- a/drivers/net/wireless/ath/ath11k/wow.c
+++ b/drivers/net/wireless/ath/ath11k/wow.c
@@ -664,6 +664,12 @@ int ath11k_wow_op_suspend(struct ieee80211_hw *hw,
 	struct ath11k *ar = hw->priv;
 	int ret;
 
+	ret = ath11k_mac_wait_tx_complete(ar);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to wait tx complete: %d\n", ret);
+		return ret;
+	}
+
 	mutex_lock(&ar->conf_mutex);
 
 	ret = ath11k_dp_rx_pktlog_stop(ar->ab, true);
@@ -696,11 +702,6 @@ int ath11k_wow_op_suspend(struct ieee80211_hw *hw,
 	}
 
 	ath11k_mac_drain_tx(ar);
-	ret = ath11k_mac_wait_tx_complete(ar);
-	if (ret) {
-		ath11k_warn(ar->ab, "failed to wait tx complete: %d\n", ret);
-		goto cleanup;
-	}
 
 	ret = ath11k_wow_set_hw_filter(ar);
 	if (ret) {

base-commit: c6d18be90f9b0c7fb64c6138b51c49151140fb57
-- 
2.25.1

