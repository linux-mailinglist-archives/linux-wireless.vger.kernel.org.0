Return-Path: <linux-wireless+bounces-7059-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F8E8B7E03
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 19:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C916288856
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 17:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EC217BB16;
	Tue, 30 Apr 2024 16:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Iq9Tg/9J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DE417A93B
	for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2024 16:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714496245; cv=none; b=OiCns6DoeBLd0VZGdXxtDf8CGlEDXwwvAIbVtkRc84+QZkAwA1pP/af7MRCiOfarFC9UBeJmN8lsU+wfSWNURnOjD8AW+GC3Y8P0Kc0mJhe8OJIUEIusgWprwhgLk/txpIA6Sp+dsLEAEcA0KiQJ5VSYoxoK+DoC2iem3nDZJsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714496245; c=relaxed/simple;
	bh=eEJzF8Mo9i6ahLpyJ9yzqvvEpJKRJ1RFfp+8YUrI+rs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=Go1L6w86Z4K6Sjt3cnvIxStKqO0p7MA3B3vLoiHvW7T3vycOeyMPBwNa8jBQK7iRlHMXtJP3sBNMKp0RjWCZZAuKx/UU4DkmyM9OIt+QgVFJLYVGg6v+P5QDAVlUTvxklT8XNDlwN8faFOuRsOY8t/kHh6NRVhhcxwI0mZutcD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Iq9Tg/9J; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43UFlBYM026531;
	Tue, 30 Apr 2024 16:57:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=5u/++T5IU7O1HvL4WmvUhcNvnoxGBciJpXD7+yLJh5w=; b=Iq
	9Tg/9JRGRgJbBmfw4UlVHpawUADv0iWuEq3JCJryxeJrb8HbKz/AnIeW6c0TvcDP
	gIbBLJDWbHla0CxkYPkZuUjTDo7w8XBBS29STwrIGfO2a+8cf3+9VDhnFfwLmMHG
	MENoUXJtAq/OrDT7zz7qFBuB13NYD9f3u1GEKnJqB4spZqeLxRZuMPxKiBUviZXi
	gAxgU7pz+JKdlKT2xcCR/fKCq1nzqkClO/wAeEeh7MFLlb5T6pd1oga0jnZt45uB
	vXoCDyAnzxFlz1V3mD0LPpP7JOLLv2GoiviQlqvBFzCmr7j5w4p6J+SnHEQQvG30
	jGZckyNFDLyigDEhIbOA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtw1hh9q7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 16:57:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43UGvKsF021615
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 16:57:20 GMT
Received: from [10.50.19.250] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 30 Apr
 2024 09:57:18 -0700
Message-ID: <9024a17b-ed88-11ff-2752-a326a65ed6a7@quicinc.com>
Date: Tue, 30 Apr 2024 22:27:15 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/4] wifi: ath12k: Add multi device support for WBM idle
 ring buffer setup
Content-Language: en-US
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240430054759.722620-1-quic_periyasa@quicinc.com>
 <3a42a9fb-8528-41fd-8c34-f2d9e13bc1dd@quicinc.com>
 <57fe6ced-4ebe-c48d-5ec3-430818eb4e2d@quicinc.com>
In-Reply-To: <57fe6ced-4ebe-c48d-5ec3-430818eb4e2d@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hF8DElXlyft7KqO11OYXV44edrSTpfz9
X-Proofpoint-ORIG-GUID: hF8DElXlyft7KqO11OYXV44edrSTpfz9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_10,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 bulkscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300119



On 4/30/2024 9:46 PM, Karthikeyan Periyasamy wrote:
> 
> 
> On 4/30/2024 9:38 PM, Jeff Johnson wrote:
>> On 4/29/2024 10:47 PM, Karthikeyan Periyasamy wrote:
>>> Refactor the WBM idle ring buffer setup to scalable for inter device
>>> multi-link operation.
>>>
>>> Note: This patchset rebased on top of below patch series
>>>   [PATCH v2 0/8] wifi: ath12k: Introduce device group abstraction
>>>   Link: 
>>> https://lore.kernel.org/all/20240425055759.1181165-1-quic_hprem@quicinc.com/
>>>
>>> Karthikeyan Periyasamy (4):
>>>    wifi: ath12k: Replace "chip" with "device" in hal Rx return buffer
>>>      manager
>>>    wifi: ath12k: Refactor idle ring descriptor setup
>>>    wifi: ath12k: use device index to advertise MLO parameter
>>>    wifi: ath12k: add multi device support for WBM idle ring buffer setup
>>>
>>>   drivers/net/wireless/ath/ath12k/core.c  | 10 +++++++++
>>>   drivers/net/wireless/ath/ath12k/dp.c    | 27 ++++++++++++++++++++++---
>>>   drivers/net/wireless/ath/ath12k/dp.h    |  1 +
>>>   drivers/net/wireless/ath/ath12k/dp_rx.c |  5 +++--
>>>   drivers/net/wireless/ath/ath12k/hal.c   |  5 +++--
>>>   drivers/net/wireless/ath/ath12k/hal.h   | 21 ++++++++++---------
>>>   drivers/net/wireless/ath/ath12k/qmi.c   |  4 ++--
>>>   7 files changed, 54 insertions(+), 19 deletions(-)
>>>
>>>
>>> base-commit: 861928281f22a08e3d258ebcfe7159d729ec07d4
>>> prerequisite-patch-id: 4bc84a4f5b10ebc28db60c5167abdaf343a1619d
>>> prerequisite-patch-id: ea87d2f46dbd5e7c82d5df02934906e219aa8388
>>> prerequisite-patch-id: e08d8632dcde9e891d37b538832b4ecfed140d9e
>>> prerequisite-patch-id: bc2c9455c9175c27b8b68f6f41d468b258007478
>>> prerequisite-patch-id: 00966c65589af8a50078fea94630cbe355f0dacf
>>> prerequisite-patch-id: 4bd8ce903cd89ae536109922f65f128ed1d4307c
>>> prerequisite-patch-id: 54fe8eb540a77804c8befeb695b61756c133b56f
>>> prerequisite-patch-id: 06244ca08d9bed3834dc5315470a19d096d749ee
>>> prerequisite-patch-id: 8e7575808b1c498d81b606777153e0e2d4ee99bd
>>> prerequisite-patch-id: 1baa4ce64b2054e82e117cfbe29f85870def37c7
>>> prerequisite-patch-id: 733cb4a1e0d02079820d8306a3da88fe2d35b06c
>>
>> My automation can't test this series since git reports:
>> fatal: bad object 861928281f22a08e3d258ebcfe7159d729ec07d4
>>
>> Also note that the "device group abstraction" series itself has 
>> dependencies.
>>
>> Using a base that isn't visible in the upstream ath.git is not helpful
>>
> 
> Looks like "device group abstraction" patch is block due to warning call 
> trace. Shall i remove the dependency and make the "device group 
> abstraction" patch depend on this series ?
> 

sent the next version by removing the dependency.

-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

