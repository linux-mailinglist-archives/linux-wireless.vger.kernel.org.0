Return-Path: <linux-wireless+bounces-18081-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB29A2109A
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 19:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3E08162888
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 18:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD611DE4C2;
	Tue, 28 Jan 2025 18:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSDc3hNZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8328418C004;
	Tue, 28 Jan 2025 18:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738088119; cv=none; b=OWsMlnX9tXmUtSkA4qfN2O1JUtX7/CS46Ly0rwZmsueKng8PrYMUIVuW0n3VJQRg5j7Ozfux5kBCcoOqDADisWUFfdGWuRJiaYMFoZLeUrtOpcnpINdQGAukfaUgbIJ5Zg7OULLE2CrT4prO14qfDmOl+KBPw6WXW8fM8YF5CS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738088119; c=relaxed/simple;
	bh=vfHlHoIceU2bxtO2YkG/eEpOBsDxtiVhZtj/Mu9aUQQ=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=uD7OKSvCuXWwv7EXW7McsaG8TsO1gr64FAUl1HBaMpQ3HdUsuYmIUnVJjFhnHG4xzsDxeLqrvaIfBYrUE6I34UA89knj8dSiYndEnZDuFeeFzDT5FFNPK7bXFLm3YT7p4Cp0A7cd/aBV6zidKSdZyTMJ5/3mnv2+GBlG/VEVIyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSDc3hNZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B575C4CED3;
	Tue, 28 Jan 2025 18:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738088116;
	bh=vfHlHoIceU2bxtO2YkG/eEpOBsDxtiVhZtj/Mu9aUQQ=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=eSDc3hNZzPWLqhvrjtHB2OxF25Bb5ArDM+cQLAD3vg8t3AEI19S/wCTboaiOQJo/Q
	 0UeAtEgOS6KTnACqKGJeN+YWBeWFfzuOQ2+OK6FEWW7XtapuFmlYo/3P6JdvSu8Bj5
	 J/UNZmyVADG/esB5comfltymfxwRrSgIjeao/abELuK7+apN1ZZ4ySGvJjzE9ab86e
	 otiN53yea7vmKrgD7UNv2N7VhD8LhUSwDjI7BGQMIBT3ZofmdHp/z+VdRHLLl8J2Zp
	 ATMGRHBamfWjI1EebURt90CdhMwryLxsjUFplOIp1uzOqbTy5tKxJz/CYNC87lGbHm
	 Jydt44ZfT+skw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: ipw2x00: Remove unused libipw_rx_any()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20250122022240.456198-1-linux@treblig.org>
References: <20250122022240.456198-1-linux@treblig.org>
To: linux@treblig.org
Cc: stas.yakovlev@gmail.com, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Dr. David Alan Gilbert" <linux@treblig.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <173808811314.1254064.2452319930910401059.kvalo@kernel.org>
Date: Tue, 28 Jan 2025 18:15:14 +0000 (UTC)

linux@treblig.org wrote:

> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> libipw_rx_any() was added in 2006 by commit 1a995b45a528 ("[PATCH]
> ieee80211_rx_any: filter out packets, call ieee80211_rx or ieee80211_rx_mgt")
> as ieee80211_rx_any but is currently unused and I can't find any sign it was
> used under either name.
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Patch applied to wireless-next.git, thanks.

22f3551b60be wifi: ipw2x00: Remove unused libipw_rx_any()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20250122022240.456198-1-linux@treblig.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


