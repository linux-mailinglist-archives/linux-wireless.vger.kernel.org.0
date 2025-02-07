Return-Path: <linux-wireless+bounces-18608-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCCDA2B88C
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 03:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CD31166CF7
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 02:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313C122619;
	Fri,  7 Feb 2025 02:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pijQCxOU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A2E3C38;
	Fri,  7 Feb 2025 02:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738893679; cv=none; b=UeLGt2O7xRbDFZc4oxJtKublihvwhn7NtCAv6TyJBR3E8BtVJ71r29UaymI0/nFD5HTdvEFpANvp9mDi9YiVzRrOIDzOpGGNrQmZyzlXt1MqvoVnQS5F1zTr+9JOY8jzOvoSyMcX7V/jktSJHRnvRkFzzGoQW4BM/jyimiOaeCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738893679; c=relaxed/simple;
	bh=m3D42JUrM6TyUor3EeqLRscsl8+YaClJzqOQSbgkqVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=e4SlS9AwJCw0sv2eXxqCaff8ENFfqUO8zI4S9PVo30Y27e7fQnuCYvkF5H6G3ayi0Wc4xKsb54loib5jV9xLTA8kwYDpfsGk3XIbupXDsuTgLiwu68svwBVuCHHcqGvOODA/B+Q/zKTun3tHSCmAnzKeA57w4A9SGxgB/Jp+Zqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pijQCxOU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5171PCvk028281;
	Fri, 7 Feb 2025 02:01:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/lmx7Fh3p/PFSQ1apxhaW8EkLnRUOlfdQPR75DkhK3I=; b=pijQCxOUD8hli9WO
	EFm1iUiclCmsfcdrgNIv+wn7Yc9CGIZU74Lh226C2FYoYDJfthhWYb58yD6BKDZ+
	DGMTxo+WfoiluyundsP+TYpcEd4YZHOU0UI9ST2cbXHXYcetVrxmbn5/Hc7jnBFh
	/qIXcXY2hxf7vLn9vPrcdySeJFs6U3/8QFBgt/iR30nY/xLbl4URFH5wAvzkQnkY
	/tY4r0mpVREaohlz5QZXwL8u1uF0CiCtcp3OsScnUtg3FVlleLRAIiGMLWvIIXne
	Qzn+mfqGppOKm/lCMtQ30uBumOaBS4745HzFaFHs1vWqzTE68qnVNQUc1kzw7iha
	E1Un6g==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44n7p7r5fe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 02:01:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51721B5f012127
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 7 Feb 2025 02:01:11 GMT
Received: from [10.231.195.16] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 6 Feb 2025
 18:01:09 -0800
Message-ID: <3e9d565e-dbb0-4a7a-987e-ed817e810607@quicinc.com>
Date: Fri, 7 Feb 2025 10:01:08 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: allow APs combination when dual stations
 are supported
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
CC: <ath11k@lists.infradead.org>, <jjohnson@kernel.org>, <kvalo@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-wireless@vger.kernel.org>
References: <d410576f-2fc7-4de1-af51-29fbe8b14948@quicinc.com>
 <20250115130359.138890-1-jtornosm@redhat.com>
 <748a5a75-1385-4691-85c1-e9cc5eb4ffc2@oss.qualcomm.com>
 <e1c9b030-8a6c-4aba-8bdd-853113bef396@quicinc.com>
 <2b52714a-0fe2-4c85-95bc-4a6c0a8a0b60@oss.qualcomm.com>
Content-Language: en-US
From: "Yu Zhang (Yuriy)" <quic_yuzha@quicinc.com>
In-Reply-To: <2b52714a-0fe2-4c85-95bc-4a6c0a8a0b60@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xFGOH_jcjhZNjLTVEwc8FlmP-SfXgfVw
X-Proofpoint-ORIG-GUID: xFGOH_jcjhZNjLTVEwc8FlmP-SfXgfVw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_01,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=424
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 clxscore=1015 mlxscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502070014



On 2/7/2025 4:20 AM, Jeff Johnson wrote:
> On 2/5/2025 11:46 PM, Yu Zhang (Yuriy) wrote:
>>
>>
>> On 1/16/2025 8:31 AM, Jeff Johnson wrote:
>>
>>> Kalle, can you review? You currently have this deferred in patchwork:
>>> https://patchwork.kernel.org/project/linux-wireless/patch/20240829064420.3074140-1-quic_yuzha@quicinc.com/
>>>
>>> /jeff
>>>
>> Jeff, can you help with this because Kallo has stepped down?
>>
>>
>> /Yuriy
> 
> We should avoid having new module parameters
> Is there a solution that doesn't require that?
> 

Yes, I think might not have expressed clearly. I was referring to the 
patch we discussed earlier, that Kallo deferred in Patchwork:
https://patchwork.kernel.org/project/linux-wireless/patch/20240829064420.3074140-1-quic_yuzha@quicinc.com/


