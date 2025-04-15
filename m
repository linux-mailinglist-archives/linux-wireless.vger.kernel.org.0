Return-Path: <linux-wireless+bounces-21546-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B66A89A5A
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 12:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D797D188EBF6
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 10:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CBB21E0A8;
	Tue, 15 Apr 2025 10:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jP6uLHVj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D988633F
	for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 10:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744713245; cv=none; b=h0m2NAkTz0LDxVVcijkRpJconHcaMU+B+XFyP8ngiErmPwlIKLDLOgU0+2mAHZmWBXX5wzgH/O7ynxi2+OMS/3SEXcdmKSUTAWq8ByPArzLATryoZQpDfB9r/TJvm6VVXIu0TT4q38tFvtGVA+uppLgySnVigHwBZHDU4O8DR1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744713245; c=relaxed/simple;
	bh=W7ezv3C7CFezj6FzNQVRi1soxBl21PD3Z+5uyIS5ZRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=M9+GpGVvV6GT2clfGQhZMujLd++y/Y/LKmCwyiwx0EUUqziC5g7vbBY2U168Qnu9SKDkUGoKcyrm88EVcwP+gNDSw25YtKtxTcqvAzY9CjfJA0bZBCFqT8XzqMJfVJYwIEUeyo8DHvsI7Lsu1PX8hPFOrnvVw5429jbcQDXrPqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jP6uLHVj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F8tM6x002421;
	Tue, 15 Apr 2025 10:33:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+M69//rVJCJEotb2r3fB/lWzv3UcHCc5pQL25VvW5N4=; b=jP6uLHVjzVcGdnOz
	Qp2qe3JnzV/GN3d7ZdKglQM65eRetw3fIwI02llN7X8v9YzlOSQ3RuZoI0YREBfa
	lBTqI/+kDO4t2iB+7gcvWkkKWAZoHVkHECEclERFW2be/mQfcNt+VqsodURriTk3
	OEgWzd63VA87td4n9DIX6778WtmOC0F/DsgxjR5Cu5GdoLu3OGWc7ctQAM63KlsG
	ohcxh5bBKw/tleWA5dywMnyt0KaxcIBMmRQfCrlH6/N8QyTRLdkJZWN+Wh6mIeu0
	oCwhojnX9hVLGhevc+pmZkpzHWjic2HNuJx3t4AU7/BOBDeLZoKbkak58P2Se832
	wAPYyA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ygxjyhqf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 10:33:59 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53FAXwgQ011621
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 10:33:58 GMT
Received: from [10.133.33.156] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 15 Apr
 2025 03:33:57 -0700
Message-ID: <283c0cb1-ddce-46a3-afd0-eb50728d2967@quicinc.com>
Date: Tue, 15 Apr 2025 18:33:54 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] wifi: ath12k: monitor mode cleanup and state
 handling
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250107025621.1907-1-quic_kangyang@quicinc.com>
 <702c843b-8462-4594-91d0-75721ba5dc48@oss.qualcomm.com>
Content-Language: en-US
From: Kang Yang <quic_kangyang@quicinc.com>
In-Reply-To: <702c843b-8462-4594-91d0-75721ba5dc48@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=WecMa1hX c=1 sm=1 tr=0 ts=67fe3617 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=T5McmiZYbs39c0-wqtQA:9
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: O-Gr9geDNbI4WqWMdVPUDEPAAul_szwA
X-Proofpoint-ORIG-GUID: O-Gr9geDNbI4WqWMdVPUDEPAAul_szwA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=966 spamscore=0 malwarescore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504150074



On 4/15/2025 7:13 AM, Jeff Johnson wrote:
> On 1/6/2025 6:56 PM, Kang Yang wrote:
>> This patch-set do some cleanup and handle state variables correctly for
>> monitor mode.
>>
>> Note: The quantity of this patch set was 11 in the previous version. 8
>> of them were merged:
>> https://patchwork.kernel.org/project/linux-wireless/cover/20241022110831.974-1-quic_kangyang@quicinc.com/
>>
>> v6: update copyright for each patch.
>> v5: rebase on tag: ath/main(ath-202412191756).
>> v4: rebase on tag: ath/main(ath-202410161539).
>> v3: rebase on tag: ath/main(ath-202410111606).
>> v2: rebase on tag: ath-202410072115.
>>
>> Kang Yang (3):
>>    wifi: ath12k: optimize storage size for struct ath12k
>>    wifi: ath12k: properly handling the state variables of monitor mode
>>    wifi: ath12k: delete mon reap timer
>>
>>   drivers/net/wireless/ath/ath12k/core.c |  7 +++++-
>>   drivers/net/wireless/ath/ath12k/core.h | 27 +++++++++++------------
>>   drivers/net/wireless/ath/ath12k/dp.c   | 30 +-------------------------
>>   drivers/net/wireless/ath/ath12k/mac.c  | 13 ++++++++++-
>>   4 files changed, 32 insertions(+), 45 deletions(-)
>>
>>
>> base-commit: 09fa3b6974a1245ddd0751747609431494ba5b4f
> 
> If these changes are still applicable, can you please rebase?
> 
> Applying: wifi: ath12k: optimize storage size for struct ath12k
> Using index info to reconstruct a base tree...
> M       drivers/net/wireless/ath/ath12k/core.h
> Falling back to patching base and 3-way merge...
> Auto-merging drivers/net/wireless/ath/ath12k/core.h
> CONFLICT (content): Merge conflict in drivers/net/wireless/ath/ath12k/core.h
> Recorded preimage for 'drivers/net/wireless/ath/ath12k/core.h'
> error: Failed to merge in the changes.
> Patch failed at 0001 wifi: ath12k: optimize storage size for struct ath12k

Patch 1 just optimize storage size for struct ath12k. Seems not 
necessary, will drop.
Patch 2 already done by Karthikeyan Periyasamy, will drop.

Will send patch 3 on latest tag.


> 


