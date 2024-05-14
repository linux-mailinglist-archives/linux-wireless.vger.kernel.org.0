Return-Path: <linux-wireless+bounces-7627-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D4A8C4BF6
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 07:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 118D91F22345
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 05:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A6B171AB;
	Tue, 14 May 2024 05:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vHsBaPfb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8DA7482
	for <linux-wireless@vger.kernel.org>; Tue, 14 May 2024 05:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715664315; cv=none; b=ZRQLw3pGtedwBMAPqnwtbfevZvtZlQIcp/UNZzrbD8S0jbkDKwuzH89uDzyJS3ORX3faqLWsue672V0nCXHlfQ71l1DIHlAl4jfttru98ZmSYyKqwEE7gTfL1Rpsa/BDVrW+fXLSk9621TDcy7xes6fpubW8++6hfvK3V5J3+Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715664315; c=relaxed/simple;
	bh=rZZB79t2PiwYA0ClpI5vhMgbF5TFDvqhiJewr2oOdCk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=c04jah2UGgTaQYHGY0L6cXBrUuFKuvmvPWCvgNYN1daf7bIeuft5RD3KhthuxAcPK2bakqqCLg7lVT2EzGGBNT1Vwsb2zoglPztgxrKPalT8hDRF7RPJkahoxK/Tr5s8CHvYo9J8GhCRhyKy19zXVndXnnQKsMqYnu1d2kQVhi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vHsBaPfb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F24EC2BD10;
	Tue, 14 May 2024 05:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715664315;
	bh=rZZB79t2PiwYA0ClpI5vhMgbF5TFDvqhiJewr2oOdCk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=vHsBaPfb/vLbHsV3/t94ogIG5DmvXyvDSF2GPCxBT/JOceRG86KbIjuzPLZYQQbM8
	 /F0SgJJwCX0zCPvojf7rRDblUQ1dzUYuNdJJ1DJj3zsL2YdNVX5lcYeAR54hzU7nvL
	 PIxnyrsX4w9srDPImDKw3GvtOs1z4tra6OUTOgpplMzlHSuLJqGGWZlG2KGtlnyjx2
	 d3Qu/RHJUvmrBmIAyiBbSjxnSaFwvppiWB8iYF+FW3Mwm1LQbusAuKnUGxoksxQX82
	 OPfHZEQ4ehX7UwZ8Nq+W9Qds0j/uXsh0L1DRmjKkQk+97fDXRNlaEpi6QIZe1WRNK9
	 O0xNuDUIM9XWw==
From: Kalle Valo <kvalo@kernel.org>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,  <ath12k@lists.infradead.org>,
  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 2/2] wifi: ath12k: use correct MAX_RADIOS
References: <20240511013644.3103905-1-quic_periyasa@quicinc.com>
	<20240511013644.3103905-3-quic_periyasa@quicinc.com>
	<7916534b-ee14-4b95-b339-d614ce9393f1@quicinc.com>
	<23354bb4-4d12-da14-1764-ea71ab05ff45@quicinc.com>
Date: Tue, 14 May 2024 08:25:11 +0300
In-Reply-To: <23354bb4-4d12-da14-1764-ea71ab05ff45@quicinc.com> (Karthikeyan
	Periyasamy's message of "Tue, 14 May 2024 06:37:29 +0530")
Message-ID: <87cyppdky0.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:

> On 5/14/2024 5:01 AM, Jeff Johnson wrote:
>> On 5/10/2024 6:36 PM, Karthikeyan Periyasamy wrote:
>>> The current value of the MAX_RADIOS define is 3. However, this value is
>>> incorrect as the maximum number of radios supported by all devices does
>>> not exceed 2. Therefore, the MAX_RADIOS define should be modified to 2.
>> Use imperative tense: Therefore, modify ...
>> 
>
> Sure, will modify in the next version.
>
>> What is the observed problem, if any, with the current code?
>> 
>
> No problem observed but it leads to unnecessary space allocated for
> the hw links in the group and also it gives incorrect perspective to
> the code reader that ath12k support max three radio platform.

Information like this is always good to include in the commit message.
There's less guessing that way.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

