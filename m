Return-Path: <linux-wireless+bounces-15807-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8FD9DF046
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Nov 2024 13:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A7EF281AAE
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Nov 2024 12:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7E2141987;
	Sat, 30 Nov 2024 12:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbzCtLRB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579BEAD23
	for <linux-wireless@vger.kernel.org>; Sat, 30 Nov 2024 12:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732968655; cv=none; b=l8/UvtpqFLcb+cz7x7ZOFIWt0pdrxuqXTFw5fYs+WCYN6VYwnr2oPJW0WtU9xcyDNhSUWv462e0f0h70JljvNC3NxYEMwzthKtYtLLZq9O0EvzZkl+HSdg8LEHK9xvCTOax+7sBb/PQC/K6t+64m2NG4MFFCnWK3ndtCrv8GeEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732968655; c=relaxed/simple;
	bh=m3Jrm8YjvacCE73jKzt5JMFeAXiSolKV9VW1bYBpAvg=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=FswacM/qkDiFIMwDKK8q2M2mFFEFiexd6efNr0J26CbSad+Cf+y1T9vBNwyrrfXgAZ3/WAQOSFXcYdXHxwOLgDZyY/8BqwC4dbghPsuNMZJlrEbn1yLnjIjbrLikZ7drZs4akL235JkXBDjMV3BHP0jY9ECFvDRtcJBII7chS0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbzCtLRB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D57BC4CECC;
	Sat, 30 Nov 2024 12:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732968654;
	bh=m3Jrm8YjvacCE73jKzt5JMFeAXiSolKV9VW1bYBpAvg=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=KbzCtLRB8/uq3h58EQ4JGeDbRh6H06yP2x0A5X0qLFeOmcPpPAJnO+ssZyoGT4wRH
	 SGNuX0Tk2E9MAPCk0YXYYnl9mpJqeon+nElKptODFl/CLCGoq3xNndU/WAR4VoCIAd
	 SUOkkYtYiCuiZmazBXSYUJkHhNtwwmDEY0QMhEkN54+JtXXHZnRMURftynSQ29ZQCP
	 Vlx5EdbYycVSyfWG1OPsD2CJE9WbBH0XL/e52WkYd9E1NzZupJ6YUPFzBmUbRwGzRS
	 Wtxh39p3XkTeNscvL/F4aB9NsFWo7x59kPsfdCeM92xvyDRi2fKqXzvbR4DFernO0D
	 hn8W4EAdI7Cbg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/4] wifi: ath12k: Refactor core startup
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20241128165026.2618331-2-kvalo@kernel.org>
References: <20241128165026.2618331-2-kvalo@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <173296865210.2878719.18308390110786354265.kvalo@kernel.org>
Date: Sat, 30 Nov 2024 12:10:53 +0000 (UTC)

Kalle Valo <kvalo@kernel.org> wrote:

> In the upcoming hardware device group abstraction radios across different
> devices can be grouped together to support multi-link operation and register as
> a device group to mac80211.
> 
> Currently, ath12k_mac_allocate() and ath12k_mac_register() are part of
> ath12k_core_start() and ath12k_core_pdev_create() respectively and are based on
> per device (struct ath12k_base). These APIs can be decoupled and moved out to
> ath12k_core_qmi_firmware_ready() itself. This refactor is helpful for device
> group abstraction when mac80211 allocate and register will be changed from per
> device (struct ath12k_base) to per device group (struct ath12k_hw_group).
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

4 patches applied to ath-next branch of ath.git, thanks.

fc38e9339c47 wifi: ath12k: Refactor core startup
016abac20b83 wifi: ath12k: add ath12k_ab_to_ah() and ath12k_ab_set_ah()
17dd22aff527 wifi: ath12k: add ath12k_get_num_hw()
45e72c306c08 wifi: ath12k: introduce QMI firmware ready flag

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20241128165026.2618331-2-kvalo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html


