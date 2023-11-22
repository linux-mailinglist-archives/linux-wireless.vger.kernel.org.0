Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8664D7F3E45
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Nov 2023 07:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbjKVGkF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Nov 2023 01:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjKVGkE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Nov 2023 01:40:04 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF7E19D
        for <linux-wireless@vger.kernel.org>; Tue, 21 Nov 2023 22:40:00 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AM4x9Ut021696;
        Wed, 22 Nov 2023 06:39:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=05Ai4kFhbQgeobP1c/yOIK/orqSWfTvtFADCmroXUrY=;
 b=QL1anAsRkLeKY9P6EQD77dWKK9D1iblOsZzNJ2iqorOb9NKraSn+uQH7DdU6uo2pNop4
 AVlpAaSnaszlzgGOnIhr1DhBU/TMZu5gsj/zXLR/qIoJQBKS3G1XbUpn9iPtR0VxpSrJ
 bpY2jy2G2pixFQwirW8Ns8hA2QDobuoBxHQV9E/HcoyJfb2aQYpmEfUJkqRW0QNtMmjb
 KeJ9V82SbfmDvdkIxrMHvJT4YvZzFKFZXdhEWY/lP2bzyb3oBgFw5OG3D/HJZP+aFEpX
 r0G7DpoFIpVJ20mdcOU6p5dOTdeAtDhHSpcAhth7mFi/HO8wBbtf+6+4wGTSuIYW0wbp AA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ugu54atdw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 06:39:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AM6dsho030401
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 06:39:54 GMT
Received: from tamizhr-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 21 Nov 2023 22:39:52 -0800
From:   Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
Subject: [PATCH 1/3] wifi: ath12k: fix calling correct function for rx monitor mode
Date:   Wed, 22 Nov 2023 12:09:30 +0530
Message-ID: <20231122063932.10321-2-quic_tamizhr@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231122063932.10321-1-quic_tamizhr@quicinc.com>
References: <20231122063932.10321-1-quic_tamizhr@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: njW0vcUl3vg1XE1se5DJREvFwUW4aaYY
X-Proofpoint-ORIG-GUID: njW0vcUl3vg1XE1se5DJREvFwUW4aaYY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_04,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 bulkscore=0 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 mlxlogscore=928 adultscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311220046
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently in ath12k_dp_tx_htt_monitor_mode_ring_config()
ath12k_dp_tx_htt_tx_monitor_mode_ring_config() function wrongly called
twice. Fix that by calling ath12k_dp_tx_htt_rx_monitor_mode_ring_config().

Currently monitor mode is disabled in driver so the change is compile
tested and boot sequence verified.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index 492ca6ce6714..8b5ca90d4f17 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -1030,7 +1030,7 @@ int ath12k_dp_tx_htt_monitor_mode_ring_config(struct ath12k *ar, bool reset)
 		return ret;
 	}
 
-	ret = ath12k_dp_tx_htt_tx_monitor_mode_ring_config(ar, reset);
+	ret = ath12k_dp_tx_htt_rx_monitor_mode_ring_config(ar, reset);
 	if (ret) {
 		ath12k_err(ab, "failed to setup rx monitor filter %d\n", ret);
 		return ret;
-- 
2.17.1

