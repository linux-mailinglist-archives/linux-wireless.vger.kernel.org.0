Return-Path: <linux-wireless+bounces-3461-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 064FA851835
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 16:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98C921F210FF
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 15:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1803C47A;
	Mon, 12 Feb 2024 15:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRAt+Oor"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573A23C478
	for <linux-wireless@vger.kernel.org>; Mon, 12 Feb 2024 15:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707752184; cv=none; b=rU3Ejthhm2hByFiaXIubP7kMj3N4UpzfURvwQCoKgmkVt3VYwdnd7ndxEtGi5PXS3u803y5QPwS7rjssGVoc7RJs8BjhgrrVDZpoDYi9THO/609a+6Vtgh4YAq5m6HmY+K/m03OBtExt38g2t7GiE0MhdhPI/DWQI6CFoqI2jag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707752184; c=relaxed/simple;
	bh=ECbYkXVzgQF/V9vRkVd65yRjFcIEHReY7TAf+IWgXXU=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=TNY+vQP6D6DXn/62DA3wHYXkagTVyIThU855UeA+eZglC+4jeSmm7zOImXfjGdAo9Qi+iaVEFKHP6UgsxJSwRgvHSVvRmu87wGM75K9EpLZ9hRR++3JIooWYmlmOUYOw75eV0/Dw60xemFT6ctQ2+ClgyeYAdSF2CQBgpzfRJ4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRAt+Oor; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A07D3C433C7;
	Mon, 12 Feb 2024 15:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707752183;
	bh=ECbYkXVzgQF/V9vRkVd65yRjFcIEHReY7TAf+IWgXXU=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=LRAt+Oor8P2T2e9jAG8RPPLO8HV53LPRxQX9ByQDfufON/BSq4/4u0WOUj+X/cJ+c
	 vFgKSVvSkfm60v8vuDYYLLrww7yg9H+RJccPRm2r1j9BdYNuEuflGi/z9O7xZRxUpd
	 c1mpe8i3MZXHEPeQWD2UYOgQT5I5op9usLhhNJPXz6Gtxo0KwqBKDGPP/R8uUtpq3H
	 NplDQz7u3dJUcD9YUlG2+MJeTd/Ib4MhKJgzlQdYF59CijSK5/DIdN4CqUQqLukeYR
	 ZJrT4XZayp7s0UuaT3zjy6gZmgtsr9Jgpl8UsrJ0ReQ0ZrajTLkrdGagMHAcbBzYCX
	 +akd1wjd579WA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: mwifiex: use kstrtoX_from_user() in debugfs
 handlers
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240110115314.421298-1-dmantipov@yandex.ru>
References: <20240110115314.421298-1-dmantipov@yandex.ru>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: David Lin <yu-hao.lin@nxp.com>, Brian Norris <briannorris@chromium.org>,
 linux-wireless@vger.kernel.org, Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170775218065.2851594.7786977190037011218.kvalo@kernel.org>
Date: Mon, 12 Feb 2024 15:36:22 +0000 (UTC)

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> Use convenient 'kstrtou32_from_user()' in 'mwifiex_verext_write()'
> and 'kstrtobool_from_user()' in 'mwifiex_timeshare_coex_write()',
> respectively. Compile tested only.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Patch applied to wireless-next.git, thanks.

425c33264e15 wifi: mwifiex: use kstrtoX_from_user() in debugfs handlers

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240110115314.421298-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


