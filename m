Return-Path: <linux-wireless+bounces-8192-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9BF8D191D
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 13:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E914F1C212D2
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 11:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9196513C819;
	Tue, 28 May 2024 11:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LuhkYiuw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB842745B
	for <linux-wireless@vger.kernel.org>; Tue, 28 May 2024 11:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716894383; cv=none; b=X+GnfDbaz3vD3q/Ly37pgbYO45TfMFTYmGxZ24IWH3/S8PtWxxgQOL39zjIiZLVnGMwqMBdjOx/cs2u0/nUitNWaKaIQA48gPRRItX95A6j6cwCpi1+kVjaw74OzY1KbnjeQ3M0veU22Hpk5Hd4PocHxN9VAstVhcoK1MDTSJ8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716894383; c=relaxed/simple;
	bh=OFv/XQ7TNpRWDLL7BFsEL4AhJkfJ4AV+GjTSjS5J4hQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=cRxVP2CIGeJ9ll17jBnnHpEYLaNuGM7g1A1OpwHiF8WPwnpPjIp0cs14Dno5ABcjZCt1GFxHpc+HYHAfxUO3sJ4X71PUOKrE04hSEKS4gHX1d2asjtHWLm0otLADzaTZNkgH8zepmkr5CszzSjhFsxWWFZLCo6BrlPMosRriovk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LuhkYiuw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B33DC3277B;
	Tue, 28 May 2024 11:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716894383;
	bh=OFv/XQ7TNpRWDLL7BFsEL4AhJkfJ4AV+GjTSjS5J4hQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=LuhkYiuwfZIhwJ7aNOWXnj123F88a3WBjc2t4h5ygqe/3cUwlZt6nLVZo/xhtOQkR
	 +2bP3WvbicsumVeCdGwTt7Nj+WRjRRIBWzLNTUBZqjNOVU5ss0NHSyCU8aZrbhZKCP
	 E+cnvGzFCDE3NTnBC98u9FN640clFKmWnT1XWqImO4lZzDP8LUArN7MpAyhl3O9VCN
	 vbsk7vVJ1o28dAB4+tdAIL8tHHrvx+aUOQKRJXb2Rkf4XLmJ74QEWS+YBbVEzORGz2
	 +cwhnpuxVEakZUdHDSOrhl7K1cw0sY30xyadZXiHd8TZ8e2157sxU7/QwN/Er4K+E7
	 hmZzqMxUAdVuw==
From: Kalle Valo <kvalo@kernel.org>
To: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] wifi: ath12k: Dump additional Tx PDEV HTT stats
References: <20240510050806.514126-1-quic_rgnanase@quicinc.com>
	<20240510050806.514126-6-quic_rgnanase@quicinc.com>
	<87le43d26u.fsf@kernel.org>
	<024e2594-309a-4549-9c69-d527717c5dd4@quicinc.com>
Date: Tue, 28 May 2024 14:06:20 +0300
In-Reply-To: <024e2594-309a-4549-9c69-d527717c5dd4@quicinc.com> (Ramya
	Gnanasekar's message of "Mon, 27 May 2024 15:08:40 +0530")
Message-ID: <87r0dm6vrn.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ramya Gnanasekar <quic_rgnanase@quicinc.com> writes:

>>> +static inline void
>>> +ath12k_htt_print_tx_pdev_mu_ppdu_dist_stats_tlv(const void *tag_buf,
>>> +						struct debug_htt_stats_req *stats_req)
>>> +{
>>> + const struct ath12k_htt_tx_pdev_mu_ppdu_dist_stats_tlv
>>> *htt_stats_buf = tag_buf;
>>> +	char *mode;
>>> +	u8 j, hw_mode, i, str_buf_len;
>>> +	u8 *buf = stats_req->buf;
>>> +	u32 len = stats_req->buf_len;
>>> +	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
>>> +	u32 stats_value;
>>> +	u8 max_ppdu = ATH12K_HTT_STATS_MAX_NUM_MU_PPDU_PER_BURST;
>>> +	u8 max_sched = ATH12K_HTT_STATS_MAX_NUM_SCHED_STATUS;
>>> +	char str_buf[ATH12K_HTT_MAX_STRING_LEN];
>>> +
>>> +	hw_mode = le32_to_cpu(htt_stats_buf->hw_mode);
>>> +
>>> +	switch (hw_mode) {
>>> +	case ATH12K_HTT_STATS_HWMODE_AC:
>>> +		len += scnprintf(buf + len, buf_len - len,
>>> +				 "HTT_TX_PDEV_MU_PPDU_DISTRIBUTION_STATS:\n");
>>> +		mode = "ac";
>>> +		break;
>>> +	case ATH12K_HTT_STATS_HWMODE_AX:
>>> +		mode = "ax";
>>> +		break;
>>> +	case ATH12K_HTT_STATS_HWMODE_BE:
>>> +		mode = "be";
>>> +		break;
>>> +	default:
>>> +		return;
>>> +	}
>> 
>> Why are we not adding "HTT_TX_PDEV_MU_PPDU_DISTRIBUTION_STATS:\n" with
>> ax and be modes?
>> 
> Sorry for the delayed response. I was on OoO for a week.

No worries.

> We will receive this TLV for each hw modes. Since
> "HTT_TX_PDEV_MU_PPDU_DISTRIBUTION_STATS:\n" is header and it would be
> suffice to print it once, hence added it inside hw mode ac which will be
> the first hw mode integrated inside the TLV.

I would have expected that we print that outside of
ath12k_htt_print_tx_pdev_mu_ppdu_dist_stats_tlv(), before the function
is called at all.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

