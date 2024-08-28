Return-Path: <linux-wireless+bounces-12160-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94156962681
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 14:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C65A51C20E8A
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 12:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AAA16BE35;
	Wed, 28 Aug 2024 12:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="rXgr2uzi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7242B16C69B
	for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2024 12:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724846669; cv=none; b=laG4Bi5x1i9mzgySA7an9gi4prT9KhHMOI+h6FT+G1DyI/dg4SWlp7MAug+sygXfLwXR7eVx/RPKBlgJ6qc1GIFTiKMq3dWKUavpufGzDk1dAh8+1UeM9iPwcFkyqjzBfBVMPLb+GPAifai8NVXomLpOglmouleAnmYJLB5r2bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724846669; c=relaxed/simple;
	bh=H4ZvHHT5KmgYW+AaIqmJ3/y4HP4g+JQGehfxFSxiW+U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CUCGJ6yRLXMDIzVjsuVy5UfgG2KXzSuH/GQ22xAgReptOL2NRgG9wWzN2A3We+hRXCN5339VN+kSWNAWuAwygVCBaDUC38mJCmQVPuOvdEjNGvAC6Jc0FGJbgW6xFC4SgMlKMklE+3PgIZv7eHVVKQtlEi1buewTx8tbBAndKCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=rXgr2uzi; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=3tUinKbyHOxTFO+gWgrMHemyyDbJNZAt3KRzY9Df5Qg=;
	t=1724846668; x=1726056268; b=rXgr2uzizSvL3vZWEqr7EZFCSdk423nriIyjpZ9I3UNdbRs
	NFBbRaqWo/1g7Cg2VvLIMMB/WdhVAX9T5potx85X1cqE4QQmfwH2YRDYrznaY6M/PeEfvmuO7F8zP
	mK5J3+M0ANxeE0ISG3aqvzkHQK9Mf3tnm0thaeWCAvynx0ss7Idl76ULpKzRhAnS2SixztXDpWWSk
	qee91szOq3n7Xh47N22Xy9OYhu4EaY2ft74ccRDYa069kow+WZc/2yIgN/pS21UO2rSCGbKPvlRrV
	8FYch5cyDrTvcYyyR1D+q2gIJ2dKjKfBEAEidJ5lHNjAAyfM8/1hw69/uiEB5v7Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sjHPV-0000000756O-13gj;
	Wed, 28 Aug 2024 14:04:25 +0200
Message-ID: <f7a99b42dae9a2c5c035515a0c4e70dff6344465.camel@sipsolutions.net>
Subject: Re: [PATCH v3 8/8] wifi: mac80211: handle
 ieee80211_radar_detected() for MLO
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 28 Aug 2024 14:04:24 +0200
In-Reply-To: <22a210cc-8e9f-47f7-8b4b-aff8f9a0781c@quicinc.com>
References: <20240711035147.1896538-1-quic_adisi@quicinc.com>
	 <20240711035147.1896538-9-quic_adisi@quicinc.com>
	 <5c099cda2015594d23f29635d77adf9db5744a15.camel@sipsolutions.net>
	 <22a210cc-8e9f-47f7-8b4b-aff8f9a0781c@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-08-28 at 17:17 +0530, Aditya Kumar Singh wrote:
> On 8/28/24 16:03, Johannes Berg wrote:
> > On Thu, 2024-07-11 at 09:21 +0530, Aditya Kumar Singh wrote:
> > >=20
> > >    * In the worker, go over all the contexts again and for all such c=
ontext
> > >      which is marked with radar detected, add it to a local linked li=
st.
> >=20
> > Why is the local list needed first?
>=20
> As per the current design and hwsim test cases,=20
> NL80211_RADAR_CAC_ABORTED event is expected first and then=20
> NL80211_RADAR_DETECTED event.

Ouch, OK.

> Now, in the worker, while iterating over=20
> the contexts and upon finding radar marked contexts,=20
> cfg80211_radar_event() can not be called immediately. First=20
> ieee80211_dfs_cac_cancel() needs to be called which in turn will send=20
> CAC_ABORTED event. Now calling this will delete the channel context,=20
> hence a local copy is taken and since we could have multiple contexts=20
> marked with radar, a linked list is used.

Why not do both in ieee80211_dfs_cac_cancel() then? You're effectively
iterating all the chanctx's there anyway, so you could just add

 if (ctx->radar_reported) {
    ctx->radar_reported =3D false;
    tmp_chandef =3D ctx->conf.chandef;
    report =3D true;
 }

 ...
 cac_event()
 if (report)
   cfg80211_radar_event(...)

or so in the loop there?

> > > +			radar_info =3D kzalloc(sizeof(*radar_info), GFP_KERNEL);
> > > +			if (WARN_ON(!radar_info))
> > > +				continue;
> >=20
> > that clearly shouldn't be a WARN_ON,
>=20
> If node can not be added, NL event will not be sent to user sapce and=20
> apt action can not be taken. Will that be fine missing out it without=20
> any warning?

Have you actually _seen_ what happens if the kernel runs out of memory?
Not that it'll actually happen here.

> > > +	if (num_chanctx > 1) {
> > > +		/* XXX: multi-channel is not supported yet in case of non-MLO */
> > > +		if (WARN_ON(!(wiphy->flags & WIPHY_FLAG_SUPPORTS_MLO)))
> > > +			trigger_event =3D false;
> > > +	}
> >=20
> > I don't see how that'd happen in the first place?
>=20
> This part is keeping the same old code with the new handling with MLO.=
=20
> Prior to MLO, if num_chanctx is more than 1, it would throw a warn_on so=
=20
> that's why it will throw now as well if MLO is not supported and=20
> simultaneously two channel contexts are marked as radar detected.

I don't think it can actually happen, and if keeping the warning around
makes the code this complex I'm not sure I'd want to?

johannes

