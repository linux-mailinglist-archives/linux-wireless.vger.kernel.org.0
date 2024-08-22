Return-Path: <linux-wireless+bounces-11808-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8922B95BC6F
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 18:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7DB61C23008
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 16:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4E71CDA23;
	Thu, 22 Aug 2024 16:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4K59aSi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C098B182DF;
	Thu, 22 Aug 2024 16:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724345413; cv=none; b=BQELr2mlgaL1Kwl/+4LA9RvWckGh6HeSrTSDAfas9J/r4siyE6TmWZayp18ykSdmkdN89CkSvRfkC0785SRPCF6E/qNhoTM9C2VzkmxlJRmghPw2fHxqaTJvlMByvoCRvAmpCpG5V43HGNbUbhPlACB9RzO2Z+sHIbnEwxj3xNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724345413; c=relaxed/simple;
	bh=+fNrTItCT2YwGN+dojlHcg8wSI5mEQWYNR8QSA6wH8A=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=BYc2ADQ1cUYmnLBjwyLLQuWWG3NtIEJXSQwWgYLiu+XugKRp9+tZyvIIC138mysFNHe+8Rkl67Q+q8RfzZbc+jGLGsI1qXxPrvdc8gqidHCr8kouyZwBMfoPqB8wYEGtdaHlQ5uPU99S+v5IwTQkgagJgjh15TLKG66NSW7UvfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4K59aSi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD69CC4AF0F;
	Thu, 22 Aug 2024 16:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724345413;
	bh=+fNrTItCT2YwGN+dojlHcg8wSI5mEQWYNR8QSA6wH8A=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=C4K59aSinf7Nds94klrGvAj7XbveK9nhD9+YPIZcrhQt0XDARKVvYbm8YycxSTcRz
	 dlkkFQqwGUlsIHD8w1CpiOQuAIYOwxedeMXs+SeWyklLe10NDOOp39VXZ5YEyt4G/9
	 nK839XUKK3IW8Fx3sp53XeLPsOQAu/Y6bPI3gYmSgfuytNHmHQkEXcK817VWeWb3ct
	 ZFSuKCR54xd78exXaX+y6+z+ds0dpZq9tqpal1lMrvRAZQeiPt1/A0kAoFQjKEfSLg
	 gNtQLNrkR8Cr+k5dA3ODvt760gkncNUeO5VGOgmLU6kYzTDrmqpi5Np64pd+7q4YoP
	 bcNPc8qA/TOIw==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,  Jeff Johnson
 <jjohnson@kernel.org>,  <linux-wireless@vger.kernel.org>,
  <ath11k@lists.infradead.org>,  <linux-kernel@vger.kernel.org>,
  <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH][next] wifi: ath11k: Avoid
 -Wflex-array-member-not-at-end warnings
References: <ZrZB3Rjswe0ZXtug@cute>
	<8d31adac-fd43-4cf9-8fc8-655b359a573c@quicinc.com>
Date: Thu, 22 Aug 2024 19:50:09 +0300
In-Reply-To: <8d31adac-fd43-4cf9-8fc8-655b359a573c@quicinc.com> (Jeff
	Johnson's message of "Fri, 9 Aug 2024 19:21:10 -0700")
Message-ID: <871q2gwlha.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 8/9/2024 9:20 AM, Gustavo A. R. Silva wrote:
>
>> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
>> getting ready to enable it, globally.
>> 
>> Move the conflicting declaration to the end of the structure. Notice
>> that `struct ieee80211_chanctx_conf` is a flexible structure --a
>> structure that contains a flexible-array member.
>> 
>> Also, remove a couple of unused structures.
>> 
>> Fix the following warnings:
>> drivers/net/wireless/ath/ath11k/core.h:409:39: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>> drivers/net/wireless/ath/ath11k/dp.h:1309:24: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>> drivers/net/wireless/ath/ath11k/dp.h:1368:24: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>> 
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>>  drivers/net/wireless/ath/ath11k/core.h |  4 +++-
>>  drivers/net/wireless/ath/ath11k/dp.h   | 23 -----------------------
>>  2 files changed, 3 insertions(+), 24 deletions(-)
>> 
>> diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
>> index df24f0e409af..e283415dccf3 100644
>> --- a/drivers/net/wireless/ath/ath11k/core.h
>> +++ b/drivers/net/wireless/ath/ath11k/core.h
>> @@ -406,11 +406,13 @@ struct ath11k_vif {
>>  	bool wpaie_present;
>>  	bool bcca_zero_sent;
>>  	bool do_not_send_tmpl;
>> -	struct ieee80211_chanctx_conf chanctx;
>>  	struct ath11k_arp_ns_offload arp_ns_offload;
>>  	struct ath11k_rekey_data rekey_data;
>>  
>>  	struct ath11k_reg_tpc_power_info reg_tpc_info;
>> +
>> +	/* Must be last - ends in a flexible-array member. */
>> +	struct ieee80211_chanctx_conf chanctx;
>
> there is something illogical about this since the vif is allocated using
> sizeof() and hence there will never be memory allocated for the flexible
> array, and it is assigned using either struct assignment or memcpy using the
> struct size which (fortunately) would not transfer the flexible array contents:
> 		arvif->chanctx = *ctx;
>
> 		memcpy(&arvif->chanctx, ctx, sizeof(*ctx));
>
> since ath11k doesn't actually use the drv_priv[] I guess this change is OK, it
> is just strange to me.
>
> also makes me wonder why ath11k keeps a copy of the chanctx instead of just
> getting it from the underlying ieee80211_link_data. but that is outside the
> scope of this discussion.

Yeah, this doesn't look right. I don't think a driver should be copying
struct ieee80211_chanctx_conf like that. I think I'll add a comment
about this to the code:

/* FIXME: Driver should not copy struct ieee80211_chanctx_conf,
 * especially because it has a flexible array. Find a better way.
 */

Thoughts?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html

