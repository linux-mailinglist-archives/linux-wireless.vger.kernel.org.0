Return-Path: <linux-wireless+bounces-1667-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F792829CCC
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jan 2024 15:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2908286D97
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jan 2024 14:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377644A992;
	Wed, 10 Jan 2024 14:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmPglFP/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E37F495D2
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jan 2024 14:50:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD38AC433F1;
	Wed, 10 Jan 2024 14:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704898238;
	bh=2yWtWpAZQO43aaUDgG54/fcYTlBHQb2cUKvrV1Kaijo=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=YmPglFP/d/PXraFgv/LwE1lsAqFKPI8TXZpgVkH0y5QqcjW1rsS7+W7cAAFzZLjVK
	 4MZtHhGNNFR6dJ5s+Gw/OqGoig35bOlhJj9OQq/6ZBoaI8SEjcFBnagjVlkmyqnuD5
	 8DfnE3X6fV3YQtQDha8I3mhBb1Jit2G4f1pS6jXFL3JmawwFHKUhVGOmcrktrDJe8h
	 yvckcRyMAvgjGnnJy2TvAR0aa813iu3X53FIfvAh+TuY+GDoXSJirrA3lyBfyivMLI
	 Owcg0TN8H5rZNBdGzeplY8kA6XBlU1fjjXQ+EO3d73yenwjBONe2EBZSqkWBsRwzsO
	 3vuywuNcdCNWQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: rtw89: 8852b: update TX power tables to R36
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240103014114.9558-1-pkshih@realtek.com>
References: <20240103014114.9558-1-pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170489823579.471554.10662808053978999696.kvalo@kernel.org>
Date: Wed, 10 Jan 2024 14:50:37 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> Update TX power tables to RF version R36. Mainly update configurations for
> Canada 5.9 GHz (U-NII 4) according to IC (Industry Canada) certification.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

2 patches applied to wireless-next.git, thanks.

ac770f07a93b wifi: rtw89: 8852b: update TX power tables to R36
e52fafea56b2 wifi: rtw89: 8851b: update TX power tables to R37

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240103014114.9558-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


