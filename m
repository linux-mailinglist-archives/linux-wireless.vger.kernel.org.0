Return-Path: <linux-wireless+bounces-30394-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B4FCF7A5E
	for <lists+linux-wireless@lfdr.de>; Tue, 06 Jan 2026 10:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB1AC3020C6B
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jan 2026 09:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1150171CD;
	Tue,  6 Jan 2026 09:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="NBz0/UeW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38344503B;
	Tue,  6 Jan 2026 09:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767693262; cv=none; b=HzF3HDRS6ymV2O2TTAoJvRHLzyn0jpob+JQ+2WDC6XnfqkRYy+iQTusjNDDOaPS1OKASzJt6HSQzz8wY8OHrL/04+tYkWBvbPLmAzRl6Nf9c8T8w4FWZk4hat+77zWUA09fPWtB6tZfXN8k1PeBeM4R+ziFTj2u+Qx9Aa83pR/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767693262; c=relaxed/simple;
	bh=jO2dwGXOFSKd4Poi40gZi6SA7vWAaZAILvVSLz9JD/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z+tqCLYeulFs9JUPPXc0KX3WIWUo8MTKJNscYwJt35uxYYP5MaETtJl/DHtaH5z/Rp+M6AGY3kDD8DhRzs82tWY23CfcIojQB/oFQtbO6aZYIVG3WODFkqX69tXxtNhGWZOnpRvgC9aJ5WQcThjWy8r4PE1r2K/SfYgt/ZlwNBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=NBz0/UeW; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Received: from simon-Latitude-5450.cni.e-technik.tu-dortmund.de ([129.217.186.82])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.18.1.16/8.18.1.16) with ESMTPSA id 6069sEkB016399
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 6 Jan 2026 10:54:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1767693254;
	bh=jO2dwGXOFSKd4Poi40gZi6SA7vWAaZAILvVSLz9JD/o=;
	h=From:To:Cc:Subject:Date;
	b=NBz0/UeWh1R2aEal/46w+ycJ/tFwQbmxQ++rNZ4XTE4kryMKbsfsioDcS3EEDY2M4
	 /mfojlSMgxiAPTbE6Bvc6Mv8S0hVWpkk8xAwiTSBqNAX0dKWv4OuQ+x+X4vLMwxrXI
	 x0fwQ3K+6xZQLmpqvOyzVLfL7uQDo7/WlE0wcR5s=
From: Simon Schippers <simon.schippers@tu-dortmund.de>
To: johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Simon Schippers <simon.schippers@tu-dortmund.de>
Subject: [PATCH RFC] wifi: mac80211: Update mesh rate control per beacon to restore correct MCS
Date: Tue,  6 Jan 2026 10:53:46 +0100
Message-ID: <20260106095346.706635-1-simon.schippers@tu-dortmund.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When operating two TP-Link EAP225 Outdoor v3 devices with OpenWrt [1] in
an 802.11s 5 GHz mesh (ath10k), I observed that the MCS does not recover
correctly after a link temporarily goes out of signal range and then
returns to good signal conditions. Instead, the low MCS selected when the
link goes out of signal range is retained even after signal quality
improves significantly. Only after a long delay (around 5 minutes) does
the rate control recover and select an appropriate higher MCS again.

I was able to reproduce this behavior reliably using a controlled test
setup with two mesh nodes connected through adjustable RF attenuators
(some details in [2]). In my measurements, the link commonly gets stuck
at MCS 2 (45 Mbit/s), resulting in a throughput of roughly 35 Mbit/s
despite great signal conditions.

I experimented with various 802.11s and ath10k configuration parameters,
but none resolved the issue.

To address this, the proposed patch triggers a rate control
initialization/update every time mesh_sta_info_init() is invoked, even if
a beacon has already been processed. With this change, the MCS is updated
correctly when signal conditions improve, and the observed issue is
resolved in my setup (not posted in [2] for now).

As I do not know if this is the right approach to solve this issue, I am
submitting this patch as an RFC.

Thanks :)
Simon

[1] Link: https://openwrt.org/toh/tp-link/eap225
[2] Link: https://forum.openwrt.org/t/802-11s-batman-5ghz-mesh-stuck-at-mcs-2-after-getting-into-range-again/243461

Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
---
 net/mac80211/mesh_plink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mesh_plink.c b/net/mac80211/mesh_plink.c
index 04c931cd2063..66d735e18461 100644
--- a/net/mac80211/mesh_plink.c
+++ b/net/mac80211/mesh_plink.c
@@ -425,68 +425,69 @@ u64 mesh_plink_deactivate(struct sta_info *sta)
 static void mesh_sta_info_init(struct ieee80211_sub_if_data *sdata,
 			       struct sta_info *sta,
 			       struct ieee802_11_elems *elems)
 {
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_supported_band *sband;
 	u32 rates, changed = 0;
 	enum ieee80211_sta_rx_bandwidth bw = sta->sta.deflink.bandwidth;
 
 	sband = ieee80211_get_sband(sdata);
 	if (!sband)
 		return;
 
 	rates = ieee80211_sta_get_rates(sdata, elems, sband->band, NULL);
 
 	spin_lock_bh(&sta->mesh->plink_lock);
 	sta->deflink.rx_stats.last_rx = jiffies;
 
 	/* rates and capabilities don't change during peering */
 	if (sta->mesh->plink_state == NL80211_PLINK_ESTAB &&
 	    sta->mesh->processed_beacon)
 		goto out;
 	sta->mesh->processed_beacon = true;
 
 	if (sta->sta.deflink.supp_rates[sband->band] != rates)
 		changed |= IEEE80211_RC_SUPP_RATES_CHANGED;
 	sta->sta.deflink.supp_rates[sband->band] = rates;
 
 	if (ieee80211_ht_cap_ie_to_sta_ht_cap(sdata, sband,
 					      elems->ht_cap_elem,
 					      &sta->deflink))
 		changed |= IEEE80211_RC_BW_CHANGED;
 
 	ieee80211_vht_cap_ie_to_sta_vht_cap(sdata, sband,
 					    elems->vht_cap_elem, NULL,
 					    &sta->deflink);
 
 	ieee80211_he_cap_ie_to_sta_he_cap(sdata, sband, elems->he_cap,
 					  elems->he_cap_len,
 					  elems->he_6ghz_capa,
 					  &sta->deflink);
 
 	ieee80211_eht_cap_ie_to_sta_eht_cap(sdata, sband, elems->he_cap,
 					    elems->he_cap_len,
 					    elems->eht_cap, elems->eht_cap_len,
 					    &sta->deflink);
 
 	if (bw != sta->sta.deflink.bandwidth)
 		changed |= IEEE80211_RC_BW_CHANGED;
 
 	/* HT peer is operating 20MHz-only */
 	if (elems->ht_operation &&
 	    !(elems->ht_operation->ht_param &
 	      IEEE80211_HT_PARAM_CHAN_WIDTH_ANY)) {
 		if (sta->sta.deflink.bandwidth != IEEE80211_STA_RX_BW_20)
 			changed |= IEEE80211_RC_BW_CHANGED;
 		sta->sta.deflink.bandwidth = IEEE80211_STA_RX_BW_20;
 	}
 
+out:
 	/* FIXME: this check is wrong without SW rate control */
 	if (!test_sta_flag(sta, WLAN_STA_RATE_CONTROL))
 		rate_control_rate_init(&sta->deflink);
 	else
 		rate_control_rate_update(local, sband, &sta->deflink, changed);
-out:
+
 	spin_unlock_bh(&sta->mesh->plink_lock);
 }
 
-- 
2.43.0


