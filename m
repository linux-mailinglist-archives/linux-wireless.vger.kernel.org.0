Return-Path: <linux-wireless+bounces-10273-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4C3933280
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jul 2024 21:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8C70B222B8
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jul 2024 19:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D096F19DF63;
	Tue, 16 Jul 2024 19:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="atFkNtaf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A6D25779;
	Tue, 16 Jul 2024 19:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721159858; cv=none; b=ltKTysPRnUUc9SlJ1BnxudLJv2/d6yWodDoYfvfMkvkLkiIwexsj1njhHSavp2T6De3KLfPUaCbr89XBWxOrzOHwjNevaAd0QdHiVFTTdHu6fGSM0zvi0GFpxJoyMobeAMI9gEhq82E3LGB6v7k6v4GAkk1FG0GZvLk2BcYqXnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721159858; c=relaxed/simple;
	bh=uyFsz0E1NO096FvlJlYqMe4GqjWfZ+pUDQY8O06c4K8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfUUEpJiVndF3yRugbacfFqvgP9Fzw92KjI75ut0uKRxSsEevhTr/VDkp2f1Qac1fCxRsCixGbKQgcqk/byrRCDhwd+K6wkdQ2RZs3qobxy9OYSRNt/zPaL6xl8hU/GL59urhn/FqTnDjSJwBkGSJ0lmYTPMXJNO+d8giXR+c1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=atFkNtaf; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id E53C41F928;
	Tue, 16 Jul 2024 21:57:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1721159853;
	bh=uyFsz0E1NO096FvlJlYqMe4GqjWfZ+pUDQY8O06c4K8=; h=From:To:Subject;
	b=atFkNtafYU1zXTAi8VPp5XWp40MmaHLTiYeASy6DJWQycqJ69onpmk67Owbc5xUBk
	 +wx9dDgvjiP2JK81BcVh6W0Aobkb5Nqnl+xkJ72KouD/GCU/2UecG9G3Rr87SRI1DU
	 HXGxLujQcLUMCLNsnUM0xp0hKR6CtbG86ikDkotlIyrutu+QPgjKCoHI0rYDflAdWk
	 uFQG0nNq5mKGjVDpiZ7Xr4ysHBYpazVNcdethbsEOFd+YTqknjiH8sIGrYFq9vt/qx
	 FAxfRQ3uO81Dlhg6NHvxuFDAgWlDxGhW/V0O56246+R8vQycGmzaNWrwrEhIyG5azn
	 GSa1aZLMbrLJg==
Date: Tue, 16 Jul 2024 21:57:31 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] wifi: mwifiex: add support for WPA-PSK-SHA256
Message-ID: <20240716195731.GB85916@francesco-nb>
References: <20240716-mwifiex-wpa-psk-sha256-v1-0-05ae70f37bb3@pengutronix.de>
 <20240716-mwifiex-wpa-psk-sha256-v1-2-05ae70f37bb3@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716-mwifiex-wpa-psk-sha256-v1-2-05ae70f37bb3@pengutronix.de>

Hello Sascha,

On Tue, Jul 16, 2024 at 01:33:28PM +0200, Sascha Hauer wrote:
> This adds support for the WPA-PSK AKM suite with SHA256 as hashing
> method (WPA-PSK-SHA256). Tested with a wpa_supplicant provided AP
> using key_mgmt=WPA-PSK-SHA256.

Do you have any more details on which chip/firmware you tested?
The change looks good, I am just wondering if there are reasons this
might create issue on some specific chip/firmware combination.

Francesco



