Return-Path: <linux-wireless+bounces-6155-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 372B88A0CB5
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 11:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62B651C2124E
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 09:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CF9145334;
	Thu, 11 Apr 2024 09:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1z4+Ogl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA7A145330
	for <linux-wireless@vger.kernel.org>; Thu, 11 Apr 2024 09:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712828757; cv=none; b=s+U+UWSBp8womg9XfikItItEH/j1TjCI38kX0T011lKafpI9uSf/HLGKDlpcx0lN51Yr9nzYM8pKoHe0hVaic5/XPT7EfapX4bLdCC7pnDqHjiD3+rFf3x2jJ+3cKIcQywslLeOwhWrgmVVnyRe2+Ps6BKdL9j5RNb42hvRtn8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712828757; c=relaxed/simple;
	bh=BYThVt2f6ZbPfcrZfcye+ZzXWaZShz25k/PsRATYf4Q=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=OOMUwGkgqsgBd7PsLO4lhYSryI+Zc8CacyJXUwcs169CgSo84omZCkd+L+tRoz5C3kIzZ7QMszBkQbJVH660ZTJN5ZLxUL3dSNCbLtfUkId4COuviDHJDAUIbNSzu7PNqA9gOsgaTfJLb+r2WeFAVnX7k8EOiX+VOld6YAiGLww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t1z4+Ogl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CEC2C43390;
	Thu, 11 Apr 2024 09:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712828757;
	bh=BYThVt2f6ZbPfcrZfcye+ZzXWaZShz25k/PsRATYf4Q=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=t1z4+Ogl824G3HpZumwr43fb8pleL8qgj1kirCLEf81bAGfHFtywR0NGLNGg2Zv+6
	 ck1mvIFRUCGv3fxN9yTpMeNyNUILTiKIGfgpzHqPTir/t8I9iGu4r9GrAr/TASDtqu
	 07kkjpDPDYai2n3j3k3tpwaDA8qCkFm7xffkp8lBkf+QPbuNZTEIhMT4NgXHZ8j4Lo
	 3BkR2bA9WLKM6TioQtsxZ+W02jW47pZwfmYusowg76t5blc0hawOlVTWltS+arrY0O
	 S1E5RNieGo1Pl+pKALcQ02d/28ZUJP2AI08WCJRzyIxubuMXNeetg8jOZl1pRJPwTP
	 5hMxp/jsxt5Pg==
From: Kalle Valo <kvalo@kernel.org>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,  Jeff
 Johnson <quic_jjohnson@quicinc.com>
Subject: Re: [PATCH v2 4/4] wifi: ath12k: Refactor data path cmem init
References: <20240409151415.1226109-1-quic_periyasa@quicinc.com>
	<20240409151415.1226109-5-quic_periyasa@quicinc.com>
Date: Thu, 11 Apr 2024 12:45:54 +0300
In-Reply-To: <20240409151415.1226109-5-quic_periyasa@quicinc.com> (Karthikeyan
	Periyasamy's message of "Tue, 9 Apr 2024 20:44:15 +0530")
Message-ID: <877ch4z0z1.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:

> Move the data path Tx and Rx descriptor primary page table CMEM
> configuration into a helper function. This will make the code more
> scalable for configuring partner device in support of multi-device MLO.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

[...]

> +static void ath12k_dp_cmem_init(struct ath12k_base *ab,
> +				struct ath12k_dp *dp,
> +				enum ath12k_dp_desc_type type)
> +{
> +	u32 cmem_base;
> +	int i, start, end;
> +
> +	cmem_base = ab->qmi.dev_mem[ATH12K_QMI_DEVMEM_CMEM_INDEX].start;
> +
> +	switch (type) {
> +	case ATH12K_DP_TX_DESC:
> +		start = ATH12K_TX_SPT_PAGE_OFFSET;
> +		end = start + ATH12K_NUM_TX_SPT_PAGES;
> +		break;
> +	case ATH12K_DP_RX_DESC:
> +		start = ATH12K_RX_SPT_PAGE_OFFSET;
> +		end = start + ATH12K_NUM_RX_SPT_PAGES;
> +		break;
> +	default:
> +		ath12k_err(ab, "invalid descriptor type %d in cmem init\n", type);
> +		return;
> +	}
> +
> +	/* Write to PPT in CMEM */
> +	for (i = start; i < end; i++)
> +		ath12k_hif_write32(ab, cmem_base + ATH12K_PPT_ADDR_OFFSET(i),
> +				   dp->spt_info[i].paddr >> ATH12K_SPT_4K_ALIGN_OFFSET);
> +}

Here's a good example why I don't like functions returning void. How do
we handle the errors in this case?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

