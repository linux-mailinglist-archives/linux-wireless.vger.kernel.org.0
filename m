Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5191C680668
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jan 2023 08:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235643AbjA3HXD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Jan 2023 02:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjA3HXC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Jan 2023 02:23:02 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06182EB65
        for <linux-wireless@vger.kernel.org>; Sun, 29 Jan 2023 23:22:59 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30U7205n023169;
        Mon, 30 Jan 2023 07:22:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=ZzB6z+OzCHpblfZxtSDFGZdU4J1iOadjsxWl2svHmFM=;
 b=Gyeb13k4HjkMY4z/5Ms3hDBHfSYZzTVneh5pKDT17Wl44ZxAq/wuo8mWPmQs2DLb7iJj
 XHL0RWUCfAzPfMnA+l4+22UcphxmyKC0FJsiIhUFT+Z5aWboTmtBIAKVDcXuk0mtNm+Y
 yaMWBMAfHTlbxExwmiDWc+immcGhx17j+DKdBqV+pjOZkzoPL02XU57l8OqtMQ3GoXRk
 cHW0c7tMx/6xHnVegpBwmvmGGACdZUrapyAVqWSp1QwKsXVjFnAuoE+LFa2FyMhmYPhB
 5P+EI9sGCvZ5RS5n7BTNPCyZP9P1/bU/iz3W9/IR9NQAhO2wVFApBJ/DAq83FjURdIKa rQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncv3fb6p6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 07:22:53 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30U7Mq65008655
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 07:22:52 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sun, 29 Jan 2023 23:22:51 -0800
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH v3 3/6] wifi: nl80211: configure puncturing in NL80211_CMD_CHANNEL_SWITCH
Date:   Sun, 29 Jan 2023 23:22:36 -0800
Message-ID: <20230130072239.26345-4-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230130072239.26345-1-quic_alokad@quicinc.com>
References: <20230130072239.26345-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gpQVyqwk1qh0W4n6rX1rfFyIeNftExXP
X-Proofpoint-ORIG-GUID: gpQVyqwk1qh0W4n6rX1rfFyIeNftExXP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_05,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 adultscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301300070
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Retrieve the puncturing bitmap during channel switch operation and
store it in struct cfg80211_csa_settings.

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
 include/net/cfg80211.h | 5 +++++
 net/mac80211/cfg.c     | 5 ++---
 net/wireless/nl80211.c | 7 +++++++
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index c25a558d50ea..7714a44d312e 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1372,6 +1372,10 @@ struct cfg80211_ap_settings {
  * @radar_required: whether radar detection is required on the new channel
  * @block_tx: whether transmissions should be blocked while changing
  * @count: number of beacons until switch
+ * @punct_bitmap: Preamble puncturing bitmap. Each bit represents a 20 MHz
+ *	channel with lowest bit corresponding to the lowest frequency. Bit set
+ *	to 1 indicates that the channel is punctured. Higher 16 bits are
+ *	currently unused.
  */
 struct cfg80211_csa_settings {
 	struct cfg80211_chan_def chandef;
@@ -1384,6 +1388,7 @@ struct cfg80211_csa_settings {
 	bool radar_required;
 	bool block_tx;
 	u8 count;
+	u32 punct_bitmap;
 };
 
 /**
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 185e218e8668..87aab0ba9353 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1297,9 +1297,8 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	}
 
 	if (params->eht_cap) {
-		if (!ieee80211_valid_disable_subchannel_bitmap(
-							&params->punct_bitmap,
-							params->chandef.width))
+		if (!ieee80211_valid_disable_subchannel_bitmap(&params->punct_bitmap,
+							       params->chandef.width))
 			return -EINVAL;
 		link_conf->eht_puncturing = params->punct_bitmap;
 		changed |= BSS_CHANGED_EHT_PUNCTURING;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 351c4cc5ec92..efe841ba8865 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -10078,6 +10078,13 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[NL80211_ATTR_CH_SWITCH_BLOCK_TX])
 		params.block_tx = true;
 
+	if (info->attrs[NL80211_ATTR_PUNCT_BITMAP]) {
+		err = nl80211_parse_punct_bitmap(rdev, info,
+						 &params.punct_bitmap);
+		if (err)
+			goto free;
+	}
+
 	wdev_lock(wdev);
 	err = rdev_channel_switch(rdev, dev, &params);
 	wdev_unlock(wdev);
-- 
2.39.0

