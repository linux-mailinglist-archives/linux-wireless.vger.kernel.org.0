Return-Path: <linux-wireless+bounces-6628-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A82428AC3BB
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 07:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D494F1C21A8D
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 05:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B46E1759F;
	Mon, 22 Apr 2024 05:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kk4L0S4K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A6410A19
	for <linux-wireless@vger.kernel.org>; Mon, 22 Apr 2024 05:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713764082; cv=none; b=nKB+AsMgmZsl0FSmtENJAhNKSOLGGkR0OciQrQLZjlhX4sRuhv6FsHDldMMei8h67y9Td55jSINmqclph8+7qON1ZpTOKeKvRBMszfJ5Lum65CPO0a7yoe+OugQyzqbslEnmfASGOeC68/EkLiy2byunjP0DNiEXmv4waG67cvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713764082; c=relaxed/simple;
	bh=LExYZM4y0Q0t6ahobi9ugvT0uqczU67uT4gthynG0nA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eUL9HapDtogRuFiUCZP3YO6alLxFU6M4dd+apwDfgm7O6pUj77foLc5EqI7QAbywT/6Uid5ighFJJ6N/DKTYOIqvGN5LoNpvaVTxYImeSxxsdBhJx5G8qeR3ZdCvQXpXGShMuE4rNNBz4h8jloUd/49gjcdRSwn8yH4AwxuIhjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kk4L0S4K; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43M3hcK8015702;
	Mon, 22 Apr 2024 05:34:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=mijvg0iHl85+poizhq7nwVxGS8pRFH6DhnDymn2tw3A=; b=kk
	4L0S4KBvo55EbaGrTWmMTvfqw78GDHTWzd3yDSo35hkeLYEvuvOFmeSOJOAo44yP
	xOLSrQ5ONqHIdIPAB8Fffn8OT/lqKh1qztwemANRflAabEYsEZqg/KnDYWuIUW4v
	b+CM3pQfVNcAbLfWsiYkheRE5Ku6jsbUtNDwJwlfKvc+d/MbxgC1iF6YSFrzoQZ3
	D0U72YSaEtOoFsC6yDqiUumPxV4mlVU3h4/3VrRRABfZr0kiBJxV4ci7qd7qtXKO
	TgtmOx2cm3mwwmnMLYzZnkriLSrZU5HsBYj5wqF3fwjUMq3QiWvHCZSkQQyAJtQa
	gkpacxERB+kS2DWTwigQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xm5sx3ayh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 05:34:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43M5YZ2O028955
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 05:34:35 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 21 Apr 2024 22:34:33 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v2 2/7] wifi: cfg80211: notify link ID in bss_color_notify
Date: Mon, 22 Apr 2024 11:04:07 +0530
Message-ID: <20240422053412.2024075-3-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240422053412.2024075-1-quic_adisi@quicinc.com>
References: <20240422053412.2024075-1-quic_adisi@quicinc.com>
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
X-Proofpoint-ORIG-GUID: KyZCjrHlk7Vsu7KgaEFMyrOQExEpNXxW
X-Proofpoint-GUID: KyZCjrHlk7Vsu7KgaEFMyrOQExEpNXxW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_02,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220024

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
index 9716a8090f47..cbf1664dc569 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -9428,70 +9428,78 @@ void cfg80211_bss_flush(struct wiphy *wiphy);
  * @cmd: the actual event we want to notify
  * @count: the number of TBTTs until the color change happens
  * @color_bitmap: representations of the colors that the local BSS is aware of
+ * @link_id: valid link_id in case of MLO or 0 for non-MLO.
  *
  * Return: 0 on success. Non-zero on error.
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
  *
  * Return: 0 on success. Non-zero on error.
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
  *
  * Return: 0 on success. Non-zero on error.
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
  *
  * Return: 0 on success. Non-zero on error.
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
  *
  * Return: 0 on success. Non-zero on error.
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
index 44971a62d798..6eee239d5909 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3924,7 +3924,7 @@ static void ieee80211_color_change_abort(struct ieee80211_sub_if_data  *sdata)
 
 	ieee80211_free_next_beacon(&sdata->deflink);
 
-	cfg80211_color_change_aborted_notify(sdata->dev);
+	cfg80211_color_change_aborted_notify(sdata->dev, 0);
 }
 
 static int
@@ -4772,14 +4772,14 @@ static int ieee80211_color_change_finalize(struct ieee80211_sub_if_data *sdata)
 
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
@@ -4812,7 +4812,8 @@ void ieee80211_color_collision_detection_work(struct work_struct *work)
 			     color_collision_detect_work);
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 
-	cfg80211_obss_color_collision_notify(sdata->dev, link->color_bitmap);
+	cfg80211_obss_color_collision_notify(sdata->dev, link->color_bitmap,
+					     link->link_id);
 }
 
 void ieee80211_color_change_finish(struct ieee80211_vif *vif)
@@ -4876,7 +4877,7 @@ ieee80211_color_change(struct wiphy *wiphy, struct net_device *dev,
 	sdata->vif.bss_conf.color_change_active = true;
 	sdata->vif.bss_conf.color_change_color = params->color;
 
-	cfg80211_color_change_started_notify(sdata->dev, params->count);
+	cfg80211_color_change_started_notify(sdata->dev, params->count, 0);
 
 	if (changed)
 		ieee80211_color_change_bss_config_notify(sdata, 0, 0, changed);
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 995904f71be3..92afbd64682d 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -19456,7 +19456,7 @@ EXPORT_SYMBOL(cfg80211_ch_switch_started_notify);
 
 int cfg80211_bss_color_notify(struct net_device *dev,
 			      enum nl80211_commands cmd, u8 count,
-			      u64 color_bitmap)
+			      u64 color_bitmap, u8 link_id)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct wiphy *wiphy = wdev->wiphy;
@@ -19479,6 +19479,10 @@ int cfg80211_bss_color_notify(struct net_device *dev,
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
2.34.1


