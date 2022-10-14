Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A01A5FF193
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Oct 2022 17:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiJNPmo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Oct 2022 11:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbiJNPmm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Oct 2022 11:42:42 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B9E1CB53F
        for <linux-wireless@vger.kernel.org>; Fri, 14 Oct 2022 08:42:40 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29EEteqG016479;
        Fri, 14 Oct 2022 15:42:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=4tzYF922QtOZ9HWF2MUcwCmnjM0kWhjntW7t/8P2NOk=;
 b=UXnSCzxjLAhszEbfyybx53Ous/RY+nzT4l+xL2nIOZBRu5YQvR9pKKPnzleTHpq222on
 BHsNBE36ujFULmwzDydrxSTL1perMLYdlMRxMMVoqVLXzte0bU7rwQm/BYxYQGkZiGzq
 +DzHnfbHP4oSJiHXdQqyp8+muZF4U3TY0bqzGy0Z6IRyw1I6ak+RmsCcIJLUZOmzuKta
 VPKOHcdJWNrbdejnvyDtqymtdG7ESUKUwZzkriObJLEaAB3LF47Uxnynu9zpgUv95cl/
 r+s0Llzo+qbtZEo470XhY/mwHV/GSvmhzPLTHCKvDX/sA6bZ9A/+12w/dKXgyasOMhIj 4w== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k74ech6tr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 15:42:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29EFgVht003870
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 15:42:31 GMT
Received: from nmaran-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 14 Oct 2022 08:42:30 -0700
From:   Nagarajan Maran <quic_nmaran@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Nagarajan Maran <quic_nmaran@quicinc.com>
Subject: [PATCH] ath11k: fix monitor vdev creation with firmware recovery
Date:   Fri, 14 Oct 2022 21:12:16 +0530
Message-ID: <20221014154216.4262-1-quic_nmaran@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KSOr6z2wb6968Xn1968n4EwKId0xSna0
X-Proofpoint-ORIG-GUID: KSOr6z2wb6968Xn1968n4EwKId0xSna0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_09,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=988 mlxscore=0
 impostorscore=0 clxscore=1011 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210140086
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

During firmware recovery, the monitor interface is not
getting created in the driver and firmware since
the respective flags are not updated properly.

So after firmware recovery is successful, when monitor
interface is brought down manually, firmware assertion
is observed, since we are trying to bring down the
interface which is not yet created in the firmware.

Fix this by updating the monitor flags properly per
phy#, during firmware recovery.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Signed-off-by: Nagarajan Maran <quic_nmaran@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 35a5de3a0a8a..0ab2f190f1ec 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1677,6 +1677,10 @@ void ath11k_core_pre_reconfigure_recovery(struct ath11k_base *ab)
 			     ath11k_mac_tx_mgmt_pending_free, ar);
 		idr_destroy(&ar->txmgmt_idr);
 		wake_up(&ar->txmgmt_empty_waitq);
+
+		ar->monitor_vdev_id = -1;
+		clear_bit(ATH11K_FLAG_MONITOR_STARTED, &ar->monitor_flags);
+		clear_bit(ATH11K_FLAG_MONITOR_VDEV_CREATED, &ar->monitor_flags);
 	}
 
 	wake_up(&ab->wmi_ab.tx_credits_wq);
-- 
2.17.1

