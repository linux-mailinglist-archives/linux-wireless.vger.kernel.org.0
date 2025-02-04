Return-Path: <linux-wireless+bounces-18350-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A58A26ADB
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 04:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FB8318869A5
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 03:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6897D15689A;
	Tue,  4 Feb 2025 03:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cSmE7Sps"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC67A3232
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 03:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738641325; cv=none; b=A6MvXGGkiWGsLl7NpCTM9d2pTrVkyacJsanl3H64qpd2S7fzbzPzR3+NA7ev9a89mJIlbNhdT4hIZecI+bHgsMOynDva+VFeOqWPzNnv1gsNZxc96XdkS9LpA937hoRqeszI9Ba5phK2MiQgSukIkkulVHgWjCLMjazmySFsMUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738641325; c=relaxed/simple;
	bh=Qi9RqsBNJjVic310Uec8FGMaIcQ/HjKpAkgOvfGwdAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SoVCchCfblS2tLy6/X1GTm01CsgNE7wk5mp4q6JOR9wHS0niDLGfMnN4kd+SfL8/MfjC+LhwDGtkpuNfJj+OGVMvK+/G+57vClDxrpyrlKtenhpmb+93Ppkli2cnMY1EpRRAdpTq30Wd5v0tpq+5q+dyFZDK782t17nXlh4RSN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cSmE7Sps; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513IpdiR005920;
	Tue, 4 Feb 2025 03:55:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JoyHl8BaLJ05WjJneh+Miolie5KQU0zh+iUovUVWenI=; b=cSmE7Spsg0PuEMjh
	xO9NaTQXu6X23dEOfKTiobvJ8BSIfSDCzMU0S63v5sERiVvUx2PcUkpCfxKtsdrT
	OBkQ9kSg4hy3kkv3TlVtE68w/QraGVnGABp7XfQF9f3QrMDsL35gW+gk5aZRDRiL
	mV7kX1WbfIM5LqK+IT3q0hnZTau8VetmxPQsLjHjRfy9YCM6ZEId30HkOmnUFUfW
	+bUJYErXh6Bf4/CMWatfPAgvVRMhrko/kVUMHG9Nbyp5gpJVa6xc1wV7BfsVniV0
	s4P2nkaYO/Va3js/nh3kQunGHIFF4pUmlY/3Df59kmyksV7NgSWWnU0nOF0DMM8h
	4Q2AJg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44k3ex0y9d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 03:55:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5143t1Dp025623
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Feb 2025 03:55:01 GMT
Received: from [10.151.40.197] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Feb 2025
 19:55:00 -0800
Message-ID: <48d940c7-817e-b92b-025d-6821358bb5ea@quicinc.com>
Date: Tue, 4 Feb 2025 09:24:57 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v7 8/9] wifi: ath12k: Refactor the format of peer rate
 table information
Content-Language: en-US
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Balamurugan Mahalingam
	<quic_bmahalin@quicinc.com>,
        Vasanthakumar Thiagarajan
	<vasanthakumar.thiagarajan@oss.qualcomm.com>
References: <20250204035215.3227307-1-quic_periyasa@quicinc.com>
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <20250204035215.3227307-1-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4iES9n-TlcOxM4eDs4bRh8LrbP9MSnyr
X-Proofpoint-GUID: 4iES9n-TlcOxM4eDs4bRh8LrbP9MSnyr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_02,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0 mlxlogscore=822
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502040029



On 2/4/2025 9:22 AM, Karthikeyan Periyasamy wrote:
> From: Balamurugan Mahalingam <quic_bmahalin@quicinc.com>
> 
> Currently, peer rate table information involves complex computation for
> the rate index to update the rate table. To simplify this process, avoid
> the rate index calculation by defining the rate table with bandwidth, GI,
> NSS, MCS. Therefore, update the rate information based on the bandwidth,
> GI, NSS and MCS information from the TLV data of monitor status Rx path.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Balamurugan Mahalingam <quic_bmahalin@quicinc.com>
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
> ---
>   drivers/net/wireless/ath/ath12k/core.h   |  6 +----
>   drivers/net/wireless/ath/ath12k/dp_mon.c | 29 +++++++++++-------------
>   2 files changed, 14 insertions(+), 21 deletions(-)
> 

Ignore this series, missed patches

-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

