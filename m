Return-Path: <linux-wireless+bounces-7759-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF4D8C7FC9
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 04:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49BD7B20EFE
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 02:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E4F5231;
	Fri, 17 May 2024 02:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jHervPBo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C2C5228
	for <linux-wireless@vger.kernel.org>; Fri, 17 May 2024 02:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715912077; cv=none; b=EEo/PzQ9Pi7KdG1X/VI5UnDSFa7vze2J+/IxR0XVhs+Rxza46ZKwM/ZIwK4w1hRFM/NNcu6pjI7/omQOV2p5RzJhb7EPbmY+C20elC2ySewcUhg096E4gNHz+1QGxtDVmxO8sA0IWtEUyP8hNousmFFZbGDMXuIxoXJuebufAV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715912077; c=relaxed/simple;
	bh=5W95nvvhpnPbj67Ut5EX9Sz2//A/uPWftgKl1irR0kU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AkwITyTzH7NPVLiwq5ti/oxzr88qEmgGhEHWTdEDMVBNUkXb4gnPpnPbH/kCTXLdlmmCjUMey9YQ7hgycwtvgHz+QRL+UbJNvUNzH2lclN2rQshaxKDaBaqg+o3iLHYTOEtVRntpIIiZr3ce/h5ayMegnEtMyhg+Cbb7pkBgX6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jHervPBo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44GKMq89026132;
	Fri, 17 May 2024 02:14:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=JInfZHlsN24Sy7UjPPOBSxjcKfod7Y98pFdcjFua1zU=; b=jH
	ervPBoSOkeXOxbKNmQgWGzcdadLpnubr2SnqaMIcIb9zz+AFW4fU83iR1Nlilzfr
	euxis3cmh9Y8L1igfRILnGWGG1I3rg2WfRFBLhuzBowSX4LaUBr1Kfo9uQrfxRfg
	noz7wYGMm/iRzL7KAOlmVzYTIPPupSvKvxVmyddBKsTksjidoXuHYTbILQh9KLCr
	Hp+BknqTG4ugSKkYMMrtUXWcZo3yTItXjspZYoyuCWijeWNdaAlI/YfM864/q/07
	te3Ea48UokeYXfTgFY+CjLDI2vlk0AvmIpRJqpp6IAA9dzDFwTsYVtLnndU4y6Xd
	uLKBZxrCUkkDSkRq9RWQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y49ft6rcq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 May 2024 02:14:30 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44H2EUde002350
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 May 2024 02:14:30 GMT
Received: from [10.111.174.12] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 16 May
 2024 19:14:28 -0700
Message-ID: <f16c897e-2b31-4a06-9ae2-7468d7b45c92@quicinc.com>
Date: Fri, 17 May 2024 10:14:23 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix the issue that calculation of ack
 signal strength
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240511030917.65811-1-quic_lingbok@quicinc.com>
 <41dd47b4-a1cc-48f5-a91a-1d64150d8c98@quicinc.com>
 <87jzjthhph.fsf@kernel.org>
Content-Language: en-US
From: Lingbo Kong <quic_lingbok@quicinc.com>
In-Reply-To: <87jzjthhph.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _e84EojRSC4es9LOnyvEnA2EWfJyPksN
X-Proofpoint-GUID: _e84EojRSC4es9LOnyvEnA2EWfJyPksN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_07,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405170017



On 2024/5/16 23:58, Kalle Valo wrote:
> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
> 
>> On 5/10/2024 8:09 PM, Lingbo Kong wrote:
>>
>> Your subject doesn't quite make sense.
>>
>> Perhaps something like: fix ack signal strength calculation
>>
>>> Currently, the calculation of ack signal strength is incorrect.
>>>
>>> This is because before calculating the ack signal strength, ath12k need
>>> to determine whether the hardware and firmware support db2dbm, if the
>>
>> please split this run-on sentence, s/, if/. If/
>>
>>> hardware and firmware support db2dbm, do not need to add noise floor,
>>> otherwise, need to add noise floor.
>>>
>>> Besides, the value of ack_rssi passed by firmware to ath12k should be a
>>> signed number, so change its type to s8.
>>>
>>> This patch affects QCN9274 and WCN7850 because they have the same issue.
>>>
>>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>>
>>> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
>>
>> Code LGTM & Kalle can fix my comments in pending so don't respin unless there
>> are additional comments.
> 
> Fixed Jeff's comments. I also removed both db2dbm variables, I felt that
> they were not necessary. Please check:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=c7b6d4df1ac8427ac758f35b7c1aa641fa8df75f
> 

kalle, thank you very much:)

