Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E328D654135
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Dec 2022 13:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiLVMnl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Dec 2022 07:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235650AbiLVMnh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Dec 2022 07:43:37 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604AC22BF8;
        Thu, 22 Dec 2022 04:43:34 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BMAldat005760;
        Thu, 22 Dec 2022 12:43:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=n4u0QORlDQIiNmr9PqyeFNaeaGjlinS5DG6hnZGlICQ=;
 b=J+QG8jkl5tAkYHMWziuti+rIE9AH2y+T52mw4Y+TSREMvfnAvrP5rGqEPy/ykrBVl5vC
 YCd6m98k0FGh9gLfBw5/L/KWOF42jyCZxJpNLHDqoLMH2Ll6DPUNHwyzLJN1mPhHZJT4
 dwKpasRvXJgiCSpbKBT6JNzt+BTKrBlyuTn/I3TGZEjENQby9B7iWbcJx49DBfFDS5rd
 aSNVg483Ehx518NtLDwBDjiL7CHdUmmEkCQa50gvIcTpTf7daW8kz/d1mFNCyswLB4aJ
 CjICv0hZBW37CbF1OoLCVXunB6hW994k9Q/HlUZa1BSPGL07vpW2a0sBedLV4ehzc/Ju Sw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mm0wfjr21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Dec 2022 12:43:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BMChL4R020922
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Dec 2022 12:43:21 GMT
Received: from youghand-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 22 Dec 2022 04:43:19 -0800
From:   Youghandhar Chintala <quic_youghand@quicinc.com>
To:     <ath10k@lists.infradead.org>, <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_mpubbise@quicinc.com>,
        Youghandhar Chintala <quic_youghand@quicinc.com>
Subject: [PATCH 2/2] wifi: ath10k: update the channel list if change in channel flags.
Date:   Thu, 22 Dec 2022 18:12:21 +0530
Message-ID: <20221222124221.30894-3-quic_youghand@quicinc.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221222124221.30894-1-quic_youghand@quicinc.com>
References: <20221222124221.30894-1-quic_youghand@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vaiGVMP9aUTPZOxXjkcOTheW1XDqGMo1
X-Proofpoint-GUID: vaiGVMP9aUTPZOxXjkcOTheW1XDqGMo1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-22_06,2022-12-22_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 spamscore=0 suspectscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212220111
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There are connection failures in hidden SSID case when the device is
with default reg domain WW.
For WW reg domain most of the 5 GHz channels are passive. When device
listens to the beacon on that channel, the driver is updating its
channel flag but firmware is not aware of it and firmware is not
sending probes on that channels.
Due to this, we are seeing connection failures when a device is trying
to connect with hidden SSID AP.
Register beacon hint notifier to the regulatory core so that driver get
notified when there is a change in channel flags. Driver's notifier
callback will send the updated flags to the firmware.

Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.2.2.c10-00754-QCAHLSWMTPL-1
Tested-on: QCA6174 hw3.2 SDIO WLAN.RMH.4.4.1-00174

Signed-off-by: Youghandhar Chintala <quic_youghand@quicinc.com>
---
 drivers/net/wireless/ath/ath10k/mac.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index ec8d5b29bc72..91a957295456 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -3534,6 +3534,15 @@ static void ath10k_mac_update_channel_list(struct ath10k *ar,
 	}
 }
 
+static void ath10k_mac_beacon_notifier(struct wiphy *wiphy)
+{
+	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
+	struct ath10k *ar = hw->priv;
+
+	if (ath10k_update_channel_list(ar))
+		ath10k_warn(ar, "failed to update channel list\n");
+}
+
 static void ath10k_reg_notifier(struct wiphy *wiphy,
 				struct regulatory_request *request)
 {
@@ -10286,6 +10295,8 @@ int ath10k_mac_register(struct ath10k *ar)
 			goto err_unregister;
 	}
 
+	ar->hw->wiphy->beacon_hint_notifier = ath10k_mac_beacon_notifier;
+
 	return 0;
 
 err_unregister:
-- 
2.38.0

