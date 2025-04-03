Return-Path: <linux-wireless+bounces-21146-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69495A7AC35
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 21:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 451B717D88D
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 19:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1831826A0CA;
	Thu,  3 Apr 2025 19:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOtEY6F6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3DE2571CD;
	Thu,  3 Apr 2025 19:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707180; cv=none; b=VFtqS1DM8I0ciDhBv+YLFzY1IzT2wXaKv7N4VQO56i3fZ2Owykv50jEUPpu2Xnr1vDNaolRBsvmi9dLqDy7KPllQOpyzeLN1YJb0USKMx6BeDrVLxsu3lU5X8tLacAZmYlaeRoLKquBPLpgiqTCkaYyJvkTpuMA7NgPV3f3n3nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707180; c=relaxed/simple;
	bh=x4Q0Inl/TWYjoBEGRiqTxNRzs76JVffOsO0uqpTrykg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eIXjd2bOEe1c2vlI1tbRuE8A76GAYYXUD6TQbDMSeS70nzOzAMLts/vYjZdiOqa/MFOvC7gsrBQ0fAq0kwQMzZrX81qEu41r8JohT7KLNQJyiBCKjSwkj6gh/IRLYVV/wk4mp23D0hdQanvA1r9k6ew7JzNheeIaJI9O40MtCpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOtEY6F6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D31ACC4CEE3;
	Thu,  3 Apr 2025 19:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707179;
	bh=x4Q0Inl/TWYjoBEGRiqTxNRzs76JVffOsO0uqpTrykg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YOtEY6F6kTrwOos/RVx7VYUUSxgoKKXj+SXbukc3yTc1pOA8OQIN/i+luu9+ZNf9E
	 ZL28A5Ln2gEeMlKN3pqyiU4G8Tcumm2dMELT7gBKLgyFXC3FUkZMIjFcyIvUG5VU0j
	 Tj6DCRlpDpqJOdNw3HS3F7HwWEwG75wU3929dg4js7C/NA4CdcsQV0ddwIKKH6h+nG
	 mzz5QBu0cHwhdM3K06MGdBRM7gZ6VsLQPWcwWYHzU8YGIcoY48bzw5U3s0HoBQFRuY
	 Ql8vx9UB1GQwG10nhdUT66rY3eQNZ60m68eiTVeqL5WOKzq60zXD76N+wRmLArsunP
	 Rm/LbiQbzXcVQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 10/47] wifi: mac80211: add strict mode disabling workarounds
Date: Thu,  3 Apr 2025 15:05:18 -0400
Message-Id: <20250403190555.2677001-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190555.2677001-1-sashal@kernel.org>
References: <20250403190555.2677001-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 3ad4fce66e4f9d82abfc366707757e29cc14a9d2 ]

Add a strict mode where we disable certain workarounds and have
additional checks such as, for now, that VHT capabilities from
association response match those from beacon/probe response. We
can extend the checks in the future.

Make it an opt-in setting by the driver so it can be set there
in some driver-specific way, for example. Also allow setting
this one hw flag through the hwflags debugfs, by writing a new
strict=0 or strict=1 value.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20250205110958.5cecb0469479.I4a69617dc60ba0d6308416ffbc3102cfd08ba068@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/mac80211.h |  6 ++++++
 net/mac80211/debugfs.c | 44 +++++++++++++++++++++++++++++++++++++++--
 net/mac80211/mlme.c    | 45 +++++++++++++++++++++++++++++-------------
 3 files changed, 79 insertions(+), 16 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 5b712582f9a9c..3b964f8834e71 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2826,6 +2826,11 @@ struct ieee80211_txq {
  *	implements MLO, so operation can continue on other links when one
  *	link is switching.
  *
+ * @IEEE80211_HW_STRICT: strictly enforce certain things mandated by the spec
+ *	but otherwise ignored/worked around for interoperability. This is a
+ *	HW flag so drivers can opt in according to their own control, e.g. in
+ *	testing.
+ *
  * @NUM_IEEE80211_HW_FLAGS: number of hardware flags, used for sizing arrays
  */
 enum ieee80211_hw_flags {
@@ -2885,6 +2890,7 @@ enum ieee80211_hw_flags {
 	IEEE80211_HW_DISALLOW_PUNCTURING,
 	IEEE80211_HW_DISALLOW_PUNCTURING_5GHZ,
 	IEEE80211_HW_HANDLES_QUIET_CSA,
+	IEEE80211_HW_STRICT,
 
 	/* keep last, obviously */
 	NUM_IEEE80211_HW_FLAGS
diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index 02b5476a4376c..a0710ae0e7a49 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -499,6 +499,7 @@ static const char *hw_flag_names[] = {
 	FLAG(DISALLOW_PUNCTURING),
 	FLAG(DISALLOW_PUNCTURING_5GHZ),
 	FLAG(HANDLES_QUIET_CSA),
+	FLAG(STRICT),
 #undef FLAG
 };
 
@@ -531,6 +532,46 @@ static ssize_t hwflags_read(struct file *file, char __user *user_buf,
 	return rv;
 }
 
+static ssize_t hwflags_write(struct file *file, const char __user *user_buf,
+			     size_t count, loff_t *ppos)
+{
+	struct ieee80211_local *local = file->private_data;
+	char buf[100];
+	int val;
+
+	if (count >= sizeof(buf))
+		return -EINVAL;
+
+	if (copy_from_user(buf, user_buf, count))
+		return -EFAULT;
+
+	if (count && buf[count - 1] == '\n')
+		buf[count - 1] = '\0';
+	else
+		buf[count] = '\0';
+
+	if (sscanf(buf, "strict=%d", &val) == 1) {
+		switch (val) {
+		case 0:
+			ieee80211_hw_set(&local->hw, STRICT);
+			return count;
+		case 1:
+			__clear_bit(IEEE80211_HW_STRICT, local->hw.flags);
+			return count;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static const struct file_operations hwflags_ops = {
+	.open = simple_open,
+	.read = hwflags_read,
+	.write = hwflags_write,
+};
+
 static ssize_t misc_read(struct file *file, char __user *user_buf,
 			 size_t count, loff_t *ppos)
 {
@@ -581,7 +622,6 @@ static ssize_t queues_read(struct file *file, char __user *user_buf,
 	return simple_read_from_buffer(user_buf, count, ppos, buf, res);
 }
 
-DEBUGFS_READONLY_FILE_OPS(hwflags);
 DEBUGFS_READONLY_FILE_OPS(queues);
 DEBUGFS_READONLY_FILE_OPS(misc);
 
@@ -659,7 +699,7 @@ void debugfs_hw_add(struct ieee80211_local *local)
 #ifdef CONFIG_PM
 	DEBUGFS_ADD_MODE(reset, 0200);
 #endif
-	DEBUGFS_ADD(hwflags);
+	DEBUGFS_ADD_MODE(hwflags, 0600);
 	DEBUGFS_ADD(user_power);
 	DEBUGFS_ADD(power);
 	DEBUGFS_ADD(hw_conf);
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 88751b0eb317a..ad0d040569dcd 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -166,6 +166,9 @@ ieee80211_determine_ap_chan(struct ieee80211_sub_if_data *sdata,
 	bool no_vht = false;
 	u32 ht_cfreq;
 
+	if (ieee80211_hw_check(&sdata->local->hw, STRICT))
+		ignore_ht_channel_mismatch = false;
+
 	*chandef = (struct cfg80211_chan_def) {
 		.chan = channel,
 		.width = NL80211_CHAN_WIDTH_20_NOHT,
@@ -385,7 +388,7 @@ ieee80211_verify_peer_he_mcs_support(struct ieee80211_sub_if_data *sdata,
 	 * zeroes, which is nonsense, and completely inconsistent with itself
 	 * (it doesn't have 8 streams). Accept the settings in this case anyway.
 	 */
-	if (!ap_min_req_set)
+	if (!ieee80211_hw_check(&sdata->local->hw, STRICT) && !ap_min_req_set)
 		return true;
 
 	/* make sure the AP is consistent with itself
@@ -445,7 +448,7 @@ ieee80211_verify_sta_he_mcs_support(struct ieee80211_sub_if_data *sdata,
 	 * zeroes, which is nonsense, and completely inconsistent with itself
 	 * (it doesn't have 8 streams). Accept the settings in this case anyway.
 	 */
-	if (!ap_min_req_set)
+	if (!ieee80211_hw_check(&sdata->local->hw, STRICT) && !ap_min_req_set)
 		return true;
 
 	/* Need to go over for 80MHz, 160MHz and for 80+80 */
@@ -1212,13 +1215,15 @@ static bool ieee80211_add_vht_ie(struct ieee80211_sub_if_data *sdata,
 	 * Some APs apparently get confused if our capabilities are better
 	 * than theirs, so restrict what we advertise in the assoc request.
 	 */
-	if (!(ap_vht_cap->vht_cap_info &
-			cpu_to_le32(IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE)))
-		cap &= ~(IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE |
-			 IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE);
-	else if (!(ap_vht_cap->vht_cap_info &
-			cpu_to_le32(IEEE80211_VHT_CAP_MU_BEAMFORMER_CAPABLE)))
-		cap &= ~IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE;
+	if (!ieee80211_hw_check(&local->hw, STRICT)) {
+		if (!(ap_vht_cap->vht_cap_info &
+				cpu_to_le32(IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE)))
+			cap &= ~(IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE |
+				 IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE);
+		else if (!(ap_vht_cap->vht_cap_info &
+				cpu_to_le32(IEEE80211_VHT_CAP_MU_BEAMFORMER_CAPABLE)))
+			cap &= ~IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE;
+	}
 
 	/*
 	 * If some other vif is using the MU-MIMO capability we cannot associate
@@ -1260,14 +1265,16 @@ static bool ieee80211_add_vht_ie(struct ieee80211_sub_if_data *sdata,
 	return mu_mimo_owner;
 }
 
-static void ieee80211_assoc_add_rates(struct sk_buff *skb,
+static void ieee80211_assoc_add_rates(struct ieee80211_local *local,
+				      struct sk_buff *skb,
 				      enum nl80211_chan_width width,
 				      struct ieee80211_supported_band *sband,
 				      struct ieee80211_mgd_assoc_data *assoc_data)
 {
 	u32 rates;
 
-	if (assoc_data->supp_rates_len) {
+	if (assoc_data->supp_rates_len &&
+	    !ieee80211_hw_check(&local->hw, STRICT)) {
 		/*
 		 * Get all rates supported by the device and the AP as
 		 * some APs don't like getting a superset of their rates
@@ -1481,7 +1488,7 @@ static size_t ieee80211_assoc_link_elems(struct ieee80211_sub_if_data *sdata,
 		*capab |= WLAN_CAPABILITY_SPECTRUM_MGMT;
 
 	if (sband->band != NL80211_BAND_S1GHZ)
-		ieee80211_assoc_add_rates(skb, width, sband, assoc_data);
+		ieee80211_assoc_add_rates(local, skb, width, sband, assoc_data);
 
 	if (*capab & WLAN_CAPABILITY_SPECTRUM_MGMT ||
 	    *capab & WLAN_CAPABILITY_RADIO_MEASURE) {
@@ -1925,7 +1932,8 @@ static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 	 * for some reason check it and want it to be set, set the bit for all
 	 * pre-EHT connections as we used to do.
 	 */
-	if (link->u.mgd.conn.mode < IEEE80211_CONN_MODE_EHT)
+	if (link->u.mgd.conn.mode < IEEE80211_CONN_MODE_EHT &&
+	    !ieee80211_hw_check(&local->hw, STRICT))
 		capab |= WLAN_CAPABILITY_ESS;
 
 	/* add the elements for the assoc (main) link */
@@ -4710,7 +4718,7 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 	 * 2G/3G/4G wifi routers, reported models include the "Onda PN51T",
 	 * "Vodafone PocketWiFi 2", "ZTE MF60" and a similar T-Mobile device.
 	 */
-	if (!is_6ghz &&
+	if (!ieee80211_hw_check(&local->hw, STRICT) && !is_6ghz &&
 	    ((assoc_data->wmm && !elems->wmm_param) ||
 	     (link->u.mgd.conn.mode >= IEEE80211_CONN_MODE_HT &&
 	      (!elems->ht_cap_elem || !elems->ht_operation)) ||
@@ -4846,6 +4854,15 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 				bss_vht_cap = (const void *)elem->data;
 		}
 
+		if (ieee80211_hw_check(&local->hw, STRICT) &&
+		    (!bss_vht_cap || memcmp(bss_vht_cap, elems->vht_cap_elem,
+					    sizeof(*bss_vht_cap)))) {
+			rcu_read_unlock();
+			ret = false;
+			link_info(link, "VHT capabilities mismatch\n");
+			goto out;
+		}
+
 		ieee80211_vht_cap_ie_to_sta_vht_cap(sdata, sband,
 						    elems->vht_cap_elem,
 						    bss_vht_cap, link_sta);
-- 
2.39.5


