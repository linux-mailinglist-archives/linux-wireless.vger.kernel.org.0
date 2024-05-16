Return-Path: <linux-wireless+bounces-7738-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F538C7561
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 13:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62A6BB20D3F
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 11:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548E926AD0;
	Thu, 16 May 2024 11:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="ItEI2mSf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201F61459FF;
	Thu, 16 May 2024 11:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715859739; cv=none; b=OrE9oUc3CTm65Qk9/waFfMKyoFnogOkHLx7KDtbm5J85gLcoXOfYwDNVH4g3ajcqK4As+nBAeeZJtudS9gUDR+NEQoy/NHdrgKfAZNMuHZnJesiJgaOr5j1oxruqWs1/Dq4D8t7l7Dwo1/RqFTzhovIV0EdczirxzynEKTCRJYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715859739; c=relaxed/simple;
	bh=vJJ9cJ+GBoXy/aj3mrmCyAmNa4s7wvf/RRV9O1BXUXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gluMUIUul0uncMOV1q8P34Ks/lOmu32werSWNOmpP4kLxmGvBlFk3DqTBJHEAFze5dZI8+GNuZy5mnQOEA2PJstqTPY5ur4FIvnM89rms1d7u2zXKfqOHS+bZnyFpgwB4ZDFCc09x12YxtY2v0Dll+Xadd38KAzkyJ3TZgygUPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=ItEI2mSf; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=CdaRdgRhRtmPhB95HwGxkR3KixTgzNdL+5gbgKKmgxM=;
	t=1715859737; x=1716291737; b=ItEI2mSfPL9tKYyeFdZOacs8bcuyb/bIrXixMurGR9dEV4X
	qSRzzlZ36pUlwc2WPJ/w2bXYD2F99ZTuNkFHNeK5ybVI/Jsc9n4hbga6C3wPDFmtiywbsdUDMWBjY
	GYw8Tnh44V83Ai8dXEXlSYBwhzb/eF/4nh7xYUoU6ICSEx7sLQzoQRWvkyEPaZTQn+Yh18kWTr3rn
	StQMcCC1TCbDCMytdnAWIk+SQ4r1lW8pNZvuw//cyOlX4eM27PYIjuknhPlPNg1mxrJaDBswhirfk
	BLEnUy+DVBU5xpG+cHWCe/gsJ1FjpJ/eSh4o/nyNOdWXcAtXIdCiqMdFZvOgCNcg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1s7ZUx-0001I0-JB; Thu, 16 May 2024 13:42:11 +0200
Message-ID: <51aea1fb-ce72-4c94-a3dd-43e84763834b@leemhuis.info>
Date: Thu, 16 May 2024 13:42:11 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath11k: move power type check to ASSOC stage
 when connecting to 6 GHz AP
To: Kalle Valo <kvalo@kernel.org>, Baochen Qiang <quic_bqiang@quicinc.com>
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
 regressions@lists.linux.dev
References: <20240424064019.4847-1-quic_bqiang@quicinc.com>
 <87wmo0k71i.fsf@kernel.org>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <87wmo0k71i.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1715859737;ed14d899;
X-HE-SMSGID: 1s7ZUx-0001I0-JB

On 11.05.24 11:54, Kalle Valo wrote:
> Baochen Qiang <quic_bqiang@quicinc.com> writes:
> 
>> With commit bc8a0fac8677 ("wifi: mac80211: don't set bss_conf in parsing")
>> ath11k fails to connect to 6 GHz AP.
>>
>> This is because currently ath11k checks AP's power type in
>> ath11k_mac_op_assign_vif_chanctx() which would be called in AUTH stage.
>> However with above commit power type is not available until ASSOC stage.
>> As a result power type check fails and therefore connection fails.
>>
>> Fix this by moving power type check to ASSOC stage, also move regulatory
>> rules update there because it depends on power type.
>>
>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
>>
>> Fixes: bc8a0fac8677 ("wifi: mac80211: don't set bss_conf in parsing")
>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> 
> Oh, this fell through the cracks. Commit bc8a0fac8677 was introduced in
> v6.9-rc1 so I should have sent this to v6.9 but it's too late now. I'll
> need to queue this for v6.10 via wireless tree.

I might have missed something, but from here it looks like that hasn't
happened yet. If I missed something or if you are busy with more
critical stuff, feel free to ignore this mail; if it fell through the
cracks again, consider this a friendly reminder that this is still
waiting for processing.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

