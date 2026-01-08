Return-Path: <linux-wireless+bounces-30564-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D55B6D04733
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 17:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7E6130492A5
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 15:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993974657FA;
	Thu,  8 Jan 2026 12:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="F/OzmF7j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2A14657E4
	for <linux-wireless@vger.kernel.org>; Thu,  8 Jan 2026 12:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767876151; cv=none; b=SIea4EkDHnIyTagK75qm2GKG3w5t6mF3AysudbDKc7bjU0nuZS50VQTZPT+TKimmRCIKep3N9XsUgSNrucUhiToY2CJ3sE6iyLdscA1QI+VOwVYlUhMFkyAqCLH3aanzBIqQqXRgMDqQaEFRFUP6WeGqXcuFMKo0MDsW7BswBcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767876151; c=relaxed/simple;
	bh=M6iNfNrNBMBMKbXVEvATsLrBYWz+UrIKzZ60sJ3wqCI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=da0OJplENqCAFlYEB25NRgmopE+XFxli/ig/Cr7g1bvJYMvK+E4GbzVCiHgMiVP0tWJ3JV6UWkvrLjv9kqZmxY0cFgjp/DcGBPJLQjhwxjdrfLE22UvgPP2DdywO3NyccRefzHlrYhYxbw7cPPBMWFTH4feK1AKc+0BtM/Dr0Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=F/OzmF7j; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=CNFjgpe2uzcdKETIx5bWZ2E7tid7AL/a7jz+QDnhfOk=;
	t=1767876150; x=1769085750; b=F/OzmF7joJFadiRHimwcf2PpEU/fnGoVnwBbgeW1gp390zD
	YkcNk1jO9am7eT23+qglb/uQIU+rp53RtHRGFOcar8vg/sA1PxSAicTLAfxYwwqgMHxkVDQJR6Q5G
	tN3fh0Gp1ctNgjEoFJp9c55WyOlORiyVZiVbH42Nsu3VoNnEnG5+JO+cAtseaKLXJgHjD+nDhVVBe
	CXTDDedY95zXmiQDjTgB6zsrKPwRwBzp/ntrOSwnVxSiGoKKsy8U/Cnzq+hyX+BcFSqgwhucCIv/7
	FqtmTxVZz6kBlsdZMbQH8lVw4XrocanM1jVj8Fmfaw1f3r4syhQc2c1+aykKvKgw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdpLO-00000006VEo-24vY;
	Thu, 08 Jan 2026 13:42:26 +0100
Message-ID: <16099966d1cbdccc5160c6aa7a2615dcfd0060d6.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v3 4/9] wifi: nl80211: Add new NL
 attributes to support (Re)Association frame encryption
From: Johannes Berg <johannes@sipsolutions.net>
To: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ainy.kumari@oss.qualcomm.com, 
	sai.magam@oss.qualcomm.com, quic_drohan@quicinc.com
Date: Thu, 08 Jan 2026 13:42:25 +0100
In-Reply-To: <20260106152503.223216-5-kavita.kavita@oss.qualcomm.com> (sfid-20260106_162528_185648_909E42F7)
References: <20260106152503.223216-1-kavita.kavita@oss.qualcomm.com>
	 <20260106152503.223216-5-kavita.kavita@oss.qualcomm.com>
	 (sfid-20260106_162528_185648_909E42F7)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2026-01-06 at 20:54 +0530, Kavita Kavita wrote:
>=20
>  include/net/cfg80211.h       |  5 +++++
>  include/net/mac80211.h       |  5 +++++
>  include/uapi/linux/nl80211.h | 26 ++++++++++++++++++++++++++
>  net/mac80211/cfg.c           |  6 ++++++
>  net/wireless/nl80211.c       | 10 ++++++++++

You should split this patchset differently so you don't have this mix of
cfg80211/mac80211 here. Perhaps this patch becomes two, or perhaps it
all goes into two other patches, dunno.

The subject also seems confused - why is this about the encryption of
certain frames? It doesn't seem to be doing any such thing at all?

> + * @epp_flags: Negotiated EPP capabilities
> + *	(bitmask of BIT(%NL80211_EPP_FLAG_...))

All of this along with the nl80211 API isn't used, and the small commit
log blurb about it:

> The Extended RSN capabilities for EPP that an EPP AP and an EPP
> non-AP STA can negotiate are as per "IEEE P802.11bi/D3.0, 9.4.2.240"
> (RSNXE), few of which are driver dependent, hence need them to be
> communicated from userspace for later use.

really doesn't make it clear why that should be maintained. Sure support
is driver dependent, but obviously you already have the extended feature
bits from patches 1 and 2.

> +++ b/include/uapi/linux/nl80211.h
> @@ -2973,6 +2973,13 @@ enum nl80211_commands {
>   *	primary channel is 2 MHz wide, and the control channel designates
>   *	the 1 MHz primary subchannel within that 2 MHz primary.
>   *
> + * @NL80211_ATTR_EPP_PEER: A flag attribute to indicate if the peer is a=
n EPP
> + *	STA. Used with %NL80211_CMD_NEW_STA and %NL80211_CMD_ADD_LINK_STA
> + *
> + * @NL80211_ATTR_EPP_FLAGS: A (u32) bitmap attribute to indicate the neg=
otiated
> + *	EPP capabilities of an EPP AP and an EPP non-AP STA. See
> + *	&enum nl80211_epp_flags for details. Used with %NL80211_CMD_SET_STATI=
ON

My preference would be to remove the FLAGS, but if you can convince me
that it's needed (and as you know I care very little about non-upstream
drivers) then still this really ought to just have a single attribute
and the mere presence indicates EPP support with the flags inside (or
non-zero flags indicate such, though I prefer to not allow zero flags
since then it's not EPP?)

> @@ -8416,6 +8418,10 @@ static int nl80211_set_station(struct sk_buff *skb=
, struct genl_info *info)
>  			nla_len(info->attrs[NL80211_ATTR_STA_EXT_CAPABILITY]);
>  	}
> =20
> +	if (info->attrs[NL80211_ATTR_EPP_FLAGS])
> +		params.epp_flags =3D
> +			nla_get_u32(info->attrs[NL80211_ATTR_EPP_FLAGS]);
> +
>  	if (parse_station_flags(info, dev->ieee80211_ptr->iftype, &params))
>  		return -EINVAL;
> =20

Are you sure it needs to be _changed_? Since EPPKE is an authentication
algorithm hostapd should know early?

But I'm not even sure how the assoc frame encryption flag makes any
sense at all, seems that ought to just depend on whether or not keys
exist.

johannes

