Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF65643A71
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Dec 2022 01:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbiLFAvA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Dec 2022 19:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbiLFAu4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Dec 2022 19:50:56 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8121B780
        for <linux-wireless@vger.kernel.org>; Mon,  5 Dec 2022 16:50:54 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B60YPbw011216;
        Tue, 6 Dec 2022 00:50:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=35Nea57BmHWey1TGhhfFbCTQq2Q5T/CDz/CR5sxgR+I=;
 b=Zch52zOBptbyacgscGZNYrBmdBnjdtz7R4rDC7yD0WJUfw7WV7dlSW1AG2a7Bjjl9Lui
 m92dA41yJ5KwCq9j8c/CAyHWHn9DhENDKjKynsWAxSRO9Olet2x2vb6YvWkwZdZJhv7g
 jTQXtR/AQZ2fydMG1zxKKN/wdHGdZJim+KuK1c1wgDP+L7IyEhrRK8y7FPUfski5frnS
 VGUcpc/2AxRo/4V7gYWnJRFmtc2jZlFwE8YRZGW8ndaqi01/GdEGECfCA041JKu/JqfM
 ctSyd9ARiwVuCYWtIJwjyGJvD1RHyTTkOilL5hwK+tRNbjouQlf26GxHPrm64kdeviGN 9g== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m9e61hx6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Dec 2022 00:50:51 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B60ooYf023936
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 6 Dec 2022 00:50:50 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 5 Dec 2022 16:50:49 -0800
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v3 3/4] wifi: mac80211_hwsim: Multiple BSSID support
Date:   Mon, 5 Dec 2022 16:50:39 -0800
Message-ID: <20221206005040.3177-4-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221206005040.3177-1-quic_alokad@quicinc.com>
References: <20221206005040.3177-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: H8E7wJI3zoOGxVOEr24tort7xG4O0Z4c
X-Proofpoint-GUID: H8E7wJI3zoOGxVOEr24tort7xG4O0Z4c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 mlxscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0 spamscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212060001
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Advertise multiple BSSID support for up to 8 interfaces.
Do not send beacons from the non-transmitting interfaces.

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
Correposponding hostapd tests:
he_ap_mbssid_open, test_he_ap_mbssid_same_security,
test_he_ap_mbssid_mixed_security1, test_he_ap_mbssid_mixed_security2.

drivers/net/wireless/mac80211_hwsim.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index b18f992b6276..7cf9a7a364be 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -2121,6 +2121,9 @@ static void mac80211_hwsim_beacon_tx(void *arg, u8 *mac,
 	    vif->type != NL80211_IFTYPE_OCB)
 		return;
 
+	if (vif->mbssid_tx_vif && vif->mbssid_tx_vif != vif)
+		return;
+
 	skb = ieee80211_beacon_get(hw, vif, link_id);
 	if (!skb)
 		return;
@@ -4404,6 +4407,8 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 		hw->wiphy->n_cipher_suites = param->n_ciphers;
 	}
 
+	hw->wiphy->mbssid_max_interfaces = 8;
+
 	data->rx_rssi = DEFAULT_RX_RSSI;
 
 	INIT_DELAYED_WORK(&data->roc_start, hw_roc_start);
-- 
2.34.1

