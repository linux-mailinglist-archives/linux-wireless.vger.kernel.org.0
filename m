Return-Path: <linux-wireless+bounces-3888-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B115385EE8E
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 02:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 079891F22953
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 01:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFF911712;
	Thu, 22 Feb 2024 01:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hB2drU2D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3732E80C;
	Thu, 22 Feb 2024 01:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708564728; cv=none; b=o+mn/Vp5IcOYv1dW0h5LaEpuFcmQrYvS2Rf4c9gRD1UyPE3myTTU3DJ8JO/2OF159s7AIeG6D9GErIhLVDgEDkvuHay6RKXg0lNH2qsb84k/ihlGSLoppjeqV0cjcdKQccaxwNm4mcaxMWK6yNHTDE0y/GvMYD4S0iJqaVe3hek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708564728; c=relaxed/simple;
	bh=kVKrnFzieRStppfHlCXNxSvGCGX67ifKx4/QTDXY2Kg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=oNS0Ferh+ObX72R3HeZncWZ+KoMyZdyilS7glp9KT+qvQ4WIYiOZV7JZq5ttl+5s5U6pFNA30JHVESsUZhNDdipXlxZlBVRVhpkRIR9HV1KD3KwRuj850a4IAhJgGADgad8w1pij2q2ww+1VCQrM7uwV9A8Jqv1PxDFlqdej80A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hB2drU2D; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41M0xmYU023733;
	Thu, 22 Feb 2024 01:18:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ArWJqb9Tv0QfNj4ezCbit8uEkjVABn+N2jAT5zAb0QE=; b=hB
	2drU2DpqmnBxYFg4BRbyNnr04Y0RR4kdNV71AHj85Gtmiuz6tV4BharDL8Y4Fa2l
	xLidNkuTOK0Djr5IQLQx8PQHqlhbqCZYgxNix2exXc8NfeR3JI0QJyDpX57Jt9xI
	d1BW+1o5KfR0sdICnXGqAEQhAdlLvuG0a2fKN2k5PKA/Tb6jHITW4oeMqIBlnjU4
	Dt7ZZY80XtxvFlDcqxSXvDJN+l2UFYpST32MsWgf5rfE4tfGWXyXZrF//LGxs4+W
	WBczvDtYKEStwQUX5ftsHFun8r6CPo1RUkFzc6ZHlmwBUECOOipKBt2Ix3z8Xlly
	s9jeOUi5HUB2OGFg+EhQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wdpe6rrbh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 01:18:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41M1IgPQ029064
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 01:18:42 GMT
Received: from [10.110.34.22] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 21 Feb
 2024 17:18:41 -0800
Message-ID: <b25a5783-a9ca-4356-ae17-bbda1340b522@quicinc.com>
Date: Wed, 21 Feb 2024 17:18:41 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: pull-request: wireless-next-2024-02-20
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: Jakub Kicinski <kuba@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
CC: <netdev@vger.kernel.org>, <linux-wireless@vger.kernel.org>
References: <20240220165842.917CDC433F1@smtp.kernel.org>
 <20240221143531.56942c6e@kernel.org>
 <2dbb3ca4-78fd-4125-b13f-4ad440923291@quicinc.com>
In-Reply-To: <2dbb3ca4-78fd-4125-b13f-4ad440923291@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: z-qy4hOehcz3LBP_HelSaQANCMJj1-9T
X-Proofpoint-ORIG-GUID: z-qy4hOehcz3LBP_HelSaQANCMJj1-9T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_09,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220008

On 2/21/2024 3:34 PM, Jeff Johnson wrote:
> On 2/21/2024 2:35 PM, Jakub Kicinski wrote:
>> On Tue, 20 Feb 2024 16:58:42 +0000 (UTC) Kalle Valo wrote:
>>> Hi,
>>>
>>> here's a pull request to net-next tree, more info below. Please let me know if
>>> there are any problems.
>>>
>>> Kalle
>>>
>>> The following changes since commit b7198383ef2debe748118996f627452281cf27d7:
>>>
>>>   wifi: iwlwifi: mvm: fix a crash when we run out of stations (2024-02-08 14:55:39 +0100)
>>>
>>> are available in the Git repository at:
>>>
>>>   git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2024-02-20
>>>
>>> for you to fetch changes up to dd66185c23f71af36397bebfc99ede608dca07b6:
>>>
>>>   wifi: wilc1000: add missing read critical sections around vif list traversal (2024-02-19 18:21:36 +0200)
>>>
>>> ----------------------------------------------------------------
>>> wireless-next patches for v6.9
>>>
>>> The second "new features" pull request for v6.9.  Lots of iwlwifi and
>>> stack changes this time. And naturally smaller changes to other drivers.
>>>
>>> We also twice merged wireless into wireless-next to avoid conflicts
>>> between the trees.
>>>
>>> Major changes:
>>>
>>> stack
>>>
>>> * mac80211: negotiated TTLM request support
>>>
>>> * SPP A-MSDU support
>>>
>>> * mac80211: wider bandwidth OFDMA config support
>>>
>>> iwlwifi
>>>
>>> * kunit tests
>>>
>>> * bump FW API to 89 for AX/BZ/SC devices
>>>
>>> * enable SPP A-MSDUs
>>>
>>> * support for new devices
>>>
>>> ath12k
>>>
>>> * refactoring in preparation for Multi-Link Operation (MLO) support
>>>
>>> * 1024 Block Ack window size support
>>>
>>> * provide firmware wmi logs via a trace event
>>>
>>> ath11k
>>>
>>> * 36 bit DMA mask support
>>>
>>> * support 6 GHz station power modes: Low Power Indoor (LPI), Standard
>>>   Power) SP and Very Low Power (VLP)
>>>
>>> rtl8xxxu
>>>
>>> * TP-Link TL-WN823N V2 support
>>
>> I'm getting these on a normal (i.e. non-W=1) clang build today:
>>
>> ../drivers/net/wireless/ath/ath12k/mac.c:8000:9: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
>>  8000 |         return ret;
>>       |                ^~~
>> ../drivers/net/wireless/ath/ath12k/mac.c:7962:9: note: initialize the variable 'ret' to silence this warning
>>  7962 |         int ret, i, j;
>>       |                ^
>>       |                 = 0
>>
> 
> definitely a flaw in 6db6e70a17f6 ("wifi: ath12k: Introduce the
> container for mac80211 hw")
> 
> my setup is using gcc which isn't flagging this :(
> 
> Karthikeyan, can you submit a patch?
> 
> /jeff
> 

I see this was already fixed by:
04edb5dc68f4 ("wifi: ath12k: Fix uninitialized use of ret in
ath12k_mac_allocate()")



