Return-Path: <linux-wireless+bounces-16613-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB8F9F7C65
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 14:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CA9217151A
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 13:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DB7224899;
	Thu, 19 Dec 2024 13:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vI+BcTFc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF8C39FCE;
	Thu, 19 Dec 2024 13:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734614944; cv=none; b=A9kR5ZE30sf1tTAT5TkoZmK8B/JfLq71ehQ6ZQKQVpMxigjJDMCOgJU73QLNCtdLJAJeE3HZ3vuav6p8YvGVzoiaRHKKeesrUWcB1PsQ6ihPKXOp5LfK66zdWqPsaU077rsBKvkvYnF8j1xr8Ss+2A96gtVPoTdH6FmLD+VHWT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734614944; c=relaxed/simple;
	bh=A1LYNU+bTOwVQx1HXIzE9f7TQzF01a4QaqmVeeoBuRs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=O7wZ2KxfKje/ikg/Cbb9/M764jdiVxGZSRmrACfwgDTCKD2clb2s7jHSCtQRP4U0YboKD44V59t2apNvVxuknY8pUb1KHyBT6gKhkk1I/2GPTIfdRGSAW+j+oaNwjEbo7BQoXyTffHxvsef4nGYsDR+82bTKTp4O80rm7OV5P98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vI+BcTFc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD4EC4CECE;
	Thu, 19 Dec 2024 13:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734614943;
	bh=A1LYNU+bTOwVQx1HXIzE9f7TQzF01a4QaqmVeeoBuRs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=vI+BcTFcOWA0TixP6swapoBS5v4jRbxVhVJVwBQFS9QCY+olRREkxdpLAA905ZbSy
	 yTnOXU+Z1ZNzcWF63Tyc9K107MtisqnU7jBuPoLF4td4pJE892UTYrHab08YZotfBh
	 82KxxcAjJ28moEuVPhe9yJhM75lUjM58T0SAckzRzJIz1LD/70rwNGC5RqY8mZJuYb
	 HUHO2kLXx2pk5xxjtvzxFZEpsA77AcDgmMAxMkhR5+J0etbsp0hwDR2RspfXZ/lRm8
	 ETZdhxB1zzdVuL1b3dIahXi2o2nisuuS+mUsUr/OXOv9MhmWPq3RVS+L7FqXS+ooWR
	 7tM9xwbWMAFwA==
From: Kalle Valo <kvalo@kernel.org>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: Jeff Johnson <jjohnson@kernel.org>,  <linux-wireless@vger.kernel.org>,
  <ath12k@lists.infradead.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] wifi: ath12k: handle radar detection with MLO
References: <20241218-ath12k_mlo_dfs-v1-0-058e783bcfc7@quicinc.com>
	<20241218-ath12k_mlo_dfs-v1-3-058e783bcfc7@quicinc.com>
Date: Thu, 19 Dec 2024 15:29:00 +0200
In-Reply-To: <20241218-ath12k_mlo_dfs-v1-3-058e783bcfc7@quicinc.com> (Aditya
	Kumar Singh's message of "Wed, 18 Dec 2024 09:11:34 +0530")
Message-ID: <875xnfhkdf.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Kumar Singh <quic_adisi@quicinc.com> writes:

> ieee80211_radar_detected() expects the driver to pass a channel context
> configuration during MLO. This is used to identify exactly which link
> detected the radar.
>
> Add support to pass this to mac80211. Since the link arvif is not known in
> the WMI event, introduce a helper iterator API,
> ath12k_mac_get_any_chanctx_conf_iter(), to get the channel context
> configuration.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

