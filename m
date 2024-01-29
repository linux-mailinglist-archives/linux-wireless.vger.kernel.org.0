Return-Path: <linux-wireless+bounces-2707-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 570EE84130F
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 20:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3799B22D05
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7F531755;
	Mon, 29 Jan 2024 19:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Rf2eaeza"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8C22E834
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 19:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706555223; cv=none; b=ay/VQ0PRirM4Pnrhkom4AJTt/9VdXSBzxMY5i4vNMeb6JFMv2po30VCJ/N0moWU1nIHtMMvdOpw/eN0xD9XtHsSIFxfksNr4HOf+LcVeVOy5apEnM6y/ls1Y+0SX7KBLF0eHZaF+erZxEQdWzHCEDyPDOjS2lU1TvF18/Sihjiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706555223; c=relaxed/simple;
	bh=pstjkDVbSxskXNtGxSwffKgVnSa0R5688CDVHSiCEps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E1F6ECtD9YR+zhJ2p64WaXawTW528JwPRU8Cf7GYmxIcWmsmEQymPM+LuwRTr0VFUc62OtxNZSjWO7gI67BuXN6MLjYJt+9YSSd7ysZz7ABmk7Cm+tIwq12foW+hxtavIE2Ye0ZJZKkXhcha2Yiu3Gvke3ekGIs9GvrjsOrQ7Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Rf2eaeza; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=rM5ZHmuhlopd0sW0+mLQZLZQPgDha6LchEbAHQGtQWI=; t=1706555221; x=1707764821; 
	b=Rf2eaezaurEkFLkWTA6Hcsg7u369enzwhs1J5dXMb+aSjfhxzPIkJPUte/3bCC43T2Nhc7wmJ3y
	UMEi74IK+aJ4RsWUvxD4P86X98HxZi/sC86npVhttgW9ylGsQLOD3a9X3JDuMuTH/bJALP0FhVvh4
	+b+9HbiLvc9x3XaZqkmKBpEIMVSCnOpxeCX+tUU4Kgq/YFO6Qq7FYF17pJWL2qGnEb68ZltL50zEc
	Dv4Hgz/fi0kQHSsT3zjJ/XE7hQ6qxgxh+W3ZMLt2TVm4oNgDTq4dfbj3ZPwDWnIAScKGpnctAvoUu
	bq9yjcxp95LwZf3tSbXOdL4iIkYul2SglNVg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUWy8-000000050B1-37Wb;
	Mon, 29 Jan 2024 20:06:57 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/2] wifi: mac80211: disambiguate element parsing errors
Date: Mon, 29 Jan 2024 20:06:53 +0100
Message-ID: <20240129200652.1a69f2a31ec7.I55b86561d64e7ef1504c73f6f2813c33030c8136@changeid>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Let the element parsing function return what kind of error
was encountered, as a bitmap, even if nothing currently
checks for which specific error it was, we'll use it later.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h |  11 +++-
 net/mac80211/util.c        | 108 ++++++++++++++++++++++++-------------
 2 files changed, 81 insertions(+), 38 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 46b517cf47ea..f5fe659a1efd 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1666,6 +1666,13 @@ struct ieee80211_csa_ie {
 	u32 max_switch_time;
 };
 
+enum ieee80211_elems_parse_error {
+	IEEE80211_PARSE_ERR_INVALID_END		= BIT(0),
+	IEEE80211_PARSE_ERR_DUP_ELEM		= BIT(1),
+	IEEE80211_PARSE_ERR_BAD_ELEM_SIZE	= BIT(2),
+	IEEE80211_PARSE_ERR_UNEXPECTED_ELEM	= BIT(3),
+};
+
 /* Parsed Information Elements */
 struct ieee802_11_elems {
 	const u8 *ie_start;
@@ -1776,8 +1783,8 @@ struct ieee802_11_elems {
 	struct ieee80211_mle_per_sta_profile *prof;
 	size_t sta_prof_len;
 
-	/* whether a parse error occurred while retrieving these elements */
-	bool parse_error;
+	/* whether/which parse error occurred while retrieving these elements */
+	u8 parse_error;
 
 	/*
 	 * scratch buffer that can be used for various element parsing related
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 5108dbaa9360..c1fa762f0cba 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1063,7 +1063,7 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 
 	for_each_element(elem, params->start, params->len) {
 		const struct element *subelem;
-		bool elem_parse_failed;
+		u8 elem_parse_failed;
 		u8 id = elem->id;
 		u8 elen = elem->datalen;
 		const u8 *pos = elem->data;
@@ -1119,7 +1119,8 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 		 * that if the content gets bigger it might be needed more than once
 		 */
 			if (test_bit(id, seen_elems)) {
-				elems->parse_error = true;
+				elems->parse_error |=
+					IEEE80211_PARSE_ERR_DUP_ELEM;
 				continue;
 			}
 			break;
@@ -1128,19 +1129,21 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 		if (calc_crc && id < 64 && (params->filter & (1ULL << id)))
 			crc = crc32_be(crc, pos - 2, elen + 2);
 
-		elem_parse_failed = false;
+		elem_parse_failed = 0;
 
 		switch (id) {
 		case WLAN_EID_LINK_ID:
 			if (elen + 2 < sizeof(struct ieee80211_tdls_lnkie)) {
-				elem_parse_failed = true;
+				elem_parse_failed =
+					IEEE80211_PARSE_ERR_BAD_ELEM_SIZE;
 				break;
 			}
 			elems->lnk_id = (void *)(pos - 2);
 			break;
 		case WLAN_EID_CHAN_SWITCH_TIMING:
 			if (elen < sizeof(struct ieee80211_ch_switch_timing)) {
-				elem_parse_failed = true;
+				elem_parse_failed =
+					IEEE80211_PARSE_ERR_BAD_ELEM_SIZE;
 				break;
 			}
 			elems->ch_sw_timing = (void *)pos;
@@ -1161,14 +1164,16 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 			if (elen >= 1)
 				elems->ds_params = pos;
 			else
-				elem_parse_failed = true;
+				elem_parse_failed =
+					IEEE80211_PARSE_ERR_BAD_ELEM_SIZE;
 			break;
 		case WLAN_EID_TIM:
 			if (elen >= sizeof(struct ieee80211_tim_ie)) {
 				elems->tim = (void *)pos;
 				elems->tim_len = elen;
 			} else
-				elem_parse_failed = true;
+				elem_parse_failed =
+					IEEE80211_PARSE_ERR_BAD_ELEM_SIZE;
 			break;
 		case WLAN_EID_VENDOR_SPECIFIC:
 			if (elen >= 4 && pos[0] == 0x00 && pos[1] == 0x50 &&
@@ -1198,7 +1203,8 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 			if (elen >= 1)
 				elems->erp_info = pos;
 			else
-				elem_parse_failed = true;
+				elem_parse_failed =
+					IEEE80211_PARSE_ERR_BAD_ELEM_SIZE;
 			break;
 		case WLAN_EID_EXT_SUPP_RATES:
 			elems->ext_supp_rates = pos;
@@ -1210,7 +1216,8 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 			if (elen >= sizeof(struct ieee80211_ht_cap))
 				elems->ht_cap_elem = (void *)pos;
 			else
-				elem_parse_failed = true;
+				elem_parse_failed =
+					IEEE80211_PARSE_ERR_BAD_ELEM_SIZE;
 			break;
 		case WLAN_EID_HT_OPERATION:
 			if (params->mode < IEEE80211_CONN_MODE_HT)
@@ -1218,7 +1225,8 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 			if (elen >= sizeof(struct ieee80211_ht_operation))
 				elems->ht_operation = (void *)pos;
 			else
-				elem_parse_failed = true;
+				elem_parse_failed =
+					IEEE80211_PARSE_ERR_BAD_ELEM_SIZE;
 			break;
 		case WLAN_EID_VHT_CAPABILITY:
 			if (params->mode < IEEE80211_CONN_MODE_VHT)
@@ -1226,7 +1234,8 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 			if (elen >= sizeof(struct ieee80211_vht_cap))
 				elems->vht_cap_elem = (void *)pos;
 			else
-				elem_parse_failed = true;
+				elem_parse_failed =
+					IEEE80211_PARSE_ERR_BAD_ELEM_SIZE;
 			break;
 		case WLAN_EID_VHT_OPERATION:
 			if (params->mode < IEEE80211_CONN_MODE_VHT)
@@ -1237,7 +1246,8 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 					crc = crc32_be(crc, pos - 2, elen + 2);
 				break;
 			}
-			elem_parse_failed = true;
+			elem_parse_failed =
+				IEEE80211_PARSE_ERR_BAD_ELEM_SIZE;
 			break;
 		case WLAN_EID_OPMODE_NOTIF:
 			if (params->mode < IEEE80211_CONN_MODE_VHT)
@@ -1248,7 +1258,8 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 					crc = crc32_be(crc, pos - 2, elen + 2);
 				break;
 			}
-			elem_parse_failed = true;
+			elem_parse_failed =
+				IEEE80211_PARSE_ERR_BAD_ELEM_SIZE;
 			break;
 		case WLAN_EID_MESH_ID:
 			elems->mesh_id = pos;
@@ -1258,7 +1269,8 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 			if (elen >= sizeof(struct ieee80211_meshconf_ie))
 				elems->mesh_config = (void *)pos;
 			else
-				elem_parse_failed = true;
+				elem_parse_failed =
+					IEEE80211_PARSE_ERR_BAD_ELEM_SIZE;
 			break;
 		case WLAN_EID_PEER_MGMT:
 			elems->peering = pos;
@@ -1284,18 +1296,21 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 			if (elen >= sizeof(struct ieee80211_rann_ie))
 				elems->rann = (void *)pos;
 			else
-				elem_parse_failed = true;
+				elem_parse_failed =
+					IEEE80211_PARSE_ERR_BAD_ELEM_SIZE;
 			break;
 		case WLAN_EID_CHANNEL_SWITCH:
 			if (elen != sizeof(struct ieee80211_channel_sw_ie)) {
-				elem_parse_failed = true;
+				elem_parse_failed =
+					IEEE80211_PARSE_ERR_BAD_ELEM_SIZE;
 				break;
 			}
 			elems->ch_switch_ie = (void *)pos;
 			break;
 		case WLAN_EID_EXT_CHANSWITCH_ANN:
 			if (elen != sizeof(struct ieee80211_ext_chansw_ie)) {
-				elem_parse_failed = true;
+				elem_parse_failed =
+					IEEE80211_PARSE_ERR_BAD_ELEM_SIZE;
 				break;
 			}
 			elems->ext_chansw_ie = (void *)pos;
@@ -1304,7 +1319,8 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 			if (params->mode < IEEE80211_CONN_MODE_HT)
 				break;
 			if (elen != sizeof(struct ieee80211_sec_chan_offs_ie)) {
-				elem_parse_failed = true;
+				elem_parse_failed =
+					IEEE80211_PARSE_ERR_BAD_ELEM_SIZE;
 				break;
 			}
 			elems->sec_chan_offs = (void *)pos;
@@ -1312,7 +1328,8 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 		case WLAN_EID_CHAN_SWITCH_PARAM:
 			if (elen <
 			    sizeof(*elems->mesh_chansw_params_ie)) {
-				elem_parse_failed = true;
+				elem_parse_failed =
+					IEEE80211_PARSE_ERR_BAD_ELEM_SIZE;
 				break;
 			}
 			elems->mesh_chansw_params_ie = (void *)pos;
@@ -1320,9 +1337,16 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 		case WLAN_EID_WIDE_BW_CHANNEL_SWITCH:
 			if (params->mode < IEEE80211_CONN_MODE_VHT)
 				break;
-			if (!params->action ||
-			    elen < sizeof(*elems->wide_bw_chansw_ie)) {
-				elem_parse_failed = true;
+
+			if (!params->action) {
+				elem_parse_failed =
+					IEEE80211_PARSE_ERR_UNEXPECTED_ELEM;
+				break;
+			}
+
+			if (elen < sizeof(*elems->wide_bw_chansw_ie)) {
+				elem_parse_failed =
+					IEEE80211_PARSE_ERR_BAD_ELEM_SIZE;
 				break;
 			}
 			elems->wide_bw_chansw_ie = (void *)pos;
@@ -1331,7 +1355,8 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 			if (params->mode < IEEE80211_CONN_MODE_VHT)
 				break;
 			if (params->action) {
-				elem_parse_failed = true;
+				elem_parse_failed =
+					IEEE80211_PARSE_ERR_UNEXPECTED_ELEM;
 				break;
 			}
 			/*
@@ -1345,7 +1370,8 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 					elems->wide_bw_chansw_ie =
 						(void *)subelem->data;
 				else
-					elem_parse_failed = true;
+					elem_parse_failed =
+						IEEE80211_PARSE_ERR_BAD_ELEM_SIZE;
 			}
 
 			if (params->mode < IEEE80211_CONN_MODE_EHT)
@@ -1361,7 +1387,8 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 									   edatalen))
 					elems->bandwidth_indication = edata;
 				else
-					elem_parse_failed = true;
+					elem_parse_failed =
+						IEEE80211_PARSE_ERR_BAD_ELEM_SIZE;
 			}
 			break;
 		case WLAN_EID_COUNTRY:
@@ -1370,7 +1397,8 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 			break;
 		case WLAN_EID_PWR_CONSTRAINT:
 			if (elen != 1) {
-				elem_parse_failed = true;
+				elem_parse_failed =
+					IEEE80211_PARSE_ERR_BAD_ELEM_SIZE;
 				break;
 			}
 			elems->pwr_constr_elem = pos;
@@ -1382,7 +1410,8 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 			 * tag (0x00).
 			 */
 			if (elen < 4) {
-				elem_parse_failed = true;
+				elem_parse_failed =
+					IEEE80211_PARSE_ERR_BAD_ELEM_SIZE;
 				break;
 			}
 
@@ -1391,7 +1420,8 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 				break;
 
 			if (elen != 6) {
-				elem_parse_failed = true;
+				elem_parse_failed =
+					IEEE80211_PARSE_ERR_BAD_ELEM_SIZE;
 				break;
 			}
 
@@ -1402,7 +1432,8 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 			break;
 		case WLAN_EID_ADDBA_EXT:
 			if (elen < sizeof(struct ieee80211_addba_ext_ie)) {
-				elem_parse_failed = true;
+				elem_parse_failed =
+					IEEE80211_PARSE_ERR_BAD_ELEM_SIZE;
 				break;
 			}
 			elems->addba_ext_ie = (void *)pos;
@@ -1411,7 +1442,8 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 			if (elen >= sizeof(struct ieee80211_timeout_interval_ie))
 				elems->timeout_int = (void *)pos;
 			else
-				elem_parse_failed = true;
+				elem_parse_failed =
+					IEEE80211_PARSE_ERR_BAD_ELEM_SIZE;
 			break;
 		case WLAN_EID_BSS_MAX_IDLE_PERIOD:
 			if (elen >= sizeof(*elems->max_idle_period_ie))
@@ -1444,7 +1476,8 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 			if (elen >= sizeof(*elems->s1g_capab))
 				elems->s1g_capab = (void *)pos;
 			else
-				elem_parse_failed = true;
+				elem_parse_failed =
+					IEEE80211_PARSE_ERR_BAD_ELEM_SIZE;
 			break;
 		case WLAN_EID_S1G_OPERATION:
 			if (params->mode != IEEE80211_CONN_MODE_S1G)
@@ -1452,7 +1485,8 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 			if (elen == sizeof(*elems->s1g_oper))
 				elems->s1g_oper = (void *)pos;
 			else
-				elem_parse_failed = true;
+				elem_parse_failed =
+					IEEE80211_PARSE_ERR_BAD_ELEM_SIZE;
 			break;
 		case WLAN_EID_S1G_BCN_COMPAT:
 			if (params->mode != IEEE80211_CONN_MODE_S1G)
@@ -1460,7 +1494,8 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 			if (elen == sizeof(*elems->s1g_bcn_compat))
 				elems->s1g_bcn_compat = (void *)pos;
 			else
-				elem_parse_failed = true;
+				elem_parse_failed =
+					IEEE80211_PARSE_ERR_BAD_ELEM_SIZE;
 			break;
 		case WLAN_EID_AID_RESPONSE:
 			if (params->mode != IEEE80211_CONN_MODE_S1G)
@@ -1468,20 +1503,21 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 			if (elen == sizeof(struct ieee80211_aid_response_ie))
 				elems->aid_resp = (void *)pos;
 			else
-				elem_parse_failed = true;
+				elem_parse_failed =
+					IEEE80211_PARSE_ERR_BAD_ELEM_SIZE;
 			break;
 		default:
 			break;
 		}
 
 		if (elem_parse_failed)
-			elems->parse_error = true;
+			elems->parse_error |= elem_parse_failed;
 		else
 			__set_bit(id, seen_elems);
 	}
 
 	if (!for_each_element_completed(elem, params->start, params->len))
-		elems->parse_error = true;
+		elems->parse_error |= IEEE80211_PARSE_ERR_INVALID_END;
 
 	return crc;
 }
-- 
2.43.0


