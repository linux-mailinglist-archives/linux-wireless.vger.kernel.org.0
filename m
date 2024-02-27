Return-Path: <linux-wireless+bounces-4101-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 146278699B0
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 16:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2CF8293C57
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 15:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBC3145324;
	Tue, 27 Feb 2024 14:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="jnLgXUtG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B953014A0BE
	for <linux-wireless@vger.kernel.org>; Tue, 27 Feb 2024 14:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709045920; cv=none; b=Ot8/faDOFURBVt6e67/jzjGz7pozyBj1Hko4OPBPgAfqT51v0T+LUtKU/zyMZiZPhbZEEFJ9GTN1nb5/TO0HAvbgxDbEFjXg2ZXwL9W770/QE4mEQMRdIYwMKjbpIMUHB62PRolYaO+gtfT75ImywLmrBz83GncVtShy9eljZmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709045920; c=relaxed/simple;
	bh=eiDdJXowgYqlQDN+ivrhrty+DwkqIw/GjM/SGzZspIo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y8KqJXn3sR3VTD6cy2M75APbCMeYTuIYrjTxPhCJp0RixZk/iJYoQWEnnAzRj3NphCD0uJzb+aJgZ3f/QBkx8O8pP/TgNhMRMsTMlYP7WH1SXVU7kDYhtu1CjXY8vVdHVBGrjdc1z+QPmNgXDZzanrHj7y+fnLDjC4yM3BsO0Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=jnLgXUtG; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=s4vEkokg8rzYyPnClul7AERIr9nMnYpnxJMNPLjXNPk=;
	t=1709045918; x=1710255518; b=jnLgXUtGPoZ0bxIiNjtRVSK8CJmL/0yJv8RFVD8EZv7cgI8
	IzRviEOUBoHqNt+xoiuMza1edEhImSighLlFpf9XKs0ehAnkuQQWN90c0XFgq5d6HZtWh9YxLzyhx
	s7ZXEhyVqcAZk41R3H1Ljggmx+hJgF45ZCom/shA8+ZpLDhJ4xOKZC/Ik3n8cxBeUPgme9xTcGNs1
	UY63JT66yY0u8cAanvDf4ukBXxWt/x1qGg+A+kaTn5aJ2bUU2vuFxyyom7nFn3WVuqD2YObJ2ITVo
	FgzfO16fr2sU2Qzm+nAaae3MZkeLenhibGl2F1GbPRGjPuJGBtN7uVIkOgC1U+ZA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1reyui-0000000AkRI-0UI7;
	Tue, 27 Feb 2024 15:58:36 +0100
Message-ID: <366ed520b5f4b3cd603be11124f9b51e32ce8106.camel@sipsolutions.net>
Subject: Re: Kernel deadlock in 6.7.5 + hacks, maybe debugfs related.
From: Johannes Berg <johannes@sipsolutions.net>
To: Ben Greear <greearb@candelatech.com>, linux-wireless
	 <linux-wireless@vger.kernel.org>
Date: Tue, 27 Feb 2024 15:58:35 +0100
In-Reply-To: <492a290b-752f-48c3-be16-59bdf7914487@candelatech.com>
References: <1c9fa9e5-09f1-0522-fdbc-dbcef4d255ca@candelatech.com>
	 <bdc7c51e3b6afaa7ac79efa15c6d1d41e9e918b5.camel@sipsolutions.net>
	 <95d56b9a-4b91-476f-bab3-7af0f28ff469@candelatech.com>
	 <0f8a0451e547f318febcbe36823e1f9914cc684b.camel@sipsolutions.net>
	 <33cc22b8-5852-42ae-9e80-8c3c58c36b6d@candelatech.com>
	 <4a3edd404b84da53b56bb0a391cb42d00f42f4c5.camel@sipsolutions.net>
	 <492a290b-752f-48c3-be16-59bdf7914487@candelatech.com>
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

On Tue, 2024-02-27 at 06:51 -0800, Ben Greear wrote:
> On 2/27/24 06:32, Johannes Berg wrote:
> > On Tue, 2024-02-27 at 06:29 -0800, Ben Greear wrote:
> > > > --- a/fs/debugfs/inode.c
> > > > +++ b/fs/debugfs/inode.c
> > > > @@ -751,13 +751,19 @@ static void __debugfs_file_removed(struct den=
try *dentry)
> > > >    	if ((unsigned long)fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)
> > > >    		return;
> > > >   =20
> > > > -	/* if we hit zero, just wait for all to finish */
> > > > -	if (!refcount_dec_and_test(&fsd->active_users)) {
> > > > -		wait_for_completion(&fsd->active_users_drained);
> > > > -		return;
> > > > -	}
> > > > +	/*
> > > > +	 * Now that debugfs_file_get() no longer sees a valid entry,
> > > > +	 * decrement the refcount to remove the initial reference.
> > > > +	 */
> > > > +	refcount_dec(&fsd->active_users);
> >=20
> > >=20
> > > [   94.576688] ------------[ cut here ]------------
> > > [   94.576699] refcount_t: decrement hit 0; leaking memory.
> > >=20
> >=20
> > Ah ... right, refcount_dec() doesn't like to hit 0, it's not meant for
> > this path.
> >=20
> > I guess we can
> >=20
> > if (refcount_dec_and_test(...))
> >     return;
> >=20
> > while (refcount_read(...)) { ... }
> >=20
> > johannes
> >=20
>=20
> Like this?
>=20
> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> index 034a617cb1a5..166053095610 100644
> --- a/fs/debugfs/inode.c
> +++ b/fs/debugfs/inode.c
> @@ -751,13 +751,20 @@ static void __debugfs_file_removed(struct dentry *d=
entry)
>          if ((unsigned long)fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)
>                  return;
>=20
> -       /* if we hit zero, just wait for all to finish */
> -       if (!refcount_dec_and_test(&fsd->active_users)) {
> -               wait_for_completion(&fsd->active_users_drained);
> +       /*
> +        * Now that debugfs_file_get() no longer sees a valid entry,
> +        * decrement the refcount to remove the initial reference.
> +        */
> +       if (!refcount_dec_and_test(&fsd->active_users))
>                  return;
> -       }
>=20

Which, btw, ignoring comments, braces, whitespace - then really just
removes the line you're getting stuck on.

So actually no ... invert the test?

 if (refcount_dec_and_test(...))
   return;

If it hit zero here, there's guaranteed to be no user, so we can return.

If it's not zero yet, we might yet go into a new cancellation, so we
need the rest of the function.

johannes

