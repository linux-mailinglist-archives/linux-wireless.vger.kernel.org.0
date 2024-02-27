Return-Path: <linux-wireless+bounces-4099-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2FD86998C
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 16:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99AEB1C20EF9
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 15:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954EF13B289;
	Tue, 27 Feb 2024 14:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="XZ5L06lP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7CE13AA37
	for <linux-wireless@vger.kernel.org>; Tue, 27 Feb 2024 14:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709045771; cv=none; b=g7fH7CH4v0qQ9XCnn14aruzJNp9yf9XIGV8MU8se7FAZi/2Vn/fvsXfegEA8JMo/WSKDAf+Dp7xhJiSSJqdfRS2xbBEbGafG/n4qbvk182UEuNY2jijDh5+/9/uY31HhiT+xIp7Ujupz7eQONj8AajfxSiwQOm/kET+hdn5aUrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709045771; c=relaxed/simple;
	bh=cGEVSgXZpWd3BXMS12edB4j/i8YmDShfaI9ofRTwnX4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H+UHAaeafkOwdjOWko6/f5fH+bweM+aUDGqkABVQ1+UxjG2Tg7jmFny+GlAIYvHSiVrfh5sUnn9veX+Y6cQSZE2XJ5KnvnKqoWwxryAjE7yLLs/AnfHhnSbbFQTsNY1+zA/NeC907L/5Hy/IhQwCF/cDqLRkcc/zf8fwt9wq/jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=XZ5L06lP; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Ha89xy4x3A2ax0eajOqJ7Iy6IiWTLMgECl3WU+OVnyE=;
	t=1709045769; x=1710255369; b=XZ5L06lP2oVf8R3KczG54Tj+37VNC2tkagJiGFrfcFbMPAw
	0sRdbI0kbn9o1LkY9U+P9lwfEVDjwI8wNRRfKXE/ATk7J+QcfP8iU2DnuIGLY8h55iTEAVRSiHxtJ
	kLYOUy0AMUr205A7iIW3gPr9JNsF0Pmw3bujgkT06CIAN2s6+xLPM60dAlFGFUdRQD8T5YWMZtga0
	sScHUFMoM1eO+I7DU19emgpwyZFoSehf0fW7OaLR/juZhWdYEZABJwsRRdibkwujzS4NSjDkTyEbb
	Z5UqAuGPUoVC604QJxnD/KjH460SmBYNM7pQmKB8lUDiF6RmG6Y8KYwThHBFLj8g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1reysI-0000000AkKr-2Tef;
	Tue, 27 Feb 2024 15:56:06 +0100
Message-ID: <d0e4d81d39587ba5cd14577453a97daed09570df.camel@sipsolutions.net>
Subject: Re: Kernel deadlock in 6.7.5 + hacks, maybe debugfs related.
From: Johannes Berg <johannes@sipsolutions.net>
To: Ben Greear <greearb@candelatech.com>, linux-wireless
	 <linux-wireless@vger.kernel.org>
Date: Tue, 27 Feb 2024 15:56:05 +0100
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

Yeah, looks about right. But not entirely sure I'm thinking this through
correctly right now ...

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
> -       /* if we didn't hit zero, try to cancel any we can */
> +       /*
> +        * As long as it's not zero, try to cancel any cancellations,
> +        * new incoming ones will wake up the completion as we might
> +        * have raced: debugfs_file_get() had already been done, but
> +        * debugfs_enter_cancellation() hadn't, by the time we got
> +        * to this point here.
> +        */
>          while (refcount_read(&fsd->active_users)) {
>                  struct debugfs_cancellation *c;
>=20
>=20


