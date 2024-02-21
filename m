Return-Path: <linux-wireless+bounces-3881-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD8B85E6C8
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 19:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F98E1C25248
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 18:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4AA85642;
	Wed, 21 Feb 2024 18:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1qWlOmM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783A385628
	for <linux-wireless@vger.kernel.org>; Wed, 21 Feb 2024 18:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708541759; cv=none; b=owWLvQ5nDXKZqQHsVQNn5ccQItSWRmm0nNWgfvEOYm4rPi9GNs9SEYIKTXfm2JgkMpMkIKCN6kEv2jly+3lVYP1rtyUjI2rZI1fQxoA4fSpm0JgA887mDxRAtUK4Up2Vy9TLFtZZ1BST1uiWRyifagvCWt8vlmsvbSd8l3+QWdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708541759; c=relaxed/simple;
	bh=ULOSVrAoDBAPPFICGwRJfwCBY7H7dZeBb1SpHOgGcrE=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=qkugj6NgRiaR6MN/vqRocddc7Jb4dm6JgAmW15xdI2QER+mWX6BcLcT96pOg1GN9WsbQ5WnCK/OClrVLraal40i1oFBwCIKqJt4p643WSAXP6Evod9ufbbYFJZ8RH5wrLIQxhxMbQx15Qjqa97ssd5QybAt3hw+a3PfWlQUjLoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1qWlOmM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA0CC433C7;
	Wed, 21 Feb 2024 18:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708541759;
	bh=ULOSVrAoDBAPPFICGwRJfwCBY7H7dZeBb1SpHOgGcrE=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=F1qWlOmMX3i5pSKM8RaNrDAnoxnhc5QGAwcs1d0TkvQj6/3p5Vu93/0+vDGH+7PgF
	 ocA5bjSHfW1hMsH3GTarTI7TGp+LJwcr0l5YyMIVfKqxlu0TB2fabxB55P0EDZfT3X
	 QfddDytf5trMoQg0W2wHEoU5UXR4jgYqDTDWNPOFsBPUBZCJuOM2eGpRDkx+H+D6jo
	 V1++3wOqTAVZaBNK8gqu9MmepPtKh2+Lv45ScdRSKbA8bvWie99WMESjR2LDt8hUqu
	 ZxKdqWdQLuuY1D6brrQDrafoTencn2slcxpggw+AoQm+/1sTdUPKIhFAA+bGPlb+JK
	 izHLXyPW9uscQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtlwifi: set initial values for unexpected cases of
 USB
 endpoint priority
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240216033949.34765-1-pkshih@realtek.com>
References: <20240216033949.34765-1-pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170854175641.1918455.1895081784487885318.kvalo@kernel.org>
Date: Wed, 21 Feb 2024 18:55:58 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Map USB endpoints to hardware and AC queues according to number of USB
> endpoints. However, original only give a warning for unexpected cases but
> initial values are not given. Then, smatch warns:
> 
> drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c:642
>   _rtl92cu_init_chipn_two_out_ep_priority() error: uninitialized symbol 'valuelow'.
> drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c:644
>   _rtl92cu_init_chipn_two_out_ep_priority() error: uninitialized symbol 'valuehi'.
> drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c:649
>   _rtl92cu_init_chipn_two_out_ep_priority() error: uninitialized symbol 'valuehi'.
> drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c:650
>   _rtl92cu_init_chipn_two_out_ep_priority() error: uninitialized symbol 'valuelow'.
> 
> The regular selection is high and low queues, so move default (unexpected)
> case along with that.
> 
> Compile tested only.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

9208e85c6272 wifi: rtlwifi: set initial values for unexpected cases of USB endpoint priority

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240216033949.34765-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


