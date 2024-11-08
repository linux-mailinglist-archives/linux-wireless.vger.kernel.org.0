Return-Path: <linux-wireless+bounces-15128-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C0F9C172B
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 08:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D4B31F223D8
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 07:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DA619413C;
	Fri,  8 Nov 2024 07:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="SML2xXWw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B3DEBE;
	Fri,  8 Nov 2024 07:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731051928; cv=none; b=pXkZF3/VneZKsMlZDMPKqzAWFbOlizXIrk54HCEMBRQSfOxildypd+F/4oM1RIXVrvSaakWcGOGhlTAkOmc+XdPKZFQgrArc0tmG2A+Ajim3z9gy5HnLqqJ8QYd2ptxeBR0xi/rh/dGOgBy0B2dlT0MLqFjTZj9AV75QC6sNVco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731051928; c=relaxed/simple;
	bh=OvF0qleoQJoKpbn0wuM7TLiHbXbO297Ng/DHJ06aK6o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oRxRo30A8P78H+ytJW2kR+Fy9VsoNJ1bN+zy3qC6DZB90nTapl/ihO/TNMZqqdGJk3UfDSveot8185EbPjwmxTAIIWuGtxiXvqCR0o0GcUJSFz+LIxIJnvtAtM5sP9IQAGnUFUp2CvivzB+w2OXfAEsnKGtlbs+GB6j9FD8FQwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=SML2xXWw; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=K7uh4BH5+X3HtSl3iUq7LWgMAEO+9K5RNU4S03RbX14=;
	t=1731051926; x=1732261526; b=SML2xXWwo849Jt3MjtC/rZ0PiTpoIEUBq34dYbxJ8aBO3zE
	6xp5vWNKNxP0uaDN4dAQfDEnEjX/wZvDm4dxaT34j24A+uH2DjYkKKDNudIdrs40qj2o75j7ZrjvT
	IroFBcb19trZg+sO19CfJyXuT5Xh3ZvJquqfxczfxo4xwmkoXH6SL4H17z7KOFgsCoBfQg4W26c5D
	65GbREFQX/vF0SpSHpjDPlevFsvBlSCpJgek84b5FOekBe2l3eT70gT4/Cgv57wRkBc80nAqBByKh
	94/YpvNLzCoVOh26/HlTpRe09idTyXhqa4b6qpzCjcXRN+LfsExISgoxy7MWT+ag==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t9JgH-0000000HA2D-18Wy;
	Fri, 08 Nov 2024 08:45:21 +0100
Message-ID: <596b789eec8c6ffdfbd6a9073464a5f19a050336.camel@sipsolutions.net>
Subject: Re: [PATCH] Fix: Ensure auth_data and ap_addr are properly set
 before marking STA as authenticated
From: Johannes Berg <johannes@sipsolutions.net>
To: Saru2003 <sarvesh20123@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com,  linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org
Date: Fri, 08 Nov 2024 08:45:20 +0100
In-Reply-To: <20241108022828.6571-1-sarvesh20123@gmail.com>
References: <20241108022828.6571-1-sarvesh20123@gmail.com>
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

On Fri, 2024-11-08 at 07:58 +0530, Saru2003 wrote:
>=20
> +++ b/net/mac80211/mlme.c
> @@ -4247,8 +4247,15 @@ static void ieee80211_auth_challenge(struct ieee80=
211_sub_if_data *sdata,
>  static bool ieee80211_mark_sta_auth(struct ieee80211_sub_if_data *sdata)
>  {
>  	struct ieee80211_if_managed *ifmgd =3D &sdata->u.mgd;
> -	const u8 *ap_addr =3D ifmgd->auth_data->ap_addr;
> +	const u8 *ap_addr;
>  	struct sta_info *sta;
> +=09
> +	if (!ifmgd->auth_data ||

That's ridiculous. By the argument behind this we could add probably
hundreds of such checks all over the place.

>  !ifmgd->auth_data->ap_addr) {

and that's even a compiler warning.

>  	sta =3D sta_info_get(sdata, ap_addr);
>  	if (!sta) {
> -		WARN_ONCE(1, "%s: STA %pM not found", sdata->name, ap_addr);
> +	        sdata_info(sdata, "STA %pM not found, skipping authentication m=
ark\n", ap_addr);
>  		return false;

That's also wrong, it doesn't just skip that part.

johannes

