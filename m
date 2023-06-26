Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32A273D5FC
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jun 2023 04:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjFZCnH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 25 Jun 2023 22:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjFZCnF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 25 Jun 2023 22:43:05 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1C0139
        for <linux-wireless@vger.kernel.org>; Sun, 25 Jun 2023 19:42:59 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35Q21jSx011022;
        Mon, 26 Jun 2023 02:42:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=YUHdgf3PzCUbbrU5PgZQ+33VeZimYf6Bv6NUP6dDX98=;
 b=UeXgh+0za+LlVHvnOql4WyhAeVrAdJtVtGM0sehK+KYnBKBjqsINNeK9YrsKQRiY+wtn
 /ko05VHapVCN9gT4t+UxpCzBG1JEOniS4e9pbYY3Puzc+RtMRYAAQEu3TxQepUeSeQDB
 siwM3R3CrPSZZuP9sK6Ihhn94FGyLrPKr2Gsav4XPtaN5I4adc3hZfnIPJ7lmRXLesGE
 VQowOgaD1sLAhSf/c13jfedoDDgCVhJztMAFoSQxuGSNtult7JCFvEqNEqjCVWB9jrAq
 lAalpx44wdHCyeOt3m2TSuWvhQCjv18zM0k2yF10UX13g+iOQWwJSlWs1prIP25V3FXy Gg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rev820bmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jun 2023 02:42:56 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35Q2gtCl016684
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jun 2023 02:42:55 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Sun, 25 Jun 2023 19:42:54 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath10k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH] wifi: ath10k: indicate to mac80211 scan complete with aborted flag for ATH10K_SCAN_STARTING state
Date:   Sun, 25 Jun 2023 22:42:32 -0400
Message-ID: <20230626024232.15579-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pXzqzKFmHNIp4bcv8swHypuYCDLMmOiL
X-Proofpoint-GUID: pXzqzKFmHNIp4bcv8swHypuYCDLMmOiL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-25_16,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 bulkscore=0 clxscore=1011 impostorscore=0 mlxscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306260023
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Scan failure can not be recovered from when running a loop of the
following steps:
1. run scan: "iw wlan scan".
2. run command: echo soft > /sys/kernel/debug/ieee80211/phy0/ath10k/simulate_fw_crash
   immediately after step 1.

result:
scan failed and can not recover even when wlan recovery succeeds:
command failed: Device or resource busy (-16)

reason:
When scan arrives, WMI_START_SCAN_CMDID is sent to the firmware and
function ath10k_hw_scan() returns, then simulate_fw_crash arrives
and the scan started event does not arrive, and then it starts to do
recovery of wlan. __ath10k_scan_finish() which is called from
ath10k_halt() is one step of recovery, it will not call
ieee80211_scan_completed() by logic currently because the scan state is
ATH10K_SCAN_STARTING. Thus it leads the scan not being completed in
mac80211, and leads all consecutive scans failing with -EBUSY in
nl80211_trigger_scan even after wlan recovery success.

Indicate scan complete with aborted flag to mac80211 for
ATH10K_SCAN_STARTING to allow recovery from scan failed with "Device or
resource busy (-16)" after wlan recovery.

Tested-on: QCA6174 hw3.2 SDIO WLAN.RMH.4.4.1-00174

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath10k/mac.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 7675858f069b..c77837b50aa8 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -4503,18 +4503,21 @@ void __ath10k_scan_finish(struct ath10k *ar)
 		break;
 	case ATH10K_SCAN_RUNNING:
 	case ATH10K_SCAN_ABORTING:
+		if (ar->scan.is_roc && ar->scan.roc_notify)
+			ieee80211_remain_on_channel_expired(ar->hw);
+		fallthrough;
+	case ATH10K_SCAN_STARTING:
 		if (!ar->scan.is_roc) {
 			struct cfg80211_scan_info info = {
-				.aborted = (ar->scan.state ==
-					    ATH10K_SCAN_ABORTING),
+				.aborted = ((ar->scan.state ==
+					    ATH10K_SCAN_ABORTING) ||
+					    (ar->scan.state ==
+					    ATH10K_SCAN_STARTING)),
 			};
 
 			ieee80211_scan_completed(ar->hw, &info);
-		} else if (ar->scan.roc_notify) {
-			ieee80211_remain_on_channel_expired(ar->hw);
 		}
-		fallthrough;
-	case ATH10K_SCAN_STARTING:
+
 		ar->scan.state = ATH10K_SCAN_IDLE;
 		ar->scan_channel = NULL;
 		ar->scan.roc_freq = 0;

base-commit: 0a00db612b6df1fad80485e3642529d1f28ea084
-- 
2.40.1

