Return-Path: <linux-wireless+bounces-24925-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA39AFC8CA
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 12:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EDC9189607A
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 10:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BD8271465;
	Tue,  8 Jul 2025 10:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ZQ6N9/YN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0C722D7B9;
	Tue,  8 Jul 2025 10:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751971618; cv=none; b=DXrKqqEuHOWibKSMEqAW9Agwol0m0N1UlzqtSeWi9IErlgfY4wgJoTe17i5876iU1B9CnnJwFrfXFjFrRYLM9nOoyGqOlVbzd4+//VkJg7L3Gzq6TQ8S2KjVU+C1tdPyzHjBTWBXUiGsDEnSJS1g5/HAwi2EDYmu/P2lLlUjv5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751971618; c=relaxed/simple;
	bh=2TOmV10lxIxuTsp8uFJG5Izu6484hI6eLic7jxQWdSE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Aj8uFwV/diD1OebgGjIJdcyL7v+gdUyGRsNi0KPevQX//FivjYmtp/GRdnDNlN15RAZct92tfSZmG4qbguNRc5U7WKOsnZXyyz0skjTwpt6kUKl0f3T8T38LUNJbIdPKcRs+6e0fTcHJB4OOSAXtVQuRya4GuG43ifwAp5mOKjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ZQ6N9/YN; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Z4l0M2PH+ps9jQt/AMGCN35e9N7g7YZfZzmLAEhhcmQ=;
	t=1751971617; x=1753181217; b=ZQ6N9/YNBcdYwblUaFn5j04VsB8G+a6zfvLuqHobH0QleoR
	iQDUp7ECXMOC7+vny6fUxWUvdFAoyO0OZT+oI9sE6YSugWNXn39LZESZ5upottEcT2pjxbCjTYmpc
	yI0z2IHdNKgOR6HDlMFKrP5FuVxGNNjzgtouU2LjaqgRsHS0eQWKLJHPNwVKDfi8dmg/ay9aZc5IT
	a4ucKXFVhtgXa46NACTZgRQHHmVo5F3YN1AfWnzM1G7FxkuZ7jsCE6br6LS+iB5cwAR9U1BLUwpXC
	9Zox09REDmP43GygcQXVyr9oHJwkgdhsKnz/YFDCqXF+rMI34Xz2oK/oAqIYynCw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uZ5qf-0000000Bp5H-46pz;
	Tue, 08 Jul 2025 12:46:54 +0200
Message-ID: <f5148f63e6f96fd18558dbb7f49d090aec931745.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v3] wifi: mac80211: consider links for
 validating SCAN_FLAG_AP in scan request during MLO
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 08 Jul 2025 12:46:53 +0200
In-Reply-To: <20250625-fix_scan_ap_flag_requirement_during_mlo-v3-1-dca408b10ba4@oss.qualcomm.com>
References: 
	<20250625-fix_scan_ap_flag_requirement_during_mlo-v3-1-dca408b10ba4@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2025-06-25 at 18:31 +0530, Aditya Kumar Singh wrote:
>=20
> -		if (ieee80211_num_beaconing_links(sdata) &&
> -		    (!(wiphy->features & NL80211_FEATURE_AP_SCAN) ||
> -		     !(req->flags & NL80211_SCAN_FLAG_AP)))
> -			return -EOPNOTSUPP;
> +		for (link_id =3D 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS;
> +		     link_id++) {
> +			link =3D sdata_dereference(sdata->link[link_id], sdata);
> +			if (!link)
> +				continue;

for_each_link_data()

> +
> +			/* if the link is not beaconing, ignore it */
> +			if (!sdata_dereference(link->u.ap.beacon, sdata))
> +				continue;
> +
> +			/* If we are here then at least one of the link is
> +			 * beaconing and since radio level information is
> +			 * not present or single underlying radio is present,
> +			 * no point in checking further and hence return if
> +			 * flag requirements are not met.
> +			 */
> +			if (wiphy->n_radio < 2) {
> +				if (!(wiphy->features & NL80211_FEATURE_AP_SCAN) ||
> +				    !(req->flags & NL80211_SCAN_FLAG_AP))
> +					return -EOPNOTSUPP;
> +
> +				continue;
> +			}

Is that _really_ worth special-casing in the scan control path? It's not
like this is a performance question here.

Maybe ieee80211_is_radio_idx_in_scan_req() shouldn't WARN_ON() then or
something, so we can reuse it. Or maybe (better?) just reorder the
checks there, if the chan_radio_idx=3D=3D-1 and radio_idx=3D=3D-1 would ret=
urn
first, and WARN only if we found a scan channel that isn't covered by a
radio?

And <2 seems really strange anyway, =3D=3D1 should basically never happen,
it's equivalent to =3D=3D0, as in no list of radios?

johannes

