Return-Path: <linux-wireless+bounces-6364-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7E78A62B3
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 07:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CB7D1F224AB
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 05:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA4338385;
	Tue, 16 Apr 2024 05:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fLSSFUuj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A03381C4
	for <linux-wireless@vger.kernel.org>; Tue, 16 Apr 2024 05:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713243622; cv=none; b=HP0iBwEnPsJOg7+kyjU2/ay8oUs2QzoRSdjnF6Wv7JItRc7xTCPexf8kJZ6E9EcejvieWYUyhyj8ahXNpFhGyjWu53qQTnrj7rJT8/7ygIpv/NWuWqPlW8uasLBFmsowJtXTI5LafsEgFajc4ffDocnuMZ6IWIdlo5tDXFIua68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713243622; c=relaxed/simple;
	bh=ARCEpyTKwNusidjFgTbo9qCFIL+PgYCDKbwzjcXRbpc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E+2nod1SycwXtBZ3QnSjhwEVayxK02CtExHGfHOII9q9+5BfqPG+m9CJLzDD5kRo/7TkbbcIdCW9yrCPkRkAzTwwB3CDOGRa3lC8piWP3j0luM6rtqm3BEnfjfjqyC/YzKI0QdjT0RWgWvyZ4bee8l0STcWpFCII9umlHtR8wMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fLSSFUuj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43G0JVjF013032;
	Tue, 16 Apr 2024 05:00:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=s7iIYvvnKXHiJrWm2gjWYcROak8g4Au6XlYAbH5HxcU=; b=fL
	SSFUuj9BZykt/lfdDiXKQrYHCt79EPZ3o5WMg6+S26zgaTF/BXrGmrHT1s/L0hWJ
	4Fwu9sMsXTZoYJNsun5wwrdiKtCoG69ppXD7ljZzuTRdQSvmiJz5LgG/58LINOef
	Sj0u4twFRyvDcADhT0uLbNvrEv33Co7EaTAtfW4VoZsYIhPQTC12O34YaZSl7V4M
	2D/6n0A0mAGL+9dNCu5Sp2T+7AyNo07UoaRG/h3bAw7s8DArG6SjGEhYUOINU3BY
	pvMkjLSOFbnpW4UlFEkJBANNlKLVPYyN8COysRQf0vJMNu5hIxPcY8cWq/Heuxk7
	lPkrbGUwRj0+M2LkMJvA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xhbburtn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 05:00:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43G505RL025239
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 05:00:05 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 15 Apr 2024 22:00:03 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH 2/7] wifi: cfg80211: notify link ID in bss_color_notify
Date: Tue, 16 Apr 2024 10:29:38 +0530
Message-ID: <20240416045943.576656-3-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416045943.576656-1-quic_adisi@quicinc.com>
References: <20240416045943.576656-1-quic_adisi@quicinc.com>
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
X-Proofpoint-ORIG-GUID: a2AyBPAirMqC-rkFI9RRfEVA8EnXtl82
X-Proofpoint-GUID: a2AyBPAirMqC-rkFI9RRfEVA8EnXtl82
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_02,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404160028

Add changes to send link ID as well in bss color notify during MLO.
Userspace application can make use of this to take necessary actions.

For now, pass 0 as link ID. Appropriate link ID will be passed in a
subsequent change.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 include/net/cfg80211.h | 26 +++++++++++++++++---------
 net/mac80211/cfg.c     | 11 ++++++-----
 net/wireless/nl80211.c |  6 +++++-
 3 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 0e2b3e0c8541..e0f488eb15d1 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -9389,60 +9389,68 @@ void cfg80211_bss_flush(struct wiphy *wiphy);
  * @cmd: the actual event we want to notify
  * @count: the number of TBTTs until the color change happens
  * @color_bitmap: representations of the colors that the local BSS is aware of
+ * @link_id: valid link_id in case of MLO or 0 for non-MLO.
  */
 int cfg80211_bss_color_notify(struct net_device *dev,
 			      enum nl80211_commands cmd, u8 count,
-			      u64 color_bitmap);
+			      u64 color_bitmap, u8 link_id);
 
 /**
  * cfg80211_obss_color_collision_notify - notify about bss color collision
  * @dev: network device
  * @color_bitmap: representations of the colors that the local BSS is aware of
+ * @link_id: valid link_id in case of MLO or 0 for non-MLO.
  */
 static inline int cfg80211_obss_color_collision_notify(struct net_device *dev,
-						       u64 color_bitmap)
+						       u64 color_bitmap,
+						       u8 link_id)
 {
 	return cfg80211_bss_color_notify(dev, NL80211_CMD_OBSS_COLOR_COLLISION,
-					 0, color_bitmap);
+					 0, color_bitmap, link_id);
 }
 
 /**
  * cfg80211_color_change_started_notify - notify color change start
  * @dev: the device on which the color is switched
  * @count: the number of TBTTs until the color change happens
+ * @link_id: valid link_id in case of MLO or 0 for non-MLO.
  *
  * Inform the userspace about the color change that has started.
  */
 static inline int cfg80211_color_change_started_notify(struct net_device *dev,
-						       u8 count)
+						       u8 count, u8 link_id)
 {
 	return cfg80211_bss_color_notify(dev, NL80211_CMD_COLOR_CHANGE_STARTED,
-					 count, 0);
+					 count, 0, link_id);
 }
 
 /**
  * cfg80211_color_change_aborted_notify - notify color change abort
  * @dev: the device on which the color is switched
+ * @link_id: valid link_id in case of MLO or 0 for non-MLO.
  *
  * Inform the userspace about the color change that has aborted.
  */
-static inline int cfg80211_color_change_aborted_notify(struct net_device *dev)
+static inline int cfg80211_color_change_aborted_notify(struct net_device *dev,
+						       u8 link_id)
 {
 	return cfg80211_bss_color_notify(dev, NL80211_CMD_COLOR_CHANGE_ABORTED,
-					 0, 0);
+					 0, 0, link_id);
 }
 
 /**
  * cfg80211_color_change_notify - notify color change completion
  * @dev: the device on which the color was switched
+ * @link_id: valid link_id in case of MLO or 0 for non-MLO.
  *
  * Inform the userspace about the color change that has completed.
  */
-static inline int cfg80211_color_change_notify(struct net_device *dev)
+static inline int cfg80211_color_change_notify(struct net_device *dev,
+					       u8 link_id)
 {
 	return cfg80211_bss_color_notify(dev,
 					 NL80211_CMD_COLOR_CHANGE_COMPLETED,
-					 0, 0);
+					 0, 0, link_id);
 }
 
 /**
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index f67c1d021812..f9374ce04c93 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3920,7 +3920,7 @@ static void ieee80211_color_change_abort(struct ieee80211_sub_if_data  *sdata)
 
 	ieee80211_free_next_beacon(&sdata->deflink);
 
-	cfg80211_color_change_aborted_notify(sdata->dev);
+	cfg80211_color_change_aborted_notify(sdata->dev, 0);
 }
 
 static int
@@ -4768,14 +4768,14 @@ static int ieee80211_color_change_finalize(struct ieee80211_sub_if_data *sdata)
 
 	err = ieee80211_set_after_color_change_beacon(sdata, &changed);
 	if (err) {
-		cfg80211_color_change_aborted_notify(sdata->dev);
+		cfg80211_color_change_aborted_notify(sdata->dev, 0);
 		return err;
 	}
 
 	ieee80211_color_change_bss_config_notify(sdata,
 						 sdata->vif.bss_conf.color_change_color,
 						 1, changed);
-	cfg80211_color_change_notify(sdata->dev);
+	cfg80211_color_change_notify(sdata->dev, 0);
 
 	return 0;
 }
@@ -4808,7 +4808,8 @@ void ieee80211_color_collision_detection_work(struct work_struct *work)
 			     color_collision_detect_work);
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 
-	cfg80211_obss_color_collision_notify(sdata->dev, link->color_bitmap);
+	cfg80211_obss_color_collision_notify(sdata->dev, link->color_bitmap,
+					     link->link_id);
 }
 
 void ieee80211_color_change_finish(struct ieee80211_vif *vif)
@@ -4872,7 +4873,7 @@ ieee80211_color_change(struct wiphy *wiphy, struct net_device *dev,
 	sdata->vif.bss_conf.color_change_active = true;
 	sdata->vif.bss_conf.color_change_color = params->color;
 
-	cfg80211_color_change_started_notify(sdata->dev, params->count);
+	cfg80211_color_change_started_notify(sdata->dev, params->count, 0);
 
 	if (changed)
 		ieee80211_color_change_bss_config_notify(sdata, 0, 0, changed);
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index a9d01cd16196..8013796f2afe 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -19455,7 +19455,7 @@ EXPORT_SYMBOL(cfg80211_ch_switch_started_notify);
 
 int cfg80211_bss_color_notify(struct net_device *dev,
 			      enum nl80211_commands cmd, u8 count,
-			      u64 color_bitmap)
+			      u64 color_bitmap, u8 link_id)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct wiphy *wiphy = wdev->wiphy;
@@ -19478,6 +19478,10 @@ int cfg80211_bss_color_notify(struct net_device *dev,
 	if (nla_put_u32(msg, NL80211_ATTR_IFINDEX, dev->ifindex))
 		goto nla_put_failure;
 
+	if (wdev->valid_links &&
+	    nla_put_u8(msg, NL80211_ATTR_MLO_LINK_ID, link_id))
+		goto nla_put_failure;
+
 	if (cmd == NL80211_CMD_COLOR_CHANGE_STARTED &&
 	    nla_put_u32(msg, NL80211_ATTR_COLOR_CHANGE_COUNT, count))
 		goto nla_put_failure;
-- 
2.25.1


