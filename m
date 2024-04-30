Return-Path: <linux-wireless+bounces-7050-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A49FB8B7791
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 15:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FD542835AE
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 13:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52471171E53;
	Tue, 30 Apr 2024 13:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3lICaCL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECF517167F
	for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2024 13:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714484934; cv=none; b=kvZzvXgpCZ/EJB0fYlkOQu3taTWHIbcgYt3IAxAiopVY4vwdwVyQgmzLIlb4h+Mt6e49M2zexmlBpFsktS0N38AU8ouyJHMshrn6QMLIAbrc8KqLJalCEvitfYIvsNrL5CT6h7PczSQKWOG6ZdV1pRUS4Z4X+2BlKbTQQ0/bv2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714484934; c=relaxed/simple;
	bh=6WTKqUfG5kN4YNoATVxd08lZG8BIH87ncCi8h2kONA8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=XBibyX+m31ki+3zpH7iQN4xG+Vm5TFANFyJe/KXLZE7yJKmonqGxQkDmc20INmzIh5GOJ6wpoeaq6d1eDCpnGRqVJGdz6B4ucAUIuSFS7wY/4hKrVadPxPTtAIv5rBDERDq0MH5OjIDYYVgqwH352ePvYBRVNkZntwIzTybsY5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3lICaCL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94350C4AF18;
	Tue, 30 Apr 2024 13:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714484933;
	bh=6WTKqUfG5kN4YNoATVxd08lZG8BIH87ncCi8h2kONA8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=f3lICaCLV6tAhH0BT5FnBShhKYOpmQZQHyzJv08Or7dA7e3pL0b38kuL8uypgQUYU
	 9uNgvcu0ER+CJQ6GPd/CpuVytPWDpP/n36QXUuUZf/GZdBLQx168XBYhXtJfymads9
	 kyEWLJbUwDvZSSleY9j106wHlgcgXI6YZSu8mEAECCyOqjiP0CfyCVMB0sSGyqKHHU
	 ZUf/6kuQ4Uljd/R2vwyIrAaBVfWSF4BlsSyTjVsZjQCPdz3xl1iWEU5s1iKtxHLYNI
	 LOsKLuWDAIPwlZPfhviMdvqx38VP/NkdEAQgRFfTL8DUheyshiciXgK/VWWG/T3tTq
	 3NGPBu0kOld+g==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>,
  <ath11k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,
  Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
Subject: Re: [PATCHv5] wifi: ath11k: skip status ring entry processing
References: <20240429073624.736147-1-quic_tamizhr@quicinc.com>
	<35f114c4-1ff7-4a4b-aadf-ed147f19e170@quicinc.com>
Date: Tue, 30 Apr 2024 16:48:50 +0300
In-Reply-To: <35f114c4-1ff7-4a4b-aadf-ed147f19e170@quicinc.com> (Jeff
	Johnson's message of "Mon, 29 Apr 2024 11:12:49 -0700")
Message-ID: <87cyq7ota5.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 4/29/2024 12:36 AM, Tamizh Chelvam Raja wrote:
>
>> From: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
>> 
>> If STATUS_BUFFER_DONE is not set for a monitor status ring entry,
>> we don't process the status ring until STATUS_BUFFER_DONE set
>> for that status ring entry.
>> 
>> During LMAC reset it may happen that hardware will not write
>> STATUS_BUFFER_DONE tlv in status buffer, in that case we end up
>> waiting for STATUS_BUFFER_DONE leading to backpressure on monitor
>> status ring.
>> 
>> To fix the issue, when HP(Head Pointer) + 1 entry is peeked and if DMA
>> is not done and if HP + 2 entry's DMA done is set,
>> replenish HP + 1 entry and start processing in next interrupt.
>> If HP + 2 entry's DMA done is not set, poll onto HP + 1 entry DMA
>> done to be set.
>> 
>> Also, during monitor attach HP points to the end of the ring and
>> TP(Tail Pointer) points to the start of the ring.
>> Using ath11k_hal_srng_src_peek() may result in processing invalid buffer
>> for the very first interrupt. Since, HW starts writing buffer from TP.
>> 
>> To avoid this issue call ath11k_hal_srng_src_next_peek() instead of
>> calling ath11k_hal_srng_src_peek().
>> 
>> Tested-on: IPQ5018 hw1.0 AHB WLAN.HK.2.6.0.1-00861-QCAHKSWPL_SILICONZ-1
>> 
>> Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
>> Co-developed-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
>> Signed-off-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>
> however note...
>
>> +
>> +				/* If done status is missing:
>> +				 * 1. As per MAC team's suggestion,
>> +				 *    when HP + 1 entry is peeked and if DMA
>> +				 *    is not done and if HP + 2 entry's DMA done
>> +				 *    is set. skip HP + 1 entry and
>> +				 *    start processing in next interrupt.
>> +				 * 2. If HP + 2 entry's DMA done is not set,
>> +				 *    poll onto HP + 1 entry DMA done to be set.
>> +				 *    Check status for same buffer for next time
>> +				 *    dp_rx_mon_status_srng_process
>> +				 */
>> +
>> + reap_status = ath11k_dp_rx_mon_handle_status_buf_done(ab, srng,
>> + rx_ring);
>
> ath11k-check reports:
>
> drivers/net/wireless/ath/ath11k/dp_rx.c:3116: line length of 95 exceeds 90 columns
> drivers/net/wireless/ath/ath11k/dp_rx.c:3117: line length of 95 exceeds 90 columns

Tamizh, please ALWAYS run ath11k-check. We are wasting time for trivial
stuff like this.

> Kalle, in this case we may want to make an exception since I don't think there
> is a clean way to fix this other than refactoring.

The new function name looked quite long so I shortened it to
ath11k_dp_rx_mon_buf_done() and the warning is now gone. Does that look
reasonable name?

Also I removed one unrelated change and removed unnecessary else. Please
check my changes:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=6e88d559268779107715008c51e006f7a5f62045

But now I noticed that the warning message needs some work:

ath11k_warn(ab, "mon status DONE not set %lx, buf_id %d\n",
	    FIELD_GET(HAL_TLV_HDR_TAG, tlv->tl),
	    buf_id);

Please use understandable warning and error messages in plain english.
Any suggestions? I can edit the commit in the pending branch.

> FWIW I'd like to see this function refactored to avoid the excessive
> indentation, but that should be a separate exercise.

Indeed, the indentation in this function is getting close to the limit.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

