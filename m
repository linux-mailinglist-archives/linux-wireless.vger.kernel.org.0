Return-Path: <linux-wireless+bounces-7144-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 797718BAD3F
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2024 15:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19E821F2151C
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2024 13:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A34E1534E0;
	Fri,  3 May 2024 13:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSP5BKdN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2610A1514E4
	for <linux-wireless@vger.kernel.org>; Fri,  3 May 2024 13:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714741889; cv=none; b=JAIt444pwurumpY5BUqWLQSe4PSUKFXW76TJZezC8aWDynJJmp/nXCsIgs14r3+HTj3F4twR2fPMG/gxQKdpUfrdhDc6tdm4HVoESMrbRmDfr47Vm3e36zNVeFhP+fOfpVAVStHGwLxOOLzYNVmf9VlUyh/dwnVdPbiwGeZMQFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714741889; c=relaxed/simple;
	bh=5404OLBra5zpvBGKgxF26R374GnojqrH4m9tPxLxqB4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Sa7tJs74iE0lXUIZ/zqyCry/QiJMwZRWRyXYYT12SA4gQhvxSCJvr7i6d/8B4UoANbluEZDh7bVuCiYu8BWrjipXjf2d6WWDhANNbH/K/egQjeS+K4BEd8wy3BM6zE/PptwS33ai4W8es+ZP9d+K8ehaow8w8TQ6fvBP9xWKDHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSP5BKdN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A172C2BBFC;
	Fri,  3 May 2024 13:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714741888;
	bh=5404OLBra5zpvBGKgxF26R374GnojqrH4m9tPxLxqB4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=PSP5BKdNjOhzRw2cMZ21Ayfon+vBr27dKHmm+CWtsDxLrGrcPv+g0Piji/HEbRnJR
	 VDZ/S6Qn1MEHCx3tHi95qpKkL7eDOznhsZZWaKl3ppAFF9/zmi22ZDD9tCRx/7C6V9
	 0odGXcgXmSCXt1h4CEhV89nI+ZIf5lg4Wz/51eejQUY8jludGYlhSKu3RsFmQTGTf+
	 Ps4qWYF+3qURu9pL3+G3UpFVFWX2qwpi1VVsX1T4Hj0ZV48DHfyMHfWQrH6Y5jXFVL
	 RlWNrRxmXBwMnrRR2hrJ9wsYIsX2ZkezffnXMZfT5Yn0GXooMNoxSCaYrputOsFJFL
	 mra5tJcelz8rQ==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>,
  <ath11k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,
  "Venkateswara Naralasetty" <quic_vnaralas@quicinc.com>
Subject: Re: [PATCHv5] wifi: ath11k: skip status ring entry processing
References: <20240429073624.736147-1-quic_tamizhr@quicinc.com>
	<35f114c4-1ff7-4a4b-aadf-ed147f19e170@quicinc.com>
	<87cyq7ota5.fsf@kernel.org>
	<4f9abe89-a004-45e8-b369-5c2b39bff440@quicinc.com>
Date: Fri, 03 May 2024 16:11:25 +0300
In-Reply-To: <4f9abe89-a004-45e8-b369-5c2b39bff440@quicinc.com> (Jeff
	Johnson's message of "Tue, 30 Apr 2024 08:14:16 -0700")
Message-ID: <871q6jnipu.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

>> Also I removed one unrelated change and removed unnecessary else. Please
>> check my changes:
>> 
>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=6e88d559268779107715008c51e006f7a5f62045
>
> So looking at the 'pending' change I have the observation that
> ath11k_dp_rx_mon_buf_done() only returns one of two values:
> DP_MON_STATUS_NO_DMA
> DP_MON_STATUS_REPLINISH
>
> And the return value handling has explicit handling for those values, without
> any logic for other values:
> +				if (reap_status == DP_MON_STATUS_NO_DMA)
> +					continue;
> +
> +				if (reap_status == DP_MON_STATUS_REPLINISH) {
>
> if we only expect these two values to ever be returned, then we could remove
> the testing for DP_MON_STATUS_REPLINISH since, it it isn't NO_DMA then it must
> be REPLINISH

Nice, I simplified this error handling now. Less indentation now which
is much better.

> + ath11k_warn(ab, "mon status DONE not set %lx, buf_id %d\n",
> + FIELD_GET(HAL_TLV_HDR_TAG, tlv->tl),
> +						    buf_id);
>
> I don't think we should log anything here. we already warn before calling the
> new function. if we get here it means the next buffer had DONE set so we can
> replenish the current buffer

Yeah, I removed the warning altogether. Please check my changes:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=49c28a9720959fb5daf702fe1732a716f3cff15c

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

