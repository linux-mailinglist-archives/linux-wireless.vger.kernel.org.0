Return-Path: <linux-wireless+bounces-6262-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 349AB8A32CE
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 17:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4238284930
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 15:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22446147C7B;
	Fri, 12 Apr 2024 15:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JBYr939c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A163C13BADA
	for <linux-wireless@vger.kernel.org>; Fri, 12 Apr 2024 15:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712936868; cv=none; b=XzNcLG9gYkk3vBFdWJkqXKRP4tmjCErrS/4zc7vRAyKZUNeDu9RPLtny8UKVaGZU4lCBpdQNryoBjSBmx2v7qPncg2nuFo8JPErFmECRoDc6l4PUI8YZIB3336Ipds9JNp+9A3v5ku0KU1QDL/FyV3jy53tkLq3Cj+EAmN+29Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712936868; c=relaxed/simple;
	bh=Mua8eSBmkxScrihoIfcyPbnJfaJ5EGjwN5QeDvTMewk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TeSXTNJd9j/bnDbSIIXx3kwoYFp9skbR2BOgzqtsBibTKfTaBF4XtCHXiqeiEPvDprJ25001mvl3RC81XzxxXAtQotPwd2qin1Uih1y/+686uC0zT00zzkuFtWwFULUpB5fZPSdRRFW9aKZvTHlugTStTEvhwo9Om5a22KcajNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JBYr939c; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43CEDI8i031115;
	Fri, 12 Apr 2024 15:47:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=xWPlCA92pTxS1RpY18IE4rrj9535hBEom20kDB6zHk8=; b=JB
	Yr939ch7pgsMGlFwFMwgBLECRB/R8AmId0T4F+LsGIEz7JyNL+8ZeghSF4XGYsGh
	gARLYZl20vtLiNxsNdFJQIdGs1EN2WEHTrkyF1AouZqCoK91eLwQ8h/NmW5JR73W
	PwFqUVm+XIbD8prOHZa6ODmArGMqLsvOQ7WXl9Zxcmyx7/sss3j3W/+wP+VibyjQ
	HfaQT+Vdw0sQd0A2DFktISCf5kfKSrAiTL2zxr5VTtqssQB/loQ49/5vdzSmwHHi
	diOPPV7O5d5BGbjbEIu/WXakVIkVC4fLTG9OZ138WR5f0bUDuTDEj9ok1e45MOKF
	n67wKa7WX7ApYarPpFmg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xf6h6r617-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 15:47:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43CFlds5024076
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 15:47:39 GMT
Received: from [10.110.37.144] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 12 Apr
 2024 08:47:39 -0700
Message-ID: <600c43f3-a069-44a6-be7a-2cc3281cf88c@quicinc.com>
Date: Fri, 12 Apr 2024 08:47:38 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] wifi: ath12k: report station mode signal strength
Content-Language: en-US
To: Lingbo Kong <quic_lingbok@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240411025322.33888-1-quic_lingbok@quicinc.com>
 <20240411025322.33888-4-quic_lingbok@quicinc.com>
 <b2a14919-6478-4a6a-bdca-e018393eac34@quicinc.com>
 <70f73d7c-4ed1-4678-9eb4-7d4594af1df9@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <70f73d7c-4ed1-4678-9eb4-7d4594af1df9@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: maszSJWR5S8ugDStKTil0OksdcGMZs5w
X-Proofpoint-GUID: maszSJWR5S8ugDStKTil0OksdcGMZs5w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_12,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=982 impostorscore=0
 bulkscore=0 spamscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404120114

On 4/12/2024 2:45 AM, Lingbo Kong wrote:
> On 2024/4/12 5:51, Jeff Johnson wrote:
>> On 4/10/2024 7:53 PM, Lingbo Kong wrote:
>>> +struct ath12k_wmi_vdev_stats {
>>
>> this name does not conform to the "Naming conventions for structures" outlined
>> at the beginning of the file:
>>   * _params is a structure which is embedded either into _cmd or _event (or
>>   * both), it is not sent individually.
>>
> 
> Oh, thanks for pointing out.
> I get what you mean, but the ath12k_wmi_vdev_stats belongs to event, so, 
> i can changes it to wmi_vdev_stats_event, i will apply it in next version.

note that _event should only be used for the first TLV in the event payload.
Any subsequent TLVs in either a command or event should use _params



