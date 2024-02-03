Return-Path: <linux-wireless+bounces-3074-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEBA847FF7
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Feb 2024 04:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFDC01C21AFA
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Feb 2024 03:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8759AF9E4;
	Sat,  3 Feb 2024 03:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bDfuVn9D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06B2F9D3
	for <linux-wireless@vger.kernel.org>; Sat,  3 Feb 2024 03:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706932484; cv=none; b=uxdCt4b1fSd3pvcgC5bL5eAm6R0eiKWaJKjUMRz3sKCX5nKRSSSsmMCC6aU7uW5cqbcCR5doRFnr1R4MyA+C6+NlR9XrYvT/mHkhiZvQ9DWipLTrernEW20+1Ls5xoxesUKFyGgwOdvRpBAu3qL7HlNUKhoY/s6huhvzCPGKoEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706932484; c=relaxed/simple;
	bh=9g9ugfYKWYwqXi0UTrkZj3py1txCde6aWEo/wwHNl2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OvOhb7U5zsZUNGv6mPAMD4Jy0zuPjD3MwfZc2Xq/zFid5FSvuFncLaCjf6W2Sa5FwKC9lnh6fpRLI2wqvhqBr64s2otuxclQKXmusalk2SVgIN0P00Rezr7xZJNTvAzzFqFHoo1CNhUTjmRg8oreWqGV7JPJi486g0ywb2TxKPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bDfuVn9D; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4133ko8q007338;
	Sat, 3 Feb 2024 03:54:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=xRBp+uYPRcH/+FXk52JgfzyKgWtslx6MHOGNDNrhoOM=; b=bD
	fuVn9DXQ+CytURQm5Pl9cX5OIc2iRNgtobgNuX1MwYrF/S5Hj7nnTX5eWY4aROAf
	3KbZiVYdGkl5HpPumSeABLS+90aZkLI8vCtysy36naJYoPFMsw+MmYVEPCryeUP4
	TAVn+tXAC4gYKCLK0b2J9H6/XsVDVnhwzdrTOfAAE0lyiapUdbuBaYTTx0OJWKgB
	papg1X8wZ0Q3Dp6WkWgPQ43VbHxsxGdJfLGiviGppSbqFdauOVSUXCqGOwItuv9E
	rR7Fe18FTP9nVZBvjLfunfli5Go1axNRA/6jNENbI2bGwGaF9OZXXh7TV0l/AYsa
	L2Jt/stUNPqs2H9gIb6Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w1019skhm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 03 Feb 2024 03:54:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4133s9aG032070
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 3 Feb 2024 03:54:09 GMT
Received: from [10.253.10.10] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 2 Feb
 2024 19:54:08 -0800
Message-ID: <cb71fe6d-c22b-4d48-965f-9348eb5ebb20@quicinc.com>
Date: Sat, 3 Feb 2024 11:54:05 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: enable 802.11 power save mode in station
 mode
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240201035830.2534-1-quic_bqiang@quicinc.com>
 <875xz7t1nw.fsf@kernel.org>
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <875xz7t1nw.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dnEyT439Y9l7D2uVoKv1_61taDwlSeBA
X-Proofpoint-GUID: dnEyT439Y9l7D2uVoKv1_61taDwlSeBA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_16,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=338 clxscore=1015 adultscore=0
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402030024



On 2/2/2024 9:51 PM, Kalle Valo wrote:
> Baochen Qiang <quic_bqiang@quicinc.com> writes:
> 
>> To reduce power consumption enable 802.11 power save mode in
>> station mode. This allows both radio and CPU to sleep more.
>>
>> Only enable the mode on WCN7850, other chips don't support it
>> for now.
>>
>> To test that power save mode is running, run below command and
>> check there is no NULL Data frame seen by a sniffer:
>>          iw dev <inf> set power_save off
>>
>> And run below command, then check there is a NULL Data frame
>> in sniffer:
>>          iw dev <inf> set power_save on
>>
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
>>
>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> 
> This had simple conflicts in hw_params, please check:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=f776fd9ccb6561c4e4fdf05552a8b57a06686a90
> 
LGTM

