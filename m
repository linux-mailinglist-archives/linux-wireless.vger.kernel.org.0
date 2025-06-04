Return-Path: <linux-wireless+bounces-23699-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6409ACDC3A
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 12:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12095177F70
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 10:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C86728C030;
	Wed,  4 Jun 2025 10:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RzpPHbkB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8231628E5E5
	for <linux-wireless@vger.kernel.org>; Wed,  4 Jun 2025 10:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749034703; cv=none; b=WFNbggwn365mzoeUYUn+eP+BGsbOzOui4bN2akgZSUev+3jku88+xAKxk5eVYglv4HCki2Q32FX0Vlo7eh/VtJ8+jqHiYpjLMQC7cB1vg4nzlhd9RfyTnWrVW4kZ3bEg8S5cpo9NNzT6gpWr/QzovqMSfw5DR9Y+n7XAiqKxoiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749034703; c=relaxed/simple;
	bh=tawDryNW4chXshEqYeSdnI+LjVipstMJKqOm5aJnXgA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z8Rj5cB0tLfbBrnhreRSqY3WMnBJc/nSMB5A2X3nOGqud6Rc2WxPDxzc0XpiGoeFKu2MLTmN8qZpQl4Qr73PFjw65sPTahWhqlA1c+AC2yS157fFDCnnycdpaNgybagWhW54XIaxF1VQNtNLHM4oRJB/QXA17rinSvWOsdN+do4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RzpPHbkB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554A9Wfv011697;
	Wed, 4 Jun 2025 10:58:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=VAZXOsJvfiNWY80tNxnqsHQI
	/GBHfBVEeY7xBDPQvWo=; b=RzpPHbkBQUZjtgdjQcmpv2Arp0G3Cnl/3Vgj4eNH
	FfaFXK1n8Z6GG01P4BzHJD1pH9hw4oxp36/yltjTzcBnyMMF5uITqigiWkGz4m3D
	GOUWYnomToAunAJ0t7SHqmxaBZOHJqzYKG9WIAdPlTtSql8dpJNUggiwmGS3Fs17
	GCnfDR1mcjs+IHbD8gz4J0R/9KT/qN5zK/oH4/SNqAXwqYbD5lXsObQNf41vdQR/
	nM15HHew4JQvArYs3lUVjT1epQoaf6+DweJGrdvEcfMJGPQCFKxVqpFFm0KNNyrM
	V9T/NGKvlx6cy+DOh+EB55rPhM5n3rtRyj2wv47E06hSDw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47202wbe72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 10:58:17 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 554AwGf4002802
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Jun 2025 10:58:16 GMT
Received: from hu-kkavita-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 4 Jun 2025 03:58:14 -0700
From: Kavita Kavita <quic_kkavita@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <quic_kkavita@quicinc.com>
Subject: [PATCH wireless-next 2/2] wifi: cfg80211: Add support for link reconfiguration negotiation offload to driver
Date: Wed, 4 Jun 2025 16:27:57 +0530
Message-ID: <20250604105757.2542-3-quic_kkavita@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250604105757.2542-1-quic_kkavita@quicinc.com>
References: <20250604105757.2542-1-quic_kkavita@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BDQ5_LStSARVm2gx7vZ_s4egPLxR10Sl
X-Proofpoint-GUID: BDQ5_LStSARVm2gx7vZ_s4egPLxR10Sl
X-Authority-Analysis: v=2.4 cv=Y/D4sgeN c=1 sm=1 tr=0 ts=684026c9 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=eDliLIXKMzjFlwTbL1sA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDA4MyBTYWx0ZWRfX8yQwI/MoQJvR
 jYATVthLQ5QW7u6T2COi+gK4aVPkwh68PvpN9in4HWkiOTFJXFfc8Yc8o5tG/l4szMJj/o/3n4H
 RLE4PAcsmnmxp8A3Neu/qjQqB3CdIlKrJV6u09A7t+ONPLEMyF/QMmfruRMhg57aKEfUhZGMtnA
 bbGkqp9k+NUJcEvA7yFLChIDurz2YDwTRwRxWiVtP9TUNgEkLwX39M4ADEVszvJ3h/6RhjrQX/b
 z6vo699BYnwylP8XKdzwBiVOggN2TGmuj8XAdgc02KLBOZuZ1l0rzbhgruXHp1gjZmWiHNPmaN/
 +BSFlV0C/UURmEk06Zc0s3EtLxqtm31geRzBInRM0YGFN50KHWIcRUlqoOQZd8iwQjnJxont6Je
 H9WeAwlVlpV1Iu6ZC7Lw/Y/FQ5WdCUSl1fcQ3VFkUw/LJa3zc7VUSsEuUBip4emXAkbDSrMw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_03,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506040083

In the case of SME-in-driver, the driver can internally choose to
update the links based on the AP MLD recommendation and do link
reconfiguration negotiation with AP MLD.
(e.g., After the driver processing the BSS Transition Management request
frame received from the AP MLD with Neighbor Report containing
Multi-Link element with recommended links information chooses to do link
reconfiguration negotiation with AP MLD).

To support this, extend cfg80211_mlo_reconf_add_done() and
NL80211_CMD_ASSOC_MLO_RECONF to indicate added links information for
driver-initiated link reconfiguration requests. For removed links,
the driver indicates links information using the
NL80211_CMD_LINKS_REMOVED event for driver-initiated cases, the same as
supplicant initiated cases.

For the driver-initiated case, cfg80211 will receive link
reconfiguration result asynchronously from driver so holding BSSes of
the accepted add links is needed in the event path. Also, no need of
unhold call for the rejected add link BSSes since there was no hold call
happened previously.

Once the supplicant receives the NL80211_CMD_ASSOC_MLO_RECONF event,
it needs to process the information about newly added links and install
per-link group keys (e.g., GTK/IGTK/BIGTK etc.).

In case of the SME-in-driver, using a vendor interface etc. to notify
the supplicant to initiate a link reconfiguration request and then
supplicant sending command to the cfg80211 can lead to race conditions.
The correct design to avoid this is that the driver indicates the
cfg80211 directly with the results of the link reconfiguration
negotiation.

Signed-off-by: Kavita Kavita <quic_kkavita@quicinc.com>
---
 include/net/cfg80211.h       |  6 ++++++
 include/uapi/linux/nl80211.h |  6 +++++-
 net/wireless/mlme.c          | 10 ++++++++--
 net/wireless/trace.h         | 10 ++++++----
 4 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index d1848dc8ec99..d5d0c3376db8 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -9736,6 +9736,11 @@ void cfg80211_links_removed(struct net_device *dev, u16 link_mask);
  * struct cfg80211_mlo_reconf_done_data - MLO reconfiguration data
  * @buf: MLO Reconfiguration Response frame (header + body)
  * @len: length of the frame data
+ * @driver_initiated: Indicates whether the add links request is initiated by
+ *	driver. This is set to true when the link reconfiguration request
+ *	initiated by driver due to AP link recommendation requests
+ *	(Ex: BTM (BSS Transition Management) request) handling offloaded to
+ *	driver.
  * @added_links: BIT mask of links successfully added to the association
  * @links: per-link information indexed by link ID
  * @links.bss: the BSS that MLO reconfiguration was requested for, ownership of
@@ -9748,6 +9753,7 @@ void cfg80211_links_removed(struct net_device *dev, u16 link_mask);
 struct cfg80211_mlo_reconf_done_data {
 	const u8 *buf;
 	size_t len;
+	bool driver_initiated;
 	u16 added_links;
 	struct {
 		struct cfg80211_bss *bss;
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index e53840d009d1..a289014abe37 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1334,7 +1334,11 @@
  *      reconfiguration request results from the driver, this command is also
  *      used as an event to notify userspace about the added links information.
  *      For notifying the removed links information, the existing
- *      %NL80211_CMD_LINKS_REMOVED command is used.
+ *      %NL80211_CMD_LINKS_REMOVED command is used. This command is also used to
+ *      notify userspace about newly added links for the current connection in
+ *      case of AP-initiated link recommendation requests, received via
+ *      a BTM (BSS Transition Management) request or a link reconfig notify
+ *      frame, where the driver handles the link recommendation offload.
  *
  * @NL80211_CMD_EPCS_CFG: EPCS configuration for a station. Used by userland to
  *	control EPCS configuration. Used to notify userland on the current state
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 05d44a443518..29e1ce8aff42 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -1331,7 +1331,8 @@ void cfg80211_mlo_reconf_add_done(struct net_device *dev,
 	lockdep_assert_wiphy(wiphy);
 
 	trace_cfg80211_mlo_reconf_add_done(dev, data->added_links,
-					   data->buf, data->len);
+					   data->buf, data->len,
+					   data->driver_initiated);
 
 	if (WARN_ON(!wdev->valid_links))
 		return;
@@ -1361,11 +1362,16 @@ void cfg80211_mlo_reconf_add_done(struct net_device *dev,
 			wdev->links[link_id].client.current_bss =
 				bss_from_pub(bss);
 
+			if (data->driver_initiated)
+				cfg80211_hold_bss(bss_from_pub(bss));
+
 			memcpy(wdev->links[link_id].addr,
 			       data->links[link_id].addr,
 			       ETH_ALEN);
 		} else {
-			cfg80211_unhold_bss(bss_from_pub(bss));
+			if (!data->driver_initiated)
+				cfg80211_unhold_bss(bss_from_pub(bss));
+
 			cfg80211_put_bss(wiphy, bss);
 		}
 	}
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 4ed9fada4ec0..61a5eca9c513 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -4126,20 +4126,22 @@ TRACE_EVENT(cfg80211_links_removed,
 
 TRACE_EVENT(cfg80211_mlo_reconf_add_done,
 	TP_PROTO(struct net_device *netdev, u16 link_mask,
-		 const u8 *buf, size_t len),
-	TP_ARGS(netdev, link_mask, buf, len),
+		 const u8 *buf, size_t len, bool driver_initiated),
+	TP_ARGS(netdev, link_mask, buf, len, driver_initiated),
 	TP_STRUCT__entry(
 		NETDEV_ENTRY
 		__field(u16, link_mask)
 		__dynamic_array(u8, buf, len)
+		__field(bool, driver_initiated)
 	),
 	TP_fast_assign(
 		NETDEV_ASSIGN;
 		__entry->link_mask = link_mask;
 		memcpy(__get_dynamic_array(buf), buf, len);
+		__entry->driver_initiated = driver_initiated;
 	),
-	TP_printk(NETDEV_PR_FMT ", link_mask:0x%x",
-		  NETDEV_PR_ARG, __entry->link_mask)
+	TP_printk(NETDEV_PR_FMT ", link_mask:0x%x, driver_initiated:%d",
+		  NETDEV_PR_ARG, __entry->link_mask, __entry->driver_initiated)
 );
 
 TRACE_EVENT(rdev_assoc_ml_reconf,
-- 
2.17.1


