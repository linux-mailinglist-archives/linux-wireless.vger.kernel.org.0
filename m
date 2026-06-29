Return-Path: <linux-wireless+bounces-38253-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EBUdEyURQmqizgkAu9opvQ
	(envelope-from <linux-wireless+bounces-38253-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 08:31:01 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE036D657C
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 08:31:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=KDwSB9LT;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Qrsujzhw;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38253-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38253-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B5DD83006F23
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 06:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423EF3033E9;
	Mon, 29 Jun 2026 06:30:58 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3992830D3F5
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 06:30:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782714657; cv=none; b=lKmdfyoX7HxUKx47VoUKHJjuL/NjurFCpoS2Q0IQ5925haNBb5Ns4zpf+YQ5A4U+B+2v3Q8qDIgZqSwMbTpwrzxG1JUf3HKDVrov7uWGnCHVPKbNoe1/qtI5uMxo4HuPAdMnHNbjH8LAyhoGLEoRUA8EgMUiK9hoyvWZgVcGrZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782714657; c=relaxed/simple;
	bh=7UBKx+dli8ih22FYK8dSf167oGeOJhBMAkoFVCDw8xw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jXb0KuST/OiWT6qVTs0G3jaSibRVW63Vj0dr8TJiClLET7628iw3cqcQxL6pCZLT5LBImcc72gYaKhJlbo9tfAEGqyzXRKiRBSUhCxpmaBVxu9n05eT1esu+jdfMWomHRR74Ll+aDMRU4qF4SNQ632aqVPPIFqNxOsrxcqqj1Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KDwSB9LT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Qrsujzhw; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T4NVHi1777434
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 06:30:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7s+FWz2YK/JFLm10dvgPWqrRER52k+FY3kHb80jN8uY=; b=KDwSB9LTZm2rajdA
	JN8r70i24O5IHE6KZUwQrHYLizm/vnz5tHIkwbO+2ZBdsarFWqWmeUr0RQFPiwXl
	lQqTHE8yWKraIXcK6P9NuY8ZtvF8fwKrBHXgvz+5zE7ucNpIBBO3E0R2aEbTR2it
	IOw6ONWeVeDJpzk3tRxAMRPHoFlCXrESdKdSbiLZ/B0Hj05nDf45/6rQhcI0RtFR
	ei/zViVa8do3rldy5sbvf7sNjxN4yN5RBvXsXMCVIFjpGD2ecx6la5GENFf7yhZv
	I36hu0dK8+Ng2SdlwN4UoZsH2/8Kh3JElSY+kRY5Hhwdr8R/D0n3OllYrgHLPsmh
	zMe1vw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26x8myjj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 06:30:53 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30c0d568830so13815971eec.1
        for <linux-wireless@vger.kernel.org>; Sun, 28 Jun 2026 23:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782714653; x=1783319453; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7s+FWz2YK/JFLm10dvgPWqrRER52k+FY3kHb80jN8uY=;
        b=Qrsujzhwk48wP4YiEXbTZMYoPIblHwcoxX9ItniR0P76kqy+ub3Uj9R5HjSv4OdvDt
         +Y5nRs/ihhymwgoMFLNiYpMzQr+1jfMHdyHk9GxEM1CCd3iDfs5uk9ZpgoxxIiA5eWKH
         JN/XeIhKfjEr0QgGSleF5a6ME2wl47W3JASSp/+4jGbviLDg5RhT0e/JmwvLsi/P/aur
         meU49EvD0sG/MBjWj8wCgGJzHUeFpkkFbmUNnPT4l34t1ItuFQFxcGXf91iMdjyo75PZ
         r1eK0owSZfvOgeEMe1WmY+fKTV3hk1G5wQKGYnkmnBVslaF2r4vy6u/mP38uXMVyTMD7
         LhQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782714653; x=1783319453;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7s+FWz2YK/JFLm10dvgPWqrRER52k+FY3kHb80jN8uY=;
        b=a9sLQwmX0UBp6GFWt5FPbQ27FJjlXY/0sFdx7fv+6jC5b+RPPPymb0+Z7LI5XIhckI
         QfJP0ymJYXjfXLupIyls5Tpl8xg2h/9uvUSi1M1/OJ5xBr/iAyEdQYhSlQGJf03Mm+1/
         A5CGE6327uaDqUPBOmwDb0ZnlGmxH455y/xVbpzVEm7z/wcvbW9FrJ9ke2wmxG1m3Xdo
         4tAiCowfFU3V99YGL9HT7eLmbrhEczQ4V9t4ILV0Mw8ZxkI8uJW1zSIhTdvco5Qdv+gq
         had3X0e7yObyaAB3btvjaUqfNO1GX0j+Ie4mVOojxz0QefgL5LOAQHMDtCtcBzP2ovIM
         S37A==
X-Gm-Message-State: AOJu0YwnFGQVhXXjct9OHNG/K0WZIrcqy+ctm+Y6+v7HlGnbA6KGYtbu
	iaUPCfBtsDr5qL25aNSoGw0KQv05ucaxTGWjkCtAmnncSC/xLpp+A+pETme9zYkhPpDA3VAcd3k
	4cQBxAseyF+m9+AKjYU/GZMeUXiKrWAvRatfqr8gauB0GRxMNgxIcIHEn+1e23Yg4iuewjw==
X-Gm-Gg: AfdE7ckUVMgxtAcHmxpGdD05Q+LWxmJg4mO44xZEZCQkWMMCPbsv4kDHF50Y4SoHbjj
	rfxBq1r6fmiijtykFBTaEJ/bGueCLlGpoJq34VLY+FbTdtNLAkqCLnQgqIu/a9XY4LD0obDXPe0
	QjbrpHugOkNh4ZkSxNiLl3j7DVU27mD2Rq6PcKrWgpm9M/G4F5aWK+Wy29HytynHjEd5kN3xloR
	UjjRWhJzpVKpjclH1xBDMm1v4bwQpiV16eyaOhn4aawzUh98VlLVu0BlBzcsvTEg1WNx+E1EHFP
	3XKleuB1Rg3hp0Vr7WIxs0uVqmdFtwg3H6dnincJvalhJNE7+d5FhYNdydf/u/HVxizxhf5oWfh
	Qr5JB0B4cJ7TYpnREs093+PU5hgkdU/PBqnQNI8F5XMI0gqp0y2I=
X-Received: by 2002:a05:7023:a86:b0:139:ed5d:3b5 with SMTP id a92af1059eb24-139ed5d0577mr6889813c88.46.1782714652614;
        Sun, 28 Jun 2026 23:30:52 -0700 (PDT)
X-Received: by 2002:a05:7023:a86:b0:139:ed5d:3b5 with SMTP id a92af1059eb24-139ed5d0577mr6889791c88.46.1782714652036;
        Sun, 28 Jun 2026 23:30:52 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139fc2ebcc0sm9925728c88.14.2026.06.28.23.30.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2026 23:30:51 -0700 (PDT)
Message-ID: <4c76c950-46ab-43b6-9189-e3ba87729cc0@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 12:00:47 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 0/3] wifi: ath12k: Fix memory allocation and
 improve reserved memory handling
To: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260611033314.2330-1-aaradhana.sahu@oss.qualcomm.com>
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260611033314.2330-1-aaradhana.sahu@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA1MyBTYWx0ZWRfX0MyaJy3ojoz0
 uVj8mhR/uKOYb7Si8yxJZroUV5AETTtcMv83Z9Tnk9X7rMrNcr7A0quHUbUSAwVHmpeN3DSfUab
 lzcqVB4O803cgNVgBgbj65RW8f98DXg=
X-Authority-Analysis: v=2.4 cv=D+N37PRj c=1 sm=1 tr=0 ts=6a42111d cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=l9q_n_bfIkH6dLceHHAA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: YbPK_E_ymdFelH6n1mfdM10li_a1GyWm
X-Proofpoint-ORIG-GUID: YbPK_E_ymdFelH6n1mfdM10li_a1GyWm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA1MyBTYWx0ZWRfX8FE3eZsJxkkm
 OaMMUNTaSIySuotH7pgtml7UxcDQSnm7yRLg1dbRm0yx8MHvl+TFZ5F/bvCPDjYVND5j0w0MNBf
 DWZsXa8hXyjOi+OflxPei1oL+zqXlxPQLDESLxr0WgoncrhGjm3TNboMaSb9ckMUOcJjCde11QR
 zTHcwgCeV3AyGzBBU2voRHVlOC7x2JUIv5MtCsZgEO6qKp4zbeMZrU6a8CEoJx0dpvWEmSN5WV3
 jJFAwelXsNWGsSeLmipOy8Ewo+eojlwjdKYT5pSNCHt0hnqT/Zytc0S+QHEem+fccoSPK1McQiX
 HbyS59DDEOskT/Vj6NDHYF0XigvVj4JW7UyVekJ7rctRTLZWolllhECwDKsTHbmstBYYeYa36f1
 cPwhnhDxrVwrA6NISL5BmtC9IBUSBq8/OOMDfNfr8tQ4wW0u2+C3cMv4TH4qCDLdmjfwszg+xVb
 03t0fxZfyquzDTyFS/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290053
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38253-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:aaradhana.sahu@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AEE036D657C

On 6/11/2026 9:03 AM, Aaradhana Sahu wrote:
> The current implementation relies on index-based device tree reserved
> memory lookup. Different platform variants define reserved memory
> regions in different orders and combinations, making the index-based
> lookup fragile across platforms.
> 
> Currently, the driver allocates the HOST_DDR_REGION_TYPE
> starting from the base of the Q6 region, which overlaps the Q6 read-only
> firmware section. This causes firmware assertions during QMI memory
> allocation, as the firmware expects writable regions to be placed after the
> read-only section.
> 
> Address these issues by:
> - switching to name-based reserved memory lookup to remove dependency on
>    device tree node ordering,
> - refactoring QMI memory assignment logic to reduce code duplication and
>    improve maintainability,
> - placing HOST_DDR and BDF regions after the Q6 read-only firmware section
>    using the bdf_addr_offset parameter.
> 
> This series ensure correct reserved memory handling across different
> platform variants, prevent overlapping memory allocations, and maintain
> backward compatibility by reusing existing reserved memory region names
> defined in device tree bindings.
> 
> Overview:
>    - Patch [1/3] switches to name-based reserved memory lookup for platform
>      compatibility.
>    - Patch [2/3] refactors QMI memory assignment to eliminate code
>      duplication.
>    - Patch [3/3] fixes memory allocation to place HOST_DDR and BDF regions
>      after Q6 read-only section.
> 
> Aaradhana Sahu (3):
>    wifi: ath12k: switch to name-based reserved memory lookup
>    wifi: ath12k: refactor QMI memory assignment
>    wifi: ath12k: allocate HOST_DDR and BDF regions after Q6 RO region
> 
>   drivers/net/wireless/ath/ath12k/ahb.c  |  18 +--
>   drivers/net/wireless/ath/ath12k/core.c |  25 ----
>   drivers/net/wireless/ath/ath12k/core.h |   2 -
>   drivers/net/wireless/ath/ath12k/qmi.c  | 168 ++++++++++---------------
>   4 files changed, 78 insertions(+), 135 deletions(-)
> 
> 
Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

