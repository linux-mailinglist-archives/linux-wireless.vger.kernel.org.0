Return-Path: <linux-wireless+bounces-19790-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B69A4F354
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 02:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 120893A9A75
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 01:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8214510A3E;
	Wed,  5 Mar 2025 01:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="h6hBYw4Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5893D531
	for <linux-wireless@vger.kernel.org>; Wed,  5 Mar 2025 01:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741137330; cv=none; b=KK6XmS5yrBTx/EcTlXNtEFORSFBLDepWAdIf0riXesMi4I+w2gUflSrxzBcUnkOzxpsAnhOniKdz8/4IUd4FIFFoWuzPi8Xbeh9ClYxvUXTQQoZbgipONSOod6bVftNI3u9rSsgRZ6UqUTIc8UDQyVF3nReHuGB4DV/eYtfO6yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741137330; c=relaxed/simple;
	bh=z3f4FG+tkqcHNir0R23dPYD8VfIUuKeWj4IgbFdGbZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lzrRV4lBboxstGaqSG32qeVS7ZbdpMXVB5Tl3olsewmpHCUsLa9eMgMkn94xylbP2/ZMJ8r3fgiL6Kpu+ZSzi7d3CYltdX8ikf0nKH3DsuV7iHU62ewvudHCGLtExuwPYOxY0v4t6EOhGbdnIO8KC8qlXfQ1bbP9E8nkgF8Y+Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=h6hBYw4Y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524NA1k2028897;
	Wed, 5 Mar 2025 01:15:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0SKEsUBhvI0VNgkwkt/wVqVm3AG1L3QIa5kW/uOemWU=; b=h6hBYw4YWmC/o4iI
	e9vfmAwg5IjdEYgzYufHRbI9EJp+B7jXvde9wJIAMcC6hWN/fWHQNxmq11PQY1ow
	985XklFWOriLHim6mRwzRAHoBQDk6MCORdMi5pMqEAh0U5J9NccpJ8ljB0kBXe+/
	fpCh0BtRKcYXSyLKsZv54G99Wwmn/XKg1FKmcCo87dGIUpv7TgaDWyX5B3GVdMCR
	JJW63KxKxgVtpLuI7jqPmjQUPZ1ceezFgFH8UtdAzXgu7SYICEPjTffFwJss5NLa
	LGeRiXITreB43YFetKbLHdAi2uslDWfNxWb7XAH5DlH4/8d5xg1+fgVFncMoSpDx
	8ibyow==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6tkprj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 01:15:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5251FOkn013114
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 5 Mar 2025 01:15:24 GMT
Received: from [10.216.53.74] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 4 Mar 2025
 17:15:23 -0800
Message-ID: <40d91ca0-56ae-5e27-c7b5-f857d7552048@quicinc.com>
Date: Wed, 5 Mar 2025 06:45:19 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v8 7/9] wifi: ath12k: fix NULL access in assign channel
 context handler
Content-Language: en-US
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250222151926.379652-1-quic_periyasa@quicinc.com>
 <20250222151926.379652-8-quic_periyasa@quicinc.com>
 <6eed9dae-7f4d-4757-9d49-b21aff8e802d@oss.qualcomm.com>
 <9177444b-fcd9-4b44-889c-ba38145aac69@oss.qualcomm.com>
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <9177444b-fcd9-4b44-889c-ba38145aac69@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=PMb1+eqC c=1 sm=1 tr=0 ts=67c7a5ad cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=Fg5gBSExyk0f5aqvcN4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: 7IcPfu1MLTsBbsa8Ai1XcKTK_TYcHTMb
X-Proofpoint-GUID: 7IcPfu1MLTsBbsa8Ai1XcKTK_TYcHTMb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_01,2025-03-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=908
 phishscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 mlxscore=0 adultscore=0 spamscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503050007



On 3/4/2025 11:09 PM, Jeff Johnson wrote:
> On 3/4/2025 9:36 AM, Jeff Johnson wrote:
>> On 2/22/2025 7:19 AM, Karthikeyan Periyasamy wrote:
>>> Currently, when ath12k_mac_assign_vif_to_vdev() fails, the radio handle
>>> (ar) gets accessed fom the link VIF handle (arvif) for debug logging, This
>>
>> WARNING:TYPO_SPELLING: 'fom' may be misspelled - perhaps 'from'?
>>
>>> is incorrect. In the fail scenario, radio handle is NULL. Fix the NULL
>>> access, avoid radio handle access by moving to the hardware debug logging
>>> helper function (ath12k_hw_warn).
> 
> (hit 'send' too soon -- I'll fix this in 'pending' if there are no other
> issues in the series)
> 
> 

sure, thanks for the review.

-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

