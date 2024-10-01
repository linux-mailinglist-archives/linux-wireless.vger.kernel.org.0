Return-Path: <linux-wireless+bounces-13369-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE6A98B8C5
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 11:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDBC31C21B07
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 09:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E706B1A00D0;
	Tue,  1 Oct 2024 09:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="VJD4nBFX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F49B19FA87
	for <linux-wireless@vger.kernel.org>; Tue,  1 Oct 2024 09:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727776764; cv=none; b=B+8Vl4bfKTmoBPaWfSOYWNLBlmPVrNf9lVvzHW3Qb8dR+pxfhO8qk8mcRgY40D/9JuFbM12udlPMA4E0BQjeT3S/EyFlDF+6h4yCBtgku14dmUZ3gInRP/7QS0KZn91KBZrLyz0l1vUr7fyYcz1L4dGvRPwdgPHCjpc/+WAcCAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727776764; c=relaxed/simple;
	bh=e3VWpjrkkVnOE4J5vs3D0E+euxN5x6KBFBaQ22mWmJc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k0b0az8WKp9q1kBlAhG/FNPnXEQKD8722NdlNjTZzCO6XmB6EiwrKvJ8h+KmYyKuXIuU8CZSTRSrSUa1SJLL0sNu2hDOV3YvuBSPG/g2L8pJwakCpewZI2wZuxzzz8Z6uPuBdeQfDpWElTFNWL5hW780cvK3UXy+0NCBAQT5HnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=VJD4nBFX; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=nCnBD1U7QvNvLUmdBdi6Nq3cRHnR8hJD3Ky8Id7tHF8=;
	t=1727776763; x=1728986363; b=VJD4nBFXXFtQ2wu09WBIG+XyY2Jap2d7FY1+pck8J+DdTX5
	44UkS1+SxD2c6gqir/2zWUIiYM0c+hopf6pAaaaFDNof3OKIBzlosUECRvxZzQUTz6WxXT2gJM/Aa
	UEkuhWnvhnxbJgIYcqgvQ1dHcDMbFCM8BmgAr7j4MKBYgdXIKWahaW1K4AD+re49GlwJUpgA6p3Mc
	OIW+3k8ItMfLoXz4HL4ZfvDGOBBSKGOyK7PnuS7LOB9vmdCv5VdJxfwh4on8EP7dnVph8vA5S3u/Z
	6yGFmVCmX9F1otpeW7v8YqL8kU6S6KTmoRhTNIW/uQVWL2tbjcBGT0Y0Aj0fG5lg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1svZf5-0000000Ei2N-3UIk;
	Tue, 01 Oct 2024 11:59:20 +0200
Message-ID: <93df47a867ee1f8d84cabdbc953707eab2ea3704.camel@sipsolutions.net>
Subject: Re: [PATCH v2] wifi: mac80211: re-order assigning channel in
 activate links
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
Date: Tue, 01 Oct 2024 11:59:19 +0200
In-Reply-To: <20241001085034.2745669-1-quic_adisi@quicinc.com>
References: <20241001085034.2745669-1-quic_adisi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-10-01 at 14:20 +0530, Aditya Kumar Singh wrote:
> The current flow in _ieee80211_set_active_links() does not align with the
> operational requirements of drivers that groups multiple hardware
> under a single wiphy. These drivers (e.g ath12k) rely on channel
> assignment to determine the appropriate hardware for each link. Without
> this, the drivers cannot correctly establish the link interface.
>=20
> Currently in _ieee80211_set_active_links(), after calling
> drv_change_vif_links() on the driver, the state of all connected stations
> is updated via drv_change_sta_links(). This is followed by handling keys
> in the links, and finally, assigning the channel to the links.
> Consequently, drv_change_sta_links() prompts drivers to create the statio=
n
> entry at their level and within their firmware. However, since channels
> have not yet been assigned to links at this stage, drivers have not
> created the necessary link interface for establishing link stations,
> leading to failures in activating the links.
>=20
> Therefore, re-order the logic so that after drv_change_vif_links() and
> removing the old links, channels are assigned to newly added links.
> Following this, the flow proceeds to station handling.
>=20

I tried this again but I fear it fundamentally cannot work with iwlwifi.

We have this comment:

        /* Initialize rate control for the AP station, since we might be
         * doing a link switch here - we cannot initialize it before since
         * this needs the phy context assigned (and in FW?), and we cannot
         * do it later because it needs to be initialized as soon as we're
         * able to TX on the link, i.e. when active.
         */

which sort of indicates that we're working around it, but it also
correctly says that we cannot activate a link before we have the (link)
station.

In the flow as you changed it we'd activate the link in firmware before
the stations are added, but that isn't allowed. There's not really a
good place to hook into after the station is added, unless we somehow
want to activate the link from the station change, but that seems ...
odd to say the least? Though I guess it's already somewhat odd to init
rate control here as written now...

Maybe we can hook into the later link info change. This seems to
initially work, but still doing more tests:


diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/driver=
s/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 9753d2c1df3e..5d90fb53b762 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -343,33 +343,20 @@ __iwl_mvm_mld_assign_vif_chanctx(struct iwl_mvm *mvm,
 	if (ret)
 		goto out;
=20
-	/* Initialize rate control for the AP station, since we might be
-	 * doing a link switch here - we cannot initialize it before since
-	 * this needs the phy context assigned (and in FW?), and we cannot
-	 * do it later because it needs to be initialized as soon as we're
-	 * able to TX on the link, i.e. when active.
+	/*
+	 * if link switching (link not active yet) we'll activate it in
+	 * firmware later on link-info change, which mac80211 guarantees
+	 * for link switch after the stations are set up
 	 */
-	if (mvmvif->ap_sta) {
-		struct ieee80211_link_sta *link_sta;
-
-		rcu_read_lock();
-		link_sta =3D rcu_dereference(mvmvif->ap_sta->link[link_id]);
-
-		if (!WARN_ON_ONCE(!link_sta))
-			iwl_mvm_rs_rate_init(mvm, vif, mvmvif->ap_sta,
-					     link_conf, link_sta,
-					     phy_ctxt->channel->band);
-		rcu_read_unlock();
+	if (ieee80211_vif_link_active(vif, link_conf->link_id)) {
+		ret =3D iwl_mvm_link_changed(mvm, vif, link_conf,
+					   LINK_CONTEXT_MODIFY_ACTIVE |
+					   LINK_CONTEXT_MODIFY_RATES_INFO,
+					   true);
+		if (ret)
+			goto out;
 	}
=20
-	/* then activate */
-	ret =3D iwl_mvm_link_changed(mvm, vif, link_conf,
-				   LINK_CONTEXT_MODIFY_ACTIVE |
-				   LINK_CONTEXT_MODIFY_RATES_INFO,
-				   true);
-	if (ret)
-		goto out;
-
 	if (vif->type =3D=3D NL80211_IFTYPE_STATION)
 		iwl_mvm_send_ap_tx_power_constraint_cmd(mvm, vif,
 							link_conf,
@@ -786,6 +773,11 @@ iwl_mvm_mld_link_info_changed_station(struct iwl_mvm *=
mvm,
 	if (WARN_ON_ONCE(!mvmvif->link[link_conf->link_id]))
 		return;
=20
+	/* not yet marked active in vif means during link switch */
+	if (!ieee80211_vif_link_active(vif, link_conf->link_id) &&
+	    vif->cfg.assoc && mvmvif->link[link_conf->link_id]->phy_ctxt)
+		link_changes |=3D LINK_CONTEXT_MODIFY_ACTIVE;
+
 	has_he =3D link_conf->he_support && !iwlwifi_mod_params.disable_11ax;
 	has_eht =3D link_conf->eht_support && !iwlwifi_mod_params.disable_11be;
=20


johannes

