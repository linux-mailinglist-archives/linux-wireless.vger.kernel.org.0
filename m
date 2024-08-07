Return-Path: <linux-wireless+bounces-11098-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C236294AEB8
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 19:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2B8D1C21791
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 17:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF10D13B293;
	Wed,  7 Aug 2024 17:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uEBsi1kU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED2584DF1;
	Wed,  7 Aug 2024 17:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723050967; cv=none; b=u0YcKvYgTaAJqDElZBq1weejM06NyiWohrICWEHnaLNyUCrVMw/p/vK0n480yi1bd4XulEy90BJMQYSGm5aPMQ79BZFfZtT+tDIzl0XZW71nZABhaFeYb2AAA5m3eWhIZYocfquC+P8JochSCix9sfR6OCJhpj3dlTB11C+t00g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723050967; c=relaxed/simple;
	bh=cWKrncZt2zOBu3pqcDgz+fbft24xEjW2Qrp8Xkgbih4=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=hwjM8SfZXHV3Brsgai+w3nKMKAgD+zPvEeAuXWzg0o4THQEVIyJ4nrNOMeIMTyiNj7bdnK8TbuzW9BotQgu9MMRDEIfiPXKzhY1jmx8En9MgNaLaRBBFuAHVq5zw5x7hKeMUHD4Xpfjf5Z2BpwRKt8YskJ0BLlsn8HQ/p2cMLTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uEBsi1kU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2366C32781;
	Wed,  7 Aug 2024 17:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723050967;
	bh=cWKrncZt2zOBu3pqcDgz+fbft24xEjW2Qrp8Xkgbih4=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=uEBsi1kUEkLOHMxUAwcccwlQSuwVqLPph8vyaAgd+Sck0r8krGOabB5IJy0LDPjEw
	 Gz5SF8IShaoDkIXc9K1svCQJnjAy25Myk2CucOBS7AriRJlMjPNX1tUEflLzyMQZDW
	 dgj0Hp7u55PFvMWHOkmNHHmJmpPrpmUvMokZ63fbnveE0Gr1dy0q1RyykxcueM1Clo
	 a9ja5IdIgpYH1bbGvfXrKfWCCxdRaTOt0yqlXn+fevLkE2QcfUoGLr3ulRPCwZRy6g
	 qxNKJEiCgZdYSRNEYU8fmLgPlCKFfHrGceNVCqOqBQzJZ4uNPNKq/EeD8QzuneB3XY
	 LwO+W+IvGdzKA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] wifi: b43: Constify struct lpphy_tx_gain_table_entry
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: 
 <e33bc9e6dff4a5b6cd8d0ab5399aa1abac5bef9d.1722753127.git.christophe.jaillet@wanadoo.fr>
References: 
 <e33bc9e6dff4a5b6cd8d0ab5399aa1abac5bef9d.1722753127.git.christophe.jaillet@wanadoo.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172305096402.4000819.13600350959712094717.kvalo@kernel.org>
Date: Wed,  7 Aug 2024 17:16:05 +0000 (UTC)

Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> 'struct lpphy_tx_gain_table_entry' are not modified in this driver.
> 
> Constifying this structure moves some data to a read-only section, so
> increase overall security.
> 
> On a x86_64, with allmodconfig:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>   16481	   6232	      0	  22713	   58b9	drivers/net/wireless/broadcom/b43/tables_lpphy.o
> 
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>   22305	    395	      0	  22700	   58ac	drivers/net/wireless/broadcom/b43/tables_lpphy.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Acked-By: Michael Büsch <m@bues.ch>

Patch applied to wireless-next.git, thanks.

4ab9f870a633 wifi: b43: Constify struct lpphy_tx_gain_table_entry

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/e33bc9e6dff4a5b6cd8d0ab5399aa1abac5bef9d.1722753127.git.christophe.jaillet@wanadoo.fr/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


