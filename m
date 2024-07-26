Return-Path: <linux-wireless+bounces-10528-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D53793CBE9
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2024 02:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E6A71C20F56
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2024 00:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E9719B;
	Fri, 26 Jul 2024 00:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ajMe1179"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D24A19A
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jul 2024 00:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721952677; cv=none; b=lXXmlHnJ8uI/TOUQNx693Zscw8jeP9XrntoffySpZ/kHBrD55ZKD1x4IeHl9L+5MmZK6jPSp9kZJD4DeMjPmMfqme6mKb+a/n7oBVSrjt+gfUV7BOZ6PknTg0OPxvSHcpQfw2n1Mpi7PidZdK4FFKH7lblM4fDQdtfMjpB55pAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721952677; c=relaxed/simple;
	bh=SxnA+gxPH7Tw0En7h4N3YPK3FGgtYClglSnqHD3M0p0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Mowyw/PlF6kO/xya6OE0E+G4V9S40eH9fB+0VmUJrAwjbxCvvRgGZgiqK1hP0vO8SgYyvvW73z6N+l+m+NlqiJNU/QOYuhxgeoouq4ts0GI0SmYAKhWCbm+bWgWDNeKVHgL+FCK1r4r8sCa3Hpaddojko1YHvZPHxjD3epBO0OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ajMe1179; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46PB8LRj014753;
	Fri, 26 Jul 2024 00:11:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q+i+bIcu0OPsRxUl6ZHlskRd0b7o7HH7UjlnA2b0HSc=; b=ajMe1179OLTVFZr1
	7WhWyWoBZ0KKUAKnay5zAJqvJTP+yJJzvpiIwQSje91rAajgEyagAnBfD+JVatSC
	Fw24FIcuXcaPR6iZJcPeeNqNMRLBa4J9Ws245BmKlBZvX1/3GtA85kljOnogwF5t
	rW9CJLnMsoqOooxgtERPJPVpRDUVotDbErdmU3IkSGoJqhFdvE94MawHdKWCf+Wh
	DOpGINkg8wKjd/PdpT2LpP9hyM+hcrvYl1xDgRrMS+9jcRyo+2m3RITHgZsyjofk
	IFrqyDFX6GfE0MGOjSgkZZGFSAVMoMe1N0YlMoCz35Nb9TD1CJ7i2wGUhxOQnW33
	ByZNxg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40k40ym709-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 00:11:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46Q0B9FC023295
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 00:11:09 GMT
Received: from [10.111.176.158] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Jul
 2024 17:11:09 -0700
Message-ID: <186e1ae9-5941-42a5-9349-4a044d97d09e@quicinc.com>
Date: Thu, 25 Jul 2024 17:11:08 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] wifi: ath12k: some fixes and clean up for monitor
 mode
Content-Language: en-US
To: kangyang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240725120035.493-1-quic_kangyang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240725120035.493-1-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 458HsGfCA0XgJH6bs66OVU-x8CpIGbIw
X-Proofpoint-ORIG-GUID: 458HsGfCA0XgJH6bs66OVU-x8CpIGbIw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-25_26,2024-07-25_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407250164

On 7/25/2024 5:00 AM, kangyang wrote:
> From: Kang Yang <quic_kangyang@quicinc.com>
> 
> This patch set does some fixes and clean up for monitor mode.
> 
> Kang Yang (11):
>   wifi: ath12k: remove unused variable monitor_present
>   wifi: ath12k: optimize storage size for struct ath12k
>   wifi: ath12k: fix struct hal_rx_ppdu_end_user_stats
>   wifi: ath12k: fix struct hal_rx_ppdu_start
>   wifi: ath12k: fix struct hal_rx_phyrx_rssi_legacy_info
>   wifi: ath12k: fix struct hal_rx_mpdu_start
>   wifi: ath12k: properly handling the state variables of monitor mode
>   wifi: ath12k: delete NSS and TX power setting for monitor vdev
>   wifi: ath12k: use tail MSDU to get MSDU information
>   wifi: ath12k: fix A-MSDU indication in monitor mode
>   wifi: ath12k: delete mon reap timer
> 
>  drivers/net/wireless/ath/ath12k/core.c   |   5 ++
>  drivers/net/wireless/ath/ath12k/core.h   |  23 +++--
>  drivers/net/wireless/ath/ath12k/dp.c     |  25 ------
>  drivers/net/wireless/ath/ath12k/dp_mon.c | 108 ++++++++++++-----------
>  drivers/net/wireless/ath/ath12k/hal_rx.h |  53 ++++++-----
>  drivers/net/wireless/ath/ath12k/mac.c    |  24 +++--
>  6 files changed, 114 insertions(+), 124 deletions(-)
> 
> 
> base-commit: db1ce56e6e1d395dd42a3cd6332a871d9be59c45

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


