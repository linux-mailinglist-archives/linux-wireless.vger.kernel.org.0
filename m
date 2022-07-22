Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B979357E215
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Jul 2022 15:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiGVNMG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Jul 2022 09:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiGVNMF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Jul 2022 09:12:05 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817DD18B35
        for <linux-wireless@vger.kernel.org>; Fri, 22 Jul 2022 06:12:01 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26MCv5Gb000755;
        Fri, 22 Jul 2022 13:11:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=NwdrEmDmoBzb/m9vnLkE03KHc15m46ZxNqQiuzcka+4=;
 b=fx6i0p5vcTDfKxt1RcJJAcPOnn3yhophCLcvvcfVIIIloB6Wwt8FbITZ9a5kONNoEtOi
 Lu3ZRcUm6WyCT4hb92/G37VqYt2Tk0ER7Dw/gXw5f10stYVTvMWIZq+wT4oOpaV6HWrC
 Kb8LhOf/Hy2hkUpDBCNMkYC9hcPuiU7IZ5zRolKtzAjyR7XfN2yVio/xQw1xP9SimXfy
 ctbUhQ+M80TBR0CpHMOTzA8vXBQQWcVVgJf1CSS0WxLDqAxgy3P/dMNUE78f65WNaCX6
 lz/5hPk53gOFm/z9+tL6jFFLQBWFG7vrTAsdaZYKDdTpEJtw3CcP8z80J0UJlA+EUvXK zw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hftv7889u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jul 2022 13:11:58 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 26MDBvPV026112
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jul 2022 13:11:58 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 22 Jul 2022 06:11:57 -0700
Received: from cnss-mw-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 22 Jul 2022 06:11:56 -0700
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/3] nl80211: Add support to send MLO link ID info in channel switch events
Date:   Fri, 22 Jul 2022 18:41:43 +0530
Message-ID: <20220722131143.3438042-2-quic_vjakkam@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220722131143.3438042-1-quic_vjakkam@quicinc.com>
References: <20220722131143.3438042-1-quic_vjakkam@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: u8zclpKO_EUGkggpSOqvFb13wmQ44It1
X-Proofpoint-GUID: u8zclpKO_EUGkggpSOqvFb13wmQ44It1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-22_04,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 suspectscore=0 impostorscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207220056
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add support to send MLO link ID information in
NL80211_CMD_CH_SWITCH_NOTIFY and NL80211_CMD_CH_SWITCH_STARTED_NOTIFY
for userspace to know on which link the event is triggered.

Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
---
 net/wireless/nl80211.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 42430749913f..cd177d2a99bb 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -18809,6 +18809,7 @@ EXPORT_SYMBOL(cfg80211_pmksa_candidate_notify);
 
 static void nl80211_ch_switch_notify(struct cfg80211_registered_device *rdev,
 				     struct net_device *netdev,
+				     unsigned int link_id,
 				     struct cfg80211_chan_def *chandef,
 				     gfp_t gfp,
 				     enum nl80211_commands notif,
@@ -18816,6 +18817,7 @@ static void nl80211_ch_switch_notify(struct cfg80211_registered_device *rdev,
 {
 	struct sk_buff *msg;
 	void *hdr;
+	struct wireless_dev *wdev = netdev->ieee80211_ptr;
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, gfp);
 	if (!msg)
@@ -18830,6 +18832,10 @@ static void nl80211_ch_switch_notify(struct cfg80211_registered_device *rdev,
 	if (nla_put_u32(msg, NL80211_ATTR_IFINDEX, netdev->ifindex))
 		goto nla_put_failure;
 
+	if (wdev->valid_links &&
+	    nla_put_u8(msg, NL80211_ATTR_MLO_LINK_ID, link_id))
+		goto nla_put_failure;
+
 	if (nl80211_send_chandef(msg, chandef))
 		goto nla_put_failure;
 
@@ -18889,7 +18895,7 @@ void cfg80211_ch_switch_notify(struct net_device *dev,
 
 	cfg80211_sched_dfs_chan_update(rdev);
 
-	nl80211_ch_switch_notify(rdev, dev, chandef, GFP_KERNEL,
+	nl80211_ch_switch_notify(rdev, dev, link_id, chandef, GFP_KERNEL,
 				 NL80211_CMD_CH_SWITCH_NOTIFY, 0, false);
 }
 EXPORT_SYMBOL(cfg80211_ch_switch_notify);
@@ -18908,7 +18914,7 @@ void cfg80211_ch_switch_started_notify(struct net_device *dev,
 
 	trace_cfg80211_ch_switch_started_notify(dev, chandef, link_id);
 
-	nl80211_ch_switch_notify(rdev, dev, chandef, GFP_KERNEL,
+	nl80211_ch_switch_notify(rdev, dev, link_id, chandef, GFP_KERNEL,
 				 NL80211_CMD_CH_SWITCH_STARTED_NOTIFY,
 				 count, quiet);
 }
-- 
2.25.1

