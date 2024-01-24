Return-Path: <linux-wireless+bounces-2445-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE77E83AAEC
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jan 2024 14:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4784B28E2B
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jan 2024 13:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEE877F18;
	Wed, 24 Jan 2024 13:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Nrkz9BEw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2E377F0E
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jan 2024 13:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706102927; cv=none; b=t80Eciz34IY0lylpEsHCzrDLcGCs7sPzt7sF1oNwa2q0/FHmiHIgO5IXUtU71wLs5/EhZWE50hpq38qDDCgqW965RseejNSXxXMk+4jO+0GVDYy2RIk3DPXU7xZVxYpxaaZXbiFp+pQ9ikjYanRdRYNukkZddyrPwz+e66mU15g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706102927; c=relaxed/simple;
	bh=CX1Z8vyt8Dwp9d/arCAs2A95N1FqDmr00jUuaGvSHWw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SCOTUlpBOR3cSCg6//UC1M2uWTGkBnjeOjggyFefXAngzfZSisvX4j5EMyHpalsIE7tOJFWNNTFf0O5nD4258k3iprE5zSwk1xSR0XGQlaRJ1xJwOSDzKXWKPPfTc2Kg/MPnvPSPleiVXvsFKgNOtpU40rgYctU4S6eEw6lRi4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Nrkz9BEw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40OCYpN7012752;
	Wed, 24 Jan 2024 13:28:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=yY64m2zGyYpm4mZlHSNZnr4CUh3saOCQuSNayIdDn/c=; b=Nr
	kz9BEwghOwgAhxAkJBUXifIFuT/9S545HLjSAkyP2MVCd21ROcKslcLD5RyHwZmI
	KaG/AOjNhGCwLDrl/ZyyEKZL6peiDUqk1Ipr9av1/Ghzwk2hjgx+LB4Du8FBaqe5
	5gqQjM6Q9bZTplsYrlttwZ4/M0acc96UO0FtywpLTQKzKIRBs1QNovoMcs74y1vJ
	nFMNH+w/v//cqrGID3g0K/wPnOof0h3QG0LiC+YxZRKeXzvwZZ+yH70wVrjpDaeB
	WEhwrLXdSIACRl4Mc9c/gZiKh5ujuq7vfKZwTfer1dNudLMkbDgT8KLGPWiduTPy
	k69ZJ4SWr62tI3wdpYQA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vtmgxhtyw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 13:28:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40ODSeME009434
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 13:28:40 GMT
Received: from cdcwlex322514-lin.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 24 Jan 2024 05:28:38 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH 1/3] wifi: cfg80211: add support for link id attribute in NL80211_CMD_DEL_STATION
Date: Wed, 24 Jan 2024 18:58:12 +0530
Message-ID: <20240124132814.802018-2-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240124132814.802018-1-quic_adisi@quicinc.com>
References: <20240124132814.802018-1-quic_adisi@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uNBR2yo47QHyjNQlEOjja4qe0n_V5mfz
X-Proofpoint-GUID: uNBR2yo47QHyjNQlEOjja4qe0n_V5mfz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_06,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401240097

Currently whenever NL80211_CMD_DEL_STATION command is called without any
MAC address, all stations present on that interface are flushed.
However with MLO there is a need to flush the stations from a particular
link in the interface, and not from all the links associated with the MLD
interface.

For example - 2 GHz and 5 GHz are part of an AP MLD. When 2 GHz BSS is
brought up, it sends flush command on the interface (MLD). Then eventually
5 GHZ links comes up and that also sends the command on the same interface.
Now by the time 5 GHz link comes up, if any station gets connected to 2 GHz
link, it would be flushed while 5 GHz link is started which is wrong.

Hence, add an option to pass link ID as well in the command so that if link
ID is passed, station using that passed link ID alone would be deleted
and others will not be removed.

A subsequent patch would add logic to delete only the station using the
passed link ID.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 include/net/cfg80211.h       |  3 +++
 include/uapi/linux/nl80211.h |  3 ++-
 net/wireless/nl80211.c       | 18 +++++++++++++++++-
 net/wireless/trace.h         |  7 +++++--
 4 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index cf79656ce09c..2e194638717d 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1766,11 +1766,14 @@ struct station_parameters {
  * @subtype: Management frame subtype to use for indicating removal
  *	(10 = Disassociation, 12 = Deauthentication)
  * @reason_code: Reason code for the Disassociation/Deauthentication frame
+ * @link_id: Link ID on which station should be connected at least in order
+ *	     to delete its entry. Valid only during MLO.
  */
 struct station_del_parameters {
 	const u8 *mac;
 	u8 subtype;
 	u16 reason_code;
+	int link_id;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 1ccdcae24372..4197d7097591 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -438,7 +438,8 @@
  *	%NL80211_ATTR_REASON_CODE can optionally be used to specify which type
  *	of disconnection indication should be sent to the station
  *	(Deauthentication or Disassociation frame and reason code for that
- *	frame).
+ *	frame). %NL80211_ATTR_MLO_LINK_ID can be used optionally to remove
+ *	stations connected and using at least that link.
  *
  * @NL80211_CMD_GET_MPATH: Get mesh path attributes for mesh path to
  * 	destination %NL80211_ATTR_MAC on the interface identified by
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 60877b532993..a99537828978 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -7627,14 +7627,16 @@ static int nl80211_del_station(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	struct net_device *dev = info->user_ptr[1];
+	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct station_del_parameters params;
+	int link_id = nl80211_link_id_or_invalid(info->attrs);
 
 	memset(&params, 0, sizeof(params));
 
 	if (info->attrs[NL80211_ATTR_MAC])
 		params.mac = nla_data(info->attrs[NL80211_ATTR_MAC]);
 
-	switch (dev->ieee80211_ptr->iftype) {
+	switch (wdev->iftype) {
 	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_AP_VLAN:
 	case NL80211_IFTYPE_MESH_POINT:
@@ -7675,6 +7677,17 @@ static int nl80211_del_station(struct sk_buff *skb, struct genl_info *info)
 		params.reason_code = WLAN_REASON_PREV_AUTH_NOT_VALID;
 	}
 
+	/* Link ID not expected in case of non-ML operation */
+	if (!wdev->valid_links && link_id != -1)
+		return -EINVAL;
+
+	/* If given, a valid link ID should be passed during MLO */
+	if (wdev->valid_links && link_id >= 0 &&
+	    !(wdev->valid_links & BIT(link_id)))
+		return -EINVAL;
+
+	params.link_id = link_id;
+
 	return rdev_del_station(rdev, dev, &params);
 }
 
@@ -16827,6 +16840,9 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_del_station,
 		.flags = GENL_UNS_ADMIN_PERM,
+		/* cannot use NL80211_FLAG_MLO_VALID_LINK_ID, depends on
+		 * MAC address
+		 */
 		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
 	{
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 1f374c8a17a5..838107186b91 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -859,6 +859,7 @@ DECLARE_EVENT_CLASS(station_del,
 		MAC_ENTRY(sta_mac)
 		__field(u8, subtype)
 		__field(u16, reason_code)
+		__field(int, link_id)
 	),
 	TP_fast_assign(
 		WIPHY_ASSIGN;
@@ -866,11 +867,13 @@ DECLARE_EVENT_CLASS(station_del,
 		MAC_ASSIGN(sta_mac, params->mac);
 		__entry->subtype = params->subtype;
 		__entry->reason_code = params->reason_code;
+		__entry->link_id = params->link_id;
 	),
 	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", station mac: %pM"
-		  ", subtype: %u, reason_code: %u",
+		  ", subtype: %u, reason_code: %u, link_id: %d",
 		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->sta_mac,
-		  __entry->subtype, __entry->reason_code)
+		  __entry->subtype, __entry->reason_code,
+		  __entry->link_id)
 );
 
 DEFINE_EVENT(station_del, rdev_del_station,
-- 
2.25.1


