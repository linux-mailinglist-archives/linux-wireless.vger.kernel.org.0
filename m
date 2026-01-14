Return-Path: <linux-wireless+bounces-30833-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC291D217AE
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 23:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65EAD3025596
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 21:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFB03AA1BB;
	Wed, 14 Jan 2026 21:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BV9uvlqZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="htaQMKA8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86E93A9015
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 21:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768427968; cv=none; b=o739JjtPhaGSvSuhFoF2b7wvD0ujcM+51VLvC0LgFP2rJgA37dFmRHcTuvR+qiquhY0XE87/Rv4XUseTukbFPOwJnoCSgWPWJcYW3oPBm8sN4/LfyM/les0Sx58ONVRL6JFFN7lZbzwEbrsF/zqaufmKhB5q4cesRear9TOJqIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768427968; c=relaxed/simple;
	bh=frBlYVR2Ft6P+ZhttGDwMdzZh206l/teIaCIbXQvM9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pug6AZ28ToGg8F/Y09WUVSKf3wfr1Fductuc2YRKGpscuk727LxqLA/7ly6dz6fkIte8yoEbgylsbzjzhaVzGEv+tkX2fYZ3JbawIYfYqmoV654YhnK4P30EX/I/cMX2Kmk/PnklLUHo9LytZp30tqZ4v/FNljHUSqxkGQWtTAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BV9uvlqZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=htaQMKA8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60EIETaR3461579
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 21:59:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OpvEH4+21FwdP09LJL6iR3hKr4clZnGQYSImAni7YoQ=; b=BV9uvlqZgkHRVeEL
	1LBpMOnJMGEzujNzwizNp/D3litzDgCUwdmD0WSGlrKcuSjaOvVjVJhTizReRffh
	YY4qXBUYWBq4WhHBqxSgm0BLvYP39+qvcVYMIhHxpm56+CD9FqPwSVZkh0PzJyWv
	wmaAaZuFoWlQcYTVUnH8iqgT4EOtkYExvhHGRpKUBQ0mcJAb7webWIff7RfWzGxp
	6qLZow7mux2KgXyBjhIDtvGIStp5LM1jKIzrCQmFD8YENnD4ZUohKmDU/DTd4y41
	WG/4zXcpxWowZQ3vAeG5trLNaokToDG099Yun5yF93H5AzfLUf+pvlTVkXgEChQS
	eMzVrQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bpg848k4e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 21:59:12 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2ae32686ed0so2230746eec.0
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 13:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768427952; x=1769032752; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OpvEH4+21FwdP09LJL6iR3hKr4clZnGQYSImAni7YoQ=;
        b=htaQMKA86YpcwJ0n/jSPAgWoFHfSUZuCpLwKX5qoKEwRetdQTXV81yAoD37VVw3vzW
         jN2fULfPhYLPyWTm4HWVpy3yKwehbiUIWdGtkEIzoaQLL399TYfxumc+tI7WKZHXyrlb
         8fYeO01icmEdW7FHHX4m5nNM3O+u6QRMiXVEwezz5dLZCclohwnlduPAYol1ulMCPtRy
         WHG8rjHvrJ9JFYp9WXZcRLD3DvW27diPy2L432OcQHOobecpxLU6wwROqI/wLiqZZLQC
         y2Is94r217LX4q0u4N+QQuhLUVyhdIAQojm5U7oFkcYuEZx9iRnqOlgE80bKybNlIDCW
         7zFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768427952; x=1769032752;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OpvEH4+21FwdP09LJL6iR3hKr4clZnGQYSImAni7YoQ=;
        b=nOGALGEa7Yh8MAEicIUbaci44oJ2l/aO2WfG6tIOZp/wNJGRP1V27JujSMVD8PK260
         kfG5yyHPtyzHynYYgHNPAUtcUrHMjHoTB0yebNgNedh0Myxxz9PgTt5y+r9LAExwkPdK
         dsRQgihae9C0opK3b07GOU2/ow8oBAVGTm/cJOrMdI+stJNc5fBYF92aJanS9QsxQczs
         xd2vc0fN/o2+gDXKeqVwFW4RHOaY/IXGl6wlWcuBMR5pLwt9FLpXrsa0raGK7QMA3Br8
         TaPCKTws/gBDs+EVUylZJ4CuM7kYSQPEy2hyyKO/eQN7JvABWtTSuWiJC1xLJnIg/iOI
         dn3A==
X-Forwarded-Encrypted: i=1; AJvYcCUOZlhZs2AGo3iB6eNpRASiarxGfZJ9bKVLwgARQKVen4PqLIGKKbdm6igb2eIoqIIzdITlH9tWXtUEJHcMqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwipnJuelmA64/7htVjjiiRjKZqFBY0Aib5AZBz/0RlUS+fWD41
	RspLY6IjJ8LLmZ1XlJO+XTahG/lVOCb9EdtPczz4es81uBD5S7qxHb0D0C6cvW+5p0nB2p5vuA4
	0LHEokrTayO9AFE3mm/JAHMATn6w6e9V5gK73dDhXDj1eiuqv8U2rIlWEBgvQtz+1jXbzmp1RoE
	qdqQ==
X-Gm-Gg: AY/fxX7qCSlX18aHUpGgTCtwzW2YRUPTuLaEwP5TXhr26mWRf9piM/A9aIXdBFqMCMZ
	2CMrgb3vc6fY1iUcX6uPhGv4qzW1syv20UnY0+svNKNW3Zt2KyGAVxIb+e7teRA+lIuiL/kYXQ9
	8C0fpVEYj0yax799qNjZgxNvpy7PO+tkO8Up3+PdMjofTyUzuUkirof5pINcwtEt1uhVtozBoBR
	40JBnHLAOUJcO75mfuATUhM0HhIVzZNc5F4GbE5tEDmHPsf2tqgAbb6nBslUHzDoyTNrv4PjOBS
	0/QyYcTeRgKl0lTfaTE1iXoraOqXFPmGeF0vzdbiSxW7ATbvhQES+2AV7zjRonIXxv9iVUN000C
	xX1nOQIzwVr0zQ3HMDucWIr1NpIbY/wOho1CCwddXN7sbKEvQYkWEa/lG+JInqMlWpg2PUteNbR
	3Q
X-Received: by 2002:a05:693c:2c13:b0:2b0:59da:f798 with SMTP id 5a478bee46e88-2b487068cccmr5445101eec.21.1768427951808;
        Wed, 14 Jan 2026 13:59:11 -0800 (PST)
X-Received: by 2002:a05:693c:2c13:b0:2b0:59da:f798 with SMTP id 5a478bee46e88-2b487068cccmr5445073eec.21.1768427951297;
        Wed, 14 Jan 2026 13:59:11 -0800 (PST)
Received: from [192.168.1.3] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b17078dd78sm20133476eec.19.2026.01.14.13.59.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jan 2026 13:59:10 -0800 (PST)
Message-ID: <89a61ef1-3e83-4303-ba04-cf5c5a4aae56@oss.qualcomm.com>
Date: Wed, 14 Jan 2026 13:59:09 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] wifi: ath11k: move .max_tx_ring to struct
 ath11k_hw_hal_params
To: "Alex G." <mr.nuke.me@gmail.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
        jjohnson@kernel.org, ath11k@lists.infradead.org
Cc: baochen.qiang@oss.qualcomm.com, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251228151408.2116108-1-mr.nuke.me@gmail.com>
 <56c6471b-c878-4afd-8e8e-d56266ca9c64@oss.qualcomm.com>
 <c8456b52-f14c-4bcf-9385-580e9607219d@oss.qualcomm.com>
 <5896283.e9J7NaK4W3@nukework.gtech>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <5896283.e9J7NaK4W3@nukework.gtech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDE4MCBTYWx0ZWRfX0RZ68NcI01NP
 VaiyISQg5JC2hol5aYOMnf7ilw4XCgbmnpSarV5ee/3j/d7TbGt3Pn9LDgeirEpvVU+5sZyWCfp
 J6lKvhoWDU8iz9PYyW1R7wD6pvTGnxgpsi0OiMDpTyD9Y5NKyocvUJBnY46Se/umIgp350jo4Lr
 a5/ueJcztOv+2Nal+IzsCBJBXc1SR+4XTtNJo/n1RCVMhZ8hddPJCFSxRzlk37BZwH1QiIepcsm
 Fn7ANJDzZR0jI0Zpr7ITH2HJHublkrSYVaOmwGs2daEO3DE1tUtNkBLCALAMI3P4yfpbL0F+bZb
 FV2C0C5ElctHXtquxoWNDaJ2faPUMNhhDmCoYvxy/CQSD5A3AFtK2HSCeonAjLbrAZj5GqoO95O
 8r7J/Pt998t21xSIYGwDktNJycWC7HGdVdCgNlZnDCEjpO2VzsaxGMpxJ3WCiZZCeOKlUhi8BvB
 KnVHzMnOGtQdtYWc3pg==
X-Authority-Analysis: v=2.4 cv=IO8PywvG c=1 sm=1 tr=0 ts=696811b0 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=azILXIGDsH6i2WhDGicA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: Yx_-WkSNAPbIlyy93Bktfn0Ne-DBBeow
X-Proofpoint-ORIG-GUID: Yx_-WkSNAPbIlyy93Bktfn0Ne-DBBeow
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_06,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601140180

On 1/14/2026 1:29 PM, Alex G. wrote:
> On Wednesday, January 14, 2026 11:24:19 AM CST Jeff Johnson wrote:
>> On 1/12/2026 11:00 PM, Vasanthakumar Thiagarajan wrote:
>>> On 12/28/2025 8:44 PM, Alexandru Gagniuc wrote:
>>>> ".max_tx_ring" is an upper bounds to indexing ".tcl2wbm_rbm_map". It
>>>> is initialized in, core.c, a different file than the array. This
>>>> spaghetti-like relation is fragile and not obvious. Accidentally
>>>> setting ".max_tx_ring" too high leads to a hard to track out-of-
>>>> bounds access and memory corruption.
>>>>
>>>> There is a small ambiguity on the meaning of "max_tx_ring":
>>>>   - The highest ring, max=3 implies there are 4 rings (0, 1, 2, 3)
>>>>   - The highest number to use for array indexing (there are 3 rings)
>>>>
>>>> Clarify this dependency by moving ".max_tx_ring" adjacent to the array
>>>> ".tcl2wbm_rbm_map", and name it "num_tx_rings". Use ARRAY_SIZE()
>>>> instead of #defines to initialize the length field.
>>>>
>>>> The ath11k_hw_hal_params_qca6390 uses fewer num_tx_rings than its map,
>>>> so use a constant to express the correct value. Add a static_assert()
>>>> to fail compilation if the constant is accidentally set too high.
>>>
>>> Text related to static_assert to be removed accordingly.
>>
> Hi Jeff,
> 
>> I removed the last sentence in 'pending', please check:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pendin
>> g&id=26bb149b5e011b0f73f7b74421589cbd38e3304b
> 
> Re-reading the commit message, I think it makes sense to also remove the 
> sentence "The ath11k_hw_hal_params_qca6390 uses fewer num_tx_rings than its 
> map, so use a constant to express the correct value.". Do you think it's worth 
> submitting a v4 with this minor change?
> 
> Alex

No need to submit a v4. I can make that change in 'pending'

/jeff

