Return-Path: <linux-wireless+bounces-7150-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0153B8BAF4C
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2024 16:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB5EC1F232C0
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2024 14:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F067D47A79;
	Fri,  3 May 2024 14:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Emyv+1Lf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E851E4B1
	for <linux-wireless@vger.kernel.org>; Fri,  3 May 2024 14:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714748147; cv=none; b=Fz8jXfIbndmOBipLNbM+OfUzc7oAe4hYR6QbGd/KBk6cG2J7qMT/swBr1MStO6iPZI8d9treofV4hW3HErOjKo8vkbgQWFj9aru633AuEfd45f6SdewDVjOdINJnRvRpT68kseKsbWubFqBiTHW84f3Y9b9cmD9ojNXYOxDU1O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714748147; c=relaxed/simple;
	bh=8Znxf46VcSvVwTTSxQMnYvh3QODuCaP/VXJS0jiGdXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=k8bUn7Z14CJWJxyzz6ZFykFyIPk8oGm/z9jn24bscDQXqL56s4DkwLxU3JZAikwDrUFL41vp6ib8lEvmKBiXKXSEFBeFtdOXM+ZZhk1fq3nmkNK4gFqLIJx4QK50ztz/0Kpi91xm45b9w12eyilNVqxzhJlaK+Qdp27WkpnCh4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Emyv+1Lf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 443DLqpM024506;
	Fri, 3 May 2024 14:55:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=l+7ecq40+oDZ500fCz2rEtnBnAykoerzuJBxSHLdkpM=; b=Em
	yv+1LfIygR1LS6NYi9Hor7jvi0dp+1uAdiXQMbxMNLZVp9rIpuufJkZTuUUYyX+K
	WN4bes0PMD3/RMiv55V/50MoKaVIcu7MZzblg0djt3YiGUN2ZNwuj6WoSTZpFJRQ
	C37eHpr8hI9Ggc2fjfjli1EtKfSLyKrj+ixP319mF3ddwoUABhc/ZbCePI5wzKMq
	BoTI3FTTfELgoX8VZmq02AzT0NIvKkg0cpgDsdsGJqXlS3dRUa3Q6W8wQB9ogPbf
	HG1ghNC6PhfICxmp9RR7w4mMoo7soO+4VT3ZUEeyauPExcZ7mulQbsZD1z6DuHsu
	SKK+HSu6pKOw8wF60fRg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xvtbpry1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 May 2024 14:55:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 443Eta4x016274
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 3 May 2024 14:55:36 GMT
Received: from [10.110.94.246] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 3 May 2024
 07:55:35 -0700
Message-ID: <143e04a0-3bda-4718-8647-1ed31e1f5774@quicinc.com>
Date: Fri, 3 May 2024 07:55:34 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv5] wifi: ath11k: skip status ring entry processing
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
CC: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>,
        <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        "Venkateswara
 Naralasetty" <quic_vnaralas@quicinc.com>
References: <20240429073624.736147-1-quic_tamizhr@quicinc.com>
 <35f114c4-1ff7-4a4b-aadf-ed147f19e170@quicinc.com>
 <87cyq7ota5.fsf@kernel.org>
 <4f9abe89-a004-45e8-b369-5c2b39bff440@quicinc.com>
 <871q6jnipu.fsf@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <871q6jnipu.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: j63a8rZHP8r7iI6Gp0GfRVE5zjnXxlHv
X-Proofpoint-ORIG-GUID: j63a8rZHP8r7iI6Gp0GfRVE5zjnXxlHv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_09,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 spamscore=0 clxscore=1015 mlxlogscore=787 lowpriorityscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405030104

On 5/3/2024 6:11 AM, Kalle Valo wrote:
> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
> 
>>> Also I removed one unrelated change and removed unnecessary else. Please
>>> check my changes:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=6e88d559268779107715008c51e006f7a5f62045
>>
>> So looking at the 'pending' change I have the observation that
>> ath11k_dp_rx_mon_buf_done() only returns one of two values:
>> DP_MON_STATUS_NO_DMA
>> DP_MON_STATUS_REPLINISH
>>
>> And the return value handling has explicit handling for those values, without
>> any logic for other values:
>> +				if (reap_status == DP_MON_STATUS_NO_DMA)
>> +					continue;
>> +
>> +				if (reap_status == DP_MON_STATUS_REPLINISH) {
>>
>> if we only expect these two values to ever be returned, then we could remove
>> the testing for DP_MON_STATUS_REPLINISH since, it it isn't NO_DMA then it must
>> be REPLINISH
> 
> Nice, I simplified this error handling now. Less indentation now which
> is much better.
> 
>> + ath11k_warn(ab, "mon status DONE not set %lx, buf_id %d\n",
>> + FIELD_GET(HAL_TLV_HDR_TAG, tlv->tl),
>> +						    buf_id);
>>
>> I don't think we should log anything here. we already warn before calling the
>> new function. if we get here it means the next buffer had DONE set so we can
>> replenish the current buffer
> 
> Yeah, I removed the warning altogether. Please check my changes:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=49c28a9720959fb5daf702fe1732a716f3cff15c
> 
LGTM, thanks!

