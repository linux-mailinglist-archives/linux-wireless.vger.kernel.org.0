Return-Path: <linux-wireless+bounces-6150-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 651328A0AC4
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 10:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B63C1B251F0
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 08:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE0713F01E;
	Thu, 11 Apr 2024 08:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZmbrgCVQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF10524A
	for <linux-wireless@vger.kernel.org>; Thu, 11 Apr 2024 08:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712822416; cv=none; b=Gqurnhwqyt5f91WdM2OBtBlnKn3mKRUtXz+CHD0cjUW8JQ5mtm/ko9qDHVdtjcU/LLvLX5lXow4Pdx/LSy35sdm+BvBv91HvOEP5fr44QxJwYjAJi/IMPpbqDhR7AOGT6j+aXHJH3uOHe2Xi4rrLqjY6hrzDDLLceiMJ6aRE+Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712822416; c=relaxed/simple;
	bh=M+YQLRJMEiVM9Vo0vzpQxTsnjt8gfQBW7P9bfuS9pqo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=jipoAFvB/T0YRjekSV/wXBdYyuh8U0MP2wXeaiNsc8q6t2qmtaqWwEtZgXwHEIBXaVIecqcXQsHxz+A257bWoMNLUAx/LnCWvYSIrEe9WLGJS4m4cc6T3lWSdJFzSt/XirlULiw4Yoh4Lq1BubbPexPwE7shBz9XLmmeBQyHIM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZmbrgCVQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43B7igHM032011;
	Thu, 11 Apr 2024 08:00:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=7hylFzyfijs5LQOKu5+jSq20piEtACWL1+Ic3lbFN38=; b=Zm
	brgCVQntH8p4b19NN9KVmJM8B43S1KO9zPmyjxG7BfWCjhGIVppaHIyyk61Zl3W7
	GqZ4NfaQAphZE5WGYb3Z+IcfU49QQUYgc1cKIaRoG3HMiHj7Tn+zordLtRMT+an1
	EW2mSdzllljqd2lDIdOhe+KMKSBrMYXPHlPmf9eM8rbi7kmMHJ43gNHC0Buavmg5
	fDRNcJCZ1jiIJ19EYCrZQo/7RN0ZcovZ4Zl9sFB2c8R1w6UzHWParWQ1+MDhTV29
	6KtQnnC0EQ8OOT9ntDv0hF3o169i08K/gYbjJYCVgBwg04l4igElyF7xS8xfIapx
	iCdugERObJZrktoFKcog==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xebqx8296-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 08:00:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43B806dt010429
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 08:00:06 GMT
Received: from [10.231.195.68] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 11 Apr
 2024 01:00:05 -0700
Message-ID: <347dce6b-94c6-4aa3-89ef-25525b4e72db@quicinc.com>
Date: Thu, 11 Apr 2024 16:00:02 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k failed to enqueue rx buf: -28
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
        James Prestwood
	<prestwoj@gmail.com>,
        "open list:MEDIATEK MT76 WIRELESS LAN DRIVER"
	<linux-wireless@vger.kernel.org>
CC: "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
References: <5c63a3a2-29fe-444c-96f1-f87c89d7af39@gmail.com>
 <216b223b-e871-42d4-8e53-59dd64efe4b9@quicinc.com>
 <6e8fe8cf-315c-47bb-b8db-5b17f7323109@quicinc.com>
Content-Language: en-US
In-Reply-To: <6e8fe8cf-315c-47bb-b8db-5b17f7323109@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NPTJIT34ipikYo5jNTIec3YT0P53tM2v
X-Proofpoint-ORIG-GUID: NPTJIT34ipikYo5jNTIec3YT0P53tM2v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_02,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxlogscore=757 malwarescore=0 phishscore=0 suspectscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404110057



On 4/1/2024 11:30 AM, Baochen Qiang wrote:
> 
> 
> On 3/30/2024 2:39 AM, Jeff Johnson wrote:
>> On 3/27/2024 9:25 AM, James Prestwood wrote:
>>> Hi,
>>>
>>> This error was brought to my attention in the kernel logs and I'm
>>> wondering if it is of any concern:
>>>
>>> kernel: ath11k_pci 0000:03:00.0: failed to enqueue rx buf: -28
>>>
>>> It seems to happen every few minutes or so. I don't notice any bad
>>> behavior associated with it per-se, but maybe its an issue of some
>>> buffer needing to be increased in size? Does this mean a frame is being
>>> dropped due to no room to receive it?
>>>
>>> Hardware we are running is:
>>>
>>> [    4.610399] ath11k_pci 0000:03:00.0: wcn6855 hw2.1
>>> [    5.777030] ath11k_pci 0000:03:00.0: chip_id 0x12 chip_family 0xb
>>> board_id 0xff soc_id 0x400c1211
>>> [    5.777039] ath11k_pci 0000:03:00.0: fw_version 0x1109996e
>>> fw_build_timestamp 2023-12-19 11:11 fw_build_id
>>> WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.36
>>>
>>> Thanks,
>>>
>>> James
Hi James, I was not able to reproduce this issue so wondering if you 
could help reproduce and collect logs for debug. If OK please first 
merge the debug patch which is available in patchwork:

https://patchwork.kernel.org/project/linux-wireless/patch/20240411074812.86700-1-quic_bqiang@quicinc.com/

Please also enable full ath11k log:
	modprobe ath11k debug_mask=0xffffffff
	modprobe ath11k_pci

Once enabled you should see lots of ath11k logs.

>>>
>>>
>>
>> + ath11k list to get more specific eyes on this issue
>> + bcc to internal list as well
>>
> I will look into this.
>>

