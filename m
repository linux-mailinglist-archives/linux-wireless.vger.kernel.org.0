Return-Path: <linux-wireless+bounces-5612-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 284E48922F8
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 18:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1D251F250EC
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 17:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CD2101EC;
	Fri, 29 Mar 2024 17:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kxkS/ndh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67ADA923
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 17:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711734355; cv=none; b=f13bgPoAaKYIT8FWIEUeuhZcrRhU+zlrGMFoLjfh1sSpv8B/EqXyrmaK+kLx47p/vfkds+QS/EseUts8F1OsQ3noCWbELsfPXjANPenIi90EhzuhlEy0AsuXmIIhN44NvMZsCm0Ac/N6EHeSjRlyW3OvCOQjXdxYoW0/G/AquBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711734355; c=relaxed/simple;
	bh=EgMx9El9tPRbzGDoMDpjbKKt4ptszjX2uN0uILg3YfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WWFPulKyaSgJHp3W2yw1MMG3A61AeWZGalqERCQj8m6Wm836uwiD2D6P2e+IXNFtITfiDFZFchlYteM92Gi4o9EGyQXQhz+n88LPCdYbWDVhWCJ4WhrGmNN+t1HyivpDFAgdc1jFc5rW6C5+dUFDEvq8fDMZiIjNZDSnp4Rzcgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kxkS/ndh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42THfbLK013432;
	Fri, 29 Mar 2024 17:45:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=+0KyaX/uuY3bOWtXzKTd5nI9t/yStuwOLfaKaupdXkI=; b=kx
	kS/ndhEaiSFW3Iepp2of82rgZ4ugAJ0lDra1IcEkD4Cw9a4g/2aStx1y9EHLWiQT
	4Uy4kRwVcRW0UhxtJFqXQHiONZYFC2c32n2EyXvM+NLLSbrGT4kwFu8eNl+5Ob+/
	DM6c++F2v1bCUW1FuvnXf9HsgmLDldQyE23SYyAT6HLcnRXJS1V+29cVWDmtFoPw
	Foo7ov0vrYWjJb9fQyZcJ+SdPdeL+i+3jPlGe0JVfoebH5faDrGRVTh8y8/C1UB7
	jXiboutdwdJPmEEJ13o0FIyaFKymoUsxRteTXpSJ2twJjvwuhy0kbVTrQk4fn4oM
	AlJ81fdk2o6k1UEpkwhQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5sm6he37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 17:45:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42THjnBU018099
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 17:45:49 GMT
Received: from [10.227.91.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 29 Mar
 2024 10:45:48 -0700
Message-ID: <e826a505-05e0-4761-ac22-97d6bfe175b6@quicinc.com>
Date: Fri, 29 Mar 2024 10:45:48 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] wifi: ath12k: add MU-MIMO and 160 MHz bandwidth
 support
Content-Language: en-US
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240327170910.23975-1-quic_pradeepc@quicinc.com>
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
In-Reply-To: <20240327170910.23975-1-quic_pradeepc@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ViwDPFeFoFziWgpLkq4PFdbxtzDyGu6_
X-Proofpoint-GUID: ViwDPFeFoFziWgpLkq4PFdbxtzDyGu6_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 suspectscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403290157



On 3/27/2024 10:09 AM, Pradeep Kumar Chitrapu wrote:
> Add support for
> 1. enabling MU-MIMO in HE and EHT modes from hardware
> 2. setting fixed HE rate/GI/LTF
> 3. 160 MHz bandwidth in HE mode
> 4. extended NSS bandwidth support
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> changes in v2:
>   - Amend mac80211 patch description as the patch is not specific
>     to AP mode.
>   - Amend EHT MU-MIMO patch description to specify future support
>     for STA mode.
> 
> Pradeep Kumar Chitrapu (10):
>    wifi: mac80211: Add EHT UL MU-MIMO flag in ieee80211_bss_conf
>    wifi: ath12k: push HE MU-MIMO params from hostapd to hardware
>    wifi: ath12k: push EHT MU-MIMO params from hostapd to hardware
>    wifi: ath12k: move HE MCS mapper to a separate function
>    wifi: ath12k: generate rx and tx mcs maps for supported HE mcs
>    wifi: ath12k: fix TX and RX MCS rate configurations in HE mode
>    wifi: ath12k: add support for setting fixed HE rate/GI/LTF
>    wifi: ath12k: clean up 80P80 support
>    wifi: ath12k: add support for 160 MHz bandwidth
>    wifi: ath12k: add extended NSS bandwidth support for 160 MHz
> 
>   drivers/net/wireless/ath/ath12k/core.h |    2 +
>   drivers/net/wireless/ath/ath12k/mac.c  | 1035 ++++++++++++++++++++----
>   drivers/net/wireless/ath/ath12k/mac.h  |   17 +
>   drivers/net/wireless/ath/ath12k/wmi.c  |   24 +-
>   drivers/net/wireless/ath/ath12k/wmi.h  |   98 ++-
>   include/net/mac80211.h                 |    4 +
>   net/mac80211/cfg.c                     |    5 +
>   7 files changed, 981 insertions(+), 204 deletions(-)
> 
> 
> base-commit: fe7e1b830cf3c0272aa4eaf367c4c7b29c169c3d
Hi Kalle/Johannes

I noticed patch status as 'Changes requested', but there were no 
accompanying comments specifying the exact modifications needed.
I kindly request additional information or guidance on the specific 
areas that require correction. Once I have a clearer understanding, I 
will promptly address the necessary fixes.

Thanks
Pradeep

