Return-Path: <linux-wireless+bounces-12037-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B077960590
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 11:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDC8D1C22D2B
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 09:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07193149E0E;
	Tue, 27 Aug 2024 09:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="O+uxGsRd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6240F19CD04
	for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2024 09:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724750951; cv=none; b=Pwm6si5/vpI5Iy/o6k771YCU2D2zo6PuGnUZtyNRbgtOf+9Bc+wDCjzG09NrpPP6hKvLx2SHGNbSfHjuEpzCURwOWATYJZopvSeVhFchtqDY5YfJviPlt391nby0MO8KJDE8hoWUht3TQLD1Tx+W33CBzsYqGiPznn8Ef9R8RLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724750951; c=relaxed/simple;
	bh=EF/3ltfs4sZbs3oo0NTWbcnFLXkAWiP3Q122eY/1JPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QTP0LXvdo3dnU7/DBoIjzI9QieCQ1C/xQRTBq34eZtY/i1uiGvXbUMEVbXb4ZrjCAkwKmoHApac92dcsPeJXG544/MwQuUPSIma5umtrUdpMKzvU59XcChJ331tiD8X2hBbHA5JJXYQA1IruvFPCd3BqMjCJW/p2AtzAir7mQ8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=O+uxGsRd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47R7dGNd023218;
	Tue, 27 Aug 2024 09:29:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z3lMxMw2+wjbzZJTTCuXDW14NudXjye3HL88jz31HyU=; b=O+uxGsRdKPmk816V
	ztsn0h15MCfe/wQ/vlZajl0Y3KEu3LdaF11opknnFCCeEsjg5rXlZ7pgM8NIb3om
	IgE1kgzN1TyYs+rromC/D+wv2SAlTLdWOuAp0r6CerxIMPC6bh0KCaVX2D3fxgEW
	ajBjObNDqCmumT5gE4O3S3yhHtLhSyJmD1nPvJm4JBiJuF+U8KmPYSCW6Lc7rXHC
	SzTugb42KEpTO9FGdnLWA/lQ9TN/q/Bi61tha1vSV+hN1hLBJOHqKj1vE9A0tBnu
	4afz/yD3pbp+TlgayJQETNAXSE3FZokO41CeF1if5/Csu6YeRWdtCdcO8P8lZZzH
	F0WrBA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 417980xdyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 09:29:03 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47R9T3BQ031996
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 09:29:03 GMT
Received: from [10.204.117.236] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 27 Aug
 2024 02:29:01 -0700
Message-ID: <1cb1976c-ef81-4f9f-8bf5-bc48195855dc@quicinc.com>
Date: Tue, 27 Aug 2024 14:58:58 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: cfg80211: skip regulatory checks when the channel
 is punctured
To: Kalle Valo <kvalo@kernel.org>
CC: <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>,
        <quic_mpaluri@quicinc.com>
References: <20240826123341.5405-1-quic_kkavita@quicinc.com>
 <87cylvf6k5.fsf@kernel.org>
Content-Language: en-US
From: Kavita Kavita <quic_kkavita@quicinc.com>
In-Reply-To: <87cylvf6k5.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uodV4drT11Fs49ie4TknU8jRI0nUH-pa
X-Proofpoint-ORIG-GUID: uodV4drT11Fs49ie4TknU8jRI0nUH-pa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_06,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 adultscore=0 mlxlogscore=592 spamscore=0 lowpriorityscore=0 clxscore=1011
 malwarescore=0 phishscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408270070


On 8/27/2024 12:35 AM, Kalle Valo wrote:
> Kavita Kavita <quic_kkavita@quicinc.com> writes:
> 
>>
>> Co-developed-by: Manaswini Paluri <quic_mpaluri@quicinc.com>
>> Signed-off-by: Manaswini Paluri <quic_mpaluri@quicinc.com>
>> Signed-off-by: Kavita Kavita <quic_kkavita@quicinc.com>
> 
> Kavita, is your first and last name really the same? Just trying to
> verify that s-o-b is correct.
> 

Yes, My first name is same as last name.


