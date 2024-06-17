Return-Path: <linux-wireless+bounces-9133-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE75A90BC50
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 22:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 091C81C22043
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 20:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35318480;
	Mon, 17 Jun 2024 20:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="O6TPpppJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B6F18AF4
	for <linux-wireless@vger.kernel.org>; Mon, 17 Jun 2024 20:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718657129; cv=none; b=sk5JrpuS4/y1m1HyuNW8Jza5p+rLHV1gW9XKRFWOOsER6nfqb/xy1Oa6IBedV/dvjJXHzOO4Jap88OhRuDl+ejrqzOwBocLpw98ABpZ51R3NCf6xSEImaV3AighiXWSKkykXY1WI2/jIdbbvmDLPJ4yKh1CemjoG6E+cmLxUQ5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718657129; c=relaxed/simple;
	bh=dIWrRsmmIF017WkZvW0hnCV6cgi5UBYhhDmILSp9erg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=P6lAM/pJDP+xy7nhVGTPDlCXJ66VPQvVy3DSxNXAQaZf4UT19FQuvsoGyqe0GuXeH44zwdQXquRKC2lBXeAEcqjSIfs025MfdfHPu6yRHiIJ754AsZSKj4p+k4/aEdKU5GFSxtNU61ws+dUT44jNWfEFyJSyHVv/yOK7XjGM5RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=O6TPpppJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HAkCRa015372;
	Mon, 17 Jun 2024 20:45:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CG4rpw1QtAw21flEocjDb9MkaqhXHqDlWsWI9uZHUwA=; b=O6TPpppJ8LAmgS3W
	wsw2UAqGAVRxWJMG6Kf/zoYN7Mxsm5UWp93Q8ESWzRjJmk5ktexo9EoN+pgQOpTZ
	bUTJ2rR+OioiUaUgDGf66hGrYLkUU+QJYKPrkfq5PRJVmjboS0Bi1tb+nPBHz2xG
	ncLgp3XP4bB/50lZ40+dkYf7ymwszXXw81P6H0SkfFLbc8u75yRPbMGvA88gsy3z
	LnW7M4FXw6vGezOs5MmilJblm/sy+k60dK8KbZ9qjNbS/qwob+KtUHHfPoyplGtj
	JQw0PTd4T1IppeCbNkt86NlZKvYDUc6RuW+cm1jGzh7qNA28PzQVOxidHYW+zG6x
	RGnpuA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ys31u4rw3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 20:45:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45HKjMmL016843
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 20:45:22 GMT
Received: from [10.48.243.231] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 17 Jun
 2024 13:45:22 -0700
Message-ID: <cd8c0d02-4175-4eea-b4c2-e4cd6250071f@quicinc.com>
Date: Mon, 17 Jun 2024 13:45:22 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] wifi: ath12k: Dump additional Tx PDEV HTT stats
Content-Language: en-US
To: Ramya Gnanasekar <quic_rgnanase@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240614063404.2659089-1-quic_rgnanase@quicinc.com>
 <20240614063404.2659089-5-quic_rgnanase@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240614063404.2659089-5-quic_rgnanase@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8f-OHUExsbVSalrKeAAVAgidAzvD7dTD
X-Proofpoint-ORIG-GUID: 8f-OHUExsbVSalrKeAAVAgidAzvD7dTD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_14,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 priorityscore=1501
 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=778 bulkscore=0
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406170160

On 6/13/2024 11:34 PM, Ramya Gnanasekar wrote:
> Support to dump additional Tx PDEV stats through HTT stats debugfs.
> Following stats dump are supported:
>         1. PDEV control path stat to dump Tx management frame count
>         2. Tx PDEV SIFS histogram stats
>         3. Tx MU MIMO PPDU stats for 802.11ac, 802.11ax and 802.11be
> 
> Sample Output:
> ---------------
> echo 1 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
> 
...
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


