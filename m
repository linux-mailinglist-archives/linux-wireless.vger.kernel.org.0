Return-Path: <linux-wireless+bounces-9617-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52702918A5B
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 19:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82CE71C2303D
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 17:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F4718FDDC;
	Wed, 26 Jun 2024 17:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqzX41GB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA83DF4D;
	Wed, 26 Jun 2024 17:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719424269; cv=none; b=B/2rOjD/cba0UWLit6kogySNfqqcvi6E6KKVGxC+8fOM0/ttoYYFn08UBpbKz/FQ0Yge3aAgNbt3Pp7+msN90Tt7vL4i3ZfvbK9CPQILReqS5X2ILXoeNByRPTlWCI1JrQTb0I1bBQBWftv4fbawM5s/g+gzoN5+Bu6gZOhr5kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719424269; c=relaxed/simple;
	bh=BuB5f/WIjNkWKIwNho1ORa+GAyRZEfVzTlct7bgAQbM=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=rcBkf2mZdeCE/Y5DaaaG9HmmCczDPtV8LbsC+0awfR7Eh1V8GNauegehe5NBTk2GPKg7J7tGFQ/wzg23Q8WDQNv5qhWoZouf94aNPraFkCUbpwvvFoThMA9Luwhns4QzqW6bRjK722UPTgGVgKGJw3X47yMtjozukuiKft9TpkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqzX41GB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 954B9C116B1;
	Wed, 26 Jun 2024 17:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719424269;
	bh=BuB5f/WIjNkWKIwNho1ORa+GAyRZEfVzTlct7bgAQbM=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=IqzX41GBr5d6BkVSgJiiObkf3eLJHfSQepLGWXgWrjHrm/p1loaFEiXWG2YmbmDwz
	 CPqHzKuJBDlxio4IHAol0HaqLNLhYSv3fiGMAf83ZfiLudRN75gOPYefvL+8+ydlkH
	 FH/LF/l0IeNM3VUJskYARadc5yaN1EjP50Gdq3pPr+A0mX63x+A6T71EyCdYc98Zg9
	 jSSJBwWX8Zm7JgNIfRNwawfKtSYEf6O++B7JboiAeNoWsnYYFN7lSOIauOyiE4zzrD
	 n6kTrFt+ZTGSBBzNo03aO6RQU8Oaahp5q2MOEGnaTvFWJQhInR5XW9PDoqj8XnAABl
	 mH8b5gTA+5nQA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: brcmfmac: of: Support interrupts-extended
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240622215416.659208-1-knaerzche@gmail.com>
References: <20240622215416.659208-1-knaerzche@gmail.com>
To: Alex Bee <knaerzche@gmail.com>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
 linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org,
 Alex Bee <knaerzche@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171942426602.1834296.6787796603105003484.kvalo@kernel.org>
Date: Wed, 26 Jun 2024 17:51:07 +0000 (UTC)

Alex Bee <knaerzche@gmail.com> wrote:

> The currently existing of_property_present check for interrupts does not
> cover all ways interrupts can be defined in a device tree, e.g.
> "interrupts-extended".
> 
> In order to support all current and future ways that can be done, drop that
> check and call of_irq_parse_one to figure out if an interrupt is defined
> and irq_create_of_mapping for the actual mapping and let it be handled by
> the interrupt subsystem.
> 
> Signed-off-by: Alex Bee <knaerzche@gmail.com>
> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Patch applied to wireless-next.git, thanks.

f3f942d6e588 wifi: brcmfmac: of: Support interrupts-extended

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240622215416.659208-1-knaerzche@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


