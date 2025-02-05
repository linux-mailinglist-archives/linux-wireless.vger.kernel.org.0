Return-Path: <linux-wireless+bounces-18478-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 526CEA2808F
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 02:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DB77164111
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 01:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3762F43;
	Wed,  5 Feb 2025 01:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D/SL7Fzy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACCB6FC5
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 01:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738717411; cv=none; b=JuHGtTAlPjN0V0Hbn8dgBJaJxkAaesAXVTE5CAmK8dkQnO9h+FnkJWaVBKW5n7XcTbte6F3JT3BkSvhhYtUutOMLGFGCddDm3KP3Xy2/ermNRCaA0y/woe3TRfqKfhZ3IQpwLgiCSSNZzoWrN7fCh8EZZgTziLRTmh4fAjeHAfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738717411; c=relaxed/simple;
	bh=sKyG/pQbT/tp3P+Vt5AN4WmraQCCzVZ+Z1aq3J6IuOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MIxnkwbi6bgrMlfcDLjU6Q6/STS/oWVgoa38cCmYbaYDJOjRjVThFnUxCikm0i9dhBtNf6RkWIqaRHBJ73CctPZ+gBoSnM10rqXn0t4A15Pft7M/bCh5nEgNoq168isFf8j6xPuNpfCGwvatgLRhBU/cCRFH+jg4zQv0SkktpLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=D/SL7Fzy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514E1aab032316;
	Wed, 5 Feb 2025 01:03:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	riqRvzbNwbYlkuc7UwhRFdLtvXAkud21a578+p1IZ04=; b=D/SL7Fzyp8+tw9Ay
	cqFTMF34lgBqzAtWT9gO8MHYJCQimjV0TNPPY7IJRMLOEpJwB/lRW+fIs5cqo5ej
	e+x8lspu2tT18VSeNdmkAOrorIiS+aup7ASZU+W/MnAVOOwWuslkY5LyluFru5cg
	KmLSzbLUQf/WIsXwf2/R6LNoSor6AEPrsH6P9ONLvbnzTy6eJX7ii6Ddp8HzADob
	FKRWMy728qrtShExeqLCb7hznUZRCuTW3EiMklDf2MR0gYogEdYPnVNX2QVeqgd4
	Bbi/ntHJ5zy6vqfn91TymSt/yuRiRu4tqqJO81gFGxmgzzMbSPX28CHbrLsgZ/PS
	YBAPwA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44km9whdxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 01:03:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51513Pv1005165
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 5 Feb 2025 01:03:25 GMT
Received: from [10.216.47.115] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 4 Feb 2025
 17:03:10 -0800
Message-ID: <0f7885ad-a360-2ff1-eb0b-51454de2eeb0@quicinc.com>
Date: Wed, 5 Feb 2025 06:32:38 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v8 1/9] wifi: ath12k: Add HAL_PHYRX_GENERIC_U_SIG TLV
 parsing support
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
References: <20250204035718.3227726-1-quic_periyasa@quicinc.com>
 <20250204035718.3227726-2-quic_periyasa@quicinc.com>
 <414ca414-d6a4-4228-acb3-dde4bb71624d@oss.qualcomm.com>
Content-Language: en-US
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <414ca414-d6a4-4228-acb3-dde4bb71624d@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: K63B46zqiidkaSgslUYMUM_-P2NOP8za
X-Proofpoint-GUID: K63B46zqiidkaSgslUYMUM_-P2NOP8za
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_10,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 adultscore=0 mlxscore=0 bulkscore=0 mlxlogscore=851
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502050006



On 2/5/2025 3:59 AM, Jeff Johnson wrote:
> On 2/3/2025 7:57 PM, Karthikeyan Periyasamy wrote:
>> Currently, monitor is not enabled. However, in the future, the monitor
>> will be enabled. Therefore, add the necessary HAL_PHYRX_GENERIC_U_SIG TLV
>> parsing support in monitor Rx path, which help to populate the EHT
>> radiotap data.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
>> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
>> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
>> Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
> 
> Normally your S-O-B should be the last tag. Any tags you collect should come
> before it.

Oh my bad, if you want to re-spin ?
will fix it in the next version of the path.

-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

