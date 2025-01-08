Return-Path: <linux-wireless+bounces-17199-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B670EA0617E
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2025 17:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E7AD1658D0
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2025 16:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1FD1FECA7;
	Wed,  8 Jan 2025 16:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pOAsTNFj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F851FE45D
	for <linux-wireless@vger.kernel.org>; Wed,  8 Jan 2025 16:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736352881; cv=none; b=u9ImhHWtWSmuRkvVWy+NZz0uoxCnOw3KCdupG/2HuiapUDjqabOUtGiyOBhsKmKOzX2eWSBKr8NF4M/90MjChN0Kpn8ylHloxBkPbEx5ItRXVgP16VONwKxnUGEs5dNqYjvlsiLcjc8FbLSCijPLq8/HKmw4g4hwf6nKmPm6PlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736352881; c=relaxed/simple;
	bh=E6Y6tA4CNp2RChT8yYyRZ+NBuBh935sl+HMKJX+5rUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AQZXlDZMN2qn/sYHNaXmvspGsW+jtpC31otqOLVWxZZ8dpKy6pioVGUiHkhuftYmAnnAmE1JUT/x+P+qnZz2Bu+d+uXwHb+rlJCGvhnvvAOzurJpkey5e2Pk9tYRaXkPZ7rex9i8oeCfg9QPMppslXJ2y9D1L5ByAQMygmQJFBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pOAsTNFj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508BkVBO005657
	for <linux-wireless@vger.kernel.org>; Wed, 8 Jan 2025 16:14:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x0HOMgigLyZ/I1O3LKpmTlmtbe7AvWiz1ycqz9rOCPM=; b=pOAsTNFjHJF3NIc6
	7kwbwfF+Li5RFysy/r866Z598IblwihdwejigA2nTet9pTmUS/TCDQzYyKkJsYNo
	eBxw6WS+M60ppYkRro/r9J7PhV8Ey7ymTv1hOadmjexYhotl+jnGOT5jHeL+VQgS
	hJIpYNjidVMU6BeMMTgd2QvST6JMXQa8fEscAvNpde2tQ2wgqasqsY15g8Nm55ZR
	TLvy4QZKoR+WRs1MrpJWf5gN2BXkgE6z40/fp2jT7/0AnIP41RDsSTWlKmOHJAQa
	pyndAmbEozHhC1EGSzYUA9usYbUzQFn6Pmj3Q2Wn5pocTUm78xbg8GKjogb0sFAK
	x0r53g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 441nj2h758-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 08 Jan 2025 16:14:39 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-216387ddda8so234409205ad.3
        for <linux-wireless@vger.kernel.org>; Wed, 08 Jan 2025 08:14:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736352878; x=1736957678;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x0HOMgigLyZ/I1O3LKpmTlmtbe7AvWiz1ycqz9rOCPM=;
        b=gx9cB27FPBOfVu1swhJDqkhuCwcgk40KTb3XP79+N0acwI3xgCcjwNmHLg9u/vHJ+6
         AtEQQo3T4guKiUGUu6DSgQ9VWjuSPAlbBKA1vTB5FxgYiMaxq4+vZcB8KF7Be9j3ST/p
         jmHRH4WCBcvkNM5LRBuQAS/GOvWKQHUnGo2y1NIU9A7CV9IWkftYYYOtExHXoDZP/paw
         GjWSzukiQ1ZG0N0znufmkKc93jQaN/dW3nt850pXMc6X9Q3VSnOLQS7jdSxpYOjHORlZ
         gnAzUCZ/U8xSNBj1q1aG4aXnSXuc7as57SZyptd83ezIsxrKEXeW/DOj59/u9WC5Iln3
         30gQ==
X-Gm-Message-State: AOJu0YxsBXNfHK3cJ8GrKqVeBp3p0bND9PP13VfGsVieLbOkGLn8U3Lq
	wHJRDMmCEafp5RkaKRomtR4BDX4kh57AJKFdyLzT6y3DY6CxC5vEm+mRY3Va7RCCSx9VD2cmGfX
	Hqy2BGYZEgh85QTQ4AC7j6MuhF2+SvArTpevaxt+QyeAjvKY6hsESODUDjrpmXlqp/Q==
X-Gm-Gg: ASbGncuGIv3vg+z+crzAmVYhP1jXHnyCYhslS21S09aDUKcs/LWtk2z6VywHilGEnRi
	HawuYqJZuBMp/psqjeAQ+czL6sqo1euRV5o7bQxvxcVV85UYZSN3NvY/UHxkDlLN26lCRN3hYGC
	OV+SB2wzPiCZsmz9YCHsN4SN5shTbxIiHAGXQnI81h/JiU85G/T4ZBgKlNByaGidkKdCjuAPTrl
	GufOdFnQ3OcdbxRdkMjokFbwh6i1Jowj/0hbVulx6mHgeoe2cKUIfmWJ2gB69BSI7Xa5r5DKeEA
	TADcq2yAhqrM7KNCn1PbsgkYH8phUv8vCMnOYKundFo1tD3udA==
X-Received: by 2002:aa7:9a87:0:b0:725:ef4b:de21 with SMTP id d2e1a72fcca58-72d21fc701dmr4821514b3a.20.1736352878325;
        Wed, 08 Jan 2025 08:14:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnzfKDtqLHMnAErCg2v3Qjwam1ikQiQe1USLBqrbZAttkwVkMvJW14pQgEvaw3NtFgpldIpQ==
X-Received: by 2002:aa7:9a87:0:b0:725:ef4b:de21 with SMTP id d2e1a72fcca58-72d21fc701dmr4821475b3a.20.1736352877905;
        Wed, 08 Jan 2025 08:14:37 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8fb0dcsm36413670b3a.147.2025.01.08.08.14.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 08:14:37 -0800 (PST)
Message-ID: <36a016f4-8ab4-41ee-824e-89c015717736@oss.qualcomm.com>
Date: Wed, 8 Jan 2025 08:14:36 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/3] wifi: ath12k: report station mode stats
To: Lingbo Kong <quic_lingbok@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20241225112315.49881-1-quic_lingbok@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20241225112315.49881-1-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: D2r4wU0eoZk4tnoZpyaVrzGrubM5F3DH
X-Proofpoint-ORIG-GUID: D2r4wU0eoZk4tnoZpyaVrzGrubM5F3DH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 impostorscore=0 clxscore=1015 spamscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501080134

On 12/25/2024 3:23 AM, Lingbo Kong wrote:
> Currently, the transmit rate, the receive rate and signal strength of "iw
> dev xxx station dump" always show an invalid value.
> 
> This is because ath12k has no logic to handle this relevant information.
> 
> To solve this issue, ath12k parses the information passed by the firmware
> and passes it to mac80211.
> 
> After that, "iw dev xxx station dump" show the correct value.
> Such as:
> 
> Station 00:03:7f:12:03:03 (on wlo1)
>         inactive time:  600 ms
>         rx bytes:       4642228
>         rx packets:     23796
>         tx bytes:       933967
>         tx packets:     8761
>         tx retries:     66
>         tx failed:      0
>         beacon loss:    0
>         beacon rx:      8925
>         rx drop misc:   191
>         signal:         -20 dBm
>         beacon signal avg:      -18 dBm
>         tx bitrate:     1441.1 MBit/s 80MHz EHT-MCS 13 EHT-NSS 2 EHT-GI 0
>         tx duration:    0 us
>         rx bitrate:     1801.4 MBit/s 80MHz EHT-MCS 11 EHT-NSS 3 EHT-GI 0
>         rx duration:    0 us
> 
> v8:
> 1.rebase to 09fa3b6974a1

Unfortunately this series conflicts with current ath/main, so you need to
rebase again. And since you'll be submitting in 2025, don't forget to update
copyrights.

/jeff

