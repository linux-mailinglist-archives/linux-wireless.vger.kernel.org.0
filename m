Return-Path: <linux-wireless+bounces-23183-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE4FABDFC3
	for <lists+linux-wireless@lfdr.de>; Tue, 20 May 2025 17:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D0D8168591
	for <lists+linux-wireless@lfdr.de>; Tue, 20 May 2025 15:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59A426159E;
	Tue, 20 May 2025 15:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZOco06WS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABE52571C8
	for <linux-wireless@vger.kernel.org>; Tue, 20 May 2025 15:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747756783; cv=none; b=lWLuTTRuiybzbKBnuWcULDRN22ZO8kcK2panbkMU//S6f6Hc1rBAEHupe0dWXPPL156g/L5MZOSvUFllH4zrLmVN/+FZVJdxQfXVD2BMi7xEGW9qDLU7jX1Zz9cv1grZGouucdJvjiM+MoqbEPB9yjPb0gLPwwRHEUL7gDUn4jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747756783; c=relaxed/simple;
	bh=OcrrhDDH7vgYDN0E5Wpfg33umvt0b32VvrIdrQihVoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fLT4AtIfRFJgfc4qGT6dUPxPr13iStyKU1qEtmxkv2lnZ3ONXao4J0AiFNFQ+tQ7eG5sek7OPY0Xh2fpla06yLC6PjmtSLDkmugrFG807KUXfGsBDOiaac86CW9puRn72/HmUy1y8Poi4MQKbM1qC30QXw6ra6l+gXUZuAV9rDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZOco06WS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KDrKtn024831
	for <linux-wireless@vger.kernel.org>; Tue, 20 May 2025 15:59:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/xfg4gRbkgVq+WXf/LY9kF1qgnqADeMIlYTZaqw82+8=; b=ZOco06WSG+bs5GSB
	yJ/9sY/4a0XMGr+xyhT8EfAabjAWYMSk2PziXtwFlEyZMPkUH+efvzSNhHOJTxH1
	vpTqr8dr0hnYJ+lUtO8rwKzS72V5EcDCZtNlXnBT15K2wMj3NlW0FvSPokf+6QJm
	xdevgrnBkiSCrGKs5PbzPD/rUcLFNFMIvJTjtU4y6Xhf1QFt98hwUUZ1G/tSqZq0
	6kMgM2ct6+R7cgI284FKlTgfvBUFIR6iT2SINeK6GpRBprpDJVurX+N/aan6XUP2
	ZIF4oON0KxNlIGEQrPRIrw+ws9Cd5U5p09KFTmVIhpszEv76kcdPa9/NZJfMB7Ai
	IkLOaw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46pjm4r4nb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 20 May 2025 15:59:40 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-742d077bdfaso3024622b3a.2
        for <linux-wireless@vger.kernel.org>; Tue, 20 May 2025 08:59:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747756779; x=1748361579;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/xfg4gRbkgVq+WXf/LY9kF1qgnqADeMIlYTZaqw82+8=;
        b=dH3K/OpRUuXx57dGIY4wVm7qeYeAc1EhlwEYJ7J6Ph6Q6U0YEEkSoSJNtEbZ+ZuHb7
         KrLafL044I6tUD0svvLhNnsz9fJkd0483t7NSnwn2sX2S5t3E1hfIdte+YNaWdx6hQsl
         1F2JKx9YWWqiQzHaZvgHsDzyR9GW4PJ3dgbS5B/0QDpjhSt2AEju8Q7kD4MUD9axQPzQ
         h/3r8mW+RPxi2SRkKyabdwoQESFsXda9VjQdzHOevS2WV7rKJn6yJxOT4hK86u5gOCO1
         6FezmgDmYkFXKbOKVS6eGSUzL+JqvOLsSE6B7t+v/rUx0A77pppe1XDOaGioYUXUKgj0
         s45Q==
X-Gm-Message-State: AOJu0YybEQqm3qOcRXgoilrMTNmD98PgsHDdXht9nkPLH3Fww1mu7bXS
	65ucumJEVlFSXxVCQgi77EhW1wnRRFAUZb0xzMl1u0jms/JkTBqOUIRvFjqqIOXHgYuTkZ4nRiC
	vrtMq4KqcWZJPLG9LjHSlSo4Vzd7EHaZ15NMIe1KOinar5UUkPT1DLtQfK9BcThHI/B21PA==
X-Gm-Gg: ASbGncucwsftK2keCMWecty8EnpzeDUO6LSi5MyJB2CC9E/a0Dp7wyPw37DV+XTzN6F
	2cjcuOlZtwZZ0HxfTYKiwEacORyJIxIntvAYcj0eKUIpnarmbL2Oi0p2GafctGGPftT8LXY7e8E
	qc7uHw9sTcvRcP4HG9wCkYodW2erbwVKfJ7un5f5/RTIUNAFkMYKSsm5078q9n5YeFI9ggeb3xz
	zFCrciTYWV/M3oTU5I8F9jBGzGPCJl+fcW26o8igp4blkKZTzZnv7sSVrpX8nwQigu/+8HQxdqG
	qwJz2jDKwJZC4yfVXLU8te/TDWCjlNXzvPPNZNZNa7X+x4BbYvk+cxbeOYQne2NLkC4=
X-Received: by 2002:a05:6a00:1790:b0:73e:970:731 with SMTP id d2e1a72fcca58-742a98b2242mr25057071b3a.16.1747756779447;
        Tue, 20 May 2025 08:59:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWizgywn3XyGyGTvaNXKFMpFRxaBh8bPEJyF2KLoiqVV6nES0DTFBt4rWEuNOifqkRR6z5OQ==
X-Received: by 2002:a05:6a00:1790:b0:73e:970:731 with SMTP id d2e1a72fcca58-742a98b2242mr25057047b3a.16.1747756779014;
        Tue, 20 May 2025 08:59:39 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eaf6f28csm8102336a12.22.2025.05.20.08.59.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 08:59:38 -0700 (PDT)
Message-ID: <12cb2f34-2142-4a38-9e73-49c2cf66d8f8@oss.qualcomm.com>
Date: Tue, 20 May 2025 08:59:37 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2 2/5] wifi: ath12k: Add ath12k_hw_params for
 IPQ5424
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath12k@lists.infradead.org,
        Saravanakumar Duraisamy <quic_saradura@quicinc.com>
References: <20250518-ath12k-ipq5424-v2-0-ef81b833dc97@quicinc.com>
 <20250518-ath12k-ipq5424-v2-2-ef81b833dc97@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250518-ath12k-ipq5424-v2-2-ef81b833dc97@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 8PBuMRI6HPt5JcU2zniWfoXyXC99UODI
X-Authority-Analysis: v=2.4 cv=C4bpyRP+ c=1 sm=1 tr=0 ts=682ca6ec cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=dKmYHbQ-0j7vB82BiUwA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: 8PBuMRI6HPt5JcU2zniWfoXyXC99UODI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEzMSBTYWx0ZWRfX4AUaEAi+Sqy9
 3SJw9etjrIgcw8ojGPepOWoAZvgSswLHqSCZFqLkiwEWTiQAi5t1A6SScCKBU+ty8h9TZnubZZj
 oareOvYVuLS482SzUzOsAFSSri3abkDeRX09JDu4aMAxaSzW+foGFOiUUlINi/eF/sD4se8z6bv
 8sFHd07E4s52oIBuWXcKSr0QVmowHHwbUJMyOB03uv87VDSiGAbAU9bJ5E/Z+a3knQ0Eo0W5pRx
 N6gTr3iGHCJP5s9a3Qkbe2dkiYvHmWblE/TVSnpp9VuF7jl+NRdrSMCHM+hAKV1o+/DzL3MQJsq
 cUG7hT+gYhXfWh5FYQIXbSOrN2d4vRO3cgE+MwkQUWwqnb0Bsli8ObwTt3R+k6o5k0vLJJ/v4gH
 7cYiZi0pz2FSFLRAuM0R00dfv6TgC16VyWrG7AHWJpgLwPU9fuo+C+wYeiZMBt8kJvbZzQYq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_06,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0
 mlxlogscore=954 spamscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505200131

On 5/18/2025 11:22 AM, Raj Kumar Bhagat wrote:
> diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
> index 7e2cf0fb2085ab014fc14a5c81074802674b154e..866de53f37bb5af94e16c796a0052fda39eb4ea8 100644
> --- a/drivers/net/wireless/ath/ath12k/hw.c
> +++ b/drivers/net/wireless/ath/ath12k/hw.c
> @@ -1590,6 +1590,84 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
>  		.ce_remap = &ath12k_ce_remap_ipq5332,
>  		.bdf_addr_offset = 0xC00000,
>  
> +		.dp_primary_link_only = true,
> +	},
> +	{
> +		.name = "ipq5424 hw1.0",
> +		.hw_rev = ATH12K_HW_IPQ5424_HW10,
> +		.fw = {
> +			.dir = "IPQ5424/hw1.0",
> +			.board_size = 256 * 1024,
> +			.cal_offset = 128 * 1024,
> +			.m3_loader = ath12k_m3_fw_loader_remoteproc,

Until the firmware is available in linux-firmware I cannot accept this series.
Please work with the firmware team to make sure I get firmware via the
internal release process so that I can stage it.

/jeff


