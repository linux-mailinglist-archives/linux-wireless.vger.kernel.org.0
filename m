Return-Path: <linux-wireless+bounces-6029-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3085189DD88
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 17:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EBD81C212A4
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 15:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5AA131BB1;
	Tue,  9 Apr 2024 15:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aXh6ggRv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3BD131BD7
	for <linux-wireless@vger.kernel.org>; Tue,  9 Apr 2024 15:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712674856; cv=none; b=hFTcAc6ejyoOm15HlyDE5E1AcdrbBUkMU1CmLabA93VnWn2d+6XG7k++b8KMnkqnO/dCak+ctQNAhCd29oM/DEbA3Jc+tICRbbUB029bnTh4WpsJShNTQQ2jRP1VvWJId/eVqMpVCpZdCrYKtOQvA2SfLy2Q/dxxxnf9S/YoLT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712674856; c=relaxed/simple;
	bh=W+NzZsqYCC6IId2wPGMJ23KSr8kJFcx4u3cCFNeRP84=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Rzwf2r++1poQAPN24/OccbY7zYe9VVwzBa4+EhKg3xwgt2sn4E/ywrpMjShwk8hbIX/qAcQlTmvTwjZgW5d6R5VEH4v8zcVJL6evi8w2i7FuvW6je4Ha4MhYrHgYkLvu2buJ3KT3ZujXBp8PS+7Mz+eFjOShTAliTS2eB3BOxkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aXh6ggRv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 439CQcWL017966;
	Tue, 9 Apr 2024 15:00:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=0SRv0Xd
	2xr4nRCfQn4isUIuqjAjjLA2TzRSRe3zGQBU=; b=aXh6ggRvQ5TSgXjF2c0YtRu
	T0mSuMtNWg//tyLWhryzB5rHGd0II4zqlbg+cAvcFUwGFRUzvDTRUZ48M8qT7X2X
	lWonALUf+myotCF852lRGHt2HdHadK+9KqhCnds8Jx84Lf0ADzmE1SEvrroeImql
	eW/u4i09ZvySB6Ve+JpvHfHPHgebHsKvFRAjV9g9MTAObhF9R2pA8XGe5ZXh72fD
	WXZeiUy97UYpcSSTXHVEHciokqVqGSBE04UToDuoKZMdZxapaVqVB+G143l5w77f
	ZMx/0+IckN+Pq6Qo1hmJn+H8Bu/qph032/OZwrtMtxmAbOiJcj7TSQqvoeW2ziQ=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xd0hw10xc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 15:00:47 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 439F0kS3019336
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Apr 2024 15:00:46 GMT
Received: from hu-rrchinan-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 9 Apr 2024 08:00:44 -0700
From: Rathees Kumar R Chinannan <quic_rrchinan@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <quic_rrchinan@quicinc.com>
Subject: [PATCH] wifi: nl80211: Parse NL80211 attribute to update probe response template
Date: Tue, 9 Apr 2024 20:30:25 +0530
Message-ID: <20240409150025.3261531-1-quic_rrchinan@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-GUID: myxb2yr4x2NSJkPiDCdfvrGzlO5MLffj
X-Proofpoint-ORIG-GUID: myxb2yr4x2NSJkPiDCdfvrGzlO5MLffj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_10,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 suspectscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404090098

Currently NL80211_ATTR_UNSOL_BCAST_PROBE_RESP attribute is parsed only by
nl80211_start_ap() and nl80211_set_beacon(). Add changes to parse this
attribute when NL80211 command received for channel change or BSS color
code change.

Add and update link_id parameter on cfg80211_color_change_settings
structure to know the link on which BSS color code change is expected.

This attribute will be set when AP is beaconing only on 6 GHz band and
unsol_bcast_presp interval is set, in this case AP sends unsolicited
broadcast probe response frame for in-band discovery.

Signed-off-by: Rathees Kumar R Chinannan <quic_rrchinan@quicinc.com>
---
 include/net/cfg80211.h |  7 +++++++
 net/mac80211/cfg.c     | 20 ++++++++++++++++++++
 net/wireless/nl80211.c | 20 +++++++++++++++++++-
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 496a9d4956de..7ebb5b8578e7 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1549,6 +1549,7 @@ struct cfg80211_ap_update {
  * @count: number of beacons until switch
  * @link_id: defines the link on which channel switch is expected during
  *	MLO. 0 in case of non-MLO.
+ * @unsol_bcast_probe_resp: Unsolicited broadcast probe response parameters
  */
 struct cfg80211_csa_settings {
 	struct cfg80211_chan_def chandef;
@@ -1562,6 +1563,7 @@ struct cfg80211_csa_settings {
 	bool block_tx;
 	u8 count;
 	u8 link_id;
+	struct cfg80211_unsol_bcast_probe_resp unsol_bcast_probe_resp;
 };
 
 /**
@@ -1575,6 +1577,9 @@ struct cfg80211_csa_settings {
  * @beacon_next: beacon data to be used after the color change
  * @count: number of beacons until the color change
  * @color: the color used after the change
+ * @link_id: defines the link on which color change is expected during
+ *	MLO. 0 in case of non-MLO.
+ * @unsol_bcast_probe_resp: Unsolicited broadcast probe response parameters
  */
 struct cfg80211_color_change_settings {
 	struct cfg80211_beacon_data beacon_color_change;
@@ -1583,6 +1588,8 @@ struct cfg80211_color_change_settings {
 	struct cfg80211_beacon_data beacon_next;
 	u8 count;
 	u8 color;
+	u8 link_id;
+	struct cfg80211_unsol_bcast_probe_resp unsol_bcast_probe_resp;
 };
 
 /**
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 97ffd3028467..4947e249cfaf 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4026,6 +4026,12 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 	ch_switch.block_tx = params->block_tx;
 	ch_switch.chandef = chanreq.oper;
 	ch_switch.count = params->count;
+	err = ieee80211_set_unsol_bcast_probe_resp(sdata,
+						   &params->unsol_bcast_probe_resp,
+						   link_data, link_conf,
+						   &changed);
+	if (err)
+		goto out;
 
 	err = drv_pre_channel_switch(sdata, &ch_switch);
 	if (err)
@@ -4891,8 +4897,11 @@ ieee80211_color_change(struct wiphy *wiphy, struct net_device *dev,
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_bss_conf *link_conf;
+	struct ieee80211_link_data *link_data;
 	u64 changed = 0;
 	int err;
+	u8 link_id = params->link_id;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
@@ -4907,6 +4916,11 @@ ieee80211_color_change(struct wiphy *wiphy, struct net_device *dev,
 		goto out;
 	}
 
+	link_data = wiphy_dereference(wiphy, sdata->link[link_id]);
+	if (!link_data)
+		return -ENOLINK;
+	link_conf = link_data->conf;
+
 	err = ieee80211_set_color_change_beacon(sdata, params, &changed);
 	if (err)
 		goto out;
@@ -4914,6 +4928,12 @@ ieee80211_color_change(struct wiphy *wiphy, struct net_device *dev,
 	sdata->vif.bss_conf.color_change_active = true;
 	sdata->vif.bss_conf.color_change_color = params->color;
 
+	err = ieee80211_set_unsol_bcast_probe_resp(sdata, &params->unsol_bcast_probe_resp,
+						   link_data, link_conf,
+						   &changed);
+	if (err)
+		goto out;
+
 	cfg80211_color_change_started_notify(sdata->dev, params->count);
 
 	if (changed)
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index b2c6376705b3..1c665d80cbfa 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -10248,6 +10248,14 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[NL80211_ATTR_CH_SWITCH_BLOCK_TX])
 		params.block_tx = true;
 
+	if (info->attrs[NL80211_ATTR_UNSOL_BCAST_PROBE_RESP]) {
+		err = nl80211_parse_unsol_bcast_probe_resp(
+			rdev, info->attrs[NL80211_ATTR_UNSOL_BCAST_PROBE_RESP],
+			&params.unsol_bcast_probe_resp);
+		if (err)
+			goto free;
+	}
+
 	params.link_id = link_id;
 	err = rdev_channel_switch(rdev, dev, &params);
 
@@ -15965,6 +15973,7 @@ static int nl80211_color_change(struct sk_buff *skb, struct genl_info *info)
 	struct nlattr **tb;
 	u16 offset;
 	int err;
+	unsigned int link_id = nl80211_link_id(info->attrs);
 
 	if (!rdev->ops->color_change)
 		return -EOPNOTSUPP;
@@ -16048,6 +16057,14 @@ static int nl80211_color_change(struct sk_buff *skb, struct genl_info *info)
 
 		params.counter_offset_presp = offset;
 	}
+	params.link_id = link_id;
+	if (info->attrs[NL80211_ATTR_UNSOL_BCAST_PROBE_RESP]) {
+		err = nl80211_parse_unsol_bcast_probe_resp(
+			rdev, info->attrs[NL80211_ATTR_UNSOL_BCAST_PROBE_RESP],
+			&params.unsol_bcast_probe_resp);
+		if (err)
+			goto out;
+	}
 
 	err = rdev_color_change(rdev, dev, &params);
 
@@ -17451,7 +17468,8 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_color_change,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP |
+					 NL80211_FLAG_MLO_VALID_LINK_ID),
 	},
 	{
 		.cmd = NL80211_CMD_SET_FILS_AAD,
-- 
2.34.1


