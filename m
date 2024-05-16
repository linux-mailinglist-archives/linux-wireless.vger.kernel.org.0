Return-Path: <linux-wireless+bounces-7742-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CC38C7747
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 15:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C16BB21037
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 13:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF92F28680;
	Thu, 16 May 2024 13:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iUdIWCMx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC9314B957
	for <linux-wireless@vger.kernel.org>; Thu, 16 May 2024 13:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715864843; cv=none; b=uQGLK1HtEuHhLVZrIo/E0wLFZyXbcxbbTSLOfA5ufrN7vEheId26ExMOoHgro+esdlEoqN8lBnvxyA9qsigBMi8QJADE1mDklwQsuP+nvJK8vfeM4Z1BGsBmMn3lPlGT/Tyzm0/GErJxWuHmPLFPlRtTarNEj5UNSv32auM2Ty0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715864843; c=relaxed/simple;
	bh=6Its8koe5kSj6DYPqjm83ekrJgGn9QyZNWAEzeigaJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NQv+utl+KHLJs5OCKr7B1KN0CzKxZNLtJgs6v8sFLS+le81ms9AlTUe2QPvyS8fk1Ywr/Gnj0lGaMcPzOyC74wOh5pDzTbgFUEyTDgGVTYGa7jMyeRamDjWQhUhTAK5rcFnJYaEfoDIQ7KDxomwxyVHJHMjiPN13iJvB9Ao9Q/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iUdIWCMx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44G8X8F9021397;
	Thu, 16 May 2024 13:07:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=oA9S7trk95zZDn6Rxbq5a85hm5CGnq2wzcpTCTCQUO4=; b=iU
	dIWCMxJluOzBnb6W2II/l0Fe063OAeSQ/P4M12WEuDTgNq6q74nm7s64bws6Gys0
	E3nb+IpjQvgd/Ezay6+v1ikeXB3V+MDdh7syZX06L5iTpKwwb14SVtif0Q/Hiqdd
	1GSgjM9W3N40OKBdzkxDhE26PlegNTKMzPnaqWw7WPSwQ1i7zdmD8B8Bflrlylds
	uWwWroOV35cmhuo51XFYIys4vz68WI2DHlKFxuh+TMTfFl8K+CpM0KAV7/vSiN1m
	2IuubRf7wlzWCjA1JM/hD0KYAJRv+6S9gRQ9FpeWE3wxt12ayH7Nz8yb1X2rfvh4
	T2IUW6fSurLkFx/+gTwg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y45vbdth4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 13:07:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44GD71aW011972
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 13:07:01 GMT
Received: from [10.110.0.4] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 16 May
 2024 06:07:00 -0700
Message-ID: <423cd28b-480c-4840-a6a4-94560aa56581@quicinc.com>
Date: Thu, 16 May 2024 06:06:59 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: ath12k: Refactor Rx descriptor CMEM
 configuration
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240516000807.1704913-1-quic_periyasa@quicinc.com>
 <20240516000807.1704913-2-quic_periyasa@quicinc.com>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240516000807.1704913-2-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xr4LmuYAgvNpTTsu9SCXUpB9pzJ9BKkG
X-Proofpoint-ORIG-GUID: xr4LmuYAgvNpTTsu9SCXUpB9pzJ9BKkG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_07,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 adultscore=0 mlxlogscore=535 phishscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405160092

On 5/15/2024 5:08 PM, Karthikeyan Periyasamy wrote:
> Currently, data path Rx descriptor placed in the CMEM memory respective
> to the Rx offset. This Rx descriptor CMEM placement is not meeting the
> requirements to support inter device MLO. In inter device MLO, multiple
> devices participate in a group. The device specific Rx descriptor buffers
> transmit to multiple device REO rings. To distinguish between device
> specific Rx descriptor buffers, the CMEM setup configuration need to
> choose a different placement based on the unique identifier (device index).
> 
> Below are the CMEM configuration placement representation:
> 
> Intra-Device MLO scenario:
> 
>         Device 0                                Device 1
> 
>      +-------------+                         +-------------+
>      |             |                         |             |
>      |     Tx      |                         |     Tx      |
>      |             |                         |             |
>      +-------------+                         +-------------+
>      |             |                         |             |
>      |     Rx      |                         |     Rx      |
>      |             |                         |             |
>      +-------------+                         +-------------+
> 
> Inter-Device MLO scenario:
> 
>         Device 0                                Device 1
> 
>      +-------------+                         +-------------+
>      |             |                         |             |
>      |     Tx      |                         |     Tx      |
>      |             |                         |             |
>      +-------------+                         +-------------+
>      |             |                         |             |
>      |     Rx      |                         |   Reserved  |
>      |  Device 0   |                         |             |
>      |             |                         |             |
>      +-------------+                         +-------------+
>      |             |                         |     Rx      |
>      |   Reserved  |                         |   Device 1  |
>      |             |                         |             |
>      +-------------+                         +-------------+
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 HW2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


