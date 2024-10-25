Return-Path: <linux-wireless+bounces-14558-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1589B0F9E
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 22:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2049BB21797
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 20:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7912121441E;
	Fri, 25 Oct 2024 20:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="k+dD5E+2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550B820EA5E;
	Fri, 25 Oct 2024 20:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729887304; cv=none; b=Pe2BLYgpWJL2Zka91fyKauP/WE+EVa4CmVjJPF6/gPEn9nBnGycER0k+XIwj2QHa8AB5w/wrnz7yTMqiywksJRWYj2pu2RVBw1KaNNtoBOaLF4/1MX9JZIJ0u5FjY/SmjobeTN6BpVrEMX4VXPR32hYmxCo39fycA7wkSn9wCsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729887304; c=relaxed/simple;
	bh=lm85X36XMUYTBMq6kI4NS7xDbiFnTG30zBba4jBm3YY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GRHcthIPum/2iwq0zvZWZmkQ/wBT+oGcWv1XXJOU/Cx1KEfmddSRn6whnH9kHsxd0A6eKunHcRGt8/Vg38vj+2w3P1FoRQVniiZAonvbXz/IA5CYOPbZr/u5tRkNVP+XEwpGCh/0+/fq2bVwYrTQEtwJZNHHyOufZYMN2To4pVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=k+dD5E+2; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=XTnMufEBsLCy9SArFZ4Fb/sv45Fzct2Fsz9IuiFXf4c=;
	t=1729887302; x=1731096902; b=k+dD5E+2CGGsSnS73yT/c2aU52ZQE3hR4LOgKyKye5p6Kn+
	fESNdf8poOksU5mRlkJPLAuRyY7sZgs/lCj5aHQr3/hWFkwL0tfx0fTr7bQwWmDHQOyIZIEgD4btL
	Bse8XB+y/OxGRIQvYG/GbzJkfNf/XlKgGRQE/WTFPMQ2jOeJCfuT1K39dmRpze7TgMU1YleQzVpD+
	eLeWNM0v5r7hI+JHiduRnEXzpI8BEzzp7QW2srcFYOB9LlTfYzD/PfHi96yXNd8E5eBSUfUu28aEB
	XMgkUo+gDFS4auFMRTAcfMKauOOI4U5+fFbCYmQ7iZjvx4VLvyZbA2n0s0EgdJqg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t4Qi1-00000004gYX-3qux;
	Fri, 25 Oct 2024 22:14:58 +0200
Message-ID: <c90c3c9825e3837bf7c47979acd0075b102576ce.camel@sipsolutions.net>
Subject: Re: [PATCH][next] wifi: mac80211: ieee80211_i: Avoid dozens of
 -Wflex-array-member-not-at-end warnings
From: Johannes Berg <johannes@sipsolutions.net>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Aditya Kumar Singh <quic_adisi@quicinc.com>
Date: Fri, 25 Oct 2024 22:14:57 +0200
In-Reply-To: <Zxv7KtPEy1kvnTPM@kspp>
References: <Zxv7KtPEy1kvnTPM@kspp>
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

On Fri, 2024-10-25 at 14:10 -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
>=20
> Move the conflicting declaration to the end of the structure and add
> a code comment. Notice that `struct ieee80211_chanctx_conf` is a
> flexible structure --a structure that contains a flexible-array member.
>=20
> Fix 50 of the following warnings:
>=20
> net/mac80211/ieee80211_i.h:895:39: warning: structure containing a flexib=
le array member is not at the end of another structure [-Wflex-array-member=
-not-at-end]
>=20
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  net/mac80211/ieee80211_i.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
> index e7815ffeaf30..c65adbdf2166 100644
> --- a/net/mac80211/ieee80211_i.h
> +++ b/net/mac80211/ieee80211_i.h
> @@ -892,9 +892,10 @@ struct ieee80211_chanctx {
>  	/* temporary data for search algorithm etc. */
>  	struct ieee80211_chan_req req;
> =20
> -	struct ieee80211_chanctx_conf conf;
> -
>  	bool radar_detected;
> +
> +	/* MUST be last - ends in a flexible-array member. */
> +	struct ieee80211_chanctx_conf conf;
>  };

Oi. That's not just a warnings problem, that's actually a pretty stupid
bug, this will surely get used and radar_detected will alias stuff that
the driver puts there - at least for drivers using chanctx_data_size,
which is a couple: ath9k, iwlmvm, mt792x, rwt89 and hwsim.

Could you resend with a description that this is a bugfix and

Fixes: bca8bc0399ac ("wifi: mac80211: handle ieee80211_radar_detected() for=
 MLO")

please? Or I can do it myself I guess, but ...

This shouldn't go to next, it should go to 6.12 since that broke it...

johannes

