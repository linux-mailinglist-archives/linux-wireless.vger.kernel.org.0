Return-Path: <linux-wireless+bounces-29793-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01482CC1B2D
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 10:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACD5F300DC9C
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 09:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009081494A8;
	Tue, 16 Dec 2025 09:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="GFr4RVnh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B80E2E413
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 09:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765876378; cv=none; b=KOkMLiGB7Cayw1/9VWYf2IZbhEuwOTXH9B8GBKbiNlzous39RDhqUnFuKxMj0cNZ8v9/uZat26xpxK0sM86u3ldvB+jbO7Td4AIn2L/9CPhlZtN8KyRMBXGj/xuwclQCSDz8XRyN3nuRTS6ngS6k7Jhs0Ga9YqW5J8fuCERHI9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765876378; c=relaxed/simple;
	bh=gFXxtL/PED1rVt0pppqghWHszbrprJ4tbcw7pCZi2e4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dBE9m8abAQRpAY5rA8dtofHqPLUd7kWX+Jg62Kfqwgzt91C1QksXstbaoVC3PqMptxVqCnHE5Snls10k27EtYQxkc/WvA2mzBLPKJ8RyOQKMsSaWUVqm8LyxJdTMOCe4jwbEWq1AWfcqTMOIUEkIMxnRr/X9AEU8IclyoQRvTnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=GFr4RVnh; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=gFXxtL/PED1rVt0pppqghWHszbrprJ4tbcw7pCZi2e4=;
	t=1765876377; x=1767085977; b=GFr4RVnhh5wOYZIKyb6M0UYUsOVipB07LZ4wzQqVlKvrU62
	l13pzSrmJIMgKXBWuSCgiLRnZwNwg8wBzJZDvSYoH8NxXzFwGXYiMmNvyXf7WFLT0jBEE7iOsMBPp
	KYzFi2ZAalgxuuJIehHMqtTUbBzQ0FKdUX30uqa2f28LDSJLqXn/MkqIINeplOVsNjfNrcXH325hU
	RUQ8GqRt7tAhAK2lpU1rWkaE9PyB/5MW/sSAgrYdOIOlFqmvQHtzUKhlBOY86SYgM+BwnMNVagvah
	qdxw+hr8YDx4ssImthCKaPToZX+teuNcinvtxiRGdRVUUjohjnNI4WNoQwxlh7Fg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vVR6z-0000000AEYg-2BZy;
	Tue, 16 Dec 2025 10:12:53 +0100
Message-ID: <feb431cdbe7581e4e961f2033606bb6fe4d90199.camel@sipsolutions.net>
Subject: Re: [PATCH RFC wireless-next 00/13] wifi: ieee80211/cfg80211: Add
 UHR (802.11bn) Capability and Operation support
From: Johannes Berg <johannes@sipsolutions.net>
To: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
Date: Tue, 16 Dec 2025 10:12:52 +0100
In-Reply-To: <07cab823d7695b20aa7ddb1b3698e5eb88ff2c9c.camel@sipsolutions.net>
References: 
	<20251216062656.1738022-1-karthikeyan.kathirvel@oss.qualcomm.com>
	 <07cab823d7695b20aa7ddb1b3698e5eb88ff2c9c.camel@sipsolutions.net>
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

On Tue, 2025-12-16 at 10:04 +0100, Johannes Berg wrote:
> On Tue, 2025-12-16 at 11:56 +0530, Karthikeyan Kathirvel wrote:
> > This series covers support for UHR capability and operation (11bn)
> > advertisement in AP and STA mode. The objective here is to give an
> > idea of basic changes needed for UHR in cfg80211/nl80211/mac80211.
>=20
> Huh. I never posted my version, sorry about that! I'll see if I can do
> that soon so we can compare notes, but I'll also go over yours quickly.

For what you have, mine was pretty similar, not all the naming
(obviously), and you also have a few more definitions for DBE etc. that
I didn't add since some were still broken.

I also had the rate calculation and more ELR stuff, IIRC.

Anyway, I'll post it soon and we can see that we arrive at a good
combination.

johannes

