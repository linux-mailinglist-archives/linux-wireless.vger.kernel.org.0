Return-Path: <linux-wireless+bounces-28869-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3DFC5239A
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Nov 2025 13:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55D8E188DBAE
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Nov 2025 12:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8025B31AF33;
	Wed, 12 Nov 2025 12:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Iz3dSmV8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BCC3191A5;
	Wed, 12 Nov 2025 12:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762949638; cv=none; b=fjTFH+DLnWFkEGmjoL17admdywvm2NL4rTq9aejctsg8rqZ0YY0FCqJyhMyC3EGN61s0bf9gIq5vFtdv+ZRccWswpWbApgTTTL/w9SqGohOGg61/yEofvCfmrjk2abF7IL5cYdr/wtCmo6ZYnRO8rnR3+7vEIUwRWCyBC3JXbzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762949638; c=relaxed/simple;
	bh=LeZBMdb0VjGDbBq/p3y0Gg3Hhmbrd7oXXF61lD0zekM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CYpTnZkiL+ETeo7FoGqULMwHNb3WaYr/8fpNrByddW55YVGu1tR3TQz/lHstJRd0/S6wlZivyGWI3ub9cRvvzTA9K3HVu2dY8CmdS90XB4nuIUW+v3ST9xf8InkahHn4D4SCMzpS3Ims47GOD5IjbSF1n4asDh89Bu96wN2fST8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Iz3dSmV8; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=LeZBMdb0VjGDbBq/p3y0Gg3Hhmbrd7oXXF61lD0zekM=;
	t=1762949635; x=1764159235; b=Iz3dSmV8mfDi8RiKpnFmCHQDyL/TZ0veXY+bVJgdsQCgbBv
	kA1YoIeLs2BhKzKZAqXsDFZhy6bprVuJCnD8KtBYTBd7gq9U2TIqx8xEL6Sl1Lm8VG19shz3ytQ0r
	zYVr2tAxJKw+IxvbqiFmJXkHn/ZbaRkbPVQBrO05mVfxDXnLTp15fU2SJmL5cLvcN7DuNQ4vAehT1
	BG/xDwuw6khtlrUF77zzq67AMRlG1JVkumBwRuEHGwqPJ818V+dU1mOg10J8MaUMH5YFs6uM2zZ0o
	JSUYWfSuRj1mxpdLnbiIxiI0lKR2XJ5Ao22uVewbL4nfSgW8ZXfvVnj7df2bowAg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vJ9jP-00000001Gma-1CJ3;
	Wed, 12 Nov 2025 13:13:47 +0100
Message-ID: <2083602a6dac97bb87b32d8832e8ac7e33506fbc.camel@sipsolutions.net>
Subject: Re: wifi: mac80211: make n_channels updated absolutely before
 accessing channels[]
From: Johannes Berg <johannes@sipsolutions.net>
To: xu.xin16@zte.com.cn
Cc: kees@kernel.org, concord@gentoo.org, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, qiu.yutan@zte.com.cn
Date: Wed, 12 Nov 2025 13:13:46 +0100
In-Reply-To: <20251112165040828QPfTMyxpU6TF3SvlWuQdq@zte.com.cn>
References: 
	20251112163750463kAkOIyBxvHkYWh9Cgdypb@zte.com.cn,494afbf2ca5b18f230b02b03f122c4d427dd08ee.camel@sipsolutions.net <20251112165040828QPfTMyxpU6TF3SvlWuQdq@zte.com.cn>
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

On Wed, 2025-11-12 at 16:50 +0800, xu.xin16@zte.com.cn wrote:
> > > From: xu xin <xu.xin16@zte.com.cn>
> > >=20
> > > The commit 2663d0462eb3 ("wifi: mac80211: Avoid address calculations =
via out of
> > > bounds array indexing") said that req->n_channels must be set before
> > > req->channels[] can be used. But there&apos;s still the case that req=
.channels
> > > accessing was prior to n_channels++.
> > >=20
> > > This does not fix any visible bug, just making n_channels updated bef=
ore
> > > accessing channels[] absolutely, to avoid potential UBSAN out of inde=
xing
> > > warning.
> >=20
> > I reverted the annotations, so this isn't necessary.
>=20
> Excuse me, what is the annotations you reverted ? Maybe I missed somthing=
.

You missed multiple things, for example the fact that your changes do
nothing.

Please, everyone, don't submit changes when you don't understand _both_
the original code (at least mostly) and your "own" changes.

Otherwise we'll just think you used an LLM to cause us work and never
take you seriously again.

johannes

