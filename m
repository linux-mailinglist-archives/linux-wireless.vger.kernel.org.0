Return-Path: <linux-wireless+bounces-14830-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A75979B9591
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 17:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A87B71C21BA2
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 16:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C9F450E2;
	Fri,  1 Nov 2024 16:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="O99Q9ek2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355531C9EB8
	for <linux-wireless@vger.kernel.org>; Fri,  1 Nov 2024 16:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730479027; cv=none; b=mn/6F/gL2KN8eMYDOBpTlFFZ2bNi12ebLzN4iiybPcSH5BxwbtX/Qgolkp6yVzc/vPn+s76tWAi7BWV84nwfaPDzRS7ezLI5fqDN25Ild2tGRcwx4m6yFjDGKcZaiRDfNhmTFPopEYvahGgPog7uygaFnllkofoGdMHB72XVfQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730479027; c=relaxed/simple;
	bh=VERV6/V4Ox9TdMdv3SG8/BVVP8tR1ht3xxDJke1NF40=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dthB/TX49YPxPDOQECiZ0TlwNoogdE8u91Nx4gnSOpBwvAjV12cI/DB0T2OhiSjD3tbDV6mTw+WAMwquCcOimvK6E9iQwyx1eF7aFBXFkMPC6bF2TpKOjuw2Rrh10Znz9v0lwkPwj7VEdfApkxl+6wHC/W5T+sxt5gbBvPQyIoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=O99Q9ek2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1BApjH023460;
	Fri, 1 Nov 2024 16:37:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7PYyh5Kj1ekYoVdSe6OMklmHajbeEZr4ogbiz+zR67g=; b=O99Q9ek2qCEeJiHv
	PjfFIi8pRWYNLmn5fi29EmMbJ5I7zgoaIj8tP8XGFSUYJ27IoI7Jzi3xJxvLQRhC
	f0M7vfEFbyXVEbeD2gNNOQ/3JxIgJiyDKROHmB2/YqJcHfKmlDlHv68cuLpu5dpO
	WvE9mSvyHdw1r0fHSbri7aOOwP4VgaqaYGAxleewZ/PGdb42gXP1hJdP60VwYYYL
	3Vzv80ienKkgZzwbtdUDzPy7BMdEqpD7RixGUZwX4CM/5Bk7Tc5VgMCk9xmpCbH0
	oUme1H4kLTjWmMAXSaMouzjoqWb1DuHBfd9+HZps46txtsxFuAX+qQtmfIPArIsm
	DgPXXA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42m1xcdx33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Nov 2024 16:37:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A1Gb1n9017928
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 1 Nov 2024 16:37:01 GMT
Received: from [10.48.242.225] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 1 Nov 2024
 09:37:01 -0700
Message-ID: <2464068b-6fdf-4106-bb68-0d134ed066e7@quicinc.com>
Date: Fri, 1 Nov 2024 09:37:00 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] wifi: ath12k: introduce ath12k_hw_warn()
To: Kalle Valo <kvalo@kernel.org>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20241101151705.165987-1-kvalo@kernel.org>
 <20241101151705.165987-5-kvalo@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241101151705.165987-5-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Nu4ehNkip8J_iKfgDzgjx7lHj_R5qPt-
X-Proofpoint-ORIG-GUID: Nu4ehNkip8J_iKfgDzgjx7lHj_R5qPt-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 malwarescore=0 suspectscore=0 phishscore=0 mlxlogscore=462 clxscore=1015
 priorityscore=1501 adultscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411010121

On 11/1/2024 8:17 AM, Kalle Valo wrote:
> From: Kalle Valo <quic_kvalo@quicinc.com>
> 
> In the following patch we need to use ath12k_warn() but don't easily have
> access to struct ath12k_base (ab) but do have access to struct ath12k_hw (ah).
> So add a new warning helper ath12_hw_warn() which takes the latter but the log
> output is still identical but uses the struct device pointer stored to struct
> ath12k_hw.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


