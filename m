Return-Path: <linux-wireless+bounces-11792-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDF295B130
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 11:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68F6A283E59
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 09:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8198F15920E;
	Thu, 22 Aug 2024 09:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqpL9Kqu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFEA15F41F
	for <linux-wireless@vger.kernel.org>; Thu, 22 Aug 2024 09:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724317725; cv=none; b=t88G34nnCl8G+pZMFIvES1gpkCn9umc2vahzwCqoLG8qrYtCZ5MaVvhX435JkyzArMe8/kkQPTF7nZQDZJT3fYCccg5YUVVVJFOi4W7A1LYQR99QEtRbLu07nscqWE+JCYPlMOg4wLcHa+AVdafsd6s7QhTHjmGgpnJyxtdnJCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724317725; c=relaxed/simple;
	bh=AqFOGvD4tvDhp8tHx360ZpKHK3ekeN/b9qDDa1hXzNk=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=W7aZ9PYi7e+kKUR+fI98fLx4AWIVOqpIHPPPlsADdA2fkZ8O7KlrHqHpwDMkbw3OJSJ/3aXxacUdpxfSwOZxAQzZUUzlTcG9d1tEkcKfXMTuKJCWPFrjJR/GZFgXDtJhwevTNeRizKtNMURYGTm5gSGhMh36b+fpQ2QwjdmPC7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqpL9Kqu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7BC8C4AF0C;
	Thu, 22 Aug 2024 09:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724317725;
	bh=AqFOGvD4tvDhp8tHx360ZpKHK3ekeN/b9qDDa1hXzNk=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=eqpL9KquTIDbASclP/aEzfo49SiKInReWguGbz+6DHkqJGZBWoKVZN0jUc129PDo0
	 yzKUzdmQe0h+MafIe6PVeRkZpkTgkEeQLmy/BKiWI+I7ZOC93OPqlf0We9uDL8LOzX
	 WHXhtmoj19SRWYnekTQ9XbOAryO8HWSuBQBMkbAfnQn3vkFq8hDSTaOGb/5EjwrAsk
	 lGrS8IWEzI2YgWPRCjg2ID7tcF2cgEfNJjBvd78Eu0jEWGolthXLG3hHnnBNCPddc7
	 rtD3IvulL2oKi4VUK3SVruE6HWOzmzXSEWzYQxUeRCN2LMZzZWS/fnLfftNKw92iIr
	 nSAyYBfbZpOQg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: MAINTAINERS: Add net-cw1200.h to NETWORKING DRIVERS (WIRELESS)
 section
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240816-wifi-mnt-v1-1-3fb3bf5d44aa@kernel.org>
References: <20240816-wifi-mnt-v1-1-3fb3bf5d44aa@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172431772309.2253380.3452086285097996947.kvalo@kernel.org>
Date: Thu, 22 Aug 2024 09:08:44 +0000 (UTC)

Simon Horman <horms@kernel.org> wrote:

> This is part of an effort [1] to assign a section in MAINTAINERS to header
> files that relate to Networking. In this case the files with "net" in
> their name.
> 
> [1] https://lore.kernel.org/netdev/20240816-net-mnt-v1-0-ef946b47ced4@kernel.org/
> 
> It seems that net-cw1200.h is included by CW1200 Wireless drivers, and
> thus that NETWORKING DRIVERS (WIRELESS) is the most relevant section for
> this file.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>

Why add it to the general wireless drivers entry? To me the cw1200 entry would be more logical:

CW1200 WLAN driver
S:	Orphan
F:	drivers/net/wireless/st/cw1200/

Please change the title to:

MAINTAINERS: wifi: cw1200: add net-cw1200.h

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240816-wifi-mnt-v1-1-3fb3bf5d44aa@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


