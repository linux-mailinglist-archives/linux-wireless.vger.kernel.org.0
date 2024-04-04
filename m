Return-Path: <linux-wireless+bounces-5880-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5797D898E75
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Apr 2024 21:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ACBC1C238D0
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Apr 2024 19:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E31132494;
	Thu,  4 Apr 2024 19:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="j/p70rKx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98D3132816
	for <linux-wireless@vger.kernel.org>; Thu,  4 Apr 2024 19:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712257219; cv=none; b=MBDJEekXc+RaHWl3NRwglx/RUH70/TIauxrPU2By8SitlJKTWVzVLVvbX9TXPRJmA77cck1VAKPuWY0nFM/GU3VSWE1uKjc//f6osNWTvlk32vR3vRSvbgNbygI/GjeHzeAYeHY9Cg0CBDAfE9cLdKg4Jy5AJFobNFzFyjW/cFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712257219; c=relaxed/simple;
	bh=Wr+7D8el2scnPFk0UMm/rgdkRYwAuGmdp+mFP6UPqgc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dHjFbo9UcDNNcgND1Fpy3nbpjLhQRQRWtrHY3VAAHbN2YDN/e+WhmYM9Jgfe5If/znoXF4veA1PzbLVshxRDpLxCSaI+ybpXOtgEdUFG+0WuvOSiSdxY787C1oNyo8kPVufTRtf9jJxU/24rzRBPtWcyAdABpUYcbMqkgJ70bqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=j/p70rKx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 434ItiXp026361;
	Thu, 4 Apr 2024 19:00:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=NiHPnZ7pnMuABYD89IzFZ657MI52CJLTfdPuAiTWiuY=; b=j/
	p70rKxL9CiKR4pAv3ImxjJF5+Pcyu90DZ1BZ8oHSTawPPc3Z94w0TxEpJQTIh6Zu
	6P7zV7bCVSv/YQsJkyWgNeQfp92Qn9wUZP8trT9ztlynErq1LkRNGP3MTlbaB9D6
	klTD0TPrSh4cntt+Df9poQD+tlPNnmqCdS8bZ+WuG+tm3yC/774N2QUyrwe3P8s+
	ZVJx5kGSGWqbRRKI9SRzoEapRKRpick9k6VmskJR0Sw4/NUvWjDUhd3zCgyk1juF
	B0zgVecQjJk2wsryCiKTmLaBPN/l54gwkUwmQUXzwvfZQz3ZJ9TNwIm0jzzw1NPt
	Xy/1H9GmASZE/co7V9jw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x9en5tbja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 19:00:12 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 434J0C6u031171
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Apr 2024 19:00:12 GMT
Received: from hu-mdharane-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 4 Apr 2024 12:00:10 -0700
From: Manish Dharanenthiran <quic_mdharane@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Manish Dharanenthiran
	<quic_mdharane@quicinc.com>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Subject: [RFC v2 1/2] wifi: cfg80211/mac80211: Introduce nl80211 commands to support MLD link removal offload
Date: Fri, 5 Apr 2024 00:29:49 +0530
Message-ID: <20240404185950.776062-2-quic_mdharane@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404185950.776062-1-quic_mdharane@quicinc.com>
References: <20240404185950.776062-1-quic_mdharane@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: b83GLI2_QW_dlLqeACGXJzlqdkHRkq82
X-Proofpoint-GUID: b83GLI2_QW_dlLqeACGXJzlqdkHRkq82
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_15,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 impostorscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404040134

This is a preparation for supporting Multi-Link reconfigure link removal
procedure[IEEE P802.11be/D5.0 - 35.3.6.3 Removing affiliated APs] for
driver which supports offloaded Multi-Link reconfigure link removal.

Multi-Link reconfigure link removal offloaded drivers will take care of
updating the reconfiguration MLE in self and partner beacons. It also
updates the AP removal timer automatically and notifies once the counter
is expired.

For such drivers AP link removal count(TBTT) and reconfiguration MLE
needs to be passed from userspace. AP link removal count indicates the
number of beacons the reconfiguration MLE will be present, after which
the link will be removed. To support this, NL80211_ATTR_AP_REMOVAL_COUNT
and NL80211_ATTR_IE are used.

In beacon offloaded drivers, to indicate status of ongoing link removal,
add two new commands NL80211_CMD_LINK_REMOVAL_STARTED,
NL80211_CMD_LINK_REMOVAL_COMPLETED. NL80211_CMD_LINK_REMOVAL_STARTED
will update timestamp of first beacon sent with reconfiguration MLE
using NL80211_ATTR_TSF attribute.

Co-developed-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Signed-off-by: Manish Dharanenthiran <quic_mdharane@quicinc.com>
---
 include/net/cfg80211.h       | 52 +++++++++++++++++++++
 include/uapi/linux/nl80211.h | 30 +++++++++++++
 net/wireless/core.h          |  2 +
 net/wireless/nl80211.c       | 87 ++++++++++++++++++++++++++++++++++++
 net/wireless/rdev-ops.h      | 17 +++++++
 net/wireless/trace.h         | 58 ++++++++++++++++++++++++
 net/wireless/util.c          | 17 +++++++
 7 files changed, 263 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 2e2be4fd2bb6..e016fd096373 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4169,6 +4169,23 @@ struct mgmt_frame_regs {
 	u32 global_mcast_stypes, interface_mcast_stypes;
 };
 
+/**
+ * struct cfg80211_link_reconfig_removal_params - Contains params needed for
+ * link reconfig removal
+ * @link_removal_cntdown: TBTT countdown value until which the beacon with ML
+ *	reconfigure element will be sent.
+ * @reconfigure_elem: ML reconfigure element to be updated in beacon in the link going to be
+ *	removed and in all affiliated links.
+ * @elem_len: ML reconfigure element length
+ * @link_id: Link id of the link to be removed.
+ */
+struct cfg80211_link_reconfig_removal_params {
+	u16 link_removal_cntdown;
+	const u8 *reconfigure_elem;
+	size_t elem_len;
+	unsigned int link_id;
+};
+
 /**
  * struct cfg80211_ops - backend description for wireless configuration
  *
@@ -4570,6 +4587,11 @@ struct mgmt_frame_regs {
  *
  * @set_hw_timestamp: Enable/disable HW timestamping of TM/FTM frames.
  * @set_ttlm: set the TID to link mapping.
+ *
+ * @link_reconfig_remove: Notifies the driver about the link to be
+ *	scheduled for removal with ML reconfigure element built for that particular
+ *	link along with the TBTT count until which the beacon with ML
+ *	reconfigure element should be sent.
  */
 struct cfg80211_ops {
 	int	(*suspend)(struct wiphy *wiphy, struct cfg80211_wowlan *wow);
@@ -4931,6 +4953,9 @@ struct cfg80211_ops {
 				    struct cfg80211_set_hw_timestamp *hwts);
 	int	(*set_ttlm)(struct wiphy *wiphy, struct net_device *dev,
 			    struct cfg80211_ttlm_params *params);
+	int	(*link_reconfig_remove)(struct wiphy *wiphy,
+					struct net_device *dev,
+					const struct cfg80211_link_reconfig_removal_params *params);
 };
 
 /*
@@ -9509,4 +9534,31 @@ ssize_t wiphy_locked_debugfs_write(struct wiphy *wiphy, struct file *file,
 				   void *data);
 #endif
 
+/**
+ * cfg80211_update_link_reconfig_remove_update - Inform userspace about
+ *	the removal status of link which is scheduled for removal
+ * @dev: the device on which the operation is requested
+ * @link_id: Link which is undergoing removal
+ * @tbtt_count: Current tbtt_count to be updated.
+ * @tsf: Beacon's timestamp value
+ * @cmd: Inform started or completed action to userspace based on the value
+ *
+ * This function is used to inform userspace about the ongoing link removal
+ * status. 'NL80211_CMD_LINK_REMOVAL_STARTED' is issued when the first beacon with
+ * ML reconfigure element is sent out. This event can be used by userspace to start
+ * the BTM in case of AP mode. And, NL80211_CMD_LINK_REMOVAL_COMPLETED is issued
+ * when the last beacon is sent with ML reconfigure element. This is used to
+ * initiate the deletion of that link, also to trigger deauth/disassoc for the
+ * associated peer(s).
+ *
+ * Note: This API is currently used by drivers which supports offloaded
+ * Multi-Link reconfigure link removal. Returns failure if FEATURE FLAG is not
+ * set or success if NL message is sent.
+ */
+int
+cfg80211_update_link_reconfig_remove_update(struct net_device *dev,
+					    unsigned int link_id,
+					    u8 tbtt_count, u64 tsf,
+					    enum nl80211_commands cmd);
+
 #endif /* __NET_CFG80211_H */
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index f917bc6c9b6f..5d09140fd070 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1304,6 +1304,10 @@
  * @NL80211_CMD_REMOVE_LINK: Remove a link from an interface. This may come
  *	without %NL80211_ATTR_MLO_LINK_ID as an easy way to remove all links
  *	in preparation for e.g. roaming to a regular (non-MLO) AP.
+ *	To initiate link removal procedure, set below attributes,
+ *	%NL80211_ATTR_AP_REMOVAL_COUNT - AP removal timer count(TBTT)
+ *	%NL80211_ATTR_IE - ML reconfigure Information element
+ *	Can be extended to update multiple TBTT & element(s).
  *
  * @NL80211_CMD_ADD_LINK_STA: Add a link to an MLD station
  * @NL80211_CMD_MODIFY_LINK_STA: Modify a link of an MLD station
@@ -1329,6 +1333,14 @@
  *      %NL80211_ATTR_MLO_TTLM_ULINK attributes are used to specify the
  *      TID to Link mapping for downlink/uplink traffic.
  *
+ * @NL80211_CMD_LINK_REMOVAL_STARTED: Once first beacon with reconfiguration MLE
+ *	is sent, userspace is notified with the TBTT and TSF value to indicate
+ *	timestamp of that beacon using %NL80211_ATTR_AP_REMOVAL_COUNT and
+ *	%NL80211_ATTR_TSF respectively.
+ *
+ * @NL80211_CMD_LINK_REMOVAL_COMPLETED: Once last beacon with reconfiguration
+ *	MLE is sent, userspace is notified with completion.
+ *
  * @NL80211_CMD_MAX: highest used command number
  * @__NL80211_CMD_AFTER_LAST: internal use
  */
@@ -1586,6 +1598,10 @@ enum nl80211_commands {
 
 	NL80211_CMD_SET_TID_TO_LINK_MAPPING,
 
+	NL80211_CMD_LINK_REMOVAL_STARTED,
+
+	NL80211_CMD_LINK_REMOVAL_COMPLETED,
+
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
@@ -2856,6 +2872,13 @@ enum nl80211_commands {
  *	%NL80211_CMD_ASSOCIATE indicating the SPP A-MSDUs
  *	are used on this connection
  *
+ * @NL80211_ATTR_AP_REMOVAL_COUNT: (u16) TBTT count up-to which reconfiguration
+ *	MLE is sent. Also, userspace will be notified with this count once the
+ *	first beacon with reconfiguration MLE is sent.
+ *
+ * @NL80211_ATTR_TSF: (u64) TSF value when the first beacon with reconfiguration
+ *	MLE is sent.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3401,6 +3424,9 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_ASSOC_SPP_AMSDU,
 
+	NL80211_ATTR_AP_REMOVAL_COUNT,
+	NL80211_ATTR_TSF,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -6545,6 +6571,9 @@ enum nl80211_feature_flags {
  *	(signaling and payload protected) A-MSDUs and this shall be advertised
  *	in the RSNXE.
  *
+ * @NL80211_EXT_FEATURE_MLD_LINK_REMOVAL_OFFLOAD: Driver/device which supports
+ *	ML reconfig link removal offload.
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -6620,6 +6649,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_OWE_OFFLOAD_AP,
 	NL80211_EXT_FEATURE_DFS_CONCURRENT,
 	NL80211_EXT_FEATURE_SPP_AMSDU_SUPPORT,
+	NL80211_EXT_FEATURE_MLD_LINK_REMOVAL_OFFLOAD,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/wireless/core.h b/net/wireless/core.h
index 118f2f619828..ce1a1aa048e2 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -552,6 +552,8 @@ void cfg80211_remove_links(struct wireless_dev *wdev);
 int cfg80211_remove_virtual_intf(struct cfg80211_registered_device *rdev,
 				 struct wireless_dev *wdev);
 void cfg80211_wdev_release_link_bsses(struct wireless_dev *wdev, u16 link_mask);
+int cfg80211_link_reconfig_remove(struct wireless_dev *wdev,
+				  const struct cfg80211_link_reconfig_removal_params *params);
 
 /**
  * struct cfg80211_colocated_ap - colocated AP information
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index b4edba6b0b7b..6a1a9e370cde 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -826,6 +826,8 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_MLO_TTLM_DLINK] = NLA_POLICY_EXACT_LEN(sizeof(u16) * 8),
 	[NL80211_ATTR_MLO_TTLM_ULINK] = NLA_POLICY_EXACT_LEN(sizeof(u16) * 8),
 	[NL80211_ATTR_ASSOC_SPP_AMSDU] = { .type = NLA_FLAG },
+	[NL80211_ATTR_AP_REMOVAL_COUNT] = { .type = NLA_U8 },
+	[NL80211_ATTR_TSF] = { .type = NLA_U64 },
 };
 
 /* policy for the key attributes */
@@ -16103,6 +16105,7 @@ static int nl80211_remove_link(struct sk_buff *skb, struct genl_info *info)
 	unsigned int link_id = nl80211_link_id(info->attrs);
 	struct net_device *dev = info->user_ptr[1];
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
+	struct cfg80211_link_reconfig_removal_params params = {};
 
 	/* cannot remove if there's no link */
 	if (!info->attrs[NL80211_ATTR_MLO_LINK_ID])
@@ -16115,6 +16118,30 @@ static int nl80211_remove_link(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 	}
 
+	if (info->attrs[NL80211_ATTR_AP_REMOVAL_COUNT]) {
+		/* Parsing and sending information to driver about ML
+		 * reconfiguration is supported only when
+		 * NL80211_EXT_FEATURE_MLD_LINK_REMOVAL_OFFLOAD is set
+		 */
+		if (!wiphy_ext_feature_isset(wdev->wiphy,
+					     NL80211_EXT_FEATURE_MLD_LINK_REMOVAL_OFFLOAD))
+			return -EOPNOTSUPP;
+
+		/* If AP removal count is present, it is mandatory to have IE
+		 * attribute as well, return error if not present
+		 */
+		if (!info->attrs[NL80211_ATTR_IE])
+			return -EINVAL;
+
+		params.reconfigure_elem = nla_data(info->attrs[NL80211_ATTR_IE]);
+		params.elem_len = nla_len(info->attrs[NL80211_ATTR_IE]);
+		params.link_removal_cntdown =
+			nla_get_u16(info->attrs[NL80211_ATTR_AP_REMOVAL_COUNT]);
+		params.link_id = link_id;
+
+		return cfg80211_link_reconfig_remove(wdev, &params);
+	}
+
 	cfg80211_remove_link(wdev, link_id);
 
 	return 0;
@@ -20214,6 +20241,66 @@ void cfg80211_schedule_channels_check(struct wireless_dev *wdev)
 }
 EXPORT_SYMBOL(cfg80211_schedule_channels_check);
 
+int
+cfg80211_update_link_reconfig_remove_update(struct net_device *netdev,
+					    unsigned int link_id,
+					    u8 tbtt_count, u64 tsf,
+					    enum nl80211_commands cmd)
+{
+	struct wireless_dev *wdev = netdev->ieee80211_ptr;
+	struct wiphy *wiphy = wdev->wiphy;
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
+	struct sk_buff *msg;
+	void *hdr;
+
+	/* Only for ML reconfigure link removal offloaded driver, need to
+	 * update the status about the ongoing link removal to userspace.
+	 */
+	if (!wiphy_ext_feature_isset(wiphy,
+				     NL80211_EXT_FEATURE_MLD_LINK_REMOVAL_OFFLOAD))
+		return -EOPNOTSUPP;
+
+	if (link_id >= 0 || !(wdev->valid_links & BIT(link_id)))
+		return -EINVAL;
+
+	trace_cfg80211_update_link_reconfig_remove_update(wiphy, netdev,
+							  link_id, tbtt_count,
+							  tsf, cmd);
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_ATOMIC);
+	if (!msg)
+		return -ENOMEM;
+
+	hdr = nl80211hdr_put(msg, 0, 0, 0, cmd);
+
+	if (!hdr)
+		goto nla_put_failure;
+
+	if (nla_put_u32(msg, NL80211_ATTR_WIPHY, rdev->wiphy_idx) ||
+	    nla_put_u32(msg, NL80211_ATTR_IFINDEX, netdev->ifindex))
+		goto nla_put_failure;
+
+	if (nla_put_u8(msg, NL80211_ATTR_MLO_LINK_ID, link_id) ||
+	    nla_put_u8(msg, NL80211_ATTR_AP_REMOVAL_COUNT, tbtt_count) ||
+	    nla_put_u64_64bit(msg, NL80211_ATTR_TSF, tsf,
+			      NL80211_ATTR_PAD))
+		goto nla_put_failure;
+
+	genlmsg_end(msg, hdr);
+
+	genlmsg_multicast_netns(&nl80211_fam, wiphy_net(wiphy), msg, 0,
+				NL80211_MCGRP_MLME, GFP_ATOMIC);
+
+	return 0;
+
+ nla_put_failure:
+	genlmsg_cancel(msg, hdr);
+	nlmsg_free(msg);
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL(cfg80211_update_link_reconfig_remove_update);
+
 /* initialisation/exit functions */
 
 int __init nl80211_init(void)
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 43897a5269b6..cbf5da73fbb0 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -1459,6 +1459,23 @@ rdev_del_intf_link(struct cfg80211_registered_device *rdev,
 	trace_rdev_return_void(&rdev->wiphy);
 }
 
+static inline int
+rdev_link_reconfig_remove(struct cfg80211_registered_device *rdev,
+			  struct net_device *dev,
+			  const struct cfg80211_link_reconfig_removal_params *params)
+{
+	int ret = -EOPNOTSUPP;
+
+	trace_rdev_link_reconfig_remove(&rdev->wiphy, dev, params);
+
+	if (rdev->ops->link_reconfig_remove)
+		ret = rdev->ops->link_reconfig_remove(&rdev->wiphy, dev,
+						      params);
+
+	trace_rdev_return_int(&rdev->wiphy, ret);
+	return ret;
+}
+
 static inline int
 rdev_add_link_station(struct cfg80211_registered_device *rdev,
 		      struct net_device *dev,
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index e039e66ab377..383b07601275 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -4005,6 +4005,64 @@ TRACE_EVENT(rdev_set_ttlm,
 		  WIPHY_PR_ARG, NETDEV_PR_ARG)
 );
 
+TRACE_EVENT(rdev_link_reconfig_remove,
+	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
+		 const struct cfg80211_link_reconfig_removal_params *params),
+
+	TP_ARGS(wiphy, netdev, params),
+
+	TP_STRUCT__entry(
+		WIPHY_ENTRY
+		NETDEV_ENTRY
+		__field(u32, link_id)
+		__field(u16, count)
+		__dynamic_array(u8, frame, params->elem_len)
+	),
+
+	TP_fast_assign(
+		WIPHY_ASSIGN;
+		NETDEV_ASSIGN;
+		__entry->link_id = params->link_id;
+		__entry->count = params->link_removal_cntdown;
+		memcpy(__get_dynamic_array(frame), params->reconfigure_elem,
+		       params->elem_len);
+	),
+
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", link_id: %u frame:0x%.2x count:%d",
+		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->link_id,
+		  le16_to_cpup((__le16 *)__get_dynamic_array(frame)), __entry->count)
+);
+
+TRACE_EVENT(cfg80211_update_link_reconfig_remove_update,
+	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
+		 unsigned int link_id, u8 tbtt_count, u64 tsf,
+		 enum nl80211_commands cmd),
+
+	TP_ARGS(wiphy, netdev, link_id, tbtt_count, tsf, cmd),
+
+	TP_STRUCT__entry(
+		WIPHY_ENTRY
+		NETDEV_ENTRY
+		__field(u32, link_id)
+		__field(u8, tbtt_count)
+		__field(u64, tsf)
+		__field(enum nl80211_commands, cmd)
+	),
+
+	TP_fast_assign(
+		WIPHY_ASSIGN;
+		NETDEV_ASSIGN;
+		__entry->link_id = link_id;
+		__entry->tbtt_count = tbtt_count;
+		__entry->tsf = tsf;
+		__entry->cmd = cmd;
+	),
+
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", link_id: %u tbtt:%u tsf: %lld, cmd: %d",
+		  WIPHY_PR_ARG, NETDEV_PR_ARG,
+		  __entry->link_id, __entry->tbtt_count, __entry->tsf, __entry->cmd)
+);
+
 #endif /* !__RDEV_OPS_TRACE || TRACE_HEADER_MULTI_READ */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 2bde8a354631..a7ba0d1850b5 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -2799,6 +2799,23 @@ bool cfg80211_iftype_allowed(struct wiphy *wiphy, enum nl80211_iftype iftype,
 }
 EXPORT_SYMBOL(cfg80211_iftype_allowed);
 
+int cfg80211_link_reconfig_remove(struct wireless_dev *wdev,
+				  const struct cfg80211_link_reconfig_removal_params *params)
+{
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
+
+	lockdep_assert_wiphy(wdev->wiphy);
+
+	/* Currently, removal of link from MLD is supported for AP BSS only, it
+	 * can be extended for non-AP/STA MLD as well but that shall use
+	 * action frame to update about its link reconfiguration.
+	 */
+	if (wdev->iftype == NL80211_IFTYPE_AP)
+		return rdev_link_reconfig_remove(rdev, wdev->netdev, params);
+
+	return -EINVAL;
+}
+
 void cfg80211_remove_link(struct wireless_dev *wdev, unsigned int link_id)
 {
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
-- 
2.34.1


