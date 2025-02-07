Return-Path: <linux-wireless+bounces-18609-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE942A2BA75
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 06:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8D3B3A6C30
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 05:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1757946BF;
	Fri,  7 Feb 2025 05:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M1jSB7qB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7242317BA6
	for <linux-wireless@vger.kernel.org>; Fri,  7 Feb 2025 05:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738904418; cv=none; b=TqvJsb74BskfohH128ksNqbBuV3IFcxIUL2rPtc1a3LCX01tULyHjzHMsQU3b0NFmEQOZbbD3CqR1xFSlWGILN3+rEQk4Qg3m0io6ElLMM6N24od+TPcIH+hCq/KIXARPnFbzItnHQNw5AMgUxReYCPNdCdZuP445EY8etauxt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738904418; c=relaxed/simple;
	bh=AWxzJnpmI6zeCn6LL93Ae4efvTHwya6vTHJDL7So8gs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VPNytJEwWT7IYffdeObJypaTkWyOny30poPQkdeWSTxi+Eu2fzaMjmTJ41UMO0HhPuzpulXuTcsYCpqiDGcptDx58x3PagR4pfhqKyZnJnDWy2RPkKB/mKClvzgJNwt8ZRJpnROVkpmUUSmslANlas6/I3NyMbT6tPd2Ert5hXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M1jSB7qB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5171PLt3028549
	for <linux-wireless@vger.kernel.org>; Fri, 7 Feb 2025 05:00:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dOzuZc8iVwPZwJIc+/M02cfHSRfQBgPrYnVNLWwSnf0=; b=M1jSB7qBk5goec8T
	GQOcg7Pu8iGbWO9nu5LL28stvOG/BdilMv5LDkp/GtCTnxQwQHvVNRQUhmb72Oor
	TVjjzgbL9CwccGcAIzla52NZ8oVTozF0CiXX9op6qtdEHXBr/5cmA3tKh91Sr3RC
	87rvCAHpCplJ1tM/2gOwc6HCwq4vZd6CuCfHMyaaib/jMhbtj4OBoEpa0cEqorc1
	AASeeXXsYQ0eg1Erps9Q/wQK7LSwu8IKjJAiRZ09OotZOtR7cLFEcMLfsBPyGzJN
	c3A2/Db36NU4Mv8HLG+jH5goSOj5002TkNoFrQTMtiAQCTTbJzDt/n/irpy4P/BQ
	rG6C6A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44n7p7rh4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 07 Feb 2025 05:00:15 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-21f022fc6a3so36487625ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 06 Feb 2025 21:00:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738904410; x=1739509210;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dOzuZc8iVwPZwJIc+/M02cfHSRfQBgPrYnVNLWwSnf0=;
        b=j9dsxNejpr+ykn3Z+g0ndOsl0c43uIniZtE0Nh3wHTqpFW5vZuqG2kQ7T37TjLM1nI
         8eKt4z6LX/NKqRYexJpEqHOGZQtvzCj0YRMNm0zQmRYIXxeh6NCje1KKQfeULQAtkrta
         B1WQiY1ewqx4OQtF0JgEJkYFgdYiUPA5qUsJTZmm3m1Yelv2GmQtpOvHcP01Ku4PEEqx
         VUD9qQE3094um+aASBdP+P3PC6YKPtoC9itXwocGuJSZAcMst6xsJ7LkojMWoOUPR72f
         P1gz+iMRWFHE2v7sAVnXF8v+1kTVL43sqWCb2rWIM2oMoFU/vjpF3rOg/hAABMCpuC/7
         p8ww==
X-Forwarded-Encrypted: i=1; AJvYcCUTyClKf4PSmd0aYWIKcRoyYZXIqqSGfjywDgvmTC8tYJinR3jA5ZNRGmh99nrv/pFz4Vvx5yBufWTpPFsJ9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzL4CB+tly8OtWiWZkvaYPBdR/uYG1r7NDSu4e16/tp/iEPSUri
	6/27A6cWOQnPigNmnz96K/41PL9d27Wfo022jSS+rCJVtCpWd8uyu4XJExr/6+3HOM4yxhY5rZW
	UGRdgnzmpsr8eNem9BdU1fBSczvHaFmzaPjPHm2Mk0+rpbtZIGnRc84z002j3bLkW9g==
X-Gm-Gg: ASbGncvCEa/MNfv5jcBexIrA566k0BERUuhV6rb5Ru3qhd6ePG+5mX0kU+DEn34YQws
	AoSarZ56w6I0xw1oaAgHz5lVgwhRabGNEfOXbIlYL+aIRB79mqJnDlEheHmNDk37CIm9Ib94ye2
	ravOYDufrIgB1uU1Gi21vvqCr3u26qC/LwyVL4wb3897SehFOLVnXhsCUF/wJqX6M/vthfh7fk0
	2k3ISUJuuemk1AOq83tTqW+MtnEw8LpojWGxn5W8fD+Y7L3eMcTvennYFFKe+VWlC1ZI5IDPS8Y
	/qufuEiu3oAOVmTQCpQ9ltAReJzoLztdbAujTcE=
X-Received: by 2002:a17:902:cec3:b0:216:4122:ab3a with SMTP id d9443c01a7336-21f2f1376c8mr95105155ad.1.1738904410216;
        Thu, 06 Feb 2025 21:00:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3I8kg0/wWJ9yAjmoEI9x+DgbR4cjYovakozwhpNH6aeEU/frAxeCztnalGWo2qYLs4bvgig==
X-Received: by 2002:a17:902:cec3:b0:216:4122:ab3a with SMTP id d9443c01a7336-21f2f1376c8mr95104675ad.1.1738904409767;
        Thu, 06 Feb 2025 21:00:09 -0800 (PST)
Received: from [10.152.202.18] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f36552068sm21477785ad.87.2025.02.06.21.00.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 21:00:09 -0800 (PST)
Message-ID: <4df3ce01-64f3-4115-be6d-c84160b8dbed@oss.qualcomm.com>
Date: Fri, 7 Feb 2025 10:30:05 +0530
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
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
References: <20250206221317.3845663-1-bvanassche@acm.org>
Content-Language: en-US
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
In-Reply-To: <20250206221317.3845663-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 73HuzM8B0QB3SaM5mAnaScPpMZ8px2_E
X-Proofpoint-ORIG-GUID: 73HuzM8B0QB3SaM5mAnaScPpMZ8px2_E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_02,2025-02-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=769
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 clxscore=1015 mlxscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502070038

On 2/7/25 03:43, Bart Van Assche wrote:
> If ag->mutex has been locked, unlock it before returning. If it has not
> been locked, do not unlock it before returning. These bugs have been
> detected by the Clang thread-safety analyzer.
> 
> Cc: Karthikeyan Periyasamy<quic_periyasa@quicinc.com>
> Cc: Jeff Johnson<jeff.johnson@oss.qualcomm.com>
> Fixes: ee146e11b4d9 ("wifi: ath12k: refactor core start based on hardware group")
> Signed-off-by: Bart Van Assche<bvanassche@acm.org>
> ---

Reviewed-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>


-- 
Aditya

