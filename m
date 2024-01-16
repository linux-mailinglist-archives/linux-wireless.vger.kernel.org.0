Return-Path: <linux-wireless+bounces-1959-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DAE82E89A
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 05:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 151911C229EB
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 04:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B591118B;
	Tue, 16 Jan 2024 04:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RTukTfpZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329C01118A
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jan 2024 04:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40G3retJ000644;
	Tue, 16 Jan 2024 04:50:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=QAdivOL0iqI4Cqi62ycdiX0+iy75X/hQpBLFBtppcWU=; b=RT
	ukTfpZFqSvgUO0mi552LvVSgha0EobyJxJqMNrPBlEcIrEw6e0T5kY5DzSDDmtMn
	ULRRLDlzvF4aawxlkeRYDjkotf3iWrGAIgrSAhC+IoYcIgjA187GImO1e440iNWZ
	n9OVYDLjsq8OQm0WCCY3HPtfiX8lrC5A4ckOzU/61tnhKib9g5Rgv2pLl4LuWaoR
	LKiAeeaXWzAq1fj21QQuRgkhVmn3Ofi3aPhjmL17CSQCZuQdH0l+Co2QZ1OwWmNq
	qxQzNaVo90YaE2+PipN2njXCE1W0ZWY6j8HatjvQVgMv74YouMwfHxFKTbdLrWkC
	daGxX+qkJCJkY6Ll55qA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vngm58aey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 04:50:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40G4oj6M031325
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 04:50:45 GMT
Received: from [10.50.41.2] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 15 Jan
 2024 20:50:43 -0800
Message-ID: <915171c5-7176-f7be-fd7f-f748917dfbf0@quicinc.com>
Date: Tue, 16 Jan 2024 10:20:38 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 00/10] wifi: ath12k: Refactor mac80211 callback operation
 functions
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240103063731.3356060-1-quic_periyasa@quicinc.com>
 <87r0ii7goe.fsf@kernel.org>
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <87r0ii7goe.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jAyjCtjaFfYUW8rYVtTgT32Z7uXrrLkI
X-Proofpoint-ORIG-GUID: jAyjCtjaFfYUW8rYVtTgT32Z7uXrrLkI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=479 spamscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401160034


On 1/15/2024 9:05 PM, Kalle Valo wrote:
> Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:
>
>> Currently, the existing mac80211 callback functions are defined assuming
>> each link/radio is represented by a single mac80211 hw. In order to
>> support multi link operation (MLO), need to move from the multi wiphy
>> model to a single wiphy model. However, the single wiphy model allows
>> multiple link/radio to be exposed by the same mac80211 hw. Therefore, we
>> need to separate the link/radio specific handling within the mac80211
>> callback operations. This way, the callback can be extended to support
>> multiple link/radio in the future.
>>
>> 			Current Multi wiphy Model
>>
>> +---------------+            +---------------+            +-------------+
>> |  Mac80211 hw  |            | Mac80211 hw   |            |Mac80211 hw  |
>> |  private data |            | private data  |            |private data |
>> |               |            |               |            |             |
>> |               |            |               |            |             |
>> |               |            |               |            |             |
>> |   ar (2GHz)   |            |   ar (5GHz)   |            |  ar (6GHz)  |
>> |               |            |               |            |             |
>> |               |            |               |            |             |
>> |               |            |               |            |             |
>> +---------------+            +---------------+            +-------------+
>>
>>
>>
>>
>> 			  Single wiphy Model
>>
>>                             +--------------+
>>                             | Mac80211 hw  |
>>                             | private data |
>>                             |              |
>>                             |ath12k hw (ah)|
>>                             | +----------+ |
>>                             | |ar (2GHz) | |
>>                             | +----------+ |
>>                             | |          | |
>>                             | |ar (5GHz) | |
>>                             | +----------+ |
>>                             | |          | |
>>                             | |ar (6GHz) | |
>>                             | |          | |
>>                             | +----------+ |
>>                             +--------------+
>>
>>
>> Karthikeyan Periyasamy (10):
>>    wifi: ath12k: Refactor mac callback of config
>>    wifi: ath12k: Refactor mac callback of bss info changed
>>    wifi: ath12k: Refactor mac callback of conf tx
>>    wifi: ath12k: Refactor mac callback of start
>>    wifi: ath12k: Refactor mac callback of stop
>>    wifi: ath12k: Refactor mac callback of update vif offload
>>    wifi: ath12k: Refactor mac callback of configure filter
>>    wifi: ath12k: Refactor mac callback of ampdu action
>>    wifi: ath12k: Refactor mac callback of flush
>>    wifi: ath12k: Refactor start vdev delay function
> In the pending branch I renamed the patch titles like this, an example:
>
> wifi: ath12k: refactor ath12k_mac_op_conf_tx()
>
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=bdb399b467daacabdc0e2127e03874d399f17a38

Looks fine to me.


Thanks,

Karthikeyan


