Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C26725B07
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jun 2023 11:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239126AbjFGJsq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Jun 2023 05:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbjFGJsp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Jun 2023 05:48:45 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB79E49
        for <linux-wireless@vger.kernel.org>; Wed,  7 Jun 2023 02:48:44 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3578HvFG022893;
        Wed, 7 Jun 2023 09:48:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=k/c63I2xws3zH/ThqP3infsaQs8RAvaeVL7UznqSboE=;
 b=lhGxsnzoN8cnM4Fb0vtgnv9CQpA/t712zSSg6SKTlrjnZdG2DlRXZI0k/PuSJEBBezo5
 fWvg6DxT28Jg0jH9tKuiNya2cNCc6BXt2RGEGypC1+apMDB3cJ/isFp5Q92CX6v26O/e
 ZrDaw0KsYphDBj4tf3KEgYu7pKSvWW8zAmvf6e/Pfsb3iSYQBjvGofbzhQ+hv3LAIuyR
 M6OY+VYN2UXxhm0SH5qaIj/2MNEON60nJQjRELa/A8ZvEOe+3NAvgqSa3/zCzxv1AetC
 XpgmVoHy9wtVoWs8Ea7CaiPAC1sr4yvgb2okdh+c31ggsJ6qJPdkGIGscAYRkhTrD+6z 7Q== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r2a769g9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jun 2023 09:48:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3579mdKG017910
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Jun 2023 09:48:39 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 7 Jun 2023 02:48:38 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>,
        Wen Gong <quic_wgong@quicinc.com>
Subject: [PATCH v4 3/5] wifi: ath11k: fix a possible dead lock caused by ab->base_lock
Date:   Wed, 7 Jun 2023 05:48:08 -0400
Message-ID: <20230607094810.26707-4-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230607094810.26707-1-quic_wgong@quicinc.com>
References: <20230607094810.26707-1-quic_wgong@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dy3eLaE7Hqkph4F5BxU4U7eEkqyxh5MQ
X-Proofpoint-GUID: dy3eLaE7Hqkph4F5BxU4U7eEkqyxh5MQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_06,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 clxscore=1015
 mlxscore=0 bulkscore=0 adultscore=0 phishscore=0 mlxlogscore=985
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306070079
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Baochen Qiang <quic_bqiang@quicinc.com>

spin_lock/spin_unlock are used in ath11k_reg_chan_list_event to
acquire/release ab->base_lock, for now this is safe because that
function is only called in soft IRQ context. But in an upcoming
patch ath11k_reg_chan_list_event() will be called from process
context, and this can result in a deadlock if ab->base_lock is
acquired in process context and then soft IRQ occurs on the same
CPU and tries to acquire that lock.

Fix it by using spin_lock_bh and spin_unlock_bh instead.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23

Fixes: 69a0fcf8a9f2 ("ath11k: Avoid reg rules update during firmware recovery")
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 77de11985f5a..2965dffe8ceb 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -7039,13 +7039,13 @@ int ath11k_reg_handle_chan_list(struct ath11k_base *ab,
 	/* Avoid default reg rule updates sent during FW recovery if
 	 * it is already available
 	 */
-	spin_lock(&ab->base_lock);
+	spin_lock_bh(&ab->base_lock);
 	if (test_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags) &&
 	    ab->default_regd[pdev_idx]) {
-		spin_unlock(&ab->base_lock);
+		spin_unlock_bh(&ab->base_lock);
 		goto retfail;
 	}
-	spin_unlock(&ab->base_lock);
+	spin_unlock_bh(&ab->base_lock);
 
 	if (pdev_idx >= ab->num_radios) {
 		/* Process the event for phy0 only if single_pdev_only
@@ -7095,7 +7095,7 @@ int ath11k_reg_handle_chan_list(struct ath11k_base *ab,
 		ab->reg_info_store[pdev_idx] = *reg_info;
 	}
 
-	spin_lock(&ab->base_lock);
+	spin_lock_bh(&ab->base_lock);
 	if (ab->default_regd[pdev_idx]) {
 		/* The initial rules from FW after WMI Init is to build
 		 * the default regd. From then on, any rules updated for
@@ -7115,7 +7115,7 @@ int ath11k_reg_handle_chan_list(struct ath11k_base *ab,
 		ab->default_regd[pdev_idx] = regd;
 	}
 	ab->dfs_region = reg_info->dfs_region;
-	spin_unlock(&ab->base_lock);
+	spin_unlock_bh(&ab->base_lock);
 
 	return 0;
 
-- 
2.40.1

