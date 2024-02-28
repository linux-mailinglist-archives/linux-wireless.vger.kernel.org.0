Return-Path: <linux-wireless+bounces-4180-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED63086ACAE
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 12:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6FA02828EB
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 11:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201DA5A0E9;
	Wed, 28 Feb 2024 11:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldM6SftM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF63512BE9D
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 11:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709118498; cv=none; b=R5SJVh0U3elsRbrbP9SRkjAfVyNO4kebU4FxRLo+G2bHv8D7fwNSUb05Jzc6pYB9Vch2TC7D666eqFRK9If3QW+ZPr9wEn556Pr+gc6c1BYMNOsu2PmXNgpglj8kjzVzxRf7vZ5Zwb82y+6vNY53g2LZCj1lpq0LoPFBL+kSIRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709118498; c=relaxed/simple;
	bh=nWtnBXCOiEAE6N6Poj4iIqORASAy4SEX/HILGhosxcc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=F44AMXujwG+m/LPTisujDRjQZRSYKMx/WLXIuomCbH+IlLxPflDiUh9SfZ0PKrxfvqJ1oMaGRTaic+Q+N3emcSNC70J86goWlKSQ9zu+o1B6VNGKmMv4TP7Mqe5wkJIpNTx7+gySeMLl5tLV1fiPKI8dRY5kRnN2Ff/t4ml4JCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldM6SftM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3170C433F1;
	Wed, 28 Feb 2024 11:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709118497;
	bh=nWtnBXCOiEAE6N6Poj4iIqORASAy4SEX/HILGhosxcc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=ldM6SftM94+WBTcIHvtV1+O/g/2o4pqNh1cJp7NIfJcR3hdGjOlEoiwZaEB3c5BMV
	 bWF49fDh/3V51206KFURxf9jmNd432ncovy1DVQfr0RlEf9XDzWue42CCt9oTgKCnN
	 iVaO9InonOJ8sFfXW5uPqeU5mHknbh19D6OkAc/R5TIFiitGaVV6BZeRfRvmh13cIm
	 6HzUEZNUcfSG3L76gbxIGkagEaeS6YC/pRc2LF1mXnH6XLVNrbVbzRKSYHKMVMdTFW
	 PcYFtJlxWpvXRP/bRypIv2Nb79TLEXs0sl1DP7HyKedZYf7ijtkwPaDkuk5cU1cK8u
	 BG+HdD3HUzeog==
From: Kalle Valo <kvalo@kernel.org>
To: Lingbo Kong <quic_lingbok@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v4] wifi: ath12k: report tx bitrate for iw dev xxx
 station dump
References: <20240219095802.1147-1-quic_lingbok@quicinc.com>
	<87y1b7jkxu.fsf@kernel.org>
	<6f39eb1c-97f7-4029-a5f2-5ab36ff0f0a6@quicinc.com>
	<877ciq9h3e.fsf@kernel.org>
	<4e67118d-80e4-422e-aa39-73b891ee6042@quicinc.com>
Date: Wed, 28 Feb 2024 13:08:14 +0200
In-Reply-To: <4e67118d-80e4-422e-aa39-73b891ee6042@quicinc.com> (Lingbo Kong's
	message of "Wed, 28 Feb 2024 15:21:30 +0800")
Message-ID: <87a5nkkfs1.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lingbo Kong <quic_lingbok@quicinc.com> writes:

> On 2024/2/27 21:23, Kalle Valo wrote:
>> Lingbo Kong <quic_lingbok@quicinc.com> writes:
>> 
>>> On 2024/2/26 23:37, Kalle Valo wrote:
>>>> Lingbo Kong <quic_lingbok@quicinc.com> writes:
>>>>
>>>>> The tx bitrate of "iw dev xxx station dump" always show an invalid value
>>>>> "tx bitrate: 6.0MBit/s".
>>>>>
>>>>> To address this issue, parse the tx complete report from firmware and
>>>>> indicate the tx rate to mac80211.
>>>>>
>>>>> After that, "iw dev xxx station dump" show the correct tx bitrate such as:
>>>>> tx bitrate: 104.0 MBit/s MCS 13
>>>>> tx bitrate: 144.4 MBit/s MCS 15 short GI
>>>>> tx bitrate: 626.9 MBit/s 80MHz HE-MCS 6 HE-NSS 2 HE-GI 0 HE-DCM 0
>>>>> tx bitrate: 1921.5 MBit/s 160MHz HE-MCS 9 HE-NSS 2 HE-GI 0 HE-DCM 0
>>>>>
>>>>> Tested-on: WCN7850 hw2.0 PCI
>>>>> WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>>>> Tested-on: QCN9274 hw2.0 PCI QCN9274 hw2.0 PCI
>>>>> WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>>>>
>>>>> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
>>>> Please use full englist words like transmit instead of tx. Also the
>>>> title could be simplified to:
>>>> wifi: ath12k: report station mode transmit rate to user space
>>>> Here I assumed this only works in station mode. Or does this also
>>>> support AP and P2P mode? The commit message should explain that.
>>>>
>>>
>>> Ok, i will apply it in next version. Thanks for pointing out.
>> After rereading my comments maybe keep the title simple like:
>>    wifi: ath12k: report station mode transmit rate
>> But it would be good to clarify in the commit message what modes
>> this is
>> supported. And what hardware families support this.
>
> Hi kalle, Could you please offer your opinion on this commit message?
>
> wifi: ath12k: report station mode transmit rate
>
> Currently, the transmit rate of "iw dev xxx station dump" command
> always show an invalid value.
>
> To address this issue, ath12k parse the info of transmit complete
> report from firmware and indicate the transmit rate to mac80211.
>
> This patch only applies to the WCN7850's station mode.
>
> After that, "iw dev xxx station dump" show the correct transmit rate.
> Such as:
> tx bitrate: 104.0 MBit/s MCS 13
> tx bitrate: 144.4 MBit/s MCS 15 short GI tx bitrate: 626.9 MBit/s
> 80MHz HE-MCS 6 HE-NSS 2 HE-GI 0 HE-DCM 0 tx bitrate: 1921.5 MBit/s
> 160MHz HE-MCS 9 HE-NSS 2 HE-GI 0 HE-DCM 0

Looks good, except for readability I would add an empty line after "Such
as:".

I noticed that the signal patch depends on this patchset:

https://patchwork.kernel.org/project/linux-wireless/patch/20240219111417.1185-1-quic_lingbok@quicinc.com/

In that you should submit both patchses in same patchset. But please
wait until I have reviewed the signal strength patch.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

