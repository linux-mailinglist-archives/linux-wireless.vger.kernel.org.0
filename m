Return-Path: <linux-wireless+bounces-76-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DB57F8D1E
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Nov 2023 19:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 282B41C20AEE
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Nov 2023 18:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68772E648;
	Sat, 25 Nov 2023 18:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="yVTo/WLF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E506DB;
	Sat, 25 Nov 2023 10:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=/elYiV2h43xgthyj4ibpKzQ7Pp8ZcGl+f6ZqBes/X4g=;
	t=1700937111; x=1702146711; b=yVTo/WLFUyDnnC0oOyAM9dz299ILLM9zK2FeE5+kIplRarN
	eZWoGX47VEdsRxfCbeLRF/tvzSbo/ReJvGr2kBphUH2mcr0ovMkHaLGDfA00KJtldMf3t5ooe+k0e
	UYV53XXuG4dE2nIjB4Cx8LKVu6SFH2RnClfdqK7fDn6vY5PSpR6QUVdvCtjz8zbdIpP/C5vIGbt0G
	1TpMJepjpmd8qumD+VV6K5B8CUj+5pVubumUYVSaVs6d2HbzXHsBNuESto4s4ogUkYEAc9u30IrPW
	CdozLSk+ZiWpCrlpcMHIQXUMCmc0PASV+WWpkAklKvx3pZYIQ0lA/oqbCv31M0aw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r6xRU-00000003uMR-1doN;
	Sat, 25 Nov 2023 19:31:48 +0100
Message-ID: <d89598efbb289d211c19880cd33db77f9dae4431.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/6] debugfs: fix automount d_fsdata usage
From: Johannes Berg <johannes@sipsolutions.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J.
	Wysocki" <rafael@kernel.org>
Date: Sat, 25 Nov 2023 19:31:47 +0100
In-Reply-To: <2023112519-reprocess-backtrack-0732@gregkh>
References: <20231124162522.16344-7-johannes@sipsolutions.net>
	 <20231124172522.01928f127e73.I64fe5615568e87f9ae2d7fb2ac4e5fa96924cb50@changeid>
	 <2023112519-reprocess-backtrack-0732@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Sat, 2023-11-25 at 14:48 +0000, Greg Kroah-Hartman wrote:
> On Fri, Nov 24, 2023 at 05:25:24PM +0100, Johannes Berg wrote:
> > From: Johannes Berg <johannes.berg@intel.com>
> >=20
> > debugfs_create_automount() stores a function pointer in d_fsdata,
> > but since commit 7c8d469877b1 ("debugfs: add support for more
> > elaborate ->d_fsdata") debugfs_release_dentry() will free it, now
> > conditionally on DEBUGFS_FSDATA_IS_REAL_FOPS_BIT, but that's not
> > set for the function pointer in automount. As a result, removing
> > an automount dentry would attempt to free the function pointer.
> > Luckily, the only user of this (tracing) never removes it.
> >=20
> > Nevertheless, it's safer if we just handle the fsdata in one way,
> > namely either DEBUGFS_FSDATA_IS_REAL_FOPS_BIT or allocated. Thus,
> > change the automount to allocate it, and use the real_fops in the
> > data to indicate whether or not automount is filled, rather than
> > adding a type tag. At least for now this isn't actually needed,
> > but the next changes will require it.
> >=20
> > Also check in debugfs_file_get() that it gets only called
> > on regular files, just to make things clearer.
> >=20
> > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> > ---
> > v2: add missing kfree() pointed out by smatch
>=20
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

I have to fix the Kconfig issue in one of the later (wireless) patches,
but does that mean you'd actually prefer the debugfs changes go through
the wireless tree, together with the code using it?

Thanks,
johannes

