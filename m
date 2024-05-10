Return-Path: <linux-wireless+bounces-7487-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6B18C296B
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 19:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F3561C221F2
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 17:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8BA1BDCF;
	Fri, 10 May 2024 17:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Wi4MgNSj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA9418637
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 17:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715362801; cv=none; b=oK81f91Zj7YOWcXnxV9HPANcWP0y2T/LQ+SSuqRvrdl0Z3UhM7yWWvQ+ROjUZhyTuOHXJiLVo6PNkm0uKq4FWGQsRifziYj41vtyhCAaLYpuN0g5NZXdFdCvH+SGHBL05e9LdAC6BuYBo+GKG4mr1DQrQYoC24I/+C39zEKX2rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715362801; c=relaxed/simple;
	bh=2+JZf6LQxzEoGqSaioP3P9oeDGJKr/aIwt9hVlZdlfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZUMX7t1V5CX/xWkUgGBygXElNADeNmsf/w3H1p6qelGpmWDWCuCD6qWkzQWCJqQ4zxUCCjNHpmnC0rLAgKv+J2kuyGti06xKWdyDWriSN9oYoFFrjoYVx0dq84F9DGARlIbQ3JVgo5xv9fy+OYsGOhGDRX6B6w7vTCWJ/qurIqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Wi4MgNSj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44AE2uD7003607;
	Fri, 10 May 2024 17:39:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=UDBENmuMm6e2iXvigK3hBdBkmavfNI9bIsXOEpfQ7sg=; b=Wi
	4MgNSjBraN4JrZ1v74ZrFr3zdJxGPCIGGp0KVK9O13c3BGUT8pvaQNMJCAlKjTLa
	XNOVeCO0ozQcMrIu5aG41r4gC+ktc+jYEcR0h5UVNKDewEV2prauchMJ2UmNSN1i
	32esx8oOkyfgSDckOAGv0/Ipj2UMFOeMNEPlNOKtbQHw42iKKdIxmuDzdpV6mmIL
	dU1UOhScXWuIZEWf3gQQL65sQ/o3sX81KkCUIB26e2GEvNfBazp3yUuqgfngLndr
	VKv7/+tdF4WiiJnUoiMjy6T320oJrpK1yWVBMdLJt3wV1m3rGwD1p7aNaqTcTNyQ
	0E2EZiLv4R2N+12GIMqw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y16w126e4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 17:39:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44AHdutS015827
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 17:39:56 GMT
Received: from [10.110.100.57] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 10 May
 2024 10:39:56 -0700
Message-ID: <2a8ec83f-f163-4be0-8970-6b383a8ef14a@quicinc.com>
Date: Fri, 10 May 2024 10:39:56 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] wifi: ath12k: support ARP and NS offload
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240510064748.369452-1-quic_bqiang@quicinc.com>
 <20240510064748.369452-6-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240510064748.369452-6-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xMENndbD6EDXKNaIG7bOslMUYC4ZH-2n
X-Proofpoint-ORIG-GUID: xMENndbD6EDXKNaIG7bOslMUYC4ZH-2n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_12,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 mlxlogscore=568 adultscore=0 suspectscore=0
 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405100127

On 5/9/2024 11:47 PM, Baochen Qiang wrote:
> Support ARP and NS offload in WoW state.
> 
> Tested this way: put machine A with QCA6390 to WoW state,
> ping/ping6 machine A from another machine B, check sniffer to see
> any ARP response and Neighbor Advertisement from machine A.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


