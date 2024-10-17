Return-Path: <linux-wireless+bounces-14179-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1132E9A2F01
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 22:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EAAEB2423B
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 20:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D6E229111;
	Thu, 17 Oct 2024 20:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="POSQkDCW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AA52281FD
	for <linux-wireless@vger.kernel.org>; Thu, 17 Oct 2024 20:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729197839; cv=none; b=mrGd1BCZx9v1YbmW5q4RQyOVkX6VNUkhl0K8vfIOWpDPP/V/xbG4gZdZC7dVd8uYiIEN/IaGiSj+C07SW2NDMmcttjV9ILN9yf1moBgHy0vP5MOMIIbXSPRX8Nvz+yKbNxEhZvepsIFFMYjzrVRkK8D9w9/PosxGSfGULRVlp2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729197839; c=relaxed/simple;
	bh=0AAb//5jy1py3pVlApXX/TJfEsoLk+erJIBDGfSlp/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pVMIYJ8yv357JcwmOaMUAVhJl7C2HiZT5mGLYgwWDrKBBvJoGKXUOjyLtxD8DL7FyIP4PELwC6xQHmmc4ELGauDgaigosMzaMS8niuMbEhOa4AvwhUc9KhHQycIA516xH4/yJQ39IHtpaxEV1Wamlos1AfXDg1lhkVsI/qqfvtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=POSQkDCW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HIqHk2012503;
	Thu, 17 Oct 2024 20:43:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kYkIDUGLCRV+wwPKXj3Vr5/KThaJDLYa7aP08VMjQf0=; b=POSQkDCW9AxUlbi9
	FHZnRg5NBEJ4UKgYwmSQGBhqZsoAZ7DQURARXwZOSIWxScSj/C72xP9LAQ7qM8mI
	Guw3/6sJa1juPnB8OcDZxRPcxDkOeegESQESPlOdlZ6ypdziPPCcyuYWkJ2EGP6V
	Yec6x/2cPnvyQ/4SNp+Ez84NdA5rvon1SQICq0D7z2/hf5s3T+FeeFKuTvnJeFbo
	xT8Tlw/3ZITUe6pMANHJx3jtI7jbZ7+MHPWsbZQZuPKnubIS7eBK2wcMvPD/+oZ0
	vPxftvLQurRDki9lSdBW2KEZ0GfFNG64xT/TqZWZnDuoWveGXuRQEBFUXqlsDNij
	fqpkHw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42abbxwf9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 20:43:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49HKhnTx018949
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 20:43:49 GMT
Received: from [10.48.241.64] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 17 Oct
 2024 13:43:48 -0700
Message-ID: <9a928610-aa89-40e6-b5fd-0dd8cf5a3a3d@quicinc.com>
Date: Thu, 17 Oct 2024 13:43:47 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/11] wifi: ath12k: some fixes and clean up for
 monitor mode
To: Kang Yang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20241017031056.1714-1-quic_kangyang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241017031056.1714-1-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XQVKD1tvfbIZLlLB5pvP-fQJDvk01e56
X-Proofpoint-GUID: XQVKD1tvfbIZLlLB5pvP-fQJDvk01e56
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410170139

On 10/16/2024 8:10 PM, Kang Yang wrote:
> This patch set does some fixes and clean up for monitor mode.
> 
> v4: rebase on tag: ath/main(ath-202410161539).
> v3: rebase on tag: ath/main(ath-202410111606).
> v2: rebase on tag: ath-202410072115.
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
>  drivers/net/wireless/ath/ath12k/dp_mon.c | 107 +++++++++++++----------
>  drivers/net/wireless/ath/ath12k/hal_rx.h |  53 ++++++-----
>  drivers/net/wireless/ath/ath12k/mac.c    |  24 +++--
>  6 files changed, 115 insertions(+), 122 deletions(-)
> 
> 
> base-commit: fa934bf3e0a825ee09f035c6580af513187d59a2

This series looks ok to me, but it conflicts with the MLO branch so I'll defer
this until the MLO branch is merged. Note that some of these fixes may not
conflict, so feel free to submit ones that don't conflict as individual patches.

