Return-Path: <linux-wireless+bounces-6640-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBBC8AC54A
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 09:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 978A91C20AD6
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 07:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8E1495F0;
	Mon, 22 Apr 2024 07:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KMT2N4++"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB59C8F3
	for <linux-wireless@vger.kernel.org>; Mon, 22 Apr 2024 07:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713770186; cv=none; b=ZEr2kacmDfCpiB72Xuu17IT5p72HkQhvJfA6EK29l96Lz3dKDRzfNmT4yNojn1pEI/z8F4hbZwZdFkItI5iSE+10Rb0GhIr4N1Y6nmynsBBdiJlx1FVMRHkIfmon9/uBXhCIhN4U1RXwWMtq1K9xrhD5w5HWh8S627rLiKgQBLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713770186; c=relaxed/simple;
	bh=J7dZFmAv+93dDhYolGELXJSEN4VNpt23HfVHjyK8Bpw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=kcE2Da94Q96gtOhZGSIZ/fXimrcOq1/3/v7o0te5zCBCiDLI2NyvxbTFTkW7c0D7mSr2TgNvXA0RGAlOOMX28Y10ENm6VSUazEwrnMnZw+zqdRUKq2/rbwvxw1Chm9o41pF5WfuaP8QejX9P+tBzSD6CnLs1hNf56DPtDMRXHNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KMT2N4++; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76923C113CC;
	Mon, 22 Apr 2024 07:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713770185;
	bh=J7dZFmAv+93dDhYolGELXJSEN4VNpt23HfVHjyK8Bpw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=KMT2N4++JFVKNhBitPPrb8AqxqRXWUTzWYA5vL4rZjV3MDh44/9207CQBiQ6PGtbx
	 PzbU43dywqTwTDoIFZw22MoXM1jDb0P4nav1SxiM1DbJeIyJAu7cTM5Tvt0fCiKFYZ
	 d/NB/9AXnUgFuj17RQ2Sh2+OuIy1Xzw+aOGvVwx8X7Sl1BxkoNnT/Ua4aSsvl6jvm7
	 yV/iVZCpzYeKvVyQW7bEAi5iUiNd0VrQulRRdbYuy5JM1e+iJ4w+D2l15sXHubXzY9
	 7fBATMWlZ4ENOsJ95/R0N5bg2pUgmXatrTs6XCC6bF/ovg0ZUgWB8QM3NJqEhP/GYQ
	 dvz+cY7tGOnfA==
From: Kalle Valo <kvalo@kernel.org>
To: Lingbo Kong <quic_lingbok@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  Jeff Johnson <quic_jjohnson@quicinc.com>,
  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v8 0/4] wifi: ath12k: ACPI support
References: <91cbda07-0b93-4e0b-adaa-cd9b078a91b8@quicinc.com>
	<be016fbf-0198-4fe1-84f8-cfb0bf00dc4b@quicinc.com>
Date: Mon, 22 Apr 2024 10:16:22 +0300
In-Reply-To: <be016fbf-0198-4fe1-84f8-cfb0bf00dc4b@quicinc.com> (Lingbo Kong's
	message of "Fri, 19 Apr 2024 17:39:32 +0800")
Message-ID: <877cgpx3y1.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Lingbo Kong <quic_lingbok@quicinc.com> writes:

> On 2024/4/19 14:30, Lingbo Kong wrote:
>>  > -------- Forwarded Message --------
>>  > Subject: Re: [PATCH v8 0/4] wifi: ath12k: ACPI support
>>  > Date: Fri, 19 Apr 2024 07:16:07 +0300
>>  > From: Kalle Valo <kvalo@kernel.org>
>>  > To: Jeff Johnson <quic_jjohnson@quicinc.com>
>>  > CC: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
>>  >
>>  > Jeff Johnson <quic_jjohnson@quicinc.com> writes:
>>  >
>>  > > On 4/18/2024 9:20 AM, Kalle Valo wrote:
>>  > >
>>  > >> From: Kalle Valo <quic_kvalo@quicinc.com>
>>  > >>
>>  > >> Through reading ACPI tables, implement Time-Average-SAR(TAS), BIOS
>>  > >> SAR, configuration of CCA threshold and band edge channel power
>>  > functionalities.
>>  > >> This is enabled only on WCN7850.
>>  > >>
>>  > >> TODO:
>>  > >>
>>  > >> * test with ACPI support in hardware (I don't have such hardware),
>>  > especially
>>  > >>=C2=A0=C2=A0 suspend and hibernation
>>  >
>>  > [...]
>>  >
>>  > > I can verify this doesn't crash my system, but apparently my ACPI
>>  > > doesn't have the underlying settings, so cannot verify actual
>>  > > functionality
>>  >
>>  > Thanks for testing. I hope Lingbo has a device with proper ACPI
>> settings.
>>  >
>> yes, I'll apply these patch then test it.
>>=20
>
> Hi, kalle, i've applied this patchset, set ACPI correctly, then ACPI's
> functionality is right.

Nice, thanks for testing.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

