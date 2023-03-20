Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D796C0CD7
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 10:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjCTJM3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Mar 2023 05:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjCTJMV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Mar 2023 05:12:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC93132C7
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 02:12:18 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32K8OZFA008798;
        Mon, 20 Mar 2023 09:12:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=eKIzTpVAmS+Uy++yOtS/LTojfn/8gh26HkFPOGaud9s=;
 b=kd5Ch88M3N8yN8a9rsDwixfHrMcYbXv0Wphk4+m519HvnORbs8ptEX448EU2cId+yMVt
 bQ2D68d+U+D7y2Y5iZcS3ZKKg809T3Rfn15LBS/UOz0PrU9oGbnMOYAPPrp+bxeo17Eu
 3s5Nlgl4t3G9sgyBGnLTN6B7YnbGDuO7Rcy5Z1bo3Wc9TIyJTwyG7ze+1qvs6EodQMyb
 qTn7aeED33ScmY4qVNRCh0ogXLyt/vAejc/Fx/Qp1GNJNMVpriiUA/ToywPlcYrOwceq
 RhSaQPMz/v3/TXqcQPmZ05fXCYiHD4BpJddAdFRUh2LSqqWto+xPyFHlNMkrd22c73fR WQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pd5ha4ar9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 09:12:12 +0000
Received: from pps.filterd (NASANPPMTA02.qualcomm.com [127.0.0.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 32K932jr029363;
        Mon, 20 Mar 2023 09:12:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA02.qualcomm.com (PPS) with ESMTP id 3pd6cm7fa1-1;
        Mon, 20 Mar 2023 09:12:12 +0000
Received: from NASANPPMTA02.qualcomm.com (NASANPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32K9CCos010480;
        Mon, 20 Mar 2023 09:12:12 GMT
Received: from hprem-linux.qualcomm.com (hprem-linux.qualcomm.com [10.201.162.248])
        by NASANPPMTA02.qualcomm.com (PPS) with ESMTP id 32K9CB1E010473;
        Mon, 20 Mar 2023 09:12:12 +0000
Received: by hprem-linux.qualcomm.com (Postfix, from userid 4146166)
        id 94B47B003A2; Mon, 20 Mar 2023 14:42:09 +0530 (IST)
From:   Harshitha Prem <quic_hprem@quicinc.com>
To:     ath12k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Harshitha Prem <quic_hprem@quicinc.com>
Subject: [PATCH] wifi: ath12k: incorrect channel survey dump
Date:   Mon, 20 Mar 2023 14:42:08 +0530
Message-Id: <20230320091208.25535-1-quic_hprem@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fR0IrmwUSDgKqMMBxce3a5Pw5U7nUa7X
X-Proofpoint-ORIG-GUID: fR0IrmwUSDgKqMMBxce3a5Pw5U7nUa7X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_06,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 mlxlogscore=999
 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303200078
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When underlying hardware supports more than one band, then wiphy
is aware of all the frequency bands present. Example, say
wiphy0 is aware of 2 GHz, 5 GHz and 6 GHz band information.
Hence, when an virtual AP interface is brought up in auto channel
selection on each band. Survey is initiated from the userspace application
for all the virtual AP interfaces simultaneously.

For survey dump collection, freq_to_idx() api is used to map the index of
particular frequency to populate its survey. When the dump was collected,
the index fetched was incorrect. Example, in case of multi-hardware,
the index of channel 36 was reported as 14, because wiphy0 had index 0-13
for 2 GHz channels, instead of 0 for that ar which resulted in invalid
survey sent to userspace application.

The incorrect index was because of the mapping did not consider whether
the freq band is present in its radio structure (ar) or not.

To handle this, the freq_to_idx() api should map index for the
particular band in the ar structure.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 3e6991120e53..f37b5c3a3ceb 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -4934,6 +4934,9 @@ static int freq_to_idx(struct ath12k *ar, int freq)
 	int band, ch, idx = 0;
 
 	for (band = NL80211_BAND_2GHZ; band < NUM_NL80211_BANDS; band++) {
+		if (!ar->mac.sbands[band].channels)
+			continue;
+
 		sband = ar->hw->wiphy->bands[band];
 		if (!sband)
 			continue;
-- 
2.17.1

