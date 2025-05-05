Return-Path: <linux-wireless+bounces-22427-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 234C8AA8B54
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 05:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E275A1891E0C
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 03:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC27F8488;
	Mon,  5 May 2025 03:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="inWAg4vp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40754C6E
	for <linux-wireless@vger.kernel.org>; Mon,  5 May 2025 03:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746416919; cv=none; b=NX83b2cCPn2/D4PqD5vap5K8r3corv8pVsw3fZ7onFwBdIdUDlXfVSec+3ia1qqy1vNGZeYBZw92AJQNB0pW1sWH0M3NOqrGcrKQsMYKkRvdQ/ri2GbU/e0Qcrx0xk2lw1YdoRyR6Wx59GL9WSAFrmnffl5RGnll82gnFRIxq/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746416919; c=relaxed/simple;
	bh=9dZuWla1djYhnirfF89ua0otnKzwUiib3nor/BGvQQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Cga0M9faS3xVrigXl7Mlp1z0dC4bORJp5JkDhJqRpHG+z0qCVYoMgsluTDAQ0LtbkL2SUan6FQaE/xx5isdM9Vl/UW14za9oClO77ArigO/89ZNdVORRec3/72LeRPxiao07PYQShKAse1i1Lkjd0XaNOvkiZfNpeYOUtEUjyq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=inWAg4vp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54519M1x021562;
	Mon, 5 May 2025 03:48:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JiGbZ0jK0ixlXLOERXzZpS+yIGD83aUGnLZBtXoqsgI=; b=inWAg4vpekpnjAjA
	DWJUYaE5tIf3y4B+x2jJSWDZ4ju4+M2qvOrBNehkAeKSovPCrZbn6huwsMvprZpL
	JGKVAX7mb8EONOLoQV/TBHKU0TwtFrgXf4VGa5rjrU4R1belWa3+E1r3NvaiHqFq
	CUvT6fdMjt3MaxmDC7fhYE9BnmCW9Up+5JdTtjDXzroqjHHDnx2arH/7rzN5jwAL
	dP1ttUGe6Qaii57eQHswjQdicDO5Okat9QM6HiAyTSf14mOW6+fbG+vDJzOeCtGT
	5VPW3py5Gqeo3ML5sMaOSQv99NuZUDoeARgmzkOfXw6pAWSawsTVnZVExiWWRPdK
	ry1lAg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46dd3n2r1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 May 2025 03:48:31 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5453mUSP028588
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 May 2025 03:48:30 GMT
Received: from [10.152.194.219] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 4 May 2025
 20:48:29 -0700
Message-ID: <8522a98a-8f43-4ad5-b097-e177702e9b40@quicinc.com>
Date: Mon, 5 May 2025 09:18:14 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: remove redundant regulatory rules
 intersection logic in host
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Aishwarya R <quic_aisr@quicinc.com>
References: <20250430154211.669502-1-quic_rajson@quicinc.com>
 <b934485c-05b3-47fb-a3ad-b7e03706d0c8@oss.qualcomm.com>
Content-Language: en-US
From: Rajat Soni <quic_rajson@quicinc.com>
In-Reply-To: <b934485c-05b3-47fb-a3ad-b7e03706d0c8@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDAzNCBTYWx0ZWRfX1eEkik5UjkFL
 0VJN9nAbN64+XJtbn9xUl+1xPE437+tk53bfvuZomNTOeDBWnx75htAaOOiri8H/W82PJjmPNPF
 DTEUGVm8aMCCxQyFBTPvc9PvtSE+pVIdq9d9bpGiMyX/LPVwsaqhhKHGGdJSFDEncOTYz75pms1
 gXYgFjZVYsg75mS8WRhsaAp1JHmPHTIEhV2bxkSDpxnC/6tsDOWbuyAF3uvcnQWtjNHzAHvH1ff
 cjEWBbDxwbDwQNfbajB44HIur/pi9co5U4LpAuX4HGahNKMECiqeCHxHXduXb9iAyeHEWpE54uh
 9dO6+Ak4tKq/RmsPuIGLJSlCkrYeW4EACSJ5vcqUrWISJvZzU7J+xgHxuI4CPY1+ZpJSZoNsh/r
 1zfPuyhMtss31C1spwTd5isOwEX4tJwmQDRgWKOfqGiO7IxexLfUHzpWCOYzVmetzJtdZASf
X-Proofpoint-GUID: HgneW2nGZa4RQl00f_xI24KHFopH6lMU
X-Proofpoint-ORIG-GUID: HgneW2nGZa4RQl00f_xI24KHFopH6lMU
X-Authority-Analysis: v=2.4 cv=UNDdHDfy c=1 sm=1 tr=0 ts=6818350f cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8
 a=LRjWmmqLfYJXe2i0rwQA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_02,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 mlxscore=0 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505050034



On 5/3/2025 2:27 AM, Jeff Johnson wrote:
> On 4/30/2025 8:42 AM, Rajat Soni wrote:
>> From: Aishwarya R <quic_aisr@quicinc.com>
>>
>> Whenever there is a change in the country code settings from the
>> user, driver does an intersection of the regulatory rules for this
>> new country with the original regulatory rules which were reported
>> during initialization time.
>>
>> There is also similar logic running in firmware with a difference
>> that the intersection in firmware is only done when the country code
>> is configuration during boot up time (BDF/OTP). Firmware logic does
>> not kick in when no country code is configured during device bring
>> up time as the device is always expected to have the country code
>> configured properly in the deployment.
>>
>> There is a debug/test use case that requires absolute regulatory
>> rules to be used for a user configured country code when the device
>> is not configured with a particular country code during boot up time.
>>
>> To support the above test use case, remove the redundant regulatory
>> rules intersection logic in the host driver. Depend on the
>> intersection logic in firmware when the device comes up with
>> pre-configured country code.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00209-QCAHKSWPL_SILICONZ-1
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> Signed-off-by: Aishwarya R <quic_aisr@quicinc.com>
>> Signed-off-by: Rajat Soni <quic_rajson@quicinc.com>
>> ---
>>  drivers/net/wireless/ath/ath12k/reg.c | 164 ++------------------------
>>  drivers/net/wireless/ath/ath12k/reg.h |   3 +-
>>  drivers/net/wireless/ath/ath12k/wmi.c |  24 +---
>>  3 files changed, 14 insertions(+), 177 deletions(-)
> 
> While this applies cleanly on top of ath-next, it does not apply cleanly on
> the pending branch.
> 
> Can you please rebase on ath/main-pending, and post a v2 with ath-pending as
> the destination branch tag? Don't worry if the patchwork bot ignores it due to
> an unknown branch tag.
> 
> /jeff

Sure, jeff. I have sent [PATCH ath-pending v2] wifi: ath12k: remove redundant regulatory rules intersection logic in host.

Thanks,
Rajat Soni


