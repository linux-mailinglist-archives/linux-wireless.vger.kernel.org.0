Return-Path: <linux-wireless+bounces-7644-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EA78C5775
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 15:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EAF51C20AFA
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 13:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035F213FD78;
	Tue, 14 May 2024 13:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="F813lmfN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF076D1A7
	for <linux-wireless@vger.kernel.org>; Tue, 14 May 2024 13:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715695179; cv=none; b=fO1Is7iD0cbId+iobLGvhBUruFx6dilHCfXuxrinIbpW+ZEG3AtxAaVsHK6cuJUwUYXaOU8J9ddyJmpy62okmx4ZJmQJv33hTyEA43+alw7xDe/VULo8w/JEc45+7tTVQx1MywPdU1gmq7SZH0Mtmlhffcur2y6R9pZCCX+3HPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715695179; c=relaxed/simple;
	bh=up8cRYJsuqWRye8sSzxE+AamgdBXueAo/Xo3Ox6CmLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cMQWbG5lK6u2CBY0hB8jcj37i2RVFszlwnqJnPBJEM0l5BrcQYK8bGIH5gOts7Wy6IEZLjc7Yb1KR6kLAn/qBEgSvqLYykxMwR4qMXY8ly1GEDEKnM8sczgwQ2g07ibgbzjdnz9UZf3BIFsTPVhxXDXCzgnFZXiLdOXzCnXWL9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=F813lmfN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44EBqCFl025313;
	Tue, 14 May 2024 13:59:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=dO4K+V4nu1bVx/veardWvikwZFhFihIRf9GHQlsVk2s=; b=F8
	13lmfNLDnAOYAzWrUV6U6ue83J4S4yu/g7PZuTS+4VMp3r5OzbSVfwDEzEYX+pSR
	usKWHSe/Ezir4WX0EnVDfOFLS9WTDnW1EFD9ZtJ+sK/KZWjz+pH4PlM7lmkq8Gtr
	nGaDmih0TyqdnmUGEIfq5P+jS2KrdQ1rxN/y9V+LhaBTbWIKUe0+QQp1oIMNzWVf
	ySiix45gBQXLsKFS95n9QEaB/aNm74G5N8twApz9hfbFKq8IU3q2EZqtN7Vnc2Ld
	W1XYbxeckbCznpCjQ+05IZxDf2etkpw+dg3Mydqr7a/Wzse/UKUj9OJWDjZZgwAk
	vsXrXFkC/R2oixwbYzIQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y47f40a27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 13:59:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44EDxUci028559
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 13:59:30 GMT
Received: from [10.110.0.4] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 14 May
 2024 06:59:29 -0700
Message-ID: <762aebb1-2bd0-4445-a51f-fea81eb952e0@quicinc.com>
Date: Tue, 14 May 2024 06:59:28 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] wifi: ath12k: prepare vif and sta datastructure
Content-Language: en-US
To: Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
References: <20240512110251.4062260-1-quic_ramess@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240512110251.4062260-1-quic_ramess@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SbTUH9OdExusxTeguGganpVtdFpDf3i9
X-Proofpoint-ORIG-GUID: SbTUH9OdExusxTeguGganpVtdFpDf3i9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_07,2024-05-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 mlxlogscore=766
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405140099

On 5/12/2024 4:02 AM, Rameshkumar Sundaram wrote:
> From: Sriram R <quic_srirrama@quicinc.com>
> 
> To prepare the driver for MLO support, split the driver vif and sta
> data structure to scale for multiple links. This requires changing
> the use of arvif and arsta to per link and not per hw which can now
> comprise of multiple links.
> Also since most configurations from mac80211 are done per link,
> do refactoring of the driver functions to apply these configurations
> at link level.
> Add the required locking changes to synchronize the usage of these
> per link objects.
> 
> ---
> v3:
>  - Rebased on ToT
> v2:
>  - Rebased PATCH 1/3 on ToT as b0afabc4d7e0 (wifi: ath12k: add support to
>    handle beacon miss for WCN7850) has introduced few APIs that use
>    arvif.
> 
> 
> Sriram R (3):
>   wifi: ath12k: prepare vif data structure for MLO handling
>   wifi: ath12k: pass ath12k_link_vif instead of vif/ahvif
>   wifi: ath12k: prepare sta data structure for MLO handling
> 
>  drivers/net/wireless/ath/ath12k/core.h   |  85 ++-
>  drivers/net/wireless/ath/ath12k/dp.c     |  21 +-
>  drivers/net/wireless/ath/ath12k/dp.h     |   3 +-
>  drivers/net/wireless/ath/ath12k/dp_mon.c |  14 +-
>  drivers/net/wireless/ath/ath12k/dp_rx.c  |  16 +-
>  drivers/net/wireless/ath/ath12k/dp_rx.h  |   2 +-
>  drivers/net/wireless/ath/ath12k/dp_tx.c  |   9 +-
>  drivers/net/wireless/ath/ath12k/dp_tx.h  |   2 +-
>  drivers/net/wireless/ath/ath12k/mac.c    | 856 +++++++++++++++--------
>  drivers/net/wireless/ath/ath12k/mac.h    |   9 +-
>  drivers/net/wireless/ath/ath12k/p2p.c    |  17 +-
>  drivers/net/wireless/ath/ath12k/p2p.h    |   2 +-
>  drivers/net/wireless/ath/ath12k/peer.c   |   7 +-
>  drivers/net/wireless/ath/ath12k/peer.h   |   4 +-
>  drivers/net/wireless/ath/ath12k/wmi.c    |  12 +-
>  15 files changed, 681 insertions(+), 378 deletions(-)
> 
> base-commit: 1025c616ee13372f3803b158abb1d87ef368ae3d
This series still LGTM

