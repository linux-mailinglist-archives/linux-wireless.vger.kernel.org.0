Return-Path: <linux-wireless+bounces-20555-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93058A68B2E
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 12:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 651D8173B13
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 11:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984662580FD;
	Wed, 19 Mar 2025 11:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jiLy5P5W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D108F252903
	for <linux-wireless@vger.kernel.org>; Wed, 19 Mar 2025 11:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382469; cv=none; b=VHI8HJbMCRpRVmrQ+K2fmFI/uFS+Ls+XqvQvghex3OVbzJKz+1GauCnOWUNYXoMQgwzAf9toN9GDfHoJQEQKq9+UBNqnXNEocyj2TmI95GC4Qa0pXkXSJxvPOD3fEDXDDNWwbRohAmjSXB5fe13YSYthvEtW/1OUL//bdMRIbfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382469; c=relaxed/simple;
	bh=fZ8oJmeFKMm93DxJqKBdkBV7zxk5UTG50Q+hfDzY7mU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GdS0B5a2tMh5OIWjozRL7XNn/XuBG6vqWxrz10JMjFUSJCdFUl5A74P42mhNSaDppY4/FrEksUcqRFoQM+rCj/9Vj7O83E7Rnfyvf52iqoIQS0YTHoiqPuBPva4QhvUuLLkMox6aaEDIiUO3cHS+h9W/mYkYyUO7ATdCEMRZnwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jiLy5P5W; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J4lmMa009848;
	Wed, 19 Mar 2025 11:07:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jqT8pRpxQ7BIjrQnHq7b0zNLT3HX21aTlRPxvTISfdo=; b=jiLy5P5WKilhHEdG
	jW8nUFQ770aWPF2LoakOJx8vnvwuh0imU+qGDOBCarui4Cm7F9hakTB+ropClpaK
	tVxYDnvjgQS7xMT2NedSQTHU+XeHA3g9gZr/e5iTXgIpUpePOfz5KNqveT/6oEik
	bKYqNSX6U7T5gfWt5Fxix1VBc+tIRGCbUBRPL+sIOuH6/rwtQeo3J+ij63KNN044
	2718Ruo6eoGcL3lTIL6Vl2btywvB5KDCGXlUUdgk8xsAyhao7C5Ur1bADUW31deW
	Fl8URaXrKaNWmBhRM7VdZ8w0JdAyn6VP7mgWBIQeYKMBJGCsJkJ1FVM7uuj9TLF4
	mfJEXg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45fdvxj78w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 11:07:39 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52JB7c73027330
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 11:07:38 GMT
Received: from [10.152.206.29] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 19 Mar
 2025 04:07:36 -0700
Message-ID: <59fdc784-1efc-4474-8b47-88866419cabf@quicinc.com>
Date: Wed, 19 Mar 2025 16:37:29 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: Fix incorrect rates sent to
 firmware
To: Ping-Ke Shih <pkshih@realtek.com>,
        "ath12k@lists.infradead.org"
	<ath12k@lists.infradead.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Pradeep Kumar Chitrapu" <quic_pradeepc@quicinc.com>
References: <20250318085013.1296262-1-quic_rdevanat@quicinc.com>
 <02b93d7699504cac89f46b1aa43c3c1c@realtek.com>
Content-Language: en-US
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
In-Reply-To: <02b93d7699504cac89f46b1aa43c3c1c@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=SKhCVPvH c=1 sm=1 tr=0 ts=67daa57b cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=xVl7SRJMKo_yyIKq5cgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: fhJ582xcrMCpwHgnFZkwLi2f1SM3d3hS
X-Proofpoint-GUID: fhJ582xcrMCpwHgnFZkwLi2f1SM3d3hS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_03,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1011 bulkscore=0 mlxscore=0 suspectscore=0 phishscore=0
 impostorscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503190077



On 3/19/2025 7:43 AM, Ping-Ke Shih wrote:
> 
>> @@ -3450,7 +3450,9 @@ static void ath12k_recalculate_mgmt_rate(struct ath12k *ar,
>>         }
>>
>>         sband = hw->wiphy->bands[def->chan->band];
>> -       basic_rate_idx = ffs(bss_conf->basic_rates) - 1;
>> +       basic_rate_idx = ffs(bss_conf->basic_rates);
>> +       if (basic_rate_idx)
>> +               basic_rate_idx -= 1;
> 
> Using __ffs() might be more readable, like
> 
>     u8 basic_rate_idx = 0;
> 
>     ...
> 
>     if (bss_conf->basic_rates)
>          basic_rate_idx = __ffs(bss_conf->basic_rates);
> 
> 
> 
Thanks for the suggestion. I'll change this in my next version.



