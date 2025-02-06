Return-Path: <linux-wireless+bounces-18602-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F524A2B125
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 19:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD4863A7EB4
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 18:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73B41B0421;
	Thu,  6 Feb 2025 18:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="inXkckgR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318C619DF8C
	for <linux-wireless@vger.kernel.org>; Thu,  6 Feb 2025 18:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738866322; cv=none; b=EtSBYiV0/N890sZSmMptGyyHk4DBTAsrtWGWDkmtVDD4naVdF9mNK/wRnShZVe0r+hm2hjJ+jStzTKyVBribhoCIjLJYq4o0wfN8849DieiA8ug9/u7m89/6CePPx/CLRcaIpHLMwq1ln1Rz9ChbEmw9mo6lTGFLccknCFgWa84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738866322; c=relaxed/simple;
	bh=2v6Pb0UuJAp2Ce7J2wyIxsh4DuptF5KuiHw+d0TBU+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sqQFwR/7W4rKeVNH3q38IiizywZ4I5SUur1DH8Jgj/UybqRL/rCjNxPCpP6NJFiwObHrN6W89tVTS+xLebVKGPqq7diFAEc+c+V8dNMqKQCmopEklsKPCj0TNMfGApstlnaWW+3lfqdTbRftTf54MLnbqeq9K6553FnzwSKoXA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=inXkckgR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5169ncLa016821
	for <linux-wireless@vger.kernel.org>; Thu, 6 Feb 2025 18:25:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1EcH+wIk7SFlGrV9UWgKzwu6ZI6nYNoJsT/9rUuTdgs=; b=inXkckgRmSRB53rF
	tC9nyODSpmG2UQf+wXe182R70SDgJSMk/qYrSLNZh7qAVdFQ8JjARWyMO4k1H/at
	jtAWXXymYXeikCiEDkOPcjmYgLXgEAu4OgqlAF9zP7cRXvynElCSbLkSfmnAU5cZ
	DXKIfciB6Q3vW2tk5oz3oV0NN6m4MKK2/nWylSjgXlD0jHrWeWzWVqDds7q5Udn0
	nSwuk3O/GSqsv8xtX+G7ZvTe2ci0qn1AG8MG9nLHkextSGOVhLHV/NqElA1Nfrta
	j4elcG1sB+dEg/B0NAR0Q7c5nheJUPzaCGnL6NwORe4cxDgIC6F3s8K04aUvGSon
	BYruZQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44mtsa1931-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 06 Feb 2025 18:25:18 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2fa1c093f12so1003807a91.2
        for <linux-wireless@vger.kernel.org>; Thu, 06 Feb 2025 10:25:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738866317; x=1739471117;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1EcH+wIk7SFlGrV9UWgKzwu6ZI6nYNoJsT/9rUuTdgs=;
        b=Zf0fusc0ccVzuUsLzndcrHo1oAc3Vjd7v6YVAb3Xs5zp6ol+T6q+laDGGcmnsHppzJ
         5Hw3reFnIfZgZBZdy10eTnaqIs34lskzxrdk2IENLEvMAj8hDJAd+jpcBu+khyp+in2k
         /ac2y3+t0P5h1oWtiP5qFZe1N6f5nrVi0f9xCgx0HKdkm/7eTdeyVF1YREcy0x4iA0b2
         LP9DNAeoDp3Xg8NbL+NmR2cSc/hgIgTek+qmLkGmsT5iAr6wxuZkOLuEPFMYKDyn9SQd
         UWIfMPpWKnuvwD/PJ1AcHahTULdIqyVU+8e4pospJczyKi+4KJzyQbRFKEyF2yaYUOAr
         HgzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtUqDhSg9D4FgQEfyi7WL3eue6RJmgsTNbNwhS6RPxgY+hy+lN49A+UAAzVM+365oC3q4JKKLObJS+fKgsRg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwS3VbfJKvEPnpSzoSMv3lOBvE4R+lZTTU1XngD+22qRsBZSqy+
	DZeSiZUUgGe5koAX96GXSb47DG9vD/67fi15edGeNkrT5Uq/yXGnSGGMVGS02c/oysUfnN59Irf
	sZavKQOC1ddEQSTyBzTSfRhooROD9TwWGmX3wiOEsHaTHbckBQh3nNdoNXospG0+Ysw==
X-Gm-Gg: ASbGncv5XT0HocNWd9+Dt5z+fwrIOM4saaqTNv1CEIk0MeqthIajW5IvMUpVbMAS/SO
	mN8DRPbLbHq9VJcHsGT6z5SQUklB0tLeKztsGdfht3e7xKFKi6Vh2MtYMcOAfZ+jct+cMxXj/mX
	DV69kbbzKgKeUJqOyA8EZVSifE0kz3Cf9y2bfy5VUjcXbDRcgT1B1Lh990loFQ7yxlS9apEvq1d
	m3/sFxARdWkrJp9/ARUEOco4B/VU/AMBiHlwPV2HZ9QzBNHRNQusomk3LREM3RNw2T0785g4uqW
	hlyHlOi7gZEIECuNG4sL+f+1Ip01oJBIrUdcF5+MIzeDH4zyySKhcmhpDu/T1jU9mgZMWO2V2w=
	=
X-Received: by 2002:a17:90b:4d81:b0:2fa:1f1b:3db7 with SMTP id 98e67ed59e1d1-2fa24272512mr75659a91.18.1738866317544;
        Thu, 06 Feb 2025 10:25:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHciBvji60FFYNw+wOe9jHq7tipWI0mE+EGPEF5DfFHGH1ACVXasewYAUw5HrXPa8KOxve6QQ==
X-Received: by 2002:a17:90b:4d81:b0:2fa:1f1b:3db7 with SMTP id 98e67ed59e1d1-2fa24272512mr75461a91.18.1738866315693;
        Thu, 06 Feb 2025 10:25:15 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa099f4d6asm1727996a91.6.2025.02.06.10.25.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 10:25:15 -0800 (PST)
Message-ID: <7633c19b-2aab-4f2a-8c11-27425f7299ae@oss.qualcomm.com>
Date: Thu, 6 Feb 2025 10:25:13 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 25/33] wifi: ath12k: Fix locking in error paths
To: Bart Van Assche <bvanassche@acm.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marco Elver <elver@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>
References: <20250206175114.1974171-1-bvanassche@acm.org>
 <20250206175114.1974171-26-bvanassche@acm.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250206175114.1974171-26-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: H1cVo9jPuMzk0qoxSB97DNXX5Zlf9w0c
X-Proofpoint-ORIG-GUID: H1cVo9jPuMzk0qoxSB97DNXX5Zlf9w0c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_05,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 mlxscore=0 adultscore=0 bulkscore=0 mlxlogscore=809
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502060147

On 2/6/2025 9:51 AM, Bart Van Assche wrote:
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

This looks like a legitimate issue.

Can you submit this as a single patch and cc the ath12k and linux-wireless
lists (as I've done in this reply)


