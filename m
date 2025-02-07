Return-Path: <linux-wireless+bounces-18635-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84421A2C696
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 16:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1A963A64E4
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 15:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABDC1EB193;
	Fri,  7 Feb 2025 15:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GcDIFUOQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00C3238D29
	for <linux-wireless@vger.kernel.org>; Fri,  7 Feb 2025 15:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738941066; cv=none; b=f03EIZ5Fk8PNbO51ubd/Dm0bEJDwUiMb5l7wdJCl+tExxRa2JEO5R2KmWeE1gti9lw4HZckudNNfdZHXacfhV3moYDmYqVqja9V2hHwFWAIhPfKv6X98JI90FySrfACv5eZdTSkgtv7ElY+opXxFsQV3xa1YfPgvt6sAz0qAKKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738941066; c=relaxed/simple;
	bh=MS5Ft81073oPYuqXfXPP6AZJpPawgA9sKN0pyM4ExXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ih7Aww9WJFzbJKcncpbZ5cbgRffh/KvvolZ0aTpIDDePF3h6lGtvesulM/V+tJD47VNyKdmuFEn3HRVT/RCM7Qr6KhxooovPycLzNtXEvQWYFjWqA2LQ2pM9TuCQsuEGQjxVj6oMqzghI5nzePCMGbsmEBWVuD+tl3y6I34sg8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GcDIFUOQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 517BNbxM032209
	for <linux-wireless@vger.kernel.org>; Fri, 7 Feb 2025 15:11:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s+V+JgQRCYKhXRFEasqcCrnMZZS1Hps/NSFCEiIsHng=; b=GcDIFUOQXQ/7X2jj
	qHiXCoqWefhgoxxmp2nwgUy44rNzTodGlt4zJfKr6Wc+zlxhHfdhEJeGNHkA4/79
	ozS+omBU3nNEU6etagUYuc2xOs5tfBkCNjUYmJKA83bez8HpuPKpjMrMcdYYAbVb
	vH3n3AwzMZA4ythBKbBMov6f458KHpU+qVf03dAoqluv0kYtcR0Kwyux6pY+66PH
	EoTpY6/DN4xDEcro1vDIrizlEm6cBnOfRXEtT3UauOzTjptSeRR2pRaQx67U4evF
	AOOoc2MjNJFOWMIa/ZdlCAnGo1RXrMeZrXUFOmLb7PPWMcuDoUr6+AL9Dj1ZEQMn
	TiH7EQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44nh8urj0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 07 Feb 2025 15:11:00 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fa3e1f08a0so185413a91.0
        for <linux-wireless@vger.kernel.org>; Fri, 07 Feb 2025 07:11:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738941060; x=1739545860;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s+V+JgQRCYKhXRFEasqcCrnMZZS1Hps/NSFCEiIsHng=;
        b=ksk/toH294AY0Z53XZVPY7yENv5UVLzxORJpWpOaiKpLWjoi+LsqeoRl8SKiOl1Umy
         OQ7mBw1kys18ip97zGU0LGYa8UP4vCIbj20z3m8X1qToCQYdudIGHNzVL8jdx8BJNz+W
         BNjuzOCWIlfwpRDIvGC6Y9CqrF7A04A0W4gxYOxxURq3TfUNDMYrnIEPzHjw8Yiyum+c
         irArdx85GV4LpdqljhAehKuhJdJgk93uvSv7FI2AfF8JTkOemBmYhksWE9+69cfgxktA
         5X4iEHplf/EupNlJO+KjDcbLVjSF3OPhIPe01aIGL8RUXGjgsSnHbI8S9FipVBqRu24L
         WNpw==
X-Forwarded-Encrypted: i=1; AJvYcCVRsCuY5pvW89TMPLQqzzsUnuX6o6mmijXVysJ+rwV4qgBKKiaORcDMsLv5BSHyP1DASkaAA/nfofqjIznILw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+vOjmpoOQuQjwHuf2nbjsb0gdzgv8dlSMPJiDR/CKKAp8pK02
	AaA+h6X3swSba0u5aQKfU2fyGYhObvOJMy01rkCovYlE1LNWMHmtCEpAVGGoXHkiGj8MElF+sVD
	ODTWxGsDaMEXQiOr0Nk++Nnn0j32n7wJvaZwLry6c4X/8saW4aCVnks7sBScL2WJsJA==
X-Gm-Gg: ASbGnctAPiQ3kQaqVdgOpsNp3tgQMwGrvfGFhZV1nIqNUxjr4bRr80yfiXZhQ4QA+t7
	dMBU55f82/VYfF5kuS2/zg4kKk8j/Kmvd0Z4gsCf9fcmJ31QV2I6kuw5yMw8+Ep+nH9AuL6SUqD
	Uyx2viIQaXa5yXtCBvYSW47XoBrV4U1WScjzUI0+eFgwyzQ8yLfwTAz1qiE1PjKV80CG3Tx4ZFH
	LZZibYABoNzKVClhIu4CgyndWoTqlkvbJRRUAAIJWIWeM4ZCrGKuibom/lSGxOGrVWzYOttfENd
	ShMIcp1sgHi+sVTLFBiGPR2xz+EYmuXUFSTDUg8u7QSBgTEaZVSSFtP+zN0Y/RpPusKdh4hjUA=
	=
X-Received: by 2002:a17:90b:194f:b0:2ee:59af:a432 with SMTP id 98e67ed59e1d1-2fa2450985amr4857276a91.31.1738941060004;
        Fri, 07 Feb 2025 07:11:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErvSX5l9qRiKdHJ4TV8ECcN8WrvQ0HpuAnUPpHdTx3VdptMOc+XJf3yadFLmyIP/yfAMO73A==
X-Received: by 2002:a17:90b:194f:b0:2ee:59af:a432 with SMTP id 98e67ed59e1d1-2fa2450985amr4857234a91.31.1738941059579;
        Fri, 07 Feb 2025 07:10:59 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa0cceff11sm3400012a91.10.2025.02.07.07.10.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2025 07:10:59 -0800 (PST)
Message-ID: <c9765212-bfb1-4b8d-80f2-7219bb4a7372@oss.qualcomm.com>
Date: Fri, 7 Feb 2025 07:10:58 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Fix locking in error paths
To: Bart Van Assche <bvanassche@acm.org>, Kalle Valo <kvalo@kernel.org>
Cc: Jeff Johnson <jjohnson@kernel.org>, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
References: <20250206221317.3845663-1-bvanassche@acm.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250206221317.3845663-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: HP2NZeuu2rTBz1HTw_aUkHqDs1hGgowM
X-Proofpoint-ORIG-GUID: HP2NZeuu2rTBz1HTw_aUkHqDs1hGgowM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_07,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502070115

On 2/6/2025 2:13 PM, Bart Van Assche wrote:
> If ag->mutex has been locked, unlock it before returning. If it has not
> been locked, do not unlock it before returning. These bugs have been
> detected by the Clang thread-safety analyzer.
> 
> Cc: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
> Fixes: ee146e11b4d9 ("wifi: ath12k: refactor core start based on hardware group")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/net/wireless/ath/ath12k/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
> index 0606116d6b9c..212cd935e60a 100644
> --- a/drivers/net/wireless/ath/ath12k/core.c
> +++ b/drivers/net/wireless/ath/ath12k/core.c
> @@ -1122,16 +1122,18 @@ int ath12k_core_qmi_firmware_ready(struct ath12k_base *ab)
>  		ath12k_core_stop(ab);
>  		mutex_unlock(&ab->core_lock);
>  	}
> +	mutex_unlock(&ag->mutex);
>  	goto exit;
>  
>  err_dp_free:
>  	ath12k_dp_free(ab);
>  	mutex_unlock(&ab->core_lock);
> +	mutex_unlock(&ag->mutex);
> +
>  err_firmware_stop:
>  	ath12k_qmi_firmware_stop(ab);
>  
>  exit:
> -	mutex_unlock(&ag->mutex);
>  	return ret;
>  }
>  

I made the subject a bit more descriptive in the pending branch:
https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=09a2421b6e5f617cfbeab906fa8037dda4aa95b8

/jeff

