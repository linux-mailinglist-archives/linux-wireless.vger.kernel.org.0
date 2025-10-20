Return-Path: <linux-wireless+bounces-28105-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C626BF1CFC
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Oct 2025 16:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 93C524E8C29
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Oct 2025 14:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D684320A39;
	Mon, 20 Oct 2025 14:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="C97mkGAF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D389831DDB7;
	Mon, 20 Oct 2025 14:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760970079; cv=none; b=tWn2ipYz3HqnYEacYSI91rT+4T6IBKMvFWQj6LhfmVNqTaxJm2EdTvDkLBnLLlCceSR4eqUjEoPFcchBz625xXziRLP5kO5nw4Jw9X4YDz3qIQqZRbngqvsw7UGjozTVrW2zK3AAQEB4SNUDGSdVTwowuITyO9TsA+nhtoL4bxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760970079; c=relaxed/simple;
	bh=7B3C3nnXc1OYN5rMpBuyWcmbrYLyyipMMNT5GUWjNoo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ie09QDZMwekWvsJ/bOHqPhOm8TVvozfCeXBeonvPtbKwjdyl9OiybCJOXm32aKjp1b1+3CX65J1eCFaXbcQQtEEi/t0k15frwTgkqlsQ0US2GSSX7gX0QBHNVXQEmAPBPElrDT+vlNQj+smXkhKwXhDsqUzwP0eHdL9VQUu9zeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=C97mkGAF; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=4heB+yTWQNHU5Z8HhOLrN88HJUxtyiYNTtlusoiS6N4=;
	t=1760970077; x=1762179677; b=C97mkGAFSXJpO+NJPhO6QeG4k/L2tI+LY7eAkYg7DpIkCZU
	Hrx34Cm/e79co5PjD1OauDWmcYOw9/y9TGYSowqK8S2sj+r1vtFmdC2QERTjuKLuFfj/2ws1k98gC
	BA8PuXVDaH+RZvR13iTeXq68MvC0fdWpP2c9X3Vtta2DPnF3f1emPsla5uMqpFJXM/MCd3GKHM4aP
	ugR3toQgRQBMndl8PKxdXM0chzQy3uots0P5tapKS/6sN7Vmb8o3Xk+gF3y9SPf8bFoXm6uBvhzGl
	SwPd7e0yyHi9i1/dChg0y4hJfADI5AQalHZHF/3LEIo059PZV6hS1Af9oBtc//hA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vAql9-000000094By-16LY;
	Mon, 20 Oct 2025 16:21:15 +0200
Message-ID: <7c8363c38c4352181ebde6b27b6d8fe69c60429f.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] wifi: WQ_PERCPU added to alloc_workqueue users
From: Johannes Berg <johannes@sipsolutions.net>
To: Marco Crivellari <marco.crivellari@suse.com>, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
 Frederic Weisbecker
	 <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Michal Hocko <mhocko@suse.com>
Date: Mon, 20 Oct 2025 16:21:14 +0200
In-Reply-To: <20250926083841.74621-3-marco.crivellari@suse.com> (sfid-20250926_103858_017981_41C79A44)
References: <20250926083841.74621-1-marco.crivellari@suse.com>
	 <20250926083841.74621-3-marco.crivellari@suse.com>
	 (sfid-20250926_103858_017981_41C79A44)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

So I don't know if I really need to tell you this, but generally the
subject should be _imperative_, not describing what you did after the
fact (i.e. "add WQ_PERCPU to ..." rather than "added ...")

> All existing users have been updated accordingly.

Surely this is not _all_ existing users? :)

> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
> ---
>  drivers/net/wireless/ath/ath6kl/usb.c         | 2 +-
>  drivers/net/wireless/quantenna/qtnfmac/core.c | 3 ++-
>  drivers/net/wireless/realtek/rtlwifi/base.c   | 2 +-
>  drivers/net/wireless/realtek/rtw88/usb.c      | 3 ++-
>  drivers/net/wireless/silabs/wfx/main.c        | 2 +-
>  drivers/net/wireless/st/cw1200/bh.c           | 4 ++--

These have different maintainers, please split up accordingly.

>  6 files changed, 9 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/net/wireless/ath/ath6kl/usb.c b/drivers/net/wireless=
/ath/ath6kl/usb.c
> index 38bb501fc553..bfb21725d779 100644
> --- a/drivers/net/wireless/ath/ath6kl/usb.c
> +++ b/drivers/net/wireless/ath/ath6kl/usb.c
> @@ -637,7 +637,7 @@ static struct ath6kl_usb *ath6kl_usb_create(struct us=
b_interface *interface)
>  	ar_usb =3D kzalloc(sizeof(struct ath6kl_usb), GFP_KERNEL);
>  	if (ar_usb =3D=3D NULL)
>  		return NULL;
> -	ar_usb->wq =3D alloc_workqueue("ath6kl_wq", 0, 0);
> +	ar_usb->wq =3D alloc_workqueue("ath6kl_wq", WQ_PERCPU, 0);
>  	if (!ar_usb->wq) {
>  		kfree(ar_usb);

I'd also think that WQ_PERCPU doesn't actually make sense for any of
these instances, but for those that still have an active maintainer I'll
defer to them, of course.


(and patch 1 should be prefixed with "wifi: cfg80211:" I'd think)

johannes

