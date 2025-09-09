Return-Path: <linux-wireless+bounces-27115-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D6DB49E8E
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 03:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4C4B1899479
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 01:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2CD223DE7;
	Tue,  9 Sep 2025 01:14:56 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10DB22172C;
	Tue,  9 Sep 2025 01:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757380496; cv=none; b=fEbtKYJJAbTFkJ3BOG0fWX4HAJrTj225hqMCPzUAgv9J+QkUa1MZ6vHfDkFudh9zjPbnchUHWgzANJt7TB1QZgB2z2K2wTMqFhnxyFCWxYLfOYk7Rdf7CLPuCgNoXFEpfweOrUS41i0i5aje0F7y/6fx8NGgY/6+ljneRjEzBko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757380496; c=relaxed/simple;
	bh=P7t7e32RzBKEq9KxafKzbyRK4AXadMHiBNxXCMZ6t7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J75KtAyYaR9kLOq0azRhZiSydLtOe8Oa6lj4g+C1zKy61coNb8w29ifKETNlfyqR3BJWarYmGxJ7imyMAnIUhkO29xyo7yc3OdwWv/pCVxIX3ZaD3BgZHVOIlSqMXZx9r4xMJ9Xaw/LXIuLv47kykSXVfFeZxsifTZrZGld3y2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 610a23828d1a11f0b29709d653e92f7d-20250909
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:a7c5afa2-14ed-478c-8b36-4fdf55554cc8,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:3edc3000533b1aed627b5c62408e3432,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|817|850,TC:nil,Content:-
	10|-8|-5|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 610a23828d1a11f0b29709d653e92f7d-20250909
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <tanzheng@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1367562291; Tue, 09 Sep 2025 09:14:48 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 353A3160042A1;
	Tue,  9 Sep 2025 09:14:48 +0800 (CST)
X-ns-mid: postfix-68BF7F87-338595101
Received: from localhost.localdomain (unknown [10.42.20.101])
	by node4.com.cn (NSMail) with ESMTPA id D46301600429B;
	Tue,  9 Sep 2025 01:14:46 +0000 (UTC)
From: tanzheng <tanzheng@kylinos.cn>
To: johannes@sipsolutions.net
Cc: arend.vanspriel@broadcom.com,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	tanzheng@kylinos.cn
Subject: Re: [PATCH v3] wifi: cfg80211: Remove the redundant wiphy_dev
Date: Tue,  9 Sep 2025 09:14:44 +0800
Message-Id: <20250909011444.86314-1-tanzheng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <67bca659b2e5d3f1625d6d92c9652618f29a6195.camel@sipsolutions.net>
References: <67bca659b2e5d3f1625d6d92c9652618f29a6195.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> > > > There is no need to call wiphy_dev again.Simplifying the
> > > > code makes it more readable.
> > > >=20
> > > > Signed-off-by: Zheng tan <tanzheng@kylinos.cn>
> > > >=20
> > >=20
> > > The bot complains this doesn't match your From: line, is that
> > intentional?
> >=20
> > Yes, I set it up this way on purpose. Sorry, I don't know=20
> > this rule. I'll modify Signed-off-by. Thank you for your comment.
>
> Oh. I wasn't really thinking you _need_ to change it - actually I was
> wondering if you _want_ to change it since I thought maybe "Zheng tan"
> was your preferred spelling, and your email client just used the
> localpart (before the @) instead of your name spelled out by accident.
>=20
> So either way I'm fine. Let me know what you prefer.

In that case, perhaps I prefer "Zheng tan".

Best regards,
Zheng tan

