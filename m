Return-Path: <linux-wireless+bounces-18371-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D7EA26B16
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 05:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B9F33A5989
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 04:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADADA1D61AA;
	Tue,  4 Feb 2025 04:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q5rlJZej"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390D41CAA7B
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 04:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738643074; cv=none; b=oYPk5GJUsoita+menGNc9lYuXVNE4klMakX4PoL/1k7n3QCC3bih3cioXUdFH/d3M+2ZT6cXnJ2zcjqZSQUeQcsEqWUADe29ZhlLFUHffBALkgFJeP/T73WFbDkr/1ffxk28aul2T8FvGKrD0fTTWWYV4T3viLrSTD0isEDW3BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738643074; c=relaxed/simple;
	bh=zyMGUtOvHE/27bNpd/8Jx/1sIRpWXV/QR7+URJyNcAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TSFI1X43HSiK1p3s66EvyV0ZCXhKQjL7RpBhimwgmdGfh81RYn5BH3isPKKF4xONLRr9Nluz/XsyO94YZJAT8oxelLTroc4bBYwCCtz6HCpaVyi1R+x7u2eZHnopJUmJZKGt06H776xTPfDlIC4itqXhi7WQTLaYesqpG68YxJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q5rlJZej; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513KQuab027347
	for <linux-wireless@vger.kernel.org>; Tue, 4 Feb 2025 04:24:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZjxET2Z5D01/aa7Lq4W4LN+bJ62d77wfUR7CBRvupO4=; b=Q5rlJZejubUt9ne5
	jY7glDqj+MIeS9C0XjmfE7kpTSWbhz8DVNJWVUfLNBimHSyUSKpNqumin4mepd49
	CPuTHanqnqVtuMsUD3Fz6mfR+WhZfDjRsVjFMHPSBMtYd5/nmlxqymqaCzJqVjh3
	HbFOJV0P4TFzL6MMiDpYCfZxkbqK/MmRyFXVbgbLpvNCbPZ3d+JhTbdnEuRoW1px
	ODId27ciu7mXTq678n4s+u2euV1XL20+WpZ/lCSHcV5/lKWBxSiGYGK1aKFlApXC
	Jfwlj97fcWYgmGHnhCJbnsgNI4OVHkWD/frPXqlhtvk/5ox60wU+PqLmZGGLXNpM
	tCjrhg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44k4ufrtf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 04:24:32 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ef775ec883so9669195a91.1
        for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 20:24:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738643071; x=1739247871;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZjxET2Z5D01/aa7Lq4W4LN+bJ62d77wfUR7CBRvupO4=;
        b=RrJtc+3r2+rt0uQPDORzgQpTakvwtb09nTp++PA3ESq0lPcGDBlM3kNFURFHaLysI7
         PPKMmYl7IPDqZx8dKD6KGiBOfcvoDaIPpxW1gF/xGkT3aOOgkBArM2XRFCoVFa/Eu1yi
         PLMYtWp1SOpVQnRhARDbUwUJiy1JqLcW6ON+2vchTMO8Ayji9R/uG2F4/DTkvBmDG3KO
         F7BfTZWvlPimVIQOnpqD5LcBKhDnxcCO26el9DjBEKZLQ6W8vN7uN08+ty5K68DCq3zl
         jA1CTu+U/YEBwQnxvClKGKsq9UCXouVmLB3lkEaENsOIcMY30A2nsn03JoOsJJk55X+C
         FJDg==
X-Gm-Message-State: AOJu0YxAecrBrMuuhoRLU3piQYpHzCLcT3YF5rEiR1guB8Y1lw+lmMyE
	hag+R4L+2kBXf/r+BjogVfumEPaPCNGQ1fC3sEYb8FmaEwJVcS3LG0GvyyR85Rdqz4Z63a8tPNV
	HPKhr+4liVojH5lyyPRu26JY4K41+oPd3tNiyA5TtVtD0VzWVJqW5solVpwqs7vFau6QoU1WTAQ
	==
X-Gm-Gg: ASbGncvsgG6CFaPcb9FU/oshjTQjO0gQb6dKUVCXOMjHxRdPPmpkgt6nIHMm5MZzlnC
	ufTX36NeygvwPJC4kXSXStVxuwekh3EBCDsR2pJkX3hhHLVXsQn4+hKuJd1bKLlxt2j+80pIBZB
	0H38FKXYXsdokMqQslZBLKoxk83qnFkkPtE7oO2rUMpFR8+DdgNhoXA45tImdQ5je09cByLf7/j
	gLLIZHD75wtNFzlR7ccA4yUFz+wHMF+Zzv4xtkmtaP7zFuK1MfJ6mm7IsyQ7T2Ug6TyTsjDBkqG
	5cTgbbhRSF2sOvR7E5iS3raaghA1eHvbjhxUvM3nnbCnA7ieWx+BQHKDa/QSa9ZdKrlHQr7u1Q=
	=
X-Received: by 2002:a05:6a00:3cc1:b0:71e:6c3f:2fb6 with SMTP id d2e1a72fcca58-72fd0be187dmr41881610b3a.8.1738643071173;
        Mon, 03 Feb 2025 20:24:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHR2b/aiu9zCPPol9JXpjxw1ZRTYbUh/t1axDFOT76fDgBs6WiaHm5jBawrXSRLxAhsIEGyiQ==
X-Received: by 2002:a05:6a00:3cc1:b0:71e:6c3f:2fb6 with SMTP id d2e1a72fcca58-72fd0be187dmr41881574b3a.8.1738643070650;
        Mon, 03 Feb 2025 20:24:30 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acebe856915sm8819450a12.38.2025.02.03.20.24.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 20:24:30 -0800 (PST)
Message-ID: <901a8947-c11b-4d0a-9cdf-93c5374ddde1@oss.qualcomm.com>
Date: Mon, 3 Feb 2025 20:24:29 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/9] wifi: ath12k: Add peer extended Rx statistics
 debugfs support
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250204035718.3227726-1-quic_periyasa@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250204035718.3227726-1-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Y7bk_3MnKievp68Wv8c3vywVqiM5P3GK
X-Proofpoint-ORIG-GUID: Y7bk_3MnKievp68Wv8c3vywVqiM5P3GK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_02,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 bulkscore=0 mlxscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=835
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502040032

On 2/3/2025 7:57 PM, Karthikeyan Periyasamy wrote:
> Currently, peer extended Rx statistics are not supported. Peer extended Rx
> statistics are collected form the TLV data reported in the monitor status
> Rx path. Therefore, add support for TLV tag parser handling and debugfs
> to configure and dump the collected information. Additionally, this series
> does not impact the WCN7850.
> 
> v8:
>  - Resend due to missed patches

you had received some Reviewed-by: tags in a prior version.
if there were no significant changes to those patches you should have
propagated the tags.
if there were significant changes and the tags were dropped on purpose, that
should be mentioned in the version history

/jeff

