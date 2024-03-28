Return-Path: <linux-wireless+bounces-5451-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F29F488FE8E
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 13:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92A8E1F25D62
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 12:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDAE7E564;
	Thu, 28 Mar 2024 12:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="LPLbZakZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102EB7EF00;
	Thu, 28 Mar 2024 12:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711627322; cv=none; b=fzrY21ys/wKRd+1lt6eS426SHBWlnqEWqpy1Yhd53WzUAMhqXnS6PfPXi8lszmcgcpNI+SVI6/BRBPvBkWhwmrJuPQCCiVl6eV86YPwNse6z3q38MkKum+QwhfH3srdavNVkZwY54LX0FcKzR2U3VKCtGsNhGV5DVoDZ77Ff7Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711627322; c=relaxed/simple;
	bh=nrisgRUODTGQErEmWu+eI98Zdm3W823MDE1S5wWMYOE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sY9Fs5o0ySI49WF5eQVSpJordP6iH0QeVMEgUMMUs0INcO6sGeUJiTW/G7wUE9/A/4w09tOc8+DOzjqFCgeMdryFkn7uQ61xwwfww5UViekev3pq7fZoXjItHcbxK1b8qCe3LhjuX5cl3ggeOni9SLpC4PwhvAZdOJHCnThYAFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=LPLbZakZ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=hVOuhICxUdhTInSEWv15GWO9hreXzs61ZuyZShZLH68=;
	t=1711627321; x=1712836921; b=LPLbZakZwOSEAdIQwB0xLcWXnZcmX86j505pqG86+yKXR2x
	0WOilkZ1QuswDMbWTff1bh26X/+Uk2xuysehgoEoQLBRrRevNQBl5SkPJk2Fknv7gqQw4K7C9bFw/
	nW/UUIcbtp62W6roktJCwor02CxMqLzvA25C60LZL4j5a5u2xPJvG+c9z4myNZ6Oq93qINKqvNOdl
	/JLJz1gdz6rnFYBWMPThZl6f1hvvhMY1q28c6FQ1sSnRHGPcJHS8BwKa5rS88pj6ommCg9RaLGxrA
	esxX0oy1g5ssvQcZ20i+7hJxii13eK+by0WCd3z8xh9wY943vWMlLzOPUteS80mw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rpoSC-00000000wR3-2bD5;
	Thu, 28 Mar 2024 13:01:56 +0100
Message-ID: <9d0f309da45ae657cd2ce0bc11a93d66e856ef64.camel@sipsolutions.net>
Subject: Re: [PATCH 02/13] wifi: nl80211: send underlying multi-hardware
 channel capabilities to user space
From: Johannes Berg <johannes@sipsolutions.net>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>, 
	ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Vasanthakumar Thiagarajan
	 <quic_vthiagar@quicinc.com>, netdev@vger.kernel.org, Jakub Kicinski
	 <kuba@kernel.org>
Date: Thu, 28 Mar 2024 13:01:55 +0100
In-Reply-To: <9d5c2f9f-19b5-af4d-8018-1eb97fac10d6@quicinc.com>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
	 <20240328072916.1164195-3-quic_periyasa@quicinc.com>
	 <6d92d0ba4a8764cd91cc20c4bd35613bcc41dfcd.camel@sipsolutions.net>
	 <9d5c2f9f-19b5-af4d-8018-1eb97fac10d6@quicinc.com>
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

On Thu, 2024-03-28 at 15:48 +0530, Karthikeyan Periyasamy wrote:
> On 3/28/2024 1:19 PM, Johannes Berg wrote:
> > On Thu, 2024-03-28 at 12:59 +0530, Karthikeyan Periyasamy wrote:
> > > +/**
> > > + * nl80211_multi_hw_attrs - multi-hw attributes
> > > + *
> > > + * @NL80211_MULTI_HW_ATTR_INVALID: invalid
> > > + * @NL80211_MULTI_HW_ATTR_IDX: (u8) multi-HW index to refer the unde=
rlying HW
> > > + *	for which the supported channel list is advertised. Internally re=
fer
> > > + *	the index of the wiphy's @hw_chans array.
> > Is there a good reason to expose this? Seems pretty internal to me, and
> > not sure what userspace would do with it?
>=20
> Hostapd use this hw index for the channel switch cmd.

What, where? I don't see that in this patchset? And why??

In any case, unless I just missed it and you're going to tell me to look
at patch N, we don't need it here, and then I'd prefer to keep it an
internal detail until it's needed.

> The hw index used as a sanity check to identify whether the user=20
> requested channel fall under the different hw or not.

You mean within hostapd itself? That doesn't make sense, it can derive
that information differently.

> In split-phy hardware, 5GHz band supported by two physical hardware's.=
=20
> First supports 5GHz Low band and second supports 5GHz High band.

In your hardware design anyway, but yeah, I get it.

> In this case, user space cannot use band vise check here to identify=20
> given channel or freq supported in the given hardware.

No, but it also doesn't need an index assigned by the kernel for that.

> > > +	for (i =3D 0; i < wiphy->num_hw; i++) {
> > > +		hw_mac =3D nla_nest_start(msg, i + 1);
> > And you kind of even have it here already ...
>=20
> Then user and kernel have to make an assumption that implicit index used=
=20
> in the life cycle.

Agree that's maybe not a great idea, for all we care this could just use
0 as the index anyway.

Which reminds me ...

Right now, the way you have it, we have the following structure:

NL80211_ATTR_MULTI_HW
- 1
  - NL80211_MULTI_HW_ATTR_IDX: 0
  - NL80211_MULTI_HW_ATTR_FREQS
    - 0: 2412
    - 1: 2417
    ...
- 2
  - NL80211_MULTI_HW_ATTR_IDX: 1
  - NL80211_MULTI_HW_ATTR_FREQS
    - ... as above with 5 GHz etc.
...


Netlink is kind of moving away from nested arrays though:

https://kernel.org/doc/html/latest/userspace-api/netlink/specs.html#multi-a=
ttr-arrays
https://kernel.org/doc/html/latest/userspace-api/netlink/genetlink-legacy.h=
tml#attribute-type-nests

This talks about families, but maybe we shouldn't read that literally
and do the new style for new arrays in existing families as well, not
just new families.

If we do that, including NL80211_MULTI_HW_ATTR_IDX for illustrative
purposes though I think it should be removed, we'd end up with:

NL80211_ATTR_MULTI_HW
 - NL80211_MULTI_HW_ATTR_IDX: 0
 - NL80211_MULTI_HW_ATTR_FREQ: 2412
 - NL80211_MULTI_HW_ATTR_FREQ: 2417
 ...
NL80211_ATTR_MULTI_HW
 - NL80211_MULTI_HW_ATTR_IDX: 1
 - NL80211_MULTI_HW_ATTR_FREQ: 5180
 - NL80211_MULTI_HW_ATTR_FREQ: 5200
 ...

which _is_ a lot more compact, and removes all the uninteresting mid-
level indexing.

So in that sense, I prefer that, but I'm truly not sure how the (hand-
written) userspace code would deal with that.

johannes

