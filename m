Return-Path: <linux-wireless+bounces-3887-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B258785ED10
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 00:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3D871C21DE2
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 23:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46529126F35;
	Wed, 21 Feb 2024 23:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PpjHQgqU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89BB8663D;
	Wed, 21 Feb 2024 23:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708558498; cv=none; b=mNVfFsn1Lt9+CyQIRa7TcF6H3VRt+eAGnd/tp+ycTR4+Jon2dU5+GIhZ8zNzzQeyNhWYvvc4B0/kGX9DCiR+FvwQpihEmGfRM7iMhOxSG/JAHAoHFvaWnPgapTHSWKJKdZFeIgo96LOBLqTDOTG8zt25swZ8LIH+ss1mDGu6/+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708558498; c=relaxed/simple;
	bh=w8w7VQCrjXuPQIZp1pwi3KQFpXEKXu9wP+mvTRpkTDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lZK3H4E99hrhVc9oK3zfCYedgWuMHxgnWFzen61dkfOWlupDtIQLywAXjg1ZoTbs0d8XZuZY62CLobe6a/K+gFebv3Ls5XaG+c74HZjvDjSdvbkL8fl1P/44TzRJrOtSmpOvcIjjtReZEI6vEkhL+5EfswVdqFkn08QShGMbFCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PpjHQgqU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41LNXOlv005786;
	Wed, 21 Feb 2024 23:34:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=CF5YtNAQDr6yamJktW+zCI5Z0+7DLGgghjxGdPaZ2iM=; b=Pp
	jHQgqUr8xTqqmmI/hrrE/D8rARNxMv8IY1y9/6ipxeRXFOaWzQA/YW+ur6Ju1swR
	aJR1/5/Pz4w5SwI2BlmDhJF+HrzFp3vRoCv/Nl4L/hp7jSKKOCqjiPV2K7aWnkXg
	R8SxCRRuqV0tsg8PIJ9Y0K7Sjl+qzfzz0700m2cG76uHVB/f9L4NtyqD7sjVCg1m
	AaHuGXek41RkPv8RMjshTk3GNBO7aYZw1NAANWdzk26RJoaSpEmCsqDCgDPkAXJX
	8haG2nzh3WKFM4awsbWnZ3clCvmD0+QSRgT24s1WrrbHAFZMzhVHG2eg3r8efYHl
	q1j41Zjo6d6IcWnt3Ktw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wdfqa1pu7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 23:34:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41LNYpCn014065
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 23:34:51 GMT
Received: from [10.110.34.22] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 21 Feb
 2024 15:34:51 -0800
Message-ID: <2dbb3ca4-78fd-4125-b13f-4ad440923291@quicinc.com>
Date: Wed, 21 Feb 2024 15:34:50 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: pull-request: wireless-next-2024-02-20
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
CC: <netdev@vger.kernel.org>, <linux-wireless@vger.kernel.org>
References: <20240220165842.917CDC433F1@smtp.kernel.org>
 <20240221143531.56942c6e@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240221143531.56942c6e@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: At-f8f2VtMF61wo0sYqmQ8HFgfNU7fto
X-Proofpoint-ORIG-GUID: At-f8f2VtMF61wo0sYqmQ8HFgfNU7fto
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_09,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 bulkscore=0 suspectscore=0 spamscore=0
 clxscore=1015 phishscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210186

On 2/21/2024 2:35 PM, Jakub Kicinski wrote:
> On Tue, 20 Feb 2024 16:58:42 +0000 (UTC) Kalle Valo wrote:
>> Hi,
>>
>> here's a pull request to net-next tree, more info below. Please let me know if
>> there are any problems.
>>
>> Kalle
>>
>> The following changes since commit b7198383ef2debe748118996f627452281cf27d7:
>>
>>   wifi: iwlwifi: mvm: fix a crash when we run out of stations (2024-02-08 14:55:39 +0100)
>>
>> are available in the Git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2024-02-20
>>
>> for you to fetch changes up to dd66185c23f71af36397bebfc99ede608dca07b6:
>>
>>   wifi: wilc1000: add missing read critical sections around vif list traversal (2024-02-19 18:21:36 +0200)
>>
>> ----------------------------------------------------------------
>> wireless-next patches for v6.9
>>
>> The second "new features" pull request for v6.9.  Lots of iwlwifi and
>> stack changes this time. And naturally smaller changes to other drivers.
>>
>> We also twice merged wireless into wireless-next to avoid conflicts
>> between the trees.
>>
>> Major changes:
>>
>> stack
>>
>> * mac80211: negotiated TTLM request support
>>
>> * SPP A-MSDU support
>>
>> * mac80211: wider bandwidth OFDMA config support
>>
>> iwlwifi
>>
>> * kunit tests
>>
>> * bump FW API to 89 for AX/BZ/SC devices
>>
>> * enable SPP A-MSDUs
>>
>> * support for new devices
>>
>> ath12k
>>
>> * refactoring in preparation for Multi-Link Operation (MLO) support
>>
>> * 1024 Block Ack window size support
>>
>> * provide firmware wmi logs via a trace event
>>
>> ath11k
>>
>> * 36 bit DMA mask support
>>
>> * support 6 GHz station power modes: Low Power Indoor (LPI), Standard
>>   Power) SP and Very Low Power (VLP)
>>
>> rtl8xxxu
>>
>> * TP-Link TL-WN823N V2 support
> 
> I'm getting these on a normal (i.e. non-W=1) clang build today:
> 
> ../drivers/net/wireless/ath/ath12k/mac.c:8000:9: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
>  8000 |         return ret;
>       |                ^~~
> ../drivers/net/wireless/ath/ath12k/mac.c:7962:9: note: initialize the variable 'ret' to silence this warning
>  7962 |         int ret, i, j;
>       |                ^
>       |                 = 0
> 

definitely a flaw in 6db6e70a17f6 ("wifi: ath12k: Introduce the
container for mac80211 hw")

my setup is using gcc which isn't flagging this :(

Karthikeyan, can you submit a patch?

/jeff

