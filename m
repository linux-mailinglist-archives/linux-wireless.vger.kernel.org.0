Return-Path: <linux-wireless+bounces-4281-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A86F986D871
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 01:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C54ED1C20DA5
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 00:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDE933C0;
	Fri,  1 Mar 2024 00:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="glzy6rzq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFA22916;
	Fri,  1 Mar 2024 00:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709253928; cv=none; b=smlClwzCAkXwaJy90AqwdNBIxblADk7vOTE9Cmcp0MOXmS4/VVZ1mKfW3DIHB0X7WnqK0EX5zVsk99XAwfNFy521kCLr3Pg35RyPaWNGnCJhoSk/ZFxbAgiuEyOjF51B5DA5QIoZn/qdB+N+p2/aBZzzX39dzwxtPAB5VESuvfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709253928; c=relaxed/simple;
	bh=iPFfVjiyS+z+zX5CZ63M9OT2EsMyB1aIKrlPflSfew0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P9pxCWItSae3qO+wKPXdu3wDiemo7FJdaaUcHLO5/r4FEH1uJiWTBVKFACRkS+fBK62kKxLR0xOWYoXSX2zvTEy48AChdclbuFOAcmiKo6bi+txWeLiWqVd0SD10wXllDPWqj9FdWZqIN0BC2XmaSRBE2T8OZ75s0BkwKcFjJkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=glzy6rzq; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709253909; x=1709858709; i=fiona.klute@gmx.de;
	bh=iPFfVjiyS+z+zX5CZ63M9OT2EsMyB1aIKrlPflSfew0=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=glzy6rzqBxlSyZPTxw2OMqIib6HPouZDMyti9ffdQESB78Ix8lz897CkZP0UxPKI
	 079/Ahuq4rtJAW89FGH1vh1Uqhl4uhfL7jcRGJTCDnlYzepbfj8l+FvljeFC21Fnb
	 8hvhOdHI9lvRPoahhfrLBWtWCf7WfbKyubZqFTGC+3SeBq2SD8i/vBH2A6oAPz/lP
	 VCL9oa0yX3YS4HnTDy8zSZdXAdH89QtTCGrAf9feLAIqcqBLWWGc3UfGsY2Il5yiS
	 ycaPuXcsGRFaTqpG2JPhcoAcf2JuQkPmwoe1nMCUvLkMb5l2xPK69PEKm+1dDHBO5
	 JW3W3XsNwhb/QDvhfA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.7.2] ([85.22.24.88]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MeCtj-1r8AMd3TTb-00bLT5; Fri, 01
 Mar 2024 01:45:08 +0100
Message-ID: <31dd8a43-0df0-4f1b-905d-67b1a63fab0e@gmx.de>
Date: Fri, 1 Mar 2024 01:45:07 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] rtw88: Add support for RTL8723CS/RTL8703B
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: "kvalo@kernel.org" <kvalo@kernel.org>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "pavel@ucw.cz" <pavel@ucw.cz>, "megi@xff.cz" <megi@xff.cz>
References: <20240227235507.781615-1-fiona.klute@gmx.de>
 <61980d74cdb24dd38a2f2e12c79125e2@realtek.com>
Content-Language: de-DE, en-US
From: Fiona Klute <fiona.klute@gmx.de>
Autocrypt: addr=fiona.klute@gmx.de; keydata=
 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
In-Reply-To: <61980d74cdb24dd38a2f2e12c79125e2@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6PcTm6Fh8aYDLmh74+2lb1msevuTwX2ZP2YMNnEAOMmjth0L9ib
 +YKc93qxRv8SoiSfxLbijeyUMhQnfx/IIkdKj+5V7ujrv4VPNsA8IRZ/WvsMEsniAUMcVEb
 e5jq77kkK0qEThtbeLQtmTo8O+qTrdgHkpKSteXqLerYkABZPDRSiz7v8CCotrvh9fbDbEo
 SY1O4iYpTUQrOtXkg5GxA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:E9b/1G2qFNA=;qhuHNpW6hAC/u2uHTq1IJbW1Y7D
 ogxomcqGdaoFCHHNhb3WvFFzpxLJdg49DakKHDrD2MOi5BnQKPJ3d8n7KTJ/4mSHALVxTM54L
 yoWKt4gTatOk/QClK9YYV5HcwocOxgJcYfSMmtops4V7F4W0AleUiamBTz3qNqafN6H1G+miX
 95rRU0kTkUzG4zqaP8nqvgCdlUEha3Nkw///XNAsMGb7lskuV5Es4UL/zeKQ3XauhdPvPmJ61
 oAAvmeOjYEPXha0tH0IXzOSs/GETe+md3MOAZkFaG62NYOMXOE3qc5DlhpChu6pX/iz46wsfW
 Q7viF9yELFqlOC2cFgtcoBwltgRAUSboGWYph9sUSGov6mkmX8oqsXF287J0cbnBr2tmH/KpY
 0v5O0HsUH3JGNojaTTKv9jMvBHuBqbEas8Gqq5+7TVQa6RxsJH40yzcnwU93EQo3H9yxfjosg
 c1vSWJAznjY8l3tjH57vFGufxnkbW3SxkBUlNV44iE8LqmhplXGlXfoKXbw+kRBvoFuovuzJH
 QIUDRlqJ0GZMnaCez0qUBZ2Wcf4boYmbQ8BhD3t/XWv2OaQFjYrvb90ydgOH+608icWQLC0H+
 PiacYBnb85hDPOgMdOL3W7FYzjzyM3WPv8lDKIXPzZi7i6l13Y+/ERybrbOfn5ouZrvkUpEBL
 YW+nn13B0XGD21rayfT0ZXcfDO3MNcZs1nu1wmGFzTZjquv/5HTx1cOvI4NLFxjbFlpXWjHdU
 5j3bIObjL1PTZ3YCRW+P2JdGBNANx9koBBBsKGoICp/v+2BCYzmWypDwH4vzYmT2hchF1rcGo
 FVqHA1HrZJV3WqybVWXCULdqa2nNqlDOpGItord7FlYfw=

Am 29.02.24 um 07:40 schrieb Ping-Ke Shih:
>
>
>> -----Original Message-----
>> From: Fiona Klute <fiona.klute@gmx.de>
>> Sent: Wednesday, February 28, 2024 7:55 AM
>> To: linux-wireless@vger.kernel.org; Ping-Ke Shih <pkshih@realtek.com>
>> Cc: Fiona Klute <fiona.klute@gmx.de>; kvalo@kernel.org; ulf.hansson@lin=
aro.org; linux-mmc@vger.kernel.org;
>> pavel@ucw.cz; megi@xff.cz
>> Subject: [PATCH v2 0/9] rtw88: Add support for RTL8723CS/RTL8703B
>>
>
> [...]
>
>>
>> v2:
>>    * Parse PHY status using struct instead of macros
>>    * Prefer MAC from EFUSE if available, move retrieving MAC from DT to
>>      a separate function
>>    * Tidy up wait for IQK to be done, replace mdelay loop with
>>      read_poll_timeout
>>    * Set dual author for rtw88_8723x
>>    * Add missing "static" to rtw8723x function declarations, fixes
>>      build failure when not built as a module
>>    * Various style fixes
>
> You have some changes by v2, so I think you don't need to take my ack-by=
 for
> those patches. Then, it will be easier for me to review patches you have
> changed.

Sorry, I thought I was supposed to keep them unless I make larger, not
requested changes.

> Anyway, could you point out patches I should pay attention? Or I will re=
view
> entire patchset one-by-one.

The bigger changes are all in rtw8703b.h (patch 4; the PHY status struct
instead of macros) and rtw8703b.c (patch 5; PHY status parsing, MAC
address retrieval, and IKQ done wait). The PHY status struct is
basically the same as in the vendor driver, I just resolved some macro
detours for big/little endian detection and spelled out "reserved" in
field names.

Changes in the other patches are minimal: additional MODULE_AUTHOR in
rtw8723x.c, missing "static"s in rtw8723x.c and rtw8723x.h, formatting,
and using rtw_read8_mask in the firmware reset (patch 6).

Best regards,
Fiona


