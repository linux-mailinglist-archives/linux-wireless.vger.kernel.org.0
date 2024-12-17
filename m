Return-Path: <linux-wireless+bounces-16495-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FED9F573A
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 20:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32E1718917FE
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 19:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DC11990CD;
	Tue, 17 Dec 2024 19:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIE6RL/w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EAA148850
	for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2024 19:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734464836; cv=none; b=pZUIAxReM92bJR/Wl0d+etRHeW/mmAxxY+Q0Lf+R+xyl1YP9ESEZ3UR1yG3bEFJSJxkZcn5xLsdlKMlHu1nTIouUG6AEBZUerA/Y79l39cZTcZvOkd/UgoO9TP6OEr8mlYUqar2pWVyRjTNs/w3Cy7ZxrIYVeg70IeFE9fACCq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734464836; c=relaxed/simple;
	bh=l+Oldl3gDqfdRJsg/VWcY4tx4XXTlXyc97fkXOIDLnA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=c5RzhbGEs3nZxJOOx0HtZyqm33Cp4NgxnR1Ome7abD0CAbYB4LbxCAJ8b4MOwoZGwxVlrUmJJU7u0FcXAyakqGVDTN0hIDsRQ7F5a+fJmZMgNtMJdQK1mnC4/Hf7eW7SZzEl+XfEZLwm3YEPitJ7COtAdXoHFq/tBPh9rkl+uKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kIE6RL/w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E670C4CED7;
	Tue, 17 Dec 2024 19:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734464836;
	bh=l+Oldl3gDqfdRJsg/VWcY4tx4XXTlXyc97fkXOIDLnA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=kIE6RL/wdDFYAQFI2K/V0do6sgE9hDBK4RqLFqnxe/Y8/GwaFyt3vin+FMadQvmVj
	 j/QYQaeF2/jd4Q60KhKchMiSTJSTJjqJHdeRabp2pWm0utjuEbEudB74ckdh8XJTXV
	 5PeMhJrkbXUP9Fi8hup3M5jbOKFfOpgD4HVPJ1IWMeuRrG+tGq1PkpdXE76bU+RVZI
	 9jzBKV4VaLeAUK/FM20jATDEh65rCyUN2l8l2BXF1TUQv3uk3fWk7KjbYKNPmx75D9
	 FVw2c1UujfG9I/JkIYQfOBtpbV7/yDufBA9GdWTPmXE9k9nCg4QfW1ZLfeHdUmzEK9
	 JjnqP0/jWoDBQ==
From: Kalle Valo <kvalo@kernel.org>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,  Jeff
 Johnson <quic_jjohnson@quicinc.com>
Subject: Re: [PATCH v3 2/8] wifi: ath12k: Refactor monitor status TLV structure
References: <20241217084511.2981515-1-quic_periyasa@quicinc.com>
	<20241217084511.2981515-3-quic_periyasa@quicinc.com>
Date: Tue, 17 Dec 2024 21:47:13 +0200
In-Reply-To: <20241217084511.2981515-3-quic_periyasa@quicinc.com> (Karthikeyan
	Periyasamy's message of "Tue, 17 Dec 2024 14:15:05 +0530")
Message-ID: <878qseks72.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:

> The following TLV structures and bitmask definitions were inherited from
> the ath11k but were not updated for the ath12k 802.11be hardware. These
> data structure and bitmask will be used to parse the monitor status
> TLV data in the Rx path.
>
> 1. hal_rx_ppdu_end_user_stats_ext structure
> 2. hal_rx_ppdu_end_duration structure
> 3. HAL_RX_HE_SIG_B2_OFDMA_INFO_INFO0_STA_TXBF bitmask
> 4. HAL_RX_MPDU_START_INFO1_PEERID bitmask
> 5. HAL_INVALID_PEERID
> 6. hal_rx_ppdu_end_user_stats bitmask
>
> Currently, there is no issue since the monitor status Rx path is not
> enabled. However, in the future, the monitor status Rx path will be
> enabled. Therefore, update the above TLV structures and bitmask to align
> with the ath12k 802.11be hardware.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

