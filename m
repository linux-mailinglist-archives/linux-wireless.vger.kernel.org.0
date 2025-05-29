Return-Path: <linux-wireless+bounces-23488-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C324AC7987
	for <lists+linux-wireless@lfdr.de>; Thu, 29 May 2025 09:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DED11C20F92
	for <lists+linux-wireless@lfdr.de>; Thu, 29 May 2025 07:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817652550C7;
	Thu, 29 May 2025 07:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="D0lA3h1c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F00215F7D;
	Thu, 29 May 2025 07:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748503241; cv=none; b=rA5rXEuFsayTntY/Y3ME05ca5aZ0DNYU7vSkNN/B0R45teNwyOj9OlFcMA30Rj7QRmZU3oxXLMC8XARe7q9lTIDB9xu1my/R21FkyQRlc4Z6E/7bGqB6JlaawFFD4SGDsB711Vp7CLMECM4HGE5aBZC5L0PK2/LCGZdneiv5XXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748503241; c=relaxed/simple;
	bh=gY4unlyyXzDyV0TAtwBDnTWLIfshVPbUOi0CDbIAvl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWO0gP27WT096jxA9YjS0ioJUWO9xcBrBcfw9g1LCwzLqVno82pcIkm4w9aEO2qUlPA/i5IRCYVa9en4YgMrrIH3Y68OsOu43LZ11z9nvIMyJqc2uPFq5rZEyl1YBOf4gkuvc2lQMJWzhsyPPWC1DFtS2Li2u/nWjOcib2UsYL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=D0lA3h1c; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 3938C20A64;
	Thu, 29 May 2025 09:20:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1748503234;
	bh=LNKXo4sCtImO+RXN4BcEP7wDoEcEVj1mmFDwzcDqPFI=; h=From:To:Subject;
	b=D0lA3h1ccTdJlfhN81EWoh//MsYBZSrxtFz+dXtSIyuO618tR9zYTsNzdhSMAaBB7
	 GiF90qcQt/UWlrIy4+JkQ+uF10aL+5Wbo5wfU81pYQjFoQcDI8FtQZypf2FXr8XcoF
	 CrN4WRhrsAR5NZMocEdYIoQFyh81nvXc+fhudOCPES5jxZwV34Pt3MTdGIFaE2qQ2H
	 NsBzvhIRa/HtrFR2nLkvN+rYcbbcpKdYyj+wR9UsNyQXowdit5UkYxyC3CWJQAk1A6
	 EsBGWVlBsrnQXzxyoFVLOCfqYRIoivt7RXNtx0duWX7TEn4aGArHgHFLLGH22MprKJ
	 QX0rqfS8fzA4Q==
Date: Thu, 29 May 2025 09:20:28 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Brian Norris <briannorris@chromium.org>
Cc: Francesco Dolcini <francesco@dolcini.it>, rafael@beims.me,
	Rafael Beims <rafael.beims@toradex.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: enable host mlme on sdio W8997 chipsets
Message-ID: <20250529072028.GA75868@francesco-nb>
References: <20250521101950.1220793-1-rafael@beims.me>
 <aC9dvv6Ki1T5RsHF@google.com>
 <20250523072604.GA14001@francesco-nb>
 <aDdCP_lvlyvk9J3n@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDdCP_lvlyvk9J3n@google.com>

Hello Brian,

On Wed, May 28, 2025 at 10:05:03AM -0700, Brian Norris wrote:
> On Fri, May 23, 2025 at 09:26:04AM +0200, Francesco Dolcini wrote:
> > On Thu, May 22, 2025 at 10:24:14AM -0700, Brian Norris wrote:
> > > On Wed, May 21, 2025 at 07:19:34AM -0300, rafael@beims.me wrote:
> > > > From: Rafael Beims <rafael.beims@toradex.com>
> > > > 
> > > > Enable the host mlme flag for W8997 chipsets so WPA3 can be used.
> > > > This feature depends on firmware support (V2 API key), which may not be
> > > > available in all available firmwares.
> > > 
> > > Is it available in *any* W8997 firmware? Or particularly, is it
> > > available in the firmware in linux-firmware.git? Judging by its git
> > > history, the answer is "no", in which case this is definitely NAK'd.
> > 
> > mrvl/sdsd8997_combo_v4.bin, from linux-firmware GIT, 16.92.21.p137
> > version. From an off-list chat with Rafael he confirmed me that this is
> > what he used for testing.
> 
> linux-firmware.git claims to hold W16.68.1.p197.1. Either WHENCE is
> wrong, or that sounds like a completely different branch. Are you sure
> about that?

Nope, I did a mistake :-). Wrong copy/paste.

[    5.956510] mwifiex_sdio mmc2:0001:1: info: FW download over, size 623352 bytes
...
[    6.825456] mwifiex_sdio mmc2:0001:1: WLAN FW is active
...
[   12.171950] mwifiex_sdio mmc2:0001:1: host_mlme: enable, key_api: 2
[   12.226206] mwifiex_sdio mmc2:0001:1: info: MWIFIEX VERSION: mwifiex 1.0 (16.68.1.p197)

root@verdin-imx8mm-14700070:~# strings /lib/firmware/mrvl/sdsd8997_combo_v4.bin |grep 16
$Id: w8997o-V4, RF878X, FP68_LINUX, 16.68.1.p197.1 $

f62026ad508304fdadd9ebb5b500a6b4  /lib/firmware/mrvl/sdsd8997_combo_v4.bin

from commit 211fbc287a0b ("linux-firmware: Update FW files for MRVL SD8997 chips")

> The firmware versions above don't match up to me. But if we confirm
> that:
> (a) this API is available in a linux-firmware.git firmware for this chip
>     and
> (b) someone includes a valid linux-firmware.git version that they tested
>     in the changelog
> 
> then maybe this is OK. As it stands now though, no.

Right, my fault, now it should be clarified. Rafael, can you prepare a
v2 patch with all this information properly written in the commit message?

Francesco


