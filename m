Return-Path: <linux-wireless+bounces-7079-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EAC8B8D42
	for <lists+linux-wireless@lfdr.de>; Wed,  1 May 2024 17:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CECD28B079
	for <lists+linux-wireless@lfdr.de>; Wed,  1 May 2024 15:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDED1C2FD;
	Wed,  1 May 2024 15:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UB99ii33"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7B412F395
	for <linux-wireless@vger.kernel.org>; Wed,  1 May 2024 15:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714577675; cv=none; b=LGPHTFsAR+N1aGO8GiiI+3b54Oo1gDilZ39EZdSB1AePMKzag2Mfl3uX12//AiAb+V/RL2KwNS8NVGG2hwBVTZRnoijxSZauHydthDm+SlNaaQzcM1JG9qrlV59t0lxrTRXn28TlIPE1hN1w9DDvCIe4okc+gGmmWjLE3S/KZvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714577675; c=relaxed/simple;
	bh=D9LeN0TAZoJmsUtu4onnzt9IlTNREDZHvNECBAzhUgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=h0EmA5/9yoHqk+XjrlASqauHo8n6WzU3Lm0ckUbD9T4a1Cy9gO3Pbxxia1Dd9I0cvMt71frHkbeW0RC/0oXMsKem8lpu6AzzS7UDanGffzUlJP5lnmWLjMhL9e+LXw+I/R057H5OMkyMLXG+pkga32JitUNfMzjbzSYtJENi+po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UB99ii33; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 441Bnx9q009312;
	Wed, 1 May 2024 15:34:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=d3z4gnYwvECJLlfvck2YkKbkaGeicKfs2PQmY7Pzr3U=; b=UB
	99ii33f76hz1+A0dvnwJIkXkm840biV7iRJqVomEqKWQEKJ/UEwv2Xw1Cczjr0AN
	Z2P3P1txWaxrlKoABxPPXMXpmUTjqSzNhSCVq/UR5ACEXH/GNPQeD0DnbN9/KMAm
	yfcxdb9NhuUxwuASRtW9wZGOqU+FjUe2mPmRuSvNIKz4kxFCTq0H4RkzdABmchiQ
	0aXge/BdklzFn2/A3khV2qXldIUSq/gVOnygrOlcbyHgXlXhypKRpG7Lu0GC5Md5
	h+5WmmT/3fZUQFsiLPQJsvPF2R4E4wWs3/RMlrvvIUEHEINSDZTbeOhsNzBEn61z
	dmLfxi+WzzbLXbsd9EUQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xueu91570-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 May 2024 15:34:10 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 441FY951012602
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 1 May 2024 15:34:09 GMT
Received: from [10.216.57.16] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 1 May 2024
 08:34:07 -0700
Message-ID: <824269da-c69d-668b-4e6b-d0453c4572c1@quicinc.com>
Date: Wed, 1 May 2024 21:04:04 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH v2 0/8] wifi: ath12k: Introduce device group abstraction
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240425055759.1181165-1-quic_hprem@quicinc.com>
 <87le4voyka.fsf@kernel.org>
Content-Language: en-US
From: Harshitha Prem <quic_hprem@quicinc.com>
In-Reply-To: <87le4voyka.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mcvGBRj7deCRL4nfIv3UFSfP-uUAA35b
X-Proofpoint-ORIG-GUID: mcvGBRj7deCRL4nfIv3UFSfP-uUAA35b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_15,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=804 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 mlxscore=0 impostorscore=0 adultscore=0 bulkscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405010110



On 4/30/2024 5:24 PM, Kalle Valo wrote:
> 47] WARNING: possible circular locking dependency detected
> [  147.211599] 6.9.0-rc5-wt-ath+ #1403 Not tainted

Thank you, Kalle, for sharing the full logs. Unfortunately, I did not 
see this warning in my testbed with QCN9274.

Seems like during rmmod case, ath12k_core_soc_destroy() is invoked with 
ag->mutex lock which in-turn invokes ath12k_qmi_deinit_service() where 
cancel_work_sync for qmi events are called. So, if 
ATH12K_QMI_EVENT_FW_READY was in queue during rmmod, it would hit a 
deadlock as in core start it requires ag->mutex lock. But, this scenario 
is quite unlikely to occur where rmmod and FW_READY event are going to 
be in parallel. Nevertheless, it has to be addressed. I will check 
further on this warning and see how to address this.

Thanks,
Harshitha

