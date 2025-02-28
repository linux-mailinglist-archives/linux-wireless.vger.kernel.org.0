Return-Path: <linux-wireless+bounces-19578-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D70C8A499BA
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 13:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B00373AA2D7
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 12:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D701A3BD7;
	Fri, 28 Feb 2025 12:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Nzy92Aup"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A190C26B2DE
	for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 12:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740746796; cv=none; b=Yu55ND3CCDdFpUXL2zRWzOw6NxS2nmYqlZw9PDuUeJwi6kypPOPumPukPWVuVv7Wt0K17h6f4OovuH+LXehmf9BsrfR0WSFlB46UBERALC1zjtFDEjpeA12DDzNmiFYXTzLfPTYkaE1TKIqyldt3CIoHoH8cHHr4XyHpPylN9iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740746796; c=relaxed/simple;
	bh=kikcQnXjAoSFmMpTA94WHzhNNEW8zAYGK1hKrGm4Hc0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d3lUIrRx0PMBZwC20xbXQwjqWFNYiPw1auSav7M7pZMzWr7ws+0kVTcGcQg371oQaL9tYxt02bXXQ1Y8fQ2IRVPaOxfcJC2Ltkr+YTVLH4Lw0HJXt09p5CniciCjzd6i0hBiSrnGM/FNERimS+CdpC8ZsGm0pJOlmRF7BYgdPic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Nzy92Aup; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=SP9g1ecrL0MxmICMni8DABlBWg2gpZkDmVSmgoO2jSs=;
	t=1740746794; x=1741956394; b=Nzy92AupY+0og7l7NCRYG+A9WBLwtFARAy5TllSRRM20UBC
	IBTOEHi5eZaY6JqnsAi3ffj7FxyKJUmle1D01p64zLv+qngrrtI4Kq4djJYYAOvzoUVXcslbTt+8s
	i5CyryFJttillvUUbfx51A7/32GhkYsP2ani9Uk1PMg1L1Hsx4FAH3hpqOMrjNE9jxEPenMLewEO2
	j6UB5lgR7gyz7cSOm9VukCcO2MzCCWS8WTzU0FVlMQ37dCNN/sPfrlbQfJrIRHEsZZXvAKHZSPxsZ
	5X8Q53QdwFWvhQtQn7qiIm8p+rV4DOluPylRIHhwFA0h53RYxZdwywXTszQ7d0Lg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tnzl9-0000000DjfN-18L0;
	Fri, 28 Feb 2025 13:46:31 +0100
Message-ID: <a5c7e7a5160c11c93052bb3f862a8089b0617bec.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] wifi: mac80211: Create separate links for VLAN
 interfaces
From: Johannes Berg <johannes@sipsolutions.net>
To: Muna Sinada <quic_msinada@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Fri, 28 Feb 2025 13:46:30 +0100
In-Reply-To: <20250118015400.1919688-2-quic_msinada@quicinc.com>
References: <20250118015400.1919688-1-quic_msinada@quicinc.com>
	 <20250118015400.1919688-2-quic_msinada@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2025-01-17 at 17:53 -0800, Muna Sinada wrote:
> Currently, MLD links for an AP_VLAN interface type is not fully
> supported.
>=20
> Add allocation of separate links for each VLAN interface and copy
> chanctx and chandef of master AP to VLAN where necessary. Separate
> links are created because for Dynamic VLAN each link will have its own
> default_multicast_key.
>=20
> Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
> ---
>  net/mac80211/chan.c        |  3 ++
>  net/mac80211/ieee80211_i.h |  2 +
>  net/mac80211/iface.c       | 23 +++++++++-
>  net/mac80211/link.c        | 86 ++++++++++++++++++++++++++++++++++++--
>  4 files changed, 108 insertions(+), 6 deletions(-)
>=20
> diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
> index a442cb667520..553fc998f5d0 100644
> --- a/net/mac80211/chan.c
> +++ b/net/mac80211/chan.c
> @@ -2124,6 +2124,9 @@ void ieee80211_link_release_channel(struct ieee8021=
1_link_data *link)
>  {
>  	struct ieee80211_sub_if_data *sdata =3D link->sdata;
> =20
> +	if (sdata->vif.type =3D=3D NL80211_IFTYPE_AP_VLAN)
> +		return;
> +
>  	lockdep_assert_wiphy(sdata->local->hw.wiphy);
> =20
>  	if (rcu_access_pointer(link->conf->chanctx_conf))
> diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
> index 9f0db39b28ff..fdd2d422ac5e 100644
> --- a/net/mac80211/ieee80211_i.h
> +++ b/net/mac80211/ieee80211_i.h
> @@ -2057,6 +2057,8 @@ static inline void ieee80211_vif_clear_links(struct=
 ieee80211_sub_if_data *sdata
>  	ieee80211_vif_set_links(sdata, 0, 0);
>  }
> =20
> +void ieee80211_apvlan_link_setup(struct ieee80211_sub_if_data *sdata);
> +
>  /* tx handling */
>  void ieee80211_clear_tx_pending(struct ieee80211_local *local);
>  void ieee80211_tx_pending(struct tasklet_struct *t);
> diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
> index 806dffa48ef9..28aa45a9601c 100644
> --- a/net/mac80211/iface.c
> +++ b/net/mac80211/iface.c
> @@ -493,6 +493,10 @@ static void ieee80211_do_stop(struct ieee80211_sub_i=
f_data *sdata, bool going_do
>  			break;
>  		list_del_rcu(&sdata->u.mntr.list);
>  		break;
> +	case NL80211_IFTYPE_AP_VLAN:
> +		sdata->wdev.valid_links =3D 0;
> +		ieee80211_vif_clear_links(sdata);
> +		break;

Would maybe make sense to move the wdev.valid_links elsewhere too, since
you have the other change to it also in link.c?
=20
> +static void ieee80211_update_apvlan_links(struct ieee80211_sub_if_data *=
sdata)
> +{
> +	struct ieee80211_sub_if_data *vlan;
> +	struct ieee80211_link_data *link;
> +	u16 master_links =3D sdata->vif.valid_links;
> +	u16 new_links, vlan_links;
> +	unsigned long add;
> +
> +	list_for_each_entry(vlan, &sdata->u.ap.vlans, u.vlan.list) {
> +		int link_id;
> +
> +		if (!vlan)
> +			continue;
> +
> +		/* No support for 4addr with MLO yet */
> +		if (vlan->wdev.use_4addr)
> +			return;

That's weird, how would it happen that the vlan has 4-addr but you
cannot check the main 'sdata' value? We don't even let you set that, I
believe?

> @@ -31,6 +87,22 @@ void ieee80211_link_init(struct ieee80211_sub_if_data =
*sdata,
>  	rcu_assign_pointer(sdata->vif.link_conf[link_id], link_conf);
>  	rcu_assign_pointer(sdata->link[link_id], link);
> =20
> +	if (sdata->vif.type =3D=3D NL80211_IFTYPE_AP_VLAN) {
> +		struct ieee80211_sub_if_data *master;
> +		struct ieee80211_bss_conf *master_conf;
> +
> +		master =3D container_of(sdata->bss,
> +				      struct ieee80211_sub_if_data, u.ap);
> +		if (!master)
> +			goto skip_vlan_conf;
> +
> +		master_conf =3D sdata_dereference(master->vif.link_conf[link_id],
> +						master);
> +
> +		memcpy(link_conf, master_conf, sizeof(*link_conf));
> +	}
> +
> +skip_vlan_conf:

You can easily get rid of the goto, and please find better names then
'master'.

johannes

