Return-Path: <linux-wireless+bounces-16558-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E7D9F70CF
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 00:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B76C77A142F
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 23:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE2919D098;
	Wed, 18 Dec 2024 23:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="bK+G1kVQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF571FCF7D
	for <linux-wireless@vger.kernel.org>; Wed, 18 Dec 2024 23:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734564539; cv=none; b=dfelKwavVN/ZMftyrBHJT4RXNw1yvrZfJVjsJE0TD+P6g/4AWIio+7At62hNhFo7zVXUkrPN7cEPMaoHnQSQAFsfXtxsoGSJ3uKnfQfs+vVPvS7JnNUb+fno2eDeniEEHXGQ4oAQMaPaq+aaXoF/iFKDOu3mV9Rvw1CQR2s7YOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734564539; c=relaxed/simple;
	bh=QQfVHt/HX68JWcD2pGybnpHMofWCQzKIsve3/1O9yNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OCX02yxdXRpiCLPwBm2Ld3iOK/JXBiweb7zY8myHj2ctKwaMPSEKRaiBe86SbGgDubSk18HvsCNBhb2WfazG/OOrfGvWSgED8JAmSUHLH4BTiJsixY1gj3TxUd2zt8dK9XLZPdu3DLLbbMbs/y1K5MK26wHTFaSFZD87pX+FbPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=bK+G1kVQ; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 9D134C00062
	for <linux-wireless@vger.kernel.org>; Wed, 18 Dec 2024 23:28:54 +0000 (UTC)
Received: from ben-dt5.candelatech.com (unknown [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id 600CF13C2B0;
	Wed, 18 Dec 2024 15:28:51 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 600CF13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1734564531;
	bh=QQfVHt/HX68JWcD2pGybnpHMofWCQzKIsve3/1O9yNM=;
	h=From:To:Cc:Subject:Date:From;
	b=bK+G1kVQRP7uE+mLPrYpUWOSJSgbGyY2aM1XweDAL1kGll1MyIFOi6Rj40jsb/scm
	 +Y3bM7H55T23TBaLPSC6pL64Dw/v9tNKWzmQvWEyVbV3JZrWkKhFPrXSftWFa99jwr
	 HiT76bg0uErLY8DV74PIfAP5hECOGMXDbwRzKfjg=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH v2 1/2] wifi: iwlwifi: Use phy-ctx channel load if no ies.
Date: Wed, 18 Dec 2024 15:28:48 -0800
Message-ID: <20241218232849.3156720-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1734564535-Cq5JsSsTxG96
X-MDID-O:
 us5;ut7;1734564535;Cq5JsSsTxG96;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Ben Greear <greearb@candelatech.com>

In case there are no IEs found that report channel load,
use channel load reported by the radio firmware.

Save related information and display it in debugfs to
better understand what is happening.

Improve debugging in related code.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---

v2:  Skip phy contexts with zero 'ref' in 2/2 patch.

 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |  43 +++++++
 drivers/net/wireless/intel/iwlwifi/mvm/link.c | 116 +++++++++++-------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  23 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   |   4 +
 4 files changed, 135 insertions(+), 51 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 91ca830a7b60..23797b1329aa 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -1062,6 +1062,49 @@ static ssize_t iwl_dbgfs_fw_system_stats_read(struct file *file,
 			 "accu_radio_stats.tx_time %lld\n",
 			 mvm->accu_radio_stats.tx_time);
 
+	pos += scnprintf(pos, endpos - pos,
+			 "mvmvif.esr_disable_reason: 0x%x\n",
+			 mvmvif->esr_disable_reason);
+	pos += scnprintf(pos, endpos - pos,
+			 "mvmvif.link_selection_res: 0x%x\n",
+			 mvmvif->link_selection_res);
+	pos += scnprintf(pos, endpos - pos,
+			 "mvmvif.primary_link: %d\n",
+			 mvmvif->primary_link);
+	pos += scnprintf(pos, endpos - pos,
+			 "mvmvif.link_selection_primary: %d\n",
+			 mvmvif->link_selection_primary);
+	pos += scnprintf(pos, endpos - pos,
+			 "mvmvif.last_esr_exit: ts: %lu  reason: 0x%x\n",
+			 mvmvif->last_esr_exit.ts, mvmvif->last_esr_exit.reason);
+	pos += scnprintf(pos, endpos - pos,
+			 "mvmvif.esr_active: %d\n",
+			 mvmvif->esr_active);
+	pos += scnprintf(pos, endpos - pos,
+			 "mvmvif.esr_active: %d\n",
+			 mvmvif->esr_active);
+	for (i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++) {
+		struct iwl_mvm_link_sel_data *d = &mvm->link_sel_data[i];
+
+		if (d->link_id == -1 || !d->chandef)
+			continue;
+
+		pos += scnprintf(pos, endpos - pos,
+				 "link-sel-data[%d] link-id: %d freq: %d signal: %d grade: %d  chan-load: %d  load-by-us: %d punc-penalty: %d\n",
+				 i, d->link_id, d->center_freq1, d->signal, d->grade,
+				 d->chan_load, d->channel_load_by_us,
+				 d->puncturing_penalty);
+	}
+	for (i = 0; i < NUM_PHY_CTX; i++) {
+		if (!mvm->phy_ctxts[i].ref)
+			continue;
+		pos += scnprintf(pos, endpos - pos,
+				 "phy-ctxtx[%d] channel-load: %d  load-by-us: %d  not-by-us: %d\n",
+				 i, mvm->phy_ctxts[i].channel_load,
+				 mvm->phy_ctxts[i].channel_load_by_us,
+				 mvm->phy_ctxts[i].channel_load_not_by_us);
+	}
+
 release_send_out:
 	mutex_unlock(&mvm->mutex);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index 272da41567ef..04a2f6c83b3c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -485,13 +485,16 @@ static const struct iwl_mvm_rssi_to_grade rssi_to_grade_map[] = {
 #define NORMALIZE_PERCENT_TO_255(percentage) ((percentage) * SCALE_FACTOR / 100)
 
 static unsigned int
-iwl_mvm_get_puncturing_factor(const struct ieee80211_bss_conf *link_conf)
+iwl_mvm_get_puncturing_factor(const struct ieee80211_bss_conf *link_conf,
+			      struct iwl_mvm_link_sel_data *data)
 {
 	enum nl80211_chan_width chan_width =
 		link_conf->chanreq.oper.width;
 	int mhz = nl80211_chan_width_to_mhz(chan_width);
 	unsigned int n_subchannels, n_punctured, puncturing_penalty;
 
+	data->puncturing_penalty = 0;
+
 	if (WARN_ONCE(mhz < 20 || mhz > 320,
 		      "Invalid channel width : (%d)\n", mhz))
 		return SCALE_FACTOR;
@@ -506,21 +509,26 @@ iwl_mvm_get_puncturing_factor(const struct ieee80211_bss_conf *link_conf)
 	n_punctured = hweight16(link_conf->chanreq.oper.punctured);
 
 	puncturing_penalty = n_punctured * SCALE_FACTOR / n_subchannels;
+	data->puncturing_penalty = puncturing_penalty;
 	return SCALE_FACTOR - puncturing_penalty;
 }
 
 static unsigned int
-iwl_mvm_get_chan_load(struct ieee80211_bss_conf *link_conf)
+iwl_mvm_get_chan_load(struct iwl_mvm *mvm,
+		      struct ieee80211_bss_conf *link_conf,
+		      struct iwl_mvm_link_sel_data *data)
 {
 	struct ieee80211_vif *vif = link_conf->vif;
 	struct iwl_mvm_vif_link_info *mvm_link =
 		iwl_mvm_vif_from_mac80211(link_conf->vif)->link[link_conf->link_id];
 	const struct element *bss_load_elem;
 	const struct ieee80211_bss_load_elem *bss_load;
-	enum nl80211_band band = link_conf->chanreq.oper.chan->band;
 	const struct cfg80211_bss_ies *ies;
 	unsigned int chan_load;
 	u32 chan_load_by_us;
+	const char *load_from = "ies";
+
+	data->channel_load_by_us = 0;
 
 	rcu_read_lock();
 	if (ieee80211_vif_link_active(vif, link_conf->link_id))
@@ -534,33 +542,20 @@ iwl_mvm_get_chan_load(struct ieee80211_bss_conf *link_conf)
 	else
 		bss_load_elem = NULL;
 
-	/* If there isn't BSS Load element, take the defaults */
+	/* If there isn't BSS Load element, get it from our phy-ctx stats */
 	if (!bss_load_elem ||
 	    bss_load_elem->datalen != sizeof(*bss_load)) {
-		rcu_read_unlock();
-		switch (band) {
-		case NL80211_BAND_2GHZ:
-			chan_load = DEFAULT_CHAN_LOAD_LB;
-			break;
-		case NL80211_BAND_5GHZ:
-			chan_load = DEFAULT_CHAN_LOAD_HB;
-			break;
-		case NL80211_BAND_6GHZ:
-			chan_load = DEFAULT_CHAN_LOAD_UHB;
-			break;
-		default:
-			chan_load = 0;
-			break;
-		}
-		/* The defaults are given in percentage */
-		return NORMALIZE_PERCENT_TO_255(chan_load);
+		chan_load = NORMALIZE_PERCENT_TO_255(mvm_link->phy_ctxt->channel_load);
+		load_from = "phy_ctx";
+	} else {
+		bss_load = (const void *)bss_load_elem->data;
+		/* Channel util is in range 0-255 */
+		chan_load = bss_load->channel_util;
 	}
-
-	bss_load = (const void *)bss_load_elem->data;
-	/* Channel util is in range 0-255 */
-	chan_load = bss_load->channel_util;
 	rcu_read_unlock();
 
+	data->chan_load = chan_load;
+
 	if (!mvm_link || !mvm_link->active)
 		return chan_load;
 
@@ -572,6 +567,12 @@ iwl_mvm_get_chan_load(struct ieee80211_bss_conf *link_conf)
 	/* channel load by us is given in percentage */
 	chan_load_by_us =
 		NORMALIZE_PERCENT_TO_255(mvm_link->phy_ctxt->channel_load_by_us);
+	data->channel_load_by_us = chan_load_by_us;
+
+	IWL_DEBUG_INFO(mvm,
+		       "Link %d chan-load from %s: %d  chan-load-by-us: %d  link-active: %d\n",
+		       link_conf->link_id, load_from, chan_load, chan_load_by_us,
+		       ieee80211_vif_link_active(vif, link_conf->link_id));
 
 	/* Use only values that firmware sends that can possibly be valid */
 	if (chan_load_by_us <= chan_load)
@@ -581,19 +582,24 @@ iwl_mvm_get_chan_load(struct ieee80211_bss_conf *link_conf)
 }
 
 static unsigned int
-iwl_mvm_get_chan_load_factor(struct ieee80211_bss_conf *link_conf)
+iwl_mvm_get_chan_load_factor(struct iwl_mvm *mvm,
+			     struct ieee80211_bss_conf *link_conf,
+			     struct iwl_mvm_link_sel_data *data)
 {
-	return SCALE_FACTOR - iwl_mvm_get_chan_load(link_conf);
+	return SCALE_FACTOR - iwl_mvm_get_chan_load(mvm, link_conf, data);
 }
 
 /* This function calculates the grade of a link. Returns 0 in error case */
 VISIBLE_IF_IWLWIFI_KUNIT
-unsigned int iwl_mvm_get_link_grade(struct ieee80211_bss_conf *link_conf)
+unsigned int iwl_mvm_get_link_grade(struct iwl_mvm *mvm,
+				    struct ieee80211_bss_conf *link_conf,
+				    struct iwl_mvm_link_sel_data *data)
 {
 	enum nl80211_band band;
 	int i, rssi_idx;
 	s32 link_rssi;
 	unsigned int grade = MAX_GRADE;
+	unsigned int rssi_grade;
 
 	if (WARN_ON_ONCE(!link_conf))
 		return 0;
@@ -629,16 +635,23 @@ unsigned int iwl_mvm_get_link_grade(struct ieee80211_bss_conf *link_conf)
 		grade = line->grade;
 		break;
 	}
+	rssi_grade = grade;
 
 	/* apply the channel load and puncturing factors */
-	grade = grade * iwl_mvm_get_chan_load_factor(link_conf) / SCALE_FACTOR;
-	grade = grade * iwl_mvm_get_puncturing_factor(link_conf) / SCALE_FACTOR;
+	grade = grade * iwl_mvm_get_chan_load_factor(mvm, link_conf, data) / SCALE_FACTOR;
+	grade = grade * iwl_mvm_get_puncturing_factor(link_conf, data) / SCALE_FACTOR;
+
+	IWL_DEBUG_INFO(mvm,
+		       "Link %d rssi-grade: %d  final grade: %d\n",
+		       link_conf->link_id, rssi_grade, grade);
+
 	return grade;
 }
 EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_mvm_get_link_grade);
 
 static
-u8 iwl_mvm_set_link_selection_data(struct ieee80211_vif *vif,
+u8 iwl_mvm_set_link_selection_data(struct iwl_mvm *mvm,
+				   struct ieee80211_vif *vif,
 				   struct iwl_mvm_link_sel_data *data,
 				   unsigned long usable_links,
 				   u8 *best_link_idx)
@@ -657,8 +670,9 @@ u8 iwl_mvm_set_link_selection_data(struct ieee80211_vif *vif,
 
 		data[n_data].link_id = link_id;
 		data[n_data].chandef = &link_conf->chanreq.oper;
+		data[n_data].center_freq1 = link_conf->chanreq.oper.center_freq1;
 		data[n_data].signal = link_conf->bss->signal / 100;
-		data[n_data].grade = iwl_mvm_get_link_grade(link_conf);
+		data[n_data].grade = iwl_mvm_get_link_grade(mvm, link_conf, &data[n_data]);
 
 		if (data[n_data].grade > max_grade) {
 			max_grade = data[n_data].grade;
@@ -733,8 +747,12 @@ iwl_mvm_esr_disallowed_with_link(struct iwl_mvm *mvm,
 	thresh = iwl_mvm_get_esr_rssi_thresh(mvm, link->chandef,
 					     false);
 
-	if (link->signal < thresh)
+	if (link->signal < thresh) {
+		IWL_DEBUG_INFO(mvm,
+			       "esr-disallowed-low-rssi, Link %d signal: %d  thresh: %d freq: %d\n",
+			       link->link_id, link->signal, thresh, link->center_freq1);
 		ret |= IWL_MVM_ESR_EXIT_LOW_RSSI;
+	}
 
 	if (conf->csa_active)
 		ret |= IWL_MVM_ESR_EXIT_CSA;
@@ -785,9 +803,10 @@ EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_mvm_mld_valid_link_pair);
  * Returns 0 if eSR is not allowed with these 2 links.
  */
 static
-unsigned int iwl_mvm_get_esr_grade(struct ieee80211_vif *vif,
-				   const struct iwl_mvm_link_sel_data *a,
-				   const struct iwl_mvm_link_sel_data *b,
+unsigned int iwl_mvm_get_esr_grade(struct iwl_mvm *mvm,
+				   struct ieee80211_vif *vif,
+				   struct iwl_mvm_link_sel_data *a,
+				   struct iwl_mvm_link_sel_data *b,
 				   u8 *primary_id)
 {
 	struct ieee80211_bss_conf *primary_conf;
@@ -810,7 +829,7 @@ unsigned int iwl_mvm_get_esr_grade(struct ieee80211_vif *vif,
 	if (WARN_ON_ONCE(!primary_conf))
 		return 0;
 
-	primary_load = iwl_mvm_get_chan_load(primary_conf);
+	primary_load = iwl_mvm_get_chan_load(mvm, primary_conf, a);
 
 	return a->grade +
 		((b->grade * primary_load) / SCALE_FACTOR);
@@ -818,13 +837,20 @@ unsigned int iwl_mvm_get_esr_grade(struct ieee80211_vif *vif,
 
 void iwl_mvm_select_links(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 {
-	struct iwl_mvm_link_sel_data data[IEEE80211_MLD_MAX_NUM_LINKS];
+	struct iwl_mvm_link_sel_data *link_sel_data = mvm->link_sel_data;
 	struct iwl_mvm_link_sel_data *best_link;
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	u32 max_active_links = iwl_mvm_max_active_links(mvm, vif);
 	u16 usable_links = ieee80211_vif_usable_links(vif);
 	u8 best, primary_link, best_in_pair, n_data;
 	u16 max_esr_grade = 0, new_active_links;
+	int z;
+
+	/* Mark links un-used for debugfs to know what to print. */
+	for (z = 0; z < IEEE80211_MLD_MAX_NUM_LINKS; z++) {
+		link_sel_data[z].link_id = -1;
+		link_sel_data[z].chandef = NULL;
+	}
 
 	lockdep_assert_wiphy(mvm->hw->wiphy);
 
@@ -839,13 +865,15 @@ void iwl_mvm_select_links(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	 */
 	WARN_ON_ONCE(max_active_links > 2);
 
-	n_data = iwl_mvm_set_link_selection_data(vif, data, usable_links,
+	IWL_DEBUG_INFO(mvm, "iwl-mvm-select-links, max-active: %d  usable: %d\n",
+		       max_active_links, usable_links);
+	n_data = iwl_mvm_set_link_selection_data(mvm, vif, link_sel_data, usable_links,
 						 &best);
 
 	if (WARN(!n_data, "Couldn't find a valid grade for any link!\n"))
 		return;
 
-	best_link = &data[best];
+	best_link = &link_sel_data[best];
 	primary_link = best_link->link_id;
 	new_active_links = BIT(best_link->link_id);
 
@@ -856,8 +884,8 @@ void iwl_mvm_select_links(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 
 	for (u8 a = 0; a < n_data; a++)
 		for (u8 b = a + 1; b < n_data; b++) {
-			u16 esr_grade = iwl_mvm_get_esr_grade(vif, &data[a],
-							      &data[b],
+			u16 esr_grade = iwl_mvm_get_esr_grade(mvm, vif, &link_sel_data[a],
+							      &link_sel_data[b],
 							      &best_in_pair);
 
 			if (esr_grade <= max_esr_grade)
@@ -865,8 +893,8 @@ void iwl_mvm_select_links(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 
 			max_esr_grade = esr_grade;
 			primary_link = best_in_pair;
-			new_active_links = BIT(data[a].link_id) |
-					   BIT(data[b].link_id);
+			new_active_links = BIT(link_sel_data[a].link_id) |
+					   BIT(link_sel_data[b].link_id);
 		}
 
 	/* No valid pair was found, go with the best link */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 2ad615293c75..751d2c2bf541 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -102,7 +102,9 @@ struct iwl_mvm_phy_ctxt {
 	/* track for RLC config command */
 	u32 center_freq1;
 	bool rlc_disabled;
+	u32 channel_load;
 	u32 channel_load_by_us;
+	u32 channel_load_not_by_us;
 };
 
 struct iwl_mvm_time_event_data {
@@ -992,6 +994,18 @@ struct iwl_mvm_acs_survey {
 	struct iwl_mvm_acs_survey_channel channels[] __counted_by(n_channels);
 };
 
+struct iwl_mvm_link_sel_data {
+	u8 link_id;
+	const struct cfg80211_chan_def *chandef;
+	/* so we don't have to reference maybe stale chandef in debugfs */
+	u32 center_freq1;
+	s32 signal;
+	u16 grade;
+	u16 chan_load; /* reported by AP BSS Load IE */
+	u16 channel_load_by_us; /* reported by firmware */
+	u16 puncturing_penalty; /* driver calculates */
+};
+
 struct iwl_mvm {
 	/* for logger access */
 	struct device *dev;
@@ -1174,6 +1188,8 @@ struct iwl_mvm {
 
 	struct ieee80211_bss_conf __rcu *link_id_to_link_conf[IWL_FW_MAX_LINK_ID + 1];
 
+	struct iwl_mvm_link_sel_data link_sel_data[IEEE80211_MLD_MAX_NUM_LINKS];
+
 	/* -1 for always, 0 for never, >0 for that many times */
 	s8 fw_restart;
 	u8 *error_recovery_buf;
@@ -2124,13 +2140,6 @@ void iwl_mvm_select_links(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 u8 iwl_mvm_get_primary_link(struct ieee80211_vif *vif);
 u8 iwl_mvm_get_other_link(struct ieee80211_vif *vif, u8 link_id);
 
-struct iwl_mvm_link_sel_data {
-	u8 link_id;
-	const struct cfg80211_chan_def *chandef;
-	s32 signal;
-	u16 grade;
-};
-
 #if IS_ENABLED(CONFIG_IWLWIFI_KUNIT_TESTS)
 unsigned int iwl_mvm_get_link_grade(struct ieee80211_bss_conf *link_conf);
 bool iwl_mvm_mld_valid_link_pair(struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index 9e72db9bab40..7f285ee49097 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -787,8 +787,12 @@ static void iwl_mvm_handle_per_phy_stats(struct iwl_mvm *mvm,
 	for (i = 0; i < NUM_PHY_CTX; i++) {
 		if (!mvm->phy_ctxts[i].ref)
 			continue;
+		mvm->phy_ctxts[i].channel_load =
+			le32_to_cpu(per_phy[i].channel_load);
 		mvm->phy_ctxts[i].channel_load_by_us =
 			le32_to_cpu(per_phy[i].channel_load_by_us);
+		mvm->phy_ctxts[i].channel_load_not_by_us =
+			le32_to_cpu(per_phy[i].channel_load_not_by_us);
 	}
 }
 
-- 
2.42.0


