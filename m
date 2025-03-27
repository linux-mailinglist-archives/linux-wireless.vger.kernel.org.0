Return-Path: <linux-wireless+bounces-20871-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2ADA7288D
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Mar 2025 02:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B9EC3AEC41
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Mar 2025 01:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4080761FF2;
	Thu, 27 Mar 2025 01:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Glw8C/qY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB4927442;
	Thu, 27 Mar 2025 01:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743040380; cv=none; b=ASrIsO/X0VlMaUfMwohnW//X9zw/CUyZq7R6ZPHhGqNVQZ410z7WceupAhcDDf7k5ZaG3mSfrhtiyxUfo6hu18a10UrIGsk2dhz4raXjLpTaKCSlGFS7zQmPm6rvM5KtvJLo7ooJLzz8VkWhWJTUoKrM6xE2fwtfgmjP2i1Lj+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743040380; c=relaxed/simple;
	bh=zBkAjJYQcEjMZXrG4b9cIHSfPiz7R+bfxV7ouadcOVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GlJKLoQUhT6T1Vo2cmna5vlQwIJlcgwkLd5cH82qBjhALFlAtvpge8IA8bTIiz3r0nPPIFUkeWywKuL6G40BZDr6dALqTxff8OXAT44S/eSgThy/MlXSlkE+Fo6KQj+FWL4aNhUA4VdcR2wf6/Qn8H5ainLpFYZZj4phgUP1O74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Glw8C/qY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QJYcer025368;
	Thu, 27 Mar 2025 01:52:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Tk4288G6sX/3FaXUDW85OcAcHNu+8pg++zMQR478mPQ=; b=Glw8C/qYdz+Ga6iq
	fBSm2wnLXHCFzMkyvUuakjFkNE07xgieVajAIVzrxaKEfUXFcBQlbf1/GrHR4d+l
	7OzdPPixeyojQwY4L1LP0VSF+HCQeriC16rwkM9LpheCeu3E6MGjRXnTT+NXywbr
	yGJ69sDMovWDBsoJbxwm9+IocadUZ24xY8otCBCunCfyWjEr+BrOHf+WOUUg+kcK
	+GZaH0M+4hlPVAU1TPIw7oCWShmfpvhJx74pybJvd0M+1LpbjI+IoxuG64A6fG8j
	7aHbwdsA9Vrzu2EDu7OKctd/gkedTG1pA45XCSuHoaBm/Eoqq6tkxPW+jt0XLjFC
	qgoSVg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45mffcjbw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 01:52:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52R1qd6T017730
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 01:52:39 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 26 Mar
 2025 18:52:37 -0700
Message-ID: <85c7729a-c410-43c6-9819-bd7ce415f406@quicinc.com>
Date: Thu, 27 Mar 2025 09:52:33 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2 0/6] wifi: ath11k: bring hibernation support
 back
To: Julian Wollrath <jwollrath@web.de>
CC: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
	<jjohnson@kernel.org>, <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Muhammad Usama
 Anjum <usama.anjum@collabora.com>
References: <20250326-ath11k-bring-hibernation-back-v2-0-87fdc2d6428f@quicinc.com>
 <20250326184754.0ca1e54d@mayene>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <20250326184754.0ca1e54d@mayene>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=CdgI5Krl c=1 sm=1 tr=0 ts=67e4af68 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=-YL0jcYk9_dqnk2SXhsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: Z6B_ToHK48bL7IwmN5IX4aquukU3rAW3
X-Proofpoint-ORIG-GUID: Z6B_ToHK48bL7IwmN5IX4aquukU3rAW3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_09,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 phishscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503270011



On 3/27/2025 1:48 AM, Julian Wollrath wrote:
> Hi,
> 
> Am Mi, 26 Mär 2025 09:33:04 +0800
> schrieb Baochen Qiang <quic_bqiang@quicinc.com>:
> 
>> To handle the Lenovo unexpected wakeup issue [1], previously we revert
>> commit 166a490f59ac ("wifi: ath11k: support hibernation"). However we
>> need to bring it back, of course with additional changes such that
>> Lenovo machines would not break.
>>
>> For suspend (S3), as those machines work well in WoWLAN mode, the
>> thought here is that we put WLAN target into WoWLAN mode on those
>> machines while into non-WoWLAN mode (which is done in the reverted
>> commit) on other machines. This requires us to identify Lenovo
>> machines from others. For that purpose, read machine info from DMI
>> interface, match it against all known affected machines. If there is
>> a match, choose WoWLAN suspend mode, else choose non-WoWLAN mode.
>> This is done in patches [1 - 4/6]
>>
>> For hibernation (S4), non-WoWLAN mode is chosen for all machines. The
>> unexpected wakeup issue should not happen in this mode, since WLAN
>> target power is cut off. To know if the system is going to suspend or
>> to hibernate, register a notifier such that kernel can notify us of
>> such infomation. This is done in patch [5/6]
> 
> with this, I just want to confirm, everything now works as expected
> after hibernation.

Thank you for testing.

> 
> 
> Best regards,
> Julian
> 
>>
>> The last patch bring the reverted "wifi: ath11k: restore country code
>> during resume" commit back.
>>
>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=219196
>>
>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
>> ---
>> Changes in v2:
>> - fix compile warnings
>> - support hibernation on Lenovo machines listed in quirk table
>> - Link to v1:
>> https://lore.kernel.org/linux-wireless/20250320023003.65028-1-quic_bqiang@quicinc.com/
>>
>> ---
>> Baochen Qiang (6):
>>       wifi: ath11k: determine PM policy based on machine model
>>       wifi: ath11k: introduce ath11k_core_continue_suspend_resume()
>>       wifi: ath11k: refactor ath11k_core_suspend/_resume()
>>       wifi: ath11k: support non-WoWLAN mode suspend as well
>>       wifi: ath11l: choose default PM policy for hibernation
>>       Reapply "wifi: ath11k: restore country code during resume"
>>
>>  drivers/net/wireless/ath/ath11k/ahb.c  |   4 +-
>>  drivers/net/wireless/ath/ath11k/core.c | 294
>> ++++++++++++++++++++++++++++++---
>> drivers/net/wireless/ath/ath11k/core.h |  16 ++
>> drivers/net/wireless/ath/ath11k/hif.h  |  14 +-
>> drivers/net/wireless/ath/ath11k/mhi.c  |  14 +-
>> drivers/net/wireless/ath/ath11k/mhi.h  |   5 +-
>> drivers/net/wireless/ath/ath11k/pci.c  |  45 ++++-
>> drivers/net/wireless/ath/ath11k/qmi.c  |   4 +- 8 files changed, 350
>> insertions(+), 46 deletions(-) ---
>> base-commit: b6f473c96421b8b451a8df8ccb620bcd71d4b3f4
>> change-id: 20250324-ath11k-bring-hibernation-back-e11ad8e82adf
>>
>> Best regards,
> 
> 
> 


