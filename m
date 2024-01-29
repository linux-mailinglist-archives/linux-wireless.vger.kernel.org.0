Return-Path: <linux-wireless+bounces-2711-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3598384132B
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 20:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 932AE2888F9
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D684C63A;
	Mon, 29 Jan 2024 19:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="PAmRzbrn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D8C48790
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 19:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706556050; cv=none; b=A7ILnDsW7YkIqs/Y9D4YOzSrHS+FY1ie4L3xEz//pP4gAt2IeUsN/lBu8R0vSKlXb5kao9oLuSh6kcbyhAbJLVBiVtBBMAkgaMqYegZbdhf2uZgnRLbOxXllASlKc0Lh72eviEBdlr2JnGIYmTlXPhUlxGI4xYNCvEB45Ey/fkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706556050; c=relaxed/simple;
	bh=Wurws95fm5zL3MFre/KgIlsS2freaecTv6Z9NiTgaqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DGyNmaKurTP9TqCcHAeE+zwDXKf7WYX3vv7hvfW1tDGsvR1Tm+JE7X9SoBJaEJ1w6OBq4FkRYKvhx4o6skvVYZFT3suGD1YWhvaXhY5pE6hElkMa6gULB4cU2jzR08Q+pwm+hE6qDPRbCvQxrMU+vgl6VaMZVSJLSqClPXgil5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=PAmRzbrn; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=gwn0jSCvuoKXHfSYbbLB/Kc9hCT5bvGLXHkUZXSElrs=;
	t=1706556047; x=1707765647; b=PAmRzbrnTOtoMcG4+sxkVYJ3Nv16aUNOI41m0Ae9uT7TGHY
	aVUCmMP8yjD1Yrwo1f+6IgSS5IMFC8aYkf779+TKGq7Fxywk5wIxHLQunBnqKwDqpNCnKXF6LjLnz
	RKrPDhKw8FeRAcXNzxq/2KYnqZyB6GeOgq8j7nUkXI8t5fWqXlasyEwCPVF4U7I2yaq2Uhwtv61Fz
	JM/gOFBSguicpiW6rMFoKetdwhNt663CVHi2FLqZDeYXNN7RvYbpjQe5+4jqo/yYhgHoo4IKIigl8
	l8+ZyY2Rq/z7wpD77NJvldbHNGFwho5xvodcSFv78oEGTSuYBdl64WDzmW8FgmLw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUXBU-000000050Z6-1g6w;
	Mon, 29 Jan 2024 20:20:44 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 01/10] wifi: mac80211: simplify HE/EHT element length functions
Date: Mon, 29 Jan 2024 20:19:27 +0100
Message-ID: <20240129202041.5890eb1d4184.Ibce7e5abcc7887630da03ac2263d8004ec541418@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129192041.58481-12-johannes@sipsolutions.net>
References: <20240129192041.58481-12-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

We don't need to pass the iftype there, we already have it
in the sdata. Simplify this code.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h |  4 ++--
 net/mac80211/mesh.c        |  8 +++-----
 net/mac80211/mesh_plink.c  |  8 +++-----
 net/mac80211/util.c        | 15 ++++++++-------
 4 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index e11297b4dc63..44400ce9a0b1 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2502,7 +2502,7 @@ u8 *ieee80211_ie_build_vht_cap(u8 *pos, struct ieee80211_sta_vht_cap *vht_cap,
 			       u32 cap);
 u8 *ieee80211_ie_build_vht_oper(u8 *pos, struct ieee80211_sta_vht_cap *vht_cap,
 				const struct cfg80211_chan_def *chandef);
-u8 ieee80211_ie_len_he_cap(struct ieee80211_sub_if_data *sdata, u8 iftype);
+u8 ieee80211_ie_len_he_cap(struct ieee80211_sub_if_data *sdata);
 u8 *ieee80211_ie_build_he_cap(const struct ieee80211_conn_settings *conn,
 			      const struct ieee80211_sta_he_cap *he_cap,
 			      u8 *pos, u8 *end);
@@ -2651,7 +2651,7 @@ u32 ieee80211_calc_expected_tx_airtime(struct ieee80211_hw *hw,
 void ieee80211_init_frag_cache(struct ieee80211_fragment_cache *cache);
 void ieee80211_destroy_frag_cache(struct ieee80211_fragment_cache *cache);
 
-u8 ieee80211_ie_len_eht_cap(struct ieee80211_sub_if_data *sdata, u8 iftype);
+u8 ieee80211_ie_len_eht_cap(struct ieee80211_sub_if_data *sdata);
 u8 *ieee80211_ie_build_eht_cap(u8 *pos,
 			       const struct ieee80211_sta_he_cap *he_cap,
 			       const struct ieee80211_sta_eht_cap *eht_cap,
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index e06d9ed2d31b..9fd209e4ca19 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2008, 2009 open80211s Ltd.
- * Copyright (C) 2018 - 2023 Intel Corporation
+ * Copyright (C) 2018 - 2024 Intel Corporation
  * Authors:    Luis Carlos Cobo <luisca@cozybit.com>
  * 	       Javier Cardona <javier@cozybit.com>
  */
@@ -981,10 +981,8 @@ ieee80211_mesh_build_beacon(struct ieee80211_if_mesh *ifmsh)
 	band = chanctx_conf->def.chan->band;
 	rcu_read_unlock();
 
-	ie_len_he_cap = ieee80211_ie_len_he_cap(sdata,
-						NL80211_IFTYPE_MESH_POINT);
-	ie_len_eht_cap = ieee80211_ie_len_eht_cap(sdata,
-						  NL80211_IFTYPE_MESH_POINT);
+	ie_len_he_cap = ieee80211_ie_len_he_cap(sdata);
+	ie_len_eht_cap = ieee80211_ie_len_eht_cap(sdata);
 	head_len = hdr_len +
 		   2 + /* NULL SSID */
 		   /* Channel Switch Announcement */
diff --git a/net/mac80211/mesh_plink.c b/net/mac80211/mesh_plink.c
index e3aad60f68ab..7ba0f01805a4 100644
--- a/net/mac80211/mesh_plink.c
+++ b/net/mac80211/mesh_plink.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2008, 2009 open80211s Ltd.
- * Copyright (C) 2019, 2021-2023 Intel Corporation
+ * Copyright (C) 2019, 2021-2024 Intel Corporation
  * Author:     Luis Carlos Cobo <luisca@cozybit.com>
  */
 #include <linux/gfp.h>
@@ -226,10 +226,8 @@ static int mesh_plink_frame_tx(struct ieee80211_sub_if_data *sdata,
 	int hdr_len = offsetofend(struct ieee80211_mgmt, u.action.u.self_prot);
 	int err = -ENOMEM;
 
-	ie_len_he_cap = ieee80211_ie_len_he_cap(sdata,
-						NL80211_IFTYPE_MESH_POINT);
-	ie_len_eht_cap = ieee80211_ie_len_eht_cap(sdata,
-						  NL80211_IFTYPE_MESH_POINT);
+	ie_len_he_cap = ieee80211_ie_len_he_cap(sdata);
+	ie_len_eht_cap = ieee80211_ie_len_eht_cap(sdata);
 	skb = dev_alloc_skb(local->tx_headroom +
 			    hdr_len +
 			    2 + /* capability info */
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index d85a9c5cde26..e9a7978d47d4 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3272,7 +3272,8 @@ u8 *ieee80211_ie_build_vht_cap(u8 *pos, struct ieee80211_sta_vht_cap *vht_cap,
 	return pos;
 }
 
-u8 ieee80211_ie_len_he_cap(struct ieee80211_sub_if_data *sdata, u8 iftype)
+/* this may return more than ieee80211_ie_build_he_cap() will need */
+u8 ieee80211_ie_len_he_cap(struct ieee80211_sub_if_data *sdata)
 {
 	const struct ieee80211_sta_he_cap *he_cap;
 	struct ieee80211_supported_band *sband;
@@ -3282,7 +3283,7 @@ u8 ieee80211_ie_len_he_cap(struct ieee80211_sub_if_data *sdata, u8 iftype)
 	if (!sband)
 		return 0;
 
-	he_cap = ieee80211_get_he_iftype_cap(sband, iftype);
+	he_cap = ieee80211_get_he_iftype_cap_vif(sband, &sdata->vif);
 	if (!he_cap)
 		return 0;
 
@@ -5065,7 +5066,8 @@ u16 ieee80211_encode_usf(int listen_interval)
 	return (u16) listen_interval;
 }
 
-u8 ieee80211_ie_len_eht_cap(struct ieee80211_sub_if_data *sdata, u8 iftype)
+/* this may return more than ieee80211_ie_build_eht_cap() will need */
+u8 ieee80211_ie_len_eht_cap(struct ieee80211_sub_if_data *sdata)
 {
 	const struct ieee80211_sta_he_cap *he_cap;
 	const struct ieee80211_sta_eht_cap *eht_cap;
@@ -5077,13 +5079,12 @@ u8 ieee80211_ie_len_eht_cap(struct ieee80211_sub_if_data *sdata, u8 iftype)
 	if (!sband)
 		return 0;
 
-	he_cap = ieee80211_get_he_iftype_cap(sband, iftype);
-	eht_cap = ieee80211_get_eht_iftype_cap(sband, iftype);
+	he_cap = ieee80211_get_he_iftype_cap_vif(sband, &sdata->vif);
+	eht_cap = ieee80211_get_eht_iftype_cap_vif(sband, &sdata->vif);
 	if (!he_cap || !eht_cap)
 		return 0;
 
-	is_ap = iftype == NL80211_IFTYPE_AP ||
-		iftype == NL80211_IFTYPE_P2P_GO;
+	is_ap = sdata->vif.type == NL80211_IFTYPE_AP;
 
 	n = ieee80211_eht_mcs_nss_size(&he_cap->he_cap_elem,
 				       &eht_cap->eht_cap_elem,
-- 
2.43.0


