Return-Path: <linux-wireless+bounces-5621-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CB589237F
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 19:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C54A3B22DD4
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 18:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C038529D;
	Fri, 29 Mar 2024 18:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Zb+QDcVO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1C750A72
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 18:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711737571; cv=none; b=I0khEeUu4VtyAbqhMc7IkBvSWJux3CFHDlLpw/7T/dx5IcNBhxDWU3jdtcYX0KK8JVWyvbGreduSdtKwaYYSI85Khft9ND3zcVhQR0/BHS6pPwqgGeOOFLk6kSDuOMzmuNoBavQI4hAO5jkk+P6575Ry2eoLNK57H4A218hie74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711737571; c=relaxed/simple;
	bh=icpSpN9xUOxcE2hIzIkbhqs3wHIlgjmgedlUzOxhs0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:CC:
	 In-Reply-To:Content-Type; b=OlHnagE6wsw83Iewi7Tvi9mOrOYzNjWtMT07ePHXFQvoGKQMdiR6xvetS9AGcnevz75m+leHPRAVzihhRclUbtoxoZOpfGR6gs+buLUn8KUsWWuXarnrK1NMNmiy70//XTrFxfYrxumNuvlY0Sp012r3gUwP4yTXrpTaeKo6LVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Zb+QDcVO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42THegmB022199;
	Fri, 29 Mar 2024 18:39:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from:cc
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Em1lJd6M7y/VRuMxpKSji7OJmdzscgdXtJix3bTMdMs=; b=Zb
	+QDcVOOLUsrfm4vrAgRhWLKMrwwqyaFwrqzqrv8pNu+WffYipdKhB6Ev8Y4CTTae
	Lqkiq2zknY+aR9tVdB5Xo9eJ6S+z1J1eeo969hU6bt83d6BuP4X85XtooxWil/pi
	dW/agT/Sg8AMxVoE9m7u690ygp8E+BxfSQSEpCgNK58C0A2h6hXZFIGZQIRn9QGF
	7qRR+LzaDGPL/dP9pgI5ju7gBGvtiYrKtXQtVUcYzgvzkHcRSkEtR6Dfqo5Fh+lD
	B+BIh8ew02h7er9e4BqSkwfCL/zv+K+X4uVzj9lnsxG/bmWDwr0asAUE3wrgN59m
	cn4nnJnH48LGBZl7Tnww==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5vkcrxv1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 18:39:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42TIdOxZ004871
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 18:39:24 GMT
Received: from [10.110.124.221] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 29 Mar
 2024 11:39:23 -0700
Message-ID: <216b223b-e871-42d4-8e53-59dd64efe4b9@quicinc.com>
Date: Fri, 29 Mar 2024 11:39:21 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k failed to enqueue rx buf: -28
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>,
        "open list:MEDIATEK MT76 WIRELESS
 LAN DRIVER" <linux-wireless@vger.kernel.org>
References: <5c63a3a2-29fe-444c-96f1-f87c89d7af39@gmail.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
CC: "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
In-Reply-To: <5c63a3a2-29fe-444c-96f1-f87c89d7af39@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1l8wSCrPiMHI9K15n_bBHbZyFVXTspJr
X-Proofpoint-GUID: 1l8wSCrPiMHI9K15n_bBHbZyFVXTspJr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=792 bulkscore=0 impostorscore=0 suspectscore=0 phishscore=0
 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403290165

On 3/27/2024 9:25 AM, James Prestwood wrote:
> Hi,
> 
> This error was brought to my attention in the kernel logs and I'm 
> wondering if it is of any concern:
> 
> kernel: ath11k_pci 0000:03:00.0: failed to enqueue rx buf: -28
> 
> It seems to happen every few minutes or so. I don't notice any bad 
> behavior associated with it per-se, but maybe its an issue of some 
> buffer needing to be increased in size? Does this mean a frame is being 
> dropped due to no room to receive it?
> 
> Hardware we are running is:
> 
> [    4.610399] ath11k_pci 0000:03:00.0: wcn6855 hw2.1
> [    5.777030] ath11k_pci 0000:03:00.0: chip_id 0x12 chip_family 0xb 
> board_id 0xff soc_id 0x400c1211
> [    5.777039] ath11k_pci 0000:03:00.0: fw_version 0x1109996e 
> fw_build_timestamp 2023-12-19 11:11 fw_build_id 
> WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.36
> 
> Thanks,
> 
> James
> 
> 

+ ath11k list to get more specific eyes on this issue
+ bcc to internal list as well


