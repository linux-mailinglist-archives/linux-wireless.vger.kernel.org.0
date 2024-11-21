Return-Path: <linux-wireless+bounces-15551-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 984749D4B7D
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 12:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B186AB25E57
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 11:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEFE1CFEC2;
	Thu, 21 Nov 2024 11:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAp+d4bV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B441CB32F;
	Thu, 21 Nov 2024 11:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732188048; cv=none; b=aL836xgaA5ZsUPe14u8dOoTbLqIjMqEzu3asI6m4n90Dz1r67xUcL8QYcwjJiuPQbKKhjPUByEGZ8juJhRiZjrhQh037yISiVXJ9/uEXpM5wgajiBY2nWB7NXtcVtCwCo8mlUwIZRPQDGVPuLy30zmFolKzXtQGAK3QTN7uW62c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732188048; c=relaxed/simple;
	bh=V1qwmYpUnP1CiJot/3EBrHXVUBv8JOAa6S7kT+VjG8M=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=dClLOgfD8ipC1ZSzx7HA2c/Y6Pgnnd0L9mpqGuFi4zxd2dGzSzCrOARCSjlOrBPtCPtFthtnXsBJjuv/LH5S2czVVhLmwKMSvqM+9Zj8+IeoWPHEbDa9t+4mFTceG8KSA2Qr7cxNfHVVuzBQ2UECb2pb4igkveWnlVDdcKwYS6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAp+d4bV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E5FEC4CECC;
	Thu, 21 Nov 2024 11:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732188047;
	bh=V1qwmYpUnP1CiJot/3EBrHXVUBv8JOAa6S7kT+VjG8M=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=HAp+d4bVQao54y/cn2DsJqZy9Yb14gtl7gGMwhxXfbV26TwD7zGxFVlX86SoLzAoP
	 AWJ1CVS3QD9B3lZGgOOvGpLtIbRyRhdCVxr3k1pF42aRFCoTsfAr5iCQwZcCpJ1cMK
	 2VIU4X1uR2iQUj055G2YcsfFotF3WZK9XNVnWw/ZnS2QQob915sBVMpxpeAglEaCSz
	 KY77A1Mv9lR3KwElj0G9LBb/AWeo9vmLThlaRMnv98rb9RPQ7aPbFeFWMiTwHZytpC
	 Ici219Mz2XWVLuB9R7tkcPmD/k5W/MMHuXRSGTVeLMl8X5Jq2kx+UrQMfo1eEviU9s
	 Gblr7G0UBxW5A==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Jeff Johnson <jjohnson@kernel.org>,  "Nathan Chancellor"
 <nathan@kernel.org>,  Nick Desaulniers <ndesaulniers@google.com>,  Bill
 Wendling <morbo@google.com>,  Justin Stitt <justinstitt@google.com>,
  "Arnd Bergmann" <arnd@kernel.org>,  <linux-wireless@vger.kernel.org>,
  <ath11k@lists.infradead.org>,  <linux-kernel@vger.kernel.org>,
  <llvm@lists.linux.dev>
Subject: Re: [PATCH 3/3] wifi: ath11k: mark
 ath11k_wow_convert_8023_to_80211() as noinline
References: <20241119-ath11k-noinline-v1-0-4ec0a8aa30b2@quicinc.com>
	<20241119-ath11k-noinline-v1-3-4ec0a8aa30b2@quicinc.com>
Date: Thu, 21 Nov 2024 13:20:43 +0200
In-Reply-To: <20241119-ath11k-noinline-v1-3-4ec0a8aa30b2@quicinc.com> (Jeff
	Johnson's message of "Tue, 19 Nov 2024 07:47:40 -0800")
Message-ID: <87plmox27o.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> When compiling the ath11k driver using clang with KASAN enabled, the
> following warning is observed:
>
> drivers/net/wireless/ath/ath11k/wow.c:672:5: warning: stack frame size (1336) exceeds limit (1024) in 'ath11k_wow_op_suspend' [-Wframe-larger-than]
>
> This is similar to the issue found in ath12k/qmi.c that was discussed
> in [1] and fixed with [2]. The issue is that clang inlining can
> explode stack usage.
>
> ath11k_wow_op_suspend() itself is a pretty lightweight function, but
> it dispatches to several other functions which do the real work. One
> path in particular is:
>
> ath11k_wow_op_suspend()
> 	ath11k_wow_set_wakeups()
> 		ath11k_vif_wow_set_wakeups()
> 			ath11k_wow_convert_8023_to_80211()
>
> Of these, ath11k_wow_convert_8023_to_80211() has non-trivial stack
> usage, so mark it as 'noinline_for_stack' to prevent it from being
> inlined in ath11k_wow_op_suspend(), thereby eliminating the excessive
> stack usage.
>
> Link: https://msgid.link/bc214795-1c51-4cb7-922f-67d6ef98bff2@quicinc.com # [1]
> Link: https://patch.msgid.link/20241028-ath12k_qmi_driver_event_work-v1-1-0d532eb593fa@quicinc.com # [2]
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

