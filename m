Return-Path: <linux-wireless+bounces-19792-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C49A4F572
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 04:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E4E8188D0F2
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 03:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC4C131E2D;
	Wed,  5 Mar 2025 03:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BAYtkOSA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B112E336F
	for <linux-wireless@vger.kernel.org>; Wed,  5 Mar 2025 03:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741145697; cv=none; b=BnkQyTc0sGHjy2z7PCSeZFJKyfr6DFig9X6Q5j/FrLmnuy420qrT69Xb3AKuw7fwuQo7/rjihEjGA92eckzqMFsQrl3gpCsQhcyvNvEensQjX9GTIJwTRv4nBqVLxupjJEcKXPvBnT2UgXYbfk7W5pA/7Zq9n67Ewd1K3swD7XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741145697; c=relaxed/simple;
	bh=joZOn/Db6yFBSdG/5WxQeIDwx7dCOQz07ZqvTFJ9V6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VzWl2jG3MksU7QtHIavS91GInVz23W3yCe2l5p6PGI9cVwhYoE7uoNcSOF3DohdAvjo09ZrUthUPrjcgwijKfEB+UrXQ+vrcBzXeZ2wM3bwnE5NcxDX+9aOgSThNyAB5y3BYKc+vzMKmA+IizwdCpGKSHQ157TKskQYKf3bZM0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BAYtkOSA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524NADQJ031419;
	Wed, 5 Mar 2025 03:34:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2FlNvvc+UPvgI8WplwO9q5+i/W3XJWbbt9A601jsx2Q=; b=BAYtkOSAbJes50qG
	vC6FaPoBOSF5PjDIhGEJwWAUyp1ctPDuOIUnR2+lagmE1WBv6wGKT8FCy2pXSjld
	ZX+fY56YkRX4HhEeaksi4Jqeux0GGhlRmFhILq+DXOodh7iCDZgAJmYO/YF/85/H
	ETSzLZtbajnkSGaX+9Iw5aQefEbUQ7zXy06/N9zmm+T1H5bqG0iKAB9lawYUNvum
	3YxcHVnv2uwhnJqvtA3HM56SneHUSG5SzPkHx+4WAfLhLJxHW8e6EZkU2eykvjSh
	2GgUEuDjiRID19lV0hMjqIkhnG8SJYGnUPAZBrUDHTTu0Hke0vpPWpFjcB73fhGI
	R5L2kw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6t4101-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 03:34:50 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5253YogI027029
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 5 Mar 2025 03:34:50 GMT
Received: from [10.152.194.132] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 4 Mar 2025
 19:34:48 -0800
Message-ID: <82594386-c0fb-4a32-b61d-a6df16654454@quicinc.com>
Date: Wed, 5 Mar 2025 09:04:45 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] wifi: ath12k: Pass correct channel frequency
 parameters
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250304095315.3050325-1-quic_surapk@quicinc.com>
 <d6b45785-22f9-490b-96dc-8b448b700bb9@oss.qualcomm.com>
Content-Language: en-US
From: Suraj P Kizhakkethil <quic_surapk@quicinc.com>
In-Reply-To: <d6b45785-22f9-490b-96dc-8b448b700bb9@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bTPLbWJoPY6iXlcI3hPrcrrtRlqU9y-P
X-Authority-Analysis: v=2.4 cv=KfMosRYD c=1 sm=1 tr=0 ts=67c7c65a cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=FxUxUG0ajero_kj7pugA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: bTPLbWJoPY6iXlcI3hPrcrrtRlqU9y-P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_02,2025-03-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 phishscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503050026


On 04-Mar-25 10:42 PM, Jeff Johnson wrote:
> On 3/4/2025 1:53 AM, Suraj P Kizhakkethil wrote:
>> For higher bandwidths, the channel frequency parameters passed to
>> the firmware are incorrect. Pass correct values of channel
>> frequency parameters.
>>
>> v2:
>>   - Replaced arg->band_center_freq1 to local variable center_freq1,
>>     which is initialized to arg->band_center_freq1
>>   - Rebased on ToT
>>
>> Sriram R (1):
>>    wifi: ath12k: Pass correct values of center freq1 and center freq2 for
>>      320 MHz
>>
>> Suraj P Kizhakkethil (1):
>>    wifi: ath12k: Pass correct values of center freq1 and center freq2 for
>>      160 MHz
>>
>>   drivers/net/wireless/ath/ath12k/wmi.c | 24 +++++++++++++++++++++---
>>   1 file changed, 21 insertions(+), 3 deletions(-)
>>
>>
>> base-commit: 3148fc3cf193dbbd2e14eee59468a510a38bf604
> Some reminders:
> 1) per new guidance you should have added the destination tree name (ath-next)
> as a patch tag, i.e.: [PATCH ath-next v2 0/2]
> 2) since these were trivial changes you should have propagated the
> Reviewed-by: tags that were given for the v1 patches.
>
> No need to resend for this, but please keep in mind for future reference.
>
> /jeff

Sure Jeff,

I'll ensure to follow these guidance in the future

Thanks


