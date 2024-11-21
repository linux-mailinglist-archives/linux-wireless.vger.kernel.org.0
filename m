Return-Path: <linux-wireless+bounces-15549-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6049D4B78
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 12:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03C091F210E7
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 11:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F531CACDB;
	Thu, 21 Nov 2024 11:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OoPYRGfK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4CE9474;
	Thu, 21 Nov 2024 11:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732188005; cv=none; b=k/QBcJvxnCaYWR86L2fPt9IgdHNb3hokmBrOajGcKTMpVAcuv7intY7SKfAawrIqmcCxOQsxR3OcYnzOJWYsgtp5fxlD2PTMSNa8tMWARwPO9xmweOFoWjN1y/agw7WnG9luMXVklmo6Ig4yY7RC9z1KI0IU5sC8yIZGdUboWvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732188005; c=relaxed/simple;
	bh=mWqhOi5kNRqEpp8ydItF5JLam0/fEY56MYBvK355DRg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=oCVyX/YEx3c1i7bZ10SyJcXTTXMW/Qfi+42ZAmPrkXnas/pJiFXjjdjuUhhAg08CAut4vJ2sUB2b6YB3NpIZ1FU/yFlZzzm4Eue1dRTQJke3DoC09LNA4vsQ+dEcmMZsnYrGDEXwUFCc8aVs/LrspQST3o/MBs3uBo7tI2Jvw9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OoPYRGfK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5983C4CECC;
	Thu, 21 Nov 2024 11:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732188005;
	bh=mWqhOi5kNRqEpp8ydItF5JLam0/fEY56MYBvK355DRg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=OoPYRGfK33eEaj4TSOXurZ1ficEBLcmADw14Aac2la9G0MyZyQ375x8K1RdrJng9w
	 gvDLnOIIwSfsC/WN0YSVXjOn56IlonUH7Quu/Yqqv8Rl1y+0Sx9shmrKXg1nrL8wkx
	 61V5xhKOsls5pPBShmdFWoKrc9zi1bHnaUnNNveKAqr9JILozoQyOHkgnSYJdSdS+q
	 Q/8boiWrZv9wpK6aXpwSRpmw8bU/Nx3BB0SQYbTzY8MXFU9epoiQAI3RhTLYK5j5vx
	 1eyFMBObvNI+AlAFfZF+Rh2c6T/Yz/OwyxQkRr/eE7dW6owOrC2qzF9V9g57Dh/Mxf
	 4gG53Bg4agTqg==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Jeff Johnson <jjohnson@kernel.org>,  "Nathan Chancellor"
 <nathan@kernel.org>,  Nick Desaulniers <ndesaulniers@google.com>,  Bill
 Wendling <morbo@google.com>,  Justin Stitt <justinstitt@google.com>,
  "Arnd Bergmann" <arnd@kernel.org>,  <linux-wireless@vger.kernel.org>,
  <ath11k@lists.infradead.org>,  <linux-kernel@vger.kernel.org>,
  <llvm@lists.linux.dev>
Subject: Re: [PATCH 1/3] wifi: ath11k: mark some QMI driver event helpers as
 noinline
References: <20241119-ath11k-noinline-v1-0-4ec0a8aa30b2@quicinc.com>
	<20241119-ath11k-noinline-v1-1-4ec0a8aa30b2@quicinc.com>
Date: Thu, 21 Nov 2024 13:20:01 +0200
In-Reply-To: <20241119-ath11k-noinline-v1-1-4ec0a8aa30b2@quicinc.com> (Jeff
	Johnson's message of "Tue, 19 Nov 2024 07:47:38 -0800")
Message-ID: <87y11cx28u.fsf@kernel.org>
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
> drivers/net/wireless/ath/ath11k/qmi.c:3199:13: warning: stack frame size (1560) exceeds limit (1024) in 'ath11k_qmi_driver_event_work' [-Wframe-larger-than]
>
> This is similar to the issue found in ath12k/qmi.c that was discussed
> in [1] and fixed with [2]. The issue is that clang inlining can
> explode stack usage.
>
> Just as in ath12k, ath11k_qmi_driver_event_work() itself is a pretty
> lightweight function, but it dispatches to several other functions
> which do the real work:
>
> ath11k_qmi_driver_event_work()
> 	ath11k_qmi_event_server_arrive()
> 		ath11k_qmi_fw_ind_register_send()
> 		ath11k_qmi_host_cap_send() *
> 		ath11k_qmi_event_load_bdf()
> 	ath11k_qmi_event_mem_request()
> 		ath11k_qmi_respond_fw_mem_request()
> 	ath11k_qmi_event_load_bdf()
> 	ath11k_qmi_wlanfw_m3_info_send() *
> 		ath11k_qmi_m3_load()
> 	ath11k_qmi_process_coldboot_calibration()
>
> Of these, the two marked with * have non-trivial stack usage. Mark
> those functions as 'noinline_for_stack' to prevent them from being
> inlined in ath12k_qmi_driver_event_work(), thereby eliminating the
> excessive stack usage.
>
> Note that this approach is a bit more "surgical" than the ath12k
> approach as only the two functions with the largest stack usage are
> modified.
>
> Link: https://msgid.link/bc214795-1c51-4cb7-922f-67d6ef98bff2@quicinc.com # [1]
> Link: https://patch.msgid.link/20241028-ath12k_qmi_driver_event_work-v1-1-0d532eb593fa@quicinc.com # [2]
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

