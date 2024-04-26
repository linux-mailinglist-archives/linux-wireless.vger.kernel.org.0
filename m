Return-Path: <linux-wireless+bounces-6934-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AAC8B3A56
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Apr 2024 16:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF204281521
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Apr 2024 14:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C79147C63;
	Fri, 26 Apr 2024 14:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UN3zRWOi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2145114533D
	for <linux-wireless@vger.kernel.org>; Fri, 26 Apr 2024 14:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714142849; cv=none; b=Mvfrkb1SiByz7pjDEafFDK0JNU8uFdJHAKuOTy36CFKXfqGYZSgcnuqHw1dRfst+Mn8ZMp3T3dmAhFc/tY5ynhJypdth5c9Ra1q7k01L4cF3bxf7aM0lEA6HCbnRQ4jYgntUSxThgDvf5gabgGyzGocnED17kLN7seHYfDp3WOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714142849; c=relaxed/simple;
	bh=mhTsvTECbgMueIie+VUva/eoBqSFRc9F3LIMk7Rzov8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pStx/0nmJlw5LdukQn3MJg6rG1rOL0cqvlXo9RrACwxXmJYU36ZU/YEn+lP+V0t5LXRB3KAbR7kt2atYqeqAwLY7SwUSn6s24BsAXaM1hiCPkcL7DBRtpevgiaWYuh2hy0URvu6ndx0LIpLgzGliWYe3fX08MNHz70NL9NPv3Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UN3zRWOi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43QDDCSW016595;
	Fri, 26 Apr 2024 14:47:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=bvOnzxvx0r7m8j8MJGOhNdJ/MtnT50SXgfeDgZXCLbM=; b=UN
	3zRWOiKLxK7biGIqJ2rTbtPO4IowwWd399oGam4jtWAiJqlKmBWGyuqvqSkT6Ehk
	27VKU1e8Yb/DRlrr9PLHqdyHhSF7QwmK2+o+hO2Y+7X65bu0wnFnaxypF1tc77lt
	HYga1DmmRXnHR3jvXRvIN/6cyRCgIvWHPWJLlYOfk8sQ/cF3s8YTLYT+tqH4Aty0
	jyrjoJ3egoEAVtrXeIFZiRDomZx8skE7hSWr6Yw6fAsfGWe5dOIAZrUFK9KrFND0
	LhZ8RHAR/swK5e2u0VKbwj27kR56tDkqzDLbqBUNBnP8aiZGe8Wgs2xMvZISKXN7
	4JqB6MN0Pj2K9VWjzR2w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xr35et53h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 14:47:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43QElMbW004278
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 14:47:22 GMT
Received: from [10.110.19.58] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 26 Apr
 2024 07:47:22 -0700
Message-ID: <b6935c08-5a7e-4c88-93a8-522f1226a274@quicinc.com>
Date: Fri, 26 Apr 2024 07:47:21 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath12k: fix flush failure in recovery scenarios
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240426015434.94840-1-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240426015434.94840-1-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: f8jfrVYj6xjV8EYi1wU3Kxuh_O2dWNfA
X-Proofpoint-ORIG-GUID: f8jfrVYj6xjV8EYi1wU3Kxuh_O2dWNfA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_12,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404260099

On 4/25/2024 6:54 PM, Baochen Qiang wrote:
> Commit eaf9f17b861b ("wifi: ath12k: relocate ath12k_dp_pdev_pre_alloc()
> call") moves ath12k_dp_pdev_pre_alloc() from ath12k_core_start() to
> ath12k_mac_allocate(), resulting in ath12k_mac_flush() failure in
> recovery scenarios:
> 
> [ 6849.684104] ath12k_pci 0000:04:00.0: pdev 0 successfully recovered
> [ 6854.907320] ath12k_pci 0000:04:00.0: failed to flush transmit queue 0
> [ 6860.027353] ath12k_pci 0000:04:00.0: failed to flush transmit queue 0
> [ 6865.143385] ath12k_pci 0000:04:00.0: failed to flush transmit queue 0
> 
> This is because, with ath12k_dp_pdev_pre_alloc() moved to ath12k_mac_allocate(),
> dp->num_tx_pending is not reset due to ATH12K_FLAG_REGISTERED set in
> recovery scenarios.
> 
> So a possible fix would be to reset that counter at some proper point,
> just like the old design. But considering that the counter tracks number
> of packets pending to be freed or returned to mac80211, forcefully reset
> it might make it hard to expose some real issues. For example if somehow
> ath12k fails to free/return some TX packets, we don't know that because
> no warnings any more.
> 
> That is to say we should not reset that counter during recovery (which is
> already done due to above commit), instead should decrease it each time
> a packet is freed/returned. Currently almost each related function has
> this logic implemented, except ath12k_dp_cc_cleanup(). So add the same
> there to fix this issue.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


