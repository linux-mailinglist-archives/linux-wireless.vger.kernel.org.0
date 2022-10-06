Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A2B5F5E20
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Oct 2022 02:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiJFA7X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 20:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiJFA7V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 20:59:21 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF9D2DB
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 17:59:20 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2960aJZ7021820;
        Thu, 6 Oct 2022 00:59:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=OrPjcoemTkT6NXWEDX0Opb/1gpwBmqp4wrvfttoV9Ug=;
 b=ngLYM5GiWOwuVeoKDOyNT0Q0Wi7QeSmGnFIUtoBAJx2aET1S3t84CaFsb1fKoB29Lfbq
 9QBOn10VW7UrykiHOttAnP3usApDoHmKyPmlBYJpBNzOVAQzY4WMwWv2VmHdRkk/ESbS
 7lZpIIcGc3qGeGSIY649zxj1j/U2CkcgVGoQ/+9HQtzSWTitdKdKs+4tIv/YsAuhMHuO
 auPT36+C97y7bjV1nfmn3i+7R7xs7gXNEp43Psm2vy15q4Ltnolbd+czYD7JII8Pi141
 JLX1MzDmi59MRNFm7CemEL3lSuYaSIxsCXWTggyuG6cSo00NVKGvFd+Na/O6Q90uMu0R nA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k15shhms5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 00:59:14 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2960xDMg021018
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Oct 2022 00:59:13 GMT
Received: from periyasa-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 5 Oct 2022 17:59:11 -0700
From:   Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Subject: [PATCH v2] wifi: ath11k: suppress add interface error
Date:   Thu, 6 Oct 2022 06:28:42 +0530
Message-ID: <20221006005842.8599-1-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bdK41WTIsZk3Mekv0cFaRlXnbfIHUZNW
X-Proofpoint-ORIG-GUID: bdK41WTIsZk3Mekv0cFaRlXnbfIHUZNW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-05_05,2022-10-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 mlxlogscore=903 spamscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210060004
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In the VIF (other than monitor type) creation request, we should not
throw the error code when the monitor VIF creation fails, since the
actual VIF creation succeeds. If we throw the error code from driver
then the actual VIF creation get fail. So suppress the monitor VIF
creation error by throwing warning message instead of error code.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.6.0.1-00760-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 v2:
  - Modified the commit message

 drivers/net/wireless/ath/ath11k/mac.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 84d956ad4093..a8a212d416b2 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -6372,18 +6372,16 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 
 	ath11k_dp_vdev_tx_attach(ar, arvif);
 
+	ath11k_debugfs_add_interface(arvif);
+
 	if (vif->type != NL80211_IFTYPE_MONITOR &&
 	    test_bit(ATH11K_FLAG_MONITOR_CONF_ENABLED, &ar->monitor_flags)) {
 		ret = ath11k_mac_monitor_vdev_create(ar);
-		if (ret) {
+		if (ret)
 			ath11k_warn(ar->ab, "failed to create monitor vdev during add interface: %d",
 				    ret);
-			goto err_peer_del;
-		}
 	}
 
-	ath11k_debugfs_add_interface(arvif);
-
 	mutex_unlock(&ar->conf_mutex);
 
 	return 0;
@@ -6408,7 +6406,6 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 	spin_unlock_bh(&ar->data_lock);
 
 err:
-	ath11k_debugfs_remove_interface(arvif);
 	mutex_unlock(&ar->conf_mutex);
 
 	return ret;

base-commit: 15bc43a23ac0504a2a99fceae4a31b8bf37ec8fe
-- 
2.37.0

