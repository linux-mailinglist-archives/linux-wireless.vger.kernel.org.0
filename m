Return-Path: <linux-wireless+bounces-24149-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C162FADAE69
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 13:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48ED33A34FC
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 11:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEFA27E07F;
	Mon, 16 Jun 2025 11:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="B3Fm+J9M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADBA202961
	for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 11:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750073260; cv=none; b=Ap4H4sONbUGwvLJ0itjO1f+AXi36PHqI5UqK2FkdgAT6YihycG/OqzdlP2qZh4MLOwTf+dEsG/ZgqRPsiIWIso/SFSNNT5axl4S+oOZwJu156mOB9LIRfXEfQBkkZ2tzd64ttZQsRauwzNp/YD/JCKSIcOU95Zhy2bhx4o7PoLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750073260; c=relaxed/simple;
	bh=u1fOOnC8lbl6xVuyXQW0+brBz2FCNymORlb12XAC0rk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ak0l2kTXrDLzWTkwINqRGMLLj7Uop/Jqxv068LGpDZgfhVS1SazgirYgq3/S6tSvQgFe96K9tnWcAtMc51DAUbDcICnL0iU9LrVAYr6JONYdD9qOQGjqUCniZvHWVtIQflfE6d83gIQ8eoIJjKtdKbFhFzlqcqBAHPpwshPz+uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=B3Fm+J9M; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=TSrDaO6x7axvfw4dUOqMqHlRng8/UPEfg/mxrxy5PEg=;
	t=1750073258; x=1751282858; b=B3Fm+J9MHY5HBlc8JQy/HThqghPtVSmrnftyxbJcbZaCS9D
	44fDwMzag0toZWoJZTvw6GoNOwng1jFOjPRqkKm0Y7afwTt9akmeEa9XuN/kZ6m5ki0BoSg4SM4I5
	oL1k2NARe7Tav4G495vKZDWE0R6IGJ1DmLcnkDm7joCEtIJs5u464QizOxCeo7WLkY786HQhJPBYg
	9j477iFKHHJlQDJoVMoGUjlrFnRDD6FbK8YVsGya//CqYQHXRQU85uw6ek1lrxeAFYD5ohkolNmXw
	omKTVGWOHHHfHyNwnnpiCcCqK2zqhvgAaRGDG17zknpuzkQ+3lHV8MPFHc/ttrFA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uR7zy-0000000CC4c-1twD;
	Mon, 16 Jun 2025 13:27:34 +0200
Message-ID: <b62bf1d140eaebe6dbc75e83541fe45347c8e6bf.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: prevent A-MSDU attacks in mesh networks
From: Johannes Berg <johannes@sipsolutions.net>
To: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Cc: linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>
Date: Mon, 16 Jun 2025 13:27:33 +0200
In-Reply-To: <20250616004635.224344-1-Mathy.Vanhoef@kuleuven.be>
References: <20250616004635.224344-1-Mathy.Vanhoef@kuleuven.be>
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


> +static bool
> +is_amsdu_aggregation_attack(struct ethhdr *eth, struct sk_buff *skb,
> +			    enum nl80211_iftype iftype)
> +{
> +	int offset;
> +
> +	/* Non-mesh case can be directly compared */
> +	if (iftype !=3D NL80211_IFTYPE_MESH_POINT)
> +		return ether_addr_equal(eth->h_dest, rfc1042_header);
> +
> +	offset =3D __ieee80211_get_mesh_hdrlen(eth->h_dest[0]);

This seems awkward? Not only was this calculated by the caller before:

                if (iftype =3D=3D NL80211_IFTYPE_MESH_POINT)
                        mesh_len =3D __ieee80211_get_mesh_hdrlen(hdr.flags)=
;

but also h_dest[0] is just taking advantage of the aliasing when we
already had a union in the caller to avoid exactly that.

We could just pass 'mesh_len' or hdr.flags from the caller? I'd prefer
mesh_len, and perhaps also changing the code to pass mesh_len to
ieee80211_amsdu_subframe_length() instead of recalculating it, since
it's not obvious (without looking into that) right now that we even
check for the necessary length of the frame.

> +	if (offset =3D=3D 6) {
> +		/* Mesh case with empty address extension field */
> +		return ether_addr_equal(eth->h_source, rfc1042_header);
> +	} else if (offset + ETH_ALEN <=3D skb->len) {

And it looks like you didn't really understand that either, or am I
completely confused? I don't see how this test could ever fail:

We previously have

                len =3D ieee80211_amsdu_subframe_length(&hdr.eth.h_proto, h=
dr.flags,
                                                      mesh_control);
                subframe_len =3D sizeof(struct ethhdr) + len;
                padding =3D (4 - subframe_len) & 0x3;

                /* the last MSDU has no padding */
                if (subframe_len > remaining)
                        goto purge;

where 'len' includes __ieee80211_get_mesh_hdrlen() if the mesh_control
is non-zero (where admittedly it's a bit messy to have different kinds
of checks for mesh - iftype and mesh_control), so we definitely have a
full ethhdr after the 'offset' you calculated?

Or maybe it should just not be separated out into a new function, then
it might be easier to see that indeed the length check isn't necessary,
and also easier to reuse the mesh_len.

In fact, given that mesh_len=3D=3D0 for non-mesh, doesn't that make the
change at least theoretically simply collapse down to pulling 6 bytes at
mesh_len offset and comparing those? In practice probably better to
compare against the already-pulled bytes if mesh_len=3D=3D0, but that'd als=
o
be simpler to understand as a check?

I think we probably want some validation here with iftype mesh vs.
mesh_control not being 0 and really now looking at this I wonder why I
let Felix get away without an enum ... but we can fix all that
separately.

johannes

