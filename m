Return-Path: <linux-wireless+bounces-195-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74ECD7FD0A5
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 09:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A358FB2123F
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 08:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C265011CA5;
	Wed, 29 Nov 2023 08:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="O+D1m/Fr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA096C1;
	Wed, 29 Nov 2023 00:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1701246272; bh=hdeyiux8A4M1rQknIJqlVEGLboCzbZuCG7DVeYADgoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O+D1m/FrU6+yIold5ZL1OZlAih5G1/rS2VPhPOHMThcLDZB+KE9bNDxub65FyDigk
	 Ab53NzecYCR5Tfg8p4IVfH4y3Qsr3LSRAXaJcIa7VqM+ceXQ8kH67a1WTwUowmvfUP
	 XEIDHZXFJSm8PCjW+5R+5fvjas4cBdXeSmwqrxAU=
Received: from pek-lxu-l1.wrs.com ([111.198.228.56])
	by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
	id 49299A87; Wed, 29 Nov 2023 16:18:18 +0800
X-QQ-mid: xmsmtpt1701245898tv0m3u240
Message-ID: <tencent_DE78F66DB82F496F9894B8E826EC8ACE0C0A@qq.com>
X-QQ-XMAILINFO: MQ9y3o0o22Fxyio0o5imDwMO6BRL+oVmUwkdJAYJsAo2ZPmSz1ty4CDS0PDRIV
	 lPj77BDY7p5a6FEfU2qyNuXYmjKj7tOZRWj2YWoizV/tj8XTIQ1olnVW4zegrcN7ltFajfIFl2id
	 opnOK4MaGyhc0IR7zzN92XGnt9hd8gGNtmGWPwLdzEP1g87KuvZ+ImoTY/DacDzSPC83Kb3K+k8m
	 56FVvAS0p60LRD8ywetIem5Sln1uc/7uKZ3Igdmnh80PLzBvuapj60kTB8elMvilVDM+vH7C9XnC
	 tjE5GgcLax81GDI2GBV1LCJZbdqUT6BZYK+cH1UHw2T5AzpX/i2B41t+4GEhpUjZSwvK23wPquiZ
	 XNnRwFJVFPObpT0LhgbLEeUZSieJDcSJA1IFrvOgvyl7glxLswCVDfNd/Isfl+zwH611aXFyD+z1
	 eovVRSxRaKudldvJ92f3utV9hX+8kCUdBMLTnmQ+VUF024dWY29XW7aP6t/C4HaSGKXI2WlhFSvu
	 BQCisWteicJAfiC1ZokYKliNIkShl0qFpPiwgEDZsA1g145EsAqHozQXxd6DGB0shCzjDBcpS9cr
	 McFdSgn1X9hY5m+Z6WVUqyXZmWHysFrPUEmnuDDr1/IvtUKq7VccaTMFyq4tOwjURHuqIgwnZeYb
	 GtRLpm3zUPDgCHdqJZN/kHR9uN3azeqF0wZv1Pe7cMAbEnnCebjldL6szSnLhCBtB3V/J47uNZGy
	 C0wS/pqiYGouZU2cERVKebs0YdYAN1CKVLadFjsiZh1EtQ+wtT7L/JlRX2YpP91+X/Ty8Xhk/aBV
	 8CuIwjHdu+7HRGwXtW+DXL4H5swxPHtKtQAy1plOTBtaegCwz9Nr3bc5EhdyErJTc9d5laM3eFyi
	 wa4NyLG8hDNqPZxNREPwl2dNqApLSgEYdBlu61NdNITENkt5QxDOM6UCCX76v8jqvZoM2RnWu5B7
	 9rOMm0ECvKfHaNR11wz9W/e8TdMWfcpgUhGKdHIgV5xAGIDmqaqcDkBK5NWe/1
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
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
Date: Wed, 29 Nov 2023 16:18:19 +0800
X-OQ-MSGID: <20231129081818.3847626-2-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <6c7765f13b715e67637438c6dffaa5a369758519.camel@sipsolutions.net>
References: <6c7765f13b715e67637438c6dffaa5a369758519.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 29 Nov 2023 07:57:07 +0100, Johannes Berg wrote:
> > [Analysis]
> > When ieee80211_get_link_sband() fails to find a valid sband and first checks
> > for params in sta_link_apply_parameters(), it will return 0 due to new_link
> > being 0, which will lead to an incorrect process after sta_apply_parameters().
> >
> > [Fix]
> > First obtain sband and perform a non null check before checking the params.
> 
> Not sure I can even disagree with that analysis, it seems right, but ...
> 
> > +	if (!link || !link_sta)
> > +		return -EINVAL;
> > +
> > +	sband = ieee80211_get_link_sband(link);
> > +	if (!sband)
> > +		return -EINVAL;
> > +
> >  	/*
> >  	 * If there are no changes, then accept a link that doesn't exist,
> >  	 * unless it's a new link.
> 
> There's a comment here which is clearly not true after this change,
> since you've already returned for !link_sta?
No, after applying my patch, it will return due to !sband.

Edward


