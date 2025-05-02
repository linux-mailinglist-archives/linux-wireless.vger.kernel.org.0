Return-Path: <linux-wireless+bounces-22362-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C55CAA7B28
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 22:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78C063AFD19
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 20:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924C120FAB4;
	Fri,  2 May 2025 20:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q02pJbCV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE5B2144B1
	for <linux-wireless@vger.kernel.org>; Fri,  2 May 2025 20:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746219358; cv=none; b=gWFQewmUgQK3iu9F0w8ONznTqZ9N/O7d9vhLbK03GtfXMup6Wwj6BKjFB4at7McoU3xzZPw7c1LIxK/2CZVjMRgIyGRtz3Z0MXO+r9+nb3L70IVvWmacC8R/ZIFFxVYeDXzA6P9os0IL6+RPoyOO2ABNls5KEnlhqhl+RLoRlGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746219358; c=relaxed/simple;
	bh=DOhPx4mZZCdhikWDX7uXO6tWupJRUtxTuyuxAeqzRGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dmEVEXpAhYw5HTz3EUieFDBAwWj1DTvb77TL79KTDpsI1Jx4jVLN5q85/cqfYH0KjfOXq8ykwem1u1SJkM7ALhG05KVps25SXZFXwTp3JPyGrdAy1SLKq12Ikz5P0iCwHutT4cU6topb6BcHi6fYSiQgaVeYfLLoVXKuJGpZdtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q02pJbCV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 542KAw22014262
	for <linux-wireless@vger.kernel.org>; Fri, 2 May 2025 20:55:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+4PaNRVXmQ87vuJiOT4xCDjQNhYIUUhavxLg1zz5jOY=; b=Q02pJbCVW8UdTnB+
	4GlqU0d6I/PB9fiN9qHVIYFD6aTv8W67DVBIhkV08DhAqBTlBcK4V7COEfz6gMnY
	yKopqKU6PsRZBkIlv15zLoHuyhdwE9VZz/Fboe6ALTRQ091W+ilpWdg+s1zIhrua
	x/jvU/hrCcOhJqn+uF0782SXtTWcnY931KeVApQBiULU2EgkbczZU2nhkfxuqY8o
	pkyGeKis7R656+sAeDx0SsVy3ZDRjcwRv7IlB8C3sLYeQS+66WvxNk3ePHSAT1pc
	IpFxlsCVrPKRUYGZ0npQ8gdbqlwAB97mOezOgIk6aeSLtX2304dmeabqILqCPSmA
	A5sgjw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46b6u41am0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 02 May 2025 20:55:55 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-736b2a25d9fso1772287b3a.0
        for <linux-wireless@vger.kernel.org>; Fri, 02 May 2025 13:55:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746219353; x=1746824153;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+4PaNRVXmQ87vuJiOT4xCDjQNhYIUUhavxLg1zz5jOY=;
        b=L47VLTUAPgKxxuTI2wEMsvmz/UcEVecJD61k/qLw6XPKPntjT35BosPN8Szin2r4Uq
         LLD8XtcjBxMLsK6g2n/xvOIpHXiUlZVMsviLx/8zC2ryqlUTszw4CO5WAEb0PoCMmK0D
         WlVlEvMv+Nf9jkGlc+bNMTAFv2WOJjBzFKrpzMW1bciHYoUQVfc14ZRCmkjDXGhagu9e
         L9yaWDmzn7frQmsW3obsKAkOZBvbrs0+kMKx/HhK4bJgoTcOS9BxaVFacmBVCa2jnASO
         He4jl67Qth41qOwRQ9+/m2+N1ykalZSTZE7Mmre7PFgGXHseQzw9C5tEh+eCpc2lzOMQ
         pfCg==
X-Gm-Message-State: AOJu0YwRJYDS4Qti8YNxNT4gsWtzUwAfOmOHaOoFc4cI0pyDLR4e4COM
	5eyjER6n76iG2zWWpk549/ZrkZEP3GiS1CTNP7/tN0SK1WWxokIs5pwowGUBkiXGR7EmoyupdOY
	h6ePXuA8MsAQhyCzuqnR+w6kTXzWZaI+X51+jY1/mFh1OGNOt/A6xipFA0R1oGxM6d8smGbwL8g
	==
X-Gm-Gg: ASbGncusT5vOq7iCExCDijJZqxV3jY11bP2YsjdC9gNQUKVgyhKRjEwdNKlbcss35BN
	3R2dOO2hsj59xy/IIUNpFGm8i+RKzowZ5q8LKfN4YVrU9CAhy1AaBYsakD4BH4Tg02T+VxmRR9W
	MG5F+j83D6sDhwj1M8T2uEqhci1vJ1Ca1RVnXmiE9KztuavNdTmRVaIfelZcDgzEZRrbMiOgN6e
	iEIxgoqEz6UMNxXOcnbwHq9d084U/Ia+OXQ2jmQZ5o57xTnyKWmhfvYKwXCYC6BL2iFRuoPdFgZ
	QyqsTDWZRHACDQlOPlaauQ8MOCDPFRH922LB2vK31hYaeKm1H2xEVdHMGDbyBSmI7ULbsJ2dciv
	/1TdV
X-Received: by 2002:a05:6a00:3488:b0:736:532b:7c10 with SMTP id d2e1a72fcca58-74058b20105mr6460975b3a.21.1746219353489;
        Fri, 02 May 2025 13:55:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFffGpZrtKkgLla/TGU4Odk3fNt5OEyPgNAZ/Qsl/1dqpk8PXNT9c+jTGvR6f2bz65hq7jgA==
X-Received: by 2002:a05:6a00:3488:b0:736:532b:7c10 with SMTP id d2e1a72fcca58-74058b20105mr6460945b3a.21.1746219353045;
        Fri, 02 May 2025 13:55:53 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74059020dc8sm2061507b3a.86.2025.05.02.13.55.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 13:55:52 -0700 (PDT)
Message-ID: <de8d2a84-6b10-4166-97b5-13ea2544fd46@oss.qualcomm.com>
Date: Fri, 2 May 2025 13:55:51 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 0/2] Add split-phy scan support in single wiphy
To: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250428151927.1169783-1-rameshkumar.sundaram@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250428151927.1169783-1-rameshkumar.sundaram@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Bv6dwZX5 c=1 sm=1 tr=0 ts=6815315b cx=c_pps a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=e70TP3dOR9hTogukJ0528Q==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=YUzBHwSPIL57o_38h9wA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: 9RzXLO3ZG4Zi4s74KEShu7CgAw9qeCsi
X-Proofpoint-ORIG-GUID: 9RzXLO3ZG4Zi4s74KEShu7CgAw9qeCsi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDE2OSBTYWx0ZWRfX0gMaSxWvJYt6 PER99WM+D5VctA26HqPUmSpQKqjU4r+Eqy3So4Fqvu4Th/lmqrqt8cqR+i8rizg+Ha05e1Rsvn5 HT079/TQO64uixZMXA9YDVXTuWxsZZUj//kwvF5Izd4VKql1QrG4rDhr55ouA7p6WnuEjLugdG+
 YGP2M3n5YQo+Qjl+y1NZdEvfHfn0vK4NJIjqDxMyQGSRbLlugmp8KPH4FJjSYzVnAGgo8S+QuNu xLVJpVgQfMLPDaImnpCoi1YMZ/FTuS2NVN3bSMuIpIBtF7LTiS8oESun574FAYfDwAzN151VaR1 FUXw9Vj26AjAsHW2oLngG0NfrZwqfyJoLXSMC22fkGlWM+lssw6aQnkXlRe05Df6cxbEv8X3N9m
 Wh2gHSuQ8X0hgS9THzRGrcTdmxhFUe66YDa+AstEK6ODqbFNYat+dFSERvmrWeZ7RHTirQkn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-02_04,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 mlxlogscore=999 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505020169

On 4/28/2025 8:19 AM, Rameshkumar Sundaram wrote:
> When two split-phy devices having supported frequency range in same band
> (as mentioned below) are combined into an ath12k HW group, they will be part
> of same wiphy and hence the channel list (wiphy->bands[]) will be common
> for all of the radios (ar).
> 
> 1 - 2.4 GHz + 5 GHz Low band
> 2 - 5 GHz High band + 6 GHz
> 
> When a scan is triggered with frequency list containing frequencies of
> both  5 GHz low and 5 GHz high, mac80211 generates a single scan request
> to driver with both the frequencies. This is because mac80211 splits the
> the scan request based on band.
> This results in driver scheduling scan for both frequencies in same radio,
> as driver always assumes that the scan request frequency list from
> mac80211 only contains frequencies for one radio.
> Split the scan request frequency list based on the supported frequency
> ranges of radios in a band and schedule scan to corresponding radios.
> 
> Since the scan request is split in ath12k driver internally, wait for
> all radios to complete their scan and report the same to mac80211.
> 
> Depends-on: https://lore.kernel.org/linux-wireless/20250417-fix_scan_vdev_handling-v3-0-9ec42513d26b@oss.qualcomm.com/
> Depends-on: https://lore.kernel.org/linux-wireless/20250417073954.632994-1-rameshkumar.sundaram@oss.qualcomm.com/
> 
> Rameshkumar Sundaram (2):
>   wifi: ath12k: Prepare ahvif scan link for parallel scan
>   wifi: ath12k: Split scan request for split band device
> 
>  drivers/net/wireless/ath/ath12k/core.h |   4 +-
>  drivers/net/wireless/ath/ath12k/mac.c  | 197 +++++++++++++++++++------
>  drivers/net/wireless/ath/ath12k/mac.h  |   7 +-
>  3 files changed, 160 insertions(+), 48 deletions(-)
> 
> 
> base-commit: 21346cd925c2567d5f56cdb1421c94815ac10221
> prerequisite-patch-id: 621a0dbeb6269fcaf27c808f951d9e2a2c3ac8f7
> prerequisite-patch-id: a9eebd8a3cc3b1ed9ed3574ce9fee088af9c5798

While this series applies cleanly on top of ath-next + the dependencies, it
does not apply cleanly on the pending branch (which already contains the
dependencies).

Can you please rebase on ath/main-pending, and post a v2 with ath-pending as
the destination branch tag? Don't worry if the patchwork bot ignores it due to
an unknown branch tag.

/jeff

