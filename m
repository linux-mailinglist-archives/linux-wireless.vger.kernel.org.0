Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC6C762A6A
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jul 2023 06:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjGZEsQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jul 2023 00:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjGZEsM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jul 2023 00:48:12 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8423B1BD1
        for <linux-wireless@vger.kernel.org>; Tue, 25 Jul 2023 21:48:11 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q3dTvT004855;
        Wed, 26 Jul 2023 04:48:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=bld8BUBROrrRwVCh3Kj5Vv+4piv6m+lvnjbbx2/iHP8=;
 b=HEZSX0jTx0GWgOA4scVYPGPhCVVTIzdk6yjS0bZF6gqPKQjbCYxcZGdWuOIJnYTc2lYE
 8F1hx+moARsZFvbsKMxH997GDN7rg2V6QlyaE1Ok1davaj26KdSS32p5hEHbmU5pZpPs
 /2t1KBQ1D1mlvKBbQqlOPCILEdZ7eB0xsWICOZFM9Ep3G+wYuYHMoYbue3s2ebLYTTCb
 0k4h+W9lQBkI5kC105X1FUaxJ/D2l65iOvWNJS7IFeyRSvNe9PraNFhZKa2vfDYjg/eC
 Uli9ux96g0p9vsdSVZpmS2S7GFiF7qqMOsR0+v8GLrU2401Kgt8CRwNP5RbXID4YlUVo PA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s29xmjjqt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 04:48:04 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36Q4m3nS010025
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 04:48:03 GMT
Received: from adisi-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 25 Jul 2023 21:48:01 -0700
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: [PATCH] wifi: ath11k: fix band selection for ppdu received in channel 177 of 5 GHz
Date:   Wed, 26 Jul 2023 10:16:24 +0530
Message-ID: <20230726044624.20507-1-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: O6_49LwVBg_wUmtaWVtfzVKHEqF8Oh_7
X-Proofpoint-GUID: O6_49LwVBg_wUmtaWVtfzVKHEqF8Oh_7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_14,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 mlxlogscore=998 impostorscore=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307260040
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

5 GHz band channel 177 support was added with the commit
"wifi: ath11k: add channel 177 into 5 GHz channel list". However,
during processing for the received ppdu in ath11k_dp_rx_h_ppdu(), channel
number is checked only till 173. This leads to driver code checking for
channel and then fetching the band from it which is extra effort since
firmware has already given the channel number in the meta deta.

Fix this issue by checking the channel number till 177 since we support
it now.

Found via code review. Compile tested only.

Fixes: e5e94d10c856 ("wifi: ath11k: add channel 177 into 5 GHz channel list")
Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 5c76664ba0dd..1e488eed282b 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -2408,7 +2408,7 @@ static void ath11k_dp_rx_h_ppdu(struct ath11k *ar, struct hal_rx_desc *rx_desc,
 		rx_status->freq = center_freq;
 	} else if (channel_num >= 1 && channel_num <= 14) {
 		rx_status->band = NL80211_BAND_2GHZ;
-	} else if (channel_num >= 36 && channel_num <= 173) {
+	} else if (channel_num >= 36 && channel_num <= 177) {
 		rx_status->band = NL80211_BAND_5GHZ;
 	} else {
 		spin_lock_bh(&ar->data_lock);
-- 
2.17.1

