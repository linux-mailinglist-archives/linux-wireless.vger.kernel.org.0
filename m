Return-Path: <linux-wireless+bounces-7149-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED26B8BAF2E
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2024 16:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229851C217DD
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2024 14:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA4957C84;
	Fri,  3 May 2024 14:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oKmco/UH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21622E827
	for <linux-wireless@vger.kernel.org>; Fri,  3 May 2024 14:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714747510; cv=none; b=ZsKKnsdbNFnmpKpFZ/4QRs4+KuvyGS9kfqeYEBc+hi7x3DxLeQOjpcE0kDmg/XknI97on6KkwAIh6prV2O62rgYlWPKuMjKDqkxnbHPwrZFsvTvghAfvw5ccXdbLLvZq1Q8svPbl161XLJwnLHBvlamwL5vIwLD1IQSo0FxNORc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714747510; c=relaxed/simple;
	bh=yo8lhtC/yChbwR48YEoWd8y5xz9NQBzeR7H9BR7EVno=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dqRn+dJAWzkBVmDB5pOJtS5Hmc2LM/PEuMD71HDGHm8u9ESxOb6uqjuhspmEpWVMER1h5/D/F8A3sCojlm8aC+i6o7yC+21PpaK6oX812OIwYP52KgIBJTh/N3kZ2urvHp/yygDF/jYUG3560ljM+K7458K6aC0g5ziqgiUc2Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oKmco/UH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 443ERXCt006149;
	Fri, 3 May 2024 14:45:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=3KH+WKs3dkeXyUiLf3eosfs6mewzmj9qJ50XRDAHZRo=; b=oK
	mco/UHsTxRCMGinfuzfvKvVFz/7bXUzatWRwlcdttKUY3xhkGjdLyz1lj7UdT97F
	6i6nZttLuCG4Zrq0JHRgCjX1o8h6qdMhpzRp7y8e/m2IANbuSKc+urn9sA0vtSxJ
	ofHC/VIImzMyXhEDY2XKpnLj6Ppv0YzOaf9upUSWz52+rB8Bx8SeiH9QtznCXBQM
	yM12MQWGmR6giD0CMgqkPa8E2tkZlQ7SfOs+vg8TPgmjAlgO9c55kkjWzMHmA4bK
	Duq7iDD5YJ/6ZpyPBOIHotyIsqSB13QssMTzhNs/KfasKSXWnhiY3dBhTro/RxQm
	F/Q4UWqukR8yQm2bbKIA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xvawbjt9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 May 2024 14:45:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 443Ej3Ua012697
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 3 May 2024 14:45:03 GMT
Received: from [10.110.94.246] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 3 May 2024
 07:45:03 -0700
Message-ID: <f45e12e1-ad97-4e6c-a8d7-b077f17158cb@quicinc.com>
Date: Fri, 3 May 2024 07:45:02 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] wifi: ath12k: prepare vif and sta datastructure
 for MLO handling
Content-Language: en-US
To: Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
References: <20240502171240.927155-1-quic_ramess@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240502171240.927155-1-quic_ramess@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PZ_ji8_zkPm_ivFLCxuaI-Zse6E9pLa8
X-Proofpoint-ORIG-GUID: PZ_ji8_zkPm_ivFLCxuaI-Zse6E9pLa8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_09,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 adultscore=0
 mlxlogscore=936 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405030104

On 5/2/2024 10:12 AM, Rameshkumar Sundaram wrote:
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
>  drivers/net/wireless/ath/ath12k/core.h   |  84 ++-
>  drivers/net/wireless/ath/ath12k/dp.c     |  21 +-
>  drivers/net/wireless/ath/ath12k/dp.h     |   3 +-
>  drivers/net/wireless/ath/ath12k/dp_mon.c |  14 +-
>  drivers/net/wireless/ath/ath12k/dp_rx.c  |  16 +-
>  drivers/net/wireless/ath/ath12k/dp_rx.h  |   2 +-
>  drivers/net/wireless/ath/ath12k/dp_tx.c  |   9 +-
>  drivers/net/wireless/ath/ath12k/dp_tx.h  |   4 +-
>  drivers/net/wireless/ath/ath12k/mac.c    | 861 +++++++++++++++--------
>  drivers/net/wireless/ath/ath12k/mac.h    |   9 +-
>  drivers/net/wireless/ath/ath12k/p2p.c    |  17 +-
>  drivers/net/wireless/ath/ath12k/p2p.h    |   2 +-
>  drivers/net/wireless/ath/ath12k/peer.c   |   7 +-
>  drivers/net/wireless/ath/ath12k/peer.h   |   4 +-
>  drivers/net/wireless/ath/ath12k/wmi.c    |  12 +-
>  15 files changed, 684 insertions(+), 381 deletions(-)
> 
> 
> base-commit: 25a42664a2e2587f2582e0717f2a71d0bdcc4be0

Kalle, please don't merge this.
I'm seeing an firmware crash on x86 WCN7850 with this version

