Return-Path: <linux-wireless+bounces-19773-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E78EA4E98D
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 18:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D18F42243D
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 17:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C60259CBB;
	Tue,  4 Mar 2025 17:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kFlSjho7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357A9259CBD
	for <linux-wireless@vger.kernel.org>; Tue,  4 Mar 2025 17:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108385; cv=none; b=e3Y/HuVp00ULeiCOsYbS88Dsr168iBm8A/tqhdqs4fmenwR3t3Nx3JHg98GHkWwn1bvpgZLoug/W1wetdEEpMcOvSTZGsjJp+wQahvKrzzJEaEXF6S3er/KYAc14jA/+icLA4zTvJi6bu/sBBokTRhbSjQcbBs9NpI7cMsB7GsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108385; c=relaxed/simple;
	bh=EfoPWbYpMvt41KkyHHAXpQkIMk18PhFR8EdAYFS85+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ImM5w+oRdaf82cSlpp8zihPFBdAOLDN3XvWNBaOWikNtnu4qpBj7U92f3WpGU6ls3jR3TJOTRDnKaJ9YYf0AA6wL+PH3t4jHAiXZ8LQgooLUv9t/NEocghZHkquiYR8M1ngUPrq/ROVhFnyd/SK8OXy9xtnI/1Nfm9IUt33wrp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kFlSjho7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524AO84t025758
	for <linux-wireless@vger.kernel.org>; Tue, 4 Mar 2025 17:13:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y/8RDQh8wr7UznX1BTQUyabFw//PS1kuHsKPG8oE3Go=; b=kFlSjho77LQOVHzs
	I7CnQa5yfXzfgDOPc3ohM81aY4epBKMRdy2MWad2LaiGDufhUZaB9HDHkWxhMSkU
	2VqK3QWs+um9BuNZbGeZYzUY/WQenSMAM5nO+Dbr3nOqgIR4cVYrFkWC8r3tRWqQ
	3lJi4B+1zNvZ/uBpghBN0uTKWt/XkPGX/BcXuwZzZnXHRHT4FWYSTu8DMpAMXEZZ
	fp8TYfaVMZwsENZg+2SqMyyQZyArBWyWRY9irEUejh95PhKbsdWYy5t20oOzxqQx
	EuVo1kCO5Y1EY/x7YPL+sqMfMdbjXBMybbYT0L14o3ekV/kJhItyrh7SD1vGzAQK
	cWIRoA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6vaj84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 04 Mar 2025 17:13:02 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2feb5cd04a0so9247389a91.2
        for <linux-wireless@vger.kernel.org>; Tue, 04 Mar 2025 09:13:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741108381; x=1741713181;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/8RDQh8wr7UznX1BTQUyabFw//PS1kuHsKPG8oE3Go=;
        b=cf1F9jC5cu2EtfYWZsjqpWJt0BksBnicQ21nO4goyGKc6soIUSSXmO56dbDdKPG78F
         NpAWVU3nPo0EweJZODbPz7rx17QDtgc3BOxnFAeDJRwzF4j4NHgnnVAiq1ma1FMFggZu
         J4SsCAn+6VBKtsLyKqGHBxN9DVGMAqH3fbC49APn5ZEfvkrJ4NGMY+GmN/B8xgVKeYJ1
         EpkFzJTHEujgTulNOXoIx4iTTin9IujjV979Fcy+i+DZy7LH23Wwa4tXKSdP6s96i746
         JPz2lzUirayTXdgg8ARGBInbBxdFIyLLCfsqokZJMioIHySYQFTKrBzGmrXYfGACg3Gn
         vPeA==
X-Gm-Message-State: AOJu0YzASU2uLQ0odE1oPtXbTepJJqsgE7nO4phvYn5vuRa9MtFmflh6
	lK0lPp+QCZBf77yXBCFy7cI+T8YpM4MPZ0MSb7VoddCIbWGceN8hoLfL3AfCfkD4yLKbAHxMEIT
	83gfIdYdql/1quiPiCHVsBPpRD4fVO9Dgo4Q0ULV2dR3BL+1TWv56hn2kvgcL4pm3UuR5qsPOZQ
	==
X-Gm-Gg: ASbGncusv+N45vdyL4tKQAXuG/OSUTEu+I7PpE73fQjOQiYWDAXMjrvc3Quxi7ediFE
	5Map4Il38Vmk2+pK+CTLFQKZqZ7HrKGGjmGAp70it7Kmd8heuVL5FaaEmQ6vyX8w7U6B8moKfPG
	NA6w600/FFoL+S6LCJMydNr/ARBBAxtR1OqLx/rDeAj7e2t5l+5+slEQuVtQ29lo8P+sQcAM/kI
	f+bPVtzWzAyW/tuFARDZWLws/GLzhtQR0fpzhrSFhru2VbcAP6Hwu3MakmvZXCEarwym1NiN3Qp
	o02MnUsDBFNOS29Y6sqD4xte4WR/Row9XxwKKZbx3+nSTyMaHBPzpRiBbDW3bXBIf6a3S6A=
X-Received: by 2002:a17:90b:2e06:b0:2fc:ec7c:d371 with SMTP id 98e67ed59e1d1-2ff49774308mr74703a91.3.1741108381173;
        Tue, 04 Mar 2025 09:13:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjMG39Rd4ec3cS18rTFLoQUEXepbg95yZLvsgbxRn4IzQCdTKnRiWMMWlOJ4rOlWZv7gLnYg==
X-Received: by 2002:a17:90b:2e06:b0:2fc:ec7c:d371 with SMTP id 98e67ed59e1d1-2ff49774308mr74677a91.3.1741108380773;
        Tue, 04 Mar 2025 09:13:00 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2235050f210sm97883245ad.205.2025.03.04.09.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 09:13:00 -0800 (PST)
Message-ID: <d6b45785-22f9-490b-96dc-8b448b700bb9@oss.qualcomm.com>
Date: Tue, 4 Mar 2025 09:12:58 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] wifi: ath12k: Pass correct channel frequency
 parameters
To: Suraj P Kizhakkethil <quic_surapk@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250304095315.3050325-1-quic_surapk@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250304095315.3050325-1-quic_surapk@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: GgMGPzIGQBAqB3JEGNDwlWnbiThFxk_M
X-Authority-Analysis: v=2.4 cv=bPnsIO+Z c=1 sm=1 tr=0 ts=67c7349e cx=c_pps a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=pXsx2e1gGNpEw_TLi-QA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: GgMGPzIGQBAqB3JEGNDwlWnbiThFxk_M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_07,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 spamscore=0 mlxscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999
 phishscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040137

On 3/4/2025 1:53 AM, Suraj P Kizhakkethil wrote:
> For higher bandwidths, the channel frequency parameters passed to
> the firmware are incorrect. Pass correct values of channel
> frequency parameters.
> 
> v2:
>  - Replaced arg->band_center_freq1 to local variable center_freq1,
>    which is initialized to arg->band_center_freq1
>  - Rebased on ToT
> 
> Sriram R (1):
>   wifi: ath12k: Pass correct values of center freq1 and center freq2 for
>     320 MHz
> 
> Suraj P Kizhakkethil (1):
>   wifi: ath12k: Pass correct values of center freq1 and center freq2 for
>     160 MHz
> 
>  drivers/net/wireless/ath/ath12k/wmi.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 
> 
> base-commit: 3148fc3cf193dbbd2e14eee59468a510a38bf604

Some reminders:
1) per new guidance you should have added the destination tree name (ath-next)
as a patch tag, i.e.: [PATCH ath-next v2 0/2]
2) since these were trivial changes you should have propagated the
Reviewed-by: tags that were given for the v1 patches.

No need to resend for this, but please keep in mind for future reference.

/jeff

