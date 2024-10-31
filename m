Return-Path: <linux-wireless+bounces-14783-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A24C89B7C9B
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 15:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5997A1F22455
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 14:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F201784A52;
	Thu, 31 Oct 2024 14:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kh2Io39h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C535E156CF;
	Thu, 31 Oct 2024 14:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730384370; cv=none; b=JVJXDVbF/j16BE++eWFvh2sxGKia2kmqBOVXX+0HGREDHf/Fg1eDGfQ7wctcbjPt5z+4Kr4qaqiJFweP2xDsgbI7PEVN7qRYD0/RCUxsdepnCN1tFxjK4UM7YRG1sogDUV1OHEgT/N9bzYVqZeZMkfOD9sJHAkNW/DNQP4kV0QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730384370; c=relaxed/simple;
	bh=QJxJNeaj3gC0NUWb5CZdw1212FbzauRiC0Vy6rHljeA=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=rlG930XlDFo3Vtu/kfr5BzBoHP6g5qMBFwVdN60sV/h7WI1ztbXVu/TBtU+B4PxaqTg/EtfG4XL01hdKkFQwAS2/MW/f0R5wmXEcLoOzp8Mxdv01IyhzAkvILnUCvw3xQwRnuTrnhpIDTPnUBBAuDKs7H8S0QKcAS/Dbu6KE3aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kh2Io39h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598ACC4DDED;
	Thu, 31 Oct 2024 14:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730384370;
	bh=QJxJNeaj3gC0NUWb5CZdw1212FbzauRiC0Vy6rHljeA=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=kh2Io39hLbpuvosOg5J3WXfTKR9/K1A1ix/WnkWrIN+lp+0OtxXR7MGxCYdQxX7y4
	 ugKYAwZGMcg1j1Ws0wDzr/vtgpFzMdloxNyRJ/zxGo29x8HslTGxjZU7MqWHJDX6BL
	 XYwsG35daO/ZmVKe2hTWE+VtGubQ50qEq3M2eUXEA2tnsl4tTfumK4UsMx+9bI8Khm
	 9nmacdkhLIkjro5fSrQ19rTCq+39YbzktZBwn57T9tVJ0DuWoeLPAFFgLf4befL4KB
	 I3ire0G0CviGopLWv9LcHEBje7mf1ZXo3hH6+LOwlfDwhLVcV2YxH9zPyCabz9jWii
	 Pk9tGhbHcj6eQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: brcm80211: Remove unused dma_txflush()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20241025204651.244627-1-linux@treblig.org>
References: <20241025204651.244627-1-linux@treblig.org>
To: linux@treblig.org
Cc: arend.vanspriel@broadcom.com, kees@kernel.org, erick.archer@outlook.com,
 linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org,
 "Dr. David Alan Gilbert" <linux@treblig.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <173038436681.539202.501004601707648947.kvalo@kernel.org>
Date: Thu, 31 Oct 2024 14:19:28 +0000 (UTC)

linux@treblig.org wrote:

> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> dma_fxflush() has been unused since 2013's
> commit 7b2385b95363 ("brcmsmac: rework of mac80211 .flush() callback
> operation")
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Patch applied to wireless-next.git, thanks.

1e52d0061a83 wifi: brcm80211: Remove unused dma_txflush()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20241025204651.244627-1-linux@treblig.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


