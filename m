Return-Path: <linux-wireless+bounces-29643-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD31CB48FB
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 03:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08DDD301A1F5
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 02:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04864236437;
	Thu, 11 Dec 2025 02:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pAIk9k4S";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZmMct7LB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7161DE2BF
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 02:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765420505; cv=none; b=CHJWdSdULX4Gj9284ytsIYFSv8pMcPmdARe+VgPF3+3gcCgceQ0CKzF3hwQxMiVmRzr1bco6Gdb7Xs7TqE15R4KLt6jjrOHqfS50oFoF20do2qub9F19eCt4GQspA5hSJCW7L9Sguu7tqRxD8r/lF94/JEFAGqo5Veg/ojlUZDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765420505; c=relaxed/simple;
	bh=N10jEd1w+2H6peyvXonG+E4IwZwbS5z21KDu6/H9k9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hfpK2feYPvJjbpEQVUQdzGdyDLgfeb1pw6wpbsQPfzkg6EBsMFwH6r6n7DanW9DB2jheM8yXvD+x6Zj0la4Ca+qah2p7l65mxj6aqDtBcblbJdLmP2La1u649HF1pgpvrR6sgemkxn/hV8ycjy/6VQVjvMCm95bm1vLtW0+k+aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pAIk9k4S; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZmMct7LB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BALVMIC4061878
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 02:35:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n673qLBkgOUY1GHNMNe14VRslEKsiUEor3PWKBqvmbc=; b=pAIk9k4SbuaX1xTf
	QSNyAUhV7jOF3xTHmsPHpwr5d52MHgCfHal4UhkAaC8aPthsXJvzZ3Kfh8L25hD6
	pRnRG3YLRcRdUMdOJxWaGwpVXP9+uhP7yeRGhXdQP2vloE07BUhkjxBNFQuLo4cs
	fewQlAvkVJdZN12qFHwuCRg94anmOwN8bAORcLYjkaUFOR0AJo6aTS3Sn9xH4OX+
	UH+AINfHrCjQUPAtt3E3ABbCissg6r9qeCeYNvTEbhbfds5A9w4O87TMMSsdON+9
	cYY5JOfh0xwiNBt2wkNYqkPQn9Z6gtAos72fhjCig1zi9+2QQX+lPMBTTB2u+kLL
	QaGEVg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ayguqgmxa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 02:35:03 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7bf5cdef41dso819885b3a.0
        for <linux-wireless@vger.kernel.org>; Wed, 10 Dec 2025 18:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765420502; x=1766025302; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n673qLBkgOUY1GHNMNe14VRslEKsiUEor3PWKBqvmbc=;
        b=ZmMct7LBraoafuWD9eLx3RnNlfij6kGTX81kG5gFyIIqJe308U/U4yHBFGUhX2I8dP
         SjrmVCkPlS3EMcFMN86sGtenz6ZIFFcbqxrYQkO4/QMf43RaMG8BwVk08T7KWqMZB/TW
         ucDSkMSt7XqMsQ5kXlwIj3/l7UJSG/UHF4m4yDMIB3oktRbVc0Un4Z3ZaeCaLllrABs/
         wf8HiGuzd1sN5osYMNwJef+iFgQHtjYFbEbCTiqCE3HouCcNggjBRPvNIz8BKM56Gd/G
         grMbGz09KjIdQn6snbko4bpIWqNdb4jI2WUVU3tQ2iRgoqWaUVOGGq5qb1ox7HAXk3iA
         LJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765420502; x=1766025302;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n673qLBkgOUY1GHNMNe14VRslEKsiUEor3PWKBqvmbc=;
        b=tEru/4M0vAxM+q42haM5olSYnaO29PQQe/DR3aYn4qYDA7sDzkqDsGx1hzkFqkHcGI
         JQrX3GF8g41CPaYaRO0xjPnz/qywncAtk/TNZsbRr12HnR80i3YOYP3ihSmA/4s6sobQ
         3S2tMFk+Nh0AI5UmGpru/4bomnL5rJ6i41AMP5JVdm14QRPKDoZTTPlRFtUG7wthNK+9
         WXvE4X2LCyAWSAkkPxghJwrq+xy8qaUwAAy+Q8ck9QRUW1WoeD3yZplvfjR+Uj5Iv+FW
         rjBDWCBqUm8jlIJrrvVqfKok4a8fztHCEb+egaio+kgIy4lOTeAqkxkiKZFfl5/Td6f8
         PO+A==
X-Gm-Message-State: AOJu0YysSiIIQKX8d6qZGZhuvSliqFmlNjvb4IYN0Kvo2ks9JWSP2Rqh
	U4XOAvpMbwdbTteweJgmLHX/m7X2pqUPmqEpoxOGeFYJyUJbvH6YZe8AAZ0g/aeGrUX/9+016i4
	ipZrhB8h88sP+mQ79YmTAHjYLiYl+yjETUerFla9ramRB/LKatecmC+wU2dtRN8kjPaCz2Q==
X-Gm-Gg: ASbGncvt4o6UVVxs2xBbTAATvk78hS4kkUrcc435SeSxVW8oXdAwLa2bllU3riwEr2A
	2tay9Au8Pfu7OqcnNHNr86OmY6G4lQTr97T5wqtaATx04EXt6sUzWTthkE3rPZCeXcLDXnQL3wF
	hl1sijEy46blUvoq0AIIarxsKlG3Lkbl/JJ4s/MLE2wyS7ONKUCFhdZMfm5I7QSBxbejDqYLUID
	yZHf0Qyj85ME68LAQDpwneHMWXNrqVWjTJVIPqOwGsj+vYCb91qRCLEGUJaJ6RxAviADWBmlCoQ
	EW7L5inEMGcqE5jClVxtvNx4XivjuzlVeu4ejK8uyHaQZxMw0e45GBpkNzHuJuZ2x6NBN2aE8F8
	8T1ORVfN7T42LHD9UWFUwe15MELFeHKerPMaqPBY9
X-Received: by 2002:a05:6300:210c:b0:361:63eb:d478 with SMTP id adf61e73a8af0-366e03bb718mr4153509637.20.1765420502283;
        Wed, 10 Dec 2025 18:35:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2z8roFhRBPLuU2YWWkgf8t/WjBVw8Y7MY45hRenK6F6I5TPyVzNHD4sB1SeRqaWsWius3hg==
X-Received: by 2002:a05:6300:210c:b0:361:63eb:d478 with SMTP id adf61e73a8af0-366e03bb718mr4153488637.20.1765420501799;
        Wed, 10 Dec 2025 18:35:01 -0800 (PST)
Received: from [10.231.195.103] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c2c1925bfsm675226a12.31.2025.12.10.18.34.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Dec 2025 18:35:01 -0800 (PST)
Message-ID: <1722daf9-064f-4d1e-a7b0-206f3acffd96@oss.qualcomm.com>
Date: Thu, 11 Dec 2025 10:34:57 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: move .max_tx_ring to struct
 ath11k_hw_hal_params
To: mr.nuke.me@gmail.com, ath11k@lists.infradead.org,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251210024036.3965135-1-mr.nuke.me@gmail.com>
 <5a5b4961-904c-45e6-aca6-b58a122e2134@oss.qualcomm.com>
 <16e02bce-18c3-42e4-a51d-60c4bdf8a763@gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <16e02bce-18c3-42e4-a51d-60c4bdf8a763@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDAxMyBTYWx0ZWRfX0vZVectKYVfn
 9WH6zYRPNI3BEs/2deIi7GJbpvCgBmne0opwKlvtC4Vp20cl/Zza6QOTdngCwDSCur53A8p5BrS
 ytGe8dV6ya3byG90gOhb3n/SitbzhfgnNqIKuN2AiA9LhaMfVrCjYnQldOkmY0SsLYm+/Hr4IpS
 4yZFeulBNyCetXVtHPhvJU3Ipkv8Gmm49cgr/5vNjgHVjaodQ5MVgy/NAGNgO/+Cm7YXV+u04eM
 7upV9N0lWolxI/iFsNNJ/8r29l91oMkOBmDLJ4AbGRURFpKLoDLH1fzzySIvSM1SQMqb+pQgx+G
 GhcEZebWtC97KW3sisx/E83VV/Zr5bzeu98vGfLZHri7m1tqFxfLyPtiRvXv3PJCz4Cu5+6sa10
 zJA+chqW/678/VsBWi9K5IbSgSHZXQ==
X-Authority-Analysis: v=2.4 cv=deGNHHXe c=1 sm=1 tr=0 ts=693a2dd7 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=_WrCZ2CG3_jBuci-I8YA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: RO6HIzLF1mQM4yqJBnj_A_o46Fil8nwG
X-Proofpoint-ORIG-GUID: RO6HIzLF1mQM4yqJBnj_A_o46Fil8nwG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-10_03,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512110013



On 12/11/2025 12:28 AM, mr.nuke.me@gmail.com wrote:
> On 12/10/25 12:46 AM, Baochen Qiang wrote:
>>
>>
>> On 12/10/2025 10:40 AM, Alexandru Gagniuc wrote:
>>> ".max_tx_ring" is an upper bounds to indexing ".tcl2wbm_rbm_map". It
>>> is initialized in, core.c, a different file than the array init. This
>>> spaghetti-like relation is fragile and not obvious. Accidentally
>>> setting ".max_tx_ring" too high leads to a hard to track out-of-
>>> bounds access and memory corruption.
>>>
>>> Clarify this dependency by moving ".max_tx_ring" adjacent to the array
>>> ".tcl2wbm_rbm_map". Use ARRAY_SIZE() instead of #defines to initialize
>>> the length field. Remove DP_TCL_NUM_RING_MAX_QCA6390, as it is no
>>> longer required.
>>>
>>> The intent is to make the code easier to understand rather than fix
>>> an existing bug.
>>>
>>
>> Even the code chane works, I am not sure whether we should do this. Because, logically
>> max_tx_ring represents hardware capability which is static. However the change actually
>> implies max_tx_ring varies on tcl2wbm_rbm_map definition.
> 
> I see what you mean, although tcl2wbm_rbm_map is const. More details below.
> 
> 
>> If we are going to add something to avoid the potential out-of-bound access or to improve
>> code readability, how about something like
>>
>>     ASSERT(hw_params.max_tx_ring <= ARRAR_SIZE(tcl2wbm_rbm_map))
> A static assert might be a good solution. I don't know how to do that.
> By the time we have hw_params.max_tx_ring and tcl2wbm_rbm_map, the
> latter is a pointer, so we can't use ARRAY_SIZE(). We could try to do

Yeah, that is a problem ...

> it dynamically, but I feel that's spaghetti code:
> 
>     if (tcl2wbm_rbm_map == &ath11k_hw_hal_params_ipq8074)
>         ASSERT(hw_params.max_tx_ring <= ARRAY_SIZE(ath11k_hw_hal_params_ipq8074));
>     else if (...)
>         ...
> 

Hmm, this is ugly. I would rather have

	map_size = ARRAR_SIZE()

in each hal_params, and then

	ASSERT(hw_params.max_tx_ring <= hw_params.hal_params->map_size)

> Alternatively, I can take the suggestion from your other email, and
> keep the "max_tx_ring", or "num_tx_rings" name. Because it is part of
> the hw_params struct (via .hal_params), it still describes the
> hardware. While the value is derived from a constant array, instead
> of being hardcoded, it remains an immutable quantity, consistent with
> a static hardware descriptor, would you agree?

Also works for me. You can make the decision.

> 
> Alex
> 


