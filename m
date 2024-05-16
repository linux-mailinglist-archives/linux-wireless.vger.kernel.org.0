Return-Path: <linux-wireless+bounces-7748-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD1E8C7AC2
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 18:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB540284FC1
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 16:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1999A4C90;
	Thu, 16 May 2024 16:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="p346a+R0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603EC2555B
	for <linux-wireless@vger.kernel.org>; Thu, 16 May 2024 16:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715878656; cv=none; b=TrOUjqlZ0DiL1fD+n64ZEGC8/14Sr2eIi/JLfXlpNn7kZC012/XoP/p6M/tMdDhMiY2CncRteTBipr5buxqhR7YxUs9JCeNwSrRQaB3voi4gdQTCnib9QKd9fBcV6lYnEHh98aoVvkm6zfU7jRbuLQiA3RAyqaqv5FJnLbpZ5Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715878656; c=relaxed/simple;
	bh=JXZpr/tjPHYQBEZXL21CLTRo0CDtjXCo4VbW/fNF9r0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kEgkgSWbzeCUmfIG1RdNLAUd9LN7vKgju/dKddP8rvdlEZEqGU39hYia/bcbyLDDxejKS+kvWRWMczA7WJmVsZ1gw/kbIKSgWVdeLSDNC18hEiVZ8cXfeakhFg/gg132Ra49hnKnW2op4EyUmSbCO2psjAfrgX7IRgUNXOnJveU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=p346a+R0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44G8aVBk007510;
	Thu, 16 May 2024 16:57:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=HAN1AL839BHTJVG7+AVaXzPFUi9mygxX7kbh3GSihLY=; b=p3
	46a+R0gXILb6Rhr7QedvfrWHgMPXGZ2rnHcsK0+8VGnVx5o3Oq8uoYz58E5g6xmS
	nqG3HR7vP2+zASiElRCC7rQypclxyZUkTqJDBSgJgIRfM8p0i7MpXAIHj0lDqug+
	sNi9+EWsKgbuJ8Ru+Xj/q9GzCpEMcP652kDz65At9asf9HwQJpUa9E6myeq1B3h5
	CXtEhlEC8WCPoLYVpnFNSbKELwvfhbXXa3NIsym7LpvBATlq53tKejsunrplnfeu
	gbimhBNo7Flg4q5JLh6qUJ6jEcoFznPMCtmkB6mngRS5SevFKPEdk/E9toy71SeH
	i/oEfa1pHGED/Cz3oztw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y47f466bx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 16:57:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44GGvQnu032657
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 16:57:26 GMT
Received: from [10.110.4.82] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 16 May
 2024 09:57:25 -0700
Message-ID: <e122dacd-c8a3-4295-9df5-c1c5a03c051b@quicinc.com>
Date: Thu, 16 May 2024 09:57:24 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix the issue that calculation of ack
 signal strength
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
CC: Lingbo Kong <quic_lingbok@quicinc.com>, <ath12k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
References: <20240511030917.65811-1-quic_lingbok@quicinc.com>
 <41dd47b4-a1cc-48f5-a91a-1d64150d8c98@quicinc.com>
 <87jzjthhph.fsf@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <87jzjthhph.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: o0kdifgD9IyVV3Qg90vVTXc4SxV4Yxp3
X-Proofpoint-ORIG-GUID: o0kdifgD9IyVV3Qg90vVTXc4SxV4Yxp3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_07,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405160121

On 5/16/2024 8:58 AM, Kalle Valo wrote:
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
LGTM, thanks!

