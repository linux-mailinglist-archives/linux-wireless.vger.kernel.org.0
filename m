Return-Path: <linux-wireless+bounces-15833-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFB89E074A
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Dec 2024 16:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C60FD176933
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Dec 2024 15:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D51207A3A;
	Mon,  2 Dec 2024 15:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QqFrSiK/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02F0207A32;
	Mon,  2 Dec 2024 15:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733153197; cv=none; b=Z1mpy8Em+yF+HmQi4cFHjlVfB4LJ6qhcgma1jgOm+EsF2fSnRHqbuRR5+Tfek2tTpw2aAxpeHrJ894AyHGwMpBt7yNlZS82/kmiJ3cjHPjNa6tFibDIHDMu01VIrlN+W/iDmypLJlwAdYDzQgxeaXVsuep7CSiEkAyHa5L2fpH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733153197; c=relaxed/simple;
	bh=NwxnFREJr8HV5KAuytk/qazMVDop3UzcP3X/Va9naog=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=GSPx2azUbWHp/RvvSI9t4FNpLknidp8pHmCUJW19gsIb9E64OuIxFtPAjujc5zUbRxkDm2JZ8sc5HAorVciiupC3iVTdq6xF32XsGd3AbFjVcK1mhwvr2I96QkaHmoTuC5mQYxfPqdnxwqj74s2HSrekFw+caZ3bCFYsy2fjTKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QqFrSiK/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 978E7C4CED1;
	Mon,  2 Dec 2024 15:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733153197;
	bh=NwxnFREJr8HV5KAuytk/qazMVDop3UzcP3X/Va9naog=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=QqFrSiK/8/3tb1df3S8HfoV8rTQD9R8mw/8TltDQLSVWNM7PhGLK8DLBDakQt/aSD
	 jD18kxqkoUO2Z3TCunPjN6qDYRqI50zJoOESRcob/VpdzSEvRWt7NNHNd2y0WJA9u1
	 IvFCo2Nc75+o0XxrA11LBElX+ln2TCi1XOX1yWFzMbp+kaJz3ZUiQ9hNUMwsGoNGzh
	 lX2F0ZSMfzbFlTOiCzkPyh1Z5sLD7y62VIcPEj6EGUgIJuL1kzG7LoWDYG1NJCwQ70
	 CsuREKEdZ+l/g8Zeto7QQ6/n0BxA1G9bK9k9QM+rEwNPp1LSATNVpSGdOaMynV1uDJ
	 Zu5n/fThMbMJA==
From: Kalle Valo <kvalo@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Brian Norris <briannorris@chromium.org>,  Francesco Dolcini
 <francesco@dolcini.it>,  linux-wireless@vger.kernel.org,
  linux-kernel@vger.kernel.org,  David Lin <yu-hao.lin@nxp.com>,
  kernel@pengutronix.de,  Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v3 00/12] mwifiex: two fixes and cleanup
References: <20241202-mwifiex-cleanup-1-v3-0-317a6ce0dd5b@pengutronix.de>
Date: Mon, 02 Dec 2024 17:26:33 +0200
In-Reply-To: <20241202-mwifiex-cleanup-1-v3-0-317a6ce0dd5b@pengutronix.de>
	(Sascha Hauer's message of "Mon, 02 Dec 2024 13:57:59 +0100")
Message-ID: <87ldwyumvq.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sascha Hauer <s.hauer@pengutronix.de> writes:

> These are a few patches broken out from [1]. Kalle requested to limit
> the number of patches per series to approximately 12 and Francesco to
> move the fixes to the front of the series, so here we go.
>
> First two patches are fixes. First one is for host mlme support which
> currently is in wireless-next, so no stable tag needed, second one has a
> stable tag.

Are you sure? Apparently we didn't take any patches to wireless-next
during this merge window (ie. last two weeks), so everything which is in
wireless-next should be in v6.13-rc1, unless I'm missing something of
course. Not a problem for me but wanted to point out anyway.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

