Return-Path: <linux-wireless+bounces-3907-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F62B85F5ED
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 11:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A5D41C20B72
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 10:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAE63BB26;
	Thu, 22 Feb 2024 10:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8gXrHGN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A740B29CEA
	for <linux-wireless@vger.kernel.org>; Thu, 22 Feb 2024 10:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708598611; cv=none; b=hvclLvCStDekwbFXZnG4uVnC9ndBotcHS5pKNkq5JsibhSwTwKDZMR9/WFz8FRJMiXyvSQAlmc+ezBVUlSqYQV9CnI0vxtduJQ6PWewkSvTufsAKKiLrvhhmoWGFvdZtKxVoU9QdcxN7Uz05NE5kJlpjXQGpWEkhOhBsgs6+SCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708598611; c=relaxed/simple;
	bh=PHAYR+G8AEvsMILj2TGvpVCTUhyBs8YZi1hH4Qg/CIc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=dwTxZxmcts2OWSHZDcAipfWX+KZ2nSRMctlKv1UphhLzrFUnEHBWd4Ohp04X+rC79uVzSDEg92E8JED+DV3GcuAdf68m0PvqfQ2Bu3zMH0d6d44L2mLVxYhgYbKmXbqD58TRpv9I9ILHALlsyy/viNaFqLT5XEG2XFDYCNxZabA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8gXrHGN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11CFC433F1;
	Thu, 22 Feb 2024 10:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708598611;
	bh=PHAYR+G8AEvsMILj2TGvpVCTUhyBs8YZi1hH4Qg/CIc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=e8gXrHGNxRBvV8NmJaFSP9Ip3AIwZiihjEDfH3OpsgfZO7tBFvo9ycEWl+sx8/ylu
	 Q54AgX97YFkgBG8iIGtXWhSDzV6uaSdowshlosM7K2oOO/NuBxbKYgwp3qPMXuq/0I
	 A/4od94pfngBbhr0jvHTiH8zJTfKK4U5zu573yYc4Ze31M4FXf5JF8GssRk9qUZ8Z8
	 v68zyR/HGYp/c7a+0udvGRReSXs/seAVcpHkdGwjcgh0DgJiWg8N56whYrys3q3I2v
	 O5r2v5dV0C4p7UNkvFhzqVkfz9g/ZBJQ7+7mJjR04PWL7Ypo65K6TFuNEJr8N7CK16
	 WCV3nPUh5WQJQ==
From: Kalle Valo <kvalo@kernel.org>
To: linux-wireless@vger.kernel.org
Cc: ath10k@lists.infradead.org,  ath11k@lists.infradead.org,
  ath12k@lists.infradead.org,  quic_jjohnson@quicinc.com
Subject: Re: pull-request: ath-next-20240222
References: <87plwolx2z.fsf@kernel.org>
Date: Thu, 22 Feb 2024 12:43:27 +0200
In-Reply-To: <87plwolx2z.fsf@kernel.org> (Kalle Valo's message of "Thu, 22 Feb
	2024 10:31:00 +0200")
Message-ID: <87h6i0lqy8.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kalle Valo <kvalo@kernel.org> writes:

> Hi,
>
> Here's an ath-next pull request to wireless-next. More info below.
>
> Kalle
>
> The following changes since commit 2a71528427c635f0a8bff704b2e62ce81c641d6f:
>
>   wifi: brcmfmac: fix copyright year mentioned in platform_data header (2024-01-31 18:48:06 +0200)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git tags/ath-next-20240222
>
> for you to fetch changes up to 3ab6aff5793c3c7bdf6535d9b0024544a4abbdd5:
>
>   wifi: ath11k: remove unused scan_events from struct scan_req_params (2024-02-15 13:24:18 +0200)
>
> ----------------------------------------------------------------
> ath.git patches for v6.9
>
> We have support for QCA2066 now and also several new features in ath12k.
>
> Major changes:
>
> ath12k
>
> * firmware-2.bin support
>
> * support having multiple identical PCI devices (firmware needs to
>   have ATH12K_FW_FEATURE_MULTI_QRTR_ID)
>
> * QCN9274: support split-PHY devices
>
> * WCN7850: enable Power Save Mode in station mode
>
> * WCN7850: P2P support
>
> ath11k:
>
> * QCA6390 & WCN6855: support 2 concurrent station interfaces
>
> * QCA2066 support
>
> ----------------------------------------------------------------

Pulled.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

