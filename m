Return-Path: <linux-wireless+bounces-11530-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D143954612
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 11:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F69F1C2335A
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 09:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938BA16F0E1;
	Fri, 16 Aug 2024 09:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="puYwxbuU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634551304AB;
	Fri, 16 Aug 2024 09:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723801688; cv=none; b=cx8J5tvBA20UVpoNjcmhbem0D7pHRhmK+qKYZZyeMpKNcJNlPDgxZexY1rjMZsbYIf9rCIHoE8EmWVhOhsCZCxJPpnOHoi/pik3M2xs5YdUN0JNauXHBbiVulEgbH9TfVp4Ru4uVYHBKOX87Bkxj/0O1DphCYvbT26bB3nwaVLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723801688; c=relaxed/simple;
	bh=WBtWprX0VlBj06J/MiqwicXG54rhOqMHrRkLdcGPLfo=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=Xsvz5/4FjLeyI3avGc7KwySoP50BC5n5ikFyFCcy3l0+amIxhIFie7SoDV3QFbN1+a9xH+WscIVs4IEZyB8kpUs1e6LRdA/mCHOLTuCYApaHoUkxQIYgeVwrVV6afKzCH2khe74yFio1cfgfUAh3mshVN6JYzsjnu0e81Ae8aSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=puYwxbuU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E88F7C32782;
	Fri, 16 Aug 2024 09:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723801687;
	bh=WBtWprX0VlBj06J/MiqwicXG54rhOqMHrRkLdcGPLfo=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=puYwxbuUDZo3m+h2/JGr6sLZHzWEAE/rHkuJmawOrfGbX0oZxPtM+hfmgHPZbT/P5
	 3Fm2Md10vxziBrfWon+uzUC1GExWGJvtacCcjbeUHwB9HtrVdzaUnWeFNdjSZ7F1cN
	 JKZcFVeUEhdDTmRTua4mCGxnhHl9LP9Tg9wbRJZeHHBP4FefmN/YdhGDAPT0NYra71
	 TupWHo9FAev8GKjn6Kro6exDlsXBSiOgAvszukcyi8kotYfFXx9FPNQt+FPMYwgKTe
	 B87XzYF5/ux4lnRBDnG8KMqyy8pfS17Q3ta0R2qVgxJ2tQ+wVEuAvtQ1nr8UwOi2P0
	 8ZCUGgC758j6Q==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: mwifiex: duplicate static structs used in driver instances
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: 
 <20240809-mwifiex-duplicate-static-structs-v1-1-6837b903b1a4@pengutronix.de>
References: 
 <20240809-mwifiex-duplicate-static-structs-v1-1-6837b903b1a4@pengutronix.de>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Brian Norris <briannorris@chromium.org>,
 Francesco Dolcini <francesco@dolcini.it>,
 Yogesh Ashok Powar <yogeshp@marvell.com>, Bing Zhao <bzhao@marvell.com>,
 "John W. Linville" <linville@tuxdriver.com>,
 Amitkumar Karwar <akarwar@marvell.com>, Avinash Patil <patila@marvell.com>,
 Kiran Divekar <dkiran@marvell.com>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, stable@vger.kernel.org,
 Sascha Hauer <s.hauer@pengutronix.de>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172380168290.1353179.16302095751530116958.kvalo@kernel.org>
Date: Fri, 16 Aug 2024 09:48:04 +0000 (UTC)

Sascha Hauer <s.hauer@pengutronix.de> wrote:

> mwifiex_band_2ghz and mwifiex_band_5ghz are statically allocated, but
> used and modified in driver instances. Duplicate them before using
> them in driver instances so that different driver instances do not
> influence each other.
> 
> This was observed on a board which has one PCIe and one SDIO mwifiex
> adapter. It blew up in mwifiex_setup_ht_caps(). This was called with
> the statically allocated struct which is modified in this function.
> 
> Cc: stable@vger.kernel.org
> Fixes: d6bffe8bb520 ("mwifiex: support for creation of AP interface")
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> Acked-by: Brian Norris <briannorris@chromium.org>

Patch applied to wireless.git, thanks.

27ec3c57fcad wifi: mwifiex: duplicate static structs used in driver instances

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240809-mwifiex-duplicate-static-structs-v1-1-6837b903b1a4@pengutronix.de/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


