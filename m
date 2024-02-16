Return-Path: <linux-wireless+bounces-3659-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2448576A5
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 08:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C6DB1F21A03
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 07:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E9A179AB;
	Fri, 16 Feb 2024 07:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="cldR7gQw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC7315E90
	for <linux-wireless@vger.kernel.org>; Fri, 16 Feb 2024 07:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708067560; cv=none; b=QyoyekzfYybj+4Fz3sSJp/OqgedB1D1Fr7jIeCs3QzLJl+jJJGRNxFYme2DyrKAnTbvlA/L09A9KHfDM0w8QqrjULQrrTb/4RiD5DzTBEWQ9ZoNCHnZprPFOzKaYiGuHC8lWJdwfcYC1nIxizmtLVkFqDXI+QJzmufBu0AGqm3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708067560; c=relaxed/simple;
	bh=ZnQLy9z5bRn+XAhGtQMxBV4kc0vlFVeA89UzabHMV6c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FCmxg3v8EDp64LZMCpyJ9pu+2Eo36LK+QcB5WlaXoIbx8+gaapwjS5Mb8JgyStH6YHbtdGbLjrLsWHS2MT5dgKJ9UH5QYm+OTVrdLfKxBnJBjPCpDgHichpfyUOoX+LxsiFUH5nYk/hl702f7USbTwxNrfW5AMpf4eBTN9yBpFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=cldR7gQw; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=5rXW/I14vVl9YxSzcMQwkTKcKZkrdMZBS9kC0QBFHD0=;
	t=1708067558; x=1709277158; b=cldR7gQwJ6wjctYZAnZn2jJOEnvg6pqcYlZqhMpaQL7Yakb
	Au4E1pTj8VVaykEhrNZt11qX5G2t9g6LiMpJqVuAwWbqIhU5UmM0Ge0GCG4XKztC4ugJ8/COjKo0q
	pRaj3MROtmdfGPcH7XflmYYTzmxBmLgfJEt6i5BW0Pg4iUnWg/NeS/ZEuf0niQenuMJNL8ZtgEtvj
	faSy5NRRB9h3E4PaiyKpmOuv16fj4XdYH9Vm/eHZgFxqMJD8Y4bcVdY5CgagTkdPlbP82A350sBf0
	Ag9kZtdcXQk4kA2h77F+h9w4gUoppQYLsQKqXPfGzXQJMEFzsicvoo9dgYEnbC3g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rasOf-0000000COQV-3qQs;
	Fri, 16 Feb 2024 08:12:34 +0100
Message-ID: <e5893311f9a5cf31f2bcb1eff9018e0924f83eba.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] wifi: mac80211_hwsim: add support for
 switch_vif_chanctx callback
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Fri, 16 Feb 2024 08:12:32 +0100
In-Reply-To: <78c51497-dd6b-4d7a-b789-e3823e89a96a@quicinc.com>
References: <20240215162811.506065-1-quic_adisi@quicinc.com>
	 <20240215162811.506065-3-quic_adisi@quicinc.com>
	 <de92380b3ec6d4e6bf854479fb3eca5ae88cf1fc.camel@sipsolutions.net>
	 <78c51497-dd6b-4d7a-b789-e3823e89a96a@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2024-02-16 at 08:45 +0530, Aditya Kumar Singh wrote:
>=20
> > > +	for (i =3D 0; i < n_vifs; i++) {
> > > +		hwsim_check_chanctx_magic(vifs[i].old_ctx);
> > > +		wiphy_dbg(hw->wiphy,
> > > +			  "switch vif channel context: %d MHz/width: %d/cfreqs:%d/%d MHz =
-> %d MHz/width: %d/cfreqs:%d/%d MHz\n",
> > > +			  vifs[i].old_ctx->def.chan->center_freq,
> > > +			  vifs[i].old_ctx->def.width,
> > > +			  vifs[i].old_ctx->def.center_freq1,
> > > +			  vifs[i].old_ctx->def.center_freq2,
> > > +			  vifs[i].new_ctx->def.chan->center_freq,
> > > +			  vifs[i].new_ctx->def.width,
> > > +			  vifs[i].new_ctx->def.center_freq1,
> > > +			  vifs[i].new_ctx->def.center_freq2);
> > > +		hwsim_set_chanctx_magic(vifs[i].new_ctx);
> >=20
> >=20
> > hwsim_set_chanctx_magic() is only partially correct, I think, this
> > depends on the mode? For CHANCTX_SWMODE_REASSIGN_VIF the chanctx should
> > already exist as well, so should also be hwsim_check_chanctx_magic() in
> > that case?
> >=20
>=20
> Oh yeah missed the mode dependency here. Thanks for pointing it out. So=
=20
> it should be something like -
>=20
> ...
>=20
> /* old already exist so check magic */
> hwsim_check_chanctx_magic(vifs[i].old_ctx);
>=20
> if (mode =3D=3D CHANCTX_SWMODE_REASSIGN_VIF) {
> 	/* Reassign then new would also exist, just interface is
> 	 * switching
> 	 */
> 	hwsim_check_chanctx_magic(vifs[i].new_ctx);
> } else {
> 	/* SWAP_* then new context does not exist hence set magic.
> 	 * Also old will no longer exist so clear the magic
> 	 */
> 	hwsim_set_chanctx_magic(vifs[i].new_ctx);
> 	hwsim_clear_chanctx_magic(vifs[i].old_ctx);
> }
>=20
> ...
>=20
> One thing, in patch should I keep those comments or those are noisy?=20
> Seems noisy to me (if at least mode documentation is referred then=20
> things are clear already)?
>=20

I'm not sure I care all that much, but I'd say even with the reference
to the modes, it's fairly easy to figure out at least by looking at the
mode docs?

I'd probably go for a switch () statement on the modes and even WARN on
invalid mode, while at it? hwsim is a test vehicle, after all.

No strong opinions on either (comments and switch) though.

johannes

