Return-Path: <linux-wireless+bounces-24595-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E26AEAD80
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 05:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59FD51885850
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 03:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B48D19D081;
	Fri, 27 Jun 2025 03:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Itc0cpOc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9378F15746E
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 03:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750995855; cv=none; b=rR98vCA/155JNVKtoPsm+zpS9MSkkbCK+GXQ/SDHb0YUhdo+oKHL+G12mAXtIVhjsZVZhL2IFPvucoaHfae/rjogK8GQizNQy2wQZFJJXhMtJ6avH4OgVChbjoL+7uZU4/13a+dx5P3qI1MCj0pL61yxDzvgfLJYrn/RmbCL7bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750995855; c=relaxed/simple;
	bh=Ufs0UHD31CyIZk3c5wqqBSwaJDBQQi5oidfZLsh8duk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DpUVKJlVvcqNBZ9vRN5ZhbJSANO/uDtSHkho+h703blimJHReVknrHiTn+wg2EFbbcye7d0VtQmFhT/151F+6Wdw85ui4iys7FsyzapcSHZPvrDLhi5pnx8Kt8j5E2qxN1hcQWMv6oBlTy0D9THoloM+d4l0sm02rbVTbqb2cQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Itc0cpOc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QKHSmJ013542;
	Fri, 27 Jun 2025 03:44:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	W6haESMb17b0awpmARzv+pxnGvZhyPxdFdK53R9oEB0=; b=Itc0cpOcxvjvHyeE
	zV+Vy552ez1lq8NQYhehs+byWqtd/Tkb5u3Ss8jD61a9cKTtEmv8oNS4SzMYFi3s
	uuemkgRmSuGBpcmfgk+rLx8pBd8TvrS9uFFU1+qAHm9R+hmf1caRMKro0YRvMJUS
	u+E531boDHecPakw+Ob0tDZ/Ooqln5wDfjpHIqiOZCirAPp1dI23D/pyvRB45Hg6
	Iu/NOm3j1fjll3GFe7V14pJy92SpeZ6/HYMdQa4kp9tFjXD2wY2FJVmrhsBtYyrg
	fuch4J2nGmhid27fHDFU0H61qXM/w3DE9UkPrxBtge/0WRklMIXgi2HLJ0ddNVBr
	iVlA0Q==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f3bgnan2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 03:44:09 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55R3i85x029397
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 03:44:08 GMT
Received: from [10.216.56.23] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 26 Jun
 2025 20:44:06 -0700
Message-ID: <e657ddc8-84c8-a9dc-7b86-482437079c7a@quicinc.com>
Date: Fri, 27 Jun 2025 09:14:00 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next v2] wifi: ath12k: Add support for transmit
 histogram stats
Content-Language: en-US
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Vasanthakumar Thiagarajan
	<vasanthakumar.thiagarajan@oss.qualcomm.com>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Saleemuddin Shaik
	<quic_saleemud@quicinc.com>
References: <20250617112139.865788-1-quic_rdevanat@quicinc.com>
 <6b32c871-0d18-4cdd-e097-97fc2e7bdf28@oss.qualcomm.com>
 <cab5daaf-bafb-4df3-9e44-1d0e6dda0341@oss.qualcomm.com>
 <fca2def0-227b-4208-8104-abc40368f7fb@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <fca2def0-227b-4208-8104-abc40368f7fb@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7vYCiBxcLiNaqejugmexJisyz8jTKpC9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDAyNyBTYWx0ZWRfX8MZ4gyeXn9Ho
 g89DeBjsu2tuyGjbLFcaUZ4n0O60SzVd/5wde23V38Yyqs0NzlC2DTlUO8vs0/pSyVx862e4Mkq
 7fqr1fsjvrRmBpVQ06TAgGUpT+FtAJCCa+uXppKwwX6TigKML1CojhEhxojZ6VPu9tcNgW5QlWm
 JAQWF67cEUAS/pfqMIIMBYkTr39j5VoaY6Vg5AMMIEOszu4DVvSyL6+ceYfBv2oWIMgJqcj9dct
 1mISDwFvmHT1TwqIxx1n71T0hRlVjudBFjs3ZEyULFxi8G0Jn0YwVF/SmnAdRrjjQXqTO6dRIFU
 u2HYMCZ5CQQudF8lGgpzuxfonO5Bz3ddpSYVreDKdFWEZIXJt7zGZIgEJ3MQd4rL1XFGqng3dI9
 Tibs08QOKbIcAIaYSueqd9A+nBxJf+uJZ6bibJvFAkwSpxNCJn0kM1LcLWUZiUx2ubrV0PnZ
X-Authority-Analysis: v=2.4 cv=L4kdQ/T8 c=1 sm=1 tr=0 ts=685e1389 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8
 a=TE82o3EEuiIpzjil3jEA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 7vYCiBxcLiNaqejugmexJisyz8jTKpC9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_01,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 mlxlogscore=977 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506270027



On 6/26/2025 11:55 PM, Jeff Johnson wrote:
> On 6/26/2025 11:18 AM, Jeff Johnson wrote:
>> On 6/26/2025 10:20 AM, Vasanthakumar Thiagarajan wrote:
>>> On 6/17/2025 4:51 PM, Roopni Devanathan wrote:
>>>> From: Saleemuddin Shaik <quic_saleemud@quicinc.com>
>>>> +struct ath12k_htt_tx_histogram_stats_tlv {
>>>> +	__le32 rate_retry_mcs_drop_cnt;
>>>> +	__le32 mcs_drop_rate[ATH12K_HTT_TX_PDEV_STATS_NUM_MCS_DROP_COUNTERS];
>>>> +	__le32 per_histogram_cnt[ATH12K_HTT_TX_PDEV_STATS_NUM_PER_COUNTERS];
>>>> +	__le32 low_latency_rate_cnt;
>>>> +	__le32 su_burst_rate_drop_cnt;
>>>> +	__le32 su_burst_rate_drop_fail_cnt;
>>>> +};
>>>
>>> Since this strcuture represents the message format used between host and firmware, pls add
>>> __packed annotation even though it may not have any effect in this case.
>>
>> looks like I missed this in a few other structs as well, at least:
>> ath12k_htt_tx_pdev_rate_stats_tlv
>> ath12k_htt_rx_pdev_rate_ext_stats_tlv
>>
>> perhaps i'll take this as-is and then have another patch that adds __packed to
>> all _tlv structs that are missing it?
> 
> actually let me fix this instance in pending, and we can fix other existing
> ones separately

Sounds good, thanks.


Vasanth

