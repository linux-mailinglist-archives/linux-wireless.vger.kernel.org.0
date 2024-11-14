Return-Path: <linux-wireless+bounces-15296-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2F39C8786
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2024 11:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E603D289721
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2024 10:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24481F893E;
	Thu, 14 Nov 2024 10:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Jm2qBYMn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0FE1FA247;
	Thu, 14 Nov 2024 10:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731579542; cv=none; b=Vo+f89riijv6zU9Cs/A4/oD8NG0boHJyz7rd7xjLL2unfC1QA5XUEZPJIsUI2cL7SasDxvWVi3JHRCtWKY/hPETVCT2SrblrnN78adjSrJRHJn2j7U9v0867vVMK3zS6HfPwVVncv73PsM7T2YJd7Sce+KLc4gcKi2UP4a55q2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731579542; c=relaxed/simple;
	bh=RjbxQmoUMvyuuDnTElsRG7JQbkfwHHxLkpG1Mksd7GQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=darYKM3/aV90Oh3vPEEev/lp7SP/nGlmxLG37j0pbihrHICf1Khe3c6NZq4IGf4guUg67j3+VPle5dDLimF+d1ydS5MCb7hxSV/TUi/cnB7Lly5Hk9AQY6+/GvpH20Fo6JDKwgLMgLSe9ApydxGvw7QdOdlyb/zQ7awwjAFnWrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Jm2qBYMn; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=RjbxQmoUMvyuuDnTElsRG7JQbkfwHHxLkpG1Mksd7GQ=;
	t=1731579541; x=1732789141; b=Jm2qBYMngGeHhPq9tD9Dkn0U+mNww09OdRRwawAr9/nH0HH
	rLKHRDWtPOCe4s5/fvlXzxPFTechSRWqeIZK3m76k/l4DTMu22rrYwXuOMe7oD0h19f+oo0GXFq9X
	1kEOpSJjy32yaefSySxJERKweEyYMxBe4FV5+V451R6fbiJ2r258r9SWGVW8veyW71KWVRrOgBKOk
	9UdxlOA8Uq2/moogA58AiPmjvR7y3lZrwp/NaRRB/XyfG5ddm4aaFqcw0ZwM0/kLpOHnOgFIrIpFr
	umzpZqUSoKaUxrJPdToNkSmk/CSieBytT9Ij5Xlf0ClVI8hYuzyw+9rk/zyJ+2cw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tBWwE-00000004h4d-2oLK;
	Thu, 14 Nov 2024 11:18:58 +0100
Message-ID: <35bee1c6146cf261ad6b47f585a5b454ad0763ec.camel@sipsolutions.net>
Subject: Re: [REGRESSION] The iwl4965 driver broke somewhere between 6.10.10
 and 6.11.5 (probably 6.11rc)
From: Johannes Berg <johannes@sipsolutions.net>
To: Linux regressions mailing list <regressions@lists.linux.dev>, Kalle Valo
	 <kvalo@kernel.org>, Alf Marius <post@alfmarius.net>
Cc: Andrey Batyiev <batyiev@gmail.com>, linux-wireless@vger.kernel.org
Date: Thu, 14 Nov 2024 11:18:57 +0100
In-Reply-To: <9fa869ddec6c22c0bb299676e27b7b33d3e3b5d7.camel@sipsolutions.net>
References: <60f752e8-787e-44a8-92ae-48bdfc9b43e7@app.fastmail.com>
	 <87wmhg61yp.fsf@kernel.org>
	 <CAEQQxWx7PXw3O_j1FWn7G+DhUUXt3sEB0qDyA2+udRQ6r28FUA@mail.gmail.com>
	 <4f689121-f2c1-45ec-bd5b-105a770af935@app.fastmail.com>
	 <87ttcauv7x.fsf@kernel.org>
	 <5f64abc6-017f-4283-bf08-dba1aea28e9d@leemhuis.info>
	 <9fa869ddec6c22c0bb299676e27b7b33d3e3b5d7.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-11-14 at 10:52 +0100, Johannes Berg wrote:
> On Thu, 2024-11-14 at 10:24 +0100, Linux regression tracking (Thorsten
> Leemhuis) wrote:
> >=20
> > Sigh.
>=20
> Please. You really should consider adjusting your attitude on all this.=
=C2=A0

Also, btw, you're always the most vocal about this, and pretty much the
only feedback at all.

As a result (at least to me), you're creating a reverse incentive. Since
I'm going to get shouted at all the time _anyway_, why bother putting in
any extra effort some of the time (realistically can't do it all or even
most of the time). Just do the simplest thing possible and throw it into
the tree that'll make it upstream somewhere without any risks (like
here, what if wireless won't get pulled quickly, Jakub had been on
vacation recently and things got delayed, and if you miss then it's a
lot of work, etc.)

johannes

