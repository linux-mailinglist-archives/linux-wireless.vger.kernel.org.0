Return-Path: <linux-wireless+bounces-8351-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7FA8D689D
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 20:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1870B1F23A6B
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 18:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C752E63B;
	Fri, 31 May 2024 18:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNKTL/jN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2C0208B0
	for <linux-wireless@vger.kernel.org>; Fri, 31 May 2024 18:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717178426; cv=none; b=mBX3EcJYsViP7AUqsbn5Ezh1OJNacKzqS4+1HwhAu2XZ5oQdjZRObLPMkanCDe9PLkbJrGtdFumGiNtpklLyAxSPG8U9tAlNszZn+4nkz1KluWFVWlIXqmSpdwTD7cQBqMO5K2OxhRpudNxKbf65RiWxyhvF5+rO3Wif/zLyopE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717178426; c=relaxed/simple;
	bh=qlU+WYP7/d64bQDIKAIfVrPzMMEKKHCH53akTxStboM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=S7ok63vCpyowAcvwKfBe2qIC7SpYYTCnUhsW5kQAmduIXUWx/6jeG+aOr9GXdfkPgBz8BXNYAGjz9gGLbVk06QDFN77RWOMD0wbhSOSomu4FCqNfWjOVr7VTL+v4+ZyeJk9ULc7mqRw9D/km72i7rQ5MRl/+cF6aySTJuyXhD2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNKTL/jN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3199C116B1;
	Fri, 31 May 2024 18:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717178425;
	bh=qlU+WYP7/d64bQDIKAIfVrPzMMEKKHCH53akTxStboM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=lNKTL/jNEiGb4YbmYyYpb0yznZrbnZAH76r+euDZAWw2ddMSrKIJwz0cLi2L8E/+h
	 49D9KYx5JtN3IE7zKkCr87TfwH39P8a0FGrlVeqtv8y2wAf0R5S+O+8KKUZ0l5lzCH
	 uAEx1ypz4TB9UC7cTF3Lup3klluADc0iWBXijEFJl0E++QZID907DWBo/ymRI9+3TU
	 lX0MzI7JRqqt1/P8bEkG52O0fb+XfnNXQAISI2riELgMd20vB/OmDIJtkKjYd8ZXVw
	 t2BDTSWVLXzpGqsLTOz4uCXRjoOQ5ptpsaxp3491zUvsraY0gK44RjK/nw6zxVwf68
	 QVBAlP1tQgNMA==
From: Kalle Valo <kvalo@kernel.org>
To: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] wifi: ath12k: Dump additional Tx PDEV HTT stats
References: <20240510050806.514126-1-quic_rgnanase@quicinc.com>
	<20240510050806.514126-6-quic_rgnanase@quicinc.com>
	<87le43d26u.fsf@kernel.org>
	<024e2594-309a-4549-9c69-d527717c5dd4@quicinc.com>
	<87r0dm6vrn.fsf@kernel.org>
	<1be3531d-b550-4b19-93bb-d41e93362e19@quicinc.com>
Date: Fri, 31 May 2024 21:00:22 +0300
In-Reply-To: <1be3531d-b550-4b19-93bb-d41e93362e19@quicinc.com> (Ramya
	Gnanasekar's message of "Tue, 28 May 2024 22:18:18 +0530")
Message-ID: <87plt1vp3d.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ramya Gnanasekar <quic_rgnanase@quicinc.com> writes:

> On 5/28/2024 4:36 PM, Kalle Valo wrote:
>> Ramya Gnanasekar <quic_rgnanase@quicinc.com> writes:
>> 
>>>>> +static inline void
>>>>> +ath12k_htt_print_tx_pdev_mu_ppdu_dist_stats_tlv(const void *tag_buf,
>>>>> +						struct debug_htt_stats_req *stats_req)
>>>>> +{
>>>>> + const struct ath12k_htt_tx_pdev_mu_ppdu_dist_stats_tlv
>>>>> *htt_stats_buf = tag_buf;
>>>>> +	char *mode;
>>>>> +	u8 j, hw_mode, i, str_buf_len;
>>>>> +	u8 *buf = stats_req->buf;
>>>>> +	u32 len = stats_req->buf_len;
>>>>> +	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
>>>>> +	u32 stats_value;
>>>>> +	u8 max_ppdu = ATH12K_HTT_STATS_MAX_NUM_MU_PPDU_PER_BURST;
>>>>> +	u8 max_sched = ATH12K_HTT_STATS_MAX_NUM_SCHED_STATUS;
>>>>> +	char str_buf[ATH12K_HTT_MAX_STRING_LEN];
>>>>> +
>>>>> +	hw_mode = le32_to_cpu(htt_stats_buf->hw_mode);
>>>>> +
>>>>> +	switch (hw_mode) {
>>>>> +	case ATH12K_HTT_STATS_HWMODE_AC:
>>>>> +		len += scnprintf(buf + len, buf_len - len,
>>>>> +				 "HTT_TX_PDEV_MU_PPDU_DISTRIBUTION_STATS:\n");
>>>>> +		mode = "ac";
>>>>> +		break;
>>>>> +	case ATH12K_HTT_STATS_HWMODE_AX:
>>>>> +		mode = "ax";
>>>>> +		break;
>>>>> +	case ATH12K_HTT_STATS_HWMODE_BE:
>>>>> +		mode = "be";
>>>>> +		break;
>>>>> +	default:
>>>>> +		return;
>>>>> +	}
>>>>
>>>> Why are we not adding "HTT_TX_PDEV_MU_PPDU_DISTRIBUTION_STATS:\n" with
>>>> ax and be modes?
>>>>
>>> Sorry for the delayed response. I was on OoO for a week.
>> 
>> No worries.
>> 
>>> We will receive this TLV for each hw modes. Since
>>> "HTT_TX_PDEV_MU_PPDU_DISTRIBUTION_STATS:\n" is header and it would be
>>> suffice to print it once, hence added it inside hw mode ac which will be
>>> the first hw mode integrated inside the TLV.
>> 
>> I would have expected that we print that outside of
>> ath12k_htt_print_tx_pdev_mu_ppdu_dist_stats_tlv(), before the function
>> is called at all.
>> 
>
> Function itself will be called more than once.

Sure, I got that. But I still think it is not really good design to
print it like that.

Maybe the output could be something like below? Or print the mode
separate in the first line?

HTT_TX_PDEV_MU_PPDU_DISTRIBUTION_STATS:

ac_mu_mimo_num_seq_posted_nr4 = 0
ac_mu_mimo_num_ppdu_posted_per_burst_nr4 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,
ac_mu_mimo_num_ppdu_completed_per_burst_nr4 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,
ac_mu_mimo_num_seq_term_status_nr4 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0,

....

HTT_TX_PDEV_MU_PPDU_DISTRIBUTION_STATS:

ax_mu_mimo_num_seq_posted_nr4 = 0
ax_mu_mimo_num_ppdu_posted_per_burst_nr4 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,
ax_mu_mimo_num_ppdu_completed_per_burst_nr4 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,
ax_mu_mimo_num_seq_term_status_nr4 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0,

ax_mu_mimo_num_seq_posted_nr8 = 0
ax_mu_mimo_num_ppdu_posted_per_burst_nr8 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,
ax_mu_mimo_num_ppdu_completed_per_burst_nr8 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,
ax_mu_mimo_num_seq_term_status_nr8 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0,

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

