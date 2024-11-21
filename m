Return-Path: <linux-wireless+bounces-15550-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD4B9D4B7A
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 12:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4EF2282910
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 11:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4761CCEC9;
	Thu, 21 Nov 2024 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBXi0RKz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913B71CB32F;
	Thu, 21 Nov 2024 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732188029; cv=none; b=ecmWQ/SpWONs9ZJL7CGe7Kv7VMvYYlFyR4xCgRSeRp08FmEpexvyqZjQOZik+zDK+CF9Ny3SrQ5ycxvHzof9PmpztpMiZVTcDOQbiLFc4T8lGu4kPuCL/3NjrqClYgq1t5eGfFB0UwJCiysEnXYwJ5BU9G9iVQEh4hUgtklY4JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732188029; c=relaxed/simple;
	bh=UYVrx/tz+yMf3dt8i+rVYN0ZOd150G0c2AUXY2rn0Zc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=iSo6IB8NdFJDdptQm3q2We5dZC0S2IQmx5ff2nN8pLxDoAC0Avh2qW3QVU/+Zmk6jAy0LcgjwyY8X5cU6+z0A7P48RUEvj6FbYxOu5kDTWvI6qRwsCVSWT/EcRitQrun0VX23QDs8LcCsBYCENt8yE0m/tsG5L25N98NWTHEE4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tBXi0RKz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D0CC4CECC;
	Thu, 21 Nov 2024 11:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732188029;
	bh=UYVrx/tz+yMf3dt8i+rVYN0ZOd150G0c2AUXY2rn0Zc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=tBXi0RKzhcKjbvdIT8YEjG/m/17yGQMiUzFIHIA8CTmF8aKKTxAZ+YToHTvh4i6Mf
	 IOfb9jbl2OWkQNxZfB6/YrvgXTXXYHUCdHTxXQ53toFTyAK4jjDMkFuvabjv0QKZeI
	 XT931pBWDUtwrI6iIvT+GaOH1KfoDWPAYiDzhaa1WASDisNVTal/rYVYa9RdVigrHM
	 JE+AmihHkFgE0VV10BvvsP23thm9KRaNuZbSaQ4uj45ume98J8B300o6TPlv+zKCFr
	 AhTCRPbM4gO3WNA804MdkRX+HISiYbQCVgOAly97MXXKZDr5Fym8MYrzMl6H6s4Z5a
	 N0PWTxmSMbC0g==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Jeff Johnson <jjohnson@kernel.org>,  "Nathan Chancellor"
 <nathan@kernel.org>,  Nick Desaulniers <ndesaulniers@google.com>,  Bill
 Wendling <morbo@google.com>,  Justin Stitt <justinstitt@google.com>,
  "Arnd Bergmann" <arnd@kernel.org>,  <linux-wireless@vger.kernel.org>,
  <ath11k@lists.infradead.org>,  <linux-kernel@vger.kernel.org>,
  <llvm@lists.linux.dev>
Subject: Re: [PATCH 2/3] wifi: ath11k: mark ath11k_dp_rx_mon_mpdu_pop() as
 noinline
References: <20241119-ath11k-noinline-v1-0-4ec0a8aa30b2@quicinc.com>
	<20241119-ath11k-noinline-v1-2-4ec0a8aa30b2@quicinc.com>
Date: Thu, 21 Nov 2024 13:20:24 +0200
In-Reply-To: <20241119-ath11k-noinline-v1-2-4ec0a8aa30b2@quicinc.com> (Jeff
	Johnson's message of "Tue, 19 Nov 2024 07:47:39 -0800")
Message-ID: <87ttc0x287.fsf@kernel.org>
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
> drivers/net/wireless/ath/ath11k/dp_rx.c:5244:5: warning: stack frame size (1304) exceeds limit (1024) in 'ath11k_dp_rx_process_mon_status' [-Wframe-larger-than]
>
> This is similar to the issue found in ath12k/qmi.c that was discussed
> in [1] and fixed with [2]. The issue is that clang inlining can
> explode stack usage.
>
> ath11k_dp_rx_process_mon_status() itself is a pretty
> lightweight function, but it dispatches to several other functions
> which do the real work:
>
> ath11k_dp_rx_process_mon_status()
> 	ath11k_dp_rx_reap_mon_status_ring()
> 	ath11k_dp_rx_mon_dest_process()
> 		ath11k_dp_rx_mon_mpdu_pop() *
> 		ath11k_dp_rx_mon_deliver()
> 			ath11k_dp_rx_mon_merg_msdus()
> 			ath11k_dp_rx_deliver_msdu()
> 	ath11k_dp_rx_update_peer_stats()
>
> Of these, only ath11k_dp_rx_mon_mpdu_pop() has non-trivial stack
> usage, so mark that function as 'noinline_for_stack' to prevent it
> from being inlined in ath11k_dp_rx_process_mon_status(), thereby
> eliminating the excessive stack usage.
>
> Link: https://msgid.link/bc214795-1c51-4cb7-922f-67d6ef98bff2@quicinc.com # [1]
> Link: https://patch.msgid.link/20241028-ath12k_qmi_driver_event_work-v1-1-0d532eb593fa@quicinc.com # [2]
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

