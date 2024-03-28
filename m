Return-Path: <linux-wireless+bounces-5442-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFC688F8C1
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 08:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 231F7B24700
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 07:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A6851C55;
	Thu, 28 Mar 2024 07:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FoGOd3G/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BE653E17
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 07:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711611023; cv=none; b=g7J3lqAFgv97Vi2bJSuU4fiGAu/2OWiR0PfCLl75tuK/ZCOpjtUT/9bUJPqxiWgFuBG9rmPc+rdLktOE50wNiWuegOUllNrjZYFE15ayR27RxFG+SQmbuOb1M0jt1BCoDUubhGlehc4LJ+ORvSX+4NEb7q5t+Y8UHv62o5EyRT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711611023; c=relaxed/simple;
	bh=JJp+Vyh1lNEfhffR8l0pgkCmcaq7Be+70PvUeYzEPks=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fm3QFpVUXGYye4dMEXqdPYv1h9u6qfBoqTqYVLEjnZUUXNpOIW5rtCLihOX7G/+ttJLsN2J80cJK5xUKIpghDgF1KG9jy1TQKIUMu7RkwsduEGsn9zw8a8RuLjBAVujx6Y8p7KnNG+uLVL3BNljmX8sEZ2pUBVKGJbqJP0ZkeUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FoGOd3G/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42S4u682015094;
	Thu, 28 Mar 2024 07:30:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=rSxKIjo/maAlGl1SnvISTzkFB8wGULpB3LJphUKy/YM=; b=Fo
	GOd3G/GiepGDt4jClVKOGHxoYnX81O42Y9L4bqRZXY27j8XU/fWC1BwJK4amp4G2
	0Wi9cw0h9KJobyAPFx5c2skLxTJSb75dmtRjqxq5aLJeY5xOjYcc2UWgXt1RpWmO
	ktmsCFNBpehTcGawEEKtUvr/H9fQOURtgt0cbvcSom3oHDU13DnPu1mgAWcWktG4
	79CdDyyuJ73w4Kt5ahs3iP+jYmdooWUtz/wKgkooUWrNvcKIo+1hlSFNOXv5SfPe
	dbQ1IgTYEz50N2i2KqLE5OfWxuoe3xh4UGpm6qQe11oNCOou2BnhYuF1H+B+c+ks
	3CPC95yxYoSbt9+9noPA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x4u1yjaut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 07:30:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42S7U9FV004892
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 07:30:09 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Mar 2024 00:30:07 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>, <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Vasanthakumar Thiagarajan
	<quic_vthiagar@quicinc.com>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 11/13] wifi: mac80211: Add multi-hardware support in the iface comb helper
Date: Thu, 28 Mar 2024 12:59:14 +0530
Message-ID: <20240328072916.1164195-12-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: Fjr9dXMqvujiTldB_0ADICPRt4y1rkEX
X-Proofpoint-ORIG-GUID: Fjr9dXMqvujiTldB_0ADICPRt4y1rkEX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_06,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0 suspectscore=0
 mlxscore=0 clxscore=1015 mlxlogscore=999 malwarescore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403280048

From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>

Currently, iface combination param supports single physical hardware.
To support multi physical hardware, add hardware specific checks on the
channel context creation and populate hardware specific parameters from
the channel definition for which the interface combination need to check.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1

Signed-off-by: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
Co-developed-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 net/mac80211/chan.c        |  33 +++++--
 net/mac80211/ieee80211_i.h |   3 +-
 net/mac80211/util.c        | 194 ++++++++++++++++++++++++++++++++++---
 3 files changed, 207 insertions(+), 23 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 08a362892d9a..0558eafa45aa 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -47,24 +47,43 @@ int ieee80211_chanctx_refcount(struct ieee80211_local *local,
 	       ieee80211_chanctx_num_reserved(local, ctx);
 }
 
-static int ieee80211_num_chanctx(struct ieee80211_local *local)
+static int ieee80211_num_chanctx(struct ieee80211_local *local,
+				 const struct cfg80211_chan_def *chandef)
 {
 	struct ieee80211_chanctx *ctx;
-	int num = 0;
+	int num = 0, hw_idx = -1, ctx_idx;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	list_for_each_entry(ctx, &local->chanctx_list, list)
-		num++;
+	if (chandef && cfg80211_chandef_valid(chandef))
+		hw_idx = cfg80211_get_hw_idx_by_chan(local->hw.wiphy,
+						     chandef->chan);
+
+	if (hw_idx < 0) {
+		list_for_each_entry(ctx, &local->chanctx_list, list)
+			num++;
+	} else {
+		list_for_each_entry(ctx, &local->chanctx_list, list) {
+			ctx_idx = cfg80211_get_hw_idx_by_chan(local->hw.wiphy,
+							      ctx->conf.def.chan);
+			if (ctx_idx != hw_idx)
+				continue;
+
+			num++;
+		}
+	}
 
 	return num;
 }
 
-static bool ieee80211_can_create_new_chanctx(struct ieee80211_local *local)
+static
+bool ieee80211_can_create_new_chanctx(struct ieee80211_local *local,
+				      const struct cfg80211_chan_def *chandef)
 {
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	return ieee80211_num_chanctx(local) < ieee80211_max_num_channels(local);
+	return ieee80211_num_chanctx(local, chandef) <
+	       ieee80211_max_num_channels(local, chandef);
 }
 
 struct ieee80211_chanctx *
@@ -1029,7 +1048,7 @@ int ieee80211_link_reserve_chanctx(struct ieee80211_link_data *link,
 
 	new_ctx = ieee80211_find_reservation_chanctx(local, chanreq, mode);
 	if (!new_ctx) {
-		if (ieee80211_can_create_new_chanctx(local)) {
+		if (ieee80211_can_create_new_chanctx(local, &chanreq->oper)) {
 			new_ctx = ieee80211_new_chanctx(local, chanreq, mode);
 			if (IS_ERR(new_ctx))
 				return PTR_ERR(new_ctx);
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 202bbffec746..42f4211c622b 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2600,7 +2600,8 @@ int ieee80211_check_combinations(struct ieee80211_sub_if_data *sdata,
 				 const struct cfg80211_chan_def *chandef,
 				 enum ieee80211_chanctx_mode chanmode,
 				 u8 radar_detect);
-int ieee80211_max_num_channels(struct ieee80211_local *local);
+int ieee80211_max_num_channels(struct ieee80211_local *local,
+			       const struct cfg80211_chan_def *chandef);
 void ieee80211_recalc_chanctx_chantype(struct ieee80211_local *local,
 				       struct ieee80211_chanctx *ctx);
 
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index b1f3b1eb053d..f8ffc8ad0cd8 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3926,6 +3926,44 @@ static u8 ieee80211_chanctx_radar_detect(struct ieee80211_local *local,
 	return radar_detect;
 }
 
+static void
+ieee80211_get_per_hw_sdata_active_iface(struct ieee80211_sub_if_data *sdata,
+					struct iface_comb_per_hw_params *per_hw,
+					int iftype_num[NUM_NL80211_IFTYPES],
+					int *total)
+{
+	struct ieee80211_local *local = sdata->local;
+	unsigned int link_id;
+	int hw_idx;
+
+	for (link_id = 0; link_id < ARRAY_SIZE(sdata->link); link_id++) {
+		struct ieee80211_link_data *link;
+		struct ieee80211_chanctx *ctx;
+
+		link = sdata_dereference(sdata->link[link_id], sdata);
+		if (!link)
+			continue;
+
+		ctx = ieee80211_link_get_chanctx(link);
+		if (ctx &&
+		    ctx->replace_state == IEEE80211_CHANCTX_WILL_BE_REPLACED)
+			ctx = ctx->replace_ctx;
+
+		hw_idx = -1;
+		if (ctx && cfg80211_chandef_valid(&ctx->conf.def))
+			hw_idx = cfg80211_get_hw_idx_by_chan(local->hw.wiphy,
+							     ctx->conf.def.chan);
+
+		if (hw_idx >= 0)
+			per_hw[hw_idx].iftype_num[sdata->wdev.iftype]++;
+		else
+			iftype_num[sdata->wdev.iftype]++;
+
+		if (total)
+			(*total)++;
+	}
+}
+
 int ieee80211_check_combinations(struct ieee80211_sub_if_data *sdata,
 				 const struct cfg80211_chan_def *chandef,
 				 enum ieee80211_chanctx_mode chanmode,
@@ -3936,9 +3974,12 @@ int ieee80211_check_combinations(struct ieee80211_sub_if_data *sdata,
 	enum nl80211_iftype iftype = sdata->wdev.iftype;
 	struct ieee80211_chanctx *ctx;
 	int total = 1;
+	struct iface_comb_per_hw_params *per_hw __free(kfree) = NULL;
 	struct iface_combination_params params = {
 		.radar_detect = radar_detect,
 	};
+	bool is_per_hw;
+	int hchan_idx = -1;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
@@ -3969,26 +4010,68 @@ int ieee80211_check_combinations(struct ieee80211_sub_if_data *sdata,
 		return 0;
 	}
 
-	if (chandef)
-		params.num_different_channels = 1;
+	is_per_hw = cfg80211_per_hw_iface_comb_advertised(local->hw.wiphy);
+	if (is_per_hw) {
+		per_hw = kcalloc(local->hw.wiphy->num_hw, sizeof(*per_hw),
+				 GFP_KERNEL);
+		if (!per_hw)
+			return -ENOMEM;
+
+		if (chandef && cfg80211_chandef_valid(chandef)) {
+			hchan_idx = cfg80211_get_hw_idx_by_chan(local->hw.wiphy,
+								chandef->chan);
+			if (hchan_idx < 0)
+				goto skip;
 
-	if (iftype != NL80211_IFTYPE_UNSPECIFIED)
-		params.iftype_num[iftype] = 1;
+			per_hw[hchan_idx].num_different_channels = 1;
 
+			if (iftype != NL80211_IFTYPE_UNSPECIFIED)
+				per_hw[hchan_idx].iftype_num[iftype] = 1;
+		}
+	} else {
+		if (chandef)
+			params.num_different_channels = 1;
+
+		if (iftype != NL80211_IFTYPE_UNSPECIFIED)
+			params.iftype_num[iftype] = 1;
+	}
+
+skip:
 	list_for_each_entry(ctx, &local->chanctx_list, list) {
 		if (ctx->replace_state == IEEE80211_CHANCTX_WILL_BE_REPLACED)
 			continue;
+
+		if (is_per_hw) {
+			if (WARN_ON(!cfg80211_chandef_valid(&ctx->conf.def)))
+				continue;
+
+			hchan_idx = cfg80211_get_hw_idx_by_chan(local->hw.wiphy,
+								ctx->conf.def.chan);
+			if (WARN_ON(hchan_idx < 0))
+				continue;
+		}
+
 		params.radar_detect |=
 			ieee80211_chanctx_radar_detect(local, ctx);
+
 		if (ctx->mode == IEEE80211_CHANCTX_EXCLUSIVE) {
-			params.num_different_channels++;
+			if (is_per_hw)
+				per_hw[hchan_idx].num_different_channels++;
+			else
+				params.num_different_channels++;
+
 			continue;
 		}
+
 		if (chandef && chanmode == IEEE80211_CHANCTX_SHARED &&
 		    cfg80211_chandef_compatible(chandef,
 						&ctx->conf.def))
 			continue;
-		params.num_different_channels++;
+
+		if (is_per_hw)
+			per_hw[hchan_idx].num_different_channels++;
+		else
+			params.num_different_channels++;
 	}
 
 	list_for_each_entry_rcu(sdata_iter, &local->interfaces, list) {
@@ -4002,13 +4085,25 @@ int ieee80211_check_combinations(struct ieee80211_sub_if_data *sdata,
 					    wdev_iter->iftype, 0, 1))
 			continue;
 
-		params.iftype_num[wdev_iter->iftype]++;
-		total++;
+		if (is_per_hw) {
+			ieee80211_get_per_hw_sdata_active_iface(sdata_iter,
+								per_hw,
+								params.iftype_num,
+								&total);
+		} else {
+			params.iftype_num[wdev_iter->iftype]++;
+			total++;
+		}
 	}
 
 	if (total == 1 && !params.radar_detect)
 		return 0;
 
+	if (is_per_hw) {
+		params.n_per_hw = local->hw.wiphy->num_hw;
+		params.per_hw = per_hw;
+	}
+
 	return cfg80211_check_combinations(local->hw.wiphy, &params);
 }
 
@@ -4022,31 +4117,100 @@ ieee80211_iter_max_chans(const struct ieee80211_iface_combination *c,
 					  c->num_different_channels);
 }
 
-int ieee80211_max_num_channels(struct ieee80211_local *local)
+static void
+ieee80211_iter_per_hw_max_chans(const struct ieee80211_iface_combination *c,
+				int hw_chan_idx, void *data)
+{
+	u32 *max_num_diff_chans = data;
+	u32 max_supp_diff_chans = 0;
+	int i;
+
+	for (i = 0; i < c->n_hw_list; i++) {
+		const struct ieee80211_iface_per_hw *h;
+
+		h = &c->iface_hw_list[i];
+		if (hw_chan_idx != -1) {
+			if (h->hw_chans_idx == hw_chan_idx) {
+				max_supp_diff_chans = h->num_different_channels;
+				break;
+			}
+			continue;
+		}
+		max_supp_diff_chans += h->num_different_channels;
+	}
+
+	*max_num_diff_chans = max(*max_num_diff_chans, max_supp_diff_chans);
+}
+
+int ieee80211_max_num_channels(struct ieee80211_local *local,
+			       const struct cfg80211_chan_def *chandef)
 {
 	struct ieee80211_sub_if_data *sdata;
 	struct ieee80211_chanctx *ctx;
+	struct iface_comb_per_hw_params *per_hw __free(kfree) = NULL;
+	struct iface_combination_params params = {0};
+	void (*iter)(const struct ieee80211_iface_combination *c,
+		     int hw_chan_idx, void *data) = ieee80211_iter_max_chans;
 	u32 max_num_different_channels = 1;
+	bool is_per_hw;
 	int err;
-	struct iface_combination_params params = {0};
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
+	is_per_hw = cfg80211_per_hw_iface_comb_advertised(local->hw.wiphy);
+	if (is_per_hw) {
+		per_hw = kcalloc(local->hw.wiphy->num_hw,
+				 sizeof(*params.per_hw),
+				 GFP_KERNEL);
+		if (!per_hw)
+			return -ENOMEM;
+
+		params.chandef = chandef;
+		iter = ieee80211_iter_per_hw_max_chans;
+	}
+
 	list_for_each_entry(ctx, &local->chanctx_list, list) {
-		if (ctx->replace_state == IEEE80211_CHANCTX_WILL_BE_REPLACED)
+		if (ctx->replace_state ==
+		    IEEE80211_CHANCTX_WILL_BE_REPLACED)
 			continue;
 
-		params.num_different_channels++;
+		if (is_per_hw) {
+			int hw_idx;
+
+			if (WARN_ON(!cfg80211_chandef_valid(&ctx->conf.def)))
+				continue;
+
+			hw_idx = cfg80211_get_hw_idx_by_chan(local->hw.wiphy,
+							     ctx->conf.def.chan);
+			if (WARN_ON(hw_idx < 0))
+				continue;
+
+			per_hw[hw_idx].num_different_channels++;
+		} else {
+			params.num_different_channels++;
+		}
 
 		params.radar_detect |=
 			ieee80211_chanctx_radar_detect(local, ctx);
 	}
 
-	list_for_each_entry_rcu(sdata, &local->interfaces, list)
-		params.iftype_num[sdata->wdev.iftype]++;
+	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
+		if (is_per_hw && ieee80211_sdata_running(sdata))
+			ieee80211_get_per_hw_sdata_active_iface(sdata,
+								per_hw,
+								params.iftype_num,
+								NULL);
+		else
+			params.iftype_num[sdata->wdev.iftype]++;
+	}
+
+	if (is_per_hw) {
+		params.n_per_hw = local->hw.wiphy->num_hw;
+		params.per_hw = per_hw;
+	}
 
 	err = cfg80211_iter_combinations(local->hw.wiphy, &params,
-					 ieee80211_iter_max_chans,
+					 iter,
 					 &max_num_different_channels);
 	if (err < 0)
 		return err;
-- 
2.34.1


