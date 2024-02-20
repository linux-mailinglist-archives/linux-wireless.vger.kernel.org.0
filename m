Return-Path: <linux-wireless+bounces-3800-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6295B85B52A
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Feb 2024 09:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EA99285649
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Feb 2024 08:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A2E5D46C;
	Tue, 20 Feb 2024 08:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="yZgfSkvD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCA75D46D
	for <linux-wireless@vger.kernel.org>; Tue, 20 Feb 2024 08:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708417761; cv=none; b=THxR/0Q82Qih0MyG7Xka+X7JHT0MjTMR/ENgma1fUHO7cEbvtRiW0EfHxxJWMRNJYe+BucYizk1DnheyIgBhVZIohCKi4P7V6/JXKxJHuujsQ7aAxUP8VbRzMq4eD6ZwcrSMmktRYo+6/q9oBGEeXQ7iBRoDvDZA1fYkehakJKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708417761; c=relaxed/simple;
	bh=1Z5nW50RCgvyaJjqEQ5nzCoK8QBWqW7eC1y5ojbKHck=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SRVTSGPTxhQF7NUOSqn7piyt7Lxu9iz3G/hSpk7xn7XYOvdHN/IItPo5zXSi8f+jfuW8Jfg+ZAF8lZzlf1/QMcSbYSLKdzRwmvXsD0wMoUT7VBW3NDEa38dGxlDkRsegsa2eAjkW4yIQEkGmdTE1Y9WKwYvwXV+lBn4XgALoGHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=yZgfSkvD; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=yf7nCsydEUajMG+b41i3DePva+5QBND2P8cM4bgDKVs=;
	t=1708417758; x=1709627358; b=yZgfSkvDs5z21BQkUANYuVaFZ1FR60nRGTxmXgdYVAmMUHj
	Hy2LaWecwlZbnplYKf5kGgoGVMgoGmoEuGrKUtuMKWLvQY95kTZ1t3vIq1vIYRZVvvAK5rpHQ6WuU
	AZ4Jl3T2rVgix0pWPM3AelFmMBuLFpZDnQGbc/tkgTAWZzkOw+ycsHBoHGmRJQuYu7f/5sPmkr99V
	c0ZjGcHIDFOlYDbV92Lp8t4Dywp1Y/+hcSAf7ny/8mEaqVETayIsPDskSD00hgVBZgisHH189eYwD
	3NpWv8QQbx1FU5K56V6teLDQx2X5o9q2BFfXVkpYFYtAwe66goTq6sTC6nVWcLiA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rcLV5-00000000lWJ-01N6
	for linux-wireless@vger.kernel.org;
	Tue, 20 Feb 2024 09:29:15 +0100
Message-ID: <a180980bd880a7d89e71ef0d0bb10c232cdf867f.camel@sipsolutions.net>
Subject: Re: [PATCH 3/8] wifi: mac80211:  make associated BSS pointer
 visible to the driver
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Date: Tue, 20 Feb 2024 09:29:14 +0100
In-Reply-To: <25c51905aac00bde0591d169d00b301c608234c5.camel@sipsolutions.net>
References: <20240206145411.3217588-1-miriam.rachel.korenblit@intel.com>
	 <20240206164849.6fe9782b87b4.Ifbffef638f07ca7f5c2b27f40d2cf2942d21de0b@changeid>
	 <25c51905aac00bde0591d169d00b301c608234c5.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2024-02-12 at 14:45 +0100, Johannes Berg wrote:
> On Tue, 2024-02-06 at 16:54 +0200, Miri Korenblit wrote:
> > Some drivers need the data in it, so move it to the link conf,
> > which is exposed to the driver.
>=20
> > + * @bss: the cfg80211 bss descriptor. Valid only for a station, and on=
ly
> > + *	when associated.
> >=20
>=20
> For the record, I'm dropping this patch.
>=20
> Yes, the data is there in the stack, but the cfg80211 BSS contains data
> that is not authenticated (from probe responses etc.) whereas mac80211
> is (hopefully always) operating on data that is authenticated with
> beacon protection.
>=20
> So exposing this to the driver feels fragile - if it actually gets used
> for pretty much anything, it won't necessarily be authenticated data.

Changed my mind again ;-)

The issue ends up being as described above, but there are some other
things that the iwlwifi driver would like to access that are most easily
obtained via this information, not just RSSI. The other thing on our
list now is the BSS load, and we had a patch [1] to parse it in mac80211
and then it's authenticated, but really we don't care much for security
purposes and would like to also have it from probe responses which are
never authenticated.

[1] https://lore.kernel.org/r/20240216135047.b771830d9b12.If5885d651cb01147=
11ee1f6c1cb8fe31a69bf0a7@changeid


So I'll apply this patch with a documentation change to warn the data
contained is not authenticated, and drop the patch [1] linked above
instead. This gives the driver more flexibility, at the expense of
perhaps a slightly greater risk of using it for something it shouldn't
be used for, but the alternatives would put more driver-specific logic
into mac80211, which we don't really want either.

johannes

