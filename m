Return-Path: <linux-wireless+bounces-19851-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2360FA54503
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 09:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 732491889623
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 08:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A646207675;
	Thu,  6 Mar 2025 08:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="wk8K2XWF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156D61DF24E;
	Thu,  6 Mar 2025 08:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741250231; cv=none; b=S08myfeBq6tP5OYr/WiJob4rYR2X72slF8Hg2vg96nu7UvWjEvSreTyhARr/MBv6aGICCrbHDKP0z2cW61XZjCLRzGh86EPqo4y2S+WkPC9DrC6SDPDWIQ1Gl8kIKmJtLXZ4zWf7CjBvZLZYUWwMVbRttJj/3LakgoMk7ZtHS04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741250231; c=relaxed/simple;
	bh=Ijp/uqr7w1PYskq3jPI6hjykLFdcqE59PKhO5ibO9Mg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kT9exbY+yarq7pOEE+T53R57oUukroltjJ9Wk/uzTa0ds/b4+n5UCkCxIAJSfp/YOiYNKBPo88v2nYmCJYUb9fgrvla5/rp+LXGmIkA0d7y+hgNp2QcbCVWsWTP9JygHMZ7mRpgMrBHe/e2M8vPNi2HNFJmrB6VObztRJ3UT3qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=wk8K2XWF; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Ijp/uqr7w1PYskq3jPI6hjykLFdcqE59PKhO5ibO9Mg=;
	t=1741250230; x=1742459830; b=wk8K2XWFSpNZtblWKZWXViFgz2WDo+4gKX5ufBBXSHJmQ8s
	zvPnuGjnLnLXu6Z/3WDIqIZ1UnD23Rn0WwX5AVroGD3PDbOZ+NMnkKZFyaLep52hOzUT7WElTnI/k
	oi4elOmETS/xxchUkGLoWcD1NLFhCkC3DNB5oIb/xnEn7zr2kgeJMVOyu+JaxrZhFC3ufriAmyZ1u
	tZT6SeAK2fYllYDrExmpyiP9UmEas6Vo5zxnKV51RVa7EzzFSY9qdf40CtHJmE3RcC10I82pZQPhT
	dQA32MpVBAbbvpjtJUsFH93AY/1A1IqQkCpKCbUDqVV0yD67/Pk8wDswX9mP0onA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tq6j3-00000002j6f-1zcs;
	Thu, 06 Mar 2025 09:37:06 +0100
Message-ID: <348c5c7840db255e6cdccb566f7cc3042dd18799.camel@sipsolutions.net>
Subject: Re: [PATCH v2 0/5] wfx: add support for WoWLAN on Silabs WF200
From: Johannes Berg <johannes@sipsolutions.net>
To: =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>, 
	linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>, 
	linux-devel@silabs.com
Date: Thu, 06 Mar 2025 09:37:04 +0100
In-Reply-To: <47066295.fMDQidcC6G@nb0018864>
References: <20250302144731.117409-1-jerome.pouiller@silabs.com>
	 <23857370.6Emhk5qWAg@nb0018864>
	 <98b872e270bf2d03700b39ec5b62f2746eb46e88.camel@sipsolutions.net>
	 <47066295.fMDQidcC6G@nb0018864>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2025-03-06 at 09:35 +0100, J=C3=A9r=C3=B4me Pouiller wrote:
>=20
> I though the missing target tree name was a blocker.
>=20

Ah, no. That's just because it doesn't _always_ manage to apply it. It's
only a blocker if that's the only thing it reported, but here it just
said it was missing but went ahead anyway.

Honestly, I have no idea why all that is, sorry.

johannes

