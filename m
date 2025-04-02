Return-Path: <linux-wireless+bounces-21071-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC122A78E56
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 14:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70B713B61E0
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 12:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A998B239562;
	Wed,  2 Apr 2025 12:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oTvPllBL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3BF20E01D;
	Wed,  2 Apr 2025 12:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743596623; cv=none; b=OUOrlSsQZQldqcnYSo16go3xxtokFFFNxXEhIogsmRwB+2wdNrgm0weG7WyIGSBiOvLWehKUv64T8ba/9IWBwSjF9/UnK3PC4+T6jcFa96DM06+JMsfW255VY+TntriKolbYTEHqBxy103Jk81hkyMK2KGhpwSdXjoEgZR+vR04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743596623; c=relaxed/simple;
	bh=sxRCMN2UqFzJH+4agENHp4HExEaVEUjCHCJeJ/xTgX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XFxW6WjooFvPu8TmkF3Ahl4L0oVufXwE7Tw2uUlpu/YmgcACSlrQ+JMhEPvJvS1uWzVIJGhjPK8bPUHVABqwdnP7oIxZ1yGTGKt1fTO3oxiR2eQsjTxnQ1OGpvweKLfbc173VPnvooP7tNCDEFzChAh0GT63yXRmg84bAFHagJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oTvPllBL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 532C0JZY007268;
	Wed, 2 Apr 2025 12:23:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xkcFHpWEAlY4rM9aIyFAYhMCRoLN5VKa+BwF+yLsfpc=; b=oTvPllBLGAaIe5u+
	OmbTk8Im+MvIdNV3CJREpZ4yrkl+jITWrbvM2mKbOp7xe01eCoB9Vpiyw1g9pFy8
	tXWfy6KJLnirJ+IaweQMrA3c0ZjzclLO5/BbOEBjroqJpV7Cg2EgP7UjfYbgwuBg
	06gVEQtZHVFQ01cY3r3oRHElotfs46J+h3z/qFwuGALsipAviWg1OAa7TL9MmTkY
	OZ3XWeUXLHXOBwl42D5Ady7H95ZlySWzCerm8oNEOHRs9Z9SDRBv9izc617JumQk
	CqZm+P6NohzDA+cDHnjzlOqampYFP6Od+dPhtLswOsYY3bINrtYYtUwRVXXeKwt6
	uN4+bA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45rh7yk8gc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Apr 2025 12:23:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 532CNRO8021059
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 2 Apr 2025 12:23:28 GMT
Received: from [10.231.195.71] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 2 Apr 2025
 05:23:25 -0700
Message-ID: <1eb3933d-9aac-4e47-a7a5-818aa18b137a@quicinc.com>
Date: Wed, 2 Apr 2025 20:23:23 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: allow APs combination when dual stations
 are supported
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
CC: <ath11k@lists.infradead.org>, <jjohnson@kernel.org>, <kvalo@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
        <quic_cjhuang@quicinc.com>, <vbenes@redhat.com>
References: <d410576f-2fc7-4de1-af51-29fbe8b14948@quicinc.com>
 <20250115130359.138890-1-jtornosm@redhat.com>
 <748a5a75-1385-4691-85c1-e9cc5eb4ffc2@oss.qualcomm.com>
Content-Language: en-US
From: "Yu Zhang (Yuriy)" <quic_yuzha@quicinc.com>
In-Reply-To: <748a5a75-1385-4691-85c1-e9cc5eb4ffc2@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=IYWHWXqa c=1 sm=1 tr=0 ts=67ed2c41 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=tPUOBYC6UmroMFteW7gA:9
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 4Q3ha7XTLwWm7TH7As6SR4qYtZIU77iW
X-Proofpoint-ORIG-GUID: 4Q3ha7XTLwWm7TH7As6SR4qYtZIU77iW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_05,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=786
 priorityscore=1501 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 clxscore=1011 spamscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504020078



On 1/16/2025 8:31 AM, Jeff Johnson wrote:
> On 1/15/2025 5:03 AM, Jose Ignacio Tornos Martinez wrote:
>> Hello Yuriy,
>>
>> Thank you for the information.
>> My platform, as you said, is just wcn6855 hw2.1, but using NetworkManager
>> with the default configuration.
>> If this is the only stopper, you can skip and not consider as a wrong case,
>> because (sorry for repeating) it is just a matter of the number of available
>> resources that can be adjusted after some research from us.
>>
>> Thanks
>>
>> Best regards
>> Jose Ignacio
> 
> Thanks,
> 
> I was hesitant to take Yuriv's patch since your problem was not fixed. But I
> guess you are already broken with the current code, so I'll take his patch,
> and then we can work on fixing any other issues from there.
> 
> Kalle, can you review? You currently have this deferred in patchwork:
> https://patchwork.kernel.org/project/linux-wireless/patch/20240829064420.3074140-1-quic_yuzha@quicinc.com/
> 
> /jeff
> 
Jeff

Could you help it?

Thanks,
Yuriy


