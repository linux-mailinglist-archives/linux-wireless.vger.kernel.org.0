Return-Path: <linux-wireless+bounces-4752-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECBD87BF99
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 16:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C80701F2309B
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 15:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA45671738;
	Thu, 14 Mar 2024 15:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ji0A/bQe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35656DDD9
	for <linux-wireless@vger.kernel.org>; Thu, 14 Mar 2024 15:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710428946; cv=none; b=gGsY/cQtZNH9JXvDbnMwVJio+tgk9Sosn6ZTgmtsPN59ucKp3DGI3WMQuFc6MrTmYZfcUOrUXUnDA/2Q5gq2NMD2BNNeP+DZHWVdXxDkmhzVqZaslTnp/PfWO6Uhsxg+pu/RqOwhhIh7L2kVyI5RsI0PSshFNNuTsnFxhacBUUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710428946; c=relaxed/simple;
	bh=9APMwM3wiUi55+KJ9Q0//+XZJGAdFLPIhRPM3kGR9fE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PeyNo5EcqSlKvztXQ9SivpejZck1M9CjkNLWJnlic3flQNQXWB2ssj/Zx8b6We0gq0nBkUuB03E2fLQ4RLZx3aznRrQnp/KB4QCNCuZ5ZYGrKHbW1IbzgMrWPe0VgkuhWI04voF0MON7Wz3dfHeOJaiRZxbkoCy3paIxE2LXQ14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ji0A/bQe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42EBt958013078;
	Thu, 14 Mar 2024 15:08:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=J4W3RTEmNxYpcH32NJfuCdJa8JlrK6HFykT4ITaYflQ=; b=ji
	0A/bQevxLLK33mX2iZHVwskuxiVW7dd7z4dQFVxEpTIsl7uQLSc2otZGo3GQEDN2
	TiAvyGUDLV33wUbM4sSe6drPinQ4JYmZ78dv27FBuu3AK9RU+Xwmsc8vt6pcYnq2
	xNuLLjMr2X5vP2m4aYQILm885BNLZt11o95kFLCJ9vBPWmL6/JFP49WEdcTqEkRa
	yHtnjSr67cCwXPsFHLDYIvxEzcuF4znHwX1LXnBvUu/FfJ3zeXzHh27HDPtCz55e
	dosqoEQOSe7VL64Hi5G3igcFLXC+eEEy8GyWQFt1A34nv7xmC2JoSsEilxKDtywf
	BoI+szSCXaJszqAO0scg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wuy3y8n16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 15:08:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42EF8wYD011667
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 15:08:58 GMT
Received: from [10.110.27.195] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 14 Mar
 2024 08:08:57 -0700
Message-ID: <2f94602e-5e77-4e79-b6f1-5612133a31ba@quicinc.com>
Date: Thu, 14 Mar 2024 08:08:57 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix memory leak in ath12k_pci_remove()
Content-Language: en-US
To: Miaoqing Pan <quic_miaoqing@quicinc.com>, <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240314012746.2729101-1-quic_miaoqing@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240314012746.2729101-1-quic_miaoqing@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3WbC36bjTIToziWwH-XPMLxiniBBamNX
X-Proofpoint-ORIG-GUID: 3WbC36bjTIToziWwH-XPMLxiniBBamNX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_12,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=785
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403140112

On 3/13/2024 6:27 PM, Miaoqing Pan wrote:
> Kmemleak reported this error:
> 
>   unreferenced object 0xffff1c165cec3060 (size 32):
>     comm "insmod", pid 560, jiffies 4296964570 (age 235.596s)
>     backtrace:
>       [<000000005434db68>] __kmem_cache_alloc_node+0x1f4/0x2c0
>       [<000000001203b155>] kmalloc_trace+0x40/0x88
>       [<0000000028adc9c8>] _request_firmware+0xb8/0x608
>       [<00000000cad1aef7>] firmware_request_nowarn+0x50/0x80
>       [<000000005011a682>] local_pci_probe+0x48/0xd0
>       [<00000000077cd295>] pci_device_probe+0xb4/0x200
>       [<0000000087184c94>] really_probe+0x150/0x2c0
> 
> The firmware memory was allocated in ath12k_pci_probe(), but not
> freed in ath12k_pci_remove() in case ATH12K_FLAG_QMI_FAIL bit is
> set. So call ath12k_fw_unmap() to free the memory.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.2.0-02280-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
> 
> Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


