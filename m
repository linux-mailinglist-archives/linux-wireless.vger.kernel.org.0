Return-Path: <linux-wireless+bounces-12659-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DC79718F4
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 14:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB4C32843E6
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 12:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF851B652E;
	Mon,  9 Sep 2024 12:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2YzGG8n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC53B1B533A;
	Mon,  9 Sep 2024 12:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725883797; cv=none; b=hTLl5w+AExHbBhrp4+MiVEgTqGBBHKNAXdtLPRVVQePXvhLrH3WgzFwmfo2B8rCXlCpjMp9Ioo3nGp8r/X1CIziFfbg2Uzh+i/S9pXzueOXLdPhGnpZ7ZUWHMLd9zduLKF1b+InokhDbdeFd0IhpMIPFgKWjoR5+Zth1Ee3CYWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725883797; c=relaxed/simple;
	bh=JNrAkxSM5sZyEuezoqC9/IvnHcF0DQDdb5yUFR2tjFc=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=lDC3f9ZXB1W3DuEutTWAFgPkmM+4AgUB+sWcR67QVkOsUchv4UwephkGnc6K0XbfTV6yg71dJUVFh+3vpNRUchVf31FveEAe1IsbwzlPoq0qQD86tBiNzcS/ExVjUamGRKgI8nlKyf6UgIV7x4mxt9iSp5IvENwbXDLd6X8e03k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2YzGG8n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2DAC4CEC5;
	Mon,  9 Sep 2024 12:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725883797;
	bh=JNrAkxSM5sZyEuezoqC9/IvnHcF0DQDdb5yUFR2tjFc=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=P2YzGG8nxqR77x10Walht4GPKTB5cyrnCuJ4NFMkinjGqj8b0PGdGMP0ag1/dtkCh
	 NziJdNC5xwK5RnuK3bCy5k1g1DK/PDwIZeEiOMGNbUKekbZgZLrB7TdORmkY6vuUpy
	 ZJaglhWiDSqCGg0ynEKp5xAgUoYpDohw1FKryQBTnpjTa3J5c0Zb5WFDFeZtkPxQ09
	 SDbfCuZOAsUCK4z1vKNXwmofQ4aARDlsha2iDiUkmgReoFA7aKUi83GfGXAiiAwJex
	 iTlGXxfC8+mb64KaDgCpLNbjhjtzYciRBa3s31G/mdsu/h9FdB4+KFwkyzeSYaZycy
	 h+JEYN7IDNqbg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH][next] wifi: mwifiex: Fix memcpy() field-spanning write
 warning in mwifiex_cmd_802_11_scan_ext()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <ZsZa5xRcsLq9D+RX@elsanto>
References: <ZsZa5xRcsLq9D+RX@elsanto>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Brian Norris <briannorris@chromium.org>,
 Francesco Dolcini <francesco@dolcini.it>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-hardening@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172588379395.2095526.695179874478539721.kvalo@kernel.org>
Date: Mon,  9 Sep 2024 12:09:55 +0000 (UTC)

"Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:

> Replace one-element array with a flexible-array member in
> `struct host_cmd_ds_802_11_scan_ext`.
> 
> With this, fix the following warning:
> 
> elo 16 17:51:58 surfacebook kernel: ------------[ cut here ]------------
> elo 16 17:51:58 surfacebook kernel: memcpy: detected field-spanning write (size 243) of single field "ext_scan->tlv_buffer" at drivers/net/wireless/marvell/mwifiex/scan.c:2239 (size 1)
> elo 16 17:51:58 surfacebook kernel: WARNING: CPU: 0 PID: 498 at drivers/net/wireless/marvell/mwifiex/scan.c:2239 mwifiex_cmd_802_11_scan_ext+0x83/0x90 [mwifiex]
> 
> Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Closes: https://lore.kernel.org/linux-hardening/ZsZNgfnEwOcPdCly@black.fi.intel.com/
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Brian Norris <briannorris@chromium.org>

Patch applied to wireless-next.git, thanks.

498365e52beb wifi: mwifiex: Fix memcpy() field-spanning write warning in mwifiex_cmd_802_11_scan_ext()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/ZsZa5xRcsLq9D+RX@elsanto/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


