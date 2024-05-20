Return-Path: <linux-wireless+bounces-7847-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B50C08C9FC3
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2024 17:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54C461F21B84
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2024 15:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA500136E0C;
	Mon, 20 May 2024 15:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XixFXTyS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9FD55782;
	Mon, 20 May 2024 15:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716219282; cv=none; b=aZd2GaTCv706oI5q+5S31gsONnB5Gj5k3tnqMsHZn13ndj496tOMdFptlGqHYR5o5AutU2CPLB23iStsgZmQ+RwcisoIdsphuZIvYg4t2If7AwVdghfqMClTUGxl3QDzI83uGmi2Zpj+bTA74fZT7ANPbmiQgtBFnyLiYgyBCAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716219282; c=relaxed/simple;
	bh=Iql17hNOkntU/TEX70CbOa8Oc4J0CcgtLaFX5lJfHiU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=myuiPqFaupde0fs/j41vz0kbSD/hzn2n5/NZk0x/FRAPywGYl8M3rApY8BoB7AdyowVPJjBscBNSJlVZWbeqjKMWWUtDNYGHW5oClAMKzEwq+C4nEjfpy4AzAUPe58bkFSO3/PHqlmjv6RvxO0bBvUbi6wfgsR+h9RQBWiLduew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XixFXTyS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164BAC32789;
	Mon, 20 May 2024 15:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716219282;
	bh=Iql17hNOkntU/TEX70CbOa8Oc4J0CcgtLaFX5lJfHiU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=XixFXTySIXU6MYB/gKzec07HMWEKKFYxZdSlTizu3cEEJboWHNEXIVMOH+N+I3nWd
	 EN8AWqbYFYeNOrOZzbWf3RRHO2414UsH+e5knfZgrGjcMuQP1fRXJyKs+CuB0DrbJr
	 6BnGqwdiFNFCIq54LQxiVXV7cIPAnhcGcwlFztw/9rdRrVkBr9F5yTM8dshmO/SsVe
	 PD8dZ/zeE5s36XgEsS0ZvS6l99vKpyXJW6+GBaeOdUSHfaUasUQltQMzJCYGaIRGKy
	 vq0rHaQq7vKo2XfDSnqPdQIWFkWOJQl9nl2WVal4dsjL5wtIbKU2ZCQ2HH/Ru3Zuc8
	 43VWsc7lRk0LQ==
From: Kalle Valo <kvalo@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath11k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,
  <regressions@lists.linux.dev>
Subject: Re: [PATCH v2] wifi: ath11k: move power type check to ASSOC stage
 when connecting to 6 GHz AP
References: <20240424064019.4847-1-quic_bqiang@quicinc.com>
	<87wmo0k71i.fsf@kernel.org>
	<3dc28f34-45cc-4e14-b9ea-1f7b78a6a591@quicinc.com>
Date: Mon, 20 May 2024 18:34:39 +0300
In-Reply-To: <3dc28f34-45cc-4e14-b9ea-1f7b78a6a591@quicinc.com> (Baochen
	Qiang's message of "Fri, 17 May 2024 10:14:08 +0800")
Message-ID: <87h6esebu8.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Baochen Qiang <quic_bqiang@quicinc.com> writes:

> On 5/11/2024 5:54 PM, Kalle Valo wrote:
>> Baochen Qiang <quic_bqiang@quicinc.com> writes:
>> 
>>> With commit bc8a0fac8677 ("wifi: mac80211: don't set bss_conf in parsing")
>>> ath11k fails to connect to 6 GHz AP.
>>>
>>> This is because currently ath11k checks AP's power type in
>>> ath11k_mac_op_assign_vif_chanctx() which would be called in AUTH stage.
>>> However with above commit power type is not available until ASSOC stage.
>>> As a result power type check fails and therefore connection fails.
>>>
>>> Fix this by moving power type check to ASSOC stage, also move regulatory
>>> rules update there because it depends on power type.
>>>
>>> Tested-on: WCN6855 hw2.0 PCI
>>> WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
>>>
>>> Fixes: bc8a0fac8677 ("wifi: mac80211: don't set bss_conf in parsing")
>>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
>> 
>> Oh, this fell through the cracks. Commit bc8a0fac8677 was introduced in
>> v6.9-rc1 so I should have sent this to v6.9 but it's too late now. I'll
>> need to queue this for v6.10 via wireless tree.
>> 
>> Adding the regression also to regzbot:
>> 
>> #regzbot introduced: bc8a0fac8677
>> #regzbot title: ath11k: connection to 6 GHz AP fails
>> 
> Hi Kalle, with an upcoming patch this regression is expected to be fixed:
>
> https://lore.kernel.org/all/20240506214536.310434f55f76.I6aca291ee06265e3f63e0f9024ba19a850b53a33@changeid/#t
>
> So here the ath11k fix would not be needed any more once above patch got merged.

What happens if we apply both patch 'wifi: ath11k: move power type check
to ASSOC stage when connecting to 6 GHz AP' and patchset 'wifi:
mac80211: build TPE handling'? In other words, do they conflict from
functionality point of view?

I ask because I suspect Johannes is planning to take patchset 'wifi:
mac80211: build TPE handling' to v6.11 but we should fix the ath11k bug
in v6.10.

> But I don't have time to test this, so suggest keeping it pending. We
> could drop it once above analysis got verified.

BTW for some this patch wasn't in the pending branch but it's there now.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

