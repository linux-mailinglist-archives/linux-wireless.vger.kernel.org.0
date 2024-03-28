Return-Path: <linux-wireless+bounces-5458-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28566890050
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 14:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D65DA290C95
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 13:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466CA7D09A;
	Thu, 28 Mar 2024 13:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="yDbJAJ38"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5D5405FF
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 13:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711632836; cv=none; b=g4reX6L/dRVH8e2DbQLfyLWzefr3ymcOjCLwY+0ybC6195PL/3FbNImNjQE922sNkzXxqQvqnzG1ZUQGQsgykWeT9hXRtu+qd/VMutzN+f47rCXEHb+HZykomAL+Vg99Lb1HsGQpoFQ0SfOKuD1wPhgqHfhK36dTeadfoCVVo1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711632836; c=relaxed/simple;
	bh=GIP4Y3zP+Jc0542YRw67X+QNVuem+/PQWwyvTFjX0IM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cxARvCXLRuy9NNc0WPUy5sgkXLDkSbjo/WtprVZI0Pnc3mqQNPU+4LXlsG1YDGtWaEATFRHp3VpHFHAKZGFjuVukmI1m+Yd2DYoYfLNFUBLXWlifTMdwsfNbR75AHZpzFjXR/L+sucAH9Evg/zH5/y9w7Osg9mirTCvcwYcZn4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=yDbJAJ38; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ukAwndyN8wSwuY93m82P0N4u/3kEv+p+1SKSqFRuS2o=;
	t=1711632833; x=1712842433; b=yDbJAJ38K0f9ooUEJqma6yCYsvTKN9F3gl7Ggfx5IvY/2jO
	POUuDs0Va19dXKuIvkYOB/a4AG2CM/BW+wu4WOuqLyuPLJK5fK2+Kbi2rkXiA9M028VhmwKn146s1
	4N+kja1ym8fZu7MyR+mwknQX7s/9RtHdynyjdyNL9q8ie0ezn/HV7fbcUGnOyj8cLjQ5oYWmUxIdb
	jgHDqw7xUIKry7XCkb/MOQul//u0gI8wnXJ9M7iRp5D+0etlblKjWVoc9CcTuKPYIWj4eI3RpgNRY
	O1/1fBF7/IK+SymWOl+C10UJWP+//KrSuad1m8J0uBB42CeDYDqihrkY+JfhssaA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rppt8-000000010MD-2pDO;
	Thu, 28 Mar 2024 14:33:50 +0100
Message-ID: <29fc2719d6814a8e84f5db9ad81c76116a52828b.camel@sipsolutions.net>
Subject: Re: [PATCH 06/13] wifi: nl80211: send iface combination to user
 space in multi-hardware wiphy
From: Johannes Berg <johannes@sipsolutions.net>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>, 
	ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Vasanthakumar Thiagarajan
	 <quic_vthiagar@quicinc.com>
Date: Thu, 28 Mar 2024 14:33:49 +0100
In-Reply-To: <20240328072916.1164195-7-quic_periyasa@quicinc.com>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
	 <20240328072916.1164195-7-quic_periyasa@quicinc.com>
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

On Thu, 2024-03-28 at 12:59 +0530, Karthikeyan Periyasamy wrote:
>=20
> + *	When describing per-hardware combinations in multi-hardware in
> + *	one wiphy model, the first possibility can further include the finer
> + *	capabilities like below

Not sure I'd say "below" rather than e.g. "like this:"

> + *	hw_chan_idx =3D 0, numbers =3D [ #{STA} <=3D 1, #{AP} <=3D 1 ],
> + *	channels =3D 1, max =3D 2
> + *	=3D> allows a STA plus an AP interface on the underlying hardware mac
> + *	   advertised at index 0 in wiphy @hw_chans array.
> + *	hw_chan_idx =3D 1, numbers =3D [ #{STA} <=3D 1, #{AP} <=3D 2 ],
> + *	channels =3D 1, max =3D 3
> + *	=3D> allows a STA plus two AP interfaces on the underlying hardware m=
ac
> + *	   advertised at index 1 in wiphy @hw_chans array.

Have you checked the rst output for this? Seems likely that's not going
to be great with that formatting, but I haven't checked.

> + * @NL80211_IFACE_COMB_PER_HW_COMB_HW_IDX: u8 attribute specifying the i=
ndex
> + *	to the wiphy @hw_chans list for which the iface combination is being
> + *	described.

"@hw_chans" doesn't make sense here, this is nl80211, it should refer to
some attribute

but why didn't you just _say_ in the patch 2 discussion that it's used
here ...

> + * @NL80211_IFACE_COMB_PER_HW_COMB_LIMITS: nested attribute containing t=
he
> + *	limits for the given interface types, see
> + *	&enum nl80211_iface_limit_attrs.
> + * @NL80211_IFACE_COMB_PER_HW_COMB_MAXIMUM: u32 attribute giving the max=
imum
> + *	number of interfaces that can be created in this group. This number
> + *	does not apply to the interfaces purely managed in software.
> + * @NL80211_IFACE_COMB_PER_HW_COMB_NUM_CHANNELS: u32 attribute specifyin=
g the
> + *	number of different channels that can be used in this group.
> + * @NUM_NL80211_IFACE_COMB_PER_HW_COMB: number of attributes
> + * @MAX_NL80211_IFACE_COMB_PER_HW_COMB: highest attribute number
> + */
> +enum nl80211_if_comb_per_hw_comb_attrs {
> +	NL80211_IFACE_COMB_PER_HW_COMB_UNSPEC,
> +	NL80211_IFACE_COMB_PER_HW_COMB_HW_IDX,
> +	NL80211_IFACE_COMB_PER_HW_COMB_LIMITS,
> +	NL80211_IFACE_COMB_PER_HW_COMB_MAXIMUM,
> +	NL80211_IFACE_COMB_PER_HW_COMB_NUM_CHANNELS,

Almost all these attributes duplicate - including their docs -
attributes from enum nl80211_if_combination_attrs. Is it really worth
doing that, rather than adding NL80211_IFACE_COMB_HW_IDX and documenting
the different uses of the attribute set?

> +	hw_combis =3D nla_nest_start(msg, NL80211_IFACE_COMB_PER_HW_COMB);
> +	if (!hw_combis)
> +		return -ENOBUFS;
> +
> +	for (i =3D 0; i < c->n_hw_list; i++) {
> +		struct nlattr *hw_combi, *limits;
> +
> +		hw_combi =3D nla_nest_start(msg, i + 1);

And of course the array and splitting discussions apply here too.

johannes

