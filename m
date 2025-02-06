Return-Path: <linux-wireless+bounces-18551-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4D1A29E35
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 02:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0361E7A06EF
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 01:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D0616419;
	Thu,  6 Feb 2025 01:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BfaLEPGD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E683010F2
	for <linux-wireless@vger.kernel.org>; Thu,  6 Feb 2025 01:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738804129; cv=none; b=Bc+4SK+/n5yBpaRBeKjilim0rfZiWsVXsxBHtm2hEz5BA36Dqe+ZpP+qq7W/+4SXAr7xfcIc/ufD3u1TBw3FuD5nVfplY+tsvjp7mVzvxRBXA7ADWji2fV2WbS0CcstAEc8iN6/hv5LEL9r66yxdhFsOR08mdcO84w6T/eenu3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738804129; c=relaxed/simple;
	bh=iAvnsgx6WM0pOL4u/dMvzG/d49L1lKyvqfbPo/XN9i0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iczccOeyvwXujXTdbjTqD6KOFQsbv0d1ZS++kk9WHSusQc9vmOIkSPxyRwH+i7mT6lKRBGj7Dw9nFbfB4fpTy5aOWWLw6UPQp3ZdECmcgIe8c3acV6gjD6dv5yBHpRDux3Itf+46qi7nM3Gzc6dqPcaD/ZA3sjXwnudm36xjM8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BfaLEPGD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515GNZK8025697
	for <linux-wireless@vger.kernel.org>; Thu, 6 Feb 2025 01:08:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lSKI5OTGEOmNuHcZ8xP6spzjksvlzMnal5VI6r0xExM=; b=BfaLEPGDiA8NUSnX
	1uBvJEPyZWhJLOEXs7xfbIhaTaLvMEscZYhMCjlPDpHGTVy3HjZiKgdBIpOnDkBg
	wTe9gb9s/W2DNLBG+WxPafs/ZhLFr1+b4pCT1r6qXsd4y2joOYvHd+DEIVvfs/lN
	cJqHDy92VtjK4y0gJzxHeYAo1aoP6hvmRY5qLpchPDbKC6sYvUufeVM3DUPjyVvX
	nVIDaiYn+1YfohUfTjRyxyb8On9YTFeVBHalzGWYaZMOfrGitBpyVCJZI3whWS5j
	H+WQqi3LNRua71XSPXAtcY+N2ZD/ttwjEjw1aDSvcu07u4M1PFjZtUBsl7JSA7P2
	fJEi4g==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44mbfh91p7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 06 Feb 2025 01:08:46 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2f816a85facso725124a91.3
        for <linux-wireless@vger.kernel.org>; Wed, 05 Feb 2025 17:08:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738804125; x=1739408925;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lSKI5OTGEOmNuHcZ8xP6spzjksvlzMnal5VI6r0xExM=;
        b=Vfn655UFTvGJLSk08JGxSfOTI5F9Q39us3ngb+FxdGHnjoAmykHaqAesDa37XncryP
         ipma8uP1wKGgTBc9Vy7L4BxKOeMGsP5eChg2fa5QuZc62QBjjyf8IwfFgT1R81EhO7kv
         PeHEusEHdlKeppylQj8XPZsXOAn7Wso2D1UlSkTKE9E45qflGfTciDh8ApouR9i8Xn+X
         a1AJ7q/Y0dgpZ66QgtOLb8dNmMi10oYS/hrWd4xVIqgu+CB7KMVIZ9Ehq3MDGq7EzB5x
         gGTdR4SB/CXJN88c7pL8MSP1DXU0cO4zIz8Z4srTm7ZYNIs5qB4jFfz8nvKgVe20JWKG
         lanw==
X-Gm-Message-State: AOJu0YxlYeL6xHuQuPtugUK63J+yHIyFMTE6GdHgkpX0XSAPCgg5nK/g
	SQE0DQKKhbFNJ8tBfNEtY3kIOLLZsmuYwxiDMLFq7/IO6ddlcuLN0zHk86hk1wwrKgz2dMxd7fb
	dbPfqQw5+fimDC/Rb0Y1TfhfWoDA6ZcSVHxfiJ4b4WDizR0tflxQOOXXCoRPgCpuRmQ==
X-Gm-Gg: ASbGncvLGb3PRjpLek+yjOpgL+8+ybclRM/XUOjejjC0cFTWFlu2cg4tkGuxo6CfhOM
	ad3cP/+q2kFiLjsaNngk9xyzIjZcqWvFKGCEUzjq7hZ5Jx/sjpHvS22BOp+njPNiobBq7unZHys
	uzMbuY758gEmwkuRa3lwzF1Yp/jWTqB/Dumg44ip9tr4iwvUnl7NsdalEQ+B0qOCNAhEEOkyTiA
	WB6PfvktXQGYPYfcRhGJaKCFVMR/XZxWE2x1aX+eoPySDpifKrFwDaThiDiLb9f+cdldSeHEyfP
	qQ4BNYD3A/3mm3OtX+fMKaAl5NuGGCou5LfGtKEy4vaOVAhfvG3TEL0NLm0GPTlQrLUB1GFDuw=
	=
X-Received: by 2002:a17:90b:4c4b:b0:2ee:a6f0:f54 with SMTP id 98e67ed59e1d1-2f9e076c892mr7798302a91.13.1738804124946;
        Wed, 05 Feb 2025 17:08:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFuAT3KmV1QhMxNYRxDWR1/Y1QEtRgjBu7SdPS/4gE7rOYEHur9cc3LT1ThUP5CPqKAJxAMOQ==
X-Received: by 2002:a17:90b:4c4b:b0:2ee:a6f0:f54 with SMTP id 98e67ed59e1d1-2f9e076c892mr7798269a91.13.1738804124549;
        Wed, 05 Feb 2025 17:08:44 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f9e1d7a5acsm2335028a91.14.2025.02.05.17.08.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 17:08:44 -0800 (PST)
Message-ID: <924677f8-b1bd-472d-aca6-60d23899e455@oss.qualcomm.com>
Date: Wed, 5 Feb 2025 17:08:43 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/9] wifi: ath12k: Add HAL_PHYRX_GENERIC_U_SIG TLV
 parsing support
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, P Praneesh <quic_ppranees@quicinc.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
References: <20250204035718.3227726-1-quic_periyasa@quicinc.com>
 <20250204035718.3227726-2-quic_periyasa@quicinc.com>
 <414ca414-d6a4-4228-acb3-dde4bb71624d@oss.qualcomm.com>
 <0f7885ad-a360-2ff1-eb0b-51454de2eeb0@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <0f7885ad-a360-2ff1-eb0b-51454de2eeb0@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 9M_ZW0Q6dTpaCVTejkjnjDs-VwIm4L6r
X-Proofpoint-ORIG-GUID: 9M_ZW0Q6dTpaCVTejkjnjDs-VwIm4L6r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_01,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 mlxscore=0 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxlogscore=923 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502060006

On 2/4/2025 5:02 PM, Karthikeyan Periyasamy wrote:
> 
> 
> On 2/5/2025 3:59 AM, Jeff Johnson wrote:
>> On 2/3/2025 7:57 PM, Karthikeyan Periyasamy wrote:
>>> Currently, monitor is not enabled. However, in the future, the monitor
>>> will be enabled. Therefore, add the necessary HAL_PHYRX_GENERIC_U_SIG TLV
>>> parsing support in monitor Rx path, which help to populate the EHT
>>> radiotap data.
>>>
>>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>>
>>> Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
>>> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
>>> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
>>> Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
>>
>> Normally your S-O-B should be the last tag. Any tags you collect should come
>> before it.
> 
> Oh my bad, if you want to re-spin ?
> will fix it in the next version of the path.
> 

yes, please re-spin

