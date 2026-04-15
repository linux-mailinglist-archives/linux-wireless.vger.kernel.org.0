Return-Path: <linux-wireless+bounces-34781-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKACKaOI32nSUgAAu9opvQ
	(envelope-from <linux-wireless+bounces-34781-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 14:46:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9460F40466A
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 14:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 641FA303FCD6
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 12:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006772580F3;
	Wed, 15 Apr 2026 12:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="vF220Zj3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240B23264D7
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 12:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776257126; cv=none; b=M2c/b7vW90biwE+N6/nZ5kIzssLGY1LPXE6Lwqc/KzJOvNNDSkvvJdD4G0k2NUUmf41dW9tZr7Zw8hQ9XomTFSrDAUZhhayM/UNzRzWYtoqBdzRVFLwsJmIWFFVwFISa1LpLiASKZUq65fV/r5849hz7KeUoA+/sf6o0nKHqWMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776257126; c=relaxed/simple;
	bh=ze1/RilIBbc9TudKfuiUmGj5kJKT7omtscESatP5Jj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rvFuReesgXfj5v52PdVU4fYUyNKSLXPN/WYF6iwuz0rwt/05AggvHAxOQoLAbho3Kj+Tc9Q9eodIhwJ75MO7cMx/X0Nn2orAzL+2SPBGQUsctwSdvR3WHF7hon/kc6cQ1V+IbGBeKElLwBA+gWkw6dZ3Bj8r+nC2wglMtaKHoOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=vF220Zj3; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=NsEqWvJ5K/cN3bZ3vWmE2if3vNTBCGsQhSgdTnHZlZs=;
	t=1776257125; x=1777466725; b=vF220Zj3NcqDuywocpIkFxxfvv6osWMkvnZNG76+2cInob1
	6oVSc9JKUykT0gAqI82Cq9FxF2/YvBXmzHGchOIkHQ+QBZAGZYoCd7oGrGVquay1F6Tub6FqTAYFo
	coG5OJbVF+CU3lZ0bGu1AzetcpNLtvtnhJ73typFxKopGAQU4lNWRoR5ZWU3EATI3ktoBWGtCaiN9
	ArnG1+K1yrcqCQk06cWRFBIyHBTYPQ4fBheAw4ploFMQxiZTzE3qArHkRhT2ZTjCrTYiLzc1xDlST
	sBN6jhRgUYXZTUcSwRbz0DveutWZM2lpFypUkJAR1RcHXd0eQvYDf16vbES7CGjA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wCzcQ-00000006OgW-3pVO;
	Wed, 15 Apr 2026 14:45:23 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	iil_jenkins iil_jenkins <EC.GER.UNIX.IIL.JENKINS@INTEL.COM>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 09/20] wifi: mac80211: clean up STA NSS handling
Date: Wed, 15 Apr 2026 14:42:07 +0200
Message-ID: <20260415144514.bef3d07beeb6.I97fb93ccc1b366110ab23de58fcd73676cdd85d6@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415124514.284345-22-johannes@sipsolutions.net>
References: <20260415124514.284345-22-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-34781-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:dkim,intel.com:url,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9460F40466A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

Move ieee80211_sta_init_nss() from VHT code to station code,
and disentangle it from rate control. This way, it becomes
clearer when 'rx_nss' is set up.

While doing this, fix the client side code to set up
link_sta->op_mode_nss instead of link_sta->pub->rx_nss for
the opmode element in association response, and remove the
(now wrong) comment about handling that in the function.

type=cleanup
ticket=none

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-on: https://gerritwcs.ir.intel.com/c/iwlwifi-stack-dev/+/273695
Tested-by: iil_jenkins iil_jenkins <EC.GER.UNIX.IIL.JENKINS@INTEL.COM>
tested: iil_jenkins iil_jenkins <EC.GER.UNIX.IIL.JENKINS@INTEL.COM>
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/ibss.c        |  2 +
 net/mac80211/ieee80211_i.h |  2 +-
 net/mac80211/mesh_plink.c  |  2 +
 net/mac80211/mlme.c        | 11 +++--
 net/mac80211/ocb.c         |  4 +-
 net/mac80211/rate.c        |  4 +-
 net/mac80211/sta_info.c    | 92 +++++++++++++++++++++++++++++++++++++
 net/mac80211/sta_info.h    |  1 +
 net/mac80211/vht.c         | 93 --------------------------------------
 9 files changed, 108 insertions(+), 103 deletions(-)

diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index 97292ff51475..96f040b4672e 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -553,6 +553,8 @@ static struct sta_info *ieee80211_ibss_finish_sta(struct sta_info *sta)
 
 	memcpy(addr, sta->sta.addr, ETH_ALEN);
 
+	ieee80211_sta_init_nss(&sta->deflink);
+
 	ibss_dbg(sdata, "Adding new IBSS station %pM\n", addr);
 
 	sta_info_pre_move_state(sta, IEEE80211_STA_AUTH);
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 3ab8368acaf9..76213b50fe57 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2315,7 +2315,7 @@ ieee80211_sta_cur_vht_bw(struct link_sta_info *link_sta)
 {
 	return _ieee80211_sta_cur_vht_bw(link_sta, NULL);
 }
-void ieee80211_sta_init_nss(struct link_sta_info *link_sta);
+
 void ieee80211_process_mu_groups(struct ieee80211_sub_if_data *sdata,
 				 struct ieee80211_link_data *link,
 				 struct ieee80211_mgmt *mgmt);
diff --git a/net/mac80211/mesh_plink.c b/net/mac80211/mesh_plink.c
index 7cbab90c8784..94201840677d 100644
--- a/net/mac80211/mesh_plink.c
+++ b/net/mac80211/mesh_plink.c
@@ -470,6 +470,8 @@ static void mesh_sta_info_init(struct ieee80211_sub_if_data *sdata,
 					    elems->eht_cap, elems->eht_cap_len,
 					    &sta->deflink);
 
+	ieee80211_sta_init_nss(&sta->deflink);
+
 	if (bw != sta->sta.deflink.bandwidth)
 		changed |= IEEE80211_RC_BW_CHANGED;
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 160ae65a5c64..438cc2d4731d 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5749,9 +5749,9 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 	 */
 
 	/*
-	 * If an operating mode notification IE is present, override the
-	 * NSS calculation (that would be done in rate_control_rate_init())
-	 * and use the # of streams from that element.
+	 * If an operating mode notification element is present, set the opmode
+	 * NSS override to correct for the current number of spatial streams,
+	 * overriding the capabilities. ieee80211_sta_init_nss() uses this.
 	 */
 	if (elems->opmode_notif &&
 	    !(*elems->opmode_notif & IEEE80211_OPMODE_NOTIF_RX_NSS_TYPE_BF)) {
@@ -5760,9 +5760,11 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 		nss = *elems->opmode_notif & IEEE80211_OPMODE_NOTIF_RX_NSS_MASK;
 		nss >>= IEEE80211_OPMODE_NOTIF_RX_NSS_SHIFT;
 		nss += 1;
-		link_sta->pub->rx_nss = nss;
+		link_sta->op_mode_nss = nss;
 	}
 
+	ieee80211_sta_init_nss(link_sta);
+
 	/*
 	 * Always handle WMM once after association regardless
 	 * of the first value the AP uses. Setting -1 here has
@@ -10617,7 +10619,6 @@ void ieee80211_process_ml_reconf_resp(struct ieee80211_sub_if_data *sdata,
 		if (add_links_data->link[link_id].status != WLAN_STATUS_SUCCESS)
 			goto disconnect;
 
-		ieee80211_sta_init_nss(link_sta);
 		if (ieee80211_sta_activate_link(sta, link_id))
 			goto disconnect;
 
diff --git a/net/mac80211/ocb.c b/net/mac80211/ocb.c
index ebb4f4d88c23..447c84235c1c 100644
--- a/net/mac80211/ocb.c
+++ b/net/mac80211/ocb.c
@@ -4,7 +4,7 @@
  *
  * Copyright: (c) 2014 Czech Technical University in Prague
  *            (c) 2014 Volkswagen Group Research
- * Copyright (C) 2022 - 2024 Intel Corporation
+ * Copyright (C) 2022 - 2024, 2026 Intel Corporation
  * Author:    Rostislav Lisovy <rostislav.lisovy@fel.cvut.cz>
  * Funded by: Volkswagen Group Research
  */
@@ -92,6 +92,8 @@ static struct sta_info *ieee80211_ocb_finish_sta(struct sta_info *sta)
 
 	memcpy(addr, sta->sta.addr, ETH_ALEN);
 
+	ieee80211_sta_init_nss(&sta->deflink);
+
 	ocb_dbg(sdata, "Adding new IBSS station %pM (dev=%s)\n",
 		addr, sdata->name);
 
diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
index 31af7dd6aedc..ba1a3aa3f5d4 100644
--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -4,7 +4,7 @@
  * Copyright 2005-2006, Devicescape Software, Inc.
  * Copyright (c) 2006 Jiri Benc <jbenc@suse.cz>
  * Copyright 2017	Intel Deutschland GmbH
- * Copyright (C) 2019, 2022-2025 Intel Corporation
+ * Copyright (C) 2019, 2022-2026 Intel Corporation
  */
 
 #include <linux/kernel.h>
@@ -38,8 +38,6 @@ void rate_control_rate_init(struct link_sta_info *link_sta)
 	struct ieee80211_supported_band *sband;
 	struct ieee80211_chanctx_conf *chanctx_conf;
 
-	ieee80211_sta_init_nss(link_sta);
-
 	if (!ref)
 		return;
 
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index e08db1b0cb30..0f174a6a04a8 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -3426,6 +3426,98 @@ void ieee80211_sta_remove_link(struct sta_info *sta, unsigned int link_id)
 	sta_remove_link(sta, link_id, true);
 }
 
+void ieee80211_sta_init_nss(struct link_sta_info *link_sta)
+{
+	u8 ht_rx_nss = 0, vht_rx_nss = 0, he_rx_nss = 0, eht_rx_nss = 0, rx_nss;
+	bool support_160;
+
+	if (link_sta->pub->eht_cap.has_eht) {
+		int i;
+		const u8 *rx_nss_mcs = (void *)&link_sta->pub->eht_cap.eht_mcs_nss_supp;
+
+		/* get the max nss for EHT over all possible bandwidths and mcs */
+		for (i = 0; i < sizeof(struct ieee80211_eht_mcs_nss_supp); i++)
+			eht_rx_nss = max_t(u8, eht_rx_nss,
+					   u8_get_bits(rx_nss_mcs[i],
+						       IEEE80211_EHT_MCS_NSS_RX));
+	}
+
+	if (link_sta->pub->he_cap.has_he) {
+		int i;
+		u8 rx_mcs_80 = 0, rx_mcs_160 = 0;
+		const struct ieee80211_sta_he_cap *he_cap = &link_sta->pub->he_cap;
+		u16 mcs_160_map =
+			le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_160);
+		u16 mcs_80_map = le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_80);
+
+		for (i = 7; i >= 0; i--) {
+			u8 mcs_160 = (mcs_160_map >> (2 * i)) & 3;
+
+			if (mcs_160 != IEEE80211_HE_MCS_NOT_SUPPORTED) {
+				rx_mcs_160 = i + 1;
+				break;
+			}
+		}
+		for (i = 7; i >= 0; i--) {
+			u8 mcs_80 = (mcs_80_map >> (2 * i)) & 3;
+
+			if (mcs_80 != IEEE80211_HE_MCS_NOT_SUPPORTED) {
+				rx_mcs_80 = i + 1;
+				break;
+			}
+		}
+
+		support_160 = he_cap->he_cap_elem.phy_cap_info[0] &
+			      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
+
+		if (support_160)
+			he_rx_nss = min(rx_mcs_80, rx_mcs_160);
+		else
+			he_rx_nss = rx_mcs_80;
+	}
+
+	if (link_sta->pub->ht_cap.ht_supported) {
+		if (link_sta->pub->ht_cap.mcs.rx_mask[0])
+			ht_rx_nss++;
+		if (link_sta->pub->ht_cap.mcs.rx_mask[1])
+			ht_rx_nss++;
+		if (link_sta->pub->ht_cap.mcs.rx_mask[2])
+			ht_rx_nss++;
+		if (link_sta->pub->ht_cap.mcs.rx_mask[3])
+			ht_rx_nss++;
+		/* FIXME: consider rx_highest? */
+	}
+
+	if (link_sta->pub->vht_cap.vht_supported) {
+		int i;
+		u16 rx_mcs_map;
+
+		rx_mcs_map = le16_to_cpu(link_sta->pub->vht_cap.vht_mcs.rx_mcs_map);
+
+		for (i = 7; i >= 0; i--) {
+			u8 mcs = (rx_mcs_map >> (2 * i)) & 3;
+
+			if (mcs != IEEE80211_VHT_MCS_NOT_SUPPORTED) {
+				vht_rx_nss = i + 1;
+				break;
+			}
+		}
+		/* FIXME: consider rx_highest? */
+	}
+
+	rx_nss = max(vht_rx_nss, ht_rx_nss);
+	rx_nss = max(he_rx_nss, rx_nss);
+	rx_nss = max(eht_rx_nss, rx_nss);
+	rx_nss = max_t(u8, 1, rx_nss);
+	link_sta->capa_nss = rx_nss;
+
+	if (link_sta->op_mode_nss)
+		link_sta->pub->rx_nss =
+			min_t(u8, rx_nss, link_sta->op_mode_nss);
+	else
+		link_sta->pub->rx_nss = rx_nss;
+}
+
 void ieee80211_sta_set_max_amsdu_subframes(struct sta_info *sta,
 					   const u8 *ext_capab,
 					   unsigned int ext_capab_len)
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 05a776dba3e9..d0987b546bb7 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -997,6 +997,7 @@ void ieee80211_sta_ps_deliver_uapsd(struct sta_info *sta);
 
 unsigned long ieee80211_sta_last_active(struct sta_info *sta, int link_id);
 
+void ieee80211_sta_init_nss(struct link_sta_info *link_sta);
 void ieee80211_sta_set_max_amsdu_subframes(struct sta_info *sta,
 					   const u8 *ext_capab,
 					   unsigned int ext_capab_len);
diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
index 17f3f281abe1..b93d6a3200c8 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -488,99 +488,6 @@ _ieee80211_sta_cur_vht_bw(struct link_sta_info *link_sta,
 	return bw;
 }
 
-void ieee80211_sta_init_nss(struct link_sta_info *link_sta)
-{
-	u8 ht_rx_nss = 0, vht_rx_nss = 0, he_rx_nss = 0, eht_rx_nss = 0, rx_nss;
-	bool support_160;
-
-	if (link_sta->pub->eht_cap.has_eht) {
-		int i;
-		const u8 *rx_nss_mcs = (void *)&link_sta->pub->eht_cap.eht_mcs_nss_supp;
-
-		/* get the max nss for EHT over all possible bandwidths and mcs */
-		for (i = 0; i < sizeof(struct ieee80211_eht_mcs_nss_supp); i++)
-			eht_rx_nss = max_t(u8, eht_rx_nss,
-					   u8_get_bits(rx_nss_mcs[i],
-						       IEEE80211_EHT_MCS_NSS_RX));
-	}
-
-	if (link_sta->pub->he_cap.has_he) {
-		int i;
-		u8 rx_mcs_80 = 0, rx_mcs_160 = 0;
-		const struct ieee80211_sta_he_cap *he_cap = &link_sta->pub->he_cap;
-		u16 mcs_160_map =
-			le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_160);
-		u16 mcs_80_map = le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_80);
-
-		for (i = 7; i >= 0; i--) {
-			u8 mcs_160 = (mcs_160_map >> (2 * i)) & 3;
-
-			if (mcs_160 != IEEE80211_HE_MCS_NOT_SUPPORTED) {
-				rx_mcs_160 = i + 1;
-				break;
-			}
-		}
-		for (i = 7; i >= 0; i--) {
-			u8 mcs_80 = (mcs_80_map >> (2 * i)) & 3;
-
-			if (mcs_80 != IEEE80211_HE_MCS_NOT_SUPPORTED) {
-				rx_mcs_80 = i + 1;
-				break;
-			}
-		}
-
-		support_160 = he_cap->he_cap_elem.phy_cap_info[0] &
-			      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
-
-		if (support_160)
-			he_rx_nss = min(rx_mcs_80, rx_mcs_160);
-		else
-			he_rx_nss = rx_mcs_80;
-	}
-
-	if (link_sta->pub->ht_cap.ht_supported) {
-		if (link_sta->pub->ht_cap.mcs.rx_mask[0])
-			ht_rx_nss++;
-		if (link_sta->pub->ht_cap.mcs.rx_mask[1])
-			ht_rx_nss++;
-		if (link_sta->pub->ht_cap.mcs.rx_mask[2])
-			ht_rx_nss++;
-		if (link_sta->pub->ht_cap.mcs.rx_mask[3])
-			ht_rx_nss++;
-		/* FIXME: consider rx_highest? */
-	}
-
-	if (link_sta->pub->vht_cap.vht_supported) {
-		int i;
-		u16 rx_mcs_map;
-
-		rx_mcs_map = le16_to_cpu(link_sta->pub->vht_cap.vht_mcs.rx_mcs_map);
-
-		for (i = 7; i >= 0; i--) {
-			u8 mcs = (rx_mcs_map >> (2 * i)) & 3;
-
-			if (mcs != IEEE80211_VHT_MCS_NOT_SUPPORTED) {
-				vht_rx_nss = i + 1;
-				break;
-			}
-		}
-		/* FIXME: consider rx_highest? */
-	}
-
-	rx_nss = max(vht_rx_nss, ht_rx_nss);
-	rx_nss = max(he_rx_nss, rx_nss);
-	rx_nss = max(eht_rx_nss, rx_nss);
-	rx_nss = max_t(u8, 1, rx_nss);
-	link_sta->capa_nss = rx_nss;
-
-	/* that shouldn't be set yet, but we can handle it anyway */
-	if (link_sta->op_mode_nss)
-		link_sta->pub->rx_nss =
-			min_t(u8, rx_nss, link_sta->op_mode_nss);
-	else
-		link_sta->pub->rx_nss = rx_nss;
-}
-
 u32 __ieee80211_vht_handle_opmode(struct ieee80211_sub_if_data *sdata,
 				  struct link_sta_info *link_sta,
 				  u8 opmode, enum nl80211_band band)
-- 
2.53.0


