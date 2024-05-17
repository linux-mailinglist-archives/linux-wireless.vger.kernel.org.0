Return-Path: <linux-wireless+bounces-7781-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F00F68C8583
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 13:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CFA71C2311A
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 11:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42793D541;
	Fri, 17 May 2024 11:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="OY57J6Cy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FD83D39B
	for <linux-wireless@vger.kernel.org>; Fri, 17 May 2024 11:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715944960; cv=none; b=tFWPsnWtIEYAwz81/0/bQLp21cWgpOHTbdHx4EM99CxPT1/LNl0WSoESK0hrsPRssw34MQyU6a112zIqqxLXwSRMUj35sdxJGEL9GDqKmWUiMlPuIxmYRRZ5Lyeiyllui3DGlYnwBN1RSDAwXbXbhmZyKfooQVcUF41zgpAQno0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715944960; c=relaxed/simple;
	bh=h+G8DXXFg4cgpZIZxiaSfxT6BbGzCdpGQVw6JN5aAJ8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hOvaAKSYMnmXvLiHu/0DONKp8f6e7T9fDCK0jYzauj+FwnnEvxFNPbzBqIETe/KN6UzWqdiEMI20B4CwfW0Ki97+V/G2B1kQmBClA/YlJ39Bt7NkVB8o4fbcQ1Hx87EW8dRveBVX5vr6t1DGZo5Bie/L4fpx8SWPH0L0yE+F4Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=OY57J6Cy; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=h+G8DXXFg4cgpZIZxiaSfxT6BbGzCdpGQVw6JN5aAJ8=;
	t=1715944958; x=1717154558; b=OY57J6CyAeg+YSCdPqRbRr/SfBN5Y+kC7JILpzJu9KYi8OY
	4GWXb4Xn5PscOzqCC4fRmuh8yPmNQvs/GgAf94wq+5reRWEXCXnKgfVNehg+0zKej1l+08W/5bCZ/
	fT+AprEpp5A5JZxoOiDRJciQO3kCrZDCzAvBqEAEh4B3AD+rKibcxpHe7L08XpyXy61Ufs2dy3SHo
	x5KFj9VSl0ZXndtj9TvVeCNpfm0f+vGTJvsCEPBx+C/7NGydQanUMtrfaYtIRtzIkLjNMyjvGbpu6
	+aqV+PlRLnyhyMx+YuESdgI452n1pIqmf1ZeLCTzTWeQG9d9mmvhHaIdU19mC15Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s7vfW-0000000ApXR-3n3r;
	Fri, 17 May 2024 13:22:35 +0200
Message-ID: <38abf8474852d1f9b890e1a346f750b7b7b7682a.camel@sipsolutions.net>
Subject: Re: iw: alignment issue in print_he_capability() on arm926
From: Johannes Berg <johannes@sipsolutions.net>
To: admin LI <admin@hifiphile.com>, linux-wireless@vger.kernel.org
Date: Fri, 17 May 2024 13:22:33 +0200
In-Reply-To: <CA+GyqeZ976F6Zbcr5oo2_f_ECiy4tqb0vTjtSNtPexO07N-H4A@mail.gmail.com>
References: 
	<CA+GyqeZ976F6Zbcr5oo2_f_ECiy4tqb0vTjtSNtPexO07N-H4A@mail.gmail.com>
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

On Fri, 2024-05-17 at 12:30 +0200, admin LI wrote:
> Hello, I'm using iw 5.16 with Yocto kirkstone 4.0.13, kernel 6.1.55 on
> SAM9G25 cpu.
>=20
> When I execute `iw wlan0 scan` kernel report many Alignment traps, looks =
like:
> Alignment trap: iw (6376) PC=3D0x00461ff8 Instr=3D0xe1f720b2
> Address=3D0x0048e771 FSR 0x001
> Alignment trap: iw (6376) PC=3D0x00461ff8 Instr=3D0xe1f720b2
> Address=3D0x0048e773 FSR 0x001
> Alignment trap: iw (6376) PC=3D0x004631c8 Instr=3D0xe1d420b0
> Address=3D0x0048e771 FSR 0x001
> Alignment trap: iw (6376) PC=3D0x00463190 Instr=3D0xe1d420b0
> Address=3D0x0048e771 FSR 0x001
>=20

Is that kind of thing not fixed up there? Does it even matter?

But I guess if we want to fix it, we'd really want something like
get_unaligned_le*() like in the kernel, not manually memcpy() in all the
code.

johannes

