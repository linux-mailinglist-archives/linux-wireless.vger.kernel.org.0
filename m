Return-Path: <linux-wireless+bounces-16409-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDAE9F2E9C
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2024 11:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6AB3188574D
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2024 10:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4E32040A7;
	Mon, 16 Dec 2024 10:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="u6b+QXle"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEE6204087
	for <linux-wireless@vger.kernel.org>; Mon, 16 Dec 2024 10:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734346464; cv=none; b=i6Vg+zCSeJW1fTM6QjaaPzrusP+m/EHhTkttxe6+4y0UJfr4iOt7pxL+NBbK0n/hNFBXUZnuF0r1wxJjtAxUrbH7mOPjdR6aj8c7ithtY0mG8WbATT/lUvdYws+jZsQcwlG5F3QtMjaqpBNUgGOEZGs9C0+KEEm3/v/2B/WBDOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734346464; c=relaxed/simple;
	bh=QupdoyGWqnolXDJdsSslSyY/znjN2VY3cXrK8BMGRWE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z0s2zK2h/YgjMSJn1qYmQ2qMOsAPsh3RJN7OM6CFtwxqKLo6REEpUZNWJO8rLLa/HvbZmFUM0iuvLN44+sLolrm5OWPVFiVB3ucgZmL3qtQJPQDI66hgLDr7j6d+N6xVHH/go4XPaOEfbQjb3v3l3JZ3Dc8EMyOeXvn0k1e4REs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=u6b+QXle; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=yRebM+02jIZsg3aUTafkDTU4G1PgRYV1LVMdGiYxOpc=;
	t=1734346462; x=1735556062; b=u6b+QXleJRdBZErWLZTdVZgjZtpQpjVs6sJ0jZVABwGEBrr
	b5RGvre96zIfUh4YeVZFP0305b9ZLIbmYdpaetrfi6lVzIJHV+QvFhs83HhTOfdWcvj2UaO1936BR
	DucViOrzrpH7GTpBTPGL742GNrmEYWw1yGitdgwFZ6XE+7S5b43JVwr2Z3LHGd2+t9z0QT4Oqk0Ba
	67/rqBFDmgXbc8nBDwbZ8JrNH5P26V/pkBw0hi/hGDFy8UCt4YWxQoP4CwZmaNVmIG2smurNlPfXo
	BiQe7JG/omvG1DxNLup0XSQsOPj0cxoeuJoovDqkjYmScNZUUvIXTq9geh1/wKaw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tN8jt-00000000vAf-1k8P;
	Mon, 16 Dec 2024 11:54:13 +0100
Message-ID: <42e0e767b0dd55c8ddaca0cbf6aa123ec8fa3942.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: ieee80211: update Indoor AFC standard power type
 definition
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Veerendranath Jakkam
	 <quic_vjakkam@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Mon, 16 Dec 2024 11:54:12 +0100
In-Reply-To: <11d8f3a6-3942-44dd-9c41-fdc645e5fdeb@oss.qualcomm.com>
References: <20241213121146.2398269-1-quic_vjakkam@quicinc.com>
	 <a850fd692db3458301eb5b7388110a3ec6ec0d01.camel@sipsolutions.net>
	 <11d8f3a6-3942-44dd-9c41-fdc645e5fdeb@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2024-12-13 at 12:11 -0800, Jeff Johnson wrote:
> On 12/13/2024 4:16 AM, Johannes Berg wrote:
> > On Fri, 2024-12-13 at 17:41 +0530, Veerendranath Jakkam wrote:
> > > Update 6 GHz regulatory info subfield mask and Indoor AFC standard po=
wer
> > > type definitions to align with spec changes introduced in the Draft
> > > P802.11Revme_D4.2, Figure 9-896 and Table E-13.
> > >=20
> >=20
> > Huh. That seems like a change explicitly *designed* to break backward
> > compatibility? Should we accept the old value from older APs or so?
> > Otherwise we can't connect in some scenarios, I think?
> >=20
> > Or at least should we say here in the commit message or so why backward
> > compatibility was broken, and that it was for other clients that didn't
> > behave well or something but our code was already fine?
> >=20
> > Or am I completely confused about it?
>=20
> IEEE Drafts sometimes make non-backward-compatible changes.

Umm. Me voicing confusion isn't a reason to state obvious things back to
me as if that explained anything at all?

In any case, they actually do that _very_ rarely (these days at least,
that was different 20 years ago I'd say) without taking existing
deployed things into account though.

> This change brings
> us up to date with the language in Draft 7.0 that was ratified and will b=
e
> published as IEEE 802.11be-2024.

That's not what this claimed in the commit log.

It also _cannot_ be correct since this stuff is in baseline as far as
802.11be is concerned, so it really cannot make incompatible changes
that suddenly make all HE stations non-compliant.

And now that you're forcing me to look into it, I see that of course it
doesn't do that. This has nothing to do with Draft 802.11be in any
version which only makes one simple change to Annex E to add 320 MHz.

The commit log claims that REVme changes it, and while that might be
true, looking at REVme (I don't have a redline version at hand right
now) indicates that certainly it didn't make it backward incompatible,
it now accepts multiple values and accepts the old values.

>  So if anything breaks, it is because it
> hasn't been updated from the draft to the ratified standard.

Clearly not.

Suggest you go back to the drawing board with these changes.

johannes

