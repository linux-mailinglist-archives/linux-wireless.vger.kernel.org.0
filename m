Return-Path: <linux-wireless+bounces-23701-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D8BACE036
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 16:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF023189AAF4
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 14:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD5428C845;
	Wed,  4 Jun 2025 14:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N+gdz1T5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9960726ACC
	for <linux-wireless@vger.kernel.org>; Wed,  4 Jun 2025 14:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749047085; cv=none; b=MZuHHmrPY0UtmwAhCJhG8XZzxqwm6SKibyIj/rLcHmX6pvH4+51H28IQLkfypbXAP1kDOwZukXwydcbW+a4GMjP2ARy9hc5gjAdVh0LAq2Vz+TeT/DobtmtpjfoRgT/cbLgwqe70t0PSK21nO7JtVl/HzxO+eqAOpKGDsLSFXaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749047085; c=relaxed/simple;
	bh=YuqOo5L+8xUvvncKuuiWvwOIBMMlZGWXUxJnmeSv7Kk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kiPQGLqgp1rUTbuGsZ+yagAV0xdKCikKLhsJqvUIX5Ldmm9ZdhRi5XIKFdoyOV3PR+OENUqYPinJmbeH9WyS3AlB5rRPvI8oDUOPjIIZFxvXoOoD10HBCm94SFY2KFaM8fSLt6OD7ja9rXg+IolkotdSU150syJfHjovGRW8LYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N+gdz1T5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554Ahnmk023019
	for <linux-wireless@vger.kernel.org>; Wed, 4 Jun 2025 14:24:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0IJLY6xsEZDcUG0P74uRftlOIFbWofcg0+xhUvkejEU=; b=N+gdz1T5dhbHZgW9
	Wojb/Pp10zKIl6PSwBtfpvCm15x7sYdtxR5mkmvTGi8xeHBESL8nnWfwBT/xwafu
	s89PUhFB/CMVWGbAnOz2+ViUSlW0MPZ0aFN2s+euf1/hSNUhfFmi4a0EmU8cj6vz
	wEsKX7gJul2TyCg3ZAOy+MajGlHth/fHYz7RrqNgGsj9lNVSJK6rln3GzvbcgOtU
	qyc3pCyCHxB/pkNX2QmXNrbd6k9KM5fGiptaLDZx/rIPZkZRoikI1GqGrtzFFk8E
	ln81hYtkcj2dBJgfPEBApBUOtAc51VacIqq1YR6x+J5rH94qjTvgN+cHTh1rGetP
	PJuqNg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 472mn00jwb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 04 Jun 2025 14:24:42 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b26e0fee459so765483a12.1
        for <linux-wireless@vger.kernel.org>; Wed, 04 Jun 2025 07:24:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749047081; x=1749651881;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0IJLY6xsEZDcUG0P74uRftlOIFbWofcg0+xhUvkejEU=;
        b=ZRaWvicSZb7BqxbZ8W5F/R7vvO8uW2cTZ9yiLh2HBaDuf3mgSa4LJoFpAJsK6Rl6WL
         /SYezne8/iLdABFDIMWUc4TcxFnkjOkoUo+AqpnM9uyb9vCpvhQEI2FoAPbJbvzmRAES
         9kj2ictF4T95VVQgSr3VWaz50criEuR7Ox+3OnJJgvqnV2xHS8zqkyt/86UiNSC3Odgv
         3NBVLqYhfhr0dJTYNMR8KdLCEBTrOpSFPr7chOdoUdcZ6lZBsUBGV/ADHqEFnoGcCWuf
         fWpJHnlw5k62SHjIkvb2Mv2uL6fPbEsj8bAcekjPSEc/uMUAc5Ar8qBfAmOj0YfSO/k+
         ltew==
X-Gm-Message-State: AOJu0Yy8TCrR0VlbncyujrlUri1KcelMeNnnQQQaCVJ8zug28QBMPgA0
	yIkkBuqrzzaC2r/VPJ95EN1pmfjpaZVto4oyQ3jPK+HfZfi7CWD5icylzqrQV57BmfQqvsrvRRb
	0Yi7EcW6gds7e0oV+7bgVtvh8CU0ys6C/Nnq/jFdSPoXFvFnnvMZf18p9mNFs+HfyXXs4/LNcPZ
	b9gw==
X-Gm-Gg: ASbGncsdoQTSSldSDUE8BlksNoi78++VVHkJ0sQ5T14sDdQK2WKoD8djGYsVWWhnswd
	Srf9vomudINkWpm3oO5DAGwFpzoPI6OJyVo+unAD8Ja5kWin7Bq+yMV8/slCXCLBIWwFYFL334Q
	bLXunNSJoBVxlKmk147heXcrTBvgf7MRudlg9i/dmhd6X0vi/K7c8f+nc7m5QdXHXnr45TMajns
	iroU3pDDy1fHFJzo7hPniupq3Gk8lvFMicgrxGkNm6HIJjxClEAkk0SD/UfN6EzmcGMLSdIpHfh
	xG15JQMAiEyOkIOMSjF+G32p70vacLSFAEM0xBR2rmWBFH8RUySQJesRKmnZ88GNB28=
X-Received: by 2002:a17:90b:350c:b0:30a:3e8e:ea30 with SMTP id 98e67ed59e1d1-312e80285c0mr10631065a91.11.1749047080893;
        Wed, 04 Jun 2025 07:24:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJgMv73IHmYkK5db7JqbBVYy6pAWpAH5/6I52na6kJ17Rbbqm2aLVI8AGnqaxQfJag8UYx0A==
X-Received: by 2002:a17:90b:350c:b0:30a:3e8e:ea30 with SMTP id 98e67ed59e1d1-312e80285c0mr10631020a91.11.1749047080409;
        Wed, 04 Jun 2025 07:24:40 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-312d8f563c2sm3848568a91.10.2025.06.04.07.24.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 07:24:40 -0700 (PDT)
Message-ID: <966fffd8-1ff4-4a29-a0a7-fd081a12dd45@oss.qualcomm.com>
Date: Wed, 4 Jun 2025 07:24:38 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 3/4] wifi: nl80211: strict checking attributes for
 NL80211_CMD_SET_BSS
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev
References: <20250604085539.2803896-1-arend.vanspriel@broadcom.com>
 <20250604085539.2803896-4-arend.vanspriel@broadcom.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250604085539.2803896-4-arend.vanspriel@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: kt_r6pWljUHw-0Suqh_UvyRrqt5H81zd
X-Proofpoint-GUID: kt_r6pWljUHw-0Suqh_UvyRrqt5H81zd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDExMCBTYWx0ZWRfX2ChKtayj1fBD
 alBbYOffhxotqh0W+vQfVmaE1TveBpGCrxrkjbifQgTV5CjgZaM0NsnhYHjgAxEGvrCITtFhyKG
 lMRCp6z5pHmJ546CPmmNNyv1+lwF+2nfO0Icn9tbMLJKZG4bYuyvzDTwunHzTWLUjSWF+OjJ2mY
 E/vlOxWbplDuVyLWyp4RghBwei4hSoo/Qxv6cBnnc0vk0QKdbe38uBRseliiSfJ2suupmi2DYdN
 dywNeBuelw9VYqaEwz7ADE0em0ByD95OXiZXy4HISQ75oHx0/5UgSJxQOlnouQr0NTofXfvD64k
 NZRnjrzepsUrxXhYk6zVY/k5y7CsLH/NJ2jZU1jgEqEgeYl/+ZgqkGN4kj/X8SjY4ZYkvorkb3Z
 9UgbBfIUoAfNqNhmfTrmEca9fOnIA8a5Qiv6T8ZlbUs0XD/dy95RPHYAoSDi9TLF2xAwnY3b
X-Authority-Analysis: v=2.4 cv=Y8/4sgeN c=1 sm=1 tr=0 ts=6840572a cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=k6iyqhMwue5QZAiwf48A:9
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_03,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=855 spamscore=0 phishscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506040110

On 6/4/2025 1:55 AM, Arend van Spriel wrote:
>   * @NL80211_ATTR_BSS_PARAM: nested attribute used with %NL80211_CMD_GET_WIPHY
> - *	which indicates which BSS parameters can be modified.
> + *	which indicates which BSS parameters can be modified. The attribute can
> + *	also be used as flag attribute by user-space in %NL80211_CMD_SET_BSS to
> + *	indicate that it wants strict checking on the BSS parameters to be
> + *	modified.

again yuck that this attribute id is a nest in one usage but a flag in another
usage :(



