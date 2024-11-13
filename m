Return-Path: <linux-wireless+bounces-15246-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BDA9C6D9A
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 12:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 870EA2834D2
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 11:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E805F1FDF86;
	Wed, 13 Nov 2024 11:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JG3YiJvm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C961FBCB3
	for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2024 11:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731496542; cv=none; b=At6bWvFn1VfgeQvClyTju4ghGv1V7rpEJ++al72/Jz8L45bBXs5nai+FdGhWQoIBsgMXK5cM9Wq+3sYeUu862oEcPUbVikcmRSvVQdOQcbO+DZRTzNaCoTqR/gfF+gOAFSHdhkZZFrT/R6XIoaFXTFn1fbwkejmDgWGAbfSNNmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731496542; c=relaxed/simple;
	bh=S4ycrZQStn8QOXaCZpRMOEP63ygGEe01jCW5MGzRT7g=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=b/SoBmGvx7A0rXDronda3rVzgmQ0bIrQ9gQU4AVCPj28pfyZA8psK0W7tV2ivIm1aWurEyFdIGayIOrdlpsx8ofgpMvxWUV9vARzJl+942UPvpkyHHsy9O0hpBIxpm3jYxvrazJtD/Fmcrg7iJNAkUX4OzoNeJa83X8mcDjL+2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JG3YiJvm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D834C4CECD;
	Wed, 13 Nov 2024 11:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731496542;
	bh=S4ycrZQStn8QOXaCZpRMOEP63ygGEe01jCW5MGzRT7g=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=JG3YiJvmboyG7gA3xaZCh2slDRsjhju+eCAfuchA7TqSXU7ldd9pUEgDD3mkeaGLi
	 0sDYejDT5v94Orub3esIi9qY/JC6TunKpYUVRvoHyNygjJHlNNScmc153aI2D3RvQT
	 ImIcH9v+LjBtGxC8J2RvSf3TzTq10x5G0HThgt5ZSelVy7HgviYJvqTPRFSrF25fmx
	 APJ2GLPkClnIqKOk+xTh06eUZ/8Fm6dLFWadByY9YQnx+WeFSm10KcKTTWVzHiZzpE
	 U5TlzUHafmx+3zMeBIuWc3YDY01YiYp84v/y5w5dhA3736ARwGfW95x8AYOq+Kj301
	 nc+5b1ZUi5VHg==
From: Kalle Valo <kvalo@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath11k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 2/6] wifi: ath11k: don't use static variables in
 ath11k_debugfs_fw_stats_process()
References: <20241113015631.3105-1-quic_bqiang@quicinc.com>
	<20241113015631.3105-3-quic_bqiang@quicinc.com>
Date: Wed, 13 Nov 2024 13:15:39 +0200
In-Reply-To: <20241113015631.3105-3-quic_bqiang@quicinc.com> (Baochen Qiang's
	message of "Wed, 13 Nov 2024 09:56:27 +0800")
Message-ID: <87y11n1j1g.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Baochen Qiang <quic_bqiang@quicinc.com> writes:

> Currently ath11k_debugfs_fw_stats_process() is using static variables to count
> firmware stat events. Taking num_vdev as an example, if for whatever reason (
> say ar->num_started_vdevs is 0 or firmware bug etc.) the following condition
>
> 	(++num_vdev) == total_vdevs_started
>
> is not met, is_end is not set thus num_vdev won't be cleared. Next time when
> firmware stats is requested again, even if everything is working fine, we will
> fail due to the condition above will never be satisfied.
>
> The same applies to num_bcn as well.
>
> Change to use non-static counters so that we have a chance to clear them each
> time firmware stats is requested. Currently only ath11k_fw_stats_request() and
> ath11k_debugfs_fw_stats_request() are requesting firmware stats, so clear
> counters there.
>
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37
>
> Fixes: da3a9d3c1576 ("ath11k: refactor debugfs code into debugfs.c")
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>

Yikes, good catch!

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

