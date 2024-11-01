Return-Path: <linux-wireless+bounces-14835-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A097E9B95E6
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 17:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 570B71F21FD3
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 16:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A0A1CB51D;
	Fri,  1 Nov 2024 16:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="F6FYalw1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069DD1C7610
	for <linux-wireless@vger.kernel.org>; Fri,  1 Nov 2024 16:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730479929; cv=none; b=DFHHtXTfvl2Up1bSPECQ2VE910FwJASAmYksDLuvzBdmI9+NUstrMJKVVzd3C1zdrklg0YxREkB8IZXprr8lz4GYwbalB5vL6Qf1WNTrCEnHLX9mjtluOMN34fs7/9spGP2x1UwYvIdA/wF64/E9jGeckv61zy4kdSr4uR66A4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730479929; c=relaxed/simple;
	bh=4XyyCMr7WNIN+9FSKNROCVwF9PXPQ51cF/rMoA+9avg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UDgARLnyJoGijSYOO7vVnrAlKXrd/5h0LO45h4hSVbO2hOBhaL3nq2faqPLYmrPIth8o6HD4okboadDUmlvPGHC2VZI0mLe/kLU+56FPL5fPXdtZiiZCj28gsdklBP6++PmkU9HjzKz+hppz5eeCuio8Bpzwdw9WRcNsgBlP5hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=F6FYalw1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1FQle1005298;
	Fri, 1 Nov 2024 16:52:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uWKdgpCrSL/dGAtjc3VP5zlmydUehCWzC80P4R0szrU=; b=F6FYalw1ijA31tWM
	oUSNEGU0ei46phethydIDvilPGOd3TfFJ354Z23u79B4cli3TUrW5F+5ociMsNTi
	QZE3rNDcglwfTjh25vcWpclfRVL1VsrBHdb9jvJmLozOvWiLaddivMbnx8R0CNDy
	pPENWceGeryt1UdAxWobqvpUVI02607f/F24+vG1icHTe6fVlWJPYm5zDu/4pGUU
	8Piez1YwSPkwUwc3D25w2z2MdW/OhmfAF+vGcrACOfyxN0YcbMJGAOkIqQVEqgN+
	QNuVPcOEXVKOhWdkuDx5aiFKn2U0PRCM+8MbjDES38jFAj+KcEtk387JlmkQEjk/
	E00Y9g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42n1mpg756-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Nov 2024 16:52:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A1Gq0iH004913
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 1 Nov 2024 16:52:00 GMT
Received: from [10.48.242.225] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 1 Nov 2024
 09:51:59 -0700
Message-ID: <935b7f88-a48f-48b5-9e5b-b333cafec25f@quicinc.com>
Date: Fri, 1 Nov 2024 09:51:59 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] wifi: ath12k: MLO support part 2
To: Kalle Valo <kvalo@kernel.org>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20241101151705.165987-1-kvalo@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241101151705.165987-1-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pqF9QvpopR5d7x-kfnzducKLepPczBYU
X-Proofpoint-GUID: pqF9QvpopR5d7x-kfnzducKLepPczBYU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=861
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411010121

On 11/1/2024 8:16 AM, Kalle Valo wrote:
> From: Kalle Valo <quic_kvalo@quicinc.com>
> 
> Here we continue to refactor mac.c to support multiple links and extend peer
> assoc WMI command to support MLO.
> 
> Please review.
> 
> v2:
> 
> * patch 1: use err_vdev_del
> 
> * patch 2: ath12k_mac_mlo_get_vdev_args(): switch
> wiphy_dereference()
> 
> * patch 2: use struct ath12k_wmi_mac_addr_params instead adding struct wmi_mac_addr
> 
> * patch 3: ath12k_mac_station_post_remove(): assign
> ahsta->links_map before rcu_assign_pointer()
> 
> * patch 3: ath12k_mac_station_unauthorize(): fi* confusing comment about __sta_info_destroy_part2()
> 
> * patch 4: debugfs.c: copyright year
> 
> * patch 5: ath12k_peer_mlo_create(): remove parenthesis from the
>   warning message
> 
> * patch 5: ATH12K_ML_PEER_ID_VALID: move to peer.h and rename to ATH12K_PEER_ML_ID_VALID
> 
> * patch 5: rename struct ath12k_peer::ml_peer_id to peer_id
> 
> * patch 5: use ath12k_peer_ml_*() naming style in peer.c
> 
> * patch 7: improve commit message a bit
> 
> * patch 7: struct wmi_peer_assoc_mlo_partner_info: add _params to name
> 
> v1: https://patchwork.kernel.org/project/linux-wireless/cover/20241023133004.2253830-1-kvalo@kernel.org/
> 
> Kalle Valo (2):
>   wifi: ath12k: ath12k_mac_vdev_create(): use goto for error handling
>   wifi: ath12k: introduce ath12k_hw_warn()
> 
> Sriram R (6):
>   wifi: ath12k: MLO vdev bringup changes
>   wifi: ath12k: Refactor sta state machine
>   wifi: ath12k: Add helpers for multi link peer creation and deletion
>   wifi: ath12k: add multi-link flag in peer create command
>   wifi: ath12k: add helper to find multi-link station
>   wifi: ath12k: Add MLO peer assoc command support
> 
>  drivers/net/wireless/ath/ath12k/core.h  |  25 ++
>  drivers/net/wireless/ath/ath12k/debug.c |   6 +-
>  drivers/net/wireless/ath/ath12k/debug.h |   5 +-
>  drivers/net/wireless/ath/ath12k/mac.c   | 504 +++++++++++++++++++-----
>  drivers/net/wireless/ath/ath12k/peer.c  | 115 ++++++
>  drivers/net/wireless/ath/ath12k/peer.h  |  12 +
>  drivers/net/wireless/ath/ath12k/wmi.c   | 191 ++++++++-
>  drivers/net/wireless/ath/ath12k/wmi.h   | 115 ++++++
>  8 files changed, 848 insertions(+), 125 deletions(-)
> 
> 
> base-commit: fa934bf3e0a825ee09f035c6580af513187d59a2

with this series I see a new warning with gcc:
drivers/net/wireless/ath/ath12k/mac.c: In function 'ath12k_bss_assoc':
drivers/net/wireless/ath/ath12k/mac.c:3080:1: warning: the frame size of 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]

we should clean this up with a subsequent patch

I'm taking the current series into 'pending'

/jeff

