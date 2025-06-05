Return-Path: <linux-wireless+bounces-23737-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7713BACEC56
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 10:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBC397A4754
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 08:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4C8155C82;
	Thu,  5 Jun 2025 08:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Neq7VcWn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E97A7E1;
	Thu,  5 Jun 2025 08:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749113486; cv=none; b=gXhrw6kcfXgpRIUnkHSzfs6wnWdz0epEX1AXamjyKI6CaFjoTHBM/yJ5gUNmjIQ8/QGBGNr7IYghYLL16Udn993Enf9a4lFz3o66bc8QDKgYAmb7DfuCiPnj4DczArLOCrGLq/axnoCaWo8Ffhlv6JGmfvYUalJiya95sQMCx+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749113486; c=relaxed/simple;
	bh=/TWBpTUqLckT3DrWaXsEmzcremmgBcj/JH7745PePXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QEFQ/QaHun0GBRfa/JEtTUmezWKJPTOwCRiMXRCl6ZkjxlqTzsRMck9/BKaL/DMgHnihyxJdIdkx33nrhF6vR5poqYydTTwbDqdQK04hr407L66U/gy7ulamGl80iWSfHOrogRbkLJNsTEuG4h5lFM3L5D5/0Oli+03/lSoAgOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Neq7VcWn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554MVRqY013969;
	Thu, 5 Jun 2025 08:51:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/MVhH5BgyQRmWPzMx4Kwju7NRE4pyh+6F5OrfoqPe54=; b=Neq7VcWn8x3mAFVe
	ccSl51IzjFpozlgNTa2K8sQWCrOFHZo2GeYwnmPCOogc8b7ZplDCQUPzUhQ4eQ36
	8TTPUZk64HwRDYjP/Eq7fk9el/pClzLbJA33C/t5wqF2o/Pb5Wii2IrM3vpTrbdp
	AYMlgRmW4KnaFlGUpX6xrl1gB+ykPm0vRTrCE1ygP1mkQbiOQd3Bokluvz2Jo75A
	EarOJkrQk5eOHEGvyKq3qxBqZ1kAT3amxh5F/A8E6y2+tCxxGWLC3iVIMbABHrAT
	M3IL2hX3e3v0REvz4CkNrj4T1vvKkWaZ2Ez2fQx7RABADi6pwqwbKFUyhKXG92qn
	FHcUKQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 472be84e1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Jun 2025 08:51:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5558pDKH027392
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Jun 2025 08:51:13 GMT
Received: from [10.253.10.58] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 5 Jun 2025
 01:51:11 -0700
Message-ID: <e1920587-331a-4742-8cc6-46bbf187d466@quicinc.com>
Date: Thu, 5 Jun 2025 16:51:08 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] wifi: ath12k: fix dest ring-buffer corruption
To: Johan Hovold <johan@kernel.org>
CC: Johan Hovold <johan+linaro@kernel.org>,
        Jeff Johnson
	<jjohnson@kernel.org>,
        Miaoqing Pan <quic_miaoqing@quicinc.com>,
        "Remi
 Pommarel" <repk@triplefau.lt>, <linux-wireless@vger.kernel.org>,
        <ath12k@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250604144509.28374-1-johan+linaro@kernel.org>
 <257bf9e9-f4b2-4ab9-804f-b895243c924d@quicinc.com>
 <aEFY3iz2gXtF_Dgx@hovoldconsulting.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <aEFY3iz2gXtF_Dgx@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=bNYWIO+Z c=1 sm=1 tr=0 ts=68415a82 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10
 a=JD1d9eFMGJjaDxi0_EkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Q7PO0mzhGUDN8Xn91SNUTXLzBPbtYNag
X-Proofpoint-ORIG-GUID: Q7PO0mzhGUDN8Xn91SNUTXLzBPbtYNag
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDA3NyBTYWx0ZWRfX9Zddn1dXHW8d
 wZlV6cC13jYAUZJWNs7Kc98vzjexy/gwemgZugM5aZv3uFME2G15z3jRp8wsU79q58UWZR6zGdH
 J7+t7Utm7Wd4v+7Il7aFH30FhU5M2ouKU0FtyF97QVmA83pSPKYM4GnRbXM3OitUy+dUnfcwXWR
 SrFDORXPNYxdh+HwY7Hf4d5IcDO4q/F7j2Ln4mDxXn9tAGHgH/Q0brwssDRUi5o6RWdnYrtY+Og
 Yo9RRoHUC0G39POhIqJi2QQMjYxg+ugVTUVYi1lCUrnCvjOh3jwn3crQXFWb5Am0mciB2kYIEDN
 kI+bNG4jfuLYI0LgsSvbcEGjmwwX8zFNrfVEmkJk75bcrGP5NXfqbYFTP1+1IEPkuDwx5oxfGZn
 hwxbMCAq/u58Kxd+o+R5Bv2M7PA/ZBtCccCQ+CYbIb/1c+bIWQrbYGIh3/yCs3t1+ldpKVE3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_02,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 suspectscore=0 mlxscore=0 impostorscore=0 spamscore=0 clxscore=1015
 mlxlogscore=849 adultscore=0 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506050077



On 6/5/2025 4:44 PM, Johan Hovold wrote:
> On Thu, Jun 05, 2025 at 04:37:13PM +0800, Baochen Qiang wrote:
>> On 6/4/2025 10:45 PM, Johan Hovold wrote:
>>> As a follow up to commit:
>>>
>>> 	b67d2cf14ea ("wifi: ath12k: fix ring-buffer corruption")
>>>
>>> add the remaining missing memory barriers to make sure that destination
>>> ring descriptors are read after the head pointers to avoid using stale
>>> data on weakly ordered architectures like aarch64.
>>>
>>> Also switch back to plain accesses for the descriptor fields which is
>>> sufficient after the memory barrier.
>>>
>>> New in v2 are two patches that add the missing barriers also for source
>>> rings and when updating the tail pointer for destination rings.
>>>
>>> To avoid leaking ring details from the "hal" (lmac or non-lmac), the
>>> barriers are added to the ath12k_hal_srng_access_end() helper. For
>>
>> Could you elaborate? what do you mean by "leaking ring details from the 'hal'"?
> 
> The type of barrier needed depends on the type of the ring. If we add
> the barrier directly in the caller, the caller would need to know what
> kind of ring (lmac or non-lmac) it is operating on, something which is
> currently abstracted away in the hal helpers.
> 

Thanks, I get your point. I can see the difference in patch [3/4]

>>> symmetry I therefore moved also the dest ring barriers into
>>> ath12k_hal_srng_access_begin() and made the barrier conditional.
> 
> Johan


