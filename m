Return-Path: <linux-wireless+bounces-17594-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2BEA13888
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 12:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A0C21886917
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 11:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C114035968;
	Thu, 16 Jan 2025 11:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="MxVq6w1O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89B71DE4C1
	for <linux-wireless@vger.kernel.org>; Thu, 16 Jan 2025 11:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737025516; cv=none; b=tKWA1DGMWlguaWzPT70MJHbQn82Odktbu5NMC5yudQLXlxTkcMGFsVAL8qxIkioZv6AOAuJRwfv20mes46w1N0la9s4w7aFyiKNU9Ku7Qgw+E10S1DIEnjO1VF+UxYwjj0oa/8F2InZRvYcdXQpzVX/ZhG7Pw+jFRFRkIQ9F+8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737025516; c=relaxed/simple;
	bh=PY//Aa6Sp90TjgbWVntlu2cvxLNyYNh/uk3xLnavon0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cwIY6EReeBTgreasb9g9NT4t+ZXgurwbe2PApA5nQ1TGlc9ytESlXFcWt6D3+ZMNNrfFZ0sif0Ai508qjJr+QijPWsX8QqVyLX9ohWHt/LIPOSTZDz4vxFRH3CY63o+TJbCQL/K/jXLQTNBPRldA/JO+plnt4ymnOzbfWd8g8YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=MxVq6w1O; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1737025504; bh=PY//Aa6Sp90TjgbWVntlu2cvxLNyYNh/uk3xLnavon0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MxVq6w1OvE/z/H/xP2HN81ee7ZUiI4oum2wg3LdnaaBg+NUdSGUu8JL71YP3WlS80
	 TnQsDFKpfMSJLBW5bUWeE856pzbld6fVJMhaGy+23Z1L9nGwvdWSwZeX/XR9XqNTET
	 sA7w0VzAqRw3iuteVIGouM3IikTrGUuGSh8t3gDrvFPfipWuQmJJm+nCBsf1ua7vzo
	 b05H1/MYY6Nz8J4w5whzwDOvyJ5fXG3Gj48jSJPIdj4NLKueWWf9AoP0Il9qYLdN9V
	 TW8NtwD7WN9oeZFyGWHLPQumaDU7ljBamGCdABJXHAWxDnN5J5pxaHe0Un04cntvHC
	 /dAPWC2msLorQ==
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org, Dmitry
 Antipov <dmantipov@yandex.ru>
Subject: Re: [PATCH 1/2] wifi: ath9k: cleanup struct ath_tx_control and
 ath_tx_prepare()
In-Reply-To: <20250115171750.259917-1-dmantipov@yandex.ru>
References: <20250115171750.259917-1-dmantipov@yandex.ru>
Date: Thu, 16 Jan 2025 12:05:03 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87jzavow80.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dmitry Antipov <dmantipov@yandex.ru> writes:

> After switching to mac80211 software queues, pointer to 'struct ath_node'
> in 'struct ath_tx_control' is still assigned but not actually used. So dr=
op
> it and cleanup related things in 'ath_tx_prepare()'. Compile tested only.
>
> Fixes: 50f08edf9809 ("ath9k: Switch to using mac80211 intermediate softwa=
re queues.")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

