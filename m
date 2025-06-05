Return-Path: <linux-wireless+bounces-23734-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FA7ACEC16
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 10:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1148016A6A0
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 08:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1038A19CCF5;
	Thu,  5 Jun 2025 08:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="S98rW2NY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7753C42A87;
	Thu,  5 Jun 2025 08:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749112649; cv=none; b=PFOIoHNBrbCO8AJRTaHkyrq/LhgagjHm7YIPXoN/CyO/vxLv2RfAf2MDwS9Rn6kl8iHKkZbHPnGAuej9gyN407mnV1UM8QI/kcFKK/5C97Mg+fqXiBeZl4BQnc2ymJpk4XUFk/HhXJ8aD5NXkYyIyfqk2tOXwNman/Hi/m5qKTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749112649; c=relaxed/simple;
	bh=lN8QOUnt3tDoKFR2GRrl18RHwKQjxTLDwQFldfPNPGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=drX5+XZAn75UpE8JNreDresBb7Qe8Dx+a6SIlmOU+RGW2SQUPbx1ViUlcz5t58kLBA4QeuEkcZMZytfc8lbsdK9oHZcOtGIfb8oI2iI9dxKIiodyB25202Xa16f0KInz+jLf7AyUXm/IiTTFWD3C27Nc+UnlwvhN0g2vuquoVJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=S98rW2NY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5557fZOt024416;
	Thu, 5 Jun 2025 08:37:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GvXMhXjr02ODB+m/D0r6qd74wzQBhpGFQBfiLckl99c=; b=S98rW2NYa9nwHdqm
	pCxWJEBzJphLXvcpgo1+wiHqDQyjX7W23N4YhIBGfFiDQNky3L9ATePqN41AZAH2
	ysVVWDyox3kB9gcfW+y7UMJJnMqtPrrOIVjdfTZR0puxk02C7Hh7j+1/KtqG/2O4
	QeJY8a034cptu6l3U96CrHHim4AYOIJk7exfdp5qLfLTLg/+lsbAg1rWemAknEE1
	EHzyZtfbyYHJGjVq2h8Vav4LWR493QtxczP/Y657euOJzKqqFtN+duL8JZ1IfYIN
	OtQkRMZOqI3+rgYUB1N6vJCnNARolxiHAevITudq85ZZGciL/esqOz74LjKXRJqX
	7NiwdA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8s0pu0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Jun 2025 08:37:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5558bJ6l005158
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Jun 2025 08:37:19 GMT
Received: from [10.253.10.58] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 5 Jun 2025
 01:37:17 -0700
Message-ID: <257bf9e9-f4b2-4ab9-804f-b895243c924d@quicinc.com>
Date: Thu, 5 Jun 2025 16:37:13 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] wifi: ath12k: fix dest ring-buffer corruption
To: Johan Hovold <johan+linaro@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
CC: Miaoqing Pan <quic_miaoqing@quicinc.com>,
        Remi Pommarel
	<repk@triplefau.lt>, <linux-wireless@vger.kernel.org>,
        <ath12k@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250604144509.28374-1-johan+linaro@kernel.org>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <20250604144509.28374-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6irz6-X3e9sQVWi0LxvafzqQ-_TPpCC-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDA3NSBTYWx0ZWRfX12rAmdHVM0Wa
 LtAmT8PLMp+iMqtdW+AA+5BQrqRCORHhcOl9jyYzluXw7Dq6QTHy0vjWgjththn6tHjTapCKA0N
 glkT8Zq0pwzisd65hnOmZMonsLkcl/u4bFUM6U7BhmnFRE54QIioPYs7mvCaAOB6LHIeL9DI6FW
 efvuIA8APe1xqvSc59/Fs/RtA+TMnlc0xDAmy9UmJ4o2QEsdmFC70TqO44X0dnlx9YC9z8pCq/P
 3NANj0A7346uxPA3NuS9SYflHz0whBm6R4M6m2acTWqyJuOdHgbn0Dt1Og2xc7ffO1EIn6vmmBr
 8O87429CWSzv+5ryK1KdixVQxSNpWqDvrU4oMKgqi2irH+nbX52orQgnWE2rEX76VjHhPwGftOv
 L6uMEkfpdaHm6xciEQLH9X5vJdltJbKAKGXmAdu3H4OBr5V2Bh/q8wx/D9EkqRMzZqd8LSq3
X-Authority-Analysis: v=2.4 cv=RdWQC0tv c=1 sm=1 tr=0 ts=6841573f cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10
 a=kPFMAqld5iEWQpescWAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 6irz6-X3e9sQVWi0LxvafzqQ-_TPpCC-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_02,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 mlxscore=0 priorityscore=1501 phishscore=0
 clxscore=1011 lowpriorityscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 spamscore=0 mlxlogscore=844 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506050075



On 6/4/2025 10:45 PM, Johan Hovold wrote:
> As a follow up to commit:
> 
> 	b67d2cf14ea ("wifi: ath12k: fix ring-buffer corruption")
> 
> add the remaining missing memory barriers to make sure that destination
> ring descriptors are read after the head pointers to avoid using stale
> data on weakly ordered architectures like aarch64.
> 
> Also switch back to plain accesses for the descriptor fields which is
> sufficient after the memory barrier.
> 
> New in v2 are two patches that add the missing barriers also for source
> rings and when updating the tail pointer for destination rings.
> 
> To avoid leaking ring details from the "hal" (lmac or non-lmac), the
> barriers are added to the ath12k_hal_srng_access_end() helper. For

Could you elaborate? what do you mean by "leaking ring details from the 'hal'"?

> symmetry I therefore moved also the dest ring barriers into
> ath12k_hal_srng_access_begin() and made the barrier conditional.
> 
> [ Due to this change I did not add Miaoqing's reviewed-by tag. ]
> 
> Johan
> 
> 
> Changes in v2:
>  - add tested-on tags to plain access patch
>  - move destination barriers into begin helper
>  - fix source ring corruption (new patch)
>  - fix dest ring corruption when ring is full (new patch)
> 
> 
> Johan Hovold (4):
>   wifi: ath12k: fix dest ring-buffer corruption
>   wifi: ath12k: use plain access for descriptor length
>   wifi: ath12k: fix source ring-buffer corruption
>   wifi: ath12k: fix dest ring-buffer corruption when ring is full
> 
>  drivers/net/wireless/ath/ath12k/ce.c  |  3 --
>  drivers/net/wireless/ath/ath12k/hal.c | 40 ++++++++++++++++++++++-----
>  2 files changed, 33 insertions(+), 10 deletions(-)
> 


