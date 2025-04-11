Return-Path: <linux-wireless+bounces-21430-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AD7A854DE
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 09:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81C624C02CC
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 07:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97BB4503B;
	Fri, 11 Apr 2025 07:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZVFLmfAX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A42D1372
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 07:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744354849; cv=none; b=ibC/rowZt9ZHZyjK9gN/1I8mIDXlqSNZKqDOnovj0Ptbv+xfNQ8OkI/Mkb1PcZrAUzzd0UA6oF+/D3+u2SfS0a5F4cOSn+V3kWnEaAVgLaOoUUIv8I8FHWtRvfRXFCDephn21dB8XyBY7uMvXrj2CXo835RXvoGJsqET3pXiH18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744354849; c=relaxed/simple;
	bh=QtsXGn1/gyLyx85l/S5hrccvHuruHTlBOsmOICy5mXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VJQfRp4kT95mcw6GrUmyb7slUXKYhrU2oijUeC7zBhcnyvB7J4PguF3t5dEpY5ktJBxGDgAQf30FsKb92QcUjjnsj35lTCHzY1/W90QkrT6Wxx7Pmm0n3e+hiYd9ALUIhdtREayJSLBSu1N1NhafAw6kpTV3bhVtoR2BHzspb9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZVFLmfAX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B4cWJ5008480;
	Fri, 11 Apr 2025 07:00:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ni+mHILITGZ5XHL/N5eQLGAbSrglv1cg+f6LFqWOhYw=; b=ZVFLmfAXQlnXNcbH
	XB5AL33ZIY+lKT1buo9JcxU7QvglZ60mpU5tWRE3MffNuBKLhN+m6i1HCAZzxLk0
	OvMXc5aKlXjM9uOcwGyRxkslWoC6PKtxb+4fbvZVXgCHc/t6NIR1s8kJ8b7M1tWL
	p7Bxbl2LdssFXOS4s71nW+gxzR5RtMS+vd+/Wk2Dl3jDt4UZCdYLKyOB9es1geZS
	W1GNOxoI2UUqcDCmmCK/3Y9+tkS3ZtbcjOWIjqa8yx91tP8FKQWLrsbD5f75Zeax
	TjG4XaCM4IGbN6n+MPiDfQ8TCF9h1s0eplTlt+3V/dCpxwMyCHYTyqcv2quTH4cq
	0aEVWw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twd09mw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 07:00:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53B70ZjB029084
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 07:00:36 GMT
Received: from [10.216.57.178] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 11 Apr
 2025 00:00:33 -0700
Message-ID: <d6feee78-d693-14b4-b90a-6c0219fede04@quicinc.com>
Date: Fri, 11 Apr 2025 12:30:30 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next v2 2/2] wifi: ath12k: correctly handle mcast
 packets for clients
Content-Language: en-US
To: Sarika Sharma <quic_sarishar@quicinc.com>,
        Vasanthakumar Thiagarajan
	<vasanthakumar.thiagarajan@oss.qualcomm.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250411061523.859387-1-quic_sarishar@quicinc.com>
 <20250411061523.859387-3-quic_sarishar@quicinc.com>
 <24179c31-f351-2ed9-2699-d98615742d4b@oss.qualcomm.com>
 <a47a67e4-5756-459d-b49c-6e517b37e492@quicinc.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <a47a67e4-5756-459d-b49c-6e517b37e492@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6j80c4qu7aYQkAAnFSJwQiq_KLUooEpj
X-Authority-Analysis: v=2.4 cv=Q4vS452a c=1 sm=1 tr=0 ts=67f8be1c cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=ppMG8rbRpNWmaPcQXTYA:9
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 6j80c4qu7aYQkAAnFSJwQiq_KLUooEpj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_02,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 mlxlogscore=589 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110049



On 4/11/2025 12:27 PM, Sarika Sharma wrote:
> On 4/11/2025 11:55 AM, Vasanthakumar Thiagarajan wrote:
>>
>>
>> On 4/11/2025 11:45 AM, Sarika Sharma wrote:
>>> Currently, RX is_mcbc bit is set for packest send from client as
>>> destination address (DA) is multicast/broadcast address, but packets
>>> are actually unicast as receiver address (RA) is not multicast address.
>>> Hence, packets are not handled properly due to this is_mcbc bit.
>>>
>>> Therefore, reset the is_mcbc bit if interface type is AP.
>>>
>>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
>>>
>>> Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
>>
>> Should there be a fixes tag?
> 
> This patch independently does not fix any known issue, this is required because of patch 1 
> in the series. Due to 1st patch some existing issue is exposed, to address that 2nd patch 
> is required.
> 

Ok

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

