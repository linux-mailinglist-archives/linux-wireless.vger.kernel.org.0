Return-Path: <linux-wireless+bounces-10753-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5F59433E3
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 18:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4638B28641B
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 16:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2621BBBC7;
	Wed, 31 Jul 2024 16:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xhs/6iw3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A7C1B29A7;
	Wed, 31 Jul 2024 16:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722442297; cv=none; b=bo2DoFJ0aK9X79glG7Td1/DKcrAOH4gWPSdAHnCKiTpMhY0rmb8Kz5wps73LWjBs8q3FVsqMEeE4oh6XAhN/tXz7HAAuMc2lTvxrWxGEf3MuP4v+EyBP3bwf0dCLpXKpaH0PCGecOYf2pfpI/OBas6+dPVVjTsbumLltNymrzA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722442297; c=relaxed/simple;
	bh=1eKOkGjX0nFNC5avzkXBDNqXKPdl5YaN3pMfAZOvbu4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Re1fH94S1PNc9YRo39WdayEOuale31NzNTMSwegF+sQm98RtOG+FrKMGwFBDEfAu7kQ8sDbar8GA37XN6zMSAjkNGFLsBy1vBjRLqX6/YHAuaBRrJzncz2bU/e7rsI6iE/Y8GgDCMb5C1rwkMd8QmoneUtrpsI35XDZdmwd2b4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xhs/6iw3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5EACC116B1;
	Wed, 31 Jul 2024 16:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722442297;
	bh=1eKOkGjX0nFNC5avzkXBDNqXKPdl5YaN3pMfAZOvbu4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Xhs/6iw3rUTCZklPVVfWH7tG9HQVL2N/AIBswSh1zdmI8+jQwBlcJuu4YAT2A05Ut
	 mNDDAn7d1suSVo+kguhkmPe+h24QCdW3DudRLjBPdLTZhmLAHf+42aRDBtM+g1p4+R
	 sJSgY8a17+3HyEikthfhTYKfWwDPZuQ60uk9+o+Diff0h4/h3j0W+axnrNcT7J3eRI
	 N0snGnj42wdcPN+NIcQ2GjKXIB2vHLNuBdQTjQXwDdhtS+Gkz69Lxkgmc0+92T1rqq
	 8MmmWPDRWbreZJAMFXLQxwHbdotXNYs687dd5/m5c2lAQbHnUHVi//jKssERWIZrdV
	 Rc/xWMV3JVQbA==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Paolo Abeni <pabeni@redhat.com>,  <netdev@vger.kernel.org>,  Jeff
 Johnson <jjohnson@kernel.org>,  "Baochen Qiang" <quic_bqiang@quicinc.com>,
  <linux-wireless@vger.kernel.org>,  <ath12k@lists.infradead.org>,  Jakub
 Kicinski <kuba@kernel.org>,  "David S. Miller" <davem@davemloft.net>,
  Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net] wifi: ath12k: fix build vs old compiler
References: <3175f87d7227e395b330fd88fb840c1645084ea7.1721127979.git.pabeni@redhat.com>
	<69825f6e-c981-4f02-b10f-27e0799804e1@quicinc.com>
Date: Wed, 31 Jul 2024 19:11:33 +0300
In-Reply-To: <69825f6e-c981-4f02-b10f-27e0799804e1@quicinc.com> (Jeff
	Johnson's message of "Tue, 16 Jul 2024 07:40:57 -0700")
Message-ID: <87v80l8rt6.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 7/16/2024 4:06 AM, Paolo Abeni wrote:
>
>> gcc 11.4.1-3 warns about memcpy() with overlapping pointers:
>>=20
>> drivers/net/wireless/ath/ath12k/wow.c: In function
>> =E2=80=98ath12k_wow_convert_8023_to_80211.constprop=E2=80=99:
>> ./include/linux/fortify-string.h:114:33: error: =E2=80=98__builtin_memcp=
y=E2=80=99
>> accessing 18446744073709551611 or more bytes at offsets 0 and 0
>> overlaps 9223372036854775799 bytes at offset -9223372036854775804
>> [-Werror=3Drestrict]
>>   114 | #define __underlying_memcpy     __builtin_memcpy
>>       |                                 ^
>> ./include/linux/fortify-string.h:637:9: note: in expansion of macro
>> =E2=80=98__underlying_memcpy=E2=80=99
>>   637 |         __underlying_##op(p, q, __fortify_size);                =
        \
>>       |         ^~~~~~~~~~~~~
>> ./include/linux/fortify-string.h:682:26: note: in expansion of macro
>> =E2=80=98__fortify_memcpy_chk=E2=80=99
>>   682 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,          =
        \
>>       |                          ^~~~~~~~~~~~~~~~~~~~
>> drivers/net/wireless/ath/ath12k/wow.c:190:25: note: in expansion of macr=
o =E2=80=98memcpy=E2=80=99
>>   190 |                         memcpy(pat, eth_pat, eth_pat_len);
>>       |                         ^~~~~~
>> ./include/linux/fortify-string.h:114:33: error: =E2=80=98__builtin_memcp=
y=E2=80=99
>> accessing 18446744073709551605 or more bytes at offsets 0 and 0
>> overlaps 9223372036854775787 bytes at offset -9223372036854775798
>> [-Werror=3Drestrict]
>>   114 | #define __underlying_memcpy     __builtin_memcpy
>>       |                                 ^
>> ./include/linux/fortify-string.h:637:9: note: in expansion of macro
>> =E2=80=98__underlying_memcpy=E2=80=99
>>   637 |         __underlying_##op(p, q, __fortify_size);                =
        \
>>       |         ^~~~~~~~~~~~~
>> ./include/linux/fortify-string.h:682:26: note: in expansion of macro
>> =E2=80=98__fortify_memcpy_chk=E2=80=99
>>   682 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,          =
        \
>>       |                          ^~~~~~~~~~~~~~~~~~~~
>> drivers/net/wireless/ath/ath12k/wow.c:232:25: note: in expansion of macr=
o =E2=80=98memcpy=E2=80=99
>>   232 |                         memcpy(pat, eth_pat, eth_pat_len);
>>       |                         ^~~~~~
>>=20
>> The sum of size_t operands can overflow SIZE_MAX, triggering the
>> warning.
>> Address the issue using the suitable helper.
>>=20
>> Fixes: 4a3c212eee0e ("wifi: ath12k: add basic WoW functionalities")
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>> Only built tested. Sending directly to net to reduce the RTT, but no
>> objections to go through the WiFi tree first
>
> Since Kalle is on holiday please go ahead and take this via net.
> This looks nicer than Kalle's version :)

Indeed, this is nicer. Thanks Paolo!

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

