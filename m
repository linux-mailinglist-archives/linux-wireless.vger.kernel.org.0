Return-Path: <linux-wireless+bounces-27197-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88ABCB50A74
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 03:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43E1C565FCF
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 01:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1914221714;
	Wed, 10 Sep 2025 01:50:01 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC4414658D;
	Wed, 10 Sep 2025 01:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757469001; cv=none; b=Gd+95ACJvnDaEfciKVpZAegIRkHRtp2UJuY6yE39eO40mL55GpJBYmQkK61B1KfYFma6JMl7n6IyNfnUK37+egzawKckyqC8/OlIR6ltgTsBxF7ehg/tRU85qO1Y52siTRtK++p2LS5tBWxzIxDYptwBcQvklCnZP7nf1CL1DTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757469001; c=relaxed/simple;
	bh=7LVigNguHvHbrA1aN0YPywOsZX96eJBBBrNQX4O0vZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nw85tpwdyqtSxJDbSkOe3zF6cQ3mYWNUu1Og0NYPdnuhOrvLyWoDoAs3+k+fX0Nc59WOIbataiKUpx/kiq43G7/fx7Jvg7gAg11O/iSEMoB7vLFZ3Zl1zOXXgZ3m6hzDqQi5Mmtzepxhw12gjYYvUcI2tmiWPLGOEsyulCoqeEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6bd23d088de811f0b29709d653e92f7d-20250910
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:ce7bef24-cef0-472b-bfb8-1e0db3e4682b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:70633738746ca705e26646221cab4099,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|817|850,TC:nil,Content:-
	10|-8|-5|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6bd23d088de811f0b29709d653e92f7d-20250910
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <tanzheng@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1179794620; Wed, 10 Sep 2025 09:49:42 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id B887516004280;
	Wed, 10 Sep 2025 09:49:42 +0800 (CST)
X-ns-mid: postfix-68C0D936-29667311
Received: from localhost.localdomain (unknown [10.42.20.101])
	by node4.com.cn (NSMail) with ESMTPA id 8825916001A03;
	Wed, 10 Sep 2025 01:49:41 +0000 (UTC)
From: Zheng tan <tanzheng@kylinos.cn>
To: johannes@sipsolutions.net
Cc: arend.vanspriel@broadcom.com,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	tanzheng@kylinos.cn
Subject: Re: [PATCH v3] wifi: cfg80211: Remove the redundant wiphy_dev
Date: Wed, 10 Sep 2025 09:49:40 +0800
Message-Id: <20250910014940.195710-1-tanzheng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2363d0a432d280cc2e374cce6603300868780592.camel@sipsolutions.net>
References: <2363d0a432d280cc2e374cce6603300868780592.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> > > > > > There is no need to call wiphy_dev again.Simplifying the
> > > > > > code makes it more readable.
> > > > > >=20
> > > > > > Signed-off-by: Zheng tan <tanzheng@kylinos.cn>
> > > > > >=20
> > > > >=20
> > > > > The bot complains this doesn't match your From: line, is that
> > > > intentional?
> > > >=20
> > > > Yes, I set it up this way on purpose. Sorry, I don't know=20
> > > > this rule. I'll modify Signed-off-by. Thank you for your comment.
> > >=20
> > > Oh. I wasn't really thinking you _need_ to change it - actually I w=
as
> > > wondering if you _want_ to change it since I thought maybe "Zheng t=
an"
> > > was your preferred spelling, and your email client just used the
> > > localpart (before the @) instead of your name spelled out by accide=
nt.
> > >=20
> > > So either way I'm fine. Let me know what you prefer.
> >=20
> > In that case, perhaps I prefer "Zheng tan".
>=20
> Ideally you could resend with your From: line adjusted, or even an extr=
a
> From: line thrown into the body of the mail, but I suppose I can try to
> adjust the From: line as well on the other mail you sent, assuming I
> remember :)

I will adjust the From line of the patch and resend it. Thank you for you=
r=20
patient reply!

Best regards,
Zheng tan

