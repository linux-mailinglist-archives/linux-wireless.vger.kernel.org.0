Return-Path: <linux-wireless+bounces-4193-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8152186B11F
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 15:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B0431C26350
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 14:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11044145341;
	Wed, 28 Feb 2024 14:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tu7ykhg2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75AF151CC5
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 14:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709128873; cv=none; b=n+5K+kS9mUxLMwvaXy1fgMGv3wSR04BxZ6HE6h37g+PHY9FfrFnj8F5blKXiHmP5CsRHwownEn4xPNCDwMmK6Vq84Y4L/BdCjGMdhMe1ezuFg0Rqizcw9EUnzCGFH+pzhEVyMozS+Ko0dggLzjCoCcbR6pIxYdtdLxca3W9NMuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709128873; c=relaxed/simple;
	bh=PQzkPrDo1YRo7+0s5+rzZSeJRnOLSEyHGwogClOAXNE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=V4sDyux6kfQD9TtPk8XiZetFWkjPHeTlacZKy0d2MRZ9PUOXcEoSWPmzr5gCIOQPO1FMpu3VTepWdCndiWFZPh7LrguwVfk0SMYghaYQu8L61Uz5iBJDZ3t9gkhixC3YSorfq4vsBiYxt033TqcuWxtspBCVjMBh6kuI7FwpmUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tu7ykhg2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2272AC433C7;
	Wed, 28 Feb 2024 14:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709128873;
	bh=PQzkPrDo1YRo7+0s5+rzZSeJRnOLSEyHGwogClOAXNE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=tu7ykhg2nMk6abggJ0xU/tnHpUtTaVix0hYBh+eRcNsV0e18t0ryQ5Q5wxnPjUpLn
	 6k9rmoc1F8Xed9MQJ64a2IaywyhUhqGRdBruCM8GDrrJFfh9zkYwHZLrh3/Usuk4BU
	 EbG+hOGUIoO1N5jismTvvvsMZIkeXPqEfLjlvgdWw/W6kAeeJTMx0ejMZJ50Hh9Zzh
	 Pzktv6+nVEzWf2FN7Q5L0Mh45puvL8tQmIhalc26bVr6jul8zYyQm07aJlLMJXKXcG
	 +lt1Smgzr2SxS5M0bWk/5zu3GmYj98LKySZGJciVq97AwQQUfVssZLo4QKa0u9BGli
	 SiAkpTgI2weZg==
From: Kalle Valo <kvalo@kernel.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,  Jeff Johnson
 <quic_jjohnson@quicinc.com>,  ath11k@lists.infradead.org,
  linux-wireless@vger.kernel.org,  lvc-project@linuxtesting.org
Subject: Re: [PATCH] wifi: ath11k: fix few -Wmaybe-uninitialized warnings
References: <20240228131406.165786-1-dmantipov@yandex.ru>
Date: Wed, 28 Feb 2024 16:01:10 +0200
In-Reply-To: <20240228131406.165786-1-dmantipov@yandex.ru> (Dmitry Antipov's
	message of "Wed, 28 Feb 2024 16:14:06 +0300")
Message-ID: <875xy8k7rt.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dmitry Antipov <dmantipov@yandex.ru> writes:

> When compiling with gcc version 14.0.1 20240226 (experimental) and
> W=12, I've noticed the following warnings:
>
> drivers/net/wireless/ath/ath11k/mac.c: In function 'ath11k_mac_op_remain_on_channel':
> drivers/net/wireless/ath/ath11k/mac.c:9230:12: warning: 'ret' may be used uninitialized
> [-Wmaybe-uninitialized]
>  9230 |         if (ret)
>
> drivers/net/wireless/ath/ath11k/qmi.c: In function 'ath11k_qmi_load_file_target_mem':
> drivers/net/wireless/ath/ath11k/qmi.c:2401:16: warning: 'ret' may be used uninitialized
> [-Wmaybe-uninitialized]
>  2401 |         return ret;
>
> drivers/net/wireless/ath/ath11k/qmi.c: In function 'ath11k_qmi_load_bdf_qmi':
> drivers/net/wireless/ath/ath11k/qmi.c:2494:17: warning: 'fw_entry' may be used uninitialized
> [-Wmaybe-uninitialized]
>  2494 |                 release_firmware(fw_entry);
>
> And a bunch of them traced to uninitialized fields of the same
> variable, e.g.:
>
> drivers/net/wireless/ath/ath11k/spectral.c: In function 'ath11k_spectral_process_data':
> drivers/net/wireless/ath/ath11k/spectral.c:700:47: warning: 'summ_rpt.meta.freq1' may
> be used uninitialized [-Wmaybe-uninitialized]
>   700 |         struct ath11k_spectral_summary_report summ_rpt;
>
> Fix all of the above by using 0 and NULL initializers where appropriate.
> Note there are few more (less obvious) -Wmaybe-uninitialized warnings
> still remains, but they're hardly possible to fix without running on
> a physical hardware. Compile tested oly.
>
> Also noticed by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Did you verify that the warnings are valid?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

