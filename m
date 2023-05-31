Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5710C7176B3
	for <lists+linux-wireless@lfdr.de>; Wed, 31 May 2023 08:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjEaGPR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 May 2023 02:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjEaGPP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 May 2023 02:15:15 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAFCC0
        for <linux-wireless@vger.kernel.org>; Tue, 30 May 2023 23:15:14 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34V3UEu3010687
        for <linux-wireless@vger.kernel.org>; Wed, 31 May 2023 06:15:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=9A5byIPszYYxuxTIUDlnZ6HTCMUJowDdoebwSFb8iAM=;
 b=O6Ah2wx8dIKxjQa7IJZXVS8b+iiU5Pqq4Fhhn4r899Vq2sh6Qm2E+hW4XJjtq61oVGGL
 oS/k1EF65QInhbPgwkCnlpRQga+Gz61YH8E0+E7TGqp7fmA6pMp6hK6L3M+FT5gF5RYI
 +mHiOMVewooWwbEtZ102+sTEYNjdbf1QBUo5S8asAmIMmSYg9hzDNrUU4OL6oqjcrMSE
 pBBJMD/iCmbCCA4vJOEfjx/iF5pfrLh6p/Qh4x/jcIbs0TExw7AKplYAjHyJ1aOOmlXh
 p+Gi5umSq1YylJ3K+cUYGNyY89dLW7/FmlcHRLvMqQ96KE4ghj63uL+uN8P51SoeN9ur gw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qwwbtgcrd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Wed, 31 May 2023 06:15:13 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34V6FCDv006610
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Wed, 31 May 2023 06:15:12 GMT
Received: from adisi-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 30 May 2023 23:15:10 -0700
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
To:     <linux-wireless@vger.kernel.org>
CC:     Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: [PATCH] wifi: mac80211: fix switch count in EMA beacons
Date:   Wed, 31 May 2023 11:44:54 +0530
Message-ID: <20230531061454.3701-1-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UeHT1xz6Y0YZMq0gO2ZLqzyaGQhh_iCH
X-Proofpoint-ORIG-GUID: UeHT1xz6Y0YZMq0gO2ZLqzyaGQhh_iCH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_02,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 mlxlogscore=847 adultscore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305310054
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently, whenever an EMA beacon is formed, due to is_template
argument being false from the caller, the switch count is always
decremented once which is wrong.

Also if switch count is equal to profile periodicity, this makes
the switch count to reach till zero which triggers a WARN_ON_ONCE.

[  261.593915] CPU: 1 PID: 800 Comm: kworker/u8:3 Not tainted 5.4.213 #0
[  261.616143] Hardware name: Qualcomm Technologies, Inc. IPQ9574
[  261.622666] Workqueue: phy0 ath12k_get_link_bss_conf [ath12k]
[  261.629771] pstate: 60400005 (nZCv daif +PAN -UAO)
[  261.635595] pc : ieee80211_next_txq+0x1ac/0x1b8 [mac80211]
[  261.640282] lr : ieee80211_beacon_update_cntdwn+0x64/0xb4 [mac80211]
[...]
[  261.729683] Call trace:
[  261.734986]  ieee80211_next_txq+0x1ac/0x1b8 [mac80211]
[  261.737156]  ieee80211_beacon_cntdwn_is_complete+0xa28/0x1194 [mac80211]
[  261.742365]  ieee80211_beacon_cntdwn_is_complete+0xef4/0x1194 [mac80211]
[  261.749224]  ieee80211_beacon_get_template_ema_list+0x38/0x5c [mac80211]
[  261.755908]  ath12k_get_link_bss_conf+0xf8/0x33b4 [ath12k]
[  261.762590]  ath12k_get_link_bss_conf+0x390/0x33b4 [ath12k]
[  261.767881]  process_one_work+0x194/0x270
[  261.773346]  worker_thread+0x200/0x314
[  261.777514]  kthread+0x140/0x150
[  261.781158]  ret_from_fork+0x10/0x18

Fix this issue by making the is_template argument as true when fetching
the EMA beacons.

Fixes: bd54f3c29077 ("wifi: mac80211: generate EMA beacons in AP mode")
Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 net/mac80211/tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 1a3327407552..76506f26c40b 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5527,7 +5527,7 @@ ieee80211_beacon_get_template_ema_list(struct ieee80211_hw *hw,
 {
 	struct ieee80211_ema_beacons *ema_beacons = NULL;
 
-	WARN_ON(__ieee80211_beacon_get(hw, vif, NULL, false, link_id, 0,
+	WARN_ON(__ieee80211_beacon_get(hw, vif, NULL, true, link_id, 0,
 				       &ema_beacons));
 
 	return ema_beacons;
-- 
2.17.1

