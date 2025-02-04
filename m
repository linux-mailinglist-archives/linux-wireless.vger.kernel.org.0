Return-Path: <linux-wireless+bounces-18374-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DCCA26B3C
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 06:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 165DD7A2426
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 05:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9932F142659;
	Tue,  4 Feb 2025 05:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dZYcrMEp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D36118EAD
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 05:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738646160; cv=none; b=t8v3Ns//Ck25iwjxcjChI77u03LdrpyvyO7bJpVWX0fYX0IqyT1O9dkBRfkAXPVM3dMZJc0OE458C1YdjKlvA4+nhA5L9cyZLrwyePHVBeNUlH35+JYaHI/20d0K2C2++4LVWTgK/YKnoeSJFCldixYVWCBoZZr+rZy5pjHE8LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738646160; c=relaxed/simple;
	bh=gpBS5NZuSjZwSiCsucuVlcUHeLXmnzzaVngW7nlrxGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sYX04hyDuDf4P3J1NPfIvJN5nU+vT6rqKFaYmSKX+hOecp316y97UUpgRseSawvmSDGbEhS3OrDVaVXiqRsopoBrWOsaRpk36Fz2YaginKJ45NE/bFriItSYcNS2p7+HDrcL4D67djXw815/iP79LJganBDXkkLsoZDzSzSxPr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dZYcrMEp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51457pJJ008139;
	Tue, 4 Feb 2025 05:15:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CUFSwjw9Umgi+b6yQFn5Ok0HZD9Zsi5KXC6ziORTLng=; b=dZYcrMEpyvRGL/nY
	U3mWyzO1jT7wKJMM0tCS8Folpz0F/HDVMBkv8+4TnnSaMq45vWXEoZBPAH0MyZx3
	Az2gyxAzJMT6SrcN+7PlhRos6diIWxEDo0GPuOYegYdCJl3aw4EPdCm20PWC20xr
	FoLt6XGvwBRPZ4iwG2TNEBRouEPV5lMlVSlXgECAvnsmvvZVCAQpE9u56P5BoFMb
	sndZfvlDRUOi2yh5ZUC83ESTG2cpCd9Bc3el5lslSjWCHN4EVYZFiyIZCBm44qq3
	AruHcqOWwe1qjLTloXY618S8N1zSBZ2r0Z/6Msy5CtPkJu85ixI+dW5NtPpZT1EM
	scSULQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44kcfp00fp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 05:15:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5145Fshj010157
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Feb 2025 05:15:54 GMT
Received: from [10.151.40.197] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Feb 2025
 21:15:52 -0800
Message-ID: <d5fac483-9ec9-255e-cc73-92cd97524735@quicinc.com>
Date: Tue, 4 Feb 2025 10:45:49 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v8 0/9] wifi: ath12k: Add peer extended Rx statistics
 debugfs support
Content-Language: en-US
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250204035718.3227726-1-quic_periyasa@quicinc.com>
 <901a8947-c11b-4d0a-9cdf-93c5374ddde1@oss.qualcomm.com>
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <901a8947-c11b-4d0a-9cdf-93c5374ddde1@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2s2zeYmjaj6MvvOVHBlwBIaEKCThZMME
X-Proofpoint-ORIG-GUID: 2s2zeYmjaj6MvvOVHBlwBIaEKCThZMME
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_02,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 mlxlogscore=719 malwarescore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040040



On 2/4/2025 9:54 AM, Jeff Johnson wrote:
> On 2/3/2025 7:57 PM, Karthikeyan Periyasamy wrote:
>> Currently, peer extended Rx statistics are not supported. Peer extended Rx
>> statistics are collected form the TLV data reported in the monitor status
>> Rx path. Therefore, add support for TLV tag parser handling and debugfs
>> to configure and dump the collected information. Additionally, this series
>> does not impact the WCN7850.
>>
>> v8:
>>   - Resend due to missed patches
> 
> you had received some Reviewed-by: tags in a prior version.
> if there were no significant changes to those patches you should have
> propagated the tags.
> if there were significant changes and the tags were dropped on purpose, that
> should be mentioned in the version history

No significant changes from v6 only rebase changes in v7, so i have the 
propagated tags in this version v8.

-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

