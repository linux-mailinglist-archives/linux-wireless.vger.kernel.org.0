Return-Path: <linux-wireless+bounces-4729-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8510B87B93E
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 09:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B1D41F2190B
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 08:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560215D488;
	Thu, 14 Mar 2024 08:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SO+NkM49"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312052A1DB
	for <linux-wireless@vger.kernel.org>; Thu, 14 Mar 2024 08:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710404812; cv=none; b=uwyc9e2pGQmgiKJIc04VZU2pfZbP5e+bkDOBwIygULpDsgNTAb7379YL00fiZdwikep+rLktwK2WBlJIdu6nWO0/ZpKfhaUIa013e8eYkS+o6BxsUQSWiQSYPKOGXk8ATA+wmeePAPIEHCCNo76wuD9vcuRDXKAfovYXDBtTwG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710404812; c=relaxed/simple;
	bh=NMPqL6Zqr7EmaMd5aQN8KKo00e/2uFnDS1/sLs6HIFM=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=RZV1jqyWZkGsrYA8yWw3WKFCKaOyypHyTdo/qawfUcdYAPNwLpDK3Vmamu/QzzoUKwTlphmOe/YsGx0vvl+1VjeFLpe0VAE6eIwo2bGETb7Qh1QOeaW8hyvuZseBGooF6TUsS+Cnp76X8VZ1d4c/Ml7UVqPxD/D6/jFP+09TnpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SO+NkM49; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6857C433F1;
	Thu, 14 Mar 2024 08:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710404811;
	bh=NMPqL6Zqr7EmaMd5aQN8KKo00e/2uFnDS1/sLs6HIFM=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=SO+NkM49NvYcmApsyff7X79OFT0F5pbkIlM3Tdqekv7acH/MvNljZkRACZLAMyP7Y
	 RV7U0xRu/0/lVqIve8Trhj78bAub6h17ANyvwuwpg8LRIfpzefN8fIaJ97G+FnIWtb
	 2wU3y7BAU9PTiD18KOLaFjmZ5vpl9BBEYG5XsOTYGZTfftd6x+iyPnxbcI7c3MqxWs
	 M+03+TlslN4mS0yJkfSwLx31fRkzAM3hXQkTtPOC0OD0fCU+JIpSt9OCOtD800KZmk
	 1GX+2EfyfjVjmh1uFx2gF58Ash4MhYU5wu/ZUPuowbKPZ8juwizQ1bmkhIZL32sgqV
	 Xajiji+g0iZMQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [wireless] wifi: rtw89: coex: fix configuration for shared
 antenna for 8922A
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240309001348.9906-1-pkshih@realtek.com>
References: <20240309001348.9906-1-pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <ku920601@realtek.com>, <kuba@kernel.org>,
 <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171040480864.2330768.13987992906518213166.kvalo@kernel.org>
Date: Thu, 14 Mar 2024 08:26:50 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> WiFi 2x2 + BT combo cards can be two or three physical antenna. For two
> antenna case, one antenna is shared by WiFi and BT, and different
> configuration should be applied. Fix the typo.
> 
> This problem was found by Coccicheck, and actually that is a typo instead:
> 
>   rtw8922a.c:2235:2-4: WARNING: possible condition with no effect (if == else)
> 
> Fixes: 652c9642eda6 ("wifi: rtw89: coex: add init_info H2C command format version 7")
> Closes: https://lore.kernel.org/linux-wireless/20240308074539.04512f66@kernel.org/
> Cc: Ching-Te Ku <ku920601@realtek.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless.git, thanks.

cec60af1972d wifi: rtw89: coex: fix configuration for shared antenna for 8922A

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240309001348.9906-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


