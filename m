Return-Path: <linux-wireless+bounces-17387-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB68A0AFA4
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 08:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB8411886F52
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 07:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A866231A26;
	Mon, 13 Jan 2025 07:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LuK4oikp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA8F230D1C
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 07:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736752300; cv=none; b=eEdWcJF4Eyao2KDeA10daYeYquhH5ABClqGnqo9p3F60MiKrMqBW/f2N7n8w+VVoc4CrOVSqHIs2Pxx9npMykow69PVGh/u9lutGPTmntKXpJPPniGoLqMOjI0Lmd3DVsqVqESxOmC7iuzRcCNeYPSnwi44//2g/honmAr9Z7kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736752300; c=relaxed/simple;
	bh=4L2u8gU/18Q08Pe80uvkZCpMX9YOW6eL5wp/puzSnjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bgVDx134qtQLht5sFNOk4+XvT5rxwEV+QEjthSpas5Tq9KBTfSsK51UmQnpwz5i4K0gxrf5x2ctbs5kTkrh+5o07KyyCEnOek2OneXkO93IXzWRHbfJQEtaYSairrXMykvIXizox2AY+Vjbvw7S6LPfcamGFgDj84CcL+1YLSB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LuK4oikp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50D06HtJ006082;
	Mon, 13 Jan 2025 07:11:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B6e59fMeJ5eErng7YxuaoW6O2OuKCvhOaDuKpX9d7SA=; b=LuK4oikpyLYdL9ex
	wFtf08rHk/jpkifoyEOV22SmSU8TDaFpRaxjPN1NuBAOXCjfSknQ3ngLCEq6Mys8
	8SevgVJRt8JuinX1gtG4ajaiifg4TLRuMjIUYF/x1m1q9LJ5wWLItAZqT3Noj6Wg
	cBx6rnnWF7ZwzrIcy1bdpIqPsSRJsd7BzMFE1+iyMS1BAyiHcjCiJuQk610tcOLq
	LwqXZtKqpy2CxU/PApVrM2O++GxinvlQIY7h4Hw0KEK6uhXIp1CWDboBzQf3PZLi
	ZAn/O7d8DzOmGBAuFWbEd3OiX6jN9CRrJe95Dk4xZVoEl4ztG8fO3zy5ClJbtILf
	UNd66A==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 444r01rrnn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 07:11:33 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50D7BWp6007411
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 07:11:32 GMT
Received: from [10.50.33.46] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 12 Jan
 2025 23:11:31 -0800
Message-ID: <509f4fff-b547-413e-b9b0-c0060ce8d379@quicinc.com>
Date: Mon, 13 Jan 2025 12:41:23 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] wifi: ath12k: Support Sounding, Latency, Trigger,
 FSE stats
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20241224102013.1530055-1-quic_rdevanat@quicinc.com>
 <7721a8cc-ee42-4b6a-a08e-ed2ec472041f@oss.qualcomm.com>
Content-Language: en-US
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
In-Reply-To: <7721a8cc-ee42-4b6a-a08e-ed2ec472041f@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: V63SOqQ_BTmkA9Wf40YRGYAXaqWJVe1S
X-Proofpoint-ORIG-GUID: V63SOqQ_BTmkA9Wf40YRGYAXaqWJVe1S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 spamscore=0 suspectscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 mlxlogscore=999 impostorscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501130060



On 1/7/2025 2:16 AM, Jeff Johnson wrote:
> On 12/24/2024 2:20 AM, Roopni Devanathan wrote:
>> Add support to request HTT stats type 22, 25, 26, 27 and 28 from
>> firmware. These stats give sounding stats, latency stats, trigger stats
>> for uplink OFDMA and MUMIMO and FSE stats, respectively.
>>
>> Depends-on:
>> [PATCH 0/2] wifi: ath12k: Support Rate and OFDMA Stats
>> Link: https://lore.kernel.org/all/20241128110949.3672364-1-quic_rdevanat@quicinc.com/
>>
>> [PATCH v4 0/2] wifi: ath12k: Support AST and Puncture Stats
>> Link: https://lore.kernel.org/all/20241217055408.1293764-1-quic_rdevanat@quicinc.com/
>>
>> v2:
>>  - Added line breaks where necessary, as pointed out by Kalle.
>>  - Modified the use of pointer arithmetic print_array_to_buf_s8().
>>  - Modified commit logs, as suggested by Kalle. 
>>
>> Dinesh Karthikeyan (5):
>>   wifi: ath12k: Support Sounding Stats
>>   wifi: ath12k: Support Latency Stats
>>   wifi: ath12k: Support Uplink OFDMA Trigger Stats
>>   wifi: ath12k: Support Uplink MUMIMO Trigger Stats
>>   wifi: ath12k: Support Received FSE Stats
>>
>> Roopni Devanathan (1):
>>   wifi: ath12k: Add API to print s8 arrays in HTT stats
>>
>>  .../wireless/ath/ath12k/debugfs_htt_stats.c   | 736 ++++++++++++++++++
>>  .../wireless/ath/ath12k/debugfs_htt_stats.h   | 267 ++++++-
>>  2 files changed, 970 insertions(+), 33 deletions(-)
>>
>>
>> base-commit: 09fa3b6974a1245ddd0751747609431494ba5b4f
>> prerequisite-patch-id: c30df5e4af6f5773ed942d8f78de88c05ce2b18b
>> prerequisite-patch-id: f2181eee4bce2e3487db9bd81ed962f477759e7e
> 
> FYI this is not applying to my test tree. Strangely, you list two 2-patch
> dependencies but only have 2 prerequisite-patch-ids instead of 4.
> 
> I now have both "Rate and OFDMA Stats" and "AST and Puncture Stats" in the
> pending branch. Look for those to be merged, and then rebase on the main
> branch at that time.

Sure, Jeff. Now that the mentioned series are merged, I'll send out a v3.
 
> /jeff

