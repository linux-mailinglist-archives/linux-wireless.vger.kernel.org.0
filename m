Return-Path: <linux-wireless+bounces-843-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B09814C35
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Dec 2023 16:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03EFB280C4E
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Dec 2023 15:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6573A8EB;
	Fri, 15 Dec 2023 15:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRnyJeQ0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6F03A8E9
	for <linux-wireless@vger.kernel.org>; Fri, 15 Dec 2023 15:59:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF6EC433C8;
	Fri, 15 Dec 2023 15:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702655943;
	bh=GhGX6p5fY5yn/kiJvEGNAHpMjIe44xbBAOgiPpDCRdg=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=TRnyJeQ0lT7YobcnukUhEnB5maG3BUEl8ROLNCmhuEGPHTP0E3/a6vY3wSUffKwd6
	 m3WNlSDnpwS0CLENNjWbWK2kDWfkE0OoAeZEH0TvNGg04h4IdBkkCZGkafehIkXeDn
	 OTmjs7hDJ8xNugW4rMDwDj29EFJlcNb48N4m2p0H51CaFUZ9MFmi+6LeqHJoP74VYo
	 NT9vL3z/FT0+5kf/CXE0KdSoDNKgY1UyCLgH27jLh1gXbNkRUzyN+JHkzaMGHpa7p7
	 IeQonlmKKvWpoCRBanB7MMm+bitAMaCYH93RViT3aHvM2phb0wAjvOTO85STEfuJbm
	 0ZcOvYLwcwVuA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: workaround too long expansion sparse
 warnings
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231214161740.1582340-1-kvalo@kernel.org>
References: <20231214161740.1582340-1-kvalo@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170265593947.1834402.14524206742930296560.kvalo@kernel.org>
Date: Fri, 15 Dec 2023 15:59:02 +0000 (UTC)

Kalle Valo <kvalo@kernel.org> wrote:

> In v6.7-rc1 sparse warns:
> 
> drivers/net/wireless/ath/ath11k/mac.c:4702:15: error: too long token expansion
> drivers/net/wireless/ath/ath11k/mac.c:4702:15: error: too long token expansion
> drivers/net/wireless/ath/ath11k/mac.c:8393:23: error: too long token expansion
> drivers/net/wireless/ath/ath11k/mac.c:8393:23: error: too long token expansion
> 
> Workaround the warnings by refactoring the code to a new function, which also
> reduces code duplication. And in the new function use max3() to make the code
> more readable.
> 
> No functional changes, compile tested only.
> 
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

fd6ed1772b2c wifi: ath11k: workaround too long expansion sparse warnings

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231214161740.1582340-1-kvalo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


