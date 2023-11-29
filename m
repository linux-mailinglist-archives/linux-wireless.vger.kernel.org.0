Return-Path: <linux-wireless+bounces-189-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2286D7FCF7F
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 07:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53A871C2095C
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 06:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EDF101DB;
	Wed, 29 Nov 2023 06:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="g7e52XAc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B460A170B;
	Tue, 28 Nov 2023 22:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=o+ruwW4g+vXqotGBgvYVAqikIMr9ZibjwJBBiNvt/1o=;
	t=1701241037; x=1702450637; b=g7e52XAcp8k3t9kvrSac43LUO1SRdqmfhXd72w+/xEuTcHk
	pzwfKFwWO0FN0B7iYep1cUzxkAV8nm/sEpC3FX5tjfgPPn5oKr8zWt3VVzH0GiVqO+8ZZtL41jC4x
	d1s5BdS0JuhTy7pVOOskemXDdO/vN8VsFDZxvZXR/0yAhEI7zEcW1kWccZ5X1+U4PSMo0zTByVBya
	0oGWhMloJS3dfwff4+rrn6DUUq0dqv39gU5CRukXazfErw5/mrm45UuCjfkjEEPgUrQWPn47P8vzn
	vulqDmIXftJK3p7dp0VD/m4Cjxpz8UtNZcPTtgI/vyp/Z+WLn4bVB0TY/YMyVDCQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r8EVQ-00000008Y6r-2148;
	Wed, 29 Nov 2023 07:57:08 +0100
Message-ID: <6c7765f13b715e67637438c6dffaa5a369758519.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: sband's null check should precede params
From: Johannes Berg <johannes@sipsolutions.net>
To: Edward Adam Davis <eadavis@qq.com>, 
	syzbot+62d7eef57b09bfebcd84@syzkaller.appspotmail.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
 llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com, 
 netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
  trix@redhat.com
Date: Wed, 29 Nov 2023 07:57:07 +0100
In-Reply-To: <tencent_0CCA1979CFA30DC8A5CF8DDC92365DCE5D07@qq.com>
References: <000000000000efc64705ff8286a1@google.com>
	 <tencent_0CCA1979CFA30DC8A5CF8DDC92365DCE5D07@qq.com>
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

On Wed, 2023-11-29 at 13:48 +0800, Edward Adam Davis wrote:
>=20
> [Analysis]
> When ieee80211_get_link_sband() fails to find a valid sband and first che=
cks=20
> for params in sta_link_apply_parameters(), it will return 0 due to new_li=
nk=20
> being 0, which will lead to an incorrect process after sta_apply_paramete=
rs().
>=20
> [Fix]
> First obtain sband and perform a non null check before checking the param=
s.

Not sure I can even disagree with that analysis, it seems right, but ...

> +	if (!link || !link_sta)
> +		return -EINVAL;
> +
> +	sband =3D ieee80211_get_link_sband(link);
> +	if (!sband)
> +		return -EINVAL;
> +
>  	/*
>  	 * If there are no changes, then accept a link that doesn't exist,
>  	 * unless it's a new link.

There's a comment here which is clearly not true after this change,
since you've already returned for !link_sta?

johannes

