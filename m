Return-Path: <linux-wireless+bounces-14511-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDA09AFD2B
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 10:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3DFE1F21077
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 08:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661851B6D00;
	Fri, 25 Oct 2024 08:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="OLYWWilC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE76156F30
	for <linux-wireless@vger.kernel.org>; Fri, 25 Oct 2024 08:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729846298; cv=none; b=iGuaBa3X95+MhR1/nh69KkyBc9PlrK5/J05DezPVjYhjinTkpOuAUZsFUGBKkyi0lbbjnNH1J6sZLJjJzLA0oXoy18yhhRrUw9Fk8/TKvhmEKxX7FIxYf0yXRlI7x1kf5HGpGq8zeptx6OpBadxA0ROIL+Hk+LTwIJdPft0HG5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729846298; c=relaxed/simple;
	bh=9Z66yuggouTPTAvOpU2HQi8vjC7+r/GBH6eOCA4CAWo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oXKA6Bz6yZwsYabP9XkZmzeLPKdTIprSVqdlXzKmAK6GuSZogW9oTjxZEKUG4wgwCNX/mGcL6gycIiq7a+2lAdXEWdegxaDIoBCL9ZLtNKhkBZkv70zRKZP31E+YHOQde+AhkDZ9K9+6B1Chdj5gAy3y8i6uEuEHTiDl8pbWHJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=OLYWWilC; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=orf+AuWOtXUvmVe/yyQb7pgAFK166BkKV1F03TU8csQ=;
	t=1729846296; x=1731055896; b=OLYWWilC9Etnz2YDD+DmReA7Zf2+191th3isKK6YoV48AUA
	8TTZpytVmQsUgbYP0AQLs+UgjFw+H+Ek/SPbuq8MZHqi1fvz/aAE61nGutXD6vHAsyEPXDmASasPP
	KhlKK5lPZV5UU4wTrkxcPYlQi7DDIZF+xJhZk1EqjXsTSbJrYWW7AevsWrHz3h84/fcWOuZM/MOGS
	PS07Me2dFOFGPttWdgb3zfqtnX2OVgJw7OLbskVo2KGxMWRiUpEM8f5VHtLpFDI+r4/cg/vLsDdgv
	X9PoNvWBgewW5PNzprTVu1GGiBTzCW/YWjJF+DgiWbrWd5i0ddANb5nhauAMTr5A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t4G2e-00000004RhA-1lO8;
	Fri, 25 Oct 2024 10:51:32 +0200
Message-ID: <d33d9883648df26d61bb801c515ee2a3a014515d.camel@sipsolutions.net>
Subject: Re: [PATCH v2 2/2] wifi: mac80211: restructure vif and link conf
 for mlo mbssid support
From: Johannes Berg <johannes@sipsolutions.net>
To: Muna Sinada <quic_msinada@quicinc.com>
Cc: linux-wireless@vger.kernel.org, Rameshkumar Sundaram
	 <quic_ramess@quicinc.com>
Date: Fri, 25 Oct 2024 10:51:31 +0200
In-Reply-To: <20241025013857.2793346-3-quic_msinada@quicinc.com>
References: <20241025013857.2793346-1-quic_msinada@quicinc.com>
	 <20241025013857.2793346-3-quic_msinada@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned


> +++ b/include/net/mac80211.h
> @@ -682,6 +682,8 @@ struct ieee80211_parsed_tpe {
>   *	responder functionality.
>   * @ftmr_params: configurable lci/civic parameter when enabling FTM resp=
onder.
>   * @nontransmitted: this BSS is a nontransmitted BSS profile
> + * @mbssid_tx_bss: Pointer to the BSS configuration of transmitting inte=
rface
> + *	if MBSSID is enabled.
>   * @transmitter_bssid: the address of transmitter AP
>   * @bssid_index: index inside the multiple BSSID set
>   * @bssid_indicator: 2^bssid_indicator is the maximum number of APs in s=
et
> @@ -790,6 +792,7 @@ struct ieee80211_bss_conf {
>  	struct ieee80211_ftm_responder_params *ftmr_params;
>  	/* Multiple BSSID data */
>  	bool nontransmitted;
> +	struct ieee80211_bss_conf *mbssid_tx_bss;

Please say a few words about the safety of accessing this pointer.

It doesn't _feel_ safe to me, if the vif/bss_conf itself may have been
reached via RCU for example. But I won't say that my gut feeling here is
necessarily correct. Please check and comment.

> @@ -2032,8 +2034,6 @@ struct ieee80211_vif {
>  	bool probe_req_reg;
>  	bool rx_mcast_action_reg;
> =20
> -	struct ieee80211_vif *mbssid_tx_vif;

The same would've been true before, I guess, though perhaps less likely
to have been an issue since the other netdev must obviously be unlinked
first. Still pointer races could happen if they both go away at the same
time and we have a stale one via RCU?

> @@ -3636,23 +3651,43 @@ void ieee80211_csa_finish(struct ieee80211_vif *v=
if, unsigned int link_id)
>  		return;
>  	}
> =20
> -	/* TODO: MBSSID with MLO changes */
> -	if (vif->mbssid_tx_vif =3D=3D vif) {
> +	if (link_data->conf->mbssid_tx_bss =3D=3D vif->link_conf[link_id]) {

And this shouldn't even build without (sparse) warnings (for similar
reasons)?

> +			valid_links =3D iter->vif.valid_links | BIT(0);
> +			for_each_set_bit(link_id_iter, &valid_links,
> +					 IEEE80211_MLD_MAX_NUM_LINKS) {

for_each_vif_active_link() is probably enough, on AP side you can't have
active !=3D valid links I think. Or for_each_valid_link()?

> +				link_iter =3D
> +				      rcu_dereference(iter->link[link_id_iter]);
> +				if (!link_iter)
> +					continue;
> +				/* Check if any of link of iterator sdata
> +				 * belongs to same mbssid group as the tx link
> +				 */
> +				if (link_iter->conf->mbssid_tx_bss !=3D
> +				    vif->link_conf[link_id])
> +					continue;
> +
> +				wiphy_work_queue(iter->local->hw.wiphy,
> +						 &link_iter->csa.finalize_work);

This really got indented a bit too far anyway though - hardly readable
at all. Please refactor.

Or you could use for_each_sdata_link() I guess, at the small expense of
iterating all links of the interfaces you're going to skip anyway, but
that seems hardly important here?

> +			}
>  		}
>  	}
>  	wiphy_work_queue(local->hw.wiphy, &link_data->csa.finalize_work);
> @@ -4757,15 +4792,35 @@ ieee80211_color_change_bss_config_notify(struct i=
eee80211_link_data *link,
> =20
>  	ieee80211_link_info_change_notify(sdata, link, changed);
> =20
> -	if (!sdata->vif.bss_conf.nontransmitted && sdata->vif.mbssid_tx_vif) {
> +	if (!link->conf->nontransmitted && link->conf->mbssid_tx_bss) {
>  		struct ieee80211_sub_if_data *child;
> +		unsigned int link_id_iter;
> +		unsigned long valid_links;
> +		struct ieee80211_link_data *link_iter;
> =20
>  		list_for_each_entry(child, &sdata->local->interfaces, list) {
> -			if (child !=3D sdata && child->vif.mbssid_tx_vif =3D=3D &sdata->vif) =
{
> -				child->vif.bss_conf.he_bss_color.color =3D color;
> -				child->vif.bss_conf.he_bss_color.enabled =3D enable;
> +			if (child =3D=3D sdata)
> +				continue;

All the same comments here ...

> +	lockdep_assert_wiphy(sdata->local->hw.wiphy);
> +	/* Check link 0 by default for non MLO. */
> +	iter_valid_links =3D sdata->vif.valid_links | BIT(0);
> +	/* Check if any of the links of current sdata is an MBSSID. */
> +	for_each_set_bit(iter_link_id, &iter_valid_links,
> +			 IEEE80211_MLD_MAX_NUM_LINKS) {

And also here.

> +++ b/net/wireless/sme.c
> @@ -1581,7 +1581,7 @@ void cfg80211_autodisconnect_wk(struct work_struct =
*work)
>  		container_of(work, struct wireless_dev, disconnect_wk);
>  	struct cfg80211_registered_device *rdev =3D wiphy_to_rdev(wdev->wiphy);
> =20
> -	wiphy_lock(wdev->wiphy);
> +	wiphy_lock(&rdev->wiphy);
> =20
>  	if (wdev->conn_owner_nlportid) {
>  		switch (wdev->iftype) {
> @@ -1618,5 +1618,5 @@ void cfg80211_autodisconnect_wk(struct work_struct =
*work)
>  		}
>  	}
> =20
> -	wiphy_unlock(wdev->wiphy);
> +	wiphy_unlock(&rdev->wiphy);
>  }

?????

johannes

