Return-Path: <linux-wireless+bounces-31458-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNMQJluogGmeAAMAu9opvQ
	(envelope-from <linux-wireless+bounces-31458-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 14:36:27 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AB562CCCF0
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 14:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BC0B93002D32
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Feb 2026 13:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3154936996C;
	Mon,  2 Feb 2026 13:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="igQPhijF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8537936923C;
	Mon,  2 Feb 2026 13:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770039372; cv=none; b=UJoGHktnrwJ9rBzsjBYu+DR9L2ClmJZMWatyDpmi6G4poxdugeH++ccTl6G7QWepgKrUBdfM0lU+cjkP6EfgARRR2huucWQxs8D7OTogd3WA23PVcTgzkCLSTHEnveeAw0ZYS+yBqJzrFsMT6SflNaVwVubkZDZjxGe1F4c57Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770039372; c=relaxed/simple;
	bh=jO2dwGXOFSKd4Poi40gZi6SA7vWAaZAILvVSLz9JD/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qVxESYRIoIXZLUZEpD/E7MTrYYEBG6ngJXNbItL06qwt6+ojILlDUC3Vl94dMAAAhcmr8gdR2hBmqxJRa9JqRswgaMYbNN6zuITFSh/jJ4Z/AmlWDEGFIzkkPcSYCwd9UeITm1Z1l3LRam1tSAg6ddBeiRhYS3kah56BMxOgea8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=igQPhijF; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Received: from simon-Latitude-5450.cni.e-technik.tu-dortmund.de ([129.217.186.201])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.18.1.16/8.18.1.16) with ESMTPSA id 612Da50r020155
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 2 Feb 2026 14:36:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1770039366;
	bh=jO2dwGXOFSKd4Poi40gZi6SA7vWAaZAILvVSLz9JD/o=;
	h=From:To:Cc:Subject:Date;
	b=igQPhijFzPFuK4FLhX9PJ4wD2LXsFQs43WeErJLKrQ3+UAMEruFXPE/olt1T6FBEs
	 LPCHVi0klKKDZIndKeTNJyah+4iezLhyT0gmJCaXGv/FQlZg2/2hWpZQH+Q7E4cY2I
	 f510IPJM55fop5vryh/NGV9NvkYSBcVwNj/Dz1U4=
From: Simon Schippers <simon.schippers@tu-dortmund.de>
To: johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Simon Schippers <simon.schippers@tu-dortmund.de>
Subject: [PATCH RFC RESEND] wifi: mac80211: Update mesh rate control per beacon to restore correct MCS
Date: Mon,  2 Feb 2026 14:35:32 +0100
Message-ID: <20260202133532.814017-1-simon.schippers@tu-dortmund.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[tu-dortmund.de,none];
	R_DKIM_ALLOW(-0.20)[tu-dortmund.de:s=unimail];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31458-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[simon.schippers@tu-dortmund.de,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tu-dortmund.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,tu-dortmund.de:email,tu-dortmund.de:dkim,tu-dortmund.de:mid]
X-Rspamd-Queue-Id: AB562CCCF0
X-Rspamd-Action: no action

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


