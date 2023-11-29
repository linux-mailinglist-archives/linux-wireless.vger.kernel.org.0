Return-Path: <linux-wireless+bounces-196-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 274B17FD0ED
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 09:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5870B1C20B61
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 08:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBDF79C3;
	Wed, 29 Nov 2023 08:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="B6n9/g6I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5102019B0;
	Wed, 29 Nov 2023 00:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=iL44Hr2Utbt8Rb40hYFfR3Yl3GOU2Y+nYu/SSloZ/X0=;
	t=1701246814; x=1702456414; b=B6n9/g6ITd6f4HA4PHYrxMnsj2Jr5FKm/W9Cex+mkmirzZ6
	uZl0WTaT89gHVqDfVVo/byLg2puPHaSGr793dffsGjLjYBakFj7KH9T93ptI1EH56KVrQgFlLK6wq
	wmGi3QAThBm5SngEVMB1HZ1+gVa5VnZKAQsWxZtj6MVwVLptm1c8nT9Qpd+v6cp3FL50UGl1rS7LH
	B7rYzsXfjXYt1ZuhCuIkebZxFf2+waQSSbCCFyQnVBEuVnVBTvH5v3d4vq1PP938eiU7Gji5/Jz1H
	sBrpKW0xu2EdKeeF+xzqe1jVYRgvFLV9T93FDiEfl9+a6aGUXB2WPi28w5ZyICAQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r8G0b-00000008abj-0RXH;
	Wed, 29 Nov 2023 09:33:25 +0100
Message-ID: <56d8b3b9099d3935a7b53e976fa998f06fbfd9a5.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: sband's null check should precede params
From: Johannes Berg <johannes@sipsolutions.net>
To: Edward Adam Davis <eadavis@qq.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, 
	syzbot+62d7eef57b09bfebcd84@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com, trix@redhat.com
Date: Wed, 29 Nov 2023 09:33:23 +0100
In-Reply-To: <tencent_DE78F66DB82F496F9894B8E826EC8ACE0C0A@qq.com>
References: 
	<6c7765f13b715e67637438c6dffaa5a369758519.camel@sipsolutions.net>
	 <tencent_DE78F66DB82F496F9894B8E826EC8ACE0C0A@qq.com>
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

On Wed, 2023-11-29 at 16:18 +0800, Edward Adam Davis wrote:
> On Wed, 29 Nov 2023 07:57:07 +0100, Johannes Berg wrote:
> > > [Analysis]
> > > When ieee80211_get_link_sband() fails to find a valid sband and first=
 checks
> > > for params in sta_link_apply_parameters(), it will return 0 due to ne=
w_link
> > > being 0, which will lead to an incorrect process after sta_apply_para=
meters().
> > >=20
> > > [Fix]
> > > First obtain sband and perform a non null check before checking the p=
arams.
> >=20
> > Not sure I can even disagree with that analysis, it seems right, but ..=
.
> >=20
> > > +	if (!link || !link_sta)
> > > +		return -EINVAL;
> > > +
> > > +	sband =3D ieee80211_get_link_sband(link);
> > > +	if (!sband)
> > > +		return -EINVAL;
> > > +
> > >  	/*
> > >  	 * If there are no changes, then accept a link that doesn't exist,
> > >  	 * unless it's a new link.
> >=20
> > There's a comment here which is clearly not true after this change,
> > since you've already returned for !link_sta?
> No, after applying my patch, it will return due to !sband.
>=20

Right, OK, but the way I read the comment (now) is that it wanted to
accept it in that case?

That said, I just threw the patch into our internal testing machinery
quickly (probably has more MLO tests than upstream hostap for now), and
it worked just fine ...

Maybe we should just remove the comment?

johannes

