Return-Path: <linux-wireless+bounces-36389-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KrxOC+9BGrrNQIAu9opvQ
	(envelope-from <linux-wireless+bounces-36389-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 20:04:31 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F885388CC
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 20:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D77F330B184F
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 17:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D86541C310;
	Wed, 13 May 2026 17:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="TQkgR1YS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD6738C2B8;
	Wed, 13 May 2026 17:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778695055; cv=none; b=Fv8KEoyiFskayFZ4+NwVcLOTT/ZnVeGRUMCJ332v3aPjI51YqJlD9Npu1gPyIun7nOHmN6DQciKZQtVNkq78T2Ns23A+HersnZv8kR2kKLFwmFskPG6EYfqNMEKyV0HFHnuFKwc1Jx75cmyk+4dhtfy1CyvRZnXCJTLhguyfhkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778695055; c=relaxed/simple;
	bh=XmrrPmZdJaPkEwoIwjxVVxewS4D228++acby7DpxpQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7VyFepizKmtp3pGjTzCPghxBN0slEh9Qi64pcY3rV3e5y9ynbR5ATFEhf+4u31UynapyMi/I/QHHqJIIZH8XMgUiCM7aQnaA1Vgv3G0TjE2hR4kWL+fOnn20DqWdgXMFNz+D+Ja5jUSHUvTKs9/cQo+U/NkmHC+m1B4EoJB9r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=TQkgR1YS; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4gG1Pz13rtzDtMg;
	Wed, 13 May 2026 17:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=riseup.net; s=squak;
	t=1778695047; bh=Uu0Ury0RB4Jz8n9cKBHsi6ncR/kg9AlVj4sjmyqoarQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TQkgR1YSoPPecXK7tPD2J+PWn9Lo27uUCM/PructzgOmUzWI1yRMnxQw10PLe0vV+
	 r/KKAx0EepIwxhKVeW/8HmEf9IP8aIehQqJZkqY4MZviI4O4qUHoFlTQnL61OZoaay
	 6Bojo3j80wrVNtDjlhxW5zVzc5C3fnJSTlmT8bQ4=
X-Riseup-User-ID: FDEA97DCFEFD1AD42A6E284BEB520E068F61E67A59937672D6FCB631F4E492EE
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4gG1Px56s6z1yhC;
	Wed, 13 May 2026 17:57:25 +0000 (UTC)
Date: Wed, 13 May 2026 14:57:18 -0300
From: Santiago Ruano =?iso-8859-1?Q?Rinc=F3n?= <santiagorr@riseup.net>
To: Kyle Farnung <kfarnung@gmail.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
	kfarnung@outlook.com, Mark Pearson <mpearson-lenovo@squebb.ca>,
	koike@igalia.com
Subject: Re: [PATCH v2] wifi: ath11k: Add two missing Lenovo IDs to the quirk
 table
Message-ID: <agS7fr8mDI9TLpvh@voleno>
References: <20260506200249.317690-1-santiagorr@riseup.net>
 <45f1c979-ea8d-4118-8551-eff93966b4e1@oss.qualcomm.com>
 <CAOPSVF29ofKi8fpmJxuq9F5uQXHe4RrFvGb2V-odGMNA77NWXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOPSVF29ofKi8fpmJxuq9F5uQXHe4RrFvGb2V-odGMNA77NWXw@mail.gmail.com>
X-Rspamd-Queue-Id: 43F885388CC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[riseup.net,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[riseup.net:s=squak];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,kernel.org,vger.kernel.org,lists.infradead.org,outlook.com,squebb.ca,igalia.com];
	TAGGED_FROM(0.00)[bounces-36389-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[riseup.net:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[santiagorr@riseup.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,riseup.net:email,riseup.net:dkim]
X-Rspamd-Action: no action

El 12/05/26 a las 20:30, Kyle Farnung escribió:
> On Tue, May 12, 2026 at 5:03 PM Jeff Johnson
> <jeff.johnson@oss.qualcomm.com> wrote:
> >
> > On 5/6/2026 12:54 PM, Santiago Ruano Rincón wrote:
> > > Commit 0eb002c93c3b4 ("wifi: ath11k: Add missing platform IDs for quirk
> > > table") added some Lenovo platform IDs to the quirk table to address a
> > > wakeup from suspend issue [1].  However, at least P14s Gen 5 AMD, as
> > > reported by Kyle Farnung [2], and P14s Gen 3 AMD are missing in the
> > > table.  This commit adds the two corresponding Lenovo version IDs for
> > > each.
> > >
> > > [1] https://bugzilla.kernel.org/show_bug.cgi?id=219196
> > > [2] https://bugzilla.kernel.org/show_bug.cgi?id=219196#c23
> > >
> > > Tested-on: P14s G3 AMD running 7.0.3.
> > >
> > > Fixes: ce8669a27016 ("wifi: ath11k: determine PM policy based on machine model")
> > > Co-authored-by: Kyle Farnung <kfarnung@gmail.com>
> >
> > This is not a standard Linux kernel commit tag.
> > Co-developed-by: could be used, but I'd need a Signed-off-by: from Kyle
> >
> > Kyle, if you'd like these added please reply with both a Co-developed-by and
> > a Signed-off-by tag
> 
> I re-tested the bug behavior on the v7.0.4 tag and found that I'm not able
> to reproduce it on my device. I put the device to sleep and then unplugged
> and replugged power; it never woke up until I intentionally woke it.
> 
> Based on discussion in [3], I narrowed my issue with wi-fi disassociation
> on wake to a suspect commit [4]. I'm developing a patch that clears the rdp
> and wrp buffers during wake to clear out any stale state in the LMAC rings.
> I'll submit that once I'm done testing it.
> 
> Santiago: Are you seeing the sleep/wake bug from [1] or something similar
> to what I was seeing around disconnections on wake?

I was seeing wifi issues after wake-up, including disassociations, as
described at https://bugs.debian.org/1132343.

> 
> [3] https://lore.kernel.org/all/CAOPSVF04q6uvVdq8GTRLHBrVMdpt9=o9wVcFMc6f-yhmSBcZqQ@mail.gmail.com/
> [4] 32be3ca4cf78b ("wifi: ath11k: HAL SRNG: don't deinitialize and
> re-initialize again")
> 
> >
> > I can apply these fixes when I process the patch in my tree.
> >
> > https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by
> >
> > > Signed-off-by: Santiago Ruano Rincón <santiagorr@riseup.net>
> > > ---
> > > Changes in v2:
> > > - Merged the Lenovo P14s G5 AMD #1 and #2 related changes proposed by
> > >   Kyle Farnung in
> > >   https://lore.kernel.org/all/20260330-p14s-pm-quirk-v2-1-ef18ce07996b@gmail.com/
> > > - Added Kyle Farnung as Co-author of the commit
> > > - Added the second ID of Lenovo P14s G3 AMD, and adapt the comments
> > >   accordingly
> > > - v1: https://lore.kernel.org/ath11k/20260423211458.458911-1-santiagorr@riseup.net/
> > > ---
> > >  drivers/net/wireless/ath/ath11k/core.c | 28 ++++++++++++++++++++++++++
> > >  1 file changed, 28 insertions(+)
> > >
> > > diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
> > > index 3f6f4db5b7ee..c1ce0a11af44 100644
> > > --- a/drivers/net/wireless/ath/ath11k/core.c
> > > +++ b/drivers/net/wireless/ath/ath11k/core.c
> > > @@ -957,6 +957,20 @@ static const struct dmi_system_id ath11k_pm_quirk_table[] = {
> > >                       DMI_MATCH(DMI_PRODUCT_NAME, "21K4"),
> > >               },
> > >       },
> > > +     {
> > > +             .driver_data = (void *)ATH11K_PM_WOW,
> > > +             .matches = { /* P14s G3 AMD #1 */
> > > +                     DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> > > +                     DMI_MATCH(DMI_PRODUCT_NAME, "21J5"),
> > > +             },
> > > +     },
> > > +     {
> > > +             .driver_data = (void *)ATH11K_PM_WOW,
> > > +             .matches = { /* P14s G3 AMD #2 */
> > > +                     DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> > > +                     DMI_MATCH(DMI_PRODUCT_NAME, "21J6"),
> > > +             },
> > > +     },
> > >       {
> > >               .driver_data = (void *)ATH11K_PM_WOW,
> > >               .matches = { /* P14s G4 AMD #1 */
> > > @@ -971,6 +985,20 @@ static const struct dmi_system_id ath11k_pm_quirk_table[] = {
> > >                       DMI_MATCH(DMI_PRODUCT_NAME, "21K6"),
> > >               },
> > >       },
> > > +     {
> > > +             .driver_data = (void *)ATH11K_PM_WOW,
> > > +             .matches = { /* P14s G5 AMD #1 */
> > > +                     DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> > > +                     DMI_MATCH(DMI_PRODUCT_NAME, "21ME"),
> > > +             },
> > > +     },
> > > +     {
> > > +             .driver_data = (void *)ATH11K_PM_WOW,
> > > +             .matches = { /* P14s G5 AMD #2 */
> > > +                     DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> > > +                     DMI_MATCH(DMI_PRODUCT_NAME, "21MF"),
> > > +             },
> > > +     },
> > >       {
> > >               .driver_data = (void *)ATH11K_PM_WOW,
> > >               .matches = { /* T16 G2 AMD #1 */
> >

