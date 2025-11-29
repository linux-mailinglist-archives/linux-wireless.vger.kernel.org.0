Return-Path: <linux-wireless+bounces-29428-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2467AC945B3
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Nov 2025 18:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEBB03A739C
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Nov 2025 17:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFBF30F80A;
	Sat, 29 Nov 2025 17:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5+YXBlB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DD7272810;
	Sat, 29 Nov 2025 17:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764437617; cv=none; b=ad5pnK5OsWaATc8s66YAtfeJvGVeV7/7REjmhHppJFaW3bUJvnEny+akjNG7JrXUva3PQxjhFMTZ0mHikwV7PLQ+KObX3F2nrbWVp+ydLUR+dEmHx1GfKmdBPs4unaWy3m6rNZChC9LkdRuULQ/yu2LEcggHZ1Vpx20s1ITNKQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764437617; c=relaxed/simple;
	bh=5rPP/osNRT4onpFbFnCI2wVrPYYIh1TjXpEtR0BwbDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WmXwL50eaFw6D7YA4RC/6INIIOcEUQapPRETS2p1xjp7ydtRt+xDPYfuqOfLer+XFPDfy13+K+Hw6/apEwaHxk9J7rriGqOnu2PrcRnbu77m5zgWvJpWcqbj6V3QX9rREU4CytMhao2aoQ6woBFXgFxJ0M+D1y1lIJEcPSFGrTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5+YXBlB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87103C4CEF7;
	Sat, 29 Nov 2025 17:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764437616;
	bh=5rPP/osNRT4onpFbFnCI2wVrPYYIh1TjXpEtR0BwbDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O5+YXBlBMyV5jwPgTPCnSr9TmYPJdvsBI5J5TiYVZa6nlOSo7fAOqm46i8JGXF/eT
	 p1Ryaxs1hR/k8moXqZyE1Uoh7nM6K/j+zjyPRE3APAC38oLN2WNtolkFNoCeRn4dOd
	 eebkW7ALJvZVqhT6iSrG9OLH5ceQbtbvshMmwEdOucGk/zouKOge5kPpf3P1SSzHKm
	 d4kTaHq0geXDFYNTvkh76McQDj9WiReWthcsMoyDLQ7bBd3NTRKXIJAhVC77Yiuoz6
	 nnFxrS/HSCHmJL0IHvfU9BJty2UkKZQCwLPU8JlTlUPPPfkv8Qu7x51CN5vVERXbzK
	 ilTg4lwN+PJeQ==
Date: Sat, 29 Nov 2025 17:33:32 +0000
From: Simon Horman <horms@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
	Nick Kossifidis <mickflemm@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH net-next] ath5k: debug.h: fix enum ath5k_debug_level
 kernel-doc
Message-ID: <aSsubK4hHWvSWh2K@horms.kernel.org>
References: <20251128010401.546506-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128010401.546506-1-rdunlap@infradead.org>

On Thu, Nov 27, 2025 at 05:04:01PM -0800, Randy Dunlap wrote:
> Add a description for ATH5K_DEBUG_ANI and delete the descriptions for
> 3 undefined enum descriptions to prevent these warnings:
> 
> Warning: drivers/net/wireless/ath/ath5k/debug.h:111 Enum value
>  'ATH5K_DEBUG_ANI' not described in enum 'ath5k_debug_level'
> Warning: drivers/net/wireless/ath/ath5k/debug.h:111 Excess enum value
>  '%ATH5K_DEBUG_DUMP_RX' description in 'ath5k_debug_level'
> Warning: drivers/net/wireless/ath/ath5k/debug.h:111 Excess enum value
>  '%ATH5K_DEBUG_DUMP_TX' description in 'ath5k_debug_level'
> Warning: drivers/net/wireless/ath/ath5k/debug.h:111 Excess enum value
>  '%ATH5K_DEBUG_TRACE' description in 'ath5k_debug_level'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Reviewed-by: Simon Horman <horms@kernel.org>


