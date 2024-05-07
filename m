Return-Path: <linux-wireless+bounces-7275-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE178BDF3C
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 12:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 317051C212B2
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 10:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EB8149C6F;
	Tue,  7 May 2024 10:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8MamacX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E345114D71E
	for <linux-wireless@vger.kernel.org>; Tue,  7 May 2024 10:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715076019; cv=none; b=abP5Ql/ORaglRYQfwaQdBhytp1OnXCAlEnmd5VC5nUxSyy708qjLYztDO5WQhuaGoYt4UA4m9/D5M6YdWzB6/AvjrlNWOd1qcz501xldisQzBnvASQNgSGmo6yhNSoAJ+gYyTh7VTDOou6IoHlJrV2suOdxpUk1CbqHmW5viRyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715076019; c=relaxed/simple;
	bh=OcSKTZStAaD9u1j/juI/j/X8r7AGIVvhSWiWUCvhUaA=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=tH/RciSYWy8C0DsifwS9W1hFBP4rSj3ms77LWA1tam9EoLL8qsReFsNmfKy+khlAemZzxf3uoJ88mGaOuTqT5AYqaO/9liw+NowcOIexCa4hXdNlXl8Sz2bLMvcVv5ajC/cwYzUq59SYIypJGnMiNqdrqIABJ4Px1BwY57FRmno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8MamacX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606F0C2BBFC;
	Tue,  7 May 2024 10:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715076018;
	bh=OcSKTZStAaD9u1j/juI/j/X8r7AGIVvhSWiWUCvhUaA=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=o8MamacXrpNlPFoEPNXuwJC3ch1F7W7FNc//rfB4KfTBxilGqX/3ovdoirwA5/817
	 TXRzwR7RX1eUBC5/SW0pgBfWn1gQOxMJTp/0hWtz2MojfA9C839czYOgBKMoGNaUYK
	 PqDbWLsHpjleGnSrzsM0PKi8outTTKOMHFUUT5vTUA5v2xTTmVWuXLhPTO35sEVTR/
	 9H5d/X/sZ32A7DiG8s+keYE/dYcEiOvG+pUrLynizeigt9N05r0wLeZbmrZQLAdjy/
	 3ksw6PQuveMe1hdp9EbYpYTYHwwSsxcMLbNIBdyksqHBM88eA2IRNiL5RLW0vWpmm3
	 VpxLFHyb16OmQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCHv5] wifi: ath11k: skip status ring entry processing
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240429073624.736147-1-quic_tamizhr@quicinc.com>
References: <20240429073624.736147-1-quic_tamizhr@quicinc.com>
To: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
Cc: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Venkateswara Naralasetty
	<quic_vnaralas@quicinc.com>, Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171507601530.3751691.1245928656021241727.kvalo@kernel.org>
Date: Tue,  7 May 2024 10:00:17 +0000 (UTC)

Tamizh Chelvam Raja <quic_tamizhr@quicinc.com> wrote:

> If STATUS_BUFFER_DONE is not set for a monitor status ring entry,
> we don't process the status ring until STATUS_BUFFER_DONE set
> for that status ring entry.
> 
> During LMAC reset it may happen that hardware will not write
> STATUS_BUFFER_DONE tlv in status buffer, in that case we end up
> waiting for STATUS_BUFFER_DONE leading to backpressure on monitor
> status ring.
> 
> To fix the issue, when HP (Head Pointer) + 1 entry is peeked and if DMA is not
> done and if HP + 2 entry's DMA done is set, replenish HP + 1 entry and start
> processing in next interrupt. If HP + 2 entry's DMA done is not set, poll onto
> HP + 1 entry DMA done to be set.
> 
> Also, during monitor attach HP points to the end of the ring and TP (Tail
> Pointer) points to the start of the ring.  Using ath11k_hal_srng_src_peek() may
> result in processing invalid buffer for the very first interrupt. Since, HW
> starts writing buffer from TP.
> 
> To avoid this issue call ath11k_hal_srng_src_next_peek() instead of
> calling ath11k_hal_srng_src_peek().
> 
> Tested-on: IPQ5018 hw1.0 AHB WLAN.HK.2.6.0.1-00861-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
> Co-developed-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
> Signed-off-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

4c2b796be3a1 wifi: ath11k: skip status ring entry processing

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240429073624.736147-1-quic_tamizhr@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


