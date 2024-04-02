Return-Path: <linux-wireless+bounces-5738-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A0F894870
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Apr 2024 02:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 780BD1C214E1
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Apr 2024 00:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C3D81E;
	Tue,  2 Apr 2024 00:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="H6Z58wDM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F5033C5
	for <linux-wireless@vger.kernel.org>; Tue,  2 Apr 2024 00:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712017230; cv=none; b=nM4jRiPIfAnxvnQ6EqqSVT6S7CgrGq/GHn686arwFLSMVHhy8v0wn+B/6Bihdu9L00qg33xm9+BluloUFd6mYoH/PsQtJQQkHBt0LSRy+gP+seTt2FK2YirVR0kpmKHkkaQnHeWi1yrPCjYmMgjdJzg4iF53PdeD5RLxCO0d/uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712017230; c=relaxed/simple;
	bh=nafcegMkMFVELELQYHobCRjmwcX6fnikKCypC1fK0bk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ut8Xn3axz0fopNLGtWNiiJMROdbB3/FpjNVwtpYqXk3F+CKS0hRcd48aE1IXRQW8xFRhnYagscQ0lWD5w2Iz5TMkMZVZQytBkmYpjifFOiqJ0Pzaa/Je30b9pohHkz5bvnCYMoC+wbjRGSc5JN2Szh3hpLunnpERAL6tY6bac9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=H6Z58wDM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 431NxCbo025645;
	Tue, 2 Apr 2024 00:20:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=8YyxJ9OgOukRr1mrdTMA2vKHNbee0gdUvwA6crGCyKs=; b=H6
	Z58wDMQiXaGbXPUVBGtbQRSjSkrApVluPpJxWUoW7UmWiHX+HP1iMng+MkuOM4FY
	F+CpXXoHLsaDTSlCnhhwJh2W15IgUJd3ylE/TY+t7EzKfmN9CfDg/JDjuDlfrWVv
	tn5JL3mvlKHfMzQuYfCRoIBlLTiXAaQHcDG1REGx2Ha7R0cTEuJIQecnaxX2Ee8T
	93VxGPszpBLPkuiJ7KMO9tkLHSAr7cS5heWUQ0sHse1RcxzHi2bjhv2DlSvDACU/
	mvYKeHIbd4ecO39ygwMSu4lt4rzKPVU9W5gpjyFudpxggyv8m7DYPDTgfxtlsWdD
	duyv/nNi/ZBSRj9x9IIg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x81wdgk2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 00:20:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4320KAu6006679
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Apr 2024 00:20:10 GMT
Received: from [10.253.8.187] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 1 Apr
 2024 17:20:09 -0700
Message-ID: <5b044799-1486-4a49-a71d-dff98640a16c@quicinc.com>
Date: Tue, 2 Apr 2024 08:20:06 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix flush failure in recovery scenarios
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>,
        "Vasanthakumar Thiagarajan (QUIC)" <quic_vthiagar@quicinc.com>
CC: <linux-wireless@vger.kernel.org>
References: <20240329015630.3019-1-quic_bqiang@quicinc.com>
 <dc3ee4aa-6fce-44d3-9095-b8b2846e1f4b@quicinc.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <dc3ee4aa-6fce-44d3-9095-b8b2846e1f4b@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: y_JmH8VZl-0dIutWdzPEepGmLouSDQ4P
X-Proofpoint-GUID: y_JmH8VZl-0dIutWdzPEepGmLouSDQ4P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_17,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2404010168



On 4/2/2024 1:01 AM, Jeff Johnson wrote:
> On 3/28/2024 6:56 PM, Baochen Qiang wrote:
>> Commit eaf9f17b861b ("wifi: ath12k: relocate ath12k_dp_pdev_pre_alloc()
>> call") moves ath12k_dp_pdev_pre_alloc() from ath12k_core_start() to
>> ath12k_mac_allocate(), resulting in ath12k_mac_flush() failure in
>> recovery scenarios:
>>
>> [ 6849.684104] ath12k_pci 0000:04:00.0: pdev 0 successfully recovered
>> [ 6854.907320] ath12k_pci 0000:04:00.0: failed to flush transmit queue 0
>> [ 6860.027353] ath12k_pci 0000:04:00.0: failed to flush transmit queue 0
>> [ 6865.143385] ath12k_pci 0000:04:00.0: failed to flush transmit queue 0
>>
>> This is because, with ath12k_dp_pdev_pre_alloc() moved to ath12k_mac_allocate(),
>> dp->num_tx_pending is not reset due to ATH12K_FLAG_REGISTERED set in
>> recovery scenarios.
>>
>> So a possible fix would be to reset that counter at some proper point,
>> just like the old design. But considering that the counter tracks number
>> of packets pending to be freed or returned to mac80211, forcefully reset
>> it might make it hard to expose some real issues. For example if somehow
>> ath12k fails to free/return some TX packets, we don't know that because
>> no warnings any more.
>>
>> That is to say we should not reset that counter during recovery (which is
>> already done due to above commit), instead should decrease it each time
>> a packet is freed/returned. Currently almost each related function has
>> this logic implemented, except ath12k_dp_cc_cleanup(). So add the same
>> there to fix this issue.
>>
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
>>
>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> 
> Do we have QCN9274 test results?
I was thinking this also applies to QCN9274 and should not cause any 
regression because it is quite a straightforward change.

Anyway, more tests more convincing.

Hi Vasanth, could you help with SSR test on this patch? Considering that 
debugfs patches and firmware-assert patch are not included in ath.git, 
you may need to find a way to simulate firmware crash to trigger SSR 
process. Please let me know if you have any issues in that.

> 

