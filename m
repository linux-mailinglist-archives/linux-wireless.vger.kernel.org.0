Return-Path: <linux-wireless+bounces-3466-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3954851844
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 16:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 021181C2061D
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 15:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856D33C689;
	Mon, 12 Feb 2024 15:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ioy+Xv8B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A0A3C684
	for <linux-wireless@vger.kernel.org>; Mon, 12 Feb 2024 15:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707752339; cv=none; b=a0GWJrPJFY4BeN8Aj5ZdEAmivZItcjyOfiZHvXYaBJf1nLGolM0UnK0W8COsbxLpXr5ufRjQNATyJQglmL05ZeNu1RZl3KnSy+uL6rV/hyUju+rQ6CfUFPCo/M0AB6PhUrrH9KI1vQ/tP5nZySR2EDN0C/2F2qWFfRq2T5xYPRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707752339; c=relaxed/simple;
	bh=ndLKKOOMqtN5vOXd9QLPhGAEsP4jQeOIdJyB8QETJtU=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=nG7k8sewtlK80p8yWm+fYLOStyhpX1cfNfr66iWAs8geXugrOw+DP32+Sej7HLT4emcMilQL2QEdVMeauKTOoLF8+7eYW7DCUoO0KhgDSi9E0+HUrniAtjmOb0V1U8cbA5vkGz06gIPm5C3QfpavPgKqP0pbzpMbnnlGGAjtGkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ioy+Xv8B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12DAFC433C7;
	Mon, 12 Feb 2024 15:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707752339;
	bh=ndLKKOOMqtN5vOXd9QLPhGAEsP4jQeOIdJyB8QETJtU=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=Ioy+Xv8BBVNCobErFTm9hZHCpqp8XFQDG5JNqUFkORwqxaH769F1h5f0NjEdzshcE
	 WYaAx8mhH5/KsfsdP5+DWMGbjpq99czgoO5qZJE5iMDQtVtIEx/CH0UhfbbWLgH8o2
	 sm0wCUQvFn7XLREjWt9ZsS0F5cx3FENkylzV41IStcQ1Uh3U3KIuDtt9WzJB16Zplk
	 xSaLgPPPHhY9wm2qShAwopFUs/DsAy+1r+OfJE7OCkfMhY3mabAT5m08yt+oPDzkFn
	 /jXLb29tvT8J581cGKuYRjmKHICujWjdlQyEi2P2K1CH8PURuY2hT4pXNCMpRR2JvZ
	 hXlfTzEI+U5kg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: brcmfmac: do not cast hidden SSID attribute value
 to
 boolean
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240208085121.2430-1-a@bayrepo.ru>
References: <20240208085121.2430-1-a@bayrepo.ru>
To: Alexey Berezhok <a@bayrepo.ru>
Cc: Arend van Spriel <aspriel@gmail.com>, linux-wireless@vger.kernel.org,
 lvc-project@linuxtesting.org, Alexey Berezhok <a@bayrepo.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170775233602.2851594.8173116143852900695.kvalo@kernel.org>
Date: Mon, 12 Feb 2024 15:38:57 +0000 (UTC)

Alexey Berezhok <a@bayrepo.ru> wrote:

> In 'brcmf_cfg80211_start_ap()', not assume that
> NL80211_HIDDEN_SSID_NOT_IN_USE is zero but prefer
> an explicit check instead. Compile tested only.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Alexey Berezhok <a@bayrepo.ru>

Patch applied to wireless-next.git, thanks.

f20073f50dfd wifi: brcmfmac: do not cast hidden SSID attribute value to boolean

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240208085121.2430-1-a@bayrepo.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


