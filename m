Return-Path: <linux-wireless+bounces-20200-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47198A5D3DD
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 02:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D9B217970D
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 01:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C1612BF24;
	Wed, 12 Mar 2025 01:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Yv8ohraZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2A28635E;
	Wed, 12 Mar 2025 01:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741741917; cv=none; b=TiMkeyyw0Pd0/yiDi19KZYBATDC8jDdaFcbdNqGwJno3Ew9JgRKMqdW9ADjy4Tb6MpxeLJAp35Bf9ifcDM0GEoxhK+Zl+HWyq/KoTWT8LP2ER4TkyKh0bLRE+IW8dblHsi2SjTvg7vsWzegs5GxaKXipIMGInBAGoKSjTCAGZyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741741917; c=relaxed/simple;
	bh=3uTBEAxnrvt8VckbMbO+YWzTrvx4Ky76r0yN7Fq88/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nU6x19lkjuJw/+GhhmY4qwupsMRmM5ceR1XLQL5rRuHwh2TUqjkq+MUSW9s7QezYonIZW4TS/2JKi8QaVgMQZY6z3Xwlx6OfVfOB5Za7Ib+noyy0HOpTvuH8sCL3s3Z4s7dkNhlvYHWMiujNFsP+10c6OAYJ48Hyn9P9OYWPUU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Yv8ohraZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BMHCUh027310;
	Wed, 12 Mar 2025 01:11:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TWkh4M++TmQNIquc8+aHVhprni9QfryS5YoQKKoySWk=; b=Yv8ohraZlZrLFjfF
	V+W1U+eVBZA7PfQcKvh4VN5sAuIqwh8HT8xBkLmzbiC6gWOv/9n+nKp+q6Dt/zpN
	KoADyUWW+mJkYzX7zv4wmr4uuuInAHzlLWoKcG2mFgfbquSa6KapRVharms5vT41
	KZAyP9MeE1tnBFabNtsPEh1oB5FenJIY8n2dD93Qs9BRGn3UrHm9FdtZvVvulvCN
	+GVk+JTKXU4WLCBUIUiWf3YTH/0UKS/CxUOmiWZcpr83+ls6JpyWmAloZMCKag5+
	9YScKoAw9Roddva95Ege07RsOi8ceQSDIUc9UArqiX6BSFJCQ971/6J6svOv7ks1
	rEbPmA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2prnxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 01:11:50 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52C1BnPx009982
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 01:11:49 GMT
Received: from [10.239.29.24] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 11 Mar
 2025 18:11:47 -0700
Message-ID: <72d95d77-674e-4ae7-83b0-ab58748b8251@quicinc.com>
Date: Wed, 12 Mar 2025 09:11:45 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 ath-next 2/2] wifi: ath11k: fix HTC rx insufficient
 length
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Johan Hovold
	<johan@kernel.org>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <johan+linaro@kernel.org>
References: <20250310010217.3845141-1-quic_miaoqing@quicinc.com>
 <20250310010217.3845141-3-quic_miaoqing@quicinc.com>
 <Z866cCj8SWyZjCoP@hovoldconsulting.com>
 <7b1c5e40-b11d-421b-8c8b-117a2a53298b@quicinc.com>
 <c0cdcaf2-655b-4d22-a949-1519c552e6a4@oss.qualcomm.com>
Content-Language: en-US
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
In-Reply-To: <c0cdcaf2-655b-4d22-a949-1519c552e6a4@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=P506hjAu c=1 sm=1 tr=0 ts=67d0df56 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=_461mWaigf2Lx6hHz88A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: fZBtn93iCiPlEz8MMMF9tBzirgQJJk4p
X-Proofpoint-ORIG-GUID: fZBtn93iCiPlEz8MMMF9tBzirgQJJk4p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_01,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503120005



On 3/11/2025 11:20 PM, Jeff Johnson wrote:
> On 3/11/2025 1:29 AM, Miaoqing Pan wrote:
>> On 3/10/2025 6:09 PM, Johan Hovold wrote:
>>> I'm still waiting for feedback from one user that can reproduce the
>>> ring-buffer corruption very easily, but another user mentioned seeing
>>> multiple zero-length descriptor warnings over the weekend when running
>>> with this patch:
>>>
>>> 	ath11k_pci 0006:01:00.0: rxed invalid length (nbytes 0, max 2048)
>>>
>>> Are there ever any valid reasons for seeing a zero-length descriptor
>>> (i.e. unrelated to the race at hand)? IIUC the warning would only be
>>> printed when processing such descriptors a second time (i.e. when
>>> is_desc_len0 is set).
>>>
>>
>> That's exactly the logic, only can see the warning in a second time. For
>> the first time, ath12k_ce_completed_recv_next() returns '-EIO'.
> 
> That didn't answer Johan's first question:
> Are there ever any valid reasons for seeing a zero-length descriptor?
> 
The events currently observed are all firmware logs. The discarded 
packets will not affect normal operation. I will adjust the logging to 
debug level.

> We have an issue that there is a race condition where hardware updates the
> pointer before it has filled all the data. The current solution is just to
> read the data a second time. But if that second read also occurs before
> hardware has updated the data, then the issue isn't fixed.
> 
Thanks for the addition.

> So should there be some forced delay before we read a second time?
> Or should we attempt to read more times?
> 

The initial fix was to keep waiting for the data to be ready. The 
observed phenomenon is that when the second read fails, subsequent reads 
will continue to fail until the firmware's CE2 ring is full and triggers 
an assert after timeout. However, this situation is relatively rare, and 
in most cases, the second read will succeed. Therefore, adding a delay 
or multiple read attempts is not useful.


