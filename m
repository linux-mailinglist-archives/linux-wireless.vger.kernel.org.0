Return-Path: <linux-wireless+bounces-15037-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42ED19BFED5
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 08:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E84F81F22AB7
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 07:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A311993B6;
	Thu,  7 Nov 2024 07:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CiI28Nu6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D840198E77
	for <linux-wireless@vger.kernel.org>; Thu,  7 Nov 2024 07:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730963707; cv=none; b=Dl5MewhQhZfT4H8kKsx0nlJVG9j9+QT/ACLKzPCBv7WWeZetQQYK5PDMUN1DbqbuTlpCeG0OiUoFscwV8KbtoE+ApLV0V4kUpmkAoviD228gyAeZhJWeqbGjib1/+ASmYvUcfVQvElZW9eLvqe8n45H1GZxOSZXLrMvTr7ECh7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730963707; c=relaxed/simple;
	bh=Ad9EvsrIhyZoo1Zn9ld2nb237dA3okLxS8BTWEmIV6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fmaEH2HMJbnMINEY//WCxtetttLhC0rZcOqe4yxkzYW3/JXabhjD9586F7yttznx68qu5mGLX1C/eCWRtdgcrB4ZIwV+RrMoLUPdqIY9KNlZFR7Y6s27R75gJ4N0EPq1bg7hZObKDqli+vkZBgpoOSZanan5ivkyqc+dB9NDQUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CiI28Nu6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6GR5xw024800;
	Thu, 7 Nov 2024 07:14:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5GyVFeKjPDh+r9v38j1LkPtGP9YGIVQdB+W3N7dW7gU=; b=CiI28Nu60RgjTjm4
	r2s8b9mXiT+S6i72iMlwCo/z/vdWhiCAJ0JGHQELtKvGZeCx8FzPG2LvLArUfHcs
	uyRl4cpLtRwtP1WOPUBuXb7/SYoEzGCp9asDjlF+ab+R6tk4ULqQB7QrjjjNR/d/
	5c9e7S9DVdNd/FqqzcMJmeP1aH2nNJr+SbFcA9ABD6MfbkQkiqs1/4EzWnWUTmu9
	wQHXGNls36qIXDApCaT0KIAkSqebhbGYSWejERXd+vcsVwJrvfKrH3y2RBYpuOk4
	ndima01wBa4Ba8/nkPSMv4qn5rB9JXK7qeVDkb8jW6sMTY5H7/UHRB3EmQe6n8cC
	hH7MnA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42r2uguhhb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 07:14:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A77Ev23013015
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Nov 2024 07:14:57 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 6 Nov 2024
 23:14:56 -0800
Message-ID: <e028f65c-9faa-46e0-ae34-35815a121ba9@quicinc.com>
Date: Thu, 7 Nov 2024 15:14:55 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] wifi: ath12k: support change_sta_links() mac80211 op
To: Kalle Valo <kvalo@kernel.org>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20241106142617.660901-1-kvalo@kernel.org>
 <20241106142617.660901-3-kvalo@kernel.org>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <20241106142617.660901-3-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 08IIgzso3jVlBt8-RTdl8tny2qgCyD5n
X-Proofpoint-GUID: 08IIgzso3jVlBt8-RTdl8tny2qgCyD5n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070053



On 11/6/2024 10:26 PM, Kalle Valo wrote:
> From: Sriram R <quic_srirrama@quicinc.com>
> 
> Add ath12k_mac_op_change_sta_links() for adding and removing
> link station.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/mac.c | 97 ++++++++++++++++++++++++++-
>  1 file changed, 96 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 0ff886e4b3ed..c0cc4e51a4d1 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -5572,6 +5572,101 @@ static void ath12k_mac_op_sta_rc_update(struct ieee80211_hw *hw,
>  	rcu_read_unlock();
>  }
>  
> +static struct ath12k_link_sta *
> +ath12k_mac_alloc_assign_link_sta(struct ath12k_hw *ah,
> +				 struct ath12k_sta *ahsta,
> +				 struct ath12k_vif *ahvif, u8 link_id)
> +{
> +	struct ath12k_link_sta *arsta;
> +	int ret;
> +
> +	lockdep_assert_wiphy(ah->hw->wiphy);
> +
> +	if (link_id >= IEEE80211_MLD_MAX_NUM_LINKS)
> +		return NULL;
> +
> +	arsta = wiphy_dereference(ah->hw->wiphy, ahsta->link[link_id]);
> +	if (arsta)
> +		return NULL;
> +
> +	arsta = kzalloc(sizeof(*arsta), GFP_KERNEL);
kmalloc() is preferred as ath12k_mac_assign_link_sta() will do 'zero'?

> +	if (!arsta)
> +		return NULL;
> +
> +	ret = ath12k_mac_assign_link_sta(ah, ahsta, arsta, ahvif, link_id);
> +	if (ret) {
> +		kfree(arsta);
> +		return NULL;
> +	}
> +
> +	return arsta;
> +}
> +

