Return-Path: <linux-wireless+bounces-6184-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E688A8A188C
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 17:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3D59B28AAA
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 15:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A08B1754B;
	Thu, 11 Apr 2024 15:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YfpZ/ZpP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DBA17548
	for <linux-wireless@vger.kernel.org>; Thu, 11 Apr 2024 15:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712848857; cv=none; b=bjsuzTd1WfZwNec1G/yduTJV/SHdJbemBTl9Xz+7RJ0fF+LHO9xAwuQkYpjnBPizAF9RtI6Sy/fyqU6d05BLgWKr+lHsLgQ5psVBTL0z7FznhPXsQn9FfTXUOHUS1up0sSIrGirpZp/xg1q89QQQI9Oag8ebSvu932Mm9NeRnrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712848857; c=relaxed/simple;
	bh=qWHcAswzrjqVl2ygoNLsHT9Q/DwGte4q+PXg5uMp2Xs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hPjWCqiZVrB1xjGxp/8+Ta5UBEhUq1h+OGvFDhaGz2ysa3Y2lY9oFCyME88Oc3N6rliuYqvQ6TA/LO8vcsoy+e2DGS9r1NSFM3cZdO3lFnuBYN+M2QvqQYu79iMK0qXOA2h4UcKQH40zmZtbyw4Tw+2OJqBCy4jtrXwdiEcwLwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YfpZ/ZpP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43BEEE8N001798;
	Thu, 11 Apr 2024 15:20:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=obUhQxnbcO8snAnhsaUvMfgbWIrQepsj+tWTy9oFZac=; b=Yf
	pZ/ZpPDbs3RMRKMfbJneiXpLORFIrwsWnN/nhJKYeGKK8Yf5lMpzbCnnP55LnLZB
	KEQJ2fgi7L6zhQLggSagqnaXSetTYWgRhtZ5fHaYJeuZFiHFznpp1csLejyfQgbY
	YOsSBhb3r8J7YB4/dWfRq5k41YXIZ1jpdOWzOfDLEiHEMRmc7vVxwvCgSQeKouJ+
	pHcgaB8o1/fmYXM33QFn8PNDvQbSscSIXAm/drh5/JwxdyfV2Vd0J1Bp8t0zPs2M
	xOmAi/ONwKqRhr3+u1H/FQlxF/FDx4Mu9ejgAZDLfFSVGVo2w3OjAko8p/uKs5in
	b+S/AYsQ9Lq0EBRI3Clw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xec6vsf89-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 15:20:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43BFKeAw007529
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 15:20:40 GMT
Received: from [10.110.37.144] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 11 Apr
 2024 08:20:40 -0700
Message-ID: <823fe8a6-1e6c-49e9-a225-2012e77093ac@quicinc.com>
Date: Thu, 11 Apr 2024 08:20:38 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] wifi: ath12k: Refactor data path cmem init
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Kalle Valo
	<kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240409151415.1226109-1-quic_periyasa@quicinc.com>
 <20240409151415.1226109-5-quic_periyasa@quicinc.com>
 <877ch4z0z1.fsf@kernel.org>
 <6ac588c2-6206-c12e-e741-cbc507365bc3@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <6ac588c2-6206-c12e-e741-cbc507365bc3@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mOR919MI6AnHBKfiQaao07LU4OU8meXH
X-Proofpoint-GUID: mOR919MI6AnHBKfiQaao07LU4OU8meXH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_08,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404110112

On 4/11/2024 3:07 AM, Karthikeyan Periyasamy wrote:
> 
> 
> On 4/11/2024 3:15 PM, Kalle Valo wrote:
>> Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:
>>
>>> Move the data path Tx and Rx descriptor primary page table CMEM
>>> configuration into a helper function. This will make the code more
>>> scalable for configuring partner device in support of multi-device MLO.
>>>
>>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
>>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>>
>>> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
>>> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>>
>> [...]
>>
>>> +static void ath12k_dp_cmem_init(struct ath12k_base *ab,
>>> +				struct ath12k_dp *dp,
>>> +				enum ath12k_dp_desc_type type)
>>> +{
>>> +	u32 cmem_base;
>>> +	int i, start, end;
>>> +
>>> +	cmem_base = ab->qmi.dev_mem[ATH12K_QMI_DEVMEM_CMEM_INDEX].start;
>>> +
>>> +	switch (type) {
>>> +	case ATH12K_DP_TX_DESC:
>>> +		start = ATH12K_TX_SPT_PAGE_OFFSET;
>>> +		end = start + ATH12K_NUM_TX_SPT_PAGES;
>>> +		break;
>>> +	case ATH12K_DP_RX_DESC:
>>> +		start = ATH12K_RX_SPT_PAGE_OFFSET;
>>> +		end = start + ATH12K_NUM_RX_SPT_PAGES;
>>> +		break;
>>> +	default:
>>> +		ath12k_err(ab, "invalid descriptor type %d in cmem init\n", type);
>>> +		return;
>>> +	}
>>> +
>>> +	/* Write to PPT in CMEM */
>>> +	for (i = start; i < end; i++)
>>> +		ath12k_hif_write32(ab, cmem_base + ATH12K_PPT_ADDR_OFFSET(i),
>>> +				   dp->spt_info[i].paddr >> ATH12K_SPT_4K_ALIGN_OFFSET);
>>> +}
>>
>> Here's a good example why I don't like functions returning void. How do
>> we handle the errors in this case?
>>
> 
> sure, will handle the error case in the caller.
> 

this is a static function with one caller. the only error is the default case
which will never be hit. adding logic to return an error and then check it in
the caller seems like overkill. why not just WARN() in the default case since
this would be a logic error with newly added code?


