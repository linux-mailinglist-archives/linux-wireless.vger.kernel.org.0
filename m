Return-Path: <linux-wireless+bounces-6887-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D7D8B2AC3
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 23:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A5011C2157A
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 21:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC90A1553B9;
	Thu, 25 Apr 2024 21:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PgdvycDH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E3F153812
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 21:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714080757; cv=none; b=pf5FJpgoT9zq+8SKCzT/Ndr24WPnPJXwdutAmc/6tpJxjoQHqRcPmMX7rJ+klFYNnQ1jv4ko0EKGxU4FLK+vZkpsJ83PiROhxiroZgeulrzT8pJcrLUQrqvqeWJDDqRKNcMj4PMlRjBYRTQBtzJ+DTygVCpEBGuZhdFDYEvfQVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714080757; c=relaxed/simple;
	bh=+AibleCg1AxyuYQHOQhkh3XtIL/tdHLGcWJG2VtsIi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kzb3+1LJgeCyJVmwm4LkTATNvlogQh/t0EdPlc1sgLdSwMd8vHTwVLhugzW9FJ+f3tuqo+sAG/ne0wPFexMgJmft14DmLP32JGIWF0Nlk0CJB3HF5CkZzdQGKqQq1NJcWd7tfvokAxpFlMVMvjL1FHB0gtvXd3qFyZ0haYI137s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PgdvycDH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43PIX9H2000432;
	Thu, 25 Apr 2024 21:32:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=YCyHGq/yfn8oVcbiK6ezphHKB4JaTArhmSICj/FmeoM=; b=Pg
	dvycDHQUVCh82YjZ8Ipc7Gv+olzPwRQ9gBku57QItn9PgrGkA1uTDIKaccLBe9a6
	AB0W5DdBps+ntc+wyFVBvaO5ZRbR73F8daUugqPykUJVFvgwuTmaV0dxga5+/QTU
	fe/utivLJ8dfcOlm+W1Ch5utyLVUUGGjyTaNOPFw6jtMJ/LP9ZBet/6aXDJIPZk5
	ns3oTQS1uykyeUJ9g4GmMTmjpxS4JiYKtYGNdwZlgy5/j4hv2rCpsfa+vWWyfOFj
	pxNJsEQj3LgSSPMDRhmWWceA/dlnGdn9xMtJwn6D6zP/983ZgC25/WG/yPTObvaE
	kT9MuKOqaPuWbPa70aXQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqenpbpnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 21:32:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43PLWVrk002545
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 21:32:31 GMT
Received: from [10.110.61.159] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Apr
 2024 14:32:30 -0700
Message-ID: <994422ec-b0cd-42b9-a438-488573cb35bb@quicinc.com>
Date: Thu, 25 Apr 2024 14:32:29 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] wifi: ath12k: Introduce device group abstraction
Content-Language: en-US
To: Harshitha Prem <quic_hprem@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
References: <20240425055759.1181165-1-quic_hprem@quicinc.com>
 <20240425055759.1181165-7-quic_hprem@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240425055759.1181165-7-quic_hprem@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uqxeQ1guPpeJ6hTqLdQL9KVjCTkVeLWH
X-Proofpoint-ORIG-GUID: uqxeQ1guPpeJ6hTqLdQL9KVjCTkVeLWH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_21,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=778 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404250156

On 4/24/2024 10:57 PM, Harshitha Prem wrote:
> From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> 
> Currently, single device is probed and once firmware is ready, the device
> is registered to mac80211. For multi-link operation, different bands of
> different devices or same device would be part of a single wiphy and for
> this, hardware device group abstraction would be helpful.
> 
> Hardware device group abstraction - when there are multiple devices (with
> single radio or dual radio) that are connected by any means of interface
> for communicating between them, then these devices can be combined
> together as a single group using a group id to form a group abstraction
> and register to mac80211.
> 
> The grouping information of multiple devices would be based on device tree
> during device probe. If no such information is available then a single
> device will be part of group abstraction and registered to mac80211 else
> multiple devices advertised in device tree are combined and then registered
> to mac80211.
> 
> For device group abstraction, a base structure named ath12k_hw_group (ag)
> and the following helpers are introduced:
>         ath12k_core_hw_group_alloc()    : allocate ath12k_hw_group (ag)
>                                           based on group id and number
>                                           of devices that are going to
>                                           be part of this group.
>         ath12k_core_hw_group_free()     : free ag during deinit.
>         ath12k_core_assign_hw_group()   : assign/map the details of group
>                                           to ath12k_base (ab).
>         ath12k_core_unassign_hw_group() : unassign/unmap the details of ag
>                                           in ath12k_base (ab).
>         ath12k_core_hw_group_create()   : create the devices which are part
>                                           of group (ag).
>         ath12k_core_hw_group_destroy()  : cleanup the devices in ag
> 
> These helpers are used during device probe and mapping the group to the
> devices involved.
> 
> Please find the illustration of how multiple devices might be combined
> together in future based on group id.
> 
>                 Grouping of multiple devices (in future)
> 
> +------------------------------------------------------------------------+
> |  +-------------------------------------+       +-------------------+   |
> |  |   +-----------+ | | +-----------+   |       |   +-----------+   |   |
> |  |   | ar (2GHz) | | | | ar (5GHz) |   |       |   | ar (6GHz) |   |   |
> |  |   +-----------+ | | +-----------+   |       |   +-----------+   |   |
> |  |          ath12k_base (ab)           |       | ath12k_base (ab)  |   |
> |  |         (Dual band device)          |       |                   |   |
> |  +-------------------------------------+       +-------------------+   |
> |                 ath12k_hw_group (ag) based on group id                 |
> +------------------------------------------------------------------------+
> 
> In the above representation, two devices are combined into single group
> based on group id.
> 
> Add base code changes where single device would be part of a group with an
> invalid group id forming an group abstraction. Multi device grouping will
> be introduced in future.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Co-developed-by: Harshitha Prem <quic_hprem@quicinc.com>
> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


