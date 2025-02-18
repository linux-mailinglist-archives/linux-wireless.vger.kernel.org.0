Return-Path: <linux-wireless+bounces-19099-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3C3A39A03
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Feb 2025 12:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 626A4168850
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Feb 2025 11:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1446E23AE96;
	Tue, 18 Feb 2025 11:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mobintestserver.ir header.i=@mobintestserver.ir header.b="Oj1ckdEE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mobintestserver.ir (mobintestserver.ir [138.199.196.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D2323717F
	for <linux-wireless@vger.kernel.org>; Tue, 18 Feb 2025 11:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.199.196.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739877085; cv=none; b=NpylvVB5ZVnOAM1QuRQGBRsuj/v9GycBgrHJ/dJAgCxQEALA/1DOG+YPcquG76KWmr0Hc4UcGtfb0dFuPlUwOEx0nD9pFmK8VCoY9xjpV7SxR6q8dAbRVpFNUxsH1KBkoS74VDYuMw95CSpN1uM1rX4bjONrdrgKx0Cjo0tf0Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739877085; c=relaxed/simple;
	bh=J6q5Z6fDtJn6BBS+T7U1DdO17HL5vyinICaaufLicu8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=kt4eF2qlFr5nyueSd/eBOzx6FsIZK0wafJsPuWhwWbomXW+34jncj2EuuTXydnhx83yWBsY5za351AWLIotGnSmdH+0lS+tVCO1NzNgT8Pduexk9LJVRpQwmNovR8qmLNZztF6vvPTmpq5hnS2jISwQhkGoR193qEzoygQn1ris=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mobintestserver.ir; spf=pass smtp.mailfrom=mobintestserver.ir; dkim=pass (2048-bit key) header.d=mobintestserver.ir header.i=@mobintestserver.ir header.b=Oj1ckdEE; arc=none smtp.client-ip=138.199.196.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mobintestserver.ir
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobintestserver.ir
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=dkim; bh=J6q5Z6fDtJn6BBS
	+T7U1DdO17HL5vyinICaaufLicu8=; h=subject:references:in-reply-to:cc:to:
	from:date; d=mobintestserver.ir; b=Oj1ckdEEMEPqZ8o2klEJbrewgCUk5noiRQl
	KovWANZmgyD/DnGf7lz9llqjbfimq+5GzBK86t0hFpumwJ2aWulhi0hwllhtjiFYAiaY5X
	t4Ppyq7A0euJChk1KZUih8v4EW5cvMpC/MnzkZKXNpmbKbYnRrmiSD3cdWTizpJMYXfYOE
	CKeCu98WsW4Qgx/1LYAn4YyeSPovU8YrSoWSwcHBMwJgs6XiLTt2guxTMXbSWj9rVGMDMW
	4d19mEWvUJRQxFnYCHksp/Ja/RX/nzzZwbKVp+D7G4XX/kR8VBgX9CoMzkGJ7H6a6XuFjD
	cdjAdZK3eixqpbaT9AHmbMD+Urg==
Received: 
	by mobintestserver.ir (OpenSMTPD) with ESMTPSA id 9d7a8db4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Feb 2025 11:11:18 +0000 (UTC)
Date: Tue, 18 Feb 2025 14:41:12 +0330 (GMT+03:30)
From: Mobin Aydinfar <mobin@mobintestserver.ir>
To: Ping-Ke Shih <pkshih@gmail.com>
Cc: wens@kernel.org, linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Message-ID: <7c909df2-2651-497c-91c2-624a7e3db43f@mobintestserver.ir>
In-Reply-To: <20250218025957.13818-1-pkshih@gmail.com>
References: <20250218025957.13818-1-pkshih@gmail.com>
Subject: =?UTF-8?Q?=D9=BE=D8=A7=D8=B3=D8=AE:_[PATCH]_wireless-r?=
 =?UTF-8?Q?egdb:_Update_regulatory_?=
 =?UTF-8?Q?rules_for_Iran_(IR)_on_both_2.4_and_5Ghz_for_2019?=
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <7c909df2-2651-497c-91c2-624a7e3db43f@mobintestserver.ir>
Disposition-Notification-To: mobin@mobintestserver.ir
Read-Receipt-To: mobin@mobintestserver.ir
X-Confirm-Reading-To: mobin@mobintestserver.ir

=DB=B1=DB=B8 =D9=81=D9=88=D8=B1=DB=8C=D9=87 =DB=B2=DB=B0=DB=B2=DB=B5 =DB=B0=
=DB=B6:=DB=B3=DB=B0:=DB=B3=DB=B8 Ping-Ke Shih <pkshih@gmail.com>:

> From: Ping-Ke Shih <pkshih@realtek.com>
>
> Decision No. 4004-01DEC-CRA, 8th Edition - February 2019,
> Radiocommunications and Regulatory Organization.
> General radio license for the use of parts of the frequency bands
> 2400-2483.5 MHz, 5150-5250 MHz, 5350-5250 MHz, 5470-5725 MHz, and
> 5850-5725 MHz in radio access networks. [1]
>
> * 2400 - 2483.5
> =C2=A0 - 100 mW e.i.r.p
> =C2=A0 - 10dBm in every 1Mhz
> * 5150 - 5250
> =C2=A0 - 200 mW e.i.r.p
> =C2=A0 - 10dBm/MHz per 1MHz bandwidth or -6dBm/25kHz per 25kHz bandwidth
> * 5250 - 5350
> =C2=A0 - 200 mW e.i.r.p
> =C2=A0 - 10dBm/MHz per 1MHz bandwidth
> =C2=A0 - DFS
> * 5470 - 5725
> =C2=A0 - 1000 mW e.i.r.p
> =C2=A0 - 17dBm/MHz per 1MHz bandwidth
> =C2=A0 - DFS
> =C2=A0 - If TPC is not used, the maximum radiated e.i.r.p. must be reduce=
d
> =C2=A0=C2=A0=C2=A0 by 3dB.
> =C2=A0 - Outdoor use only
> =C2=A0=C2=A0=C2=A0 (Since NO-INDOOR flag is not supported by current form=
at, don't add
> =C2=A0=C2=A0=C2=A0=C2=A0 this entry.)
> * 5725 - 5850
> =C2=A0 - 4000 mW e.i.r.p
> =C2=A0 - 36dBm in every 500 kHz
> =C2=A0 - DFS
> =C2=A0 - Outdoor use only
> =C2=A0=C2=A0=C2=A0 (Since NO-INDOOR flag is not supported by current form=
at, don't add
> =C2=A0=C2=A0=C2=A0=C2=A0 this entry.)
>
> These information is from [4], Mobin Aydinfar shared the official link=20
> [1]
> (inaccessible from outside of Iran), a mirror version [2] and=20
> translated
> version [3].
>
> [1]=20
> https://asnad.cra.ir/fa/Public/Documents/Details/73af8590-f065-eb11-968f-=
0050569b0899
> [2] https://mobintestserver.ir/Iran-2.4Ghz-5Ghz-cra-official-doc.pdf
> [3] https://mobintestserver.ir/Iran-2.4Ghz-5Ghz-cra-official-table.ods
> [4]=20
> https://lore.kernel.org/linux-wireless/c9ccf5ba-c091-45c4-9283-970bfa4f1a=
fe@mobintestserver.ir/T/#u
>
> Cc: Mobin Aydinfar <mobin@mobintestserver.ir>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
> db.txt | 9 ++++++---
> 1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/db.txt b/db.txt
> index d56ad32d31c9..0189355dff17 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -934,9 +934,12 @@ country IN:
> =C2=A0=C2=A0=C2=A0 (5470 - 5725 @ 160), (24), DFS
> =C2=A0=C2=A0=C2=A0 (5725 - 5875 @ 80), (30)
>
> -country IR: DFS-JP
> -=C2=A0=C2=A0 (2402 - 2482 @ 40), (20)
> -=C2=A0=C2=A0 (5735 - 5835 @ 80), (30)
> +# Source:
> +#=20
> https://asnad.cra.ir/fa/Public/Documents/Details/73af8590-f065-eb11-968f-=
0050569b0899
> +country IR: DFS-ETSI
> +=C2=A0=C2=A0 (2400 - 2483.5 @ 40), (100 mW)
> +=C2=A0=C2=A0 (5150 - 5250 @ 80), (200 mW)
> +=C2=A0=C2=A0 (5250 - 5350 @ 80), (200 mW), DFS
>
> # IS as part of CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301=20
> 893)
> # and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300=20
> 440)
> --
> 2.25.1

Thanks for the patch, I should mention the document date is February=20
2021, Not 2019.

Best Regards

