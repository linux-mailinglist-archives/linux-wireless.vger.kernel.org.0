Return-Path: <linux-wireless+bounces-21304-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08134A81D76
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 08:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0EA31B80080
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 06:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE5419C54B;
	Wed,  9 Apr 2025 06:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YAUkYrCD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247FD8F5B
	for <linux-wireless@vger.kernel.org>; Wed,  9 Apr 2025 06:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744181399; cv=none; b=p8Ny50XXhkzlUAVQgA2UT9IKLcVxuBucOhifvl9/doU8EdqFL/zt0vserFtxqe0KOXrIWl6DqiT9nxlFypymWXJe42nJjVQqpj7nKBDCR+Cs7MyXNYrmmLFH25YSU8P62Pq0sYTM6ArTEMdwc1WWk1+9/IPw9XtXub56VPnD6zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744181399; c=relaxed/simple;
	bh=AHzAtPfLsyA5qOLFByjGfzmnWZgXaS5wY06ARn0YXxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VYvdTolqWQf98ygMTzmNzyhEkV36rL9UeAEJ0kCY3VkIwRT9LISGltuRPMDuHw16hWeFtDAqYHWqgjyxKKKx6vRwp5T7KMWy1+b9c+RogkTOx/5+mSy9hYxohv1ByeiavI1UMUIG0XLw02vQb08KtaVlZj9xUAfBAfhyxQ2nf3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YAUkYrCD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538JZRGW002911
	for <linux-wireless@vger.kernel.org>; Wed, 9 Apr 2025 06:49:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/1X6BikGeQC9ltRy8Ygd8U3o4+vQ/nGrtJz0JxdCpMc=; b=YAUkYrCDA6NhWrHF
	kfZXM3EcUsWbyCH6xBfTA4QSvtpu3vir7HZIAjfCzsZJKuLWaS1FokaT4kMsqkxn
	VEWZJfpN62v8+M5XofIB5BT12d81jCjyf5hgyKrBfQa5s0lfIqBOzkVE+ySjCeJJ
	BrmJ+07bZa/bntxX2hYRfvNFaS6bquGw4EFerJkCUwkL5vFhYhbI2AfiIex5Tnm2
	RWsPI5ncrRknWK7vjWLZRKS+NzVWifjUNSCS02Y4b5I4EwQuAxOC2eWQZCY2YxWe
	Yq1vC3FjBB2kUZlKMs30uJb8qzYZ9rlt/r1vEgxJji+bfL+on6Y31SEJ0W3ghlsc
	KMqCDQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twc1j88u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 09 Apr 2025 06:49:56 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-225ab228a37so58319255ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 08 Apr 2025 23:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744181395; x=1744786195;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/1X6BikGeQC9ltRy8Ygd8U3o4+vQ/nGrtJz0JxdCpMc=;
        b=TWed9baAWaZvlYPQsu4rJoel3Et8C0VYDCxILKT+KqeO6rGlU/0A9iI0bqDmC3Ucwv
         xtOH38/9YVOaYmYNG3+KYRgvGc3iZIyRMjkbyDVmLnaW4/j/ibc+JojMvQaFDGbTTDn/
         oHqNE01R8UdAk+0fBU5pooIEjMxYoXckuw2SxZAHDok8sYcHvCPnFF2wuZrij5GlBL3A
         oBVlfpeatpdHuMIgkpAi2oNLj3O0GVx/sCUnlAzjP1YCTu/LMY+WUpEsu1XJdNixwOgC
         K+SPO9E02qn1aGdaylDyGnphrht5cLNxEnaIKeBabHxyegl8LHeC87HELyryqE6WJfNH
         PtDQ==
X-Gm-Message-State: AOJu0YwBhONqtzGkOoXaySngz+YUUkzm6ckyxR0ddxorcl+CwvnMzQB+
	1Y2aSpqJVjjpQVgRfBI8WfBgSzEFt9Zo/ttwfcWZggW6ITbsQ2VO6Hztqcr1jsLgsr0StFMc6gi
	vE+VyjbqKYDCUJLMmHyBgSR0YGXHi1ErTMKVTYIYJLXqLOPWXmCf3X9kmnHBvuDJvEg==
X-Gm-Gg: ASbGncuos49Cr2ORzpUzoCViJ6H9Lmc/Xu29jQ0pmz72ILWWOhw3zzOqhYLuKUotHFI
	6KNRXkXB9wSFnMx2wLxu7FkT94FR0EOsz4mCoFoK8enAOEVAf252n4mF2uXuGaa6wQzt519ulHw
	dNofik2Wb3B8pexEGS9Q5rW2d4h723MmFUJQ6/5WFsXJI3i53MH2wjO/cbq9DeGZ7o+Ys5MFJUl
	A6JJVySoQcO8U5GP1JKa9/6Uqu+Vjy+APQ9ugeOOBic/pnVdgnK/bob95jxtSGKSOz1yobLH7Qd
	XNLkbVsqai6pdrDGT2+BDWxoooCu2tW5j0szfSCbtw4+ftSRLWZtHQ==
X-Received: by 2002:a17:902:d4c9:b0:223:3ef1:a30a with SMTP id d9443c01a7336-22ac2c266bfmr23569705ad.45.1744181395564;
        Tue, 08 Apr 2025 23:49:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHFwN1/kCHRF5sXa5SM37WwiipqMAdARvPFhd5rtpSdJKbrCoft3tNyz1ggfv85MoIGpUZSA==
X-Received: by 2002:a17:902:d4c9:b0:223:3ef1:a30a with SMTP id d9443c01a7336-22ac2c266bfmr23569495ad.45.1744181395147;
        Tue, 08 Apr 2025 23:49:55 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7c99f23sm4308925ad.154.2025.04.08.23.49.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 23:49:54 -0700 (PDT)
Message-ID: <b9b89ff9-aa34-aeb6-53f5-153c87f8ef4a@oss.qualcomm.com>
Date: Wed, 9 Apr 2025 12:19:52 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next 2/2] wifi: ath12k: avoid multiple skb_cb fetch in
 ath12k_mac_mgmt_tx_wmi()
Content-Language: en-US
To: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250406092214.3602182-1-rameshkumar.sundaram@oss.qualcomm.com>
 <20250406092214.3602182-3-rameshkumar.sundaram@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250406092214.3602182-3-rameshkumar.sundaram@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: taZHKhR6M_4wnHN3FDG6D2WFxdRaRI8x
X-Authority-Analysis: v=2.4 cv=KtdN2XWN c=1 sm=1 tr=0 ts=67f61894 cx=c_pps a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=WCOpYE3sKWxYynmXVT0A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: taZHKhR6M_4wnHN3FDG6D2WFxdRaRI8x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_02,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=699 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504090027



On 4/6/2025 2:52 PM, Rameshkumar Sundaram wrote:
> ath12k_mac_mgmt_tx_wmi() fetches ath12k's skb_cb space multiple times from
> TX skb which is redundant operation. Save the skb_cb in a local pointer
> and use the same instead.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

