Return-Path: <linux-wireless+bounces-6928-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A47978B3677
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Apr 2024 13:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D67F2851BC
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Apr 2024 11:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9B0144D3C;
	Fri, 26 Apr 2024 11:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+ccKbVZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9CB13F01A
	for <linux-wireless@vger.kernel.org>; Fri, 26 Apr 2024 11:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714130664; cv=none; b=ED4W6eVDFm2yez2V8++6oFaYgvMr/Q2eXutqUV1Qo5PID8G65zJuLNXJyq5YC/kqSok6r7OkQxjkhE4ZkkAaeSVlE+JqZ960VT3i9FDSwR0Fk5zqvAB9ZAQg4miLU8gqapVjWVax8/JLlp00ulriN6oxh9NgfQJy0tzitLUjBCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714130664; c=relaxed/simple;
	bh=R9JX84BXKQf4UHZRk81RPQG7Gd4aJssAqnYn3UH2Ef8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=NSvYs6lQ5iAARnUH61Y8mPppKhhOlq0tqeV2Fg+1o+DbXARnKdVIk1EKmLe97d2Ixtc9fmWnlkGZa56S69Gd36SkAT+3fKvIaNnvn/X/QswXBgFgaTTn+XtOSmGybRfYkyrnCZ6PyH+MG+h8dWScbnyeOlaFX+LvFHOGKXImMHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+ccKbVZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF223C113CD;
	Fri, 26 Apr 2024 11:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714130663;
	bh=R9JX84BXKQf4UHZRk81RPQG7Gd4aJssAqnYn3UH2Ef8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=j+ccKbVZI0l10IW8Vlgc6LbKc7gEG8ExC8lik04Y0zdQbiVfZdcXbFYoeo/CfdaJh
	 fFlwlrWdlEUqzzULPbCif5e8w7201DTFNIKQnNjpIxc9CmJuTzf/vygG4LZya98U/E
	 +abl9PL2/BaXEx6q4vPrjXES/e2jNaIjUD5XWolwVoOnUDsnkv6Uwq9E9c9n0nUMiX
	 5ZZf6RLBhDwG28sVTHSxCAZ1STBk68gHfiw2xS/FjvVH2NkNOXKx4UwFqz0no39Et4
	 /bmo2vdcu3XlVhLeOUouWENjRA/ui99sZT4BVsV+9dqUeWjBXGkwVlqrJdKGrhGF/C
	 d1OPcWelWMCAg==
From: Kalle Valo <kvalo@kernel.org>
To: Lingbo Kong <quic_lingbok@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] wifi: ath12k: report station mode transmit rate
References: <20240419032122.7009-1-quic_lingbok@quicinc.com>
	<20240419032122.7009-2-quic_lingbok@quicinc.com>
	<87r0etsp6u.fsf@kernel.org>
	<c01db4fc-03a0-41f6-9f16-bfa3b2c08007@quicinc.com>
Date: Fri, 26 Apr 2024 14:24:21 +0300
In-Reply-To: <c01db4fc-03a0-41f6-9f16-bfa3b2c08007@quicinc.com> (Lingbo Kong's
	message of "Fri, 26 Apr 2024 16:01:19 +0800")
Message-ID: <87r0esqsd6.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lingbo Kong <quic_lingbok@quicinc.com> writes:

> On 2024/4/25 18:37, Kalle Valo wrote:
>> Lingbo Kong <quic_lingbok@quicinc.com> writes:
>> 
>>> Currently, the transmit rate of "iw dev xxx station dump" command
>>> always show an invalid value.
>>>
>>> To address this issue, ath12k parse the info of transmit complete
>>> report from firmware and indicate the transmit rate to mac80211.
>>>
>>> This patch affects the station mode of WCN7850 and QCN9274.
>>>
>>> After that, "iw dev xxx station dump" show the correct transmit rate.
>>> Such as:
>>>
>>> Station 00:03:7f:12:03:03 (on wlo1)
>>>          inactive time:  872 ms
>>>          rx bytes:       219111
>>>          rx packets:     1133
>>>          tx bytes:       53767
>>>          tx packets:     462
>>>          tx retries:     51
>>>          tx failed:      0
>>>          beacon loss:    0
>>>          beacon rx:      403
>>>          rx drop misc:   74
>>>          signal:         -95 dBm
>>>          beacon signal avg:      -18 dBm
>>>          tx bitrate:     1441.1 MBit/s 80MHz EHT-MCS 13 EHT-NSS 2 EHT-GI 0
>>>
>>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.2.1-00201-QCAHKSWPL_SILICONZ-1
>>>
>>> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
>> [...]
>> 
>>> +static void ath12k_dp_tx_update(struct ath12k *ar, struct hal_tx_status *ts)
>>> +{
>>> +	if (ar->last_ppdu_id != 0) {
>>> +		if (ar->last_ppdu_id == ts->ppdu_id ||
>>> +		    ar->cached_ppdu_id == ar->last_ppdu_id)
>>> +			ar->cached_ppdu_id = ar->last_ppdu_id;
>>> +
>>> +		ath12k_dp_tx_update_txcompl(ar, ts);
>>> +	}
>>> +
>>> +	ar->last_ppdu_id = ts->ppdu_id;
>>> +}
>> A code comment would help a lot. Why is ar->cached_ppdu_id needed
>> here?
>> And if 'ar->cached_ppdu_id == ar->last_ppdu_id' is true why do then
>> do
>> 'ar->cached_ppdu_id = ar->last_ppdu_id'? The value of ar->cached_ppdu_id
>> is not changing here (unless I'm missing something).
>> Also I'm worried about locking. How is access to ar->last_ppdu_id
>> and
>> ar->cached_ppdu_id protected?
>> 
>
> Thanks for pointing to this.
> you're right, the ar->cached_ppdu_id haven't used in here, so need to
> delete it.
> i missed something in here.
>
> So, change the ath12k_dp_tx_update(struct ath12k *ar, struct
> hal_tx_status *ts) to
> static void ath12k_dp_tx_update(struct ath12k *ar, struct hal_tx_status *ts)
> {
> 	if (ts->flags & HAL_TX_STATUS_FLAGS_FIRST_MSDU) {
> 		if (ar->last_ppdu_id != 0)
> 			ath12k_dp_tx_update_txcompl(ar, ts);
> 		ar->last_ppdu_id = ts->ppdu_id;
> 	}
> }

Access to ar->last_ppdu_id still looks racy to me.

And why do we need to track last_ppdu_id? I don't have time to start
investigating that right now, a code comment explaining that would help
a lot.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

