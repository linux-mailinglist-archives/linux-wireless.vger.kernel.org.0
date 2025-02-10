Return-Path: <linux-wireless+bounces-18687-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95163A2E2D9
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 04:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72C7F3A4B2D
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 03:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C395EAF9;
	Mon, 10 Feb 2025 03:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GiV1ooQY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC0A35953
	for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 03:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739158421; cv=none; b=PaZxGbQtvjy0nyN/dQR11w/w9xBvPwCTQVzm7RG4t13o3YJI7jgSfg7v4hqG9Z7V6D5LllQz9bBufKsPG7/nWC3mMjiNkG2pQVLqexZyrTtjaJekVIqcLu0p7b6E9VnvHHxq1ld3sZ5Pt6DS8QgQcJMfPii3r3zQtfTgt6N1AA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739158421; c=relaxed/simple;
	bh=YHeHZNOWN6kZWUWe3rNuWHpAEwYGkiq5W8CYjsIzn6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YfkeK3qG2GbtjMAiqHPNSxXBpb/wa7gvLxewnWUKhC2NiM6xzOFkM4FtXsYi5Pps8M2ut6E1qyj8ncjXbnHHzmzerbm04WKm8y28ZWVw67pmma/VDGXpeyBsnQn3AswHf2WiKL7Q11l4hGIC6Jc1M118ZHrKzunPHq0e5lQ5ir4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GiV1ooQY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 519MGwvv015468
	for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 03:33:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Tc+kij6+pE0t14MlY+EJRZoja7UejFCIx+FgUfhcgkU=; b=GiV1ooQYZi7qVDXH
	dxrqq/YhdQO0zUYJwfSucenCrfpBpLq/r5SUrFpQCtXEZquyrJNsb03bYi2Dsna7
	CrBu7TEtCPidBBXMQ/QnwyqNRMvJSk8zcWsM+LUhFkZplsSzPDSkQyE1u1zrr6Jz
	2gOQiKqa3wREQASg0sEOD6gTGATDdegCshvhIrjbIhZj5jRvsgKyA9NGaG/Eo7qB
	elAhtra2uyvi25hRd22cRPgkkmafZVWkclp6kBzaAhCRXzr4Qh3WO1yay//7Xm5/
	3vlVgq10lweBWCuuIM4G4lnEwZFEnk9tTSR9/19mAHtyy167frKTLHS0IcUXumtI
	1Dw8HA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44p0dqay2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 03:33:39 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2f83e54432dso13056431a91.2
        for <linux-wireless@vger.kernel.org>; Sun, 09 Feb 2025 19:33:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739158419; x=1739763219;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tc+kij6+pE0t14MlY+EJRZoja7UejFCIx+FgUfhcgkU=;
        b=BNmb8eU7LJruj63Smp6ORdB8b9log6Uu0fgdB/PDx2Tc7wQ8mSLbNz21HF/ygy49dj
         sK4LhDcN+rYhBACbagwJOKeEc3YltP0GJHPUKjTfjT9BAWkOlSVrO8hXmoBZfY6fh2U3
         UwAVVRS0LUH3IGY8xXtBSY4J2JZaCCjJFyeLUpRn42EXbZqtIEnBeIsFT7KGjZML/is0
         DjmAV0CfNhE6xGZRrUMKWs7NOPxHB1v2+92SUUChF1TOpUqCqf/NR4vQuHonIiF11k+q
         IH4o2/mkKjkLQTLoWB7U9a6yyvCPtDqnCFHE1bjsLZkfnRvG1FhO7pQSRdAmGc8Q+kMJ
         4HtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjNiyw7+cUVpQTuH0tPSYXZSDe1jycmSqekA9Ji2kQN0J+uIycdd3wJKEmSNU7YnxQacfFyLIlF1RfkrQOmA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7i8vGYlrK18UokUcRF27ITh//G6MalJxI8TZf3K3DhRwAxiqU
	U0DZNBCewIIR54r/drWh9qbqArZJFd6xGu0CzznQfFmymFPMw9VEFIAF5rBcHtZ7ibrctdPROUQ
	n2fQZoWLwdKHlXlUdNJ7dyXw57Uwn6zDQJ57pkZht/RDgA7OdEX1AW60y2ONWLZ12jzlq79+SmQ
	==
X-Gm-Gg: ASbGncutMkNNCebEPiG/RVLUBCzM9AuR2rFVswrmb/+DqV9pHVjGY3L1qb18rWCfnXc
	dq4Dr6LonLnMksw+HiDL1Y8tU+JbeogZwoc7Nau/TEnT9t9dkRj10Ql7QhGabjwyzBEVHHQrX7/
	xfcSi2wLJHUiCW+pq44d014+fkWJyKS/fj+G0pVEBHRljjdYVlmY/rxuYTpYJyNOw1CKLC+kENh
	a2AbIrn+CckPBnNzSXiHQA7OIyR0RYg3AoNJCz2jSYwmBXfSapbrAsH+NqVlH8jPiz89RqQpfDG
	zqaSluCOyMpsY0eqvrIMKSsmkJJGupAI5SAffKE=
X-Received: by 2002:a05:6a00:3016:b0:725:e499:5b86 with SMTP id d2e1a72fcca58-7305d546034mr20917158b3a.20.1739158418676;
        Sun, 09 Feb 2025 19:33:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNWKz69WA1iDoZIkm4CPxi7iVaekbu8x2lRv9HMX2DcslnSjt1KSl9w6DbAHKm61c/erwkVQ==
X-Received: by 2002:a05:6a00:3016:b0:725:e499:5b86 with SMTP id d2e1a72fcca58-7305d546034mr20917126b3a.20.1739158418324;
        Sun, 09 Feb 2025 19:33:38 -0800 (PST)
Received: from [10.152.202.18] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ae7f84sm6511273b3a.80.2025.02.09.19.33.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Feb 2025 19:33:38 -0800 (PST)
Message-ID: <5eede3cc-1b60-41ff-9ced-8a75107748e3@oss.qualcomm.com>
Date: Mon, 10 Feb 2025 09:03:34 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Fix locking in error paths
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Bart Van Assche <bvanassche@acm.org>, Kalle Valo <kvalo@kernel.org>
Cc: Jeff Johnson <jjohnson@kernel.org>, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
References: <20250206221317.3845663-1-bvanassche@acm.org>
 <c9765212-bfb1-4b8d-80f2-7219bb4a7372@oss.qualcomm.com>
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <c9765212-bfb1-4b8d-80f2-7219bb4a7372@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Sqqzno2Neu2aLrGXiwyii02zoprXPuV4
X-Proofpoint-ORIG-GUID: Sqqzno2Neu2aLrGXiwyii02zoprXPuV4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_02,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 phishscore=0 spamscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 mlxlogscore=973 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502100027

On 2/7/25 20:40, Jeff Johnson wrote:
> On 2/6/2025 2:13 PM, Bart Van Assche wrote:
>> If ag->mutex has been locked, unlock it before returning. If it has not
>> been locked, do not unlock it before returning. These bugs have been
>> detected by the Clang thread-safety analyzer.
>>
>> Cc: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
>> Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
>> Fixes: ee146e11b4d9 ("wifi: ath12k: refactor core start based on hardware group")
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>> ---
>>   drivers/net/wireless/ath/ath12k/core.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
>> index 0606116d6b9c..212cd935e60a 100644
>> --- a/drivers/net/wireless/ath/ath12k/core.c
>> +++ b/drivers/net/wireless/ath/ath12k/core.c
>> @@ -1122,16 +1122,18 @@ int ath12k_core_qmi_firmware_ready(struct ath12k_base *ab)
>>   		ath12k_core_stop(ab);
>>   		mutex_unlock(&ab->core_lock);
>>   	}
>> +	mutex_unlock(&ag->mutex);
>>   	goto exit;
>>   
>>   err_dp_free:
>>   	ath12k_dp_free(ab);
>>   	mutex_unlock(&ab->core_lock);
>> +	mutex_unlock(&ag->mutex);
>> +
>>   err_firmware_stop:
>>   	ath12k_qmi_firmware_stop(ab);
>>   
>>   exit:
>> -	mutex_unlock(&ag->mutex);
>>   	return ret;
>>   }
>>   
> 
> I made the subject a bit more descriptive in the pending branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=09a2421b6e5f617cfbeab906fa8037dda4aa95b8

Better now, thanks.


-- 
Aditya

