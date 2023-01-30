Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D01768066E
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jan 2023 08:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235811AbjA3HXH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Jan 2023 02:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235734AbjA3HXE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Jan 2023 02:23:04 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB371EB65
        for <linux-wireless@vger.kernel.org>; Sun, 29 Jan 2023 23:23:02 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30U5R2GX012346;
        Mon, 30 Jan 2023 07:22:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=bKTblokCGoYjixOwCXgpQa5tnihfrqA+kGfvd4N2gcY=;
 b=gmvlBTk8WhFAZChfEa5Q0ordY0OI7EFm+imliXYuSRIYvvSHxTgEf/p1H7yGb1iM2qkm
 7iaiMgfBBv0/BneCFq6hhMZipJuE2rAsaWuiLtAt/k+Wn4rgYTaHbETy58aBU45W7GQu
 SmvacqUq9scXRm9jOnY59/4Gj90AqlhWcqT1VDGNUorSFUqm8kkLNYjj/OssC5TI9nNV
 QYQimWhCMz2ajk0XVA0YNNUjPVgMqcl7hBgeUaPPGJqaa9N1TJv5WWUS3vb+KRkg2ycG
 GBRHzC8eOfEza2TQNeH9UpvlbeyUq1okDz4ZFf+bGxqENgRSqpgdpUBMrS4mtczntEQm cg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncu1tu8gn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 07:22:54 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30U7Mrrj014994
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 07:22:53 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sun, 29 Jan 2023 23:22:52 -0800
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH v3 6/6] wifi: nl80211: add puncturing bitmap in channel switch events
Date:   Sun, 29 Jan 2023 23:22:39 -0800
Message-ID: <20230130072239.26345-7-quic_alokad@quicinc.com>
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
X-Proofpoint-GUID: 98hL9NlcMvDgUfU00aI6XkBg15vTjkYB
X-Proofpoint-ORIG-GUID: 98hL9NlcMvDgUfU00aI6XkBg15vTjkYB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_05,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 impostorscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301300070
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Include the puncturing bitmap in channel switch (started/finished)
notifications to userspace.

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
 net/wireless/nl80211.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 55daddb0e6ad..4d415e04f5a3 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -18984,7 +18984,7 @@ static void nl80211_ch_switch_notify(struct cfg80211_registered_device *rdev,
 				     struct cfg80211_chan_def *chandef,
 				     gfp_t gfp,
 				     enum nl80211_commands notif,
-				     u8 count, bool quiet)
+				     u8 count, bool quiet, u32 punct_bitmap)
 {
 	struct wireless_dev *wdev = netdev->ieee80211_ptr;
 	struct sk_buff *msg;
@@ -19018,6 +19018,9 @@ static void nl80211_ch_switch_notify(struct cfg80211_registered_device *rdev,
 			goto nla_put_failure;
 	}
 
+	if (nla_put_u32(msg, NL80211_ATTR_PUNCT_BITMAP, punct_bitmap))
+		goto nla_put_failure;
+
 	genlmsg_end(msg, hdr);
 
 	genlmsg_multicast_netns(&nl80211_fam, wiphy_net(&rdev->wiphy), msg, 0,
@@ -19067,7 +19070,8 @@ void cfg80211_ch_switch_notify(struct net_device *dev,
 	cfg80211_sched_dfs_chan_update(rdev);
 
 	nl80211_ch_switch_notify(rdev, dev, link_id, chandef, GFP_KERNEL,
-				 NL80211_CMD_CH_SWITCH_NOTIFY, 0, false);
+				 NL80211_CMD_CH_SWITCH_NOTIFY, 0, false,
+				 punct_bitmap);
 }
 EXPORT_SYMBOL(cfg80211_ch_switch_notify);
 
@@ -19089,7 +19093,7 @@ void cfg80211_ch_switch_started_notify(struct net_device *dev,
 
 	nl80211_ch_switch_notify(rdev, dev, link_id, chandef, GFP_KERNEL,
 				 NL80211_CMD_CH_SWITCH_STARTED_NOTIFY,
-				 count, quiet);
+				 count, quiet, punct_bitmap);
 }
 EXPORT_SYMBOL(cfg80211_ch_switch_started_notify);
 
-- 
2.39.0

