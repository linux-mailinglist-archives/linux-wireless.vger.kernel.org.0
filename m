Return-Path: <linux-wireless+bounces-20361-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4A6A606A8
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 01:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF1B14604D8
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 00:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBDA4C8F;
	Fri, 14 Mar 2025 00:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fSmv1uv2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4A02E336D;
	Fri, 14 Mar 2025 00:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741913220; cv=none; b=eH2EMMjmLffb3dXWNb5Jkh7J7SewCiEEMqSvr++6ja5e0rgdxEQGpPdsx6YGBRCAx9cfKyOxUVhN92oun5NwhpmFTq++9YQCUKkE06tByOQF4FYFlVMKl1xw3zgFCdK4OL1ycTfPT+5XXkxYqIM9NL5FheshcBMcL3xjiwwKuZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741913220; c=relaxed/simple;
	bh=EyuohB05lqPBTCRoPW2fjWSQr42oM6pNAi6Wp3SmcGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iNH3XzylfvCuX1h5BIy2nYy6FbF2BG5qJf4Ngw2dZQZf/M7y/mddVaBelcaRVgVyyqyMGUwaHLQDFFK8IF26yhLqv5rH50E2czjgalMuPOGvM3On86K7x+4vTd2EtHaweCY9dWmSYQuJAWJKAsUC8a5VuFo3KQjrW8MgbTpcwfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fSmv1uv2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DNQF87016250;
	Fri, 14 Mar 2025 00:46:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hDRWHFruEAw8rPKa3kcGgs8v9/GUou8yTUSzmrvxDdM=; b=fSmv1uv2MQgLy0gj
	+vvJuNufAluGALzRhWf/zQID9l2Y8w65znN9MzHElqEiVBI3DM6y2DvFRpV7LTfy
	yAUgEqiHmPPycknnLhWrA7H52VCQZ4FJCzIykOCKtuTlF/U01QewC2YTCTOvLuJa
	R93F1eeFAMIjS6s1un4nQj34DVPcWXXu/SAp4w98iNHuUDJg5/f77/o33vD93F5G
	3n014c1yEH5HToSNoywUgDpdlmNNUk4yJ266F3SHGew2poe8ouONrEND1wIqFOv3
	a6qmFiP0MqnGP/sz1w4zbTA60Uz7cIWWqAE94tkLA4D5tuW5a31ndiuyZ0fLkdTF
	lzlNow==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2nykad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 00:46:54 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52E0ksUJ021665
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 00:46:54 GMT
Received: from [10.239.29.24] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 13 Mar
 2025 17:46:52 -0700
Message-ID: <08cfa289-111c-416d-8e5a-971961d954ca@quicinc.com>
Date: Fri, 14 Mar 2025 08:46:50 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 ath-next 2/2] wifi: ath11k: fix HTC rx insufficient
 length
To: Johan Hovold <johan@kernel.org>
CC: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <johan+linaro@kernel.org>
References: <20250310010217.3845141-1-quic_miaoqing@quicinc.com>
 <20250310010217.3845141-3-quic_miaoqing@quicinc.com>
 <Z866cCj8SWyZjCoP@hovoldconsulting.com>
 <7b1c5e40-b11d-421b-8c8b-117a2a53298b@quicinc.com>
 <c0cdcaf2-655b-4d22-a949-1519c552e6a4@oss.qualcomm.com>
 <72d95d77-674e-4ae7-83b0-ab58748b8251@quicinc.com>
 <Z9G5zEOcTdGKm7Ei@hovoldconsulting.com>
 <8251fc50-5df4-4a3f-91bf-40c09c33cf6e@quicinc.com>
 <Z9MAehaipGtwge8p@hovoldconsulting.com>
Content-Language: en-US
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
In-Reply-To: <Z9MAehaipGtwge8p@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: s6thM_5dezFFUxWCR1GvHQaUizI7jz3p
X-Authority-Analysis: v=2.4 cv=ZObXmW7b c=1 sm=1 tr=0 ts=67d37c7e cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=Wml-KaHhdQLM07Bvzy4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: s6thM_5dezFFUxWCR1GvHQaUizI7jz3p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_10,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503140004



On 3/13/2025 11:57 PM, Johan Hovold wrote:
> On Thu, Mar 13, 2025 at 09:41:51AM +0800, Miaoqing Pan wrote:
>> On 3/13/2025 12:43 AM, Johan Hovold wrote:
> 
>>> I've taken a closer look at the driver and it seems like we're missing a
>>> read barrier to make sure that the updated descriptor is not read until
>>> after the head pointer.
>>>
>>> Miaoqing, could you try the below patch with your reproducer and see if
>>> it is enough to fix the corruption?
>>
>> Sure, the stress test is running.
> 
> Thanks.
> 
>>> If so I can resend with the warning removed and include a corresponding
>>> fix for ath12k (it looks like there are further places where barriers
>>> are missing too).
> 
>> If the DMA read barrier works, do you think my submitted patch series is
>> still needed? Because the error handling is incorrect.
> 
> Yeah, it would still be good to fix up the error handling even if you
> don't expect to ever see a descriptor with length 0.
> 
> But unless the device is doing something wrong here, there shouldn't be
> a need for peeking at the descriptor and retrying.
> 
> Johan

New version will be submitted based on the previous discussion.

