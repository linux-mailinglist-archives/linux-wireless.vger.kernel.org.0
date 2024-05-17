Return-Path: <linux-wireless+bounces-7772-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F988C8240
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 10:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 819261C21299
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 08:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B0A182C5;
	Fri, 17 May 2024 08:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bw/I/l81"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B0FEC4;
	Fri, 17 May 2024 08:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715932993; cv=none; b=ky2r2JfxYGgiwrgb5r96NOP2aaOdlzTCZcY3LotmF67Crv2rJimBfElZfl0VTXADcw2PUFdMTZt1oXT5SC3YMyyKcmRHz0mqI73xWjncgyG3RAPcui8NSmjUkQP+nM9Wx6v+OZ1pm+5iJ6He6kdbpFpb1mvaO0JDseXyxD6UijI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715932993; c=relaxed/simple;
	bh=5mfe7yBVIkw7H5OSayGdSn3kS2VYj3CX0eJpo7nXuHc=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=Xp1Ka+xCKI3/uQ71Icr3/Mbcf+KF4M0QO1WtwyojbO1WpBKrn5d3p1nwVQ1A+XK1IkprFvXqJUhW801rjKmvVT8c4k+oFYsT/Ur5IYlguQeCNt8HtYf1+5dKFaGTBmCRicCu9/W/EY5j8I5wJs0S5iorhXOAaQBfle2S0Rx4nMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bw/I/l81; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B74EDC2BD10;
	Fri, 17 May 2024 08:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715932992;
	bh=5mfe7yBVIkw7H5OSayGdSn3kS2VYj3CX0eJpo7nXuHc=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=Bw/I/l81zW67cM21ugTgD/pi3kqYZrUsw9e90mM5Py1e8xnlalTYctqcQrhOtFX8U
	 bbnYCRO1146NbsKlizJK3wk6nJO2730eo+lgI0FheNFIcdr/JY94Jcq/i8YKoPwcmD
	 rThVDj7tPI5jAmMqXolgJJeq9ceabZpqmN5fhWZV07hx6Pbn0LwIhXUol5ikp+tUw3
	 vovSKaAilqnXumBekjtWmrDqHkf0XHuehV7yIE7VbOVbXN0EWu/e63EwRZwtwbErlJ
	 ALcw80NJyayzqkkLRdvRVzmKKMua8HAZ7vAJpA9XhDSR01UFEYR9skxtB56fOq9XAI
	 56x8YgdKUO39Q==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v1] wifi: mwifiex: Fix interface type change
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240510110458.15475-1-francesco@dolcini.it>
References: <20240510110458.15475-1-francesco@dolcini.it>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Brian Norris <briannorris@chromium.org>,
 Francesco Dolcini <francesco@dolcini.it>,
 Rafael Beims <rafael.beims@toradex.com>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, tsung-hsien.hsieh@nxp.com,
 David Lin <yu-hao.lin@nxp.com>, stable@vger.kernel.org,
 Francesco Dolcini <francesco.dolcini@toradex.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171593298896.3274748.6589375938243977457.kvalo@kernel.org>
Date: Fri, 17 May 2024 08:03:10 +0000 (UTC)

Francesco Dolcini <francesco@dolcini.it> wrote:

> From: Rafael Beims <rafael.beims@toradex.com>
> 
> When changing the interface type we also need to update the bss_num, the
> driver private data is searched based on a unique (bss_type, bss_num)
> tuple, therefore every time bss_type changes, bss_num must also change.
> 
> This fixes for example an issue in which, after the mode changed, a
> wireless scan on the changed interface would not finish, leading to
> repeated -EBUSY messages to userspace when other scan requests were
> sent.
> 
> Fixes: c606008b7062 ("mwifiex: Properly initialize private structure on interface type changes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rafael Beims <rafael.beims@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Patch applied to wireless-next.git, thanks.

a17b9f590f6e wifi: mwifiex: Fix interface type change

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240510110458.15475-1-francesco@dolcini.it/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


