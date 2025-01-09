Return-Path: <linux-wireless+bounces-17240-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E23D3A07670
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 14:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E6B3188A5FB
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 13:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58490215F5F;
	Thu,  9 Jan 2025 13:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfrEku7Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B642010FD
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jan 2025 13:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736427904; cv=none; b=EamqBYyY4ZkoQL3ciTJb2HjmoUaHhLtQVamWnS7QT7ewIPrR+HSjlaR8WVySVqvGP3+GL6wI5X/2nHa2a0uEz3DafkQqC/MDlHenzGdJFlqEOz1xko+OAV8iRHH3X23YqVofp9eDoz0oKnPR0kZJZnAmDB2h58Yzv98WY2m99ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736427904; c=relaxed/simple;
	bh=nWmz63W1uAhpdYEaB77+TMv4CTNJnteVN4HUDYk5nZ8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=WVvJsigJjVupJUHgS8leavvesmZ+xOa3CyEMNPUlg/Vq2MMDHYLs5SI7DlyZw4XMoABxCCB47VVFTe1txG833jFtaGMJ0R1aSrcNx8fk5qLGVY3CAJCaXRVSt93kGOfc3R8sdVN9sP5vBwMEfsQ8Rpo6WaoldepcvKhQn6KjjoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfrEku7Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1845C4CED2;
	Thu,  9 Jan 2025 13:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736427903;
	bh=nWmz63W1uAhpdYEaB77+TMv4CTNJnteVN4HUDYk5nZ8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=OfrEku7Zpe3Ye5uB9yCX7USbrYiPRTdMgJEmagFPt7OhG+//bAUKoxBVN75YyneUH
	 FvcnbMntG7LXN3fMac8eBxbeDyqedlpNNy6NWwZlkFPhBQjwXPv5+iL/Qb9Fm1JwUa
	 CU2TfVzvarn4gZ0Kj4YPLqh++1r0Q7FhCBVK6SsKU8MiHJvIHZeZhqz0EhSxCP3r6i
	 B9zqOes8UbqUTC1dUcdH3ykm9GZJg2g+7xjZVmjmyNLNyjECa2qdLseHD6Omm+pZar
	 OcMl3M4URF/Enf8ov+/yuakGqob2jA+PRO3mBNVscfblek7HcPyDyaPx7OfaTdN2st
	 OSJg8+4nw87rw==
From: Kalle Valo <kvalo@kernel.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Jeff Johnson <jjohnson@kernel.org>,  ath10k@lists.infradead.org,
  linux-wireless@vger.kernel.org,  lvc-project@linuxtesting.org
Subject: Re: [PATCH] wifi: ath10k: perform buffer size check in
 ath10k_wow_convert_8023_to_80211()
References: <20241225124710.91238-1-dmantipov@yandex.ru>
Date: Thu, 09 Jan 2025 15:05:00 +0200
In-Reply-To: <20241225124710.91238-1-dmantipov@yandex.ru> (Dmitry Antipov's
	message of "Wed, 25 Dec 2024 15:47:10 +0300")
Message-ID: <87h668dtoj.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dmitry Antipov <dmantipov@yandex.ru> writes:

> Looking through the following:
>
> -> ath10k_vif_wow_set_wakeups()
>    -> ath10k_wow_convert_8023_to_80211()
>       ...
>       memcpy(..., ..., pattern_len);                    [1]
>       ...
>    <- ...
>    if (WARN_ON(...packet_len > WOW_MAX_PATTERN_SIZE))   [2]
>       ...
>
> I've found that [2] makes no sense after [1]. I.e. check for possible
> buffer overflow should be performed prior to touching both 'pattern' and
> 'mask' buffers with 'memcpy()' in 'ath10k_wow_convert_8023_to_80211()'.
> Compile tested only.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

This code path should be tested on a real device, can anyone help with
that?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

