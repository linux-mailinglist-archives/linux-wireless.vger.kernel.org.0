Return-Path: <linux-wireless+bounces-17316-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E97A08F07
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 12:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7ADB188C66D
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 11:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBFE209F4F;
	Fri, 10 Jan 2025 11:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KS0WrNxi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0A920ADF6
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 11:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508040; cv=none; b=hAg2vUImvjhJGJr9q0J5HA3+p30YlnGlY9Y1Xa6N1Spwpo92FBHpc+iN36154JCI2s/+srwUCxpiBqLIn7A2w6Z32STZ2+Bce6fcFUfLBL4ZRP9d4ki4q8W+5tUVBVDg52ycv2AZLPs00EsFJntanxjPZXbqquBMtqZgt+NhLC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508040; c=relaxed/simple;
	bh=jRxyxm0wyIwBNRZchK7jXxE6TFQ8TqnhZQDwNp/oA1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GIELXJKtwrKbYclhvLyG08nqPvsAfrQFBO0SUi6eH1CizoFSlK8HbyryvbcvCoFsFaiqiOff+40IweLAN0LmWxkbi4VVnupvUElSVrE4dAgHUrqoqIMLm+pSRNSlzGIIw+X5Fm2Qwz9bTS4Nmnpz4VPfe8XO2vB77wigYvYq0sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KS0WrNxi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50A3ws2s018929;
	Fri, 10 Jan 2025 11:20:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y1QNF4Z5saKMafMyDVULSVixM5Td0KJIWSBrgXV4yFY=; b=KS0WrNxios/q+GkL
	3N04v85Jlh8ZYBoLkKystL20DhYAGcPi4KNvZ7dYJokGuYF8C1gZ23eWVI2NX1Ew
	AtQxRXN/vPXJXHzSBkufOBwoYKq7Wr8vxWyDMJdG7FHT0ANm4CimFBfft/1MiKUl
	Pddm72SzTsORg9h94m12zIPCGnt9beDeIp08Qpmr7rDLTtkdKhN6gKoPzeBrEQlb
	yN5UeuQfBk0nV2B1o/i25vqDIdzqlNrFo739NolSrnMXUSigCCbIvfscIqQ2ImlP
	1GEKi1HCWSrSTpRT9DeJ6Jx3Rx2vMdDPCP6JuflguAH6/pZ19jagNg/mI3IHYX4X
	Ocqv/w==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 442v3rh36r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 11:20:36 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50ABKaT1025411
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 11:20:36 GMT
Received: from [10.152.193.243] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 10 Jan
 2025 03:20:35 -0800
Message-ID: <2a746b17-fdf6-45e8-907b-2534ad956872@quicinc.com>
Date: Fri, 10 Jan 2025 16:50:31 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/5] wifi: ath12k: Factory test mode support
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250110061224.1839547-1-quic_aarasahu@quicinc.com>
Content-Language: en-US
From: Aaradhana Sahu <quic_aarasahu@quicinc.com>
In-Reply-To: <20250110061224.1839547-1-quic_aarasahu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4jQh8MM-umlcoBNBgAc4CvZZIAlqMtjs
X-Proofpoint-ORIG-GUID: 4jQh8MM-umlcoBNBgAc4CvZZIAlqMtjs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 clxscore=1015 mlxscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501100087



On 1/10/2025 11:42 AM, Aaradhana Sahu wrote:
> Device is booted in factory test mode for calibration.
> The commands are sent from userspace application, which
> is sent to firmware using wmi commands. Firmware sends
> the response to driver as wmi events and driver sends
> these events to the application via netlink message.
> 
> Also added changes related to correct pdev id access for
> fw test cmd.
> 
> Aaradhana Sahu (5):
>   wifi: ath: create common testmode_i.h file for ath drivers
>   wifi: ath12k: export ath12k_wmi_tlv_hdr for testmode
>   wifi: ath12k: add factory test mode support
>   wifi: ath12k: Fill pdev id for fw test cmd
>   wifi: ath12k: Disable MLO in Factory Test Mode
> 
> ---
> v7:
>   -Updated copyright
>   -Moved ath12k_ftm_check in ath12k_core_hw_group_set_mlo_capable()
> v6:
>   -Rebased on ToT
>   -Updated copyright
>   -Added patch[5/5]
> v5:
>   -Updated copyright
>   -Fixed line length within 90 char
> v4:
>   -Rebased on latest ToT
> v3:
>   -Rebased on latest ToT
>   -Updated Tested-on Tag
>   -Removed second parameter of ath12k_core_start()
>   -Updated copyright
> v2:
>   -Rebased on latest ath ToT
> ---
> 
>  drivers/net/wireless/ath/ath11k/testmode.c    |  80 ++--
>  drivers/net/wireless/ath/ath12k/Makefile      |   1 +
>  drivers/net/wireless/ath/ath12k/core.c        |  30 +-
>  drivers/net/wireless/ath/ath12k/core.h        |  13 +-
>  drivers/net/wireless/ath/ath12k/debug.h       |   3 +-
>  drivers/net/wireless/ath/ath12k/dp.c          |   5 +-
>  drivers/net/wireless/ath/ath12k/mac.c         |  17 +-
>  drivers/net/wireless/ath/ath12k/pci.c         |   3 +-
>  drivers/net/wireless/ath/ath12k/testmode.c    | 394 ++++++++++++++++++
>  drivers/net/wireless/ath/ath12k/testmode.h    |  40 ++
>  drivers/net/wireless/ath/ath12k/wmi.c         |  41 +-
>  drivers/net/wireless/ath/ath12k/wmi.h         |  23 +-
>  drivers/net/wireless/ath/ath12k/wow.c         |   3 +-
>  .../wireless/ath/{ath11k => }/testmode_i.h    |  54 +--
>  14 files changed, 622 insertions(+), 85 deletions(-)
>  create mode 100644 drivers/net/wireless/ath/ath12k/testmode.c
>  create mode 100644 drivers/net/wireless/ath/ath12k/testmode.h
>  rename drivers/net/wireless/ath/{ath11k => }/testmode_i.h (50%)
> 
> 
> base-commit: dbe50a7420e22954c747e79e72df2750d795ea77

Please ignore this patch series, I have sent next version(v8).


