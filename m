Return-Path: <linux-wireless+bounces-197-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B46C27FD155
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 09:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBA06B21654
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 08:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46359125BB;
	Wed, 29 Nov 2023 08:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="kkgmX/J+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86E0BC;
	Wed, 29 Nov 2023 00:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1701247730; bh=Xk1r4MKViKZ7+K/uenq6FuE6+PsSkXPe5XNBpnfJRBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kkgmX/J+PTZp/WExqwS73Yz2yenr8IWZtGcpa17s8EcOj/b/vKT5X95/USw68gE2V
	 gc/Ju8SGrXdWiOWm14pVzpIS5axq1QlWTgrVnQ5xVocRyv+BthC0GzJrFK0f320b3Y
	 +rQTkTTbmrtLzTrrbmZ7e+AvQAB02kdPb/qEjp94=
Received: from pek-lxu-l1.wrs.com ([111.198.228.56])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id C2D3D61D; Wed, 29 Nov 2023 16:48:45 +0800
X-QQ-mid: xmsmtpt1701247725tk0ncglh8
Message-ID: <tencent_6E9CA7EF46E452C90650899D2ECFEEFE4C06@qq.com>
X-QQ-XMAILINFO: OZZSS56D9fAjWVaB4PHNJb8tsTqNPxKnsmpxg/CWpO1uIz/88+WpUBbId7L5Mf
	 JCB41rIfjxdNfx/YEReganC6bVYF565SBtQaTWRbgHiSfo4g2dpz6OiOCQNO7U3IuN4/YV5r6iwx
	 h/NmRHfIgkxRnJJjooXW5DwDNb1WXenPRVBwo8OvoXT4kl6M21LVslH4cFX4DiOFeXI7F4DwGNfC
	 AAD9Vk+oY7f3Z9p834tHGTMlR5NO+a+77NkETksN7kXVnQL5MfrKb7OVKwohB8e3MflXd+f/+RhL
	 MSQ9TLhSK/p9gjUOZoGXVJu6xUzufamFhU8RfWo4obqZk3nikaFioex2+SZ6ag8Dpzy2SKDmorCL
	 2pq/4Zgz+pRWMjNLwBT2vE2FrWs2qvmR0/IZM3LlKuX4GBsfFE3lsLcT97c17bOsZ2dekThBq8lK
	 1GbcKZJoDIrpfzjwlfLpofh7pd7ehQakDwSPrOQhzfY0Bwa0pQgAH0pIGnO7OK7rIzcYdZlUK7C9
	 4F1Nx3cOhhwmMDMKQpWw1ttUW3I2FYXhsL5oXHumAAnFGLPgGLOpWNgJZBuN/MtapDhwyo5TY4BJ
	 0zGjRK4JcoRUHa77S6jSJiEMkfS+gPYfrYprp/E4WRoUYUg3SQDyB7uulquZFK8aYjTWFA4PiSTS
	 yWq9ndILBFpt4yxOxIqaBflSEUdNpmQsVrCJKurw16gd3KWydZdk61gNINTdUoXGp1n2IoxoxYyM
	 2fKM7j+TQ0VJXixi/ZpTBDkiZolZcsXg1yNKcKoXslnmwkMY9yvhxUeZoIz70OOCxFW4UNOAeiKy
	 WULJxJMhoZKzVF475Sgz/QVBWaxW9qNOzUhKmMyuz3yEDFDWFPzUe2FPNiV9Bncmw0knFQvis3RQ
	 rbVJY9SsbiNcOs8kM09pD6b5RL2K9biCTDNXxt3S9rfZacvCbWN9RHpPZ6OjoaLroE17E8l5zq5z
	 777jVfBaWAHPwWFqSUjw==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: johannes@sipsolutions.net
Cc: davem@davemloft.net,
	eadavis@qq.com,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	llvm@lists.linux.dev,
	nathan@kernel.org,
	ndesaulniers@google.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+62d7eef57b09bfebcd84@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	trix@redhat.com
Subject: Re: [PATCH] wifi: mac80211: sband's null check should precede params
Date: Wed, 29 Nov 2023 16:48:46 +0800
X-OQ-MSGID: <20231129084845.3875870-2-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <56d8b3b9099d3935a7b53e976fa998f06fbfd9a5.camel@sipsolutions.net>
References: <56d8b3b9099d3935a7b53e976fa998f06fbfd9a5.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 29 Nov 2023 09:33:23 +0100, Johannes Berg wrote:
> > > > [Analysis]
> > > > When ieee80211_get_link_sband() fails to find a valid sband and first checks
> > > > for params in sta_link_apply_parameters(), it will return 0 due to new_link
> > > > being 0, which will lead to an incorrect process after sta_apply_parameters().
> > > > 
> > > > [Fix]
> > > > First obtain sband and perform a non null check before checking the params.
> > > 
> > > Not sure I can even disagree with that analysis, it seems right, but ...
> > > 
> > > > +	if (!link || !link_sta)
> > > > +		return -EINVAL;
> > > > +
> > > > +	sband = ieee80211_get_link_sband(link);
> > > > +	if (!sband)
> > > > +		return -EINVAL;
> > > > +
> > > >  	/*
> > > >  	 * If there are no changes, then accept a link that doesn't exist,
> > > >  	 * unless it's a new link.
> > > 
> > > There's a comment here which is clearly not true after this change,
> > > since you've already returned for !link_sta?
> > No, after applying my patch, it will return due to !sband.
> > 
> 
> Right, OK, but the way I read the comment (now) is that it wanted to
> accept it in that case?
> 
> That said, I just threw the patch into our internal testing machinery
> quickly (probably has more MLO tests than upstream hostap for now), and
> it worked just fine ...
> 
> Maybe we should just remove the comment?
Do you mean to delete the comments below?
   3         /*
   2          * If there are no changes, then accept a link that doesn't exist,
   1          * unless it's a new link.
1800          */

Edward


