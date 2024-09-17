Return-Path: <linux-wireless+bounces-12907-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DAB97AD6D
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2024 11:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D93BB1F2212D
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2024 09:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7C253389;
	Tue, 17 Sep 2024 08:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="RpICDkv4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D7E15CD41
	for <linux-wireless@vger.kernel.org>; Tue, 17 Sep 2024 08:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726563593; cv=none; b=arFjqLVymqb+3SefxHiOYhh9LdbVHBoCpTQZr9dfUTQZjSsySO0PsM8J6w7GANGDgY8NS4ZD2BlnXJmM5r1S3ngcjEBARjulYpSS2mKNcD4C0bQOMIjmDdMF5o8H9Zdotd9amXHvA2exj8RIc1p+NutJgwYGD1jRJusFTfc6uwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726563593; c=relaxed/simple;
	bh=FwXjkQzMgoy2ixxoNTzFO7M6vYPhbXXPYvf0jIN4R7s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AJVhVzpER/4UW1+lZVqxcTBl3kLRV7popFVjZoVqRjPOTXPQXPCfnzIbW3OvlnFU7XJS1HtF76iSjm3hmL28dysyw6cMt+4trsGNTFgvXYcNPRmqdSHs/7DJEcBVD5X+C18x2NTHQO52om1B5a5TX6Pm5vMZo+JoN82joQvYuVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=RpICDkv4; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=FwXjkQzMgoy2ixxoNTzFO7M6vYPhbXXPYvf0jIN4R7s=;
	t=1726563592; x=1727773192; b=RpICDkv41OZCfRpfS6iK6jNjTiu+OzgjwwrOpFb5YTptRUE
	cEZJ9DLVAnBMwp8K8oLek8t3ba5xHpwSJ3Y+eKoeiXLexNthRApfFKTmqCHLX6kZ96UiU/iFemaq7
	qkNQkRzau2JnnKX/vNpXYN+Sjm8Uk+10wIdEs3c6OnpoiuUNDQFoEade73QMaz6tmQTUCC1Lq6qP6
	c9dzkQkh/xwezk4TA/dL/T9tLo0c63FXn93uRYEU3QCovY1+gbHwieWEMuI0/959eo5mClbC/qPCk
	EHZPMo/0MNbuEHhY7ffnwtH6ha18Z5c9a+4dKdiGSgQ2uHcKFN4tmQTBeLkXNpYA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sqU3p-0000000E699-2NJl;
	Tue, 17 Sep 2024 10:59:49 +0200
Message-ID: <b628adea24aa4b3ab70092a9f6cc7d5e7f4b981a.camel@sipsolutions.net>
Subject: Re: [RFC 4/6] wifi: mac80211: support per-radio driver start/stop
 calls
From: Johannes Berg <johannes@sipsolutions.net>
To: Felix Fietkau <nbd@nbd.name>
Cc: linux-wireless@vger.kernel.org
Date: Tue, 17 Sep 2024 10:59:48 +0200
In-Reply-To: <6964618A-06A2-4E83-8AA7-B71FDAA282A0@nbd.name>
References: 
	<a2d18db2ad31e1dfe7780b39ad43c5db82e1eb93.camel@sipsolutions.net>
	 <6964618A-06A2-4E83-8AA7-B71FDAA282A0@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2024-08-23 at 13:31 +0200, Felix Fietkau wrote:
>=20
> > On 23. Aug 2024, at 12:17, Johannes Berg <johannes@sipsolutions.net> wr=
ote:
> >=20
> > =EF=BB=BFOn Mon, 2024-08-05 at 21:23 +0200, Felix Fietkau wrote:
> > > Radios are started/stopped based on the vif allowed radios. This allo=
ws
> > > drivers to keep unused radios inactive.
> >=20
> > Similar argument here, I'd think you don't need this with
> > WANT_MONITOR_VIF. Is this really something we want? Why?
>=20
> I want to keep radios shut down when no scan, roc or normal operation can=
 happen on them (based on allowed radios mask).

Makes sense I guess, but do you really need mac80211 helping with that?

You already know which vifs are enabled and which aren't, and you can
also access their radio mask if you want to. Not sure I see the added
value of mac80211 keeping track of it. Worst case iterate the existing
vifs when removing one?

This is only needed/useful when there are multiple "real" devices and
you don't have anything else managing them, so I kind of see this as a
corner case, but perhaps I'm wrong?=20

johannes

