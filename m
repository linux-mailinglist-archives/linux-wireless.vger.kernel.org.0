Return-Path: <linux-wireless+bounces-6674-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E77D8AD193
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 18:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A1E72818E4
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 16:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0AD153565;
	Mon, 22 Apr 2024 16:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LRswoEyR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95592153562
	for <linux-wireless@vger.kernel.org>; Mon, 22 Apr 2024 16:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713802200; cv=none; b=Zxfz/dcfr6G6+H5q9mNaoTgL/ngg8O+DjIwgZxRPODgZff8SenOsDO3nZ5bI9k/yiWGjv/Qv/AiQBpwV7KOr/m2komKmGvVKrj4vCwXHFMMKjn6lu7ypR1rUd073gdAKWvIdNJI0K5bUsIC+tCNT99JfhOYXbh3Zqtdf1uKDZsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713802200; c=relaxed/simple;
	bh=3Af4QcesK38+giuiX1incZxKKGgnWCMBYcOPvIwZ6qY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RjqjWFik/X+aMT5MghwkySktO6acsuj5J8V8eJtQTWGPyFHG7Wu4Iw0Q6OQI1Rt5D8RSFOjha4dDcXlYRg62AzxWlfE9IimcWaFmhMn6UYecE18fnqI+PUf2BPp6KBTnZnamRja5KaNXeY+uUwE3mhXHtNgY/+IilcuorBt8Y5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LRswoEyR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43MFU4mf008007;
	Mon, 22 Apr 2024 16:09:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=2lSvTP1dn28zewscktIA759SM4uYHHYwZxU3RSSyuH4=; b=LR
	swoEyRMigI/Qm3YDP9DxeEZQyGF1ljuFIBn3ki2A+tqY1LLUI/JvWlJjK0dm+JaK
	N4n5se4qUsDqJRg0JaCfdW/fcO20HdcraH/MdBC24AfIO6HD28ksZAj7ys7rjhjm
	Pl4SyzKL3rwtmnvJ9tNtm0ICjmEkIA4TGK+x3NoMj8Fy3UGnm7QVug+HH3Vu1Y5D
	e/lYWN1QBgTUwtXpCW7mV1gKsHADw8V5yCs1C9Oe/q6BZoL0Fri6TtYT8fBt93gT
	EpFSLpMvA/aOKH8mPpLltrnsrcYWefBbzsLQcj6o7oeVLAqe8LCGf+5TRPPZ0sJS
	ksqXR3aU/pFPSSxTftyQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xm5sx4wgg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 16:09:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43MG9lIF024298
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 16:09:47 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 22 Apr
 2024 09:09:46 -0700
Message-ID: <f30ad02c-0c52-4a28-b63f-22ae84f23b77@quicinc.com>
Date: Mon, 22 Apr 2024 09:09:46 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] wifi: ath12k: Refactor data path cmem init
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
CC: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240409151415.1226109-1-quic_periyasa@quicinc.com>
 <20240409151415.1226109-5-quic_periyasa@quicinc.com>
 <877ch4z0z1.fsf@kernel.org>
 <6ac588c2-6206-c12e-e741-cbc507365bc3@quicinc.com>
 <823fe8a6-1e6c-49e9-a225-2012e77093ac@quicinc.com>
 <87y195vc0w.fsf@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <87y195vc0w.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: IXSAyZRAk9iSOZDqmHP0OPl1hC2mzSFu
X-Proofpoint-GUID: IXSAyZRAk9iSOZDqmHP0OPl1hC2mzSFu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=730 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220068

On 4/22/2024 5:04 AM, Kalle Valo wrote:
> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
> 
>>>>> +	default:
>>>>> +		ath12k_err(ab, "invalid descriptor type %d in cmem init\n", type);
>>>>> +		return;
>>>>> +	}
>>>>> +
>>>>> +	/* Write to PPT in CMEM */
>>>>> +	for (i = start; i < end; i++)
>>>>> +		ath12k_hif_write32(ab, cmem_base + ATH12K_PPT_ADDR_OFFSET(i),
>>>>> + dp->spt_info[i].paddr >> ATH12K_SPT_4K_ALIGN_OFFSET);
>>>>> +}
>>>>
>>>> Here's a good example why I don't like functions returning void. How do
>>>> we handle the errors in this case?
>>>>
>>>
>>> sure, will handle the error case in the caller.
>>>
>>
>> this is a static function with one caller. the only error is the default case
>> which will never be hit. adding logic to return an error and then check it in
>> the caller seems like overkill. why not just WARN() in the default case since
>> this would be a logic error with newly added code?
> 
> I think the software will be more robust then all errors are properly
> handled in a uniform way. For example, will everyone notice the warning
> message? What if the function is extended later and then the person
> doesn't add any error handling "because it didn't have that even
> earlier"? It's also a lot easier to review if error handling follows the
> same style throughout the driver.

A large number of coding errors occur in exception paths. So minimizing the
number of exception paths decreases the opportunity for introducing these kind
of errors. So the real trick is making sure "all errors are properly handled
in a uniform way"

/jeff

