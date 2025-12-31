Return-Path: <linux-wireless+bounces-30202-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C019CEB044
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 02:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A66E43018F73
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 01:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A908E1A9FBC;
	Wed, 31 Dec 2025 01:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TDaAT+/r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3A2189906;
	Wed, 31 Dec 2025 01:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767146247; cv=none; b=ryf2X/vgBdwKpB/3r1BHyWKM63nY8la0ew0tLJS0fNXFmjrXSbxVpOD+2PWHs9pdg/Lu1g9OBaz2VBvyn69pNPoXgUIojBLsbfKyeU3V0EFxL2d0gkoM7m/sNbRLfvisSdL0Hwr0vBBL/oVZbAIGBUP1TAYGIVaaGXwCaMQ6UQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767146247; c=relaxed/simple;
	bh=BEzGWJOVbkdOfvP+jxM8kRiE+88PF5GTUjfJy2MLec4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCo+Z5SvcbTIGlNwXoM4QH3ZFhGn82i4vaB40UmJ13MJ3zAStk4MPz5oxlczVYrqwRpnpFfMQ+f+sT0gbJ9UbabDzKtThJ5MFozdbR7wTgQveRbk87GzPLOioWrmjrQV3JIVrslydBy6ngSR/vXGm9xLbociRGBaJw7va+0+qek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TDaAT+/r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71115C116C6;
	Wed, 31 Dec 2025 01:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767146246;
	bh=BEzGWJOVbkdOfvP+jxM8kRiE+88PF5GTUjfJy2MLec4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TDaAT+/rZ5rJby0gP47mwGNIqBGfNAGp8InD/a+DoxM+Qbsl3nyBw0CUZXyM+fL01
	 XvaXV0vJs9cnDRtgexhJe2okyTMGhTKI/PCVqW8c7NxiBmCffPqCieyHwGks9yqCbF
	 MmW5nsLh6+P8TToE0duTYa02+4C65NOJ6Jy75gbzaltzbg0ZT+rXOpcXUG/UDm2ZM7
	 66tSeknHYczlniNcFMFZUoH2XgbNWL1oyihdm636S819jYCPeI1uZ5zQcK7IlS9xzM
	 GtDgAuD5+SRTSwDal7uylPAW1Fuey0gF4SEOK6L5w6pQ24FguVvNlUMxA/MEjBOjjO
	 Dm47SXeT3l9Cw==
Date: Tue, 30 Dec 2025 17:57:12 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Matthew Schwartz <matthew.schwartz@linux.dev>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	Mario Limonciello <superm1@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>, quan.zhou@mediatek.com,
	Felix Fietkau <nbd@nbd.name>, lorenzo@kernel.org,
	ryder.lee@mediatek.com, linux-wireless@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	linux-mediatek@lists.infradead.org, shuah <shuah@kernel.org>
Subject: Re: Linux 6.19-rc1 mediatek mt7921e broke badly
Message-ID: <20251231015712.GA2299@sol>
References: <d7f3b00d-beec-41f0-b157-7cfb871f9a46@linuxfoundation.org>
 <756e3f65-b2f2-4da3-985a-17754a7a872d@t-8ch.de>
 <CAHk-=wjO-7uR5HBi-MFnkxAxjhpgfbAQ+HCMKPiXFVwM+AJ7tA@mail.gmail.com>
 <6fc04df5-b753-4b2d-b978-0e59a7f48ff7@linux.dev>
 <c1304430-dd7d-437b-8744-70af9ca85c0d@linuxfoundation.org>
 <CAHk-=wh6WP0Wq=rbC2Md6vsFrV-+nvDjxgfx9NpMzUmVFNkJ9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh6WP0Wq=rbC2Md6vsFrV-+nvDjxgfx9NpMzUmVFNkJ9A@mail.gmail.com>

On Tue, Dec 30, 2025 at 05:27:13PM -0800, Linus Torvalds wrote:
> On Tue, 30 Dec 2025 at 15:57, Shuah Khan <skhan@linuxfoundation.org> wrote:
> >
> > I would recommend reverting f804a5895eba instead of trying
> > fix it. Then find a better way to eliminate extra newline that
> > shows up in dmesg when firmware build date happens to have
> > a newline.
> 
> Yeah. Let's revert it.
> 
> And the way to fix the extra newline is trivial: just remove it from
> the "dev_info()" format string.
> 
> Our kernel printing logic will add a newline for the next line anyway
> if it is missing (unless somebody explicitly uses PR_CONT).
> 
> Can whoever saw the problem confirm that just a revert and a "remove
> \n from that dev_info()" fixes the output for them?

That works for me.  The revert by itself makes the FORTIFY_SOURCE crash
go away and reintroduces a blank line in the log.  Removing the \n from
the string passed to dev_info as well makes the blank line go away.

- Eric

