Return-Path: <linux-wireless+bounces-25915-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3BEB0ECB7
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 10:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF9C9189F17E
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 08:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7438728152F;
	Wed, 23 Jul 2025 08:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="u2O5bTaA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67CD281353
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 08:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753257861; cv=none; b=C/egRGb599exYln/052B5/oVwmk5ZVRwTKmthM7G5CktW6ke/wuGMGMjExT1d9MjdNGTw9QUQfPiaj+i3V+xR0H4bS9RjMChg+VUcHX/dT7gzNNZy3xC5oSUxczPx8NccbPABAqjTkLYxxbtL0Woc5aqdWrVfiY9CRQZwA2LMpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753257861; c=relaxed/simple;
	bh=cgMnPQbs5EFPugVCvGBpRQzijky3zPYi2AOkXxGea/M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N1LY71q1c37CEBNM/tuDy7WxTQflC5VSWQRkCIBt8IXz+SEkoRjfUmXm7mDJMw6HYP7v4c6UoG5fYYn646aApvTj9GfwOD6iNcDnpK318VLQk6lfYWJPiWL3mwWbAG2t1z1D9hDtZ18qNTd7EV3J0c4td3OpGgX2uxcTjFMTb3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=u2O5bTaA; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=gQLDfOZvphauH4WNMAe4CXqJNEQ+IRNd9cB2cArxHGE=;
	t=1753257859; x=1754467459; b=u2O5bTaA/+5S97dLBnYrMExYoOrDnFFKkQ62RqKo4AyZksA
	rGCH1Nk6AzJll8vUzc2WFLQt6vHnWFGtjpaIB8kEwyoa9L8Voxak1OxOI21tWy9dbhNJy0Qwpytu3
	iMnBzTKejQ8djfXGObkmiZGPgdKkfVX362TlTlV1H7XxWdZTtoGtxnGPJaqhRnyfpdLLaZLbeHA0J
	Fb14+TOwPFRvgxllCuA2jivnS1FotjQaBqlj1ShyNs0zHecVuReLccvJTodSO+JSriZ7GQDbFdlP7
	ocr818Eee7px0AtquYpBlbe4cvrPbPYYdpNlDPcnvxfwYe1c9EMgHXqHGfrW/FTA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ueUST-00000003a2I-3QYT;
	Wed, 23 Jul 2025 10:04:14 +0200
Message-ID: <d97f20cff120e813b83c3a7d41bae63b151da26a.camel@sipsolutions.net>
Subject: Re: [wireless-next 1/2] wifi: mac80211: support encoding S1G TIM PVB
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Date: Wed, 23 Jul 2025 10:04:06 +0200
In-Reply-To: <20250722071642.875875-2-lachlan.hodges@morsemicro.com> (sfid-20250722_091728_659585_C991C363)
References: <20250722071642.875875-1-lachlan.hodges@morsemicro.com>
	 <20250722071642.875875-2-lachlan.hodges@morsemicro.com>
	 (sfid-20250722_091728_659585_C991C363)
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

On Tue, 2025-07-22 at 17:16 +1000, Lachlan Hodges wrote:

> +/*
> + * An S1G PPDU TIM PVB uses the notion of pages. Each page can reference
> + * 2048 AIDs, however since mac80211 does not support page slicing we
> + * are reusing the existing TIM bitmap, which supports up to 2008 AIDs.
> + * As the TIM element has a maximum length of 255 bytes, and each encode=
d
> + * block has a maximum length of 10 bytes at most we can support 25 bloc=
ks,
> + * as 1 + 1 + 1 + 25 * 10 =3D 253 bytes, leaving our maximum AID count f=
or
> + * an S1G PPDU at 25 * 64 =3D 1600. If page slicing is introduced in the
> + * future, this will need to be modified.
> + */
> +#define IEEE80211_MAX_AID_S1G_NO_PS	1600
> +#define IEEE80211_MAX_S1G_TIM_BLOCKS	25

Come to think of it, neither of these really makes sense in the
ieee80211.h header file since they're implementation related limits due
to the encoding. And IEEE80211_MAX_S1G_TIM_BLOCKS is questionable too
(see below), spec wise the limit would maybe be 32 (you cannot encode
higher than block 0..31 in the 5 bit block index.)


> +static void ieee80211_beacon_add_tim_pvb(struct ps_data *ps,
> +					 struct sk_buff *skb, u8 aid0, u8 *tim)

Maybe use 'struct element' for the tim pointer? that way tim[1] =3D ...
becomes tim->datalen =3D ... which seems easier to understand.

I know the code didn't use that (it predates the existence of 'struct
element') but it could also originally put the WLAN_EID_TIM that way,
for example.

And maybe aid0 could be 'bool mcast_traffic' or 'bool aid0_traffic' (if
mcast is too specific, not sure what might get encoded there now/s1g.)

(mostly I'm thinking it should be bool, 'bool aid0' is also fine)

> +static void ieee80211_s1g_beacon_add_tim_pvb(struct ps_data *ps,
> +					     struct sk_buff *skb, u8 aid0,
> +					     u8 *tim)
[...]
> +	/* Emit an encoded block for each non-zero sub-block */
> +	for (blk =3D 0; blk < IEEE80211_MAX_S1G_TIM_BLOCKS; blk++) {

So this only makes sense if you actually limit the AIDs to 1600... Maybe
then that's what you want to do :)

Otherwise even if you have no traffic for AIDs 1..1000 you would still
never indicate the traffic for AIDs >=3D1600 (or so.)

If you don't want to limit to 1600 then I think encoding wise we're
limit to 2048 (but in practice to 2008 with the AID limit in nl80211),
but this code would then probably attempt to access 2048 so we need to
ensure the ps->tim bitmap is actually slightly larger. Not that I really
see an issue with that. Or add a check for the actual idx below, similar
to the one you have there, but with a subblock index of 2008/8 =3D=3D 251
instead.

> +		u8 blk_bmap =3D 0;
> +		int sblk, subcnt =3D 0;
> +
> +		for (sblk =3D 0; sblk < 8; sblk++) {
> +			int idx =3D blk * 8 + sblk;
> +
> +			if (idx >=3D IEEE80211_MAX_AID_S1G_NO_PS)
> +				break;

I think you'll want to remove this condition. If you _do_ limit the AIDs
anyway it's not needed, and if you _don't_ limit the AIDs then it should
be replaced by some "does it fit" condition, and/or checking for the
2008 value.

> +			/*
> +			 * If the current subblock is non-zero, increase the
> +			 * number of subblocks to emit for the current block.
> +			 */
> +			if (ps->tim[idx]) {

Also ... this line and the idx>=3D cannot simultaneously be right ... Here
it's basically a subblock index into the bitmap, whereas the >=3DMAX_AID
means it would be an AID, i.e. they're different units by a factor of 8.

It actually looks like it's a subblock index, but then the AID condition
makes no sense anyway.

Maybe rename the variable ;-)

> +				blk_bmap |=3D BIT(sblk);
> +				subcnt++;

I'd be tempted to remove the subcnt variable and use hweight8(blk_bmap)
in its place? I don't think it's _that_ much more expensive, and avoids
having to maintain the same information twice, basically?

> +		/*
> +		 * Increase the tim length by the current encoded block
> +		 * length by block control + block bitmap + n_subblocks where
> +		 * n_subblocks represents the number of subblock bytes to emit
> +		 * for the current block.
> +		 */
> +		tim[1] +=3D 1 + 1 + subcnt;

Or you could just remove all of this tim[1] code from _both_ functions
in the first place, and just have the _caller_ update it:

struct element *tim;

pos =3D skb_put(skb, 4);
tim =3D (void *)pos;
// add all the stuff including PVB
tim->datalen =3D skb_tail_pointer(skb) - &tim->data;

or so. I could be off by one I guess :)

Then (going back down the stack of thoughts) you don't need the 'subcnt'
at all.

johannes

