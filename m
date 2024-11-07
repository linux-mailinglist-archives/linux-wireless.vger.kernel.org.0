Return-Path: <linux-wireless+bounces-15112-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E312A9C0F10
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 20:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A75632852C2
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 19:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D8A21766D;
	Thu,  7 Nov 2024 19:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JVc3ikEU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAF082C60
	for <linux-wireless@vger.kernel.org>; Thu,  7 Nov 2024 19:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731008312; cv=none; b=oLVQCUl1JvnSqzcyJEkfdgb32BtUKq7Hvo5D9razFMgWkm19tZyCNnq2LK8FmutF5JQXH/TVl7ZV+ChSeAE/HrjucHaIIbN0Ki+HU3WNm0Sr2xAbGndmF1HfuT4Zr64p1XRvQr3SJUSEHL1O1thI5Ohz+riJSO5GvJU3mOFU7CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731008312; c=relaxed/simple;
	bh=wHe4jOvQAUdApV3To6QHAMwvFAil0ayAJM9L6niayXU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=HusTJ2AAGlSJCfoK+Zl5SJqFiJNOaZrMmCSXbDzC/tRCzbd3GdFeqRvnrq7xZeVmDbsp/giSh5BDo1Q2k3wCfNPY7tJ0SUNTlhdAqsTFm6yPStL420vuDcImKVEJtcUOSyc7q1Dg2dQhO+589X+pgmCkXADlWkPhk1H8kfoMGiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JVc3ikEU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7HLdsd010195;
	Thu, 7 Nov 2024 19:38:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QqqAEE5orr95uyDNMZx7djXBF2jhuSb31zAQU+Kzogk=; b=JVc3ikEUMtDWtx1t
	iSnGBtUMr/Pk5X7xQzYgr/vk0gPRuGuyYhd3gsKhKXQD0+BDSdHBqXO65ZDH9ARe
	5ziks5zufXpOi4e9fFYMSK1zZg63V9fFc4M084cfvLldHhJm4k5y41z706G1yBww
	8MQ1Ad92wofxpsy5YTAQ+RTiNJ7/8fAUqSyIkX2IqEhueWgDRXOVY6G1V197rSHR
	aWO7W7u0eI44SRMJCILj8Jby723IKCAEUCEVv0/2AcoPC0ui9L2jBxtAbvAAq+GJ
	uLzkKVToQIA9U7nPkFOs2etuEA6G1ZbZs/zybMT/50/g7P5LcT2EAAccRA1IgzA8
	/fZ+lg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42qfdx8q4q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 19:38:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A7JcQop027022
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Nov 2024 19:38:26 GMT
Received: from [10.48.242.241] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 7 Nov 2024
 11:38:26 -0800
Message-ID: <4d88286e-c416-4c54-96af-727f62536b98@quicinc.com>
Date: Thu, 7 Nov 2024 11:38:25 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] wifi: ath12k: Support Pager, Counter, SoC,
 Transmit Rate Stats
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20241106044548.3530128-1-quic_rdevanat@quicinc.com>
 <6f995c95-d9db-4169-8216-fd1959fce2a7@quicinc.com>
Content-Language: en-US
In-Reply-To: <6f995c95-d9db-4169-8216-fd1959fce2a7@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wz-c8LUc-XABJo4ctApReyScv90yx2vr
X-Proofpoint-ORIG-GUID: wz-c8LUc-XABJo4ctApReyScv90yx2vr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070154

On 11/6/2024 4:15 PM, Jeff Johnson wrote:
> On 11/5/2024 8:45 PM, Roopni Devanathan wrote:
>> Add support to request HTT stats type 36, 37, 38 and 40 from firmware.
>> These stat types give downlink pager stats, counter and TPC stats, SoC
>> common stats and Transmit PER rate stats, respectively.
>>
>> v4:
>>  - Addressed Jeff's comments pertaining to data type conversions.
>> v3:
>>  - Added macros to fix compilation issues.
>> v2:
>>  - Removed dependencies. No change in code.
>>
>> Dinesh Karthikeyan (4):
>>   wifi: ath12k: Support Downlink Pager Stats
>>   wifi: ath12k: Support phy counter and TPC stats
>>   wifi: ath12k: Support SoC Common Stats
>>   wifi: ath12k: Support Transmit PER Rate Stats
>>
>>  .../wireless/ath/ath12k/debugfs_htt_stats.c   | 630 +++++++++++++++++-
>>  .../wireless/ath/ath12k/debugfs_htt_stats.h   | 204 +++++-
>>  2 files changed, 831 insertions(+), 3 deletions(-)
>>
>>
>> base-commit: d63fbff74ab1af1573c1dca20cfe1e876f8ffa62
> I acked 2-4/4. I can fix 1/4 in pending so no need to spin v5
> 

Please check the fixup of the 1/4 patch:
https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=e97a15b67f1417e36d799aaa1f15e3a362293475

