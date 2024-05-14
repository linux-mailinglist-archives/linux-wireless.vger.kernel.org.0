Return-Path: <linux-wireless+bounces-7640-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C498C5735
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 15:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39F472848BD
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 13:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBB7144D0E;
	Tue, 14 May 2024 13:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgBjSd2o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72B114430A;
	Tue, 14 May 2024 13:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715693072; cv=none; b=iuFchRqlf+0GJnz0rxF/3rfrZUYgr3twiF1q8Gl3omNMWoNKNoQxlBGeNYiE3qQR4LczTyoQyuYRCK85bOJMYOGPvzeFR+oNnTV9/OWtohhw/dloiuHoe4C3COlZNYqZ0cxNjaXgp607sFWg2it+e31d25S4IEIZ8NTvHNY18kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715693072; c=relaxed/simple;
	bh=EbXUyLPzVf2Qs04ZBeB7sglb2l63aesvqV1ukVQsRgk=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=tujQVS+LMEdhuv6sghLQKH/NgtMBPc88JSI3+OejKUnzPEGWoGPgFkLlwzuJ/LsZR/1MixCYkfBqrs18oRdsVnZwunnWveXFCgPrmF7iS9Zudyh6Lei1UpNgGejOt5zfOS6BLCwbNC/r4OCg/Kp5BsKJAhFnhr07meIR0X32dQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgBjSd2o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92279C2BD10;
	Tue, 14 May 2024 13:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715693071;
	bh=EbXUyLPzVf2Qs04ZBeB7sglb2l63aesvqV1ukVQsRgk=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=qgBjSd2oEvIkfEN62NOmnXs5vsBqCuQ2xJ6Xu3fuP7dWWKq0qWTG7FXVqF3IBn9OF
	 hpNLxSa32lBaGjwQga6rIv4NNpEqYe18r6T90HY2BROs55HoxrQEKr0VGvMssbHO1A
	 ZDFJ3KXm1aFRPDqjaiY4+l8cFVxdmTLj/jbbpvt2KElnGJi+flEVzjE8QzZm8W/PtD
	 BDjhcZaUWQeMEh97Ra2lzWj6+YXiuMRcxQB6I2sIMlCoZYOp4GjPWDxZJQ1zQZwVHq
	 U6W7tste388hEaYkYOs+/xufyEd4eyT/LVqMnlvsNius3agawYdD1HCfYUuM+2bQk1
	 hMYD7kYjaHlxA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH wireless-next] ath11k: Fix error path in
 ath11k_pcic_ext_irq_config
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240508185902.70975-1-leitao@debian.org>
References: <20240508185902.70975-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: horms@kernel.org, Jeff Johnson <jjohnson@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org (open list:NETWORKING DRIVERS (WIRELESS)),
 ath11k@lists.infradead.org (open list:QUALCOMM ATHEROS ATH11K WIRELESS
 DRIVER), linux-kernel@vger.kernel.org (open list)
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171569306687.2017278.16792087877494747045.kvalo@kernel.org>
Date: Tue, 14 May 2024 13:24:28 +0000 (UTC)

Breno Leitao <leitao@debian.org> wrote:

> If one of the dummy allocation fails in ath11k_pcic_ext_irq_config(),
> the previous allocated devices might leak due to returning without
> deallocating the devices.
> 
> Instead of returning on the error path, deallocate all the previously
> allocated net_devices and then return.
> 
> Fixes: bca592ead825 ("wifi: ath11k: allocate dummy net_device dynamically")
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Simon Horman <horms@kernel.org>

As commit bca592ead825 is in net-next I think this patch needs to go to v6.10, right?

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240508185902.70975-1-leitao@debian.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


