Return-Path: <linux-wireless+bounces-1958-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F77482E893
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 05:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FEB21C2299F
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 04:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE2B79C3;
	Tue, 16 Jan 2024 04:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DkI/WE20"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AE979C1
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jan 2024 04:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40G1FJ11012878;
	Tue, 16 Jan 2024 04:49:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=QxXNxIjp9Bm2uBDIVOPHAoJwp45g7B1F6UItfLPQg0M=; b=Dk
	I/WE20pW9CnN+mBQvC0pyhP7oBCrHI1W8k1U9d66itrg9k4agrf2QE9HFwCqNjhi
	wmRAzQSldmMWy1Jq1Q/QQXmpMP+Ylszfdat+9xwGOP39G2UOwaXFE2TfSYH+BZpw
	zCRu4lC1/+43yiOKvlXEiSpvHb1hQqWLPrsLxh6lxn3mrQ7bA40ZdpGJwTo9sNRN
	6DKsKTvFCtIJZstEasQIBIEGtSnUT3WEHW0N2jMo8SZ9pbTIWCodG5VIQSoYGn4I
	V2xhY65WGzaGLBGfEbY3C2+C2cArXUyE61sVFmEHVFU0MEGwb3OMKDamBzHXbgLw
	FpzaIpOxAFwoQ3SHTpXw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vn28shuu7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 04:49:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40G4nIhI019680
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 04:49:18 GMT
Received: from [10.50.41.2] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 15 Jan
 2024 20:49:16 -0800
Message-ID: <250299dd-364c-2575-70e3-fc8cc6d91bf6@quicinc.com>
Date: Tue, 16 Jan 2024 10:19:12 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 4/4] wifi: ath12k: Refactor MAC un/register helper
 function
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20231206034920.1037449-1-quic_periyasa@quicinc.com>
 <20231206034920.1037449-5-quic_periyasa@quicinc.com>
 <87bk9uej0b.fsf@kernel.org>
 <269ea05b-d665-eceb-d7a1-d0ac20d341a7@quicinc.com>
 <87v87u7h1g.fsf@kernel.org>
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <87v87u7h1g.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GQ2PBIri8KGwLxb_28IvDB1nBnUCsWyL
X-Proofpoint-ORIG-GUID: GQ2PBIri8KGwLxb_28IvDB1nBnUCsWyL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 mlxscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0
 mlxlogscore=687 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401160034


On 1/15/2024 8:57 PM, Kalle Valo wrote:
> Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:
>
>>> Is there a reason why you moved these two functions from mac.c to
>>> core.c? This is mac level code anyway, right?
>> This is not fully mac level code, some parts of SoC/chip level code
>> bindup in the mac level. So i segregated the SoC level code like ab
>> related param initialization handling from the mac level procedure.
>>
>> Now, mac/radio should take care only radio level handling procedure.
>>
>> In future for MLO, SoC level can be extend easily.
> But is there a concrete reason to have the functions in core.c? In your
> following patches I couldn't see why to move these functions to core.c,
> everything seems to be suitable for mac.c.
>
> I experimented this in the pending branch and moved the functions to
> mac.c (tag ath-pending-202401151424):
>
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=bee89ac2b5755754849deaf7054828e982cc6658
>
> I also fixed your other patchsets to match that and to me it makes more
> sense to have everything in mac.c. I prefer to make core.c as simple as possible.
>
> As you can see I also made changes to the patch titles to make them more
> understandable:
>
> wifi: ath12k: refactor ath12k_mac_register() and ath12k_mac_unregister()
>
> Thoughts?


Looks fine to me.


Thanks,

Karthikeyan


