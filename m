Return-Path: <linux-wireless+bounces-5206-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB2688AA61
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 17:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74B3F1C36EE4
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 16:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B5E639;
	Mon, 25 Mar 2024 15:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="w1JqQ96V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE95F7F48F
	for <linux-wireless@vger.kernel.org>; Mon, 25 Mar 2024 15:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711380108; cv=none; b=AaoahrkoTXqokaheAEkVBvhQK/fFSV8iVEGeMj4nizI2N+sZGRNc98IRfCaGYvrirreAWtKfGTIYYca/WL006StXoX3/6Gvb95FyYP+AbbhcHmmu8834YhwROIWoBPzjFJC+djbKVZ4tIwUCC/akB/RCT+FMmStivQUG6/nanfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711380108; c=relaxed/simple;
	bh=K5L5k1m/rN3s6wgwiv8+rS9heNJYnXkXYw89D1KeMrs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L6rG5CXRVnEjpdkam3nU90/CVHYCqyAgmo/wpohTKSQjH0jrgh6ut2AZ2BSwDYbiaIFaNEUMewGFR9v0T0uiD+lCZhIC7EWJyv/UWw90szfCGjAff5HrwNUiDnxG9d7Ru3O5NgkFAPSVL6+7sXGJAJbcsd3tzc8FoNNsd+HJvlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=w1JqQ96V; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=SVCXwL1iI/bNs8G7d4KaZw3fMBGDP6EFpG9+mgrsaAI=;
	t=1711380105; x=1712589705; b=w1JqQ96VKGVnwl/6lm+9N47wpkhFqTua+TCfZl//l0n/oni
	s4HYtMYBgqcF7BdjfnlfMpmLeq1WPPdyROezkuxGh6oZ8+2O/R3LQqLUlgfpVJo5EKhxO45l1GEyj
	il0PiAkzCVvy5gor32sNIZKkHj7HQLzcagflTwG9Sl962SbqKEb9Xn5jJ8QSCT1ACNos/M3LL7GGa
	2WS7QfetH0GXOeVIyEqvOMIu+xsXFRxlejJr+wiTRBdmjUIp6Q4vrQ59eLi0Pn06nsryuSSNPGJsj
	w9xaP3rvGxpmj7XawLz2r/NvLUt17sjP5w8n7FPadioeyXkQxZb9eiFUozNbgEYA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rom8t-0000000DuBG-0Ddh;
	Mon, 25 Mar 2024 16:21:43 +0100
Message-ID: <2c8338a29d3c42ebbf1fd5efd348c14471fa5004.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: validate link status before deciding on
 off channel Tx
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org, Sriram R <quic_srirrama@quicinc.com>
Date: Mon, 25 Mar 2024 16:21:42 +0100
In-Reply-To: <20240312154620.242773-1-quic_adisi@quicinc.com>
References: <20240312154620.242773-1-quic_adisi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-03-12 at 21:16 +0530, Aditya Kumar Singh wrote:

> In such cases, the bss active flag might not provide the exact
> status of the MLD links.

That's ... true I guess, but then I'm suspicious, why are you sending
this patch? Does that mean 'active' is managed incorrectly and actually
becomes false when one link is removed, rather than all? Can you fix
that too? And if you fix that ... yeah we probably still should have
this patch but ... _without_ this:

> +	/* This is consolidated status of the MLD or non ML bss */
> +	if (sdata->bss->active)
> +		return true;

I'd think?

> While at it, when source address is same as the link conf's address and
> if userspace requested Tx on a specific link, add changes to use the same
> link id if the link bss is matching the requested channel.

Why not separate that? It's really not related much?

> +	if (link_id < 0)
> +		return false;
> +
> +	if (!sdata->vif.valid_links)
> +		return false;
> +
> +	if (!(sdata->vif.valid_links & BIT(link_id)))
> +		return false;

The second condition seems useless then?

But probably better to check *active* links, and then might as well use
ieee80211_vif_link_active()?

> +	link =3D sdata_dereference(sdata->link[link_id], sdata);
> +	if (!link)
> +		return false;

That might be a WARN_ON()? After all, if links are valid (or active per
above) that really should be there?

>  int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
>  		      struct cfg80211_mgmt_tx_params *params, u64 *cookie)
>  {
> @@ -817,7 +850,7 @@ int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wir=
eless_dev *wdev,
>  	case NL80211_IFTYPE_P2P_GO:
>  		if (sdata->vif.type !=3D NL80211_IFTYPE_ADHOC &&
>  		    !ieee80211_vif_is_mesh(&sdata->vif) &&
> -		    !sdata->bss->active)
> +		    !ieee80211_is_link_bss_active(sdata, params->link_id))
>  			need_offchan =3D true;
> =20
>  		rcu_read_lock();
> @@ -897,8 +930,17 @@ int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wi=
reless_dev *wdev,
>  				break;
>  			}
> =20
> -			if (ether_addr_equal(conf->addr, mgmt->sa))
> +			if (ether_addr_equal(conf->addr, mgmt->sa)) {
> +				/* If userspace requested Tx on a specific link
> +				 * use the same link id if the link bss is matching
> +				 * the requested chan.
> +				 */
> +				if (sdata->vif.valid_links &&
> +				    params->link_id >=3D 0 && params->link_id =3D=3D i &&
> +				    params->chan =3D=3D chanctx_conf->def.chan)
> +					link_id =3D i;
>  				break;
> +			}
> =20
>  			chanctx_conf =3D NULL;
>  		}
>=20
> base-commit: c2b25092864a16c7865e406badedece5cc25fc2b


