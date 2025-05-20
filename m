Return-Path: <linux-wireless+bounces-23181-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E34A9ABDF2C
	for <lists+linux-wireless@lfdr.de>; Tue, 20 May 2025 17:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D11A14C6CEE
	for <lists+linux-wireless@lfdr.de>; Tue, 20 May 2025 15:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F14A262D29;
	Tue, 20 May 2025 15:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oimRF4wV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F213E25F963
	for <linux-wireless@vger.kernel.org>; Tue, 20 May 2025 15:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747754756; cv=none; b=QYCTcg4mgrKSQrs3I8Kkekv4JLyS9MR0DXb8Aj1mN0Fh3ZHaQb+RxZJNxpxRH8jMfbpxRy4zA6lSOtTErrcJfT+4fv7aX8TzzbIdklNN4FBFFzeJ6u3ekb+DTWqA4ZPhn9Nu5OzOVDwDGoB7meKg9jwE8Rls4SWg241/lpcWY4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747754756; c=relaxed/simple;
	bh=a+kBW5Rzr9aehWGN2QcYZG/FawqNDH5QD4OQ3O6rdBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lJn3MUMvcWVAnbkaA/Ng2PuD/FC9rajf8TEoL4WKoQnfPVexlozwJ6hYaf7m7GiawWkQYl/qKSMABxksxP0gbejCie3UoUQBqaGiIrk7a577s/DQwmG+YHoYNPqe6BkCCR5KmZ6oJenzeSZ+IITzs2cMLDEISpJYM6bMHV4RZ74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oimRF4wV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KDrm4t000401
	for <linux-wireless@vger.kernel.org>; Tue, 20 May 2025 15:25:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U3iyhmSVXCnIAeQ/mX2FSUocouwGoMqzly66trga9vs=; b=oimRF4wV3FSgDyKN
	oTXEyhQ+s4ecq/QkULEGfTe+M8ey22bne4GvundPl96DIlJMTRXQI4du5u0iHWjA
	NVifIbrPO9pXfZoq/IJvcTMqzJYo6iuJ//VBnzR18XygS2o6gR0AdjaG9XwkHa6E
	pzczbj5ug5ewG6NPl5Cd/VRz6QN5m3HG+XVbXIcWHaFIr0Q7eFiiOlJrvAIJNst6
	VgwJn8Ou6N0yb0k6TeNbgVVHrE/k6JtAPzxY0Mn2ZJEfiCErxYJyrij23zH4tS1m
	d9SeYDDv1KFVukUJuez09YV400IdqjAJM8jw1nIPR1rn+KseoMaIcQ6x3EU9h4ww
	LHhlsQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46r1atmfd6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 20 May 2025 15:25:51 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2321207ff20so43701275ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 20 May 2025 08:25:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747754750; x=1748359550;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U3iyhmSVXCnIAeQ/mX2FSUocouwGoMqzly66trga9vs=;
        b=PVzHbGwNrSvML+rv1ySythG2m+UhEL+eFKPCaimA2Ueo6qa2g5CzAMZEaimwH7s0Ea
         pvhyTphTjQ9MoLj2n8rlqHxRoGo6GvE7djYmy5PsTevPdDgCYdK0SCDXVxK6JcsUmrNB
         z1GeQKESfj7bbVzhbgFWt3Zy0vl/V8bdugEbg0scgrmSG9sIBW4WwzFjWkSnh+Eik2yR
         pRe4ZeU7V1gUB0wp9rHNMpAwVHjkUEocL7A7LBh6KQsC2UrtA6cOuQ6YR3MOJN8iTpm+
         oqbUi5ca7lyDnjvV+UvGHj1Fk/oZbbWAs7pjLcdT4bS10EJKaOzQSjTTwalsadZaLaNf
         D1Ww==
X-Gm-Message-State: AOJu0YxOyDK9aZsIuV15D/VmXGuxIebK0VtZB53UKJH/ZGrgoNUIsxj+
	SnHiiy3mRhIBfQ0AJf0Yb9G4nH3TeQkmU6QmpAtFjrbd8W5hJxxsMsU8cFeqnMeHyCnp3Lx0fbS
	tdM4t81lDa2TQQScKGr384V2c6IsNAhSJiiwFP4iO7Oj+N5AevXid4GblK+inoTeugVNDDA==
X-Gm-Gg: ASbGncs2UhdSqzWWO4b/fpCgtBqqQNk/tbTK1hf24kDTNs3UR9iYN6ptq0W9gDvO3Md
	KGl+XlN+olaXyDz05HTWMOoVqbfH3pDUDeDp0gCLYwMTnt0np/4TbA/5HCSyEiQTsAatSd42d/j
	7Uk1vFaHupfzPUIZ54VMu3TmahXDyR8kAFdZ1vnP/ToWzv7N9uoKzKkWhw/O6Q+k+HsEQ5JRzRS
	/EWzt7whpKRcfuXetYuztOhwVL2GAy067c36Ky9xJmk5MuqtlC1uJCNSSZ+iMk2GP8Ak47a/83m
	NF5pyjV9XPhaTuy3/k4TnJws6QEF2W/qGl0s8LayWXJC+5r1oVVC0A/q3z6MYXM09h4=
X-Received: by 2002:a17:902:cecf:b0:231:b407:db41 with SMTP id d9443c01a7336-231d43bf736mr224939535ad.27.1747754750205;
        Tue, 20 May 2025 08:25:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGkGfWaazXcZbuH0aAN0U+ulHXKKi+rzNIXBPpahmk4o7uzWcwBjJDLN6OKx6ktgCnI5sp/Q==
X-Received: by 2002:a17:902:cecf:b0:231:b407:db41 with SMTP id d9443c01a7336-231d43bf736mr224939245ad.27.1747754749820;
        Tue, 20 May 2025 08:25:49 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4adafedsm77567345ad.56.2025.05.20.08.25.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 08:25:49 -0700 (PDT)
Message-ID: <f454f61a-f785-4270-9989-2a1469164a36@oss.qualcomm.com>
Date: Tue, 20 May 2025 08:25:48 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next] wifi: ath9k_htc: Abort software beacon
 handling if disabled
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Sujith Manoharan <Sujith.Manoharan@atheros.com>,
        "John W. Linville" <linville@tuxdriver.com>
Cc: linux-wireless@vger.kernel.org, Robert Morris <rtm@csail.mit.edu>
References: <20250402112217.58533-1-toke@toke.dk>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250402112217.58533-1-toke@toke.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OfqYDgTY c=1 sm=1 tr=0 ts=682c9eff cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=OINd2kQi1hpqukDy0P0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: XOdJsC2Zs7CaUAh1cOHQov1wMg2DW7i5
X-Proofpoint-GUID: XOdJsC2Zs7CaUAh1cOHQov1wMg2DW7i5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEyNSBTYWx0ZWRfX8l/Th+V4+d8o
 RR7W7vxxzydprPEh2nmQsSMPgZth5z8qvgWdyAn/+DzrEABKF3IKiG/MEK4KtnOpQrkZDJfzCqz
 Rj9l8toy4/xcuQCjqGB840U6dQ9HaDy1iC9y5FaIKWbmifmnOyD1y4uCRtPc/kTmZ3gLDHDGkos
 l+8vmw3zs4t51kwyeALyV3DFvEWgb250i4vhTegGA4MhS9Tcl3c3swc0fX/qxJiuzKuSDMhsle1
 JVrrcx99j8XUeBEhrzWMSCQrL3UAhGj5GyiqA1yTeSMooEB+r4dKBu09pKwo9jqyLwFQaIaJY3O
 PmHJf4yKIppxhm6XJBkdZWSsBoCMmDFlz/AzmZs5kRQiZAQ3QKODvl2AFHaFx9lJdyy27LH20Fy
 ohtvcEW/+/0FqIIgo7qgiyPq7oWraljAo4b9LJSHBBI88j63RrJLRRFNdJjUcFh1ThvDIQ4T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_06,2025-05-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999
 clxscore=1015 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505200125

On 4/2/2025 4:22 AM, Toke Høiland-Jørgensen wrote:
> A malicious USB device can send a WMI_SWBA_EVENTID event from an
> ath9k_htc-managed device before beaconing has been enabled. This causes
> a device-by-zero error in the driver, leading to either a crash or an
> out of bounds read.
> 
> Prevent this by aborting the handling in ath9k_htc_swba() if beacons are
> not enabled.
> 
> Reported-by: Robert Morris <rtm@csail.mit.edu>
> Link: https://lore.kernel.org/r/88967.1743099372@localhost

Changed this to Closes: to make checkpatch happy

> Fixes: 832f6a18fc2a ("ath9k_htc: Add beacon slots")
> Signed-off-by: Toke Høiland-Jørgensen <toke@toke.dk>
> ---
>  drivers/net/wireless/ath/ath9k/htc_drv_beacon.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_beacon.c b/drivers/net/wireless/ath/ath9k/htc_drv_beacon.c
> index 547634f82183..81fa7cbad892 100644
> --- a/drivers/net/wireless/ath/ath9k/htc_drv_beacon.c
> +++ b/drivers/net/wireless/ath/ath9k/htc_drv_beacon.c
> @@ -290,6 +290,9 @@ void ath9k_htc_swba(struct ath9k_htc_priv *priv,
>  	struct ath_common *common = ath9k_hw_common(priv->ah);
>  	int slot;
>  
> +	if (!priv->cur_beacon_conf.enable_beacon)
> +		return;
> +
>  	if (swba->beacon_pending != 0) {
>  		priv->beacon.bmisscnt++;
>  		if (priv->beacon.bmisscnt > BSTUCK_THRESHOLD) {


