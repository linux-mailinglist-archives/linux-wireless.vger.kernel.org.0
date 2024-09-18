Return-Path: <linux-wireless+bounces-12957-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA9E97BD12
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 15:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A092A1C2150B
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 13:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29C918950C;
	Wed, 18 Sep 2024 13:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6Ei8360"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2D6176ABB
	for <linux-wireless@vger.kernel.org>; Wed, 18 Sep 2024 13:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726666409; cv=none; b=bCfO6Dez2ICDiQx8Ckwxv8NZOAZzvpaG4ZL3pMk1D7VrWhy5zkcDB6WF1PmSsjAoH2JCcNyHF62eQKcStaxGxG4uI0ym5C7e/Wex4du44eIsi5TFnxbMpQjSPsFiOGdt9Lw+NWaJQTtR5MyfYWLeDRfY+xa/OC10fus3H4sLFNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726666409; c=relaxed/simple;
	bh=Zfq1gsjwk7VFZKeJdzKygDFpA1d6RXID+rs7se9RLMU=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=iH5fhZ0A97o7jRKGEGQzlAlhXHGt0wlhYVw2HZqgxhLcuqps9NqCe5aKncpsI1k+sRBOi9TcVo8pSVsLTx9QBOmLORfcPi/A6Kl+pz5BZDHPupLzlHUIi7GGD76k/IAfqv32+BPrmBhIPtTvg5Le6lyuFD+1IXF+Tus1SDIqrcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6Ei8360; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B2FC4CEC3;
	Wed, 18 Sep 2024 13:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726666409;
	bh=Zfq1gsjwk7VFZKeJdzKygDFpA1d6RXID+rs7se9RLMU=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=Y6Ei8360x0f/1PdnYDA7BPYfQ4b6HAlztQOcD8xzmGHQL3QM2uXjZrjhcagAi5nkE
	 /nKW16y+Iic6dmIK4uXc3HQMZ54JjyCxVnJjXnXx5EgasoSt6E+MTj3zOx7cCdPMeq
	 OAm3Iq3MGPZ/UDB3HTisqSPevI0cX3oinUtoOuVBKDZHBISESzh1YupMkY/tH3vHD6
	 y3RRFvYqopAoULBQpchTTwEu2jrVrzBwnyUIr7u5A/Aaut/qmsWUCcS7cke+r0321g
	 VJ9N4bE9U7mfxBO1NnuN2mR/A4v6Jkx0ZJ7lWbsj5v75KytgdJo+tKaFoeHozgduJF
	 3h1CzVuWvKHDw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw89: coex: add debug message of link counts on
 2/5GHz
 bands for wl_info v7
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240912021626.10494-1-pkshih@realtek.com>
References: <20240912021626.10494-1-pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172666640677.3918518.17032704490786204843.kvalo@kernel.org>
Date: Wed, 18 Sep 2024 13:33:28 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The counts will be used by MLO, and it is ongoing to add the code, so add
> debug message in todo part to avoid warnings reported by clang:
> 
> coex.c:6323:23: warning:
> 	 variable 'cnt_2g' set but not used [-Wunused-but-set-variable]
>  6323 |         u8 i, mode, cnt = 0, cnt_2g = 0, cnt_5g = 0, ...
>       |                              ^
> coex.c:6323:35: warning:
> 	 variable 'cnt_5g' set but not used [-Wunused-but-set-variable]
>  6323 |         u8 i, mode, cnt = 0, cnt_2g = 0, cnt_5g = 0, ...
>       |                                          ^
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless.git, thanks.

5575058ba95b wifi: rtw89: coex: add debug message of link counts on 2/5GHz bands for wl_info v7

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240912021626.10494-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


