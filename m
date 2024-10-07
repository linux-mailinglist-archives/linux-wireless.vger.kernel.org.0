Return-Path: <linux-wireless+bounces-13589-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B65992AEE
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 14:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7697E284CCD
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 12:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C82F1D1E60;
	Mon,  7 Oct 2024 12:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IOImJAX5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A9D1B78F3
	for <linux-wireless@vger.kernel.org>; Mon,  7 Oct 2024 12:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728302481; cv=none; b=goLPkb1xq8AubAvg3GxCYebvLgy3yLK83Bw4Jwd1kLk0HtAj4CZ/tDlavpjuSwLOfumRMkCWBE31MSPqIt34gmJS93nE/ifsUpo1HdIHykQZu7YSw8MWm/m/VYiXg2vmLDLczYAqOxkGP02S+7s25a+f2NIaemKW/+eHQiMi3R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728302481; c=relaxed/simple;
	bh=6QZ5SUQhDoEQN1RUVWMOJwir67faFxOS/k/v2+nAmoM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o9bm9hm/YEMYtAnoa4fCRaJ61A2BFgqUA2nN9an7jo0nsi9gmcf8X3b/I/JzSMSRYYfEfVOJsoohM3J1Ctl1jSbjncxjKJuDP8UPSs5qCAzVgKomyzntJIF4GwmNGDw4IihplXMBOjzmYcc2W0apzDrAahHSEc3rqe684O7tdEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IOImJAX5; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728302480; x=1759838480;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6QZ5SUQhDoEQN1RUVWMOJwir67faFxOS/k/v2+nAmoM=;
  b=IOImJAX5Vw801ha8Jf+jVwkXBG9jLJfegCNvzf3FTyotCEjr63tEeNoW
   6NUSTye0ELjFr3b/Q5jytxtOzF6hDybfRyo0BObQq3fGkvcqlXdp2ekpN
   EkJFPN3E/Yx/6q7tAvuaP97qR650JjcCedwSUlcVnB+tgVaRVUW2MSCWN
   2N5kw++nq8oL5WBWqZSA4C6/N2YSLzC6arPAKbxwnx26lpxSiVX/AnFsG
   P7BUW9PP00cpTvz8fX9rokFzpXTq41PPzeNF97niz9H/oyHKz/ZYuo18g
   2Lf+hbRlbBR5a4swPfmbsIhs2Is1S0KyVRT3Cw7LbUUs2MLaUYjrDkPD+
   A==;
X-CSE-ConnectionGUID: VCmSCiFRShyvY7tGyB618g==
X-CSE-MsgGUID: fdQjyMM7TsWl2EgvGz1YRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11217"; a="38099382"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="38099382"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 05:01:18 -0700
X-CSE-ConnectionGUID: RJKFhY3KTaalOoDuHU/qEQ==
X-CSE-MsgGUID: CyRjpULjTNuBWhiFKsLFAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="75019252"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 05:01:17 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 04/14] wifi: mac80211: make bss_param_ch_cnt available for the low level driver
Date: Mon,  7 Oct 2024 15:00:48 +0300
Message-Id: <20241007144851.e2d8d1a722ad.I04b883daba2cd48e5730659eb62ca1614c899cbb@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241007120058.1822752-1-miriam.rachel.korenblit@intel.com>
References: <20241007120058.1822752-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Drivers may need to track this. Make it available for them, and maintain
the value when beacons are received.
When link X receives a beacon, iterate the RNR elements and update all
the links with their respective data.
Track the link id that updated the data so that each link can know
whether the update came from its own beacon or from another link.
In case, the update came from the link's own beacon, always update the
updater link id.
The purpose is to let the low level driver know if a link is losing its
beacons. If link X is losing its beacons, it can still track the
bss_param_ch_cnt and know where the update came from.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/mac80211.h     | 15 ++++++
 net/mac80211/ieee80211_i.h |  2 -
 net/mac80211/mlme.c        | 93 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 106 insertions(+), 4 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 752c0abd6c83..9ed6907a1e3c 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -740,6 +740,19 @@ struct ieee80211_parsed_tpe {
  * @eht_80mhz_full_bw_ul_mumimo: in AP-mode, does this BSS support the
  *	reception of an EHT TB PPDU on an RU that spans the entire PPDU
  *	bandwidth
+ * @bss_param_ch_cnt: in BSS-mode, the BSS params change count. This
+ *	information is the latest known value. It can come from this link's
+ *	beacon or from a beacon sent by another link.
+ * @bss_param_ch_cnt_link_id: in BSS-mode, the link_id to which the beacon
+ *	that updated &bss_param_ch_cnt belongs. E.g. if link 1 doesn't hear
+ *	its beacons, and link 2 sent a beacon with an RNR element that updated
+ *	link 1's BSS params change count, then, link 1's
+ *	bss_param_ch_cnt_link_id will be 2. That means that link 1 knows that
+ *	link 2 was the link that updated its bss_param_ch_cnt value.
+ *	In case link 1 hears its beacon again, bss_param_ch_cnt_link_id will
+ *	be updated to 1, even if bss_param_ch_cnt didn't change. This allows
+ *	the link to know that it heard the latest value from its own beacon
+ *	(as opposed to hearing its value from another link's beacon).
  */
 struct ieee80211_bss_conf {
 	struct ieee80211_vif *vif;
@@ -834,6 +847,8 @@ struct ieee80211_bss_conf {
 	bool eht_su_beamformee;
 	bool eht_mu_beamformer;
 	bool eht_80mhz_full_bw_ul_mumimo;
+	u8 bss_param_ch_cnt;
+	u8 bss_param_ch_cnt_link_id;
 };
 
 /**
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 4f0390918b60..ea74b625aa6c 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1015,8 +1015,6 @@ struct ieee80211_link_data_managed {
 
 	int wmm_last_param_set;
 	int mu_edca_last_param_set;
-
-	u8 bss_param_ch_cnt;
 };
 
 struct ieee80211_link_data_ap {
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 735e78adb0db..cc8399de8e6d 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2643,6 +2643,89 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 			 &ifmgd->csa_connection_drop_work);
 }
 
+struct sta_bss_param_ch_cnt_data {
+	struct ieee80211_sub_if_data *sdata;
+	u8 reporting_link_id;
+	u8 mld_id;
+};
+
+static enum cfg80211_rnr_iter_ret
+ieee80211_sta_bss_param_ch_cnt_iter(void *_data, u8 type,
+				    const struct ieee80211_neighbor_ap_info *info,
+				    const u8 *tbtt_info, u8 tbtt_info_len)
+{
+	struct sta_bss_param_ch_cnt_data *data = _data;
+	struct ieee80211_sub_if_data *sdata = data->sdata;
+	const struct ieee80211_tbtt_info_ge_11 *ti;
+	u8 bss_param_ch_cnt;
+	int link_id;
+
+	if (type != IEEE80211_TBTT_INFO_TYPE_TBTT)
+		return RNR_ITER_CONTINUE;
+
+	if (tbtt_info_len < sizeof(*ti))
+		return RNR_ITER_CONTINUE;
+
+	ti = (const void *)tbtt_info;
+
+	if (ti->mld_params.mld_id != data->mld_id)
+		return RNR_ITER_CONTINUE;
+
+	link_id = le16_get_bits(ti->mld_params.params,
+				IEEE80211_RNR_MLD_PARAMS_LINK_ID);
+	bss_param_ch_cnt =
+		le16_get_bits(ti->mld_params.params,
+			      IEEE80211_RNR_MLD_PARAMS_BSS_CHANGE_COUNT);
+
+	if (bss_param_ch_cnt != 255 &&
+	    link_id < ARRAY_SIZE(sdata->link)) {
+		struct ieee80211_link_data *link =
+			sdata_dereference(sdata->link[link_id], sdata);
+
+		if (link && link->conf->bss_param_ch_cnt != bss_param_ch_cnt) {
+			link->conf->bss_param_ch_cnt = bss_param_ch_cnt;
+			link->conf->bss_param_ch_cnt_link_id =
+				data->reporting_link_id;
+		}
+	}
+
+	return RNR_ITER_CONTINUE;
+}
+
+static void
+ieee80211_mgd_update_bss_param_ch_cnt(struct ieee80211_sub_if_data *sdata,
+				      struct ieee80211_bss_conf *bss_conf,
+				      struct ieee802_11_elems *elems)
+{
+	struct sta_bss_param_ch_cnt_data data = {
+		.reporting_link_id = bss_conf->link_id,
+		.sdata = sdata,
+	};
+	int bss_param_ch_cnt;
+
+	if (!elems->ml_basic)
+		return;
+
+	data.mld_id = ieee80211_mle_get_mld_id((const void *)elems->ml_basic);
+
+	cfg80211_iter_rnr(elems->ie_start, elems->total_len,
+			  ieee80211_sta_bss_param_ch_cnt_iter, &data);
+
+	bss_param_ch_cnt =
+		ieee80211_mle_get_bss_param_ch_cnt((const void *)elems->ml_basic);
+
+	/*
+	 * Update bss_param_ch_cnt_link_id even if bss_param_ch_cnt
+	 * didn't change to indicate that we got a beacon on our own
+	 * link.
+	 */
+	if (bss_param_ch_cnt >= 0 && bss_param_ch_cnt != 255) {
+		bss_conf->bss_param_ch_cnt = bss_param_ch_cnt;
+		bss_conf->bss_param_ch_cnt_link_id =
+			bss_conf->link_id;
+	}
+}
+
 static bool
 ieee80211_find_80211h_pwr_constr(struct ieee80211_sub_if_data *sdata,
 				 struct ieee80211_channel *channel,
@@ -4667,7 +4750,8 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 				ret = false;
 				goto out;
 			}
-			link->u.mgd.bss_param_ch_cnt = bss_param_ch_cnt;
+			bss_conf->bss_param_ch_cnt = bss_param_ch_cnt;
+			bss_conf->bss_param_ch_cnt_link_id = link_id;
 		}
 	} else if (elems->parse_error & IEEE80211_PARSE_ERR_DUP_NEST_ML_BASIC ||
 		   !elems->prof ||
@@ -4677,6 +4761,7 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 	} else {
 		const u8 *ptr = elems->prof->variable +
 				elems->prof->sta_info_len - 1;
+		int bss_param_ch_cnt;
 
 		/*
 		 * During parsing, we validated that these fields exist,
@@ -4684,8 +4769,10 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 		 */
 		capab_info = get_unaligned_le16(ptr);
 		assoc_data->link[link_id].status = get_unaligned_le16(ptr + 2);
-		link->u.mgd.bss_param_ch_cnt =
+		bss_param_ch_cnt =
 			ieee80211_mle_basic_sta_prof_bss_param_ch_cnt(elems->prof);
+		bss_conf->bss_param_ch_cnt = bss_param_ch_cnt;
+		bss_conf->bss_param_ch_cnt_link_id = link_id;
 
 		if (assoc_data->link[link_id].status != WLAN_STATUS_SUCCESS) {
 			link_info(link, "association response status code=%u\n",
@@ -6913,6 +7000,8 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 	/* note that after this elems->ml_basic can no longer be used fully */
 	ieee80211_mgd_check_cross_link_csa(sdata, rx_status->link_id, elems);
 
+	ieee80211_mgd_update_bss_param_ch_cnt(sdata, bss_conf, elems);
+
 	if (!link->u.mgd.disable_wmm_tracking &&
 	    ieee80211_sta_wmm_params(local, link, elems->wmm_param,
 				     elems->wmm_param_len,
-- 
2.34.1


