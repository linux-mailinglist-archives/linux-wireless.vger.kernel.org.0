Return-Path: <linux-wireless+bounces-3135-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C70A849F79
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 17:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8688B1F23273
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 16:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8921328DD1;
	Mon,  5 Feb 2024 16:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iUmgMVCr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F672EB08
	for <linux-wireless@vger.kernel.org>; Mon,  5 Feb 2024 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707150618; cv=none; b=BNcn/vvwco3o8SJAatw5oruzrzKLUQfJBineGpAuY2IMfC0cKWfQDyDNn4w5KlDyzsx//qiAlQDJbQavQNIVJ0fgfL/eN/hcVzIEjEtEdI19SP/g+ZYI3OcG6huO2dvw00GFDvfaNQr3TwapWws4ZdfqoSWnUhjpqY3MHqm7LDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707150618; c=relaxed/simple;
	bh=mwJwIzazg4AbCLeZLhiOMwS4NiEcsiuusoZu8XjjIL4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CWNZKQqFOXfxatRzMnmpHS2r0bNmA5j3nVbOZwwVNFZQoSXMWUDfSeyHHGTCMy6+QZAtZaA1ejp8VidaSyiJbCP47OaRYkmxEAZfYJCmlQ3KgYb0lhsXeTcb7bkt+IulaugYKIAQLZMgZgAYF4+gk1UnQL049i/ZaAnDm+9836A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iUmgMVCr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 415FVe9K023117;
	Mon, 5 Feb 2024 16:30:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=aevTwimk3CtTG3JpWKWwEfCm4GBX5NbnurOrZUlw98Y=; b=iU
	mgMVCr19e9V86G0bsBi1JaEQva47aZuvEb8ES8PRzD3x66OEWTo1xhkbeNd1aVap
	RPqIlodrIC6SqSW1QJDsJTSqb9Wn5XuLuLi4J60fGTrf1L9HBpMBTne1cnIQ+9xl
	3Uh4K3Natf8lLuUQo/4L5vSacPgE3q6f3rTxbrGpfXCFMc9TEfZxFSfs3XITY9bL
	tzZ1dCk08ISmPvVvIRG4Qkn2xsh7xBjBcjMw+fvdYprmrxkiEMv0jTD/+3mNxCRS
	si3a5fFzKsR6LBLtwLvq96+/YGBOltsTIOChEf0ttKCNOdh8An+KCvnehB/U0doT
	01lgpW3EO4uk/olmysHg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w2rvj9cuu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 16:30:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 415GUC0l016394
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Feb 2024 16:30:12 GMT
Received: from cdcwlex322514-lin.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 08:30:10 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v2 1/3] wifi: cfg80211: add support for link id attribute in NL80211_CMD_DEL_STATION
Date: Mon, 5 Feb 2024 21:59:50 +0530
Message-ID: <20240205162952.1697646-2-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240205162952.1697646-1-quic_adisi@quicinc.com>
References: <20240205162952.1697646-1-quic_adisi@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SfQvl7wPVjsg7YJC9GvUrkIQ-j6O0Oa4
X-Proofpoint-GUID: SfQvl7wPVjsg7YJC9GvUrkIQ-j6O0Oa4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402050124

Currently whenever NL80211_CMD_DEL_STATION command is called without any
MAC address, all stations present on that interface are flushed.
However with MLO there is a need to flush such stations only which are
using at least a particular link from the AP MLD interface.

For example - 2 GHz and 5 GHz are part of an AP MLD.
To this interface, following stations are connected -
   1. One non-EHT STA on 2 GHz link.
   2. One non-EHT STA on 5 GHz link.
   3. One Multi-Link STA having 2 GHz and 5 GHz as active links.

Now if currently, NL80211_CMD_DEL_STATION is issued by the 2 GHz link
without any MAC address, it would flush all station entries. However,
flushing of station entry #2 at least is not desireable since it
is connected to 5 GHz link alone.

Hence, add an option to pass link ID as well in the command so that if link
ID is passed, stations using that passed link ID alone would be flushed
and others will not.

So after this, station entries #1 and #3 alone would be flushed and #2 will
remain as it is.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 include/net/cfg80211.h       |  3 +++
 include/uapi/linux/nl80211.h |  4 +++-
 net/wireless/nl80211.c       | 19 ++++++++++++++++++-
 net/wireless/trace.h         |  7 +++++--
 4 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 51b9e6fa12f8..ae2d5b48e634 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1766,11 +1766,14 @@ struct station_parameters {
  * @subtype: Management frame subtype to use for indicating removal
  *	(10 = Disassociation, 12 = Deauthentication)
  * @reason_code: Reason code for the Disassociation/Deauthentication frame
+ * @link_id: Link ID on which station should be connected at least in order
+ *	to delete its entry. Valid only during MLO.
  */
 struct station_del_parameters {
 	const u8 *mac;
 	u8 subtype;
 	u16 reason_code;
+	int link_id;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 853ac538a686..34406670fc4c 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -438,7 +438,9 @@
  *	%NL80211_ATTR_REASON_CODE can optionally be used to specify which type
  *	of disconnection indication should be sent to the station
  *	(Deauthentication or Disassociation frame and reason code for that
- *	frame).
+ *	frame). %NL80211_ATTR_MLO_LINK_ID can be used optionally to remove
+ *	stations connected and using at least that link as one of its
+ *	active links.
  *
  * @NL80211_CMD_GET_MPATH: Get mesh path attributes for mesh path to
  * 	destination %NL80211_ATTR_MAC on the interface identified by
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 68c20409eca6..15e9ca4e4d9e 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -7630,14 +7630,16 @@ static int nl80211_del_station(struct sk_buff *skb, struct genl_info *info)
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
@@ -7678,6 +7680,17 @@ static int nl80211_del_station(struct sk_buff *skb, struct genl_info *info)
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
 
@@ -16786,6 +16799,10 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_del_station,
 		.flags = GENL_UNS_ADMIN_PERM,
+		/* cannot use NL80211_FLAG_MLO_VALID_LINK_ID, depends on
+		 * whether MAC address is passed or not. If MAC address is
+		 * passed, then even during MLO, link ID is not required.
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


