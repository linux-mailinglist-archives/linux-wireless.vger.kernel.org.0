Return-Path: <linux-wireless+bounces-3880-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BA785E6C3
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 19:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0677B27A69
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 18:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172A985937;
	Wed, 21 Feb 2024 18:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/aRyUJu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A998592D
	for <linux-wireless@vger.kernel.org>; Wed, 21 Feb 2024 18:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708541736; cv=none; b=gcWfOhs/YQkQf7mjQJWXg1TukA0Nfc1X9dvTlnFwR32/z6IySlncUK+1bn8RVNl9XAH9XHR7+FhI2sBq8UZi+ptevkYr6P3IGAPW8RDQPpkyS9S7g8K6r3bAgfQI80sgEblRqghrhXAG0BugKrzCu4YjtSaD/ypVc9ayq1eIeSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708541736; c=relaxed/simple;
	bh=rLWDmUCAx6EILc6f8XjazvNhWfCbGx8cvM4UHjC/Jf4=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=i/o5g21GjYe8fonOV3gKkYdKZChHqrfRtr7/ozqJnO73Om+QQ2DbzCKay4UzSUqDIANJYTgnDZl/myQ3BD1PHa8WDK9WR57RwM9qvxrevYb28M/pHdYj28Lz80a/eLFi66iF9N2bJzAeeLQrNuw0DC57a9KTdBfTwIkf9id9tuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/aRyUJu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F3AC433C7;
	Wed, 21 Feb 2024 18:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708541735;
	bh=rLWDmUCAx6EILc6f8XjazvNhWfCbGx8cvM4UHjC/Jf4=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=G/aRyUJuE39cMCEZWPoqqSkM5Y2QfOJuJhnIfO9BjbKyeFqa2BzGhg6nkw09jFp/o
	 Wfo7xIcXiqkRzmpZi/TefV21tKdCdN35Anmn02n1QKgrrm7VoCmEpeTPtsSWBqCRo9
	 kLKKzu0aCKhkUhgVvUZKdKDZakeJDvbZ0PL42vVtZavhwvWt5xSuaUTGYFKKD2y6cY
	 BaeC01baatzdJZS3x965olErrqzy14bAxKmlDe/yncjk6D1/n5xfbEuUnE8dDS0HrE
	 TSeyB9RsTOgjOWbrGBMyY8Xt0SfpmDp93xVPq8WtfR2W1O2d+Tv9eD9lQ5LVV9kJWg
	 ljJ0WW2/kTpYA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtl8xxxu: check vif before using in rtl8xxxu_tx()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240216033923.34683-1-pkshih@realtek.com>
References: <20240216033923.34683-1-pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <Jes.Sorensen@gmail.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170854173243.1918455.9065659857855467612.kvalo@kernel.org>
Date: Wed, 21 Feb 2024 18:55:34 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The 'vif' is from tx_info of SKB, and other codes check 'vif' before using,
> which raises smatch warnings:
> 
> drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:5656 rtl8xxxu_tx()
>    warn: variable dereferenced before check 'vif' (see line 5553)
> 
> Compile tested only.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

513c559ca9f0 wifi: rtl8xxxu: check vif before using in rtl8xxxu_tx()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240216033923.34683-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


