Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B006BEB0F
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Mar 2023 15:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjCQOXv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Mar 2023 10:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjCQOXu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Mar 2023 10:23:50 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBC03C2C
        for <linux-wireless@vger.kernel.org>; Fri, 17 Mar 2023 07:23:48 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32H7WoLe005989;
        Fri, 17 Mar 2023 14:23:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=RtdykfH34sB398wiH3FMtT32mbr+AL3pPqCl7SdbBwE=;
 b=HnZUmFikFpNGaFIar9ARUM2ALz6YOF28XLHziwMi2MRt4kAwh7FkKt1GQuqlNA9EFkFi
 gdHvW5Y3dicsE08prjVd7921PaeP1hjJp2hETCMMDx4kD8Ti7x0FedWQ/wFRDFTGss6x
 AkwudX+C+lIJ/hhiy/wXVeYaUQcSSREpL5q/RlcN5OBdJ7oEL18i15Yq6vNYIHcBJkVl
 fPXKwm6E+iZfL29gP9x9jtZbz8MwgBlPqAHSHBY7R93vaa0rEkX9QKkhxgLZJRpKZu6W
 +Ht17i2FkE53mDpBLxkUcTKixnseebmtUF2P6pknHcfP4XHQQ1vuKoPTcZ+n0yFZ4akv ww== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pcayeajs6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 14:23:44 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32HENiQY009855
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 14:23:44 GMT
Received: from cnss-mw-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 17 Mar 2023 07:23:42 -0700
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, <quic_vjakkam@quicinc.com>
Subject: [PATCH] wifi: cfg80211/nl80211: Add support to indicate STA MLD setup links removal
Date:   Fri, 17 Mar 2023 19:51:53 +0530
Message-ID: <20230317142153.237900-1-quic_vjakkam@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: sJWiyko8UxDlD-hjcQtnbKhrNF_8B2sw
X-Proofpoint-GUID: sJWiyko8UxDlD-hjcQtnbKhrNF_8B2sw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_09,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 bulkscore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303170098
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

STA MLD setup links may get removed if AP MLD remove the corresponding
affiliated APs with Multi-Link reconfiguration as described in
P802.11be_D3.0, section 35.3.6.2.2 Removing affiliated APs. Currently,
there is no support to notify such operation to cfg80211 and userspace.

Add support for the drivers to indicate STA MLD setup links removal to
cfg80211 and notify the same to userspace. Upon receiving such
indication from the driver, clear the MLO links information of the
removed links in the WDEV.

Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
---
 include/net/cfg80211.h       | 11 ++++++
 include/uapi/linux/nl80211.h | 10 ++++++
 net/wireless/core.h          |  1 +
 net/wireless/nl80211.c       | 70 ++++++++++++++++++++++++++++++++++++
 net/wireless/sme.c           | 15 ++++++++
 net/wireless/trace.h         | 15 ++++++++
 6 files changed, 122 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 7cebba1c4135..98809268e3a3 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -9036,4 +9036,15 @@ static inline int cfg80211_color_change_notify(struct net_device *dev)
 bool cfg80211_valid_disable_subchannel_bitmap(u16 *bitmap,
 					      const struct cfg80211_chan_def *chandef);
 
+/**
+ * cfg80211_link_reconfig - Notify about removed STA MLD setup links.
+ * @dev: network device.
+ * @link_mask: BIT mask of removed STA MLD setup link IDs.
+ *
+ * Inform cfg80211 and the userspace about removed STA MLD setup links due to
+ * AP MLD removing the corresponding affiliated APs with Multi-Link
+ * reconfiguration.
+ */
+void cfg80211_link_reconfig(struct net_device *dev, u16 link_mask);
+
 #endif /* __NET_CFG80211_H */
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 9a0ac0363f1f..5b3f94af8dc5 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1309,6 +1309,14 @@
  *	The number of peers that HW timestamping can be enabled for concurrently
  *	is indicated by %NL80211_ATTR_MAX_HW_TIMESTAMP_PEERS.
  *
+ * @NL80211_CMD_LINK_RECONFIG: Notify userspace about the removal of STA MLD
+ *	setup links due to AP MLD removing the corresponding affiliated APs with
+ *	Multi-Link reconfiguration. If all the STA MLD setup links removed
+ *	during Multi-Link reconfiguration, the driver shall use
+ *	%NL80211_CMD_DISCONNECT instead of this command since it is a connection
+ *	drop. %NL80211_ATTR_MLO_LINKS is used to provide information about the
+ *	removed STA MLD setup links.
+ *
  * @NL80211_CMD_MAX: highest used command number
  * @__NL80211_CMD_AFTER_LAST: internal use
  */
@@ -1562,6 +1570,8 @@ enum nl80211_commands {
 
 	NL80211_CMD_SET_HW_TIMESTAMP,
 
+	NL80211_CMD_LINK_RECONFIG,
+
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
diff --git a/net/wireless/core.h b/net/wireless/core.h
index 7c61752f6d83..0f47741e301e 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -569,5 +569,6 @@ void cfg80211_remove_link(struct wireless_dev *wdev, unsigned int link_id);
 void cfg80211_remove_links(struct wireless_dev *wdev);
 int cfg80211_remove_virtual_intf(struct cfg80211_registered_device *rdev,
 				 struct wireless_dev *wdev);
+void cfg80211_wdev_release_link_bsses(struct wireless_dev *wdev, u16 link_mask);
 
 #endif /* __NET_WIRELESS_CORE_H */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 0a31b1d2845d..359afd96d701 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -18167,6 +18167,76 @@ void nl80211_send_disconnected(struct cfg80211_registered_device *rdev,
 	nlmsg_free(msg);
 }
 
+void cfg80211_link_reconfig(struct net_device *dev, u16 link_mask)
+{
+	struct wireless_dev *wdev = dev->ieee80211_ptr;
+	struct wiphy *wiphy = wdev->wiphy;
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
+	struct sk_buff *msg;
+	struct nlattr *links;
+	void *hdr;
+
+	ASSERT_WDEV_LOCK(wdev);
+	trace_cfg80211_link_reconfig(dev, link_mask);
+
+	if (WARN_ON(wdev->iftype != NL80211_IFTYPE_STATION &&
+		    wdev->iftype != NL80211_IFTYPE_P2P_CLIENT))
+		return;
+
+	if (WARN_ON(!wdev->valid_links || !link_mask ||
+		    (wdev->valid_links & link_mask) != link_mask ||
+		    wdev->valid_links == link_mask))
+		return;
+
+	cfg80211_wdev_release_link_bsses(wdev, link_mask);
+	wdev->valid_links &= ~link_mask;
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return;
+
+	hdr = nl80211hdr_put(msg, 0, 0, 0, NL80211_CMD_LINK_RECONFIG);
+	if (!hdr) {
+		nlmsg_free(msg);
+		return;
+	}
+
+	if (nla_put_u32(msg, NL80211_ATTR_WIPHY, rdev->wiphy_idx) ||
+	    nla_put_u32(msg, NL80211_ATTR_IFINDEX, dev->ifindex))
+		goto nla_put_failure;
+
+	links = nla_nest_start(msg, NL80211_ATTR_MLO_LINKS);
+	if (!links)
+		goto nla_put_failure;
+
+	while (link_mask) {
+		struct nlattr *link;
+		int link_id = __ffs(link_mask);
+
+		link = nla_nest_start(msg, link_id + 1);
+		if (!link)
+			goto nla_put_failure;
+
+		if (nla_put_u8(msg, NL80211_ATTR_MLO_LINK_ID, link_id))
+			goto nla_put_failure;
+
+		nla_nest_end(msg, link);
+		link_mask &= ~(1 << link_id);
+	}
+
+	nla_nest_end(msg, links);
+
+	genlmsg_end(msg, hdr);
+
+	genlmsg_multicast_netns(&nl80211_fam, wiphy_net(&rdev->wiphy), msg, 0,
+				NL80211_MCGRP_MLME, GFP_KERNEL);
+	return;
+
+ nla_put_failure:
+	nlmsg_free(msg);
+}
+EXPORT_SYMBOL(cfg80211_link_reconfig);
+
 void nl80211_send_ibss_bssid(struct cfg80211_registered_device *rdev,
 			     struct net_device *netdev, const u8 *bssid,
 			     gfp_t gfp)
diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index 28ce13840a88..37823522da00 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -491,6 +491,21 @@ static void cfg80211_wdev_release_bsses(struct wireless_dev *wdev)
 	}
 }
 
+void cfg80211_wdev_release_link_bsses(struct wireless_dev *wdev, u16 link_mask)
+{
+	unsigned int link;
+
+	for_each_valid_link(wdev, link) {
+		if (!wdev->links[link].client.current_bss ||
+		    !(link_mask & BIT(link)))
+			continue;
+		cfg80211_unhold_bss(wdev->links[link].client.current_bss);
+		cfg80211_put_bss(wdev->wiphy,
+				 &wdev->links[link].client.current_bss->pub);
+		wdev->links[link].client.current_bss = NULL;
+	}
+}
+
 static int cfg80211_sme_get_conn_ies(struct wireless_dev *wdev,
 				     const u8 *ies, size_t ies_len,
 				     const u8 **out_ies, size_t *out_ies_len)
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 716a1fa70069..d31d76ac3f46 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -3946,6 +3946,21 @@ TRACE_EVENT(rdev_set_hw_timestamp,
 		  __entry->enable)
 );
 
+TRACE_EVENT(cfg80211_link_reconfig,
+	TP_PROTO(struct net_device *netdev, u16 link_mask),
+	TP_ARGS(netdev, link_mask),
+	TP_STRUCT__entry(
+		NETDEV_ENTRY
+		__field(u16, link_mask)
+	),
+	TP_fast_assign(
+		NETDEV_ASSIGN;
+		__entry->link_mask = link_mask;
+	),
+	TP_printk(NETDEV_PR_FMT ", link_mask:%u", NETDEV_PR_ARG,
+		  __entry->link_mask)
+);
+
 #endif /* !__RDEV_OPS_TRACE || TRACE_HEADER_MULTI_READ */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.25.1

