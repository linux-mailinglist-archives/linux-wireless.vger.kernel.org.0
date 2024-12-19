Return-Path: <linux-wireless+bounces-16594-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6AC9F7A6B
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 12:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D151F1892552
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 11:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42E022257B;
	Thu, 19 Dec 2024 11:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xs9FwFnX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA97221467
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 11:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734607930; cv=none; b=oU78xp3BnQlUS5PRZu96a811OrxAGiDp1oleIR1VTFe2PH1m/XTnhOjHZhbhbQJ6tD35GhH7SGmsEYK2ymJeVk32X/hRVl+x/FiYf0mz0ZHzql6IQGRoD42L7nIT6GlnLTUrSCq5GZEfS/EqjPXFvHF36N4DCKnFkhL80NqjYSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734607930; c=relaxed/simple;
	bh=gte74b0Y8f2QJIkvnAM1b3fi665Ezbem0bk6W9zICGw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=FeBRbOiLqNY77x/kx/xUovkCVHf81p9TrN7aL+dwrkzeTUGDq/PQVocAbbtNulLg82DMcoEU5lnm48iL67T1F5mQkQuhdzWYdH9in5zs0qqX7r1zDdazcx1fSvD7WF1kVw+QFhoFUrOxsWvDO8mCSQvjKJLi6LeRQU0q2QzgaDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xs9FwFnX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 425C4C4CECE;
	Thu, 19 Dec 2024 11:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734607929;
	bh=gte74b0Y8f2QJIkvnAM1b3fi665Ezbem0bk6W9zICGw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Xs9FwFnXP7a4Ue7s6lsXVnT1qwLOcVaW+raP9wSSQgVT5o9XGkIrQf9K7AwbQm+/J
	 Irb4UYbeGcVViSh5qbSQBoBXleTy+VBftwJaAuWVBjNd9w0XiGj1EAMk7glGPLFOP5
	 K/Q4m9w4xbk02lCsIPGKt3Y9EU/0633mo+XZUEzi7qA+cMgLJRdJvLYOPu7rz8xZA/
	 FB1lhGoqVsMFRbHMNz4W1NExm02pbzUxx30/Is+ZhENGpTdw0JUgZhDyrkDTqIW1Jr
	 bZEONDmbKxRPMrnAcCbv2ARz6ZWJGlojI1gul48lCMGF3+3Z30IA7yQsDUeStieAc8
	 UYxx9zwLaTzQw==
From: Kalle Valo <kvalo@kernel.org>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 2/3] wifi: ath12k: Refactor the monitor Tx/RX handler
 procedure arguments
References: <20241219001006.1036495-1-quic_periyasa@quicinc.com>
	<20241219001006.1036495-3-quic_periyasa@quicinc.com>
Date: Thu, 19 Dec 2024 13:32:06 +0200
In-Reply-To: <20241219001006.1036495-3-quic_periyasa@quicinc.com> (Karthikeyan
	Periyasamy's message of "Thu, 19 Dec 2024 05:40:05 +0530")
Message-ID: <87wmfvj4cp.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:

> Currently, the pdev handle is given along with the mac id to all the
> monitor Tx/Rx handler procedure arguments. The mac id information is
> derived from the pdev handle itself. Therefore, remove the unnecessary
> mac id argument from the handler.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/dp_mon.c | 29 ++++++++++++------------
>  drivers/net/wireless/ath/ath12k/dp_mon.h |  7 +++---
>  2 files changed, 17 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
> index 85ff89b91624..ae2f6847bc88 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_mon.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
> @@ -845,7 +845,7 @@ static void ath12k_dp_mon_rx_msdus_set_payload(struct ath12k *ar,
>  }
>  
>  static struct sk_buff *
> -ath12k_dp_mon_rx_merg_msdus(struct ath12k *ar, u32 mac_id,
> +ath12k_dp_mon_rx_merg_msdus(struct ath12k *ar,

BTW I find it confusing that in the commit message you talk about "pdev
handle" but in the code it's named "ar". It would be nice to have
terminology all over. No need to change anything for this patch, just a
small comment for the future.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

