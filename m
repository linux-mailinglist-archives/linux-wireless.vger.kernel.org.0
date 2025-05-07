Return-Path: <linux-wireless+bounces-22698-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4431CAAD30B
	for <lists+linux-wireless@lfdr.de>; Wed,  7 May 2025 04:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B53A4E818E
	for <lists+linux-wireless@lfdr.de>; Wed,  7 May 2025 02:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED7E143C61;
	Wed,  7 May 2025 02:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aMnLQoCE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8FB4A11
	for <linux-wireless@vger.kernel.org>; Wed,  7 May 2025 02:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746583683; cv=none; b=bnVcY+N1ZBSnEkzRsS72EL5WsP14UZRCr3F/FR5EILZABU/jz7PoFZXkKxDdB13liKlRH9emOOLTVXsKVcjbRmXzUcRRj/NWKZciyu1W1cLwVt7QcBBJ94ktozaWJlKPQWFXhzj+ngTE9Xbwhfc4/kgIpNAs07VaR8jv5CToOpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746583683; c=relaxed/simple;
	bh=xW86/9jEHkBKoQI00vm6u/I3t7pzKXBz5toWfbeiRjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GxuKAAMsEwD5q1UODUM/1Mg6KiGqsftorO5k1z0Hpyl+oRYY/Lrj15eap6kWKLGyCVQcB6FoUyfpB/z3L8KwtLkmJrefYElkmde3KOkrMwADgDkjmDCMlIhqssmogHoebins8TuvagPXgLoViNmJ7xIsXzzlvjicYxy4DagfiRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aMnLQoCE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5471Gkth002510
	for <linux-wireless@vger.kernel.org>; Wed, 7 May 2025 02:08:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7wZOjd8ceYaj0jg8B4gKb3L865zn1+qkmaarQvnEXoo=; b=aMnLQoCExPgi8WeA
	FXVNlWQLqaR7AhLnBh0cghR3a+Zgybvs4xwxDcq/09gptfI7dWIGkANtS0veHCtV
	qope+QTGXstOR4OwAhnhApMYerL9xzgkVIiARxRQogg4LxHVShOf0buyCcCDcpHE
	IvKzlbCoYHWHBMbsuviIxlOgi0djgIezDQiP2Thm+mVeAiyBFGDt+nu/hgJjwvFz
	qi3MNMvMOHMCPPH73VpG8DqUZdcvI4THghqx0VE+JdMtM8Ydnyy7N7xVGnr/9Z95
	6ZaF6ZV2kGPm+sonJb8KDD7N+vM/a0wMHIIvp09PwI7u355dMTgNHsCX9YRqclNs
	sHJNww==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46fsmt0kgx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 07 May 2025 02:08:00 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7401179b06fso4966252b3a.1
        for <linux-wireless@vger.kernel.org>; Tue, 06 May 2025 19:08:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746583679; x=1747188479;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7wZOjd8ceYaj0jg8B4gKb3L865zn1+qkmaarQvnEXoo=;
        b=daIkd7e3QyNGqHyXe3zdZHElTWUBEfRNY2uCs6kWTrkY92XI/3LK69RYofx7BeQtzb
         k6r82QQLDBqPrhhTLSuf0UpilFvRhbLYvkPue8rzulooQ8ldCG8U20YCB42BkQBVP6wc
         WtteJInPAn4sf2dC2lkIEANddxLL0W7hFw9RRVS5I55yLbAdr/gKhwl96gZKZ9R1V8J+
         gQWYNt27izaKrThyC9Wg1rZSOnQVciC2U/pMx5R7Ntku/OgcIEvuawcjmxXY84KyOI0+
         F1jFfdY5L6gacMrQzZGDDV2AYUgfy1LJoRqPs6qV5on5/FeZqg+FIUV8Ee7DIymw7au5
         sKrA==
X-Gm-Message-State: AOJu0Yz2jQWESPfe6SqTEdpzlh2qBRHbzjS2FQ4ZqVnn6P+PP/tuWkUJ
	BcHXzGK04WOd6ZThtYvYc+uO2nt3PxsL4bSXnaKsMRyavcEr86VozrHOzgmZAouhEBJlsCKFYb7
	6gtf10++i8Ffmrs+SVarvwj4vxkftp5GRBbMdaWBpsL7zNAC+GZH9aWWlUuu2uJkx0xAGFhtsMw
	==
X-Gm-Gg: ASbGncstiUTw20dwAwcv9OHg2MofbwNmL1oLK97KBHR45tZyAnHeJ7wFI9zCMB5rcul
	tvBC8oXBgDFCXsfZlPI+pUIskhui/cjbRr3TC4BQS8Eo0jmgwubzfPuX4jUO+199rvwpS1GoMbn
	/xpho4jpcFuYb1JAcwIi4GCTu+wpz31cIsHcdrvSQrxAX4J8ACQV5eo7V6nsjgfd9Z35ypklW9O
	nXZv/TiyZybtEW1X5fWfr6WpbjnqCmb5dnDjtfKKKgVr0zBBNraveFQ88pSZ03sV//CgNuNBSzn
	Ab/ZHNR02n1qg6+nh7EYuI8DYhZfudG0Hi9ijfMfgwHEVag+6rUpzAZAIp3tsH96ZvTFtzAvpZ0
	=
X-Received: by 2002:a05:6a21:9203:b0:1f5:80a3:b006 with SMTP id adf61e73a8af0-2148be0d1ffmr2006541637.21.1746583679377;
        Tue, 06 May 2025 19:07:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/uUMV/wZt5ljG6wdlTNRYDgj/VDqH6QBHtVVvFKegyCB66lIbkhWcRfuZj76r2zSQ82jSug==
X-Received: by 2002:a05:6a21:9203:b0:1f5:80a3:b006 with SMTP id adf61e73a8af0-2148be0d1ffmr2006515637.21.1746583679040;
        Tue, 06 May 2025 19:07:59 -0700 (PDT)
Received: from [10.133.33.216] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1fb3925ae3sm8385333a12.12.2025.05.06.19.07.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 19:07:58 -0700 (PDT)
Message-ID: <afd009c0-38aa-422c-9aeb-665ada3c9235@oss.qualcomm.com>
Date: Wed, 7 May 2025 10:07:56 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] wifi: ath12k: delete mon reap timer
To: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250107025621.1907-1-quic_kangyang@quicinc.com>
 <20250107025621.1907-4-quic_kangyang@quicinc.com>
 <9f7dcede-caa3-970e-6d37-9f18344665e8@quicinc.com>
Content-Language: en-US
From: Kang Yang <kang.yang@oss.qualcomm.com>
In-Reply-To: <9f7dcede-caa3-970e-6d37-9f18344665e8@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=U9KSDfru c=1 sm=1 tr=0 ts=681ac080 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=aE2tVh0QiOHCoEqsSJoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: k1DEbNeD5nJA-yNnAxd5cfa49Jfz3AEi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDAxOCBTYWx0ZWRfX2LQjTvJH8NEE
 Sba1qS/Pom2BxukGX7PNMAbfv4CqVDeVwTGEJb6y1zhBLgZiohML2LJC6LfL849eZiFlL2C/ZEN
 7PfMXVEGh/KTRVDfXOlFWgYgju86PYeDwn58AQwO4rvygB7K0FZQaWyHwjKIRTJyLzU8MGRF8bS
 O9FIbEqNRD63AKu+LmXZi8+5Lf+86F/T0FGIJ4wlOh/KN/dO38ZgeRzIM3EQkSbATWsSawXvE9h
 /UCn7yEzVCc3zDm6cN0yf6KUwy+vkw3ntfq5u2h6GPqvYVlUZ6axMhncWqJg6bRKXpOxvgnnUre
 PPw9tZcdZRH0/bx4t6rzekxtP8d0S/KgqUz/PFmgjppusW9Pzw3yNkEoM8Xal/v9Kd1KSgGaQTE
 +fsGS8PozJJ5lxa5PxylrVbLyV+Dxya5fsDGBTRXIYXEYj86WBcErzNKcHGbwFpAe/JI8+dW
X-Proofpoint-ORIG-GUID: k1DEbNeD5nJA-yNnAxd5cfa49Jfz3AEi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_01,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=927 phishscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505070018



On 5/1/2025 11:34 PM, Vasanthakumar Thiagarajan wrote:
> 
> 
> On 1/7/2025 8:26 AM, Kang Yang wrote:
>> Currently mon reap timer is not used, and it is not needed anymore.
>>
>> So remove related code.
>>
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481- 
>> QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/core.h |  2 --
>>   drivers/net/wireless/ath/ath12k/dp.c   | 30 +-------------------------
>>   2 files changed, 1 insertion(+), 31 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/ 
>> wireless/ath/ath12k/core.h
>> index 41a51c7bad6c..ad2451fd7ce9 100644
>> --- a/drivers/net/wireless/ath/ath12k/core.h
>> +++ b/drivers/net/wireless/ath/ath12k/core.h
>> @@ -992,8 +992,6 @@ struct ath12k_base {
>>       struct ath12k_dbring_cap *db_caps;
>>       u32 num_db_cap;
>> -    struct timer_list mon_reap_timer;
>> -
>>       struct completion htc_suspend;
>>       u64 fw_soc_drop_count;
>> diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/ 
>> wireless/ath/ath12k/dp.c
>> index 9e5a4e75f2f6..f162f98e7b79 100644
>> --- a/drivers/net/wireless/ath/ath12k/dp.c
>> +++ b/drivers/net/wireless/ath/ath12k/dp.c
>> @@ -1,7 +1,7 @@
>>   // SPDX-License-Identifier: BSD-3-Clause-Clear
>>   /*
>>    * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
>> - * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All 
>> rights reserved.
>> + * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All 
>> rights reserved.
>>    */
>>   #include <crypto/hash.h>
>> @@ -982,11 +982,6 @@ void ath12k_dp_pdev_free(struct ath12k_base *ab)
>>   {
>>       int i;
>> -    if (!ab->mon_reap_timer.function)
>> -        return;
> 
> This dead code removal change also fixes a memory leak in 
> rxdma_mon_dst_ring with QCN
> chipset. Bailing out based on the timer setup will leave the memory 
> allocated
> for rxdma_mon_dst_ring unfreed as rxdma_mon_dst_ring is allocated when 
> the mon_reap_timer
> is not setup.


Praneesh told me about this.

This change is in master-pending now.
https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=main-pending&id=c23cc8ea2d104fecd0a54ca691cf8d58fe956fa7


> 
> Vasanth
> 


