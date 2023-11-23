Return-Path: <linux-wireless+bounces-21-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D9A7F690C
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Nov 2023 23:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 817F8281861
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Nov 2023 22:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533723E48B;
	Thu, 23 Nov 2023 22:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="KbOnmNii"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7C910D0
	for <linux-wireless@vger.kernel.org>; Thu, 23 Nov 2023 14:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=i+dvryFmERWiasl+husG8hANXmNn8EXY0WUwLDrFb94=;
	t=1700778751; x=1701988351; b=KbOnmNiiCYePY/saLznv4W6WQ8yPjcltTWzbKeimdsmuhAW
	LRRkSAZEWOBjHP4l2XTvSsmG3YH/Ps7prHnxnpBxrK9JJpptH0SKbXxU7dsC44KcN4z5VVDFEBcoX
	U/FnZ1lnidcmGH3kR5589MmfjZnmecOqvBD8Zt8kXt9DVP02tO2/Cw2JhWSE4+RCH2zqGYAv9xeHB
	wqvOHsku4/2aAGEPRgFI5Bg9ngMfnbVAwlrLr9+dtVOC0DrbK041mBViZ1q0oW6SjfYyAgIujeUv3
	FS7b01aAKU43p+zao6rQoCe2AUPONIeI7yZPhBNkvLdjSyNEreF7wCBNjCG5fqug==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r6IFJ-00000001YOQ-1ZZc
	for linux-wireless@vger.kernel.org;
	Thu, 23 Nov 2023 23:32:29 +0100
Message-ID: <a0a595546f39f72df3bf41cefb5de34b64916fd7.camel@sipsolutions.net>
Subject: Re: [RFC PATCH v2 09/13] wifi: mac80211: simplify non-chanctx
 drivers
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Date: Thu, 23 Nov 2023 23:32:28 +0100
In-Reply-To: <20231123231436.ce4c2648b190.I60d093b2fc81ca1853925a4d0ac3a2337d5baa5b@changeid>
References: <20231123221436.143254-14-johannes@sipsolutions.net>
	 <20231123231436.ce4c2648b190.I60d093b2fc81ca1853925a4d0ac3a2337d5baa5b@changeid>
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

On Thu, 2023-11-23 at 23:14 +0100, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>=20
> There are still surprisingly many non-chanctx drivers, but in
> mac80211 that code is a bit awkward. Simplify this by having
> those drivers assign 'emulated' ops, so that the mac80211 code
> can be more unified between non-chanctx/chanctx drivers. This
> cuts the number of places caring about it by about 15, which
> are scattered across - now they're fewer and no longer in the
> channel context handling.
>=20
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
> v2:
>  - handle drivers that NULL out their chanctx ops (thanks PK!)
> v3:
>  - force reconfig in scan, at least hwsim depends on that to
>    collect survey data
>=20

Sorry, I never posted a v2 before, so both of those changes should've
been under v2.

johannes

