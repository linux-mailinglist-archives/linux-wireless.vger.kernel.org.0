Return-Path: <linux-wireless+bounces-16078-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED009E9B04
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 16:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59C5B282A76
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 15:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F981369AA;
	Mon,  9 Dec 2024 15:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fg+oFQeO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064B2233139;
	Mon,  9 Dec 2024 15:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733759934; cv=none; b=rBfIBp27g4DEgiIVUFMgRVUJXyQAt8cd3Jjk4lN50Y6dxTm/IhmsJwSBKtoZJnmqGaG12ZRR/gLtxbr5j2D8SR+889lTXUT0t/W+6lrO0TE3zt+UP0ZrUMLyTKeZSq0xm/skEez0p0Y20rKVSXE0ZrzLUgDfq/lBQjQjEfxzzkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733759934; c=relaxed/simple;
	bh=OO/cbnYzf7FBnThMr5HyGBtVFD9nIjTXZEtzGzeppGE=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=H8sdoMoE9z/gkwkcFZX/XXutBYHiuHEambXs95QeRNKqYxYgN2JAYN0YJ6l6wOFRHF1RtnR/K6cqF9UFHmNpGQ/pLCUg/d3NMgDYN+aVi3jvsexwF+0Eo4TXO0DRrQ9kxKHkEO5BUHs9hiuacC66lQkFXBDAy7GeQ+3mM3CFxk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fg+oFQeO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4C6C4CED1;
	Mon,  9 Dec 2024 15:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733759932;
	bh=OO/cbnYzf7FBnThMr5HyGBtVFD9nIjTXZEtzGzeppGE=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=Fg+oFQeO2kxp5YwnqKCYMkxppM0DGUp3qVxQ5sA5nAhg3znZy/eC4jlBglaQcF/pD
	 1ek0X+lGA/sb+0yV86GarHhJ0//nhWl6/GeurMFilAnXgVNik5+axaVubjfJjqrBrn
	 86+D1UrJksk/A/x7WQkpy+hnh6fB3EM8+OelfkaB9ESisxtWQuZNPPWc8FbMqDy4kl
	 8JkRD4kzTEhYQqrCcC5V/LWtyFXz9lTa1eRABmGQQ0yimefBwGiWp9fLGT93pJHCyk
	 U2M6D7V794lB7TwBTexFvKiGyb5NKZYztjvbcbzPQRSGcT2/O8refdTkfvvj9cWQks
	 R1eAulDtuAE/Q==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: wlcore: testmode: Constify strutc nla_policy
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: 
 <78810e3ebb74ddbd3a4538f182bf1143b89baba7.1731332414.git.christophe.jaillet@wanadoo.fr>
References: 
 <78810e3ebb74ddbd3a4538f182bf1143b89baba7.1731332414.git.christophe.jaillet@wanadoo.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 linux-wireless@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <173375992872.157598.4366313738760552668.kvalo@kernel.org>
Date: Mon,  9 Dec 2024 15:58:50 +0000 (UTC)

Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> 'struct nla_policy' is not modified in this driver.
> 
> Constifying this structure moves some data to a read-only section, so
> increase overall security, especially when the structure holds some
> function pointers.
> 
> On a x86_64, with allmodconfig:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>    5062	    528	      0	   5590	   15d6	drivers/net/wireless/ti/wlcore/testmode.o
> 
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>    5178	    404	      0	   5582	   15ce	drivers/net/wireless/ti/wlcore/testmode.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Patch applied to wireless-next.git, thanks.

01e767d6f783 wifi: wlcore: testmode: Constify strutc nla_policy

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/78810e3ebb74ddbd3a4538f182bf1143b89baba7.1731332414.git.christophe.jaillet@wanadoo.fr/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


