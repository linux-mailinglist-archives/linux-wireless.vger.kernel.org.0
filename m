Return-Path: <linux-wireless+bounces-7458-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF4A8C2612
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 15:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 284B11C2191D
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 13:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E1412CD8F;
	Fri, 10 May 2024 13:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdTIbV3p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D50712C46B;
	Fri, 10 May 2024 13:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715349136; cv=none; b=nssW72WKJe7s5AQMjTtpI9Ph2G7n50zDPkwGxELBFHjKK9hbNp60A9Hr+nQnZ+fkMmBxcTGAdO4DYHs9HLlu0QNdXU2UZn2YNsyMtsh4FXaq4+IhcmudMXONWEuRfAFRpmKdEji+kpCSVxFI2B8QfzZRbXWtzn1twDFCQGS+wGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715349136; c=relaxed/simple;
	bh=P03mPsNFGR0/RNBmpmCMETYGOpewXcdJhDQnp92x98U=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=RdToRcoMLJhLFfSeALD9wMw59LWr+hiO6Q14FTRysi/LZzIfSJwN9l3Dwc+wSn1+ifQrXCbPWB+GmpQirR56oCkACHhO3wfA6djQmcFHDHPerrmWqe2rj5ReW8dclXzddCW+mwn4PJbNilPqjWaJjtaPuc5jwdSQTuPMUoWObCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdTIbV3p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0484C32781;
	Fri, 10 May 2024 13:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715349135;
	bh=P03mPsNFGR0/RNBmpmCMETYGOpewXcdJhDQnp92x98U=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=CdTIbV3p+4e9dZYYzb9p0raW2kJxdErUtvbB2gTyAlJgbePLaNavSF0S+hRtzQvJv
	 giA7CUdN2YZIOrk7XANyrFY5jsFCDzKxHXQZpHQGR1fp1Rod9/9XPQEuumQYSe1sZA
	 1nAY/DLONdV+kC3ws88a7/6D5wCLzwQzyIWzG36sWz3EQSt2g6X8RsArbllW9jORcJ
	 XJjrNAh5Hlv7JwWB+zX/POAWBGZglSTpJ0O8FqsYHc6ZBnHv6wY4owV2OOVdyv2zkx
	 bXo/67Gzzo878XtRdQDgTa/2OViokNXOj50RP4qPSvGeeXyzfBT1/JPujSSXHzU6ca
	 WZgiTxD7fU92Q==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Ansuel Smith <ansuelsmth@gmail.com>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  <linux-kernel@vger.kernel.org>,  <ath10k@lists.infradead.org>,
  <linux-wireless@vger.kernel.org>,  <netdev@vger.kernel.org>,  Sebastian
 Gottschall <s.gottschall@dd-wrt.com>,  Steve deRosier
 <derosier@cal-sierra.com>,  Stefan Lippers-Hollmann <s.l-h@gmx.de>
Subject: Re: [PATCH v14] ath10k: add LED and GPIO controlling support for
 various chipsets
References: <20230611080505.17393-1-ansuelsmth@gmail.com>
	<878rcjbaqs.fsf@kernel.org>
	<648cdebb.5d0a0220.be7f8.a096@mx.google.com>
	<648ded2a.df0a0220.b78de.4603@mx.google.com>
	<CA+_ehUzzVq_sVTgVCM+r=oLp=GNn-6nJRBG=bndJjrRDhCodaw@mail.gmail.com>
	<87v83nlhb3.fsf@kernel.org>
	<7585e7c3-8be6-45a6-96b3-ecb4b98b12d8@quicinc.com>
	<cce2700c-e54f-4a50-b3f0-0b8a82b961a4@quicinc.com>
Date: Fri, 10 May 2024 16:52:11 +0300
In-Reply-To: <cce2700c-e54f-4a50-b3f0-0b8a82b961a4@quicinc.com> (Jeff
	Johnson's message of "Thu, 9 May 2024 09:48:08 -0700")
Message-ID: <875xvllqpg.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 5/9/2024 9:37 AM, Jeff Johnson wrote:
>> On 5/8/2024 9:50 PM, Kalle Valo wrote:
>>> Sorry for the delay but finally I looked at this again. I decided to
>>> just remove the fixme and otherwise it looks good for me. Please check
>>> my changes:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=688130a66ed49f20ca0ce02c3987f6a474f7c93a
>>>
>> 
>> I have a question about the copyrights in the two new files:
>> + * Copyright (c) 2018-2023, The Linux Foundation. All rights reserved.
>> 
>> My understanding is that Qualcomm's affiliation with Linux Foundation via Code
>> Aurora ended in December 2021, and hence any contributions in 2022-2023 should
>> be the copyright of Qualcomm Innovation Center, Inc.
>> 
>> 
>
> ok it seems like Kalle's v13 had:
>  + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
>
> and Ansuel's v14 has:
>  + * Copyright (c) 2018-2023, The Linux Foundation. All rights reserved.
>
> So Ansuel, is your work on behalf of The Linux Foundation?

BTW in the pending branch I can change the copyright back to original so
no need to resend because of this. But I'll need guidance from Ansuel.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

