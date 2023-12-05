Return-Path: <linux-wireless+bounces-429-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CACF78058AA
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Dec 2023 16:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8365D281F9E
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Dec 2023 15:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BE968EA1;
	Tue,  5 Dec 2023 15:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUkDezEB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5A0AD56
	for <linux-wireless@vger.kernel.org>; Tue,  5 Dec 2023 15:29:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A90DC433C9;
	Tue,  5 Dec 2023 15:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701790152;
	bh=MfLafCfcRaDpmdszQrVQWn7XO/mPGu2x0vw5QhEpwMU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=hUkDezEB4Iwi6LnBU9YZQVH/Z3YCUHfzhbNV5af7LhhqlzL0gSQPDaiLyjeP/KkKr
	 529hiF43YIwRbaELj0t2q9r2MbylgnOGoPzn2e+cdTIksEkwHCQ9a4GS1q/gpjRPsM
	 msDyp2mexulTyX3XHpruoKphejmCACcFV2QYVQNvM2TiAAT4P3ek9swSkoGYUoJE9X
	 EUxuE55TQuqxMqcUcmHK7jXBkH9JIJCoqUx8tH0KLyCYRUgrTJP2WyP3qj0WPWrp2I
	 Hy1+kqUUG5WtYuzqJWC7PTdDpFiuJaHQH1MyTPRQWGh8pARz2EkIVoxEEpF1L763he
	 g/qK06yXDCOYg==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,  "Gustavo A. R. Silva"
 <gustavoars@kernel.org>,  Kees Cook <keescook@chromium.org>,
  <ath10k@lists.infradead.org>,  <ath11k@lists.infradead.org>,
  <linux-wireless@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] wifi: ath11k: Use DECLARE_FLEX_ARRAY() for
 ath11k_htc_record
References: <20231127-flexarray-htc_record-v1-0-6be1f36126fd@quicinc.com>
	<20231127-flexarray-htc_record-v1-4-6be1f36126fd@quicinc.com>
	<4f2a486c-c6de-43e4-8bb6-bdd3f819b0a9@embeddedor.com>
	<c5555ad6-6991-4fca-864f-355d2fae9ae1@quicinc.com>
Date: Tue, 05 Dec 2023 17:29:08 +0200
In-Reply-To: <c5555ad6-6991-4fca-864f-355d2fae9ae1@quicinc.com> (Jeff
	Johnson's message of "Mon, 27 Nov 2023 08:32:51 -0800")
Message-ID: <87edg0pt17.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 11/27/2023 8:23 AM, Gustavo A. R. Silva wrote:
>
>> 
>> 
>> On 11/27/23 10:14, Jeff Johnson wrote:
>>> Transform the zero-length array in ath11k_htc_record into a proper
>>> flexible array via the DECLARE_FLEX_ARRAY() macro. This helps with
>>> ongoing efforts to globally enable -Warray-bounds.
>>>
>>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>>> ---
>>>   drivers/net/wireless/ath/ath11k/htc.h | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/wireless/ath/ath11k/htc.h b/drivers/net/wireless/ath/ath11k/htc.h
>>> index 84971cc9251c..e0434b29df70 100644
>>> --- a/drivers/net/wireless/ath/ath11k/htc.h
>>> +++ b/drivers/net/wireless/ath/ath11k/htc.h
>>> @@ -151,7 +151,7 @@ struct ath11k_htc_credit_report {
>>>   struct ath11k_htc_record {
>>>   	struct ath11k_htc_record_hdr hdr;
>>>   	union {
>>> -		struct ath11k_htc_credit_report credit_report[0];
>>> +		DECLARE_FLEX_ARRAY(struct ath11k_htc_credit_report, credit_report);
>>>   	};
>> 
>> Why not removing the `union` and just do a direct transformation [0] -> [ ] ?
>
> No reason other than staying consistent with ath10k.
> Will see if Kalle has an opinion on this.

Yeah, I don't see the need for the union and I removed it in the pending
branch:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=a2faeea1fe0635563187e7821a6d0baf7b40f2c6

Does it look ok?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

