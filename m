Return-Path: <linux-wireless+bounces-14784-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 044F59B7CB1
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 15:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD3F4282AE4
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 14:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0681A286D;
	Thu, 31 Oct 2024 14:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KU7yXS9E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558011A265E
	for <linux-wireless@vger.kernel.org>; Thu, 31 Oct 2024 14:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730384438; cv=none; b=jT9+XMEhMgfn//jucmpJWC48rhnV54NCqSEExWuybKY+4aOpto7+hnVS/D06exjZHufGXhcM74BjO0Ec9b+I3AVvCnpMVAdvqeK4VqgY3g+8BbsqFfxk5ZBa3Pu4QRLD3ntYrgB8uNMrawz24hu44izqEVZaPbt4TdBOkrY+4rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730384438; c=relaxed/simple;
	bh=Vb9V4OKwM8pfdri9jhkPlPDeip2AFeT+GpgSLBpXj18=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=IC3OYB+APLhKS2tdWbocYj65t5zUeOLazQakX83K+LiJg8bHjJATVhKR3kf6lrfJ2EmQDWjNGnzx7jmmC3+2TrSvRy5Wd3bQgytxLuZk1C0oPuK0FJI5S4njQWwUvuZZOf5laB/FgOXVMc0fsLKjxzEFZPKkEkh7G8H3uMuPyEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KU7yXS9E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BCC2C4FF48;
	Thu, 31 Oct 2024 14:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730384438;
	bh=Vb9V4OKwM8pfdri9jhkPlPDeip2AFeT+GpgSLBpXj18=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=KU7yXS9E0aiwmSSu2uaEEHWiS0Az/H1rnny5NWLCbG6srMOOgw6kXr9qiU09fDz7X
	 eY/1DWR+mr+amkIEjI0+rj5XRUBzEh0yHLD/Ltf2jR6jma+egcuv8nDv0vOEfP4ck5
	 LXo5WPGe96FGWpdUAkg5qtHenvRpqeMOOTgBoUXmSnuXN6SeyTGGNWV47tup8tIzAD
	 6YdYU5Unah5EHI7uONC1L93buo9+PP6+/HOLaFjhLcMONNzcA7Cu/oFBYA3rQ74zBN
	 KKt6NGGgF/be0lBEBoo4jsjMGyqOba7vgvg7DSyOZcSsskqhWqqv3JkxIUB29+whPd
	 plXdcLSIeHRYw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: cw1200: Fix potential NULL dereference
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20241028-cw1200-fix-v1-1-e092b6558d1e@linaro.org>
References: <20241028-cw1200-fix-v1-1-e092b6558d1e@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-wireless@vger.kernel.org, kernel test robot <lkp@intel.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <173038443545.539202.17263172917828394635.kvalo@kernel.org>
Date: Thu, 31 Oct 2024 14:20:36 +0000 (UTC)

Linus Walleij <linus.walleij@linaro.org> wrote:

> A recent refactoring was identified by static analysis to
> cause a potential NULL dereference, fix this!
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202410121505.nyghqEkK-lkp@intel.com/
> Fixes: 2719a9e7156c ("wifi: cw1200: Convert to GPIO descriptors")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Patch applied to wireless-next.git, thanks.

2b94751626a6 wifi: cw1200: Fix potential NULL dereference

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20241028-cw1200-fix-v1-1-e092b6558d1e@linaro.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


