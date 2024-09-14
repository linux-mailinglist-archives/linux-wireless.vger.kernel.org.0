Return-Path: <linux-wireless+bounces-12861-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 293F597909F
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Sep 2024 13:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7DAAB22785
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Sep 2024 11:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DCD1CEADF;
	Sat, 14 Sep 2024 11:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3+bJ5l7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25BB1CEAC3
	for <linux-wireless@vger.kernel.org>; Sat, 14 Sep 2024 11:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726314367; cv=none; b=bFkEEGN2lRxLZxr5kEjsNxwrfvcreZoFp9WS4sWQS6S/+GBKcgYn0H54Cfw3ir7xPzFJ1zyQCiIJz0T8mwrAzArNquYxshTYsV/bjTd6Y7FpXUFGM8KKcSUUH27BLtUowtVv+Yt+GSCQY4Mu0n79NpBMAqeuybW0EVIP8wsAxh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726314367; c=relaxed/simple;
	bh=h3R50H6t6rxOZRV35z46awjwxg5bZ6hbfpawIXW05wQ=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=Go2iC3SGbPZcnDVPU7ARxU8lvDU0bGeOJQPh+KWgCRNBqelU9BtXnhVbhHvGxEZ3w2Rho4p5gKKdA3mvu4Dfkzcs8ncWqKm0Ut8ybNFfcE/SosDYFMkGR9nTzwXpsx+ae7stQr2Gdvd/iJXkz4P0747iBIXhQuMw8lCiznv+/Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3+bJ5l7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF590C4CEC0;
	Sat, 14 Sep 2024 11:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726314366;
	bh=h3R50H6t6rxOZRV35z46awjwxg5bZ6hbfpawIXW05wQ=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=D3+bJ5l7Jml/VjgUWfk9spO8+3bAEl0rgFGOMrIFQxLgufpawtqLuZ5Tj9FJ+9Sai
	 qoiQeyV4TjmwA+5OTOIIvS8R/APgbNhnCXVVDzUmD0SAhqQmWv3/NyT7AGvj+wY72r
	 cB47ermX+ER9rCGGvUai26hNa7eub6UelwOYLZTA2NoG+d0wAYNk9Tm9sk7i7J345+
	 e5ds8OVcNZGgvDOPmusPlfxJtkTFoMV4Fi446/aqL4GBN8QWpwHEUZMnaYuHtRuBip
	 uGeHyWqEz8HkAR+LLBM/SumIBhQgwzmtIBTAk6UA7kn5DKkCZ3k9Sw0hxXoAtXP2p6
	 i0jS/iXjiwlww==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -next] ath9k: use clamp() in ar9003_aic_cal_post_process()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240830011858.603514-1-lizetao1@huawei.com>
References: <20240830011858.603514-1-lizetao1@huawei.com>
To: Li Zetao <lizetao1@huawei.com>
Cc: <toke@toke.dk>, <lizetao1@huawei.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172631436381.3042536.8611929309351688690.kvalo@kernel.org>
Date: Sat, 14 Sep 2024 11:46:05 +0000 (UTC)

Li Zetao <lizetao1@huawei.com> wrote:

> When it needs to get a value within a certain interval, using clamp()
> makes the code easier to understand than min(max()).
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

1d66430cc9af wifi: ath9k: use clamp() in ar9003_aic_cal_post_process()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240830011858.603514-1-lizetao1@huawei.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html


