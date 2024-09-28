Return-Path: <linux-wireless+bounces-13265-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28574988EB5
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Sep 2024 11:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5159281A70
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Sep 2024 09:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E996419F136;
	Sat, 28 Sep 2024 09:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2xtlhk6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57CE19F12C
	for <linux-wireless@vger.kernel.org>; Sat, 28 Sep 2024 09:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727514684; cv=none; b=lYNXk5zRStRZc/0Eqq/pqIi8FHA9dP8u6aChh5BsdlwYK9AGM/vDSqdkuCtjERVTSZaU5J1FEzOYCOfv7NfvpDGv6GQm6y9UumofimA85iy7oE9JLnwg1Cne5MsxJi/fphJD14STtHql1MCPJzaBUY9cjvttruplo2ExLCBPAxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727514684; c=relaxed/simple;
	bh=OJ3gO0JwDTJwnTctZQnELZ3cghcWHB1pcbja2AailI8=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=kFNA77V3dlkzpDQIgYxDG955s8YqEp+1BPWDV9wqWj6IPMinxC5AQGJOusv5YvmeTR8bN7YYL/xe96LPagVbEZpninivdqAIwBPTsX225C2QyaFm6L7+uhQeiA/X0LN/GmfuwiAtoFAfRQgVSXrRHFsSnICX7Sazn64YqBkliz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2xtlhk6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613A3C4CECF;
	Sat, 28 Sep 2024 09:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727514684;
	bh=OJ3gO0JwDTJwnTctZQnELZ3cghcWHB1pcbja2AailI8=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=n2xtlhk6BD4fbK6P276W0InOdSg4UVsuylMASUwP8JWAagf7bkTCDzgEDeGpRKkD5
	 ail25wNetiu0z2oiFGGcKCMjxvGrjRnJcqwqnMHf+dpYlUwm4IUqyGH+9TIcU/c+2f
	 tnrbCX0PZ1XtggcrUlFJi4pcIvLJY2wrPBEpQ848xiym9lyM3mvceWup110QcyroB/
	 msesWHB21ko15cVFSvkF5YdSXCGxx/mFK69dEMmJRU0bw6Qrgbm9q4smYzL86GmTCf
	 MIZdil8BV/wMAPAIxRkg9jTdSil8SSuPAu1hMAHGGxlsjs+vFrY5zw5szhx/luTwbJ
	 4fNeL9h/EUKjA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: ath10k: fix invalid VHT parameters in
 supported_vht_mcs_rate_nss1
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240711020344.98040-2-quic_bqiang@quicinc.com>
References: <20240711020344.98040-2-quic_bqiang@quicinc.com>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_bqiang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172751468142.2249584.250066721438756221.kvalo@kernel.org>
Date: Sat, 28 Sep 2024 09:11:23 +0000 (UTC)

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> In supported_vht_mcs_rate_nss1, the rate for MCS9 & VHT20 is defined as
> {780,  867}, this does not align with firmware's definition and therefore
> fails the verification in ath10k_mac_get_rate_flags_vht():
> 
>         invalid vht params rate 960 100kbps nss 1 mcs 9
> 
> Change it to {865,  960} to align with firmware, so this issue could be
> fixed.
> 
> Since ath10k_hw_params::supports_peer_stats_info is enabled only for
> QCA6174, this change does not affect other chips.
> 
> Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00309-QCARMSWPZ-1
> 
> Fixes: 3344b99d69ab ("ath10k: add bitrate parse for peer stats info")
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Closes: https://lore.kernel.org/lkml/fba24cd3-4a1e-4072-8585-8402272788ff@molgen.mpg.de/
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

d50886b27850 wifi: ath10k: fix invalid VHT parameters in supported_vht_mcs_rate_nss1
52db16ec5bae wifi: ath10k: fix invalid VHT parameters in supported_vht_mcs_rate_nss2

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240711020344.98040-2-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html


