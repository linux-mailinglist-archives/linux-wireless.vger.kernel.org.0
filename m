Return-Path: <linux-wireless+bounces-9129-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE0690BA07
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 20:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D4601C23762
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 18:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539591990AA;
	Mon, 17 Jun 2024 18:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="h31PowxH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971291990B3
	for <linux-wireless@vger.kernel.org>; Mon, 17 Jun 2024 18:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718649996; cv=none; b=nZWX98KqZ+Us97HFKlKWTIcfbPzlLpUdpx9WrxV9Wht7ZVJHKdiOi3+oRBwz2Pwf5cUeHErUZR7HoZC2m1GKKQfhJmwpirw5g6ExXBwtyaXxXMzc+pUlaJ0TqFo06ASEiqcNa90cP5eZFdObwHz4dntGnYZS1GkAPQlSRphP6Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718649996; c=relaxed/simple;
	bh=+hWR8sfU7BP2BU2H6VkQkp4LP8iullhz2fXSZ6yL+8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LiNMPEj5a/jGLdRLM7Eu1njj7bHYf6RpF2vKaekhnmNI6VJeoUxxmc+sqTTMQd0nOCHPrNXi03QV3k7Mto8jMXrGdqT87noJH4hPGyYFwRbRMXqz7GwqGT+3tVXALd6JVy/eUnTFeE7E3KvK5grJQyi2y+ADz+xQjMxBBEZsl78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=h31PowxH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HAiFEA009325;
	Mon, 17 Jun 2024 18:46:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ThFyhitQHbil3ukfPb4BTQDlV68mQR+9q/sXZH8kJAQ=; b=h31PowxH4teN4qq9
	STTRmBtIFmUvGb38TwFlbhflD8bULz0H93slIXFWYtdizm0EK01q4Qgr1CeuN4zl
	sHRp9wc5yKmBHDh3ev99aLLHDjZTq3KoojyUAYvCUM7dOwNB2pr6U7C0IPndVslg
	YQ9YShLn7vEQ7pH4PAEsf0eRr6szPcikl4SIx5OLHnSkFxKQNOUBMjTBPXCX9vjL
	Jl220h8eLeXlQPqcZS9jXaIvcm7bSY6URmoQ6yFRfDGKTxxh4srHD4l1WgvnJx+P
	2N+1fOL4UFYpFAGHHDMVJ8FIAiRk8Y2py++/X+wlCStkwLDuShK9YJ6T8k0XXb8E
	4b/PBA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ys3b74he7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 18:46:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45HIkTpd000315
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 18:46:29 GMT
Received: from [10.48.243.231] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 17 Jun
 2024 11:46:28 -0700
Message-ID: <0c17fa05-f9c5-4aa1-bede-6dbb17a754e2@quicinc.com>
Date: Mon, 17 Jun 2024 11:46:27 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 0/9] wifi: ath12k: add MU-MIMO and 160 MHz bandwidth
 support
Content-Language: en-US
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240612234209.2324181-1-quic_pradeepc@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240612234209.2324181-1-quic_pradeepc@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NkyUa0NJia6ScTzURfs2kSMVnr3em0-n
X-Proofpoint-ORIG-GUID: NkyUa0NJia6ScTzURfs2kSMVnr3em0-n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_14,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 bulkscore=0 spamscore=0 mlxscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406170145

On 6/12/2024 4:42 PM, Pradeep Kumar Chitrapu wrote:
> Add support for
> 1. enabling MU-MIMO in HE and EHT modes from hardware
> 2. setting fixed HE rate/GI/LTF
> 3. 160 MHz bandwidth in HE mode
> 4. extended NSS bandwidth support
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> changes in v7:
>  - rebase and remove patch 01/10 which was merged already.
> 
> changes in v6:
>  - Change comment in patch 01/10 to represent only AP mode
>    implementation.
> 
> changes in v5:
>  - Fix column length to 80 in patch 01/10
>  - Fix advertises spelling in patch 09/10
>  - Fix choosing spelling in patch 10/10
> 
> changes in v4:
>  - Fix ath12k-check warnings in patch 2/10 and 7/10
>  - remove "hostapd" reference in patches 2/10 and 3/10
>  - remove redundant prerequisite-patch-id's in cover letter
> 
> changes in v3:
>  - address review comments for fixing ath12k-check issues.
> 
> changes in v2:
>  - Amend mac80211 patch description as the patch is not specific
>    to AP mode.
>  - Amend EHT MU-MIMO patch description to specify future support
>    for STA mode.
> 
> Pradeep Kumar Chitrapu (9):
>   wifi: ath12k: push HE MU-MIMO params to hardware
>   wifi: ath12k: push EHT MU-MIMO params to hardware
>   wifi: ath12k: move HE MCS mapper to a separate function
>   wifi: ath12k: generate rx and tx mcs maps for supported HE mcs
>   wifi: ath12k: fix TX and RX MCS rate configurations in HE mode
>   wifi: ath12k: add support for setting fixed HE rate/GI/LTF
>   wifi: ath12k: clean up 80P80 support
>   wifi: ath12k: add support for 160 MHz bandwidth
>   wifi: ath12k: add extended NSS bandwidth support for 160 MHz
> 
>  drivers/net/wireless/ath/ath12k/core.h |    2 +
>  drivers/net/wireless/ath/ath12k/mac.c  | 1052 ++++++++++++++++++++----
>  drivers/net/wireless/ath/ath12k/mac.h  |   17 +
>  drivers/net/wireless/ath/ath12k/wmi.c  |   24 +-
>  drivers/net/wireless/ath/ath12k/wmi.h  |   98 ++-
>  5 files changed, 985 insertions(+), 208 deletions(-)
> 
> 
> base-commit: e72048809ec7355a947415ae6836d2eb7fdcda39

This series produces the following warnings when applied to ath-202406171110

In function 'ath12k_peer_assoc_h_he',
    inlined from 'ath12k_peer_assoc_prepare' at drivers/net/wireless/ath/ath12k/mac.c:2951:2:
drivers/net/wireless/ath/ath12k/mac.c:2357:21: warning: 'ath12k_peer_assoc_h_he_limit' reading 16 bytes from a region of size 0 [-Wstringop-overread]
 2357 |                 v = ath12k_peer_assoc_h_he_limit(v, he_mcs_mask);
      |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/wireless/ath/ath12k/mac.c:2357:21: note: referencing argument 2 of type 'const u16[8]' {aka 'const short unsigned int[8]'}
drivers/net/wireless/ath/ath12k/mac.c: In function 'ath12k_peer_assoc_prepare':
drivers/net/wireless/ath/ath12k/mac.c:2139:12: note: in a call to function 'ath12k_peer_assoc_h_he_limit'
 2139 | static u16 ath12k_peer_assoc_h_he_limit(u16 tx_mcs_set,
      |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
In function 'ath12k_peer_assoc_h_he',
    inlined from 'ath12k_peer_assoc_prepare' at drivers/net/wireless/ath/ath12k/mac.c:2951:2:
drivers/net/wireless/ath/ath12k/mac.c:2370:21: warning: 'ath12k_peer_assoc_h_he_limit' reading 16 bytes from a region of size 0 [-Wstringop-overread]
 2370 |                 v = ath12k_peer_assoc_h_he_limit(v, he_mcs_mask);
      |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/wireless/ath/ath12k/mac.c:2370:21: note: referencing argument 2 of type 'const u16[8]' {aka 'const short unsigned int[8]'}
drivers/net/wireless/ath/ath12k/mac.c: In function 'ath12k_peer_assoc_prepare':
drivers/net/wireless/ath/ath12k/mac.c:2139:12: note: in a call to function 'ath12k_peer_assoc_h_he_limit'
 2139 | static u16 ath12k_peer_assoc_h_he_limit(u16 tx_mcs_set,
      |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
In function 'ath12k_peer_assoc_h_he',
    inlined from 'ath12k_peer_assoc_prepare' at drivers/net/wireless/ath/ath12k/mac.c:2951:2:
drivers/net/wireless/ath/ath12k/mac.c:2370:21: warning: 'ath12k_peer_assoc_h_he_limit' reading 16 bytes from a region of size 0 [-Wstringop-overread]
 2370 |                 v = ath12k_peer_assoc_h_he_limit(v, he_mcs_mask);
      |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/wireless/ath/ath12k/mac.c:2370:21: note: referencing argument 2 of type 'const u16[8]' {aka 'const short unsigned int[8]'}
drivers/net/wireless/ath/ath12k/mac.c: In function 'ath12k_peer_assoc_prepare':
drivers/net/wireless/ath/ath12k/mac.c:2139:12: note: in a call to function 'ath12k_peer_assoc_h_he_limit'
 2139 | static u16 ath12k_peer_assoc_h_he_limit(u16 tx_mcs_set,
      |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
 

