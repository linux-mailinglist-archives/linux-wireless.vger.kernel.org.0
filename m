Return-Path: <linux-wireless+bounces-14778-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E70A79B7C54
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 15:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DA581F21ED8
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 14:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E280714F121;
	Thu, 31 Oct 2024 14:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KR2h0gI7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B446A84A3F;
	Thu, 31 Oct 2024 14:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730383498; cv=none; b=CdvE1C2N6xrwuuqFLblzY0giVf6KcGfwey/uqJHXzTSlsxFEzO0nt0fIXTG/YqqEyi30FgNDRinQQzymwlXv/i9URgELP4HZiAOuE7Cp9GUpqQUg/khQ1Bt7xWQyiIlyURmnFYpBi3IPNE2V2drlBcjG0ENSEKssayoTKLh91PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730383498; c=relaxed/simple;
	bh=HVdeTGq8tw85YSsGdDSi8A8rnS3fMC4tuFjU7oRUbCE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=LvLbTubyHqetNPaxzHRRKEvNCdZGz72iEuGnKx9EJtT9rbfs1jd3adp/ICuCgCeL5/Pjfcs2ur2sAEv7A3t9BKLwSza04gIvbnoSS3D2HwHhNF15ZbyN5VfTqBBui5IWyaL8U3e7Vyxd3Ycmze6yCDomnVPRDqNYMEZqz38CmA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KR2h0gI7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA4F3C4FE0E;
	Thu, 31 Oct 2024 14:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730383498;
	bh=HVdeTGq8tw85YSsGdDSi8A8rnS3fMC4tuFjU7oRUbCE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=KR2h0gI7A/NUGYNKfPWgTn9tf/w10eoK/Joft+nluD7JFlW1HMjj3sRTe0LHHZJ3f
	 Z1bAZW628FLFBnmBF5WI131W9+MKm+dd0atNbFZ1UWgmugJBEax7W+eOR34q2GGEQN
	 c4x5uLp49Z9qhWFVQFHFAs1cMrFbdUWVDat1F7BG8QI8Yhk5Whs8tF2uN9dm26OxBQ
	 cldGX7CbtH/s227j2bhjuAUbg/v2llPtimvIqUBpFiPSeIGj0iC1Vi9DGMNwSX39oO
	 6cgTW4bOBWGbw2ne7LZHiQLPrWgW3bso+6+RKacs52gqPANAOEmL63jJsdO2kyxt4f
	 H9yG+LOifqhPQ==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: <ath12k-devel-internal@qti.qualcomm.com>,  Jeff Johnson
 <jjohnson@kernel.org>,  Nathan Chancellor <nathan@kernel.org>,  Nick
 Desaulniers <ndesaulniers@google.com>,  Bill Wendling <morbo@google.com>,
  Justin Stitt <justinstitt@google.com>,  Arnd Bergmann <arnd@kernel.org>,
  <linux-wireless@vger.kernel.org>,  <ath12k@lists.infradead.org>,
  <linux-kernel@vger.kernel.org>,  <llvm@lists.linux.dev>
Subject: Re: [PATCH] wifi: ath12k: mark QMI driver event helpers as noinline
References: <20241028-ath12k_qmi_driver_event_work-v1-1-0d532eb593fa@quicinc.com>
Date: Thu, 31 Oct 2024 16:04:53 +0200
In-Reply-To: <20241028-ath12k_qmi_driver_event_work-v1-1-0d532eb593fa@quicinc.com>
	(Jeff Johnson's message of "Mon, 28 Oct 2024 07:08:40 -0700")
Message-ID: <87bjz0fjwa.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> As described in [1], compiling the ath12k driver using clang with
> KASAN enabled warns about some functions with excessive stack usage,
> with the worst case being:
>
> drivers/net/wireless/ath/ath12k/qmi.c:3546:13: warning: stack frame size (2456) exceeds limit (1024) in 'ath12k_qmi_driver_event_work' [-Wframe-larger-than]
>
> Nathan [2] highlighted work done by Arnd [3] to address similar
> issues in other portions of the kernel.
>
> ath12k_qmi_driver_event_work() itself is a pretty lightweight
> function, but it dispatches to several other functions which do the
> real work:
> ath12k_qmi_driver_event_work()
> 	ath12k_qmi_event_server_arrive()
> 		ath12k_qmi_host_cap_send()
> 	ath12k_qmi_event_mem_request()
> 		ath12k_qmi_respond_fw_mem_request()
> 	ath12k_qmi_event_load_bdf()
> 		ath12k_qmi_request_target_cap()
> 		ath12k_qmi_load_bdf_qmi()
> 		ath12k_qmi_wlanfw_m3_info_send()
>
> Mark all of those underlying functions as 'noinline_for_stack' to
> prevent them from being inlined in ath12k_qmi_driver_event_work(),
> thereby eliminating the excessive stack usage.
>
> Link: https://msgid.link/bc214795-1c51-4cb7-922f-67d6ef98bff2@quicinc.com # [1]
> Link: https://msgid.link/20241025223321.GA3647469@thelio-3990X # [2]
> Link: https://lore.kernel.org/all/?q=f:arnd@kernel.org+Wframe-larger-than # [3]
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

