Return-Path: <linux-wireless+bounces-4826-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7934187E329
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 06:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FBE72828FB
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 05:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5358F21379;
	Mon, 18 Mar 2024 05:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mjvCNiKY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB3B200C7
	for <linux-wireless@vger.kernel.org>; Mon, 18 Mar 2024 05:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710740205; cv=none; b=EJzwOZDF2PFdHTOWo9xh0GftrkySKLv2kFjmiNHY6dxE/qB3t0CTvoTsuAawvyHkqwYp9VFg9Ysdl6kFQ9ELvP0UAOgkGteRgkVy/T6lfF2XKZ6j5wmXi8UpS5b60prxxlnnlo+JCrZPk2Ni6XsHIF+U6cAvWia8zvS7HngeXBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710740205; c=relaxed/simple;
	bh=nP6iPZlP4uqDCxZbWuWF2CU64r0bJ0E/L2andRBl5N4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WAkQonr782qDIFGEOEy9j+rkimgDqppFvc+FNdGm+26h31w0Mz5NhlgJw4dkqsxPiNWH6ZRYyr6wYpIkBbx/xL9j8mJQ8mtG91ztn4jb+ruoiIm1MtKeDWESbkKI/WKwqubvPMaqfqW/+RgOiIrS7XCMkbNGKpx193Fhi3awWl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mjvCNiKY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42I2TUkK027647;
	Mon, 18 Mar 2024 05:36:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=nCPmt04n30baei2Bt6KRmDlRcXbO6R1P+rFqtm6/vwk=; b=mj
	vCNiKYW3c1VWKgPumqHcJlr+gyuiAsplUZHoS19gMK9DhElpgIId6yuu+Xt/i8ve
	EWbfz7PESZDxLMh94YlV0t6mI6Yn1MOOxK4r4Us0bECcJd5BG1FSxJQm1dMIJGag
	J3W6zjbtsSAh2fYk8wDcFT0hkIUGd01w8F3LGfNBENmm9f46Q+nJi+z0duwiYRIy
	66gUqOX9Ie1CGzgeGAHlV4IgGH5NwCa7Gz8KuJ9Is9L7JStQzlYzmWIpofPIjozz
	HW0c7MYewcT9HRwvF3WQlmiOo+uhSC8VkXX3mKVQfY7JfpRLslYOKlyKXj0Q+WrV
	Pa6F2GQolCo6WaVRVX+A==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wwxtb14ve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 05:36:30 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42I5aT7n030957
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 05:36:29 GMT
Received: from hu-rrchinan-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 17 Mar 2024 22:36:27 -0700
From: Rathees Kumar R Chinannan <quic_rrchinan@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Rathees Kumar R Chinannan
	<quic_rrchinan@quicinc.com>
Subject: [RFC 1/2] wifi: nl80211: Add attribute to send critical update params
Date: Mon, 18 Mar 2024 11:06:06 +0530
Message-ID: <20240318053607.1056739-2-quic_rrchinan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240318053607.1056739-1-quic_rrchinan@quicinc.com>
References: <20240318053607.1056739-1-quic_rrchinan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BLT8bUaCOQ6iOP71gycBQm0DUA6V_UC9
X-Proofpoint-ORIG-GUID: BLT8bUaCOQ6iOP71gycBQm0DUA6V_UC9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-17_12,2024-03-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0 mlxlogscore=958
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403180040

Add NL80211_ATTR_RXMGMT_CRITICAL_UPDATE attribute to send critical
update params to hostapd on NL80211_CMD_FRAME.

User space application requires these CU params to update fields on probe
and assoc response frame. So, during probe or assoc request frame receive,
send these params as a new attribute on existing NL80211_CMD_FRAME for
AP MLD.

Change in CU parameters should be sent to user space either before or
along with probe or assoc request frame receive to ensure that user space
uses latest CU values and BPCC while generating response to the received
frames. So, add the critical update parameters as a new attribute to
existing NL80211_CMD_FRAME command instead of sending this on a separate
NL80211 event.

Signed-off-by: Rathees Kumar R Chinannan <quic_rrchinan@quicinc.com>
---
 include/net/cfg80211.h       |  10 +++
 include/uapi/linux/nl80211.h |  98 +++++++++++++++++++++++++++++
 net/wireless/nl80211.c       | 117 ++++++++++++++++++++++++++++++++++-
 3 files changed, 224 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 2e2be4fd2bb6..496a9d4956de 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -6142,7 +6142,11 @@ void wiphy_delayed_work_flush(struct wiphy *wiphy,
  *	unprotected beacon report
  * @links: array of %IEEE80211_MLD_MAX_NUM_LINKS elements containing @addr
  *	@ap and @client for each link
+ * @links.ap.bpcc: Bss param change count value for each link
+ * @links.ap.switch_count: CSA/BCCA count for each link
+ * @links.ap.critical_flag: Critical update flag for each link
  * @valid_links: bitmap describing what elements of @links are valid
+ * @critical_update: critical params updated on any wdev link
  */
 struct wireless_dev {
 	struct wiphy *wiphy;
@@ -6247,6 +6251,9 @@ struct wireless_dev {
 		u8 addr[ETH_ALEN] __aligned(2);
 		union {
 			struct {
+				u8 bpcc;
+				u8 switch_count;
+				bool critical_flag;
 				unsigned int beacon_interval;
 				struct cfg80211_chan_def chandef;
 			} ap;
@@ -6256,6 +6263,7 @@ struct wireless_dev {
 		};
 	} links[IEEE80211_MLD_MAX_NUM_LINKS];
 	u16 valid_links;
+	bool critical_update;
 };
 
 static inline const u8 *wdev_address(struct wireless_dev *wdev)
@@ -8340,6 +8348,7 @@ void cfg80211_conn_failed(struct net_device *dev, const u8 *mac_addr,
  * @flags: flags, as defined in &enum nl80211_rxmgmt_flags
  * @rx_tstamp: Hardware timestamp of frame RX in nanoseconds
  * @ack_tstamp: Hardware timestamp of ack TX in nanoseconds
+ * @critical_update: critical params updated for the received frame
  */
 struct cfg80211_rx_info {
 	int freq;
@@ -8351,6 +8360,7 @@ struct cfg80211_rx_info {
 	u32 flags;
 	u64 rx_tstamp;
 	u64 ack_tstamp;
+	bool critical_update;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index f23ecbdd84a2..34a2608f2051 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2856,6 +2856,15 @@ enum nl80211_commands {
  *	%NL80211_CMD_ASSOCIATE indicating the SPP A-MSDUs
  *	are used on this connection
  *
+ * @NL80211_ATTR_RXMGMT_CRITICAL_UPDATE: This is a nested attribute for driver
+ *	supporting critical update feature for AP MLD. When used with
+ *	%NL80211_CMD_FRAME it contains attribute defined in &enum nl80211_cu_attrs
+ *	to send critical update params for list of MLDs. Driver adds this attribute
+ *	only for probe, assoc and reassoc request frame. User-space can use these
+ *	params to update CU fields on corresponding response frame. This attribute
+ *	is needed only on beacon offload case and it is not needed on beacon
+ *	non-offload case since user space itself has these data.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3401,6 +3410,7 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_ASSOC_SPP_AMSDU,
 
+	NL80211_ATTR_RXMGMT_CRITICAL_UPDATE,
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -7987,4 +7997,92 @@ enum nl80211_ap_settings_flags {
 	NL80211_AP_SETTINGS_SA_QUERY_OFFLOAD_SUPPORT	= 1 << 1,
 };
 
+/*
+ * Critical update attribute length for a MLD list with two nested
+ * attributes. Each nla_nest_start() reserves four bytes.
+ */
+#define NL80211_CU_ATTR_MLDS_LEN	8
+
+/*
+ * Critical update attribute length for a particular MLD with two nested attributes.
+ * Each nla_nest_start() reserves four bytes and
+ * nla_put_u32(NL80211_CU_MLD_ATTR_IFINDEX) reserves eight bytes.
+ */
+
+#define NL80211_CU_ATTR_MLD_LEN		16
+
+/*
+ * Critical update attribute length for a particular link.
+ * Each nla_nest_start() reserves four bytes,
+ * nla_put_u8(NL80211_CU_MLD_LINK_ATTR_ID) reserves eight bytes,
+ * nla_put_flag(NL80211_CU_MLD_LINK_ATTR_CRITICAL_FLAG) reserves four bytes,
+ * nla_put_u8(NL80211_CU_MLD_LINK_ATTR_BPCC) reserves eight bytes and
+ * nla_put_u8(NL80211_CU_MLD_LINK_ATTR_SWITCH_COUNT) reserves eight bytes,
+ */
+#define NL80211_CU_ATTR_LINK_LEN	32
+
+/**
+ * nl80211_cu_attrs - critical update attributes
+ *
+ *
+ * @__NL80211_CU_ATTR_INVALID: invalid
+ * @NL80211_CU_ATTR_MLDS: nested attribute specifying list of MLDs,
+ * see &enum nl80211_cu_mld_attrs
+ * @__NL80211_CU_ATTR_LAST: internal use
+ * @NL80211_CU_ATTR_MAX: maximum critical update attribute
+ */
+enum nl80211_cu_attrs {
+	__NL80211_CU_ATTR_INVALID,
+
+	NL80211_CU_ATTR_MLDS,
+
+	/* keep last */
+	__NL80211_CU_ATTR_LAST,
+	NL80211_CU_ATTR_MAX = __NL80211_CU_ATTR_LAST - 1
+};
+
+/**
+ * nl80211_cu_mld_attrs - per mld critical update attributes
+ *
+ * @__NL80211_CU_MLD_ATTR_INVALID: invalid
+ * @NL80211_CU_MLD_ATTR_IFINDEX: network interface index (u32)
+ * @NL80211_CU_MLD_ATTR_LINKS: nested attribute specifying list of links
+ * on each mld, see &enum nl80211_cu_mld_link_attrs
+ * @__NL80211_CU_MLD_ATTR_LAST: internal use
+ * @NL80211_CU_MLD_ATTR_MAX: maximum per mld critical update attribute
+ */
+enum nl80211_cu_mld_attrs {
+	__NL80211_CU_MLD_ATTR_INVALID,
+
+	NL80211_CU_MLD_ATTR_IFINDEX,
+	NL80211_CU_MLD_ATTR_LINKS,
+
+	/* keep last */
+	__NL80211_CU_MLD_ATTR_LAST,
+	NL80211_CU_MLD_ATTR_MAX = __NL80211_CU_MLD_ATTR_LAST - 1
+};
+
+/**
+ * nl80211_cu_mld_link_attrs - per link critical update attributes
+ *
+ * @__NL80211_CU_MLD_LINK_ATTR_INVALID: invalid
+ * @NL80211_CU_MLD_LINK_ATTR_ID: link ID (u8) for the AP MLD
+ * @NL80211_CU_MLD_LINK_ATTR_CRITICAL_FLAG: critical update flag for the link
+ * @NL80211_CU_MLD_LINK_ATTR_BPCC: BSS parameter change count (u8) for the link
+ * @NL80211_CU_MLD_LINK_ATTR_SWITCH_COUNT: CSA / BCCA switch count (u8) for the link
+ * @__NL80211_CU_MLD_LINK_ATTR_LAST: internal use
+ * @NL80211_CU_MLD_LINK ATTR_MAX: maximum per link critical update attribute
+ */
+enum nl80211_cu_mld_link_attrs {
+	__NL80211_CU_MLD_LINK_ATTR_INVALID,
+
+	NL80211_CU_MLD_LINK_ATTR_ID,
+	NL80211_CU_MLD_LINK_ATTR_CRITICAL_FLAG,
+	NL80211_CU_MLD_LINK_ATTR_BPCC,
+	NL80211_CU_MLD_LINK_ATTR_SWITCH_COUNT,
+
+	/* keep last */
+	__NL80211_CU_MLD_LINK_ATTR_LAST,
+	NL80211_CU_MLD_LINK_ATTR_MAX = __NL80211_CU_MLD_LINK_ATTR_LAST - 1
+};
 #endif /* __LINUX_NL80211_H */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index b4edba6b0b7b..81fae4b51847 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -468,6 +468,25 @@ static const struct netlink_range_validation nl80211_punct_bitmap_range = {
 	.max = 0xffff,
 };
 
+static const struct nla_policy
+link_policy[NL80211_CU_MLD_LINK_ATTR_MAX + 1] = {
+	[NL80211_CU_MLD_LINK_ATTR_ID] = { .type = NLA_U8 },
+	[NL80211_CU_MLD_LINK_ATTR_CRITICAL_FLAG] = { .type = NLA_FLAG },
+	[NL80211_CU_MLD_LINK_ATTR_BPCC] = { .type = NLA_U8 },
+	[NL80211_CU_MLD_LINK_ATTR_SWITCH_COUNT] = { .type = NLA_U8 },
+};
+
+static const struct nla_policy
+mld_policy[NL80211_CU_MLD_ATTR_MAX + 1] = {
+	[NL80211_CU_MLD_ATTR_IFINDEX] = { .type = NLA_U32 },
+	[NL80211_CU_MLD_ATTR_LINKS] = NLA_POLICY_NESTED(link_policy),
+};
+
+static const struct nla_policy
+cu_policy[NL80211_CU_ATTR_MAX + 1] = {
+	[NL80211_CU_ATTR_MLDS] = NLA_POLICY_NESTED(mld_policy),
+};
+
 static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[0] = { .strict_start_type = NL80211_ATTR_HE_OBSS_PD },
 	[NL80211_ATTR_WIPHY] = { .type = NLA_U32 },
@@ -826,6 +845,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_MLO_TTLM_DLINK] = NLA_POLICY_EXACT_LEN(sizeof(u16) * 8),
 	[NL80211_ATTR_MLO_TTLM_ULINK] = NLA_POLICY_EXACT_LEN(sizeof(u16) * 8),
 	[NL80211_ATTR_ASSOC_SPP_AMSDU] = { .type = NLA_FLAG },
+	[NL80211_ATTR_RXMGMT_CRITICAL_UPDATE] = NLA_POLICY_NESTED(cu_policy),
 };
 
 /* policy for the key attributes */
@@ -18843,6 +18863,91 @@ bool cfg80211_rx_unexpected_4addr_frame(struct net_device *dev,
 }
 EXPORT_SYMBOL(cfg80211_rx_unexpected_4addr_frame);
 
+static int nl80211_send_mgmt_critical_update_len(struct wireless_dev *wdev)
+{
+	struct wiphy *wiphy = wdev->wiphy;
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
+	struct wireless_dev *tmp_wdev;
+	int link_id;
+	int cu_len = 0;
+
+	cu_len += NL80211_CU_ATTR_MLDS_LEN;
+	list_for_each_entry(tmp_wdev, &rdev->wiphy.wdev_list, list) {
+		cu_len += NL80211_CU_ATTR_MLD_LEN;
+		for_each_valid_link(tmp_wdev, link_id) {
+			cu_len += NL80211_CU_ATTR_LINK_LEN;
+		}
+	}
+	return cu_len;
+}
+
+/* Add critical update attribute when sending management frame
+ * to user space.
+ */
+static int nl80211_send_mgmt_critical_update(struct sk_buff *msg,
+					     struct wireless_dev *wdev)
+{
+	struct wiphy *wiphy = wdev->wiphy;
+	struct wireless_dev *tmp_wdev;
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
+	struct nlattr *critical_update;
+	struct nlattr *mld_list, *mld;
+	struct nlattr *link_list, *link;
+	struct net_device *tmp_netdev;
+	int link_id;
+	int i = 0, j = 0;
+
+	critical_update = nla_nest_start(msg, NL80211_ATTR_RXMGMT_CRITICAL_UPDATE);
+	if (!critical_update)
+		return -ENOBUFS;
+
+	mld_list = nla_nest_start(msg, NL80211_CU_ATTR_MLDS);
+	if (!mld_list)
+		return -ENOBUFS;
+
+	list_for_each_entry(tmp_wdev, &rdev->wiphy.wdev_list, list) {
+		if (!tmp_wdev->valid_links)
+			continue;
+		if (!tmp_wdev->critical_update)
+			continue;
+		mld = nla_nest_start(msg, i + 1);
+		if (!mld)
+			return -ENOBUFS;
+		tmp_netdev = tmp_wdev->netdev;
+		if (tmp_netdev &&
+		    nla_put_u32(msg, NL80211_CU_MLD_ATTR_IFINDEX, tmp_netdev->ifindex))
+			return -ENOBUFS;
+		link_list = nla_nest_start(msg, NL80211_CU_MLD_ATTR_LINKS);
+		if (!link_list)
+			return -ENOBUFS;
+
+		for_each_valid_link(tmp_wdev, link_id) {
+			link = nla_nest_start(msg, j + 1);
+			if (!link)
+				return -ENOBUFS;
+			if (nla_put_u8(msg, NL80211_CU_MLD_LINK_ATTR_ID, link_id))
+				return -ENOBUFS;
+			if (tmp_wdev->links[link_id].ap.critical_flag &&
+			    nla_put_flag(msg, NL80211_CU_MLD_LINK_ATTR_CRITICAL_FLAG))
+				return -ENOBUFS;
+			if (nla_put_u8(msg, NL80211_CU_MLD_LINK_ATTR_BPCC,
+				       tmp_wdev->links[link_id].ap.bpcc))
+				return -ENOBUFS;
+			if (nla_put_u8(msg, NL80211_CU_MLD_LINK_ATTR_SWITCH_COUNT,
+				       tmp_wdev->links[link_id].ap.switch_count))
+				return -ENOBUFS;
+			nla_nest_end(msg, link);
+			j++;
+		}
+		nla_nest_end(msg, link_list);
+		nla_nest_end(msg, mld);
+		i++;
+	}
+	nla_nest_end(msg, mld_list);
+	nla_nest_end(msg, critical_update);
+	return 0;
+}
+
 int nl80211_send_mgmt(struct cfg80211_registered_device *rdev,
 		      struct wireless_dev *wdev, u32 nlportid,
 		      struct cfg80211_rx_info *info, gfp_t gfp)
@@ -18850,8 +18955,12 @@ int nl80211_send_mgmt(struct cfg80211_registered_device *rdev,
 	struct net_device *netdev = wdev->netdev;
 	struct sk_buff *msg;
 	void *hdr;
+	int cu_len = 0;
 
-	msg = nlmsg_new(100 + info->len, gfp);
+	if (info->critical_update)
+		cu_len = nl80211_send_mgmt_critical_update_len(wdev);
+
+	msg = nlmsg_new(100 + info->len + cu_len, gfp);
 	if (!msg)
 		return -ENOMEM;
 
@@ -18885,6 +18994,12 @@ int nl80211_send_mgmt(struct cfg80211_registered_device *rdev,
 						   NL80211_ATTR_PAD)))
 		goto nla_put_failure;
 
+	if (info->critical_update) {
+		if (nl80211_send_mgmt_critical_update(msg, wdev))
+			goto nla_put_failure;
+		/* Reset the flag after adding the critical update attribute*/
+		wdev->critical_update = false;
+	}
 	genlmsg_end(msg, hdr);
 
 	return genlmsg_unicast(wiphy_net(&rdev->wiphy), msg, nlportid);
-- 
2.34.1


