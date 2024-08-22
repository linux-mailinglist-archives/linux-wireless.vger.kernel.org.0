Return-Path: <linux-wireless+bounces-11791-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3382095B10B
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 11:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E513D282539
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 09:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D24015C156;
	Thu, 22 Aug 2024 09:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LcpPMgCv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E77B1CFB9;
	Thu, 22 Aug 2024 09:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724317233; cv=none; b=GHe5VF7GvNyo8LTTe19yQyeNjhK6+Fnss1NYdE27c0nev1Bdc0hcH3pzXMa42dX6XA0u8eSb8tXSfWBc0LNvvElUEN0rZEXYcy8eW5eGYOiJjr3RGJo3dYCecKLQXNx3BWp+HiX87nzhUejl68HsvyGi/AJPsJRF8PH0+IMTJ1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724317233; c=relaxed/simple;
	bh=DTKmkZCfsT6mqM6ng6WdvHgR2q9ReddZ1ktwO8MCYkE=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=juRV+HTkIx/NBp6DB/NdXssZB1vvFaqUtfTxukaguOQ//iUwSj5RgF4NeZiwhYatB1/SfPwzpb6VdDE0Neia0cbhPKGEYyVJAf5fWAwqG/MsZljfmg+lQscmy+J158++M0m9bxcjIN6AVBbHILR8dmqCa59WmtQ1UMDIwnI5ASs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LcpPMgCv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8935AC4AF0B;
	Thu, 22 Aug 2024 09:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724317232;
	bh=DTKmkZCfsT6mqM6ng6WdvHgR2q9ReddZ1ktwO8MCYkE=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=LcpPMgCvgs6HYzca5AdXgCT186sdoQNV3w+dl9C4qcjmzLzoLGg+iKLxf6p9HQ6x7
	 F0H2d7s96K3XZfIk45EgVwsfuM1HXD/dbxKmeer4LBBHpRsClc+F+hNkGHEocQz60K
	 2cFUGo0NuWSkUMoPgSSuGIXUQXZWeMDV39oV9wSqQfl/U/JU41DsQFt33QcRsqyUJX
	 LXdtWPgEBrgBdKcnFGK6ZK5m5X6nUoS4Krp26BVk4o7W8ZlbWvwmbQQlmY18XW6t3W
	 Y4osOFBlOLLKPoRR07bzI75v9bn343mqIOMMvLmR7Dki9ilxJ10WNpNkHV18ks+7Lt
	 olLDV0OU3mkhw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: mwifiex: remove unnecessary checks for valid priv
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: 
 <20240816-mwifiex-remove-priv-checks-v1-1-6dd6553e8ed9@pengutronix.de>
References: 
 <20240816-mwifiex-remove-priv-checks-v1-1-6dd6553e8ed9@pengutronix.de>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Brian Norris <briannorris@chromium.org>,
 Francesco Dolcini <francesco@dolcini.it>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172431722965.2217900.9384549285038078950.kvalo@kernel.org>
Date: Thu, 22 Aug 2024 09:00:31 +0000 (UTC)

Sascha Hauer <s.hauer@pengutronix.de> wrote:

> The pointers in adapter->priv[] are allocated in mwifiex_register().
> With an allocation failed the function will return an error and
> driver initialization is aborted. This makes all checks for valid
> priv pointers unnecessary throughout the driver. In many places
> the pointers are assumed to be valid without checks, this patch
> removes the remaining checks.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Acked-by: Brian Norris <briannorris@chromium.org>

Patch applied to wireless-next.git, thanks.

67a72043aa2e wifi: mwifiex: remove unnecessary checks for valid priv

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240816-mwifiex-remove-priv-checks-v1-1-6dd6553e8ed9@pengutronix.de/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


