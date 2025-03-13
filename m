Return-Path: <linux-wireless+bounces-20291-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D869A5E99A
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 03:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFBB0176522
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 02:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44BE1C683;
	Thu, 13 Mar 2025 02:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KAbMdxxT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4EC23B0
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 02:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741831369; cv=none; b=RPWjEoMl6awtqP/XFKB9TOeAqyIIglrRTVWxamI+eLFrzzYyBWk6duvopNYXX7wgfJCh9RKJHivQOj/v9Ki5G+xnuSrnCU5QO/p/qq+3wMJVwCORB9+xx714+LunaNpvHeynDoPEFaXEOUnWdBPFHL+pD975w4YDsHozU5cINl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741831369; c=relaxed/simple;
	bh=7okmEkvnJf4VDdnH0TiNeKUL4Xh+47WcDoxzien8fKU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r8yOZjCSen48l1l2RkQL3FAk1UDXHcQYSsoupoPiKyHKLSCkAe3vFN3ORNokaefLJAcpohdfbBSQCmiyD9qG3IU5sqWn4YnFAdpUIKgDqkjhyZDZOnZw6mDr/f4CQpnWSR6oM6MmbE0EH9yrP2dF2LUyjQeLKfVHNDC4KqC6KFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KAbMdxxT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52CMrGFC016250;
	Thu, 13 Mar 2025 02:02:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=rc0f83kQsYz7e3G8gbjLmRZu
	SsrksORj29hQ08Fl5vE=; b=KAbMdxxTx4GeSwKG1WTx1zMSTe7c9Lu8Sy5es1fL
	aNfXMk/VVd3zf4VbP21UaT+usH1u2F6/GVdk1kBTJgLdREXrosgMVNVweo93g6Bm
	pUkcZ+VabNNOrdC7hjR4OGnlOQE0ZUDck7lofYbWCj7uxX8r+la9GCvCdTZhS3ln
	pYcnpv057a+ZN5yZeYmxwCun2h8trxxmC9X/uuLYuPueEbimsLUdwfdBd/TMKkse
	gcspqv0/vFG9mOsNOGI81Itbccn3NVImt611M+vy5yFwC5q2iZCASQ88nmzCS6oV
	+jxGgpGfd/cNJ1y2u5XcRdtvJo3lvdzCQd4PwS8wCkby2Q==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2nv7rt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 02:02:42 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52D22gND010298
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 02:02:42 GMT
Received: from hu-nithp-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 12 Mar 2025 19:02:40 -0700
From: Nithyanantham Paramasivam <quic_nithp@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Nithyanantham Paramasivam
	<quic_nithp@quicinc.com>
Subject: [PATCH wireless-next v2 1/2] wifi: cfg80211: Allow monitor creation in NO_VIRTUAL_MONITOR mode with active AP
Date: Thu, 13 Mar 2025 07:31:53 +0530
Message-ID: <20250313020154.4066212-2-quic_nithp@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250313020154.4066212-1-quic_nithp@quicinc.com>
References: <20250313020154.4066212-1-quic_nithp@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BQjU6U1_PDWR5tk-HTcNRr3sN2iTNc5f
X-Authority-Analysis: v=2.4 cv=ZObXmW7b c=1 sm=1 tr=0 ts=67d23cc2 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=4AGc7K47HeZWFpGZGNcA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: BQjU6U1_PDWR5tk-HTcNRr3sN2iTNc5f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_01,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503130015

Currently, in NO_VIRTUAL_MONITOR mode, when creating an
AP/STA + monitor, there is a restriction: if the AP/STA is running,
setting the channel for the monitor is not allowed. For example,
in a scenario with three supported radios where the AP uses only the
2 GHz and 5 GHz bands, the 6 GHz band remains available. However,
due to the restriction that rdev->num_running_ifaces must equal
rdev->num_running_monitor_ifaces in cfg80211_has_monitors_only(),
we are unable to create the monitor interface.

cfg80211_set_monitor_channel -> cfg80211_has_monitors_only()

static inline bool cfg80211_has_monitors_only() {
...
   return rdev->num_running_ifaces == rdev->num_running_monitor_ifaces
        && rdev->num_running_ifaces > 0;
}

To address this, introduce the new
WIPHY_FLAG_SUPPORTS_CONCUR_MONITOR_N_OTHER_VIF
flag to advertise concurrent support for monitor mode alongside AP/STA
interfaces in cfg80211. This flag will enable the creation of
a monitor interface by bypassing the cfg80211_has_monitors_only()
function. In the mac80211 layer, no additional changes are required.
It follows the same sequence as standalone monitor creation in
NO_VIRTUAL_MONITOR mode.

Signed-off-by: Nithyanantham Paramasivam <quic_nithp@quicinc.com>
---
 include/net/cfg80211.h | 55 ++++++++++++++++++++++--------------------
 net/wireless/chan.c    |  4 ++-
 2 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 6b170a8d086c..b85020ad329a 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5037,34 +5037,37 @@ struct cfg80211_ops {
  * @WIPHY_FLAG_SUPPORTS_NSTR_NONPRIMARY: support connection to non-primary link
  *	of an NSTR mobile AP MLD.
  * @WIPHY_FLAG_DISABLE_WEXT: disable wireless extensions for this device
+ * @WIPHY_FLAG_SUPPORTS_CONCUR_MONITOR_N_OTHER_VIF: Flag to advertise concurrent
+ *	support for monitor mode alongside AP/STA
  */
 enum wiphy_flags {
-	WIPHY_FLAG_SUPPORTS_EXT_KEK_KCK		= BIT(0),
-	WIPHY_FLAG_SUPPORTS_MLO			= BIT(1),
-	WIPHY_FLAG_SPLIT_SCAN_6GHZ		= BIT(2),
-	WIPHY_FLAG_NETNS_OK			= BIT(3),
-	WIPHY_FLAG_PS_ON_BY_DEFAULT		= BIT(4),
-	WIPHY_FLAG_4ADDR_AP			= BIT(5),
-	WIPHY_FLAG_4ADDR_STATION		= BIT(6),
-	WIPHY_FLAG_CONTROL_PORT_PROTOCOL	= BIT(7),
-	WIPHY_FLAG_IBSS_RSN			= BIT(8),
-	WIPHY_FLAG_DISABLE_WEXT			= BIT(9),
-	WIPHY_FLAG_MESH_AUTH			= BIT(10),
-	WIPHY_FLAG_SUPPORTS_EXT_KCK_32          = BIT(11),
-	WIPHY_FLAG_SUPPORTS_NSTR_NONPRIMARY	= BIT(12),
-	WIPHY_FLAG_SUPPORTS_FW_ROAM		= BIT(13),
-	WIPHY_FLAG_AP_UAPSD			= BIT(14),
-	WIPHY_FLAG_SUPPORTS_TDLS		= BIT(15),
-	WIPHY_FLAG_TDLS_EXTERNAL_SETUP		= BIT(16),
-	WIPHY_FLAG_HAVE_AP_SME			= BIT(17),
-	WIPHY_FLAG_REPORTS_OBSS			= BIT(18),
-	WIPHY_FLAG_AP_PROBE_RESP_OFFLOAD	= BIT(19),
-	WIPHY_FLAG_OFFCHAN_TX			= BIT(20),
-	WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL	= BIT(21),
-	WIPHY_FLAG_SUPPORTS_5_10_MHZ		= BIT(22),
-	WIPHY_FLAG_HAS_CHANNEL_SWITCH		= BIT(23),
-	WIPHY_FLAG_NOTIFY_REGDOM_BY_DRIVER	= BIT(24),
-	WIPHY_FLAG_CHANNEL_CHANGE_ON_BEACON     = BIT(25),
+	WIPHY_FLAG_SUPPORTS_EXT_KEK_KCK			= BIT(0),
+	WIPHY_FLAG_SUPPORTS_MLO				= BIT(1),
+	WIPHY_FLAG_SPLIT_SCAN_6GHZ			= BIT(2),
+	WIPHY_FLAG_NETNS_OK				= BIT(3),
+	WIPHY_FLAG_PS_ON_BY_DEFAULT			= BIT(4),
+	WIPHY_FLAG_4ADDR_AP				= BIT(5),
+	WIPHY_FLAG_4ADDR_STATION			= BIT(6),
+	WIPHY_FLAG_CONTROL_PORT_PROTOCOL		= BIT(7),
+	WIPHY_FLAG_IBSS_RSN				= BIT(8),
+	WIPHY_FLAG_DISABLE_WEXT				= BIT(9),
+	WIPHY_FLAG_MESH_AUTH				= BIT(10),
+	WIPHY_FLAG_SUPPORTS_EXT_KCK_32			= BIT(11),
+	WIPHY_FLAG_SUPPORTS_NSTR_NONPRIMARY		= BIT(12),
+	WIPHY_FLAG_SUPPORTS_FW_ROAM			= BIT(13),
+	WIPHY_FLAG_AP_UAPSD				= BIT(14),
+	WIPHY_FLAG_SUPPORTS_TDLS			= BIT(15),
+	WIPHY_FLAG_TDLS_EXTERNAL_SETUP			= BIT(16),
+	WIPHY_FLAG_HAVE_AP_SME				= BIT(17),
+	WIPHY_FLAG_REPORTS_OBSS				= BIT(18),
+	WIPHY_FLAG_AP_PROBE_RESP_OFFLOAD		= BIT(19),
+	WIPHY_FLAG_OFFCHAN_TX				= BIT(20),
+	WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL		= BIT(21),
+	WIPHY_FLAG_SUPPORTS_5_10_MHZ			= BIT(22),
+	WIPHY_FLAG_HAS_CHANNEL_SWITCH			= BIT(23),
+	WIPHY_FLAG_NOTIFY_REGDOM_BY_DRIVER		= BIT(24),
+	WIPHY_FLAG_CHANNEL_CHANGE_ON_BEACON		= BIT(25),
+	WIPHY_FLAG_SUPPORTS_CONCUR_MONITOR_N_OTHER_VIF	= BIT(26),
 };
 
 /**
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 9f918b77b40e..29715d492944 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -1509,7 +1509,9 @@ int cfg80211_set_monitor_channel(struct cfg80211_registered_device *rdev,
 {
 	if (!rdev->ops->set_monitor_channel)
 		return -EOPNOTSUPP;
-	if (!cfg80211_has_monitors_only(rdev))
+	if (!(rdev->wiphy.flags &
+	      WIPHY_FLAG_SUPPORTS_CONCUR_MONITOR_N_OTHER_VIF) &&
+	    !cfg80211_has_monitors_only(rdev))
 		return -EBUSY;
 
 	return rdev_set_monitor_channel(rdev, dev, chandef);
-- 
2.17.1


