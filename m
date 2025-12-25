Return-Path: <linux-wireless+bounces-30107-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB1BCDDA1B
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Dec 2025 11:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFB4F3013E95
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Dec 2025 10:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3955423D7EC;
	Thu, 25 Dec 2025 10:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eHokdcIF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IhLDGdIL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9320B8460
	for <linux-wireless@vger.kernel.org>; Thu, 25 Dec 2025 10:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766657147; cv=none; b=V069Gb6FsZQB+/vdPEgwAmoRoPHeGqzCoeKEzVL4KPWhBn8dRycJSgJwihdIAdJHuQGYTyW36c8Di0avzJFT3vc+/8I9kg3RdfKv/QujIsir90ixM+yi4IE5G5BcQVHGU5mkewu2iuvhrUFZm157MP8LLHX9dCvLfLy33qmhmTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766657147; c=relaxed/simple;
	bh=pWv+I4TWZVeHJAEzrNmur8jCZ9wfV0HlczZFC4K/rXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L3eVjNsZuE2xKeNs1cxIfR9lA9YziTdjiAokXcxdfsm5LjC5Ehjk74WWfK0E80ciKZ12HcaaMXMJHJaEBuV8m0LeOZOrwTwce5Y6cQ6wO67XTyp4PdEI3+beEMoQ5sl8Ai+I9wjcemuqQLC8eyHOYERroIUe54x5YCdjBUIFPNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eHokdcIF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IhLDGdIL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BP8bQTN2059034
	for <linux-wireless@vger.kernel.org>; Thu, 25 Dec 2025 10:05:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fpQR5MhthxNYS5X1B4rXC7O41ZaJ8gH+dbtsDtAc7Lg=; b=eHokdcIF4YJP56la
	BGteIpjyXQKlQ4e57sPQq4hY1McvZPSnAynfqqmT70dudKiQtaqPV4/8xRmnh77n
	XDmZX3Hfh/i45/KPE+nJwIcLcvd639eRQnRYuQY2zyuhhOSSnOzabChDvKJ7KA43
	f9TiqL/fi9nnFN98uZEnpEmILEkILc6X+k5VfcKO2OQ3aMD6hS0JPnYvsmIUHvXz
	0s1+mQLipd9bqVhSxwmeY5Xik8LMFHsqZgWBZoD5NoOIhBS5kZGFHLmUrnTcisj9
	wjxxEVyJjzrs43sYqqacBlRgaLWIjjFdHiVsFasLAoBHHX6owU+Dux0M8yzPpEmx
	t/idiQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b8kbusgaj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 25 Dec 2025 10:05:44 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b6ce1b57b9cso6527698a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 25 Dec 2025 02:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766657144; x=1767261944; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fpQR5MhthxNYS5X1B4rXC7O41ZaJ8gH+dbtsDtAc7Lg=;
        b=IhLDGdIL5zG/FS7q8FLiKEa6UzluPQjlSF/KFjdVKO6Mn+yjbJs6piDen+GG7TGBU5
         e7ZgJ5aAknVAEWsFIiVX6G8FJqbQBD9WxnrwoQllUriMNal8hQPUUcDrEgYbkCVTxxmW
         9sKOGlAH5x53Csvwn6uCUXRVJl8GBslGS8XH+oH/f9ZuhO0Fp8cCB0Z/PIug570LZxqG
         PjYsSKrI9N66SIgiaiZfUzYJ6vvroJHBokqL4rDKRcIXWtKM9TfhuB9EtqxWl5FHvLVB
         nBMG+f6vq6Zal8OlDTkCyT8ODvpgStxC+cnwCQByr2tRbxrh/dfR9QP6fIPllP3skK9V
         ylIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766657144; x=1767261944;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fpQR5MhthxNYS5X1B4rXC7O41ZaJ8gH+dbtsDtAc7Lg=;
        b=pUUHVqQgiyt7NLRRzYMaN+cGPgt28xADftLV+zdXh0XtpxgE5//0wxDTF+WTHk9EkP
         y7pqijrCP0o2ustI+j9Uji0P8UKddFXcCJeghN7vAE8LAcFk1vTuMaf1Oz3KMdtnrKBA
         3LHgX1ezWwjN04xUH73y7ju4wBrRsegpT8vunobFCT5VZwAA7WKfZkmmYeofojv342sf
         c4+4wIUU71zO02PTM71n5rAqPf50L5LjltMlzQG9Bs0DhxpSz8NasAGWSUIMHeXh7XgN
         2UNJLCwUldTEK6Sc58VWqzJlbWOfgiU7dOfCiDugBoYcAqLvYWS7DcbAEeVQojnisAsP
         jktA==
X-Forwarded-Encrypted: i=1; AJvYcCWJ63ueQdckOuyhMRKRDWlPmqnk5AUaZoJ6eQn3FYLk0BFSWtb8zGe9aU1KsqeUYtMnoGd51cAvL0RtKFQ48g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOS3pYgVTImeo3VZVke72slA6dmoxqiSnOeghEsWMP27YWryGi
	bTDLsc12DOb4fETzfwEVYC6mqRtXqrXuMUs80eeHLUVSC95oQ+4s8ta2rlUWHGrF+kWd9hiLoap
	C4YecOJ+67kkcK+KDMZSyHQnF7eq/ZaxKb0jO8Z0F+N/AX32UcLZSS+5aN2KjRsn4sKc8RA==
X-Gm-Gg: AY/fxX5jMlWKhHU+2K1C34h7Ti2SNvSlFsaS8V8R0dxzgyo3/5NLhzvdHYjhnj3FxLf
	bEGo1kpDiR6c1vMOOogU0BPBUD1u3qfKf7dfY1JkwKepUi3delP1Kg5gGEmDiOkb8QRSCVhmNY9
	RXoBTToUY8SQRtcxDaNwPQNb1iw+f9zU/15T+Ch5djpWXn+pkkIsa9yvEUK74Ksp3pdQkUdWaW+
	7Rc3D6fyrkK/VhEK6KKKTEQOhZNgX+6zw7YmjIiN76sDDgWFbz1Z4/BZVzqC9xZRghWmedjka3N
	NUI68zJW2yKR6ebxxfgI+I8nVAqnWhueOfSEE9ZpmptBJHQ9IQPSYh4BTCFoPuqAQzz33DezH5M
	/f49ZNBIlnEMUcmscrqB+Bke5OS/gKwTJf+CChCw9qfmDh2/Ak1Ov4pVUblkf3hJTWNQLmjZUaK
	I3B01jHA==
X-Received: by 2002:a05:6a00:1f06:b0:7ae:d1d:d500 with SMTP id d2e1a72fcca58-7ff641193d9mr18300391b3a.4.1766657143926;
        Thu, 25 Dec 2025 02:05:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHAFIEoFagy2scNUKwIjJ20L5wmLpWPL/hZajeM9dLT/f6lWLYsRJMfgEduMnI8hA2d3pDWw==
X-Received: by 2002:a05:6a00:1f06:b0:7ae:d1d:d500 with SMTP id d2e1a72fcca58-7ff641193d9mr18300372b3a.4.1766657143406;
        Thu, 25 Dec 2025 02:05:43 -0800 (PST)
Received: from [10.133.33.27] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e48cffesm18764071b3a.49.2025.12.25.02.05.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Dec 2025 02:05:42 -0800 (PST)
Message-ID: <e63d61c6-a35b-421a-820c-91262f3b11a4@oss.qualcomm.com>
Date: Thu, 25 Dec 2025 18:05:36 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix qmi memory allocation logic for CALDB
 region
To: "Alex G." <mr.nuke.me@gmail.com>, jjohnson@kernel.org,
        ath11k@lists.infradead.org,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
References: <20251206175829.2573256-1-mr.nuke.me@gmail.com>
 <7ef46837-7799-4ede-9f5e-88a010d5d1d4@oss.qualcomm.com>
 <884758381.0ifERbkFSE@nukework.gtech>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <884758381.0ifERbkFSE@nukework.gtech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI1MDA5NSBTYWx0ZWRfX+THEPTmpwJzE
 sqvHh5BiX21pzimuIYCkHTUhZg94CWL1eLYo9gZUJuy0ZzLi/MqVk6xy8O5v0jseF7D3vQ/tn5U
 gcQXqVtOeCjBXgtqsKDQpeC+mmgCeYQMw6FXi/Jb5049GFeYP3TTVo2KqeKmI7pQmDxYTqNZZwY
 JBapTfaEOSJAMxFz8n77AqFOiL6WvnL23wRLxqZBhSqF1Yuxbi+wAdd1nJsXirvAJj6JtkAdSI1
 KTKtEV/aBKUTDqQ7IDOHUJpBAOuGvLgSZR1jZR1NU3Hmnwr19nBEkJTbcqh7bOIs7x4BrQwvghp
 u6+iEHebMTPVjtKbbiqpZHYOLjDXBlINeXsWt3/vkwuvKzrQE1zCyLUu1wX2WlhKGx1e69QQMnj
 EIJbH5914G7AyMq7jb47p1edHKnDVfEUN5uIirXWVxhpt/aKoD1HoVganLh+Ws/DUXICcdTD2wW
 IWdeequNNqFOCggIYOA==
X-Authority-Analysis: v=2.4 cv=Vtguwu2n c=1 sm=1 tr=0 ts=694d0c78 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yXKDi3_BjhFrakrclucA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: NSZKgo43SDHgvQAMauDU8WW-oBpAOnC4
X-Proofpoint-GUID: NSZKgo43SDHgvQAMauDU8WW-oBpAOnC4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-24_04,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512250095



On 12/25/2025 5:47 AM, Alex G. wrote:
> On Monday, December 8, 2025 4:23:46 AM CST Baochen Qiang wrote:
>> On 12/7/2025 1:58 AM, Alexandru Gagniuc wrote:
>>> Memory region assignment in ath11k_qmi_assign_target_mem_chunk()
>>>
>>> assumes that:
>>>   1. firmware will make a HOST_DDR_REGION_TYPE request, and
>>>   2. this request is processed before CALDB_MEM_REGION_TYPE
>>>
>>> In this case CALDB_MEM_REGION_TYPE, can safely be assigned immediately
>>> after the host region.
>>>
>>> However, if the HOST_DDR_REGION_TYPE request is not made, or the
>>> reserved-memory node is not present, then res.start and res.end are 0,
>>> and host_ddr_sz remains uninitialized. The physical address should
>>> fall back to ATH11K_QMI_CALDB_ADDRESS. That doesn't happen:
>>>
>>> resource_size(&res) returns 1 for an empty resource, and thus the if
>>> clause never takes the fallback path. ab->qmi.target_mem[idx].paddr
>>> is assigned the uninitialized value of host_ddr_sz + 0 (res.start).
>>>
>>> Use "if (res.end > res.start)" for the predicate, which correctly
>>> falls back to ATH11K_QMI_CALDB_ADDRESS.
> 
> I am ready to submit the IPQ9574 support. This patch is a dependency. Should I 
> include this change in the series that adds IPQ9574?

Better not, first reason is for track purpose. And the second, since the patch is fixing a
broken commit, IMO being standalone makes it easy for stable team to do backport work.

> 
>> In addition, does it make sense to do of_reserved_mem_region_to_resource()
>> before the loop, which may give CALDB_MEM_REGION_TYPE a chance even
>> HOST_DDR_REGION_TYPE request is not made?
> 
> I'm sorry that I initially missed this question. I don't think we should move 
> &res initialization outside the loop. We also need host_ddr_sz to be 
> initialized by a HOST_DDR_REGION_TYPE (1) request. On IPQ9574, the firmware 
> doesn't make that request, so host_ddr_sz remains uninitialized. Since &res 
> and host_ddr_sz are used together, I think it's better to initialize them, 
> together.

fine then

> 
> 
> Without patch:
> 
>     ath11k c000000.wifi: qmi firmware request memory request
>     ath11k c000000.wifi: qmi mem seg type 4 size 409600
>     ath11k c000000.wifi: qmi mem seg type 2 size 262144
>     ath11k c000000.wifi: qmi mem seg type 3 size 1048576
>     ...
>     ath11k c000000.wifi: failed to assign qmi target memory: -5
> 
> 
> 
> With patch:
> 
>     ath11k c000000.wifi: qmi firmware request memory request
>     ath11k c000000.wifi: qmi mem seg type 4 size 409600
>     ath11k c000000.wifi: qmi mem seg type 2 size 262144
>     ath11k c000000.wifi: qmi mem seg type 3 size 1048576
>     ath11k c000000.wifi: qmi ignore invalid mem req type 3
>     ath11k c000000.wifi: qmi req mem_seg[0] 0x000000004ba00000 409600 4
>     ath11k c000000.wifi: qmi req mem_seg[1] 0x000000004b700000 262144 2
> 
> 
> Tested on : WLAN.HK.2.9.0.1-01890-QCAHKSWPL_SILICONZ-1
> 
> Alex
> 
> 
> 
> 


