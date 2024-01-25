Return-Path: <linux-wireless+bounces-2497-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA6B83C89C
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 17:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80336B22F5A
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 16:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91925134721;
	Thu, 25 Jan 2024 16:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uaRJQtQI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6FD13D4E2
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jan 2024 16:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201057; cv=none; b=pmI1tiH5ONBBwm8GF0jIk7IpPAwzLi0FIzbEXFLTTeWGEzEdhcdhIbmVbv8oQXpOm9BpDWfP8Dhn2UqA6b6FAFJ8qSDjG8lTIxzPWBB0oXKicShteCTBtfIoDQNpTlcJ55C7fAuVCSuXZf2BpyelSsD4tfj+E/Klil/74MUBPyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201057; c=relaxed/simple;
	bh=wcCNop60hgk2j5yhVDqKEmLRVykIVtyvwQqWxiqbSlk=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=NNUAtqEriffpuMuuwG4FMtb0PZw73KzBU89Cc5CeyKQxYQJ7LEEc54GMSlS1qfjOs4MoccdlNHU6ShY6sEcg8nmskDiTXqUqlkG5C8AwyRuVagWUVStuXQGEfov/xzAD0e17ittuWtIYlcdEbvcgcb5ilzynUak/v0Kg1T3Ql80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uaRJQtQI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E26C433F1;
	Thu, 25 Jan 2024 16:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706201056;
	bh=wcCNop60hgk2j5yhVDqKEmLRVykIVtyvwQqWxiqbSlk=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=uaRJQtQIAbei8YJM7J6brVdZNuT0jxerVh/3uNw7N0uebStc/lyeNYQKps69RRsiI
	 0lpVfXpYU332k+xo1VdYftU7/78fzbF2Vz7jFnUVAJHfp2kF2UGKdTXikdpFSxmBAg
	 lGjgKaV6oDxAbIACztxpf3VHHXdc22cGwDb+d+bgohXYGE38x4mUs1tTlaecgcSkRr
	 GIsoTzaOK45RzrXWkKHX4TB/zCGrAfaSeYmP9I9SrQWG+zaZv7bTvgYgi0ELXe9C9p
	 5UPU3EYL1JfacgKtMxFJOS7HIWIZvLNDhu54+dEYqFptsHoCIxGyk1ZWOYqbTGLhE+
	 KQ8liHRZpCJHg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/4] wifi: ath11k: remove invalid peer create logic
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240123025700.2929-2-quic_bqiang@quicinc.com>
References: <20240123025700.2929-2-quic_bqiang@quicinc.com>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_bqiang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170620105373.504797.9989085853141323864.kvalo@kernel.org>
Date: Thu, 25 Jan 2024 16:44:15 +0000 (UTC)

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> In ath11k_mac_op_assign_vif_chanctx(), there is a logic to
> create peer using ar->mac_addr for a STA vdev. This is invalid
> because a STA vdev should have a peer created using AP's
> MAC address. Besides, if we run into that logic, it means a peer
> has already been created earlier, we should not create it again.
> So remove it.
> 
> This is found during code review.
> 
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

4 patches applied to ath-next branch of ath.git, thanks.

171203f0c409 wifi: ath11k: remove invalid peer create logic
629642fa8b25 wifi: ath11k: rename ath11k_start_vdev_delay()
ce59902e56ea wifi: ath11k: avoid forward declaration of ath11k_mac_start_vdev_delay()
9d5f28c1366f wifi: ath11k: fix connection failure due to unexpected peer delete

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240123025700.2929-2-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


