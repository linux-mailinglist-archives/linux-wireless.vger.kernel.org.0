Return-Path: <linux-wireless+bounces-32749-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id fpgELw1yrmkCEgIAu9opvQ
	(envelope-from <linux-wireless+bounces-32749-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 08:09:01 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A726234A5B
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 08:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 46C5A30058E1
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2026 07:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204AA35DA41;
	Mon,  9 Mar 2026 07:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Ts24dMm/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D085735838A;
	Mon,  9 Mar 2026 07:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773040139; cv=none; b=nRpEGovPhRd2S+vidabzTRiw7ILJrXXTtV/2nVkSZE66E76PCgWncVw3RYQTxo6xWFGp9SrcqtWEd6PD0ltdRoaN8Zzj4MbPn0nR5SPFNBBZOFT2c3mvBg4IrCE/YXdQWhgHpt9033oRZ+ePOKLE5cJjTyxPFQuTvpb5CogWlX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773040139; c=relaxed/simple;
	bh=XpY/t2PZhWdNCbnz6i8Ww/rhyBIIvWSYrY+/h+T7duw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vAOx0X6INoDcfZY3kpssjtlP2kPaLl9Etkr0Xj/QZTOBveUAbfoMNMW3E8N71fWqTvIe3f4Lqyo9R5eavs7YoNpK3gKb/gEIw/JM0A7DITtdRZdxir0qa6BPfHpAwhXjm9q2a/hxyDfbZJObqRdDVIcjh0PMdPCyFfIivbEc0vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Ts24dMm/; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=gZMGKabdYzeLfhDsJ1Db2AbYSD4HGbVvgVYnxD/7438=;
	t=1773040137; x=1774249737; b=Ts24dMm/JUDSgVn3dstv2ECeC3tTZIS9M6rfLsKqguPyFgv
	PDVLE2M3KXsqNepw9aVA19ccVjfRqiQIfV1Q4LvJmJtIM8Y3ThaGjjzqkKzjjP/Ps1x0IMKXARfh1
	W6GydgtwoOo+I0GNWKGUMNxQamWprUb08jFrprumN7rgQKJf0nPVzNCqoDhdwtvyLcZSqkcD6txDs
	4gI/uXF6lxflvnX3ZsbZErR1W8wjPlkDvf4Sl1t9mEUTKLmYuLl4zyshUJuLGmMY1CTyHgs2VQ4cM
	c5Ut++cAOBMiZZygb4IKYKLdvR86s4smOBT5QGiVVnAVeoUmMXq70Ygy5UhUvOSg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vzUjW-0000000Clsm-0APJ;
	Mon, 09 Mar 2026 08:08:54 +0100
Message-ID: <1ca86ec4a1af1edfb791ca65023ab1979507c5bc.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 14/35] wifi: mm81x: add mac.c
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: Dan Callaghan <dan.callaghan@morsemicro.com>, Arien Judge	
 <arien.judge@morsemicro.com>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt	 <justinstitt@google.com>,
 ayman.grais@morsemicro.com, 	linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 09 Mar 2026 08:08:53 +0100
In-Reply-To: <vttdls7sm4h3br7y5kcea5i4teqnuiuzgq3miswg6r45asvng7@jto3tksuvofj> (sfid-20260309_054337_596627_E09272CA)
References: <20260227041108.66508-1-lachlan.hodges@morsemicro.com>
	 <20260227041108.66508-15-lachlan.hodges@morsemicro.com>
	 <a04a91f1203609e89df97cc950bb2af37a66aee5.camel@sipsolutions.net>
	 <vttdls7sm4h3br7y5kcea5i4teqnuiuzgq3miswg6r45asvng7@jto3tksuvofj>
	 (sfid-20260309_054337_596627_E09272CA)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Rspamd-Queue-Id: 5A726234A5B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[morsemicro.com,kernel.org,gmail.com,google.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-32749-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.972];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,lkml];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Mon, 2026-03-09 at 15:43 +1100, Lachlan Hodges wrote:
> >  2) Are you going to incur the wrath of mm/ folks, where instances of
> >     'struct mm_struct' are commonly called 'mm'? I can find a few
> >     examples of others (struct drm_buddy *mm, struct mqd_manager *mm),
> >     but you'd double the instances.
>=20
> This.. is definitely something I did not think of. I have no issue with
> renaming to something else.. maybe mx? I'm not sure.

Yeah I really don't know. There's no 'mm->lock' (any more? for some
reason _that_ was what caught my eye wrt. the naming) in mm/, and I
guess soon also not in your driver. I'll try to ask around, but it's
probably safer to rename, and shouldn't be _that_ hard with spatch I
guess. I guess 'mx' seems reasonable, 'mmx' is also confusing perhaps,
and 'mm81x' doesn't lend itself to obvious other abbreviations.


> > > +	/*
> > > +	 * mm81x only support changing/setting the channel
> > > +	 * when we create an interface.
> > > +	 */
> > > +	if (WARN_ON(changed & IEEE80211_CHANCTX_CHANGE_CHANNEL))
> > > +		mm81x_err(mm, "Changing channel via chanctx not supported");
> >=20
> > Wait, what, why do you have chanctx support then? This seems highly
> > questionable, how do you not run into this all the time?
> >=20
> > If it just has a single, wouldn't the chanctx emulation suit the driver
> > better, and that'd make this more obvious? Hmm, but you _do_ support
> > multiple vifs? I'm confused.
>=20
> We originally used chanctx emulation.. but I suppose in an effort to
> be "modern" we use chanctx. It's probably best to switch back to the
> chanctx emulation anyway. As for why we don't run into this is due
> to no channel switch support yet, iirc mac80211 I think needs a minor
> tweak to work with S1G (which further reinforces the idea that we
> should just emulate chanctx)

I don't mind the emulation _that_ much to force drivers into some
unnatural scheme for them :) This seems even more confusing and
unexpected than the emulation perhaps.

But I don't want to impose here either.

> Thanks for the review. On the other thread [1] you mentioned sending a
> pull request once reviews settle down, as per the documentation in [2]
> (which I should have read earlier... :) ),

Heh, I didn't really know we had that document either, Kalle did all
that :)

> can we confirm that this means
> we are to submit subsequent patchset revisions in the same per-file
> format until everyone is happy with the driver, and then raise the PR?

I wouldn't necessarily way _everyone_, you can probably always find
someone willing to nitpick if you look hard enough ;-)

But yeah, I don't think you have a choice for how to post, the whole
driver as one patch would not really even load well in an email client I
guess, let alone make it possible to comment on easily.

As I said there, for the merge I'd prefer just a single commit as a pull
request.

Obviously I hope/expect you're going to continue to maintaining the
driver and we'll have to figure out the workflow for that - perhaps
depending on how much work you're planning to put into it.

johannes

