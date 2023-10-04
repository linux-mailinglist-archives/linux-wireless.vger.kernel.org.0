Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814527B773E
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Oct 2023 06:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241063AbjJDEti (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Oct 2023 00:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241070AbjJDEti (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Oct 2023 00:49:38 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D952B0
        for <linux-wireless@vger.kernel.org>; Tue,  3 Oct 2023 21:49:34 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3944co2S017782;
        Wed, 4 Oct 2023 04:49:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=4dB9t9+cD+dWIHCfPjBXU7ikwo1P3PWqrr+bn3J03Ng=;
 b=iRjSJWB/BsIhHQxwXCgLYDP6h/CB+SJNbqMC5wFJjVDY4WxNUFxH+D2V0B+GlAy+oDeE
 yn/Y1SJTwc27MFx90c3mYbXrCT4FcJJbAn3cGc5Sukp7NJzeI1rLiX9k5pZHAQti4Phk
 iIFuaozqNACKmZGtYXZE/bxvqInYBIThHZ6cYbF22QGQHxgFiV+XRzstlNG7Qr1FOVZd
 lndJ55Cwj5ceDgUurK4QwjgujSm/Ddfilz8Ca18dHW5DfaTyBZ4p6/o/H4oAbJdUgn8K
 t9Yq0Sn4mOfBXmVBAIsGjyXEiNQnpMMQx9ec9zZ1Wx4+7jyO6/dBoDD0zSjOCTNPrGQ3 Ow== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tgr9mgx9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 04:49:29 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3944nSpp031863
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 4 Oct 2023 04:49:28 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 3 Oct 2023 21:49:28 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH] wifi: ath11k: call ath11k_mac_fils_discovery() without condition
Date:   Tue, 3 Oct 2023 21:49:15 -0700
Message-ID: <20231004044915.6817-1-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3kqY3yPEGmAwUO-U8PAl1HBPge2paz3v
X-Proofpoint-ORIG-GUID: 3kqY3yPEGmAwUO-U8PAl1HBPge2paz3v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_01,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 adultscore=0 clxscore=1011
 mlxlogscore=655 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310040033
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Mac80211 does not set flags BSS_CHANGED_FILS_DISCOVERY and
BSS_CHANGED_UNSOL_BCAST_PROBE_RESP if there are no updates to
FILS discovery and unsolicited broadcast probe response transmission
configurations respectively. This results in the transmissions getting
stopped during BSS change operations which do not include these
attributes. Remove the checks for the flags and always send the existing
configuration to firmware.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 20b04723daec..5b3d31f53ecf 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -3731,9 +3731,7 @@ static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 				    arvif->vdev_id, ret);
 	}
 
-	if (changed & BSS_CHANGED_FILS_DISCOVERY ||
-	    changed & BSS_CHANGED_UNSOL_BCAST_PROBE_RESP)
-		ath11k_mac_fils_discovery(arvif, info);
+	ath11k_mac_fils_discovery(arvif, info);
 
 	if (changed & BSS_CHANGED_ARP_FILTER) {
 		ipv4_cnt = min(vif->cfg.arp_addr_cnt, ATH11K_IPV4_MAX_COUNT);

base-commit: 140accd3f29eee6507f8a51bc38e85c119aedf14
-- 
2.39.0

