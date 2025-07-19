Return-Path: <linux-wireless+bounces-25683-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 432B2B0B110
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Jul 2025 19:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C09FF3B0B2C
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Jul 2025 17:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6189476;
	Sat, 19 Jul 2025 17:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LonTf85f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D19C21C190
	for <linux-wireless@vger.kernel.org>; Sat, 19 Jul 2025 17:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752945725; cv=none; b=M4z7d35UcCFImPP+At0F7BSO9jX3RX5aaBTKVcZangNIWcBukzyignxbZFDmV/g6Gd5K690pENEWejFa6clVb1q0EVWzl52ePYO9UWLAoWtIV7ZAV3Ti0oaB9NOZ5jGJdadIvKlv+fOvSnkQLMsRHeSEqPq2q8z4qroNAoijMB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752945725; c=relaxed/simple;
	bh=MLAvcegA4PyP2rE2wMK5AzgmTWEH78sJO82rM4rDDLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Whx1LSBTAsVgpRZRecP6B3fliDq83jbdJxQIgzdqHBtfKy02Eet8B/JtRi3iEidFdgmev5WFHFEZf0mvgNQiQSnI9GYcHANivBxgrakmt6vCu7feNf5W21jmN09M4VsKMkCeRWIOTtrBImD7pPK3Ntm6HBCNdiNa1MB5EKcWxhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LonTf85f; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56JGvlIQ008927
	for <linux-wireless@vger.kernel.org>; Sat, 19 Jul 2025 17:22:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4JpVhQLJSPv3BQlSmdFwM3pxbrYszmWw5/rIg8qZdnY=; b=LonTf85fWyfriiw0
	e4ypW2SavodVtqowc2E43oFqsZNM8WVylIGSR8mTpvJkgoxLzwhiKW6k7d2uY1MP
	stKl4Lb7EjlAUAon9xJeGT/Qfj9yf0TGs13isOUUaoJ92ewMMyQqpIwfZHYgByeG
	ALCz1Wdb2UN2avFgD89ZFfkBrx5Wp2ChN+g6QtBSjnoQHM8iVvXUBUO90xV+QEAq
	wPaYKti9LUNz2oiAGO3Lpx8yarJOCykmzl2A1Y0SFUtzHuOSuK/cgHlmnNw1b0f4
	h2VtuRFnEHyTeQySKGNWhlzFtPqGgjNK9rkaVBWnfHhvXz3Ml++XpR4tl+0/l9XB
	D76iJA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4804hmgwr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 19 Jul 2025 17:22:03 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b38ffb62492so3591758a12.0
        for <linux-wireless@vger.kernel.org>; Sat, 19 Jul 2025 10:22:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752945722; x=1753550522;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4JpVhQLJSPv3BQlSmdFwM3pxbrYszmWw5/rIg8qZdnY=;
        b=qCFh+kolQsu7hT7fXYpSJV0JxWdr2REB0LlO28qAP8inlVOkXynvc0yGCdv5BB7Dib
         /Bxe1YrTnZ6IIjKcyfeGXFKq1ApmHSZ/fjNxkjkG+izFKvRiBr32chGdq42tW/qwZmnG
         yywV7FhEsjqbDVcVbFn4Mhm1Z68CCihYfHRyiw8ZwIyNMlkmmyH1QHdhIGqY1Y7idJrw
         MhaeYWJEfwwSkFIJAIvKRTugqqhE2YpCH7x2vBX5tu8RjPnShqa5DAktX5E3YD2yeRqN
         OmMVyHZql1o+TrARPoTaOtQJiAMgHMLdRVzN1/GKvnNtJfeaeq2uP7iyQqIuQnuJumvw
         KSIQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2sgi8aiuk3figI4ZJfXQgQ73RcbPnDv8N649P6Z8oPutOFsbHkM62Fa9Ie8SSeKKp1gtcAwhlrwdY4LGOqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy44MuzdLCdPXOrJOQxCqhOpRRwwl0nnFZr1oXjClbCJDkXMrEZ
	kyJG+L9xJOhmHRigKoBFIhVBXnTJv5fh98Y++Dggej5ylvFfo4jtc5vxAxEum9r4EvAgjKasnsa
	l/7Pu4IzkqKRh8wQybLP5Z/nOsOo2j56V0+W/l7q8TPef4/4vKanW2AbUE8KON6RN6CaIpakqo/
	ki5A==
X-Gm-Gg: ASbGncskvrN2NCvYdGPlrGVm8Cq8RqfSc8zgMsV/u0sIF3YG+N/XxaM2B9Tb59VRqJS
	Bd/UammbnrW1yc8QVbZEoLSw4AdBr2LoiI9G81MpDLCffdiUBxx+e7n9qKQIrcATgoZQO5KETEk
	8utetpMuJd3TpDtzC9rndbezVv+G2fSkZhQn8jrC9HATZh1VOyVe0siRW9yfv/YMl0VSzyQLRlG
	XMgVC0BFEGmCYAZH+aXGs7nN9UWpdjhSPs8cIQA8t50FmjSQDsCZ0Xv0r8DRXNAj+wolLl76SwW
	Z1/AXWOOnvLzuBXCpCxeQHxkf8Qgr+320G02WOrUe6Fi48eBJvKoIiQSe5SdwcufEMn1IxaRC4U
	oafkYyzUW4BzOOgSRHRp9kGsGs2oN5g98
X-Received: by 2002:a17:903:230d:b0:234:e3b7:5ce0 with SMTP id d9443c01a7336-23e30384570mr133419865ad.47.1752945722044;
        Sat, 19 Jul 2025 10:22:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvDdJW6YIr1ZYHpaTRpQN36bqxM/GTcxkOqpcyyNNjkJ0nFfayx73Pq2oYbOIAbABFTcfX5w==
X-Received: by 2002:a17:903:230d:b0:234:e3b7:5ce0 with SMTP id d9443c01a7336-23e30384570mr133419665ad.47.1752945721571;
        Sat, 19 Jul 2025 10:22:01 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6d8825sm31331245ad.169.2025.07.19.10.22.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Jul 2025 10:22:01 -0700 (PDT)
Message-ID: <1cb5c9e8-9894-43e6-ba3b-755a7d1dd56b@oss.qualcomm.com>
Date: Sat, 19 Jul 2025 10:21:59 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] bcma: Use managed APIs
To: Salah Triki <salah.triki@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <zajec5@gmail.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <aHvFi5PMXFxGwd1W@pc>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <aHvFi5PMXFxGwd1W@pc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Xz8r-VIN8NYaE3gSanEAK6Q_Y2RGXpAe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE5MDE3MiBTYWx0ZWRfX4sZuyzydzklu
 ZWjLliFk9UXODFmV1ngcgXILEUTvcKLACAdFRVzv+cVhGOXaY53Ib49XUDEq7zyy3mxkmkSQUUe
 FsiGf9qGl5BkrCiVQCvQfZ5cbHv03ObuUVyIjgpsX4Tq9AapdmsWtrJliDR0CZcC9BnSgoC5MGd
 w41XOyRSl4qqWm+jtC+lkagfuZWs2b/PbE+tSrQhBrKBSMBazWPnPWbSWlByOEZbhAmR/D1Ko1V
 mzuB2Fv43Y/q2Kq/RgRN0v/jDrFOnDufRHS+dRYx3gSyxZ6KUi/+J2t6tiNgZp3M2Ouyej9urfg
 YSOLZ/npZQZSQXuCBIsZMRcIvRooxePp0wjhVBV+ODk9J0Dcwus/Avk2KWTbcD+Zlk3sxfK4AHh
 5/1iEVoj47ohmIsiEqfghfOTAQnMxNO38zn014r9MNLVbgbru7v1xK0aZP6r6Y4ixglZJMW4
X-Authority-Analysis: v=2.4 cv=Navm13D4 c=1 sm=1 tr=0 ts=687bd43b cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=C54rZm91nIrLC89xkaUA:9 a=QEXdDO2ut3YA:10 a=D0TqAXdIGyEA:10
 a=xa8LZTUigIcA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: Xz8r-VIN8NYaE3gSanEAK6Q_Y2RGXpAe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-19_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=850 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 mlxscore=0 impostorscore=0 clxscore=1015 bulkscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507190172

On 7/19/2025 9:19 AM, Salah Triki wrote:
> Replace pci_* with pcim_* and kzalloc() with devm_kzalloc() so that no
> need to worry about freeing resources and disabling the device.
> 
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> Tested-by: Compile only

1) When you post a new version of a patch, please do NOT have it be
In-Reply-To any previous messages. Each version of a patch should start a
separate e-mail thread. The guidance at
<https://www.kernel.org/doc/html/latest/process/submitting-patches.html#explicit-in-reply-to-headers>
seems outdated.

2) Most maintainers will not accept patches which make such a big semantic
change without actually testing the change on hardware.

