Return-Path: <linux-wireless+bounces-22059-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12709A9C403
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 11:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63D1D7B71F8
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 09:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFF423C8AA;
	Fri, 25 Apr 2025 09:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="rw/IFCfK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BF523A989
	for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 09:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745573984; cv=none; b=V140w6NwcNuAquqaG48ZaQB8aOmLiii8fYgzF8DhBstvGIlUtUgVU298Z6PxJw4+HOj5qFuFaSNkFQnmNujRHswbIKBDnc090UmfU2lfpmolZ9DdY4rCpdMuEcRCxUddr07E0CXS7AyCxKItHIP5iI0FORNpZ7Rj92zsQAEFGmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745573984; c=relaxed/simple;
	bh=oe6c723ruQyEFarMg+8ww0ir1fey4nLa14FDmxbbOz4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TmYD0UoSOHwIPzt4NAOH3wV1yVVEON0nQ577toghZA6WRKLaZk+6eoiCAV3yoLNyz5EupxuNirDSTqFMpWLzbmnNrTcnPA2qObzVrRqqYYxe9T49ck2fIRQpwC3GPUXmdr4p+MZ+sJUKl2QyB0VD+73uHa2qriCJmBi8L+npFMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=rw/IFCfK; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=oe6c723ruQyEFarMg+8ww0ir1fey4nLa14FDmxbbOz4=;
	t=1745573982; x=1746783582; b=rw/IFCfKeZxfplAhA2EInJVEoD10H5wmWQ9s5ag8rRzbn4Z
	TftKlbTaiWtm23Yr4rQhMa3RCBV0ZQtGtyBxYi9f39ZetSgTzmKMYMPkdCL8Mye4BMnh2GUQpVcHe
	Tqj/d1OeteRrtZXnn1zkwH4PbqnL0aX8pvh4nzMyAUUfTOYwrPb91LiG/jJFMY692VHSK417yKz8C
	fh6F8H8fAqJlaSs6oFswfJgYuQqOO+wgeh9yccg3QY2vhR6S6BtP9wj5Ok+7h+N1ME9aeqc6dQmhb
	GL9XVo3URDKBQwu3wJclbxc6e+6k/IkS0Pd1/f5r/vR2CSo6yzAR4cmp7AwiSUpA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u8FX1-00000001HLS-1oJj;
	Fri, 25 Apr 2025 11:39:39 +0200
Message-ID: <a34be080dd664a01b94d80150cbb2b6e95034eff.camel@sipsolutions.net>
Subject: Re: [PATCH 00/38] wireless: ra6w driver for Renesas IEEE 802.11ax
 devices
From: Johannes Berg <johannes@sipsolutions.net>
To: Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>, 
	linux-wireless@vger.kernel.org
Cc: Sergiy Petrov <sergiy.petrov.ue@bp.renesas.com>, Viktor Barna
	 <viktor.barna.rj@bp.renesas.com>, Gal Gur <gal.gur.jx@renesas.com>
Date: Fri, 25 Apr 2025 11:39:38 +0200
In-Reply-To: <20250417135236.52410-1-oleksandr.savchenko.dn@bp.renesas.com>
References: <20250417135236.52410-1-oleksandr.savchenko.dn@bp.renesas.com>
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

Hi!

On Thu, 2025-04-17 at 16:51 +0300, Alexander Savchenko wrote:
> Renesas Electronics Corporation publishes to the opensource new
> wireless driver for an own 802.11 chipset family - RA6Wx.

I guess I'll ask the same questions I just asked the other recent new
driver submission:

https://lore.kernel.org/linux-wireless/45b74f9f0831294e783a019cd6a1437fdad4=
eb6a.camel@sipsolutions.net/


You're not adding a MAINTAINERS entry, what are your plans to actually
support this?

Also, how much do you actually plan on being part of the community?
Reviewing others' code, etc.?

See also
https://lore.kernel.org/linux-wireless/21896d2788b8bc6c7fcb534cd43e75671a57=
f494.camel@sipsolutions.net/

> (including the firmware binaries).

Those should probably go to linux-firmware.git.

> The RFC is divided into separate patches on a per-file basis to simplify
> the review process.

The bot reported some issues anyway:
https://patchwork.kernel.org/project/linux-wireless/patch/20250417135236.52=
410-39-oleksandr.savchenko.dn@bp.renesas.com/
FYI.


So dunno what to do with this - I'm not going to review this. I suggest
you build some street cred first, review other patches, show that you're
around and care about the infrastructure you're building on.

johannes

