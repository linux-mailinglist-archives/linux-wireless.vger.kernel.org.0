Return-Path: <linux-wireless+bounces-5492-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1BE8908A5
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 19:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78DFC1F25522
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 18:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877E81311B5;
	Thu, 28 Mar 2024 18:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="VKktKG2Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18593BBDC;
	Thu, 28 Mar 2024 18:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711652020; cv=none; b=VOz+Pf0pRHBLKHAzLfXa9lS+72gSQHeimLfG/HapeW6DqFGqLRnSjAz7fLHOPjLtXYrqEjjdb+EFNMSLeVbr3deZ9O5QGXxooh5LTxvXMMYTeEXG0LCmRUbQD78/ZWIetpV4qNStD/GOG/bMdqEjjuftWNsxdj5Ob3UqYLwLVGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711652020; c=relaxed/simple;
	bh=eX35r6bRbE8OJxYRuvGCVHaFTLI09zUq1rUz5j7QL/U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qPswCws6VzQ0sEHrz9KbhkevPcTsI6avG5qC85F8zpMc09FYxAZvEtBmcDpr4y71P4NPt8k2KCnqUarStxYBWn8me3miIwqEVDPp/m8FwSfeagFvGhiHvHM9AtShVan+65FCPfTM6Jh/zYs05MuWvmNBe4PMLoShRGtzZf9hC+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=VKktKG2Q; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=OTcux6tsV0p/3xqWxMopt0TVCxlgxKArOoPe3sFFjw8=;
	t=1711652019; x=1712861619; b=VKktKG2QwdjjzjaxgBiLFXJushK2pylk/qAX1fffcu0EU78
	KQeQZOXtwSG/yEPiAKqNjklQgOAVTgihUND69pxFDOiYSMEh3YDK5LnmthgofwhQc97iQUiJtvEUK
	4Q+Pjs+J0E33x/Lw6P8gHWBC17W2ATrLIHh8E/FcjjcZsSpM3/ThAzMVsxGuKRgoNVBUl/1pUsiK8
	DRzZVuuwtnW2RDjQds1wr1YpZmYqIXmMK4E97xB/HQ/kUqPTXotUAUrymxGkv1JMPlE16GJBEVHoE
	u6Quk07yd+jIr1ViPLtBp+FC1Qi2azrNvOFTai5BmBLqBT7uTDmQJZt3U15dn/gQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rpusY-00000001F0q-1luv;
	Thu, 28 Mar 2024 19:53:34 +0100
Message-ID: <485ca445f0f0c47179a338df2538e74d520627ad.camel@sipsolutions.net>
Subject: Re: [PATCH 02/13] wifi: nl80211: send underlying multi-hardware
 channel capabilities to user space
From: Johannes Berg <johannes@sipsolutions.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>, 
	ath12k@lists.infradead.org, linux-wireless@vger.kernel.org, Vasanthakumar
	Thiagarajan <quic_vthiagar@quicinc.com>, netdev@vger.kernel.org
Date: Thu, 28 Mar 2024 19:53:33 +0100
In-Reply-To: <20240328114903.1d0c8af9@kernel.org>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
	 <20240328072916.1164195-3-quic_periyasa@quicinc.com>
	 <6d92d0ba4a8764cd91cc20c4bd35613bcc41dfcd.camel@sipsolutions.net>
	 <9d5c2f9f-19b5-af4d-8018-1eb97fac10d6@quicinc.com>
	 <9d0f309da45ae657cd2ce0bc11a93d66e856ef64.camel@sipsolutions.net>
	 <20240328114903.1d0c8af9@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-03-28 at 11:49 -0700, Jakub Kicinski wrote:
> > So in that sense, I prefer that, but I'm truly not sure how the (hand-
> > written) userspace code would deal with that.
>=20
> I think the best way today would be two walks:
>=20
> 	for_each_attr() {
> 		switch (type):
> 		case THE_A_ARRAY_1:
> 			cnt1++;
> 			break;
> 		case THE_A_ARRAY_2:
> 			cnt2++;
> 			break;
> 	}
>=20
> 	if (cnt1)
> 		array_1 =3D calloc();
> 	cnt1 =3D 0; /* we'll use it as index in second loop */
> 	if (cnt2)
> 		array_2 =3D calloc();
> 	cnt2 =3D 0;
>=20
> 	for_each_attr() {
> 		/* [ normal parsing, populating array_1[cnt1++] etc. ] */
> 	}

Yeah, that makes sense.

I'm not sure we even need the calloc() all the time, depends what we're
doing with it, of course.

> Compared to "indexed array" the only practical difference I think is
> the fact that all attrs are walked. I think you have to count them
> either way before parsing.

Right, generally the pattern would be something like

nla_for_each_nested(...)
	n++;

// alloc etc.

idx =3D 0;
nla_for_each_nested(...)
	array[idx++] =3D whatever(attr);

or something like that.

So I guess the only thing that changes really is that this now becomes

nla_for_each(...)
	if (type !=3D DESIRED)
		continue;

vs.

nla_for_each_nested(...)


I suppose we could even define a

nla_for_each_type(..., type)

for that.

> I was wondering at some point whether we should require that all
> multi-attr attributes are grouped together. Or add an explicit "count"
> attribute. But couldn't convince myself that such extra rules will
> pay off sufficiently with perf and/or ease of use...

That doesn't seem likely, after all, you'll definitely want to double-
check all that ... Personally, unless you have something super perf
critical, I definitely prefer _not_ having a count like that in the API
because it encourages unsafe code that doesn't do the necessary bounds
checks and then crashes ...

johannes

