Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751FE64E79D
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Dec 2022 08:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiLPHNR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Dec 2022 02:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiLPHMm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Dec 2022 02:12:42 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EF563FD
        for <linux-wireless@vger.kernel.org>; Thu, 15 Dec 2022 23:09:41 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BG5Fts6020051;
        Fri, 16 Dec 2022 07:09:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=SMMHidC9CouKZys2MmzOi0iNbDc9JwTuik96A5rL7Mc=;
 b=kwTyctDCwkVJykOfcG/COGd2YOUZBLDTs9xHJza+L+zFeukayXUyxEoI1vDHCBSQ8B5G
 Lv+5pJQo91VBxZyhvYNhd32mjYblyyMZo2YFKQ2MbZ3Cb1iPgFls53qMJpITPu3NYe1j
 /kuSPZkaSnhEfQ5shFP9AvwZy5+xwe3jV9oKs+B/klDa5q3r8OnO7mnO52pufUSaGPCe
 5aG/HMSd1XduOk0muQZmKfWzTTvPBrMJQNcSHFObgjvMh5nJwWvzTtJ4tv2vN3ZbzzPR
 u44psjgLSkzuxPa7sTrHbDRCPV2qBN+/5pdtQLZfE1/EBWP6lP17J/RN4FA+GqAS84kA bg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mfukhv9uu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 07:09:36 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BG79Zsv031287
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 07:09:35 GMT
Received: from nmaran-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 15 Dec 2022 23:09:33 -0800
From:   Nagarajan Maran <quic_nmaran@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Nagarajan Maran <quic_nmaran@quicinc.com>
Subject: [PATCH 1/2] wifi: cfg80211: DFS radar detection support with radar bitmap
Date:   Fri, 16 Dec 2022 12:39:17 +0530
Message-ID: <20221216070918.5969-2-quic_nmaran@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221216070918.5969-1-quic_nmaran@quicinc.com>
References: <20221216070918.5969-1-quic_nmaran@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pTn1GsrO3ZE6-lwizEO4sXNsRDqeN5di
X-Proofpoint-ORIG-GUID: pTn1GsrO3ZE6-lwizEO4sXNsRDqeN5di
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_03,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212160061
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

With the current implementation when radar is detected, the whole
configured DFS channels are moved to "unavailable" state(NOL).
However to move only the radar affected channels alone to NOL,
introducing two unsigned 16bit variables "cf1_radar_bitmap" and
"cf2_radar_bitmap" which denotes the radar(with a granularity of
20 MHz) in the first and the second part of the channel respectively.
The "cf2_radar_bitmap" value will be valid only when the
"center_freq2" is available.

The LSB of the radar bitmap corresponds to the lowest 20 MHz channel
of the configured channel bandwidth. Each bit set to "1" in this radar
bitmap indicates that radar is detected in that sub-channel. Based
on this radar bitmap the radar affected channels alone will be moved
to NOL. Advertise these radar bitmaps using new NL attributes
"NL80211_ATTR_CF1_RADAR_BITMAP" and "NL80211_ATTR_CF2_RADAR_BITMAP"
with the existing "NL80211_CMD_RADAR_DETECT". Once these are
advertised and the needed dfs state propagation is done, reset these
radar bitmap values as they are not valid until there is another
radar detection.With these radar bitmaps, we can support bandwidth
reduction and RX puncturing in the DFS Channels.

Signed-off-by: Nagarajan Maran <quic_nmaran@quicinc.com>
---
 include/net/cfg80211.h       |  6 ++++++
 include/uapi/linux/nl80211.h | 11 +++++++++++
 net/wireless/chan.c          | 24 ++++++++++++++++--------
 net/wireless/mlme.c          |  4 ++++
 net/wireless/nl80211.c       | 11 +++++++++++
 net/wireless/reg.c           |  3 +++
 6 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 03d4f4deadae..d6d4edb945db 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -744,6 +744,10 @@ struct key_params {
  *	chan will define the primary channel and all other
  *	parameters are ignored.
  * @freq1_offset: offset from @center_freq1, in KHz
+ * @cf1_radar_bitmap: Radar bitmap in a granularity of 20 MHz in the
+ *	first segment.
+ * @cf2_radar_bitmap: Radar bitmap in a granularity of 20 MHz in the
+ *	second segment.
  */
 struct cfg80211_chan_def {
 	struct ieee80211_channel *chan;
@@ -752,6 +756,8 @@ struct cfg80211_chan_def {
 	u32 center_freq2;
 	struct ieee80211_edmg edmg;
 	u16 freq1_offset;
+	u16 cf1_radar_bitmap;
+	u16 cf2_radar_bitmap;
 };
 
 /*
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index c14a91bbca7c..4a1c875f5b6f 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2751,6 +2751,15 @@ enum nl80211_commands {
  *	the incoming frame RX timestamp.
  * @NL80211_ATTR_TD_BITMAP: Transition Disable bitmap, for subsequent
  *	(re)associations.
+ *
+ * @NL80211_ATTR_CF1_RADAR_BITMAP: (u16) RADAR bitmap where the LSB
+ *	corresponds to the lowest 20 MHz of the first part of the channel.
+ *	Each bit set to 1 indicates that radar is detected in that sub-channel.
+ * @NL80211_ATTR_CF2_RADAR_BITMAP: (u16) RADAR bitmap where the LSB
+ *	corresponds to the lowest 20 MHz of the second part of the channel.
+ *	Each bit set to 1 indicates that radar is detected in that sub-channel.
+ *	This will be valid only when the %NL80211_ATTR_CENTER_FREQ2 is present.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3279,6 +3288,8 @@ enum nl80211_attrs {
 	NL80211_ATTR_TX_HW_TIMESTAMP,
 	NL80211_ATTR_RX_HW_TIMESTAMP,
 	NL80211_ATTR_TD_BITMAP,
+	NL80211_ATTR_CF1_RADAR_BITMAP,
+	NL80211_ATTR_CF2_RADAR_BITMAP,
 
 	/* add attributes here, update the policy in nl80211.c */
 
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 0e5835cd8c61..38fffe1a613a 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -447,20 +447,26 @@ EXPORT_SYMBOL(cfg80211_chandef_compatible);
 
 static void cfg80211_set_chans_dfs_state(struct wiphy *wiphy, u32 center_freq,
 					 u32 bandwidth,
-					 enum nl80211_dfs_state dfs_state)
+					 enum nl80211_dfs_state dfs_state,
+					 u16 radar_bitmap)
 {
 	struct ieee80211_channel *c;
 	u32 freq;
+	int i;
 
-	for (freq = center_freq - bandwidth/2 + 10;
-	     freq <= center_freq + bandwidth/2 - 10;
-	     freq += 20) {
+	for (i = 0, freq = center_freq - bandwidth / 2 + 10;
+	     freq <= center_freq + bandwidth / 2 - 10;
+	     freq += 20, i++) {
 		c = ieee80211_get_channel(wiphy, freq);
 		if (!c || !(c->flags & IEEE80211_CHAN_RADAR))
 			continue;
 
-		c->dfs_state = dfs_state;
-		c->dfs_state_entered = jiffies;
+		if (!radar_bitmap ||
+		    ((radar_bitmap & 1 << i) &&
+		     dfs_state == NL80211_DFS_UNAVAILABLE)) {
+			c->dfs_state = dfs_state;
+			c->dfs_state_entered = jiffies;
+		}
 	}
 }
 
@@ -478,12 +484,14 @@ void cfg80211_set_dfs_state(struct wiphy *wiphy,
 		return;
 
 	cfg80211_set_chans_dfs_state(wiphy, chandef->center_freq1,
-				     width, dfs_state);
+				     width, dfs_state,
+				     chandef->cf1_radar_bitmap);
 
 	if (!chandef->center_freq2)
 		return;
 	cfg80211_set_chans_dfs_state(wiphy, chandef->center_freq2,
-				     width, dfs_state);
+				     width, dfs_state,
+				     chandef->cf2_radar_bitmap);
 }
 
 static u32 cfg80211_get_start_freq(u32 center_freq,
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 58e1fb18f85a..077db2b50728 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -963,6 +963,10 @@ void __cfg80211_radar_event(struct wiphy *wiphy,
 
 	memcpy(&rdev->radar_chandef, chandef, sizeof(struct cfg80211_chan_def));
 	queue_work(cfg80211_wq, &rdev->propagate_radar_detect_wk);
+
+	/* Reset radar bitmaps, as they are advertised with radar detection */
+	chandef->cf1_radar_bitmap = 0;
+	chandef->cf2_radar_bitmap = 0;
 }
 EXPORT_SYMBOL(__cfg80211_radar_event);
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 33a82ecab9d5..c7b6d1d3da1c 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -805,6 +805,8 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_MLD_ADDR] = NLA_POLICY_EXACT_LEN(ETH_ALEN),
 	[NL80211_ATTR_MLO_SUPPORT] = { .type = NLA_FLAG },
 	[NL80211_ATTR_MAX_NUM_AKM_SUITES] = { .type = NLA_REJECT },
+	[NL80211_ATTR_CF1_RADAR_BITMAP] = { .type = NLA_U16 },
+	[NL80211_ATTR_CF2_RADAR_BITMAP] = { .type = NLA_U16 },
 };
 
 /* policy for the key attributes */
@@ -3763,6 +3765,15 @@ static int nl80211_send_chandef(struct sk_buff *msg,
 	if (chandef->center_freq2 &&
 	    nla_put_u32(msg, NL80211_ATTR_CENTER_FREQ2, chandef->center_freq2))
 		return -ENOBUFS;
+	if (chandef->cf1_radar_bitmap &&
+	    nla_put_u16(msg, NL80211_ATTR_CF1_RADAR_BITMAP,
+			chandef->cf1_radar_bitmap))
+		return -ENOBUFS;
+	if (chandef->cf2_radar_bitmap &&
+	    nla_put_u16(msg, NL80211_ATTR_CF2_RADAR_BITMAP,
+			chandef->cf2_radar_bitmap))
+		return -ENOBUFS;
+
 	return 0;
 }
 
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 4f3f31244e8b..cadfa2c1c0eb 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -4295,6 +4295,9 @@ void regulatory_propagate_dfs_state(struct wiphy *wiphy,
 
 		nl80211_radar_notify(rdev, chandef, event, NULL, GFP_KERNEL);
 	}
+	/* Reset radar bitmaps, since the propagation is done */
+	chandef->cf1_radar_bitmap = 0;
+	chandef->cf2_radar_bitmap = 0;
 }
 
 static int __init regulatory_init_db(void)
-- 
2.17.1

