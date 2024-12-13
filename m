Return-Path: <linux-wireless+bounces-16381-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 952969F0D43
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 14:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1BC6167FF7
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 13:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113911E0091;
	Fri, 13 Dec 2024 13:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="TCdKp5dG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE68C1DA5F;
	Fri, 13 Dec 2024 13:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734096473; cv=none; b=ZlIWe76imwQW3Hmo7XPz74VxV5q5vMvKmkSeOOWVPnjpENALq35qwLafF5aelDpmPAZbEuwmEfhong/e1zKTVCJAQjeegvs63ZTs6IZQvkF8lQB2ntfZifWxzi4dBqdf4kUXIeqpkZ5L3P+WEX4NyQbhWPrytwLxiCzUm1un3hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734096473; c=relaxed/simple;
	bh=bxt/ucduwPrssRD95ItPQSQOqvnWV7JgVW5NkbSy77E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvgzJgD46dhoMK8juiKbDwi7ton9QBTpgN3lwQmEPhvylHgBnImu2OgBX+MTrROAwVHMdBjo1zrFckgB2EizR7hB8uuwj61kXBsDMzio0lrN2OqAu02onyhEmFUxCD8thB+N9JwFICLVo3R7Tawf7uKOxzIkEG1cXBHFxQNZbvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=TCdKp5dG; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B0D4540E0169;
	Fri, 13 Dec 2024 13:27:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id sGcE60KnN3ec; Fri, 13 Dec 2024 13:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1734096462; bh=fx6NJswxnApctvUDdLiVKEkcBeLJJ6f/OgTP8Pi/0ME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TCdKp5dGfLFekVy98Z5cRjbFBjMfVvYyRYfkhUYQV27uBBXCYYZh9p+mOk9Fgf+Os
	 pQnkema3VHjYt9PUh0meOBj5NrPk/zKO+QDenixpK9n+dz4n1W1+s+KDo+a/POiJM5
	 Jf6qn/XogPW/5jtU4WaIDhZKUdouklEFEDqlqUxQY/zqmsi+ilibsowZBZAyXy4Y1x
	 TpfygtsV0EIon2P3uQJgohoT4cvoEShfdG4TimQLth0mosUPdNeCeUnCPY7vJpG8jp
	 FMDw44tc9UZ8zLBh5SjSjW+tYFB4s0xcTFhxdZaxrRiBX6ofb+4X6HzSOYzqwyuH19
	 3Gkh2PB0uUC+JXk2zhzsze0kIwSidQFUGAMJuPIsUXASeoSmC8/pKQYSSGpe+44W7X
	 wfaRwlYuRha6hXFbAGc3543MSmoNrbjsNXBdfC4dqq55iCvp1sGLVzoHBrZ6ElvUth
	 Xr+52lDoTAkJQ9VOWavMmRSsyh9669yeE7txdySAT/BnY2u4V0QitRMiF/v+BjKPP3
	 KRaaFCcHHir2sRjQSC0fOS2DqMpzcB0re3ld0RlRsARj0Xcy3Re1L5ZPKAiOs62UDt
	 Jv74MNH+taDciFgIldizxt2pc4BNlWyyNgb6b/mcvo5h8L2N4EtjOHDklrGej/mcSh
	 CG5OdhA4dM08z1FXqQoO86yE=
Received: from zn.tnic (p200300ea971f9372329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:9372:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2E54840E015F;
	Fri, 13 Dec 2024 13:27:19 +0000 (UTC)
Date: Fri, 13 Dec 2024 14:27:09 +0100
From: Borislav Petkov <bp@alien8.de>
To: Kalle Valo <kvalo@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>, Yafang Shao <laoar.shao@gmail.com>,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	x86@kernel.org, linux-snps-arc@lists.infradead.org,
	linux-wireless@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, ocfs2-devel@lists.linux.dev,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH 1/7] vsprintf: Add %pTN to print task name
Message-ID: <20241213132709.GAZ1w2LW4LgHi-6XfZ@fat_crate.local>
References: <20241213054610.55843-1-laoar.shao@gmail.com>
 <20241213054610.55843-2-laoar.shao@gmail.com>
 <Z1vq2-V7vB5KhBR9@pathway.suse.cz>
 <87r06crnew.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87r06crnew.fsf@kernel.org>

On Fri, Dec 13, 2024 at 10:35:03AM +0200, Kalle Valo wrote:
> I agree, it makes the code harder to read for someone who is not
> familiar with all the %p magic we have (like me).

+1

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

