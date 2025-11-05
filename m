Return-Path: <linux-wireless+bounces-28623-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A52EFC363A5
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 16:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A36C1A217C5
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 15:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E03324B3D;
	Wed,  5 Nov 2025 15:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="qX7HFkRE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91B730FC00
	for <linux-wireless@vger.kernel.org>; Wed,  5 Nov 2025 15:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762355298; cv=none; b=DBSzCSKe/E+7PK2N2FhIHFTX2023YuNMmoByhizpxuFTB9c6EqYrk1CQgnC6Pk8b9a3YVNMv5DgXAn/E7rG0Xl6iy1d5/EskFDBOzZmegEx2ck1PH0RFbAl6EpcFLWlIbo/HVTqhTkZkWYLdLkrALxSSKoQd6qBIAg9DO9cXAsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762355298; c=relaxed/simple;
	bh=3ZvEcdScGwhlkQsP5SWJNrmIswNHR3rzd2mRBVBiGVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cI60sK5CcClrdvH4bvNz+ryBrsq1MFS2ZEzo5TnVa52zaR4HQVsf+XDsW/wxcsiPG3EZtFFtDZgGyavZXd/2Kj0sMzZe22n+HO14k8ltJm4sWv8hxtcJOzIT+INfw+dgh0b7SvY4mrytXVnFjs7S4okWi4o5iC55Q/1klHclX/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=qX7HFkRE; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=kX1khJJ5vCRS3F2TsDYKWf7M+X+erNxW+FFpAf5dzDg=; t=1762355295; x=1763564895; 
	b=qX7HFkRE2slXdCf8EjCn7blXiII3dwWUmHo75oyOBRWKTAcVAsu/HgWsVx1JUaa7PtJ4DMxLmdy
	UmW8lCFA8sDvU1JRLxr85PCquylABFVawvsn9mc1pm/SCbfPkaGHCh58Rh8kvFAoWOZyElWwHEfRz
	2+CoEme1cKRDNJU6oCt8adFtlW23PC7xyAv4wTAHP/ho/aIHbSlgLeYsVQheXIdz1uMPy0Thv00IS
	dhV80WlY0Sl2Mjt6uTbyOas/tP6KH2hmC+PAL8JKHQquJAd/PsmkIn6BtQT0+EXjWHAYLSHG0wS3e
	Z5/NzBLwJWvIQ7x4fQR97J4wfSrmLPsaPHug==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vGf7M-0000000FGvn-3AEy;
	Wed, 05 Nov 2025 16:08:13 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next] wifi: mac80211: pass frame type to element parsing
Date: Wed,  5 Nov 2025 16:08:10 +0100
Message-ID: <20251105160810.a476d20a6e01.Ie659535f9357f2f9a3c73f8c059ccfc96bf93b54@changeid>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This will be needed for UHR operation parsing, and we
already pass whether or not the frame is an action
frame, replace that by the full type. Note this fixes
a few cases where 'false' was erroneously passed (mesh
and TDLS) and removes ieee802_11_parse_elems_crc() as
it's unused.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/ieee80211.h  |  1 +
 net/mac80211/agg-rx.c      |  7 ++++--
 net/mac80211/ibss.c        | 14 +++++++-----
 net/mac80211/ieee80211_i.h | 21 +++++-------------
 net/mac80211/mesh.c        | 26 +++++++++++++---------
 net/mac80211/mesh_hwmp.c   |  7 ++++--
 net/mac80211/mesh_plink.c  |  7 ++++--
 net/mac80211/mlme.c        | 45 ++++++++++++++++++++++++++++----------
 net/mac80211/parse.c       | 30 ++++++++++++++++++++-----
 net/mac80211/scan.c        |  6 ++++-
 net/mac80211/tdls.c        | 12 +++++++---
 net/mac80211/tests/elems.c |  4 +++-
 12 files changed, 123 insertions(+), 57 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index ddff9102f633..2d8f7d719976 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -43,6 +43,7 @@
 #define IEEE80211_FCTL_VERS		0x0003
 #define IEEE80211_FCTL_FTYPE		0x000c
 #define IEEE80211_FCTL_STYPE		0x00f0
+#define IEEE80211_FCTL_TYPE		(IEEE80211_FCTL_FTYPE | IEEE80211_FCTL_STYPE)
 #define IEEE80211_FCTL_TODS		0x0100
 #define IEEE80211_FCTL_FROMDS		0x0200
 #define IEEE80211_FCTL_MOREFRAGS	0x0400
diff --git a/net/mac80211/agg-rx.c b/net/mac80211/agg-rx.c
index e38f46ffebfa..7da909d78c68 100644
--- a/net/mac80211/agg-rx.c
+++ b/net/mac80211/agg-rx.c
@@ -9,7 +9,7 @@
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2007-2010, Intel Corporation
  * Copyright(c) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2024 Intel Corporation
+ * Copyright (C) 2018-2025 Intel Corporation
  */
 
 /**
@@ -206,7 +206,10 @@ u8 ieee80211_retrieve_addba_ext_data(struct sta_info *sta,
 	if (elem_len <= 0)
 		return 0;
 
-	elems = ieee802_11_parse_elems(elem_data, elem_len, true, NULL);
+	elems = ieee802_11_parse_elems(elem_data, elem_len,
+				       IEEE80211_FTYPE_MGMT |
+				       IEEE80211_STYPE_ACTION,
+				       NULL);
 
 	if (!elems || elems->parse_error || !elems->addba_ext_ie)
 		goto free;
diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index 6e36b09fe97f..168f84a1353b 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -9,7 +9,7 @@
  * Copyright 2009, Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright(c) 2016 Intel Deutschland GmbH
- * Copyright(c) 2018-2024 Intel Corporation
+ * Copyright(c) 2018-2025 Intel Corporation
  */
 
 #include <linux/delay.h>
@@ -1554,6 +1554,7 @@ void ieee80211_rx_mgmt_probe_beacon(struct ieee80211_sub_if_data *sdata,
 {
 	size_t baselen;
 	struct ieee802_11_elems *elems;
+	u16 type;
 
 	BUILD_BUG_ON(offsetof(typeof(mgmt->u.probe_resp), variable) !=
 		     offsetof(typeof(mgmt->u.beacon), variable));
@@ -1566,8 +1567,9 @@ void ieee80211_rx_mgmt_probe_beacon(struct ieee80211_sub_if_data *sdata,
 	if (baselen > len)
 		return;
 
+	type = le16_to_cpu(mgmt->frame_control) & IEEE80211_FCTL_TYPE;
 	elems = ieee802_11_parse_elems(mgmt->u.probe_resp.variable,
-				       len - baselen, false, NULL);
+				       len - baselen, type, NULL);
 
 	if (elems) {
 		ieee80211_rx_bss_info(sdata, mgmt, len, rx_status, elems);
@@ -1616,9 +1618,11 @@ void ieee80211_ibss_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
 			if (ies_len < 0)
 				break;
 
-			elems = ieee802_11_parse_elems(
-				mgmt->u.action.u.chan_switch.variable,
-				ies_len, true, NULL);
+			elems = ieee802_11_parse_elems(mgmt->u.action.u.chan_switch.variable,
+						       ies_len,
+						       IEEE80211_FTYPE_MGMT |
+						       IEEE80211_STYPE_ACTION,
+						       NULL);
 
 			if (elems && !elems->parse_error)
 				ieee80211_rx_mgmt_spectrum_mgmt(sdata, mgmt,
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 73fd86ec1bce..b63ef61f6278 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2422,7 +2422,8 @@ static inline void ieee80211_tx_skb(struct ieee80211_sub_if_data *sdata,
  * @mode: connection mode for parsing
  * @start: pointer to the elements
  * @len: length of the elements
- * @action: %true if the elements came from an action frame
+ * @type: type of the frame the elements came from
+ *	(action, probe response, beacon, etc.)
  * @filter: bitmap of element IDs to filter out while calculating
  *	the element CRC
  * @crc: CRC starting value
@@ -2440,7 +2441,7 @@ struct ieee80211_elems_parse_params {
 	enum ieee80211_conn_mode mode;
 	const u8 *start;
 	size_t len;
-	bool action;
+	u8 type;
 	u64 filter;
 	u32 crc;
 	struct cfg80211_bss *bss;
@@ -2452,17 +2453,14 @@ struct ieee802_11_elems *
 ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params);
 
 static inline struct ieee802_11_elems *
-ieee802_11_parse_elems_crc(const u8 *start, size_t len, bool action,
-			   u64 filter, u32 crc,
-			   struct cfg80211_bss *bss)
+ieee802_11_parse_elems(const u8 *start, size_t len, u8 type,
+		       struct cfg80211_bss *bss)
 {
 	struct ieee80211_elems_parse_params params = {
 		.mode = IEEE80211_CONN_MODE_HIGHEST,
 		.start = start,
 		.len = len,
-		.action = action,
-		.filter = filter,
-		.crc = crc,
+		.type = type,
 		.bss = bss,
 		.link_id = -1,
 	};
@@ -2470,13 +2468,6 @@ ieee802_11_parse_elems_crc(const u8 *start, size_t len, bool action,
 	return ieee802_11_parse_elems_full(&params);
 }
 
-static inline struct ieee802_11_elems *
-ieee802_11_parse_elems(const u8 *start, size_t len, bool action,
-		       struct cfg80211_bss *bss)
-{
-	return ieee802_11_parse_elems_crc(start, len, action, 0, 0, bss);
-}
-
 extern const int ieee802_1d_to_ac[8];
 
 static inline int ieee80211_ac_from_tid(int tid)
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index f37068a533f4..68901f1def0d 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2008, 2009 open80211s Ltd.
- * Copyright (C) 2018 - 2024 Intel Corporation
+ * Copyright (C) 2018 - 2025 Intel Corporation
  * Authors:    Luis Carlos Cobo <luisca@cozybit.com>
  * 	       Javier Cardona <javier@cozybit.com>
  */
@@ -1410,7 +1410,10 @@ ieee80211_mesh_rx_probe_req(struct ieee80211_sub_if_data *sdata,
 	if (baselen > len)
 		return;
 
-	elems = ieee802_11_parse_elems(pos, len - baselen, false, NULL);
+	elems = ieee802_11_parse_elems(pos, len - baselen,
+				       IEEE80211_FTYPE_MGMT |
+				       IEEE80211_STYPE_PROBE_REQ,
+				       NULL);
 	if (!elems)
 		return;
 
@@ -1455,11 +1458,11 @@ ieee80211_mesh_rx_probe_req(struct ieee80211_sub_if_data *sdata,
 }
 
 static void ieee80211_mesh_rx_bcn_presp(struct ieee80211_sub_if_data *sdata,
-					u16 stype,
 					struct ieee80211_mgmt *mgmt,
 					size_t len,
 					struct ieee80211_rx_status *rx_status)
 {
+	u16 type = le16_to_cpu(mgmt->frame_control) & IEEE80211_FCTL_TYPE;
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_if_mesh *ifmsh = &sdata->u.mesh;
 	struct ieee802_11_elems *elems;
@@ -1469,7 +1472,7 @@ static void ieee80211_mesh_rx_bcn_presp(struct ieee80211_sub_if_data *sdata,
 	enum nl80211_band band = rx_status->band;
 
 	/* ignore ProbeResp to foreign address */
-	if (stype == IEEE80211_STYPE_PROBE_RESP &&
+	if (type == (IEEE80211_FTYPE_MGMT | IEEE80211_STYPE_PROBE_RESP) &&
 	    !ether_addr_equal(mgmt->da, sdata->vif.addr))
 		return;
 
@@ -1478,8 +1481,7 @@ static void ieee80211_mesh_rx_bcn_presp(struct ieee80211_sub_if_data *sdata,
 		return;
 
 	elems = ieee802_11_parse_elems(mgmt->u.probe_resp.variable,
-				       len - baselen,
-				       false, NULL);
+				       len - baselen, type, NULL);
 	if (!elems)
 		return;
 
@@ -1514,7 +1516,9 @@ static void ieee80211_mesh_rx_bcn_presp(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (ifmsh->sync_ops)
-		ifmsh->sync_ops->rx_bcn_presp(sdata, stype, mgmt, len,
+		ifmsh->sync_ops->rx_bcn_presp(sdata,
+					      type & IEEE80211_FCTL_STYPE,
+					      mgmt, len,
 					      elems->mesh_config, rx_status);
 free:
 	kfree(elems);
@@ -1622,7 +1626,10 @@ static void mesh_rx_csa_frame(struct ieee80211_sub_if_data *sdata,
 	pos = mgmt->u.action.u.chan_switch.variable;
 	baselen = offsetof(struct ieee80211_mgmt,
 			   u.action.u.chan_switch.variable);
-	elems = ieee802_11_parse_elems(pos, len - baselen, true, NULL);
+	elems = ieee802_11_parse_elems(pos, len - baselen,
+				       IEEE80211_FTYPE_MGMT |
+				       IEEE80211_STYPE_ACTION,
+				       NULL);
 	if (!elems)
 		return;
 
@@ -1699,8 +1706,7 @@ void ieee80211_mesh_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
 	switch (stype) {
 	case IEEE80211_STYPE_PROBE_RESP:
 	case IEEE80211_STYPE_BEACON:
-		ieee80211_mesh_rx_bcn_presp(sdata, stype, mgmt, skb->len,
-					    rx_status);
+		ieee80211_mesh_rx_bcn_presp(sdata, mgmt, skb->len, rx_status);
 		break;
 	case IEEE80211_STYPE_PROBE_REQ:
 		ieee80211_mesh_rx_probe_req(sdata, mgmt, skb->len);
diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index 9101858525dd..a41b57bd11ff 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2008, 2009 open80211s Ltd.
- * Copyright (C) 2019, 2021-2023 Intel Corporation
+ * Copyright (C) 2019, 2021-2023, 2025 Intel Corporation
  * Author:     Luis Carlos Cobo <luisca@cozybit.com>
  */
 
@@ -951,7 +951,10 @@ void mesh_rx_path_sel_frame(struct ieee80211_sub_if_data *sdata,
 
 	baselen = (u8 *) mgmt->u.action.u.mesh_action.variable - (u8 *) mgmt;
 	elems = ieee802_11_parse_elems(mgmt->u.action.u.mesh_action.variable,
-				       len - baselen, false, NULL);
+				       len - baselen,
+				       IEEE80211_FTYPE_MGMT |
+				       IEEE80211_STYPE_ACTION,
+				       NULL);
 	if (!elems)
 		return;
 
diff --git a/net/mac80211/mesh_plink.c b/net/mac80211/mesh_plink.c
index cb45a5d2009d..04c931cd2063 100644
--- a/net/mac80211/mesh_plink.c
+++ b/net/mac80211/mesh_plink.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2008, 2009 open80211s Ltd.
- * Copyright (C) 2019, 2021-2024 Intel Corporation
+ * Copyright (C) 2019, 2021-2025 Intel Corporation
  * Author:     Luis Carlos Cobo <luisca@cozybit.com>
  */
 #include <linux/gfp.h>
@@ -1248,7 +1248,10 @@ void mesh_rx_plink_frame(struct ieee80211_sub_if_data *sdata,
 		if (baselen > len)
 			return;
 	}
-	elems = ieee802_11_parse_elems(baseaddr, len - baselen, true, NULL);
+	elems = ieee802_11_parse_elems(baseaddr, len - baselen,
+				       IEEE80211_FTYPE_MGMT |
+				       IEEE80211_STYPE_ACTION,
+				       NULL);
 	if (elems) {
 		mesh_process_plink_frame(sdata, mgmt, elems, rx_status);
 		kfree(elems);
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 025210d50405..21562decb694 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1002,6 +1002,9 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 		.from_ap = true,
 		.start = ies->data,
 		.len = ies->len,
+		.type = ies->from_beacon ?
+			IEEE80211_FTYPE_MGMT | IEEE80211_STYPE_BEACON :
+			IEEE80211_FTYPE_MGMT | IEEE80211_STYPE_PROBE_RESP,
 	};
 	struct ieee802_11_elems *elems;
 	struct ieee80211_supported_band *sband;
@@ -5180,7 +5183,9 @@ static void ieee80211_epcs_teardown(struct ieee80211_sub_if_data *sdata)
 			continue;
 		}
 
-		elems = ieee802_11_parse_elems(ies->data, ies->len, false,
+		elems = ieee802_11_parse_elems(ies->data, ies->len,
+					       IEEE80211_FTYPE_MGMT |
+					       IEEE80211_STYPE_BEACON,
 					       NULL);
 		if (!elems) {
 			rcu_read_unlock();
@@ -5226,6 +5231,7 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 		.len = elem_len,
 		.link_id = link_id == assoc_data->assoc_link_id ? -1 : link_id,
 		.from_ap = true,
+		.type = le16_to_cpu(mgmt->frame_control) & IEEE80211_FCTL_TYPE,
 	};
 	bool is_5ghz = cbss->channel->band == NL80211_BAND_5GHZ;
 	bool is_6ghz = cbss->channel->band == NL80211_BAND_6GHZ;
@@ -6359,6 +6365,7 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 		.bss = NULL,
 		.link_id = -1,
 		.from_ap = true,
+		.type = le16_to_cpu(mgmt->frame_control) & IEEE80211_FCTL_TYPE,
 	};
 	struct ieee802_11_elems *elems;
 	int ac;
@@ -7267,7 +7274,9 @@ ieee80211_mgd_check_cross_link_csa(struct ieee80211_sub_if_data *sdata,
 						    (prof->sta_info_len - 1),
 						    len -
 						    (prof->sta_info_len - 1),
-						    false, NULL);
+						    IEEE80211_FTYPE_MGMT |
+						    IEEE80211_STYPE_BEACON,
+						    NULL);
 
 		/* memory allocation failed - let's hope that's transient */
 		if (!prof_elems)
@@ -7371,6 +7380,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 		.mode = link->u.mgd.conn.mode,
 		.link_id = -1,
 		.from_ap = true,
+		.type = le16_to_cpu(mgmt->frame_control) & IEEE80211_FCTL_TYPE,
 	};
 
 	lockdep_assert_wiphy(local->hw.wiphy);
@@ -7973,7 +7983,10 @@ void ieee80211_process_neg_ttlm_req(struct ieee80211_sub_if_data *sdata,
 	ies_len  = len - offsetof(struct ieee80211_mgmt,
 				  u.action.u.ttlm_req.variable);
 	elems = ieee802_11_parse_elems(mgmt->u.action.u.ttlm_req.variable,
-				       ies_len, true, NULL);
+				       ies_len,
+				       IEEE80211_FTYPE_MGMT |
+				       IEEE80211_STYPE_ACTION,
+				       NULL);
 	if (!elems) {
 		ttlm_res = NEG_TTLM_RES_REJECT;
 		goto out;
@@ -8179,9 +8192,11 @@ void ieee80211_sta_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
 				break;
 
 			/* CSA IE cannot be overridden, no need for BSSID */
-			elems = ieee802_11_parse_elems(
-					mgmt->u.action.u.chan_switch.variable,
-					ies_len, true, NULL);
+			elems = ieee802_11_parse_elems(mgmt->u.action.u.chan_switch.variable,
+						       ies_len,
+						       IEEE80211_FTYPE_MGMT |
+						       IEEE80211_STYPE_ACTION,
+						       NULL);
 
 			if (elems && !elems->parse_error) {
 				enum ieee80211_csa_source src =
@@ -8208,9 +8223,11 @@ void ieee80211_sta_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
 			 * extended CSA IE can't be overridden, no need for
 			 * BSSID
 			 */
-			elems = ieee802_11_parse_elems(
-					mgmt->u.action.u.ext_chan_switch.variable,
-					ies_len, true, NULL);
+			elems = ieee802_11_parse_elems(mgmt->u.action.u.ext_chan_switch.variable,
+						       ies_len,
+						       IEEE80211_FTYPE_MGMT |
+						       IEEE80211_STYPE_ACTION,
+						       NULL);
 
 			if (elems && !elems->parse_error) {
 				enum ieee80211_csa_source src;
@@ -10988,7 +11005,10 @@ static void ieee80211_ml_epcs(struct ieee80211_sub_if_data *sdata,
 		pos = scratch + sizeof(control);
 		len -= sizeof(control);
 
-		link_elems = ieee802_11_parse_elems(pos, len, false, NULL);
+		link_elems = ieee802_11_parse_elems(pos, len,
+						    IEEE80211_FTYPE_MGMT |
+						    IEEE80211_STYPE_ACTION,
+						    NULL);
 		if (!link_elems)
 			continue;
 
@@ -11039,7 +11059,10 @@ void ieee80211_process_epcs_ena_resp(struct ieee80211_sub_if_data *sdata,
 				 u.action.u.epcs.variable) -
 		IEEE80211_EPCS_ENA_RESP_BODY_LEN;
 
-	elems = ieee802_11_parse_elems(pos, ies_len, true, NULL);
+	elems = ieee802_11_parse_elems(pos, ies_len,
+				       IEEE80211_FTYPE_MGMT |
+				       IEEE80211_STYPE_ACTION,
+				       NULL);
 	if (!elems)
 		return;
 
diff --git a/net/mac80211/parse.c b/net/mac80211/parse.c
index c5e0f7f46004..bfc4ecb7a048 100644
--- a/net/mac80211/parse.c
+++ b/net/mac80211/parse.c
@@ -6,7 +6,7 @@
  * Copyright 2007	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017	Intel Deutschland GmbH
- * Copyright (C) 2018-2024 Intel Corporation
+ * Copyright (C) 2018-2025 Intel Corporation
  *
  * element parsing for mac80211
  */
@@ -286,6 +286,24 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 
 	bitmap_zero(seen_elems, 256);
 
+	switch (params->type) {
+	/* we don't need to parse assoc request, luckily (it's value 0) */
+	case IEEE80211_FTYPE_MGMT | IEEE80211_STYPE_ASSOC_REQ:
+	case IEEE80211_FTYPE_MGMT | IEEE80211_STYPE_REASSOC_REQ:
+	default:
+		WARN(1, "invalid frame type 0x%x for element parsing\n",
+		     params->type);
+		break;
+	case IEEE80211_FTYPE_MGMT | IEEE80211_STYPE_ASSOC_RESP:
+	case IEEE80211_FTYPE_MGMT | IEEE80211_STYPE_REASSOC_RESP:
+	case IEEE80211_FTYPE_MGMT | IEEE80211_STYPE_PROBE_REQ:
+	case IEEE80211_FTYPE_MGMT | IEEE80211_STYPE_PROBE_RESP:
+	case IEEE80211_FTYPE_MGMT | IEEE80211_STYPE_BEACON:
+	case IEEE80211_FTYPE_MGMT | IEEE80211_STYPE_ACTION:
+	case IEEE80211_FTYPE_EXT | IEEE80211_STYPE_S1G_BEACON:
+		break;
+	}
+
 	for_each_element(elem, params->start, params->len) {
 		const struct element *subelem;
 		u8 elem_parse_failed;
@@ -566,7 +584,8 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 			if (params->mode < IEEE80211_CONN_MODE_VHT)
 				break;
 
-			if (!params->action) {
+			if (params->type != (IEEE80211_FTYPE_MGMT |
+					     IEEE80211_STYPE_ACTION)) {
 				elem_parse_failed =
 					IEEE80211_PARSE_ERR_UNEXPECTED_ELEM;
 				break;
@@ -582,7 +601,8 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 		case WLAN_EID_CHANNEL_SWITCH_WRAPPER:
 			if (params->mode < IEEE80211_CONN_MODE_VHT)
 				break;
-			if (params->action) {
+			if (params->type == (IEEE80211_FTYPE_MGMT |
+					     IEEE80211_STYPE_ACTION)) {
 				elem_parse_failed =
 					IEEE80211_PARSE_ERR_UNEXPECTED_ELEM;
 				break;
@@ -942,7 +962,7 @@ ieee80211_prep_mle_link_parse(struct ieee80211_elems_parse *elems_parse,
 	sub->len = end - sub->start;
 
 	sub->mode = params->mode;
-	sub->action = params->action;
+	sub->type = params->type;
 	sub->from_ap = params->from_ap;
 	sub->link_id = -1;
 
@@ -1041,7 +1061,7 @@ ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params)
 		sub.start = elems_parse->scratch_pos;
 		sub.mode = params->mode;
 		sub.len = nontx_len;
-		sub.action = params->action;
+		sub.type = params->type;
 		sub.link_id = params->link_id;
 
 		/* consume the space used for non-transmitted profile */
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index bb9563f50e7b..5ef315ed3b0f 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -76,7 +76,11 @@ void ieee80211_inform_bss(struct wiphy *wiphy,
 	if (!update_data)
 		return;
 
-	elems = ieee802_11_parse_elems(ies->data, ies->len, false, NULL);
+	elems = ieee802_11_parse_elems(ies->data, ies->len,
+				       update_data->beacon ?
+					IEEE80211_FTYPE_MGMT | IEEE80211_STYPE_BEACON :
+					IEEE80211_FTYPE_MGMT | IEEE80211_STYPE_PROBE_RESP,
+				       NULL);
 	if (!elems)
 		return;
 
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index ba5fbacbeeda..dbbfe2d6842f 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -6,7 +6,7 @@
  * Copyright 2014, Intel Corporation
  * Copyright 2014  Intel Mobile Communications GmbH
  * Copyright 2015 - 2016 Intel Deutschland GmbH
- * Copyright (C) 2019, 2021-2024 Intel Corporation
+ * Copyright (C) 2019, 2021-2025 Intel Corporation
  */
 
 #include <linux/ieee80211.h>
@@ -1783,7 +1783,10 @@ ieee80211_process_tdls_channel_switch_resp(struct ieee80211_sub_if_data *sdata,
 	}
 
 	elems = ieee802_11_parse_elems(tf->u.chan_switch_resp.variable,
-				       skb->len - baselen, false, NULL);
+				       skb->len - baselen,
+				       IEEE80211_FTYPE_MGMT |
+				       IEEE80211_STYPE_ACTION,
+				       NULL);
 	if (!elems) {
 		ret = -ENOMEM;
 		goto out;
@@ -1902,7 +1905,10 @@ ieee80211_process_tdls_channel_switch_req(struct ieee80211_sub_if_data *sdata,
 	}
 
 	elems = ieee802_11_parse_elems(tf->u.chan_switch_req.variable,
-				       skb->len - baselen, false, NULL);
+				       skb->len - baselen,
+				       IEEE80211_FTYPE_MGMT |
+				       IEEE80211_STYPE_ACTION,
+				       NULL);
 	if (!elems)
 		return -ENOMEM;
 
diff --git a/net/mac80211/tests/elems.c b/net/mac80211/tests/elems.c
index a53c55a879a8..1039794a0183 100644
--- a/net/mac80211/tests/elems.c
+++ b/net/mac80211/tests/elems.c
@@ -2,7 +2,7 @@
 /*
  * KUnit tests for element parsing
  *
- * Copyright (C) 2023-2024 Intel Corporation
+ * Copyright (C) 2023-2025 Intel Corporation
  */
 #include <kunit/test.h>
 #include "../ieee80211_i.h"
@@ -15,6 +15,8 @@ static void mle_defrag(struct kunit *test)
 		.link_id = 12,
 		.from_ap = true,
 		.mode = IEEE80211_CONN_MODE_EHT,
+		/* type is not really relevant here */
+		.type = IEEE80211_FTYPE_MGMT | IEEE80211_STYPE_BEACON,
 	};
 	struct ieee802_11_elems *parsed;
 	struct sk_buff *skb;
-- 
2.51.1


