Return-Path: <linux-wireless+bounces-2529-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B8A83D710
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 10:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47A4D29A696
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 09:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FE260869;
	Fri, 26 Jan 2024 09:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="bBc/RW6v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831F46086C
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jan 2024 09:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706259976; cv=none; b=dboD+iSYrh5Zb6Wq/p7dnbUk5nshWvPU1kFRBVRFEtwg4QZL3LC4cLFC0+xy+sBLjkR4beaJIV5/fpi9YtMDByjng4ybVsci5Q95L1kmh6Pp7U4FpZYKtyWGMXMzLcK4KiNiVw165C70aUNY8P0mxCMbAqo4U90VUl9FbyjPLvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706259976; c=relaxed/simple;
	bh=h/YPOiAF2UDbeP+qd6XAkZ1ycM5AQyRs1nOreguUqzM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LHE3xewz2LlO30HVl/bfDRlai+f0DZ9yZD2kJN/rmqHnQuNKvBhqrEt8voNGKfpAVV6kZN4GuhxMRIfljQ1SnOBdGMxHENuKeRqYzAeQoO0mcXCMPw/0TC9OoDP0+footII9A0tdXsAWRW4nR7PngZoLQzGOBKiczDmtsGlGsB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=bBc/RW6v; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=DvH42WRPA5TSQmY+MuaNkQLBEhe1kPIlJiiKLZNJbzA=;
	t=1706259972; x=1707469572; b=bBc/RW6v/aK9ZPuC0fkymMHpdqT8+Iod795WHoveFpIZU/i
	MZzznKI+eqxv1FdpUWiryDWYWJh77QffbzUNtAieGyRJm7ovRUkp6Ef7Uer7AnsxBPyzpBGXuuVB5
	Q1ufZ9PS0RwerP4YIuTA2hWn+2nPYb4igPcUvWxQpWC4+HVdo5I9si7c9GyXqYXsI2iwr3tlbNzrK
	nV0Sw1IeGh7CWRhe7loCmBdll42V2F7eRgOyr0IvdDdgd86BGNtb7L5TOZ3qdn92LYN1yxOusCLEV
	TZAnSO6esGgKLK8LqCwQkqA/+T7mGa1l/1jmUv+1WBagCofLKDhUZzDbJo3rh3pA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rTI9y-0000000142U-3Lj0;
	Fri, 26 Jan 2024 10:06:03 +0100
Message-ID: <61ad9e10e42c9f114c2a7de534690f8c0133bf58.camel@sipsolutions.net>
Subject: Re: [PATCH 1/3] wifi: cfg80211: add support for link id attribute
 in NL80211_CMD_DEL_STATION
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Fri, 26 Jan 2024 10:06:01 +0100
In-Reply-To: <20240125125855.827619-2-quic_adisi@quicinc.com>
References: <20240125125855.827619-1-quic_adisi@quicinc.com>
	 <20240125125855.827619-2-quic_adisi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-01-25 at 18:28 +0530, Aditya Kumar Singh wrote:
> Currently whenever NL80211_CMD_DEL_STATION command is called without any
> MAC address, all stations present on that interface are flushed.

True.

> However with MLO there is a need to flush the stations from a particular
> link in the interface, and not from all the links associated with the MLD
> interface.

Fair enough, I can get behind that.

Edit: reading the code - I think I misunderstand that ... you're
actually trying to remove all MLDs ("STATION") that have an active link
on this link? So then maybe disregard all the below, and just write a
better commit message?
But I'll leave the below because I'm not really sure what you're trying
to do here.


> For example - 2 GHz and 5 GHz are part of an AP MLD. When 2 GHz BSS is
> brought up, it sends flush command on the interface (MLD). Then eventuall=
y
> 5 GHZ links comes up and that also sends the command on the same interfac=
e.
> Now by the time 5 GHz link comes up, if any station gets connected to 2 G=
Hz
> link, it would be flushed while 5 GHz link is started which is wrong.

Right. Though in this case - after bringup - you wouldn't really have to
flush anyway, so it could just not do that, I guess? Feels a bit like a
broken flow which is a bad justification, but I do understand there's
justification for this.

> Hence, add an option to pass link ID as well in the command so that if li=
nk
> ID is passed, station using that passed link ID alone would be deleted
> and others will not be removed.

So first: Do you want some feature flag that indicates this? Or will we
just eat the cost of kicking out everyone (without even sending deauth
though, I think?) when running on older kernels?


Secondly: why is this part of NL80211_CMD_DEL_STATION? I'm not convinced
that makes sense. I actually kind of get why you're doing that - it's
easier to retrofit into the existing hostapd, but I don't necessarily
think that the hostap design (problems?) should influence this too much.

IOW, it would feel much more appropriate to have this as part of
NL80211_CMD_REMOVE_LINK_STA? After all, when going to MLD then "STATION"
now represents a "peer MLD", and "LINK_STA" now represents an affiliated
STA. And flushing all affiliated STAs is what you want.

So I think it should be NL80211_CMD_REMOVE_LINK_STA without a
NL80211_ATTR_MLD_ADDR.

> A subsequent patch would add logic to delete only the station using the
> passed link ID.

Not sure I'd say that here - I mean, (1) yeah obviously, otherwise we
won't apply this patch? and (2) it's not related to cfg80211.

>  	case NL80211_IFTYPE_MESH_POINT:
> @@ -7675,6 +7677,17 @@ static int nl80211_del_station(struct sk_buff *skb=
, struct genl_info *info)
>  		params.reason_code =3D WLAN_REASON_PREV_AUTH_NOT_VALID;
>  	}
> =20
> +	/* Link ID not expected in case of non-ML operation */
> +	if (!wdev->valid_links && link_id !=3D -1)
> +		return -EINVAL;
> +
> +	/* If given, a valid link ID should be passed during MLO */
> +	if (wdev->valid_links && link_id >=3D 0 &&
> +	    !(wdev->valid_links & BIT(link_id)))
> +		return -EINVAL;

Maybe refactor this with the NL80211_FLAG_MLO_VALID_LINK_ID checks?

> @@ -16827,6 +16840,9 @@ static const struct genl_small_ops nl80211_small_=
ops[] =3D {
>  		.validate =3D GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
>  		.doit =3D nl80211_del_station,
>  		.flags =3D GENL_UNS_ADMIN_PERM,
> +		/* cannot use NL80211_FLAG_MLO_VALID_LINK_ID, depends on
> +		 * MAC address
> +		 */
>  		.internal_flags =3D IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),

Hmm? How does NL80211_FLAG_MLO_VALID_LINK_ID depend on the MAC address?!
It ... doesn't?

johannes

