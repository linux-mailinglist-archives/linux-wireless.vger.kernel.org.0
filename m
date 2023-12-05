Return-Path: <linux-wireless+bounces-436-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E49805EF6
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Dec 2023 21:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2FAD1F21671
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Dec 2023 20:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6C46ABB6;
	Tue,  5 Dec 2023 20:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUHYATuQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF67A6AB96
	for <linux-wireless@vger.kernel.org>; Tue,  5 Dec 2023 20:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D6FC433C7;
	Tue,  5 Dec 2023 20:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701806418;
	bh=RBZVphrxSnYDxF8yl0ilHhdMH6viddnORNq4gQqJ+FE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=XUHYATuQ/GyNS+eZhUMbDiK7+hG9idnMSxzD4uDk+N0wysPaKZguSD3hxd3LdWcyY
	 8BGn28THz+MZ85eeWikC1v1iUru28mUFQezzjs1YeYCNNEuNJN5qjBXQA8gSu+5b2h
	 T3zyBP9qC67eCgjpVaeRu1aAJgs3tqW4idua8mS58CpyIv5ClAvLgFWRXXuTr+LGEO
	 DAIJJMM0LyvLC87c9hDHMu8IDfnuyMgmpXzGrvxPRREjZFQNWCulayqLtPg9KIqNYh
	 X9Ii7VPijVx5+8btcMKc6vUApMk5MWU5l3GgR76xBHJPs36JnreWHhKWNO/+mhgYCN
	 Yf/JCBDHFQBsw==
From: Kalle Valo <kvalo@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,  "Gustavo A. R. Silva"
 <gustavoars@kernel.org>,  Kees Cook <keescook@chromium.org>,
  ath10k@lists.infradead.org,  ath11k@lists.infradead.org,
  linux-wireless@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] wifi: ath11k: Use DECLARE_FLEX_ARRAY() for
 ath11k_htc_record
References: <20231127-flexarray-htc_record-v1-0-6be1f36126fd@quicinc.com>
	<20231127-flexarray-htc_record-v1-4-6be1f36126fd@quicinc.com>
	<4f2a486c-c6de-43e4-8bb6-bdd3f819b0a9@embeddedor.com>
	<c5555ad6-6991-4fca-864f-355d2fae9ae1@quicinc.com>
	<87edg0pt17.fsf@kernel.org>
	<30ea9d68-e49e-4727-88aa-547b1b0feebf@embeddedor.com>
Date: Tue, 05 Dec 2023 22:00:14 +0200
In-Reply-To: <30ea9d68-e49e-4727-88aa-547b1b0feebf@embeddedor.com> (Gustavo A.
	R. Silva's message of "Tue, 5 Dec 2023 09:45:57 -0600")
Message-ID: <875y1cpghd.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Gustavo A. R. Silva" <gustavo@embeddedor.com> writes:

> On 12/5/23 09:29, Kalle Valo wrote:
>> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
>> 
>>> On 11/27/2023 8:23 AM, Gustavo A. R. Silva wrote:
>>>
>>>>
>>>>
>>>> On 11/27/23 10:14, Jeff Johnson wrote:
>>>>> Transform the zero-length array in ath11k_htc_record into a proper
>>>>> flexible array via the DECLARE_FLEX_ARRAY() macro. This helps with
>>>>> ongoing efforts to globally enable -Warray-bounds.
>>>>>
>>>>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>>>>> ---
>>>>>    drivers/net/wireless/ath/ath11k/htc.h | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/net/wireless/ath/ath11k/htc.h b/drivers/net/wireless/ath/ath11k/htc.h
>>>>> index 84971cc9251c..e0434b29df70 100644
>>>>> --- a/drivers/net/wireless/ath/ath11k/htc.h
>>>>> +++ b/drivers/net/wireless/ath/ath11k/htc.h
>>>>> @@ -151,7 +151,7 @@ struct ath11k_htc_credit_report {
>>>>>    struct ath11k_htc_record {
>>>>>    	struct ath11k_htc_record_hdr hdr;
>>>>>    	union {
>>>>> -		struct ath11k_htc_credit_report credit_report[0];
>>>>> +		DECLARE_FLEX_ARRAY(struct ath11k_htc_credit_report, credit_report);
>>>>>    	};
>>>>
>>>> Why not removing the `union` and just do a direct transformation [0] -> [ ] ?
>>>
>>> No reason other than staying consistent with ath10k.
>>> Will see if Kalle has an opinion on this.
>> Yeah, I don't see the need for the union and I removed it in the
>> pending
>> branch:
>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=a2faeea1fe0635563187e7821a6d0baf7b40f2c6
>> Does it look ok?
>> 
>
> Nope.
>
> A direct transformation is just fine:
>
> -	union {
> -		struct ath11k_htc_credit_report credit_report[0];
> -	};
> +	struct ath11k_htc_credit_report credit_report[];
>
> There is no need for DFA in this situation.

Sorry, I read your comments too hastily. Jeff, as I'm offline tomorrow
would you mind submitting v2?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

