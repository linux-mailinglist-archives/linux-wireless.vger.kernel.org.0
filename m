Return-Path: <linux-wireless+bounces-13024-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC7A97CC9D
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 18:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47026283EE2
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 16:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AE719F473;
	Thu, 19 Sep 2024 16:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3EH6Elb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE52199FC2;
	Thu, 19 Sep 2024 16:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726764382; cv=none; b=Fymz3sHtS1JsXkKrwVDJhLZn2QO7aVrivpLYtqAcG3phbSIwXJeQqdWwUMgAgpMxFGLHQIdS7lh87mbjbwo9Vn/gaaytRiLrBnOv/DbmGe5V/0pP2CgbYMjPHhlf9XuPpaSS+pQMBnShOmPTTsDqKT0l3kxHvrhjLyiwtiwfSso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726764382; c=relaxed/simple;
	bh=Vuv8FLFA9PwbWOnTvAxXu6BnGw5oinSe1553u2C8Ysw=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=KQIJcQe6Ritb0P15Sb6Q0x7toYu2Ai9RNXoogfDntjEEOH7981k8Y6vevu6T/hxxaWAHg1DwxQoi9KS5yQkdNGDS61+ioRH2CmuT0DPm8iUNJz0VGEihDBEBNwZkRQSOn1BZwQ1KsiX4K/465dFiHTn2ofddyL6C9qV6CKoF0CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3EH6Elb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9964C4CEC4;
	Thu, 19 Sep 2024 16:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726764382;
	bh=Vuv8FLFA9PwbWOnTvAxXu6BnGw5oinSe1553u2C8Ysw=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=f3EH6ElbaZu2o1Wsv/PHru5l/55w7fG6L8NBWBWAnETFMMb1AnL3YE8OSpGg64FEP
	 JBZG+Lb4VnlGJe92DmsECuUY4K8e5k6A/Qwxr3rnUGJhQfOMHyQ79Rrwarp7j5lK6X
	 8nM8yVVtD8I39XDLy7qYpQWNGjh7Z3qT0MGguwv3ZyAtONsazVrGlFvrkuYZXQD6ze
	 JFI9GUOdka2DNnKYhkYcOVrBsyHx5iv0xTEsNT7TieNxoD4Mttbgrwhn90ygrD8F6X
	 8VAjhe9AmpEpjPslLNU53Zi0L565Jys/WmOVcZnuzkZH0yKV0z7T2R3JfenC4u/tWm
	 HqKPZy0gkfTVw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: modify null check logic in
 ath11k_ce_rx_post_pipe()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240909150824.28195-1-m.lobanov@rosalinux.ru>
References: <20240909150824.28195-1-m.lobanov@rosalinux.ru>
To: Mikhail Lobanov <m.lobanov@rosalinux.ru>
Cc: Mikhail Lobanov <m.lobanov@rosalinux.ru>,
 Jeff Johnson <jjohnson@kernel.org>,
 Govindaraj Saminathan <quic_gsamin@quicinc.com>,
 Miles Hu <milehu@codeaurora.org>, Sven Eckelmann <seckelmann@datto.com>,
 Rajkumar Manoharan <rmanohar@codeaurora.org>,
 John Crispin <john@phrozen.org>, linux-wireless@vger.kernel.org,
 ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172676437762.281449.1201751345434084726.kvalo@kernel.org>
Date: Thu, 19 Sep 2024 16:46:19 +0000 (UTC)

Mikhail Lobanov <m.lobanov@rosalinux.ru> wrote:

> The previous logic in ath11k_ce_rx_post_pipe() incorrectly required both 
> dest_ring and status_ring to be NULL in order to exit the function. 
> This caused the function to continue even if only one of the pointers 
> was NULL, potentially leading to null pointer dereferences in 
> ath11k_ce_rx_buf_enqueue_pipe().
> 
> Fix the condition by modifying the logic so that the function returns 
> early if either dest_ring or status_ring is NULL.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Signed-off-by: Mikhail Lobanov <m.lobanov@rosalinux.ru>

Jeff, what do you think?

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240909150824.28195-1-m.lobanov@rosalinux.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html


