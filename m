Return-Path: <linux-wireless+bounces-16593-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CBD9F7A61
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 12:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4856E18912F7
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 11:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A226122371F;
	Thu, 19 Dec 2024 11:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oqy+PQNN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBDB22371C
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 11:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734607682; cv=none; b=SR/8AfaaqM4t3YWJemKAZc0ruVVDhGVI0UBwKheGTZt9rX8eCejA+9pY14/i5Du9Aj7vwunZ+xOX2/XtFxlVAMp8Fs2NkU6GsTqVxdmlC2/9nHcv+XAt5pkiO3Agg7dVzYF/fOQg0pABYPEbrpHlFIMRtlF9Drwm9p2HPfR+JGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734607682; c=relaxed/simple;
	bh=ampQwOjpQ3nLz2i3Ha1t4hsgPOsUWyGofe6L9xs8eqw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Y7Iu+myLEA/FF3f2dkFJ5PrNbvXNn31E1/tRgXvtLQ1bEgQP4cf3jBBLlNAhWKR2l02407WxngzaU4XM1KFJKSt9GwQ4PAkmRt5vFvpV23BhhvpSFD264FUX31cUZfGUN8tqB7EFxXXx3cL9wqTL4v89pUeh30+289eKy2d0+kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oqy+PQNN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35461C4CECE;
	Thu, 19 Dec 2024 11:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734607681;
	bh=ampQwOjpQ3nLz2i3Ha1t4hsgPOsUWyGofe6L9xs8eqw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Oqy+PQNNWw5JBjFs0tMVaDrcsV+G5D5qSv1fAgL3GRXImE+yyyRopuuZz9ueh8M5K
	 NYafqEYoXVu0rNXg29x0qHvUCrnNyKn83UlXT7wSfcmORD4le12I6LAy4FI5zwL65v
	 7cNk+rMMYuSfoHm5dPlZ3P3uIV4jWLwgD9Wl10FKHZ5qe74K9NC0Goochbqwgzq53/
	 aaUU3n1r2+VnHw8NRQOvDWAlbQieF/62pzoPybyw/bHBiw+WMol3GltskypnPG3R5O
	 +/iUC1TMHZ6yqeakhbcdbudJA+AD6/aZTk0LVqxKVZ2B8/frtt9x+S8nOcizcWs3LB
	 HZYa5xE51ROFw==
From: Kalle Valo <kvalo@kernel.org>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/3] wifi: ath12k: Refactor the monitor Rx parser
 handler argument
References: <20241219001006.1036495-1-quic_periyasa@quicinc.com>
	<20241219001006.1036495-2-quic_periyasa@quicinc.com>
Date: Thu, 19 Dec 2024 13:27:59 +0200
In-Reply-To: <20241219001006.1036495-2-quic_periyasa@quicinc.com> (Karthikeyan
	Periyasamy's message of "Thu, 19 Dec 2024 05:40:04 +0530")
Message-ID: <871py3kj40.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:

> Currently, the monitor Rx parser handlers
> ath12k_dp_mon_rx_parse_status_tlv() and ath12k_dp_mon_parse_rx_dest()
> take the device handle from the caller. However, these handlers
> functionality is technically pdev specific. Additionally, the device handle
> can be retrieved from the pdev handle. Therefore, for better code
> understanding, change the monitor Rx parser handlers argument from the
> device handle to the pdev handle.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

