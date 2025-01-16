Return-Path: <linux-wireless+bounces-17596-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE3AA138C6
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 12:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED04018812D7
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 11:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DCC1D79A9;
	Thu, 16 Jan 2025 11:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdoA0kVO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9D61A0BF3
	for <linux-wireless@vger.kernel.org>; Thu, 16 Jan 2025 11:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737026368; cv=none; b=qDHOJ4Ywb+KljFrjO4nvDWvZbwXE9pPSSRh/qUWSWotpYp1nQBUxip9lm4a/ylU6ErI90vLp+llzD30kBGxqY75QKN3sR91+WZ5p6N3AIHgO2k8FkcqnFELXgeDemtNhADgUx5iIlcnoonu8cYL32JSs3hAL/E9N9HCg/zopVHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737026368; c=relaxed/simple;
	bh=4j2SySHk3aVtQzs9NyYvQH+p1sjwQc3KJjTJCIYSSus=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=cqBGVGaPq2Xz0coGQuWEAp/bBz7bgOQ18Yy6BiR+s0zETfe2K+4gwAchFgcyaEjut0hKeyBu91ry0fr8w9Cqbr2izMarl8l4FG5bQsDaCYERxQd4n6j3ank33BeyqaxjhJZP1woZNXUX5UGMq1uw7rMGiSecw2l04h2peO4RGdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdoA0kVO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 334A3C4CED6;
	Thu, 16 Jan 2025 11:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737026365;
	bh=4j2SySHk3aVtQzs9NyYvQH+p1sjwQc3KJjTJCIYSSus=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=OdoA0kVOY/UcmdoX+FXmGtriXiFLj6P1cQw1PCPAOHBS8tfGcrzDeBbADhInpiWoY
	 Qq8blEfZ5dkzaArC2tEJ/yD9InOoOirsZ3hqkIVekzCOgv4C+pAagI6any3SKtQg3q
	 wu1KKilxJYqu9rMqnEdbPAOXkB/I1G8uwaza2dxygZspqY5qeYpA9Mf+Spj+CX64TA
	 J7E90tVLPukMLJRDaqm7Tu7Bp/Ca5oiNn/CyjMf30rg2+5bY0FZ0okJapL2hs+RVxt
	 IGugFfXrhRANCIdfxXeNU0TeJD/ElRdczH59rdVXNeehYyKf1wmcb6bSPNbc86ZOL7
	 OH0dAjEYew0YQ==
From: Kalle Valo <kvalo@kernel.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
  linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/2] wifi: ath9k: cleanup struct ath_tx_control and
 ath_tx_prepare()
References: <20250115171750.259917-1-dmantipov@yandex.ru>
Date: Thu, 16 Jan 2025 13:19:23 +0200
In-Reply-To: <20250115171750.259917-1-dmantipov@yandex.ru> (Dmitry Antipov's
	message of "Wed, 15 Jan 2025 20:17:49 +0300")
Message-ID: <87y0zbm2f8.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dmitry Antipov <dmantipov@yandex.ru> writes:

> After switching to mac80211 software queues, pointer to 'struct ath_node'
> in 'struct ath_tx_control' is still assigned but not actually used. So drop
> it and cleanup related things in 'ath_tx_prepare()'. Compile tested only.
>
> Fixes: 50f08edf9809 ("ath9k: Switch to using mac80211 intermediate software queues.")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

I don't think cleanup patches should have a Fixes tag. This is not
fixing a user visible issue.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

