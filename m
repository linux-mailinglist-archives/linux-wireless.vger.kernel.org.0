Return-Path: <linux-wireless+bounces-14326-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4B59AB050
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 16:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61D3B1F22944
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 14:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A44819D88F;
	Tue, 22 Oct 2024 14:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="BUiZYvTg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF7981AD7;
	Tue, 22 Oct 2024 14:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729605737; cv=none; b=c8WIvhReikt0VioX6Q3oIfUaRp8uPtraPsn58OwegursvnMaOpNYj6GCsm+Sy1o6q78B5HAiy6bWsLjBMB18PVTtInx3nenr68+wTGgykGPnECK9GSt+e+IeqnKcrhwcCQkTBb/cHPAu9yx4R7lYBucwCtZxrimGihk+7Z5qW5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729605737; c=relaxed/simple;
	bh=ED3j1hRpxBmLLUASk+1iG/4g/xGTzTGN2UHy/Z5W9NU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aKpX7adM+qSatwkkst8B32vlp2gMQ020IHM5n5aM1vDk+nDnoB6RI3yR0HC8FG9yEEpMq9vopC2kiJpvHh6zQrVQhcCqECDpYo5eiBihFXZ+ifNoBi88woYfOTEI0Nd/HRLdzuDpxjrIcuF7+a4KL6d4lTmu+bkunPoQPLKicZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=BUiZYvTg; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=5wraFinemnXvechAgSBWJnCfd74TP5J4MGgea03qWBw=;
	t=1729605735; x=1730815335; b=BUiZYvTgG8a5ap62uzIci5gCchCCLOwajFayKKUEwiDdx4H
	QhamWLdtU8Bs16DLisUyQTIVUkuFHYcXX05gI8WIc72yu3WiaPCjsOfiLLLphipPfEiYWPLtSSX1k
	q+1AxjQwKz/gSq201FkLWCdA8ezfDN809h1ZU+6taFZYuShIcT8tMDIKFmYxjt4rAdp1euVmEFfFy
	PhscJoclPo3FgAq3zJCZWOESK7kfvU6kKnLVw7/BYZRmf+dyFpR6+pPQNnUU0hQ+6beN1un8oinbG
	Rd7oWlvf3BWDNShMRKBH3Ax1RmYpj3Nhpq5bsV2sHhpG0RLcv42fitGY2e4Ewn0g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t3FSc-00000001lNY-2Uoq;
	Tue, 22 Oct 2024 16:02:10 +0200
Message-ID: <e3c39c3e7be70993c7fa07e58c2beda52ff44cb9.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] debugfs: add small file operations for most files
From: Johannes Berg <johannes@sipsolutions.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, Alexander
 Viro <viro@zeniv.linux.org.uk>, "Rafael J . Wysocki" <rafael@kernel.org>
Date: Tue, 22 Oct 2024 16:02:09 +0200
In-Reply-To: <2024102201-pummel-mournful-d349@gregkh>
References: 
	<20241022151838.26f9925fb959.Ia80b55e934bbfc45ce0df42a3233d34b35508046@changeid>
	 <2024102201-pummel-mournful-d349@gregkh>
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

On Tue, 2024-10-22 at 15:55 +0200, Greg Kroah-Hartman wrote:
> On Tue, Oct 22, 2024 at 03:18:34PM +0200, Johannes Berg wrote:
> > From: Johannes Berg <johannes.berg@intel.com>
> >=20
> > As struct file_operations is really big, but (most) debugfs
> > files only use simple_open, read, write and perhaps seek, and
> > don't need anything else, this wastes a lot of space for NULL
> > pointers.
> >=20
> > Add a struct debugfs_short_fops and some bookkeeping code in
> > debugfs so that users can use that with debugfs_create_file()
> > using _Generic to figure out which function to use.
> >=20
> > Converting mac80211 to use it where possible saves quite a
> > bit of space:
> >=20
> > 1010127  205064    1220 1216411  128f9b net/mac80211/mac80211.ko (befor=
e)
> >  981199  205064    1220 1187483  121e9b net/mac80211/mac80211.ko (after=
)
> > -------
> >  -28928 =3D ~28KiB
> >=20
> > With a marginal space cost in debugfs:
> >=20
> >    8701	    550	     16	   9267	   2433	fs/debugfs/inode.o (before)
> >   25233	    325	     32	  25590	   63f6	fs/debugfs/file.o  (before)
> >    8914	    558	     16	   9488	   2510	fs/debugfs/inode.o (after)
> >   25380	    325	     32	  25737	   6489	fs/debugfs/file.o  (after)
> > ---------------
> >    +360      +8
> >=20
> > (All on x86-64)
> >=20
> > A simple spatch suggests there are more than 300 instances,
> > not even counting the ones hidden in macros like in mac80211,
> > that could be trivially converted, for additional savings of
> > about 240 bytes for each.
> >=20
> > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>=20
> I imagine you want to take this through the wireless tree for the second
> patch, so feel free to do that and add:

I don't even really care, we're not likely to be changing the mac80211
debugfs code in a way that'd create (significant) conflicts. But I can
do that, thanks!

johannes

