Return-Path: <linux-wireless+bounces-9794-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0947291EA8D
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 23:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A12C1C2111F
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 21:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B673B171657;
	Mon,  1 Jul 2024 21:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="NvhHmpB6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B781F171655
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jul 2024 21:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719871092; cv=none; b=ZTM9W0OvpLR2OQHND/OnQ66kz5q+jZgVmvGWIpSBKlQTL6GFoLUa3colYcflqSeCCrUwaT/VQnygT0V6n3pREpm5NmnUZgfDCDW50Lip/4+BYf830oSsXOv7s/e0lGM31OPCLYR/3RIKbWuvm+16qNAeZWZDfhzqPNBD2jjrORg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719871092; c=relaxed/simple;
	bh=EwikAoVDhRgB+fdrxeRzAT8ct0ZX7dE5/wvcg+oExMU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g4ujo8sE8gT2MYW6lJF2RBj4OOREIe6UJSWcQwUI+ck9eEDM7fCiFk0SstPvi34T4sK3mKw50iOHwg8URDYPFzyh6Fxtr4FrRTLjD+JJrGSUu4sE+QYFaDCOpMZ9fYxabKxSP5Oe3JW1ncASNsAnDhjHE2gAtpdroKgkv5bKFr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=NvhHmpB6; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=EwikAoVDhRgB+fdrxeRzAT8ct0ZX7dE5/wvcg+oExMU=;
	t=1719871089; x=1721080689; b=NvhHmpB6DkX14ZNacdvIcqq+MCz/x/5N9DvuUEufPyq0nKG
	A5ZSReCfp2ciU6mKdqwy/3wNlgCHGte7WxnxFRJrOCUx1JwBroTFg2xMELXWBChCU8jaiW3m0Dplq
	MVdx7+GmPvhSv1Yn2AJ/f2FBIpdrz/T+ZsNbegsa6ntUE4W4l3cd/szca4dyoYUD5oL3Nr0U7XagB
	ptwTUBbwmnSJkCYJJ32iamaO+0NntpWzxJuPxUyHXuhjo/TSYF6TE9veB+I1WEHVnS5I4TlJVAR8m
	+m/vWakaJSDJzALzY1NxyEa/yfBfAdzpAQ5gRXocox9cQeA0grlM7XVlGzBZCj0g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sOP2E-00000003RB0-2Nyb;
	Mon, 01 Jul 2024 23:58:06 +0200
Message-ID: <a95d943d72123ddf4079262003516f29f52b06ad.camel@sipsolutions.net>
Subject: Re: [PATCH] iw: fix formats under MIPS64/PPC
From: Johannes Berg <johannes@sipsolutions.net>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-wireless@vger.kernel.org
Date: Mon, 01 Jul 2024 23:58:05 +0200
In-Reply-To: <CAKxU2N-L+B_DSTA9nsseDgnzCtgOvtSgd6pShEF-MmA=DQCR7A@mail.gmail.com>
References: <20240628223237.16222-1-rosenp@gmail.com>
	 <8f826bf3e6c2a676c4db37fdfd5b10e364abbb51.camel@sipsolutions.net>
	 <CAKxU2N-L+B_DSTA9nsseDgnzCtgOvtSgd6pShEF-MmA=DQCR7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2024-07-01 at 14:28 -0700, Rosen Penev wrote:
> On Mon, Jul 1, 2024 at 3:01=E2=80=AFAM Johannes Berg <johannes@sipsolutio=
ns.net> wrote:
> >=20
> > On Fri, 2024-06-28 at 15:32 -0700, Rosen Penev wrote:
> > > __SANE_USERSPACE_TYPES__ needs to be defined to get consistent 64-bit
> > > type defines and to fix -Wformat warnings.
> > >=20
> >=20
> > How does this even work? Pretty much every file I checked in iw include=
s
> > iw.h _last_ (or close to it), after netlink, nl80211.h etc., so ...?
> > Doesn't really seem like it would have any effect?
> I only tested compilation of iw itself, not of any project that uses it.

Hm? It's iw itself only anyway? But where did you see warnings/errors,
and why did they go away when this shouldn't have really done anything?

johannes
>=20

