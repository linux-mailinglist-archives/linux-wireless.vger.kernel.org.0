Return-Path: <linux-wireless+bounces-18078-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24345A21088
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 19:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EE763A27EF
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 18:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3511DE4CE;
	Tue, 28 Jan 2025 18:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDjCk15m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E931C5F1D;
	Tue, 28 Jan 2025 18:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738087975; cv=none; b=f6f/G1FbY1FnX2g3E99ZTLajhfxU0OCj/P5ownp0L63JCe6Pn02mcU3Qw0SoVgKJoHlJypm67iS3mbXLQkAIy2MdjH+AdOnMZCKWjzjJdr1uLlpVErZSfeeW0+zEo9INXnRwMeIiZxnwhfRwfrRr9qtbgrpNmoPWU4cOmfR2XF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738087975; c=relaxed/simple;
	bh=95lk6YfqqRVVR/aa6V0QOhf1oGZBK2E+oCT4l1g0Caw=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=ZvLXPJHV5sY4VZJJ7KLa9UhYY1DOXgBZwFWepd1suyxKMglmAgOzA+bY1x9IpPXk6gECUrXXDSqcYmLqC0aJt49whLb1YDsxlu375JdiTQqS3f/wVbOAVBs0V0BEtEDa2J3c1zUr7ibZkW65DYnWnBKEF67vpHcLUmjK80qTT88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDjCk15m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA39C4CEE1;
	Tue, 28 Jan 2025 18:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738087974;
	bh=95lk6YfqqRVVR/aa6V0QOhf1oGZBK2E+oCT4l1g0Caw=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=fDjCk15mjWJ8g4sNs/1T6Ik/doH48kqvRlt1wENNFhK8BccNAiGkJzXUEPDHXFaHl
	 qDWb0UHG1IiqPJ+r1LnVZOyLEzNgfjG/Aw8Iq++T4beejZw3bWWuuHp0xsDzruuASO
	 JL9cCVVdHXDK+WyniXK6mwwumxlWvmNIMd+X4pJdSPCRxIL0kzOE/EtLyg96fJk/WS
	 05TC8dnkBTpefM+IMaoJ2NuwkDg336h0PMgF3iWSxQuOJp7JtRD0ftvpWr8ErHHc5F
	 EcsSs/+0IBz21qBal+bhySPH9q5AyMdFdHnMUnshfSZ9aQbECNR5OZneYmjidOeWe0
	 hR4aAHXKAiOaw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: mwifiex: Constify struct mwifiex_if_ops
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: 
 <03d524b72f20a0302e4de5e0ebdc20ab69469dec.1737308889.git.christophe.jaillet@wanadoo.fr>
References: 
 <03d524b72f20a0302e4de5e0ebdc20ab69469dec.1737308889.git.christophe.jaillet@wanadoo.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Brian Norris <briannorris@chromium.org>,
 Francesco Dolcini <francesco@dolcini.it>, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <173808797082.1254064.16676111572438788530.kvalo@kernel.org>
Date: Tue, 28 Jan 2025 18:12:52 +0000 (UTC)

Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> 'struct mwifiex_if_ops' are not modified in these drivers.
> 
> Constifying these structures moves some data to a read-only section, so
> increase overall security, especially when the structure holds some
> function pointers.
> 
> On a x86_64, with allmodconfig, as an example:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>   61439	   4367	     32	  65838	  1012e	drivers/net/wireless/marvell/mwifiex/pcie.o
> 
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>   61699	   4127	     32	  65858	  10142	drivers/net/wireless/marvell/mwifiex/pcie.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Patch applied to wireless-next.git, thanks.

e50e30fa966e wifi: mwifiex: Constify struct mwifiex_if_ops

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/03d524b72f20a0302e4de5e0ebdc20ab69469dec.1737308889.git.christophe.jaillet@wanadoo.fr/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


