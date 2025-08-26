Return-Path: <linux-wireless+bounces-26634-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4923CB36D48
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 17:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 270204661C3
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 15:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB9521ABA2;
	Tue, 26 Aug 2025 15:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WRG7PNoE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AE220A5EA
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 15:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756220434; cv=none; b=nx1/TNU7bznxnuKFBSpv8chRhhevBuNhm+YjNaa1b8XmDvVWK1TqixeYuEjakgDWL/gcqaRM6Qtsj3NZVkozThLkSgaweuvUPry2oq8dBmvsmzCdlbJz8w8xfLDjEVUsvpZRT/eHLgClxWtI6nvsvs/IFVvKVOrI2qrUYInZSIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756220434; c=relaxed/simple;
	bh=2sy3SUnm+GjMD5Z9IU85pM6PJVMtTyWK5ugr4sAqHGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rHwjMMvRsVP0eAWqIdbOVqOSj/VuA2bg5CC0GU1z7D8Ydjhn9EnWFLOTwfhRQu3vog6suD4qBKUw/MWbUk9MGhvXUHiXjCXs4w6IbnyX8/1v9GzpeBo2bicSv0T4MYui11wAkqFiV1BadUrR6hJgDk2W5VkzCOaB81DmGbsyZ8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WRG7PNoE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q9AYUh026003
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 15:00:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	E4zX7FDy46jTNSQfokkMWhQWg4d+EwhS10aZhkxTroI=; b=WRG7PNoEhPAZ6Las
	GjPzDASv0k7AsMlKLNXrsayQz4PVoDt9yLz44JJ2T5Gh1evTDT5zmrIXN2aAhuOK
	0oB5z38kF84s/uQ43DmvwRQHaQDSaNokR9iWd9tvpt+iRytNm0KzY1hihVuEDjqt
	64CVPXVxmAg2UYnTFyeoGiUq+gQmFM9P05X9q3qBReyXl1t1kBaQemxglkxubCLa
	fa1j7tzj9/JJBAAcnDc4zSXbyfzWTlYvd0IjYop+S1TjWFZnMqF7V5wLk+e1xUkp
	+f6ontf3JCnIEu2a0A74avaufpUNQVf4QDaTuoo5eML4C4z4EhdKI8Auii2zPoXw
	cvFxgQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48s2eujbtg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 15:00:30 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-246cf6af36dso27249105ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 08:00:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756220430; x=1756825230;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E4zX7FDy46jTNSQfokkMWhQWg4d+EwhS10aZhkxTroI=;
        b=joJmA7vKcFZ6EmVK7wYJEnEinJpZSre7a859FSsLF436L+qwhurRnx5hgkbXdDIWVw
         MGzKXkQcRt2Jap6xv3ITlIH1hEQfhhwJMu4n6HtpQmmFzXvLH1cSDTIL8M2cIHEUn+pI
         soUaa15COz6dMB33BdSy1U5junP1XR/q2UO8z7V7QZ2lAovX9ozqWHsYqGwxeLdK0sJk
         il2pisSxTht4d5WiwRwxyX/7GS7Vf6yeqWbr0ieXFNALCzxWkyUiEQcXNx0DaQjY82Ix
         TRy0swk4oElWFasQoiXCqNYbHgOQQosFXYEq8DwPgN4bFwxAu+yTA9YAZpBjBPIKy4pB
         hkGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVh9yAYTgamjg6r08miTY5Lzk1PdFMTM8newqCUbp2fujcwc15ZSN3nmcUgGo6OL3758cuMkF9h8HkqRk3xDA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYo7paJNOsyasYLgyHxhh1oz3GBnlJoEOUTPYWSpOEG/AuA5AZ
	liIcLVJsMPXWF7f1ylHO646947/TSewnkYeSqL706/tBEpzVquETIiUjSV3rrzxkzIoAvlueA02
	fGYGI7D7+373kSTRfMW70L3GhoIoLvSoXfAm1C1Caeyc5+iolDYpVWklijCJThV2mM6xRVQ==
X-Gm-Gg: ASbGncuCGIntSSWd8ymjnVw5wJnjqlVQX5p5r/kzdBt7oXUT+6sxO7xk1661gGk/tur
	hhjEOHhV9xlr2R2rYvqbSgyLWoMXrkgYaNykgvBS7qUSD368ZgloHcm/skbSIf6gNv0lhBtlJVH
	NPnlpyNM3FCjrl16XgjUOvyorgec1K4xPoHkZJDWuDmJYJuDCExfy3KEUWepiFSFpVSGs5QWqKI
	WEt0UaNOMJt/dbX+hWm4SqJqCnx7NGKcwnAtG9wMLqXHfP/lh/o0ANyRHEwRl7zoN/c/zen0cij
	Qk9Bk+qbLvJO+Eb42m8eoRGYGVQ7VhyQvhhqYe3ASenSrHj5zmF3FArpVpK19Tt+0kt92yI1DIZ
	bjVIneiod4wWTynWKqAw=
X-Received: by 2002:a17:902:fc8d:b0:246:bbd9:3810 with SMTP id d9443c01a7336-246bbd93ac4mr97127785ad.48.1756220428343;
        Tue, 26 Aug 2025 08:00:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtHCr7bGLy8u99KJ7otoMRWvX2qvOYlQm9bz63m305Hao9FmeN0OIQ1YPRtU1qfgas8ctCIg==
X-Received: by 2002:a17:902:fc8d:b0:246:bbd9:3810 with SMTP id d9443c01a7336-246bbd93ac4mr97125605ad.48.1756220426060;
        Tue, 26 Aug 2025 08:00:26 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3275933d6a2sm904010a91.23.2025.08.26.08.00.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 08:00:25 -0700 (PDT)
Message-ID: <eae93cc2-8090-4040-8b27-c492af528b45@oss.qualcomm.com>
Date: Tue, 26 Aug 2025 08:00:24 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80211: fix incorrect type for ret
To: Liao Yuanhong <liaoyuanhong@vivo.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "open list:MAC80211" <linux-wireless@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20250825022911.139377-1-liaoyuanhong@vivo.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250825022911.139377-1-liaoyuanhong@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: LuP3JfIEyzAE-rrThoAGb-l-mN7TFBlN
X-Proofpoint-GUID: LuP3JfIEyzAE-rrThoAGb-l-mN7TFBlN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDAwMSBTYWx0ZWRfXzZg69VkUWBvN
 XLiczZwYMSjj5m+UC7+ai4EbZBcSNpmrE8T83cT8mNxnq3flPoKN6c/0ElRCtauh+G5/fxaHFWm
 e66lvHVTzRLmFxxCsg8mzFoJ3mT8djbr0piRVnw07VBT+UCxh2xULG0dfCI12UjScsp+BvpYkF1
 RR7LH3NXn+JPp/T4BLNRFs5vHguViFd+iRVtfbRXec57hq1GBAxtu4AdnyCslNG3wcdu8MmQ+yQ
 3DvlnS2bymAi+eAfqWkeVK0kNaSH5/O2fxfgB216BaBiO42rCv9zdQ9b2nK68xwzxzUnl4o9j3O
 qZdTyES0BH7PUoGDA1jkRc/Vi3YgIos2flwpcFuGYTO9VxTkyizjma1Q+oNRs9sTvRfcdheMm8i
 IJdHVmyQ
X-Authority-Analysis: v=2.4 cv=PJUP+eqC c=1 sm=1 tr=0 ts=68adcc0e cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=1WtWmnkvAAAA:8 a=EUspDBNiAAAA:8
 a=LVyCKMctt9a3gUk7OTIA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 phishscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508260001

On 8/24/2025 7:29 PM, Liao Yuanhong wrote:
> The variable ret is declared as a u32 type, but it is assigned a value
> of -EOPNOTSUPP. Since unsigned types cannot correctly represent negative
> values, the type of ret should be changed to int.

not only that, but drv_get_ftm_responder_stats() is declared to return int

> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>

Reviewed-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>


