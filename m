Return-Path: <linux-wireless+bounces-32038-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOmDBaeCl2n4zQIAu9opvQ
	(envelope-from <linux-wireless+bounces-32038-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 22:37:43 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FA4162DF9
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 22:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8BC45300530A
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 21:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19DC306480;
	Thu, 19 Feb 2026 21:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EY4ya4ww";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e7kw7Ex4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D565B2C1589
	for <linux-wireless@vger.kernel.org>; Thu, 19 Feb 2026 21:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771537057; cv=none; b=Q1MQ8YrlawTJw/h3S91V27F3g5/zId0cu7SgZK5/AEDYl6siuiqog8RB8sEWRXinolYB168JM/mm3gH1AgE9zdi/ITA/Lzk6ozbHB16hqpTrML4T2mxvyA+rZopO8uFWnPiGEH+A5wPRMr83SDwIF0jfghkGDxsfJOcGve0PKyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771537057; c=relaxed/simple;
	bh=PDR0Qja/ONeWRLaspYAQG2OWGhECWcoy/XADxMtXGNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sCkD1fiBufBsg3if+kPXFz3aCyQWlxtWs7I7NCF/BkGKolspIqDcMWQxIsat3VMTiFUGJXnsvPD30P+3hC28pyDXFbbdeoA161jyYrBi1RL4NRvIWqOVto672eJMUHOEi/OgJwTVpS3U8l4etRrPvtw6ryO6AeEjSQkEYpxileA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EY4ya4ww; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e7kw7Ex4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61JIYhFw2509265
	for <linux-wireless@vger.kernel.org>; Thu, 19 Feb 2026 21:37:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iKx/fk4L9hr4iTsFMK6M/vbjuUixutrPmAviSLksXy0=; b=EY4ya4wwCUcP6HvQ
	Mfz+ylrwQUa94jTdtJ/uh7VniG+B3/7hLy6im95VkrhAh2h5ZFb+OcSBiNLUHylB
	DDc5MFiWKUpJ9YRh/pmup8jIuQMcfFYelLgsC1MQbnQQCS++/acWdzNDsicDEruV
	PZOiKvm9w57hd0uxDoYG34Ns6IKnjy/XD5INmfi22N12j0XBqF0Ky+7OJINvJwGV
	mS33zWW/8aWtbycs+VfqSPDKNZPkbIuJxglcnFHN1qRaTmzJZ9Ulw3FR84qknJKz
	MWg3aSZG0dYW0bTwgUD59LM6g08WZ8YZouZT6fRmXpcRNo+o4bRV0CSqjPnZxM/1
	+dmXtw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ce2ghsqqj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 19 Feb 2026 21:37:36 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-127337c8e52so50520767c88.1
        for <linux-wireless@vger.kernel.org>; Thu, 19 Feb 2026 13:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771537055; x=1772141855; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iKx/fk4L9hr4iTsFMK6M/vbjuUixutrPmAviSLksXy0=;
        b=e7kw7Ex44nnY8F1fIGV4YXQDNRO8EjkXXf6Zrj7jQnbtsrT6PAX8+aCc7jJotqc1RT
         zGjkyBk37MTLJCAfjsqpECd8xb0ElIv7oEuyDL2cOXCEsihiUtH5Utreg/2T1yMSJn5E
         +mJb+Q8Zh1ochUP1FfpbnkbVee4WqkGn5WhLelNLuqEeF/G6XrdwfOERxDGvgxEyNDzW
         S0neFSeKb7CTNdLXeUT19xMdk9Z3WZTHw6K0tIQFh58mR7kFqqEYxJJDLGcxjQDVN6xB
         ZxcN/fG58dutC/5KFRddvl6xL2Wv3CRyYt4jvTZeLCNzfA45/v/eQJAzsz/Ls0DxXvAs
         BwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771537055; x=1772141855;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iKx/fk4L9hr4iTsFMK6M/vbjuUixutrPmAviSLksXy0=;
        b=EVpNDgY0K84q0V5Vl6CxdHzcnvS9XN7S/Z/3yn/OB0OhSHwIqrZSnknrQ4fci1fq2K
         24qCU7HZ5T0cAv7nxWxeUl2Om7PDE4I9130GWny0CyzNgCLwkxsaqbxEGK03Y3XzsH0I
         Now2icSocHPqzby/pbHT2As2UIOGXqkkRE5oJmikxPxM2l49t1fp91Q5S7hmUlEgX5IA
         UEROT0+S0E5Ra3NY96cLIW9ZuJKjHYjQgFmSIwcoi4ubs6N8hvPT23Ftevbqm6Y4uKqg
         Lgjea6VJsoqy7dx1l3ZQnSeeg2f7RfWOZ7sOhaEXlA+9MbqNSS7Q5jEXn/DJ+vZAo/Zo
         Y4gg==
X-Gm-Message-State: AOJu0YzoCSU23ddNYyLWxj1QS5/e7IxyyKDuij+L6vEjOwGTFxyMfgkj
	ydZ19ZsPGili9o/5G/91vDhChpDqQaVwQGXhJPWR05wDgZrbXD5/YF3XwuvMuaxRhqyOknPMEzr
	XsWu90acG20iy1GRJ3meZhbxDxhn6f1p2qoDWwOYuM0uPs3rZDet5LPE1OdOQuSbMS7ME9Q==
X-Gm-Gg: AZuq6aKTjMAnXRjP6AxyzrCTu91FItUvLYFQuUv8AB8Mx0SBVdbDCFLywBiu5dC9Rtd
	qpEEUyaLwIlBkiQvpAQiKoxcQo2ZxisDoILMIAft/iZYNWt8+s3UzMipJQGUkVe59xuNtlmFHNB
	ZIrGrS/xA3UA9F991jdAZbLSMVnLzhYzGfuyvcLPKIzHuv9dkSIimuGg0dHXTir8ScxnWVrETh8
	gGV2aNfR4Y9ir4AZw7BcXTYgpQHUe0FUPhHAr8mfL6alWzDc5/drHIWyEt5dk1Z6NkP8iRrSokW
	PCFIgRcIB2HEZAIY5xyzeRNuLe4BVQIuZ6CRLwnYY5zUiIfjBFuz7yb+L+86fBKRIRzfNQWyErR
	bA7aY5ollKBqsP0Kwh57Q3OWZ9yugoCq9qyRTrdU8fYp6gk2KxSnU1F2XozbB1EBFDiK50tUjGJ
	FHkImccKe1nb5RLg==
X-Received: by 2002:a05:7022:78f:b0:11b:f056:a1b3 with SMTP id a92af1059eb24-1273adc697bmr10349110c88.11.1771537055392;
        Thu, 19 Feb 2026 13:37:35 -0800 (PST)
X-Received: by 2002:a05:7022:78f:b0:11b:f056:a1b3 with SMTP id a92af1059eb24-1273adc697bmr10349091c88.11.1771537054787;
        Thu, 19 Feb 2026 13:37:34 -0800 (PST)
Received: from [192.168.1.41] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742c64282sm30220375c88.5.2026.02.19.13.37.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 13:37:34 -0800 (PST)
Message-ID: <017ec99b-693f-47e5-ac38-6c207a32eb62@oss.qualcomm.com>
Date: Thu, 19 Feb 2026 13:37:33 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2] wifi: ath12k: add basic hwmon temperature
 reporting
To: Nicolas Escande <nico.escande@gmail.com>,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Aishwarya R <aishwarya.r@oss.qualcomm.com>
References: <20260219073440.19618-1-maharaja.kennadyrajan@oss.qualcomm.com>
 <DGITONL8L200.PJE38TDXYRQC@gmail.com>
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
In-Reply-To: <DGITONL8L200.PJE38TDXYRQC@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: zohKDillA1FAl4R7tLIuDQun8HpQkK7L
X-Authority-Analysis: v=2.4 cv=dqzWylg4 c=1 sm=1 tr=0 ts=699782a0 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=4Jm5UyAM-6VcxyqVLLgA:9 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDE5NiBTYWx0ZWRfX9pao6aHqR5Te
 QoiBYB38B7INFuRZBwrTCKsF3x1jCauIvPdFNhY4Nu7AGcsI6ko5mGYwg+6+nTzzUooti5Tc8VO
 kT7UKjRtr2tD1OG6yOT9tqrtYnIajvZzy5f7uT61w4djoRwPKqXh1Zf+sdmiVy89X5DbCM7yyIL
 A6+J33kqxbsgGs9WHRI2ymC/C8RvV5k/3b77dj/jMH/T0BfGZg3LxYCNgaf6KOSRBruny38nYoK
 iPVglT/ARPByBZgzC72KRI/UkD7s4SPa8APsW52fPakWdsW3eSnqFoMAY+JMx91PfXyupTxb1R2
 U93JvKFPKcJrpNEoS9X5Jdfo5rfnsme8UrtsDeyxVzrhypKT1z5u4yk9MzHrErSKfH7QhtJE/t2
 HGY/FdvWyiLu9mQLDyZL5itcHSiDZzXc1PH4bv6rjpo4ZZxATero231XA5aOc9k50ZLuNuWieYK
 ksbrXc7PaNte4JAodYQ==
X-Proofpoint-GUID: zohKDillA1FAl4R7tLIuDQun8HpQkK7L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_05,2026-02-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602190196
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32038-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[gmail.com,oss.qualcomm.com,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 30FA4162DF9
X-Rspamd-Action: no action

On 2/19/2026 1:15 AM, Nicolas Escande wrote:
> On Thu Feb 19, 2026 at 8:34 AM CET, Maharaja Kennadyrajan wrote:
>> +ath12k-$(CONFIG_THERMAL) += thermal.o
>>
> 
> I may be wrong but I do not see Kconfig changes that allows to actually build
> the new files. Is this intended ?

There is no configuration specifically for the driver -- it just follows
whatever has been configured globally. So CONFIG_THERMAL would need to be
enabled to have the file compiled, and CONFIG_HWMON would need to be enabled
to have the sysfs file exposed. ath10k and ath11k have the same logic.

/jeff



