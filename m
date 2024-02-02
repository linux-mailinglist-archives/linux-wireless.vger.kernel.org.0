Return-Path: <linux-wireless+bounces-3031-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A64C8847070
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 13:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48EBC1F24968
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 12:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7AA1874;
	Fri,  2 Feb 2024 12:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+cPTIm1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883C91872
	for <linux-wireless@vger.kernel.org>; Fri,  2 Feb 2024 12:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706877418; cv=none; b=cyh/z4WJgvCOBVJhJltpi0Yw7DyBCmUHIoPjad9/os4SYTBLR8TPWQ4RrR8gByP96bcYF/FMeW3INOO/rh4fbelcNOKLUmSwBvHX/aYSbj5tLCPuT+A7RJXmnLEoGI4exhjJ8fgy2mpQ3SGUDobVbgTu4bSCDpd4TJrEzo8gjWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706877418; c=relaxed/simple;
	bh=S9kXI/nhnyCQ2E9xStS/KEOinhoWXOUkKo3t3H2M95c=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=JO44kbcrxzTkEg8oBZ9fEAucqXCSDMCL8Ch/SKCtnlHJlC8UVOtaWlgOTZTJWRZ1KHvUzybdi3HpQs5C6ZrOgVAXdyYljJUPWopzqt604NyXYmA60CDQxGZv8A51eZWrxJhxRPGn7MKntmQevM/15OyX9DHeUPFAaUymPYQsOyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+cPTIm1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 251A2C433C7;
	Fri,  2 Feb 2024 12:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706877418;
	bh=S9kXI/nhnyCQ2E9xStS/KEOinhoWXOUkKo3t3H2M95c=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=M+cPTIm1DVO7RaQ+3OZ9bpbFIvU8ENiPcpbdd+OAUAoNw5zUwCrFYx4X+jyFbd3hV
	 wZ3V+6CMBq94lD/UDRadU+sncEBqCPLLQ+g5QcRcoYBGjw8yuFu2YZNPcxfEQDgikp
	 h0CaCe1TfGxWtLv3vyixtYJZmQDOeZhrMVSkCDhdifYkG1S5jgk/6GKEeAoD8/vU3n
	 8jh0MP+Aq1Dn3p5oGUBQDpm3vKO/GG0AV/lxjLjxfWtCOrFYG+PSgu9CWBwf4Wfwi7
	 8iuvZ7ljdjqIS6/y+MlEFGcNQYHqMr/wKLTGYOtqwkYzvVPouw/rjKZGnN63hGAub0
	 mN6uNpXjrmk1Q==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Lingbo Kong <quic_lingbok@quicinc.com>,  <ath12k@lists.infradead.org>,
  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] wifi: ath12k: add processing for TWT enable event
References: <20240122085336.3985-1-quic_lingbok@quicinc.com>
	<20240122085336.3985-2-quic_lingbok@quicinc.com>
	<ea2952a4-8343-407e-9a9c-3c93f4afd607@quicinc.com>
Date: Fri, 02 Feb 2024 14:36:55 +0200
In-Reply-To: <ea2952a4-8343-407e-9a9c-3c93f4afd607@quicinc.com> (Jeff
	Johnson's message of "Mon, 22 Jan 2024 09:47:36 -0800")
Message-ID: <87a5ojt53s.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 1/22/2024 12:53 AM, Lingbo Kong wrote:
>> When ath12k send TWT enable command to firmware, firmware will return a TWT
>> enable event to ath12k. Through the analysis of TWT enable event status, we
>> can easily obtain the status of TWT enable command. It can be more
>> convenient to debug TWT.
>> 
>> This patch works with WCN7850 and QCN9274.
>> 
>> Tested-on: WCN7850 hw2.0 PCI
>> WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
>> 
>> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
>> ---
> [...snip...]
>> diff --git a/drivers/net/wireless/ath/ath12k/wmi.h
>> b/drivers/net/wireless/ath/ath12k/wmi.h
>> index 06e5b9b4049b..7570ef7be38d 100644
>> --- a/drivers/net/wireless/ath/ath12k/wmi.h
>> +++ b/drivers/net/wireless/ath/ath12k/wmi.h
>
> Qualcomm Innovation Center copyright missing 2024
>
> Kalle can probably address this in "pending"

Actually the year 2024 was already there, most likely some other patch
added that.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

