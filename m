Return-Path: <linux-wireless+bounces-30740-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 88399D1863E
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 12:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8C8DE306B84A
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 11:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0356349B02;
	Tue, 13 Jan 2026 11:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="uURmhcIa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A727296BC5;
	Tue, 13 Jan 2026 11:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768302342; cv=none; b=Qeaa0PzCQxAX4H4cWZlwyiKxvpztihz2IK9E+ZjxDurNZdzsrj0vwZmbdbbL8jyWDpXjm9KlVrw4UTDbzLCyFnkYwwAUTcKZ1vyKpFL1GjMuF5QeBp5hxSD8yy/wbVLd1nKerBMkq7Vjegp59qzqvl5p4f9WJCj7cG5sgWxCgeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768302342; c=relaxed/simple;
	bh=CzjdWSiaEsZbo6KTHjYNSxL+ISojl6DULDL7gFMMLWY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S6wDT/tcECWDbZTKfDcPTbHABQ2OZGp+0xv5l0IRLLM3o4AUMk7xm+b/CJwE4j61iwXyznirjsVxrsIp0D/gzQ5Z5Xba+7HfFKzS/ST5BKSMPGw8yXj34dStF/HGmkZLQfHKFVP8Iq/EHkuWTDSbb8/ix9iZa0rVgm6LjVUT6fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=uURmhcIa; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=gXYb/LxBq8s1hNblmNQTz4msl7CLCdfEmYzUVwYx2eI=;
	t=1768302341; x=1769511941; b=uURmhcIahkfA7jg9v+bW57pnHlL1VXcWixZvKATPQmelCBa
	d3zxVaTk02epCnNpv0+AYeMEydGuXslirTsLpVo9R7mPglmJZpGPOdSrtWielAqxd3wp291ZFoMnM
	ArgLnwqNk+VgGjQRb26DkPO7zaES6P8+FuKHLqXQM2iFYXjbJImknoa48t01FR42xu2PpS8S/mV/r
	BsJg4QCg3SYF5mfrsXJQZc7155Gc2nenRobPHA+kRuQUAFUt6+V9YsTmV0Kf+4qp76vA13C8Ntwrm
	Er9ZWO6INhm9DM3PDsQBkOyi2JRPMQC1YSP34bTq6ekrB/L7NLkKIUYrrla7M+3g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vfcDM-0000000AjIc-46Rt;
	Tue, 13 Jan 2026 12:05:33 +0100
Message-ID: <2f4c22558d20b42615adde772551c1bfb346da47.camel@sipsolutions.net>
Subject: Re: [PATCH 0/3] replace system_unbound_wq, add WQ_PERCPU to
 alloc_workqueue
From: Johannes Berg <johannes@sipsolutions.net>
To: Marco Crivellari <marco.crivellari@suse.com>, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
 Frederic Weisbecker
	 <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Michal Hocko <mhocko@suse.com>
Date: Tue, 13 Jan 2026 12:05:32 +0100
In-Reply-To: <CAAofZF5yenY8Q92taaJW2-=kenDVuc6ABEtbVT5+yzM_pBVZsw@mail.gmail.com> (sfid-20260113_112857_683696_3BB5BCB5)
References: <20251113162032.394804-1-marco.crivellari@suse.com>
	 <CAAofZF5yenY8Q92taaJW2-=kenDVuc6ABEtbVT5+yzM_pBVZsw@mail.gmail.com>
	 (sfid-20260113_112857_683696_3BB5BCB5)
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

On Tue, 2026-01-13 at 11:28 +0100, Marco Crivellari wrote:
> On Thu, Nov 13, 2025 at 5:20=E2=80=AFPM Marco Crivellari
> <marco.crivellari@suse.com> wrote:
> > [...]
> > Marco Crivellari (3):
> >   ath6kl: add WQ_PERCPU to alloc_workqueue users
> >   cw1200: add WQ_PERCPU to alloc_workqueue users
> >   wifi: replace use of system_unbound_wq with system_dfl_wq
> >=20
> >  drivers/net/wireless/ath/ath6kl/usb.c | 2 +-
> >  drivers/net/wireless/st/cw1200/bh.c   | 5 +++--
> >  net/wireless/core.c                   | 4 ++--
> >  net/wireless/sysfs.c                  | 2 +-
> >  4 files changed, 7 insertions(+), 6 deletions(-)
>=20
> Gentle ping.

I have none of these pending now - if I didn't accept them then they're
lost. I did try to apply another similar one yesterday but it was
already there in a slightly different format, so maybe things have
gotten out of sync?

johannes

