Return-Path: <linux-wireless+bounces-4095-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A054F869897
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 15:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1185AB30FC1
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 14:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA9413B79F;
	Tue, 27 Feb 2024 14:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="UCCSd7DH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1CD13B798
	for <linux-wireless@vger.kernel.org>; Tue, 27 Feb 2024 14:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709044365; cv=none; b=bpCLPmky+SlW5vQiRybCzFkCN+p8im0diXGBEsDAAV1SpRAjcrklUj74/v1MwGekp5nzjXsWKqF/Utr4DqvtDRV/JPP07oBDojUy3hKFDqfOfX3qGxK+UzhAfrW7tmquJdo8CnvZuMaqyzZh4ZBv0kc4Gcj1TYQqcVQctYNTwIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709044365; c=relaxed/simple;
	bh=axcPbXbUSY/XRNTbE30hBVb/AtnvuIDIVJHGFhc3q1M=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QmOr7b86Xm3Y/WhbaLd2y3HUUFdRgO4soNPnjlflSDMCaOqS0UJJ8Hw2GatdRQxPh6DUNV09GEwhpZ49kBxa9FU/97PdSZy8p2jDqq3mvwa9C3ESpUuxiiQX1VgQGtDMHHlCc8wZ/t2SwWoSo4AfhJZ2LrZkgGECX6kYIO/rMCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=UCCSd7DH; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=7ipt4vJibGdGJI8ORo6RBWcE0A4Qt4II4w3bnSgo/ls=;
	t=1709044363; x=1710253963; b=UCCSd7DHEbj+Qlrq1Ll1XRhFx31sLqFBIaF7tjiwsweD/XX
	6rcirzqjT5GAx/nkv2y/VZX+Ss5Jlusw/+TAgluRd1KDgxsHQWQowTZpHUac3oUn+t5ffmn6MqrtY
	n3Ny1AtHjG88TUcQgAUhEDwlBPuu9oN5s24sxA07u9Op+nOPZljleMTu9qJkv6k43WJJ8kerAdL2g
	YZrhWTrotb/CtHqs83ZE1hTviWoqmPy8gGQTG/PfaL7aJ9VxWu0m+zBNAcAcV8tU4Ey49Q06uMt+3
	xHCs36WdNHonLj1NjYrFU6/fxMzdh4t4AP+OrOLxhnnmS4N6rTRVpVqdP3QhEadQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1reyVc-0000000AjQ1-3IZ2;
	Tue, 27 Feb 2024 15:32:40 +0100
Message-ID: <4a3edd404b84da53b56bb0a391cb42d00f42f4c5.camel@sipsolutions.net>
Subject: Re: Kernel deadlock in 6.7.5 + hacks, maybe debugfs related.
From: Johannes Berg <johannes@sipsolutions.net>
To: Ben Greear <greearb@candelatech.com>, linux-wireless
	 <linux-wireless@vger.kernel.org>
Date: Tue, 27 Feb 2024 15:32:39 +0100
In-Reply-To: <33cc22b8-5852-42ae-9e80-8c3c58c36b6d@candelatech.com>
References: <1c9fa9e5-09f1-0522-fdbc-dbcef4d255ca@candelatech.com>
	 <bdc7c51e3b6afaa7ac79efa15c6d1d41e9e918b5.camel@sipsolutions.net>
	 <95d56b9a-4b91-476f-bab3-7af0f28ff469@candelatech.com>
	 <0f8a0451e547f318febcbe36823e1f9914cc684b.camel@sipsolutions.net>
	 <33cc22b8-5852-42ae-9e80-8c3c58c36b6d@candelatech.com>
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

On Tue, 2024-02-27 at 06:29 -0800, Ben Greear wrote:
> > --- a/fs/debugfs/inode.c
> > +++ b/fs/debugfs/inode.c
> > @@ -751,13 +751,19 @@ static void __debugfs_file_removed(struct dentry =
*dentry)
> >   	if ((unsigned long)fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)
> >   		return;
> >  =20
> > -	/* if we hit zero, just wait for all to finish */
> > -	if (!refcount_dec_and_test(&fsd->active_users)) {
> > -		wait_for_completion(&fsd->active_users_drained);
> > -		return;
> > -	}
> > +	/*
> > +	 * Now that debugfs_file_get() no longer sees a valid entry,
> > +	 * decrement the refcount to remove the initial reference.
> > +	 */
> > +	refcount_dec(&fsd->active_users);

>=20
> [   94.576688] ------------[ cut here ]------------
> [   94.576699] refcount_t: decrement hit 0; leaking memory.
>=20

Ah ... right, refcount_dec() doesn't like to hit 0, it's not meant for
this path.

I guess we can

if (refcount_dec_and_test(...))
   return;

while (refcount_read(...)) { ... }

johannes

