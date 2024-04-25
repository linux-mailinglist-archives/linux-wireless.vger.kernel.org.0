Return-Path: <linux-wireless+bounces-6900-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 756718B2D2E
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Apr 2024 00:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 144361F22377
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 22:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FFE6BFA8;
	Thu, 25 Apr 2024 22:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IxlCzTbN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2428B2599
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 22:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714084819; cv=none; b=eY76cc4UWP/e1XmAJLLoB7E+nneI2PaUDBpzvbd2XqF3Nsh00WvIsrh4vhzZFB28LGHb108r8qQUddU0l+vqFzaRNBlw2ivD4p2HJs2lO4vBav6C+/WcpscfppVJO5OqmcwyY1TXmZMd3qxkPQl+/DeybalODiUCNCb6Ha9SyMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714084819; c=relaxed/simple;
	bh=+rIWMqkiVllcJy6nJIfVJSLFTgbhWDKTnrpZAvaHgr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PrDQsdv2QQFVAMiDXJvjoRW3njEhmFjmJ3UE0CG8TNWfm2XNW2De8Ut5trw0d6nHVCsWMR7TOiObt4uBsiL9awhw2mUUOkXYDLVPdRTx33+O41AGS1mEhWSHyEeVF42HJ7xefVa/Hsltlbp36AqLm8GTBlvm9yzXvAcGggPPeWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IxlCzTbN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43PGQoXn005941;
	Thu, 25 Apr 2024 22:40:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=3Y0qkvTTLGDDMHjevLrB9xvkRZGRG8z5t23AfLcLXi4=; b=Ix
	lCzTbNpNQrAdGC195K1T4g5xB24H1Y5/jK/S/D5tt0aZ/MjfrVlZurC8LHFnq4WB
	4418xxgmp2jUB3okR1fzCJN9wR57gush3GYdfFsSjAI0xmJxDiya0YZbmAtjaQnI
	xoBnwKlHpnMzR+V+QVc1ZGpbaIXYx/eLmyObbWy91/nRv08KDJSJuJTfeABgbJES
	WHoUSnCqn/jLaq7eNrnqgAYHunJfgWxtJMdSLVNapOas0q3TFhYaRhFw1698WI6F
	UVhaYQOVwHa7j7Sch6FFPlS0QP7OceVvV9dEpFxwKNUKkO7O6ZNVQXoSlhuSXTda
	za97VgI4dXKapbT16Lxg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqtph8r1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 22:40:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43PMe6lu003912
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 22:40:06 GMT
Received: from [10.110.19.58] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Apr
 2024 15:40:05 -0700
Message-ID: <034950cb-cf04-443f-a13c-b7d7a47ff0d7@quicinc.com>
Date: Thu, 25 Apr 2024 15:40:04 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/10] wifi: ath12k: push HE MU-MIMO params from
 hostapd to hardware
Content-Language: en-US
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Muna Sinada <quic_msinada@quicinc.com>
References: <20240424201959.935-1-quic_pradeepc@quicinc.com>
 <20240424201959.935-3-quic_pradeepc@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240424201959.935-3-quic_pradeepc@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Mm9avUMmY5TpLMxj-WND8KNqxbbpfO0i
X-Proofpoint-ORIG-GUID: Mm9avUMmY5TpLMxj-WND8KNqxbbpfO0i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_21,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404250166

On 4/24/2024 1:19 PM, Pradeep Kumar Chitrapu wrote:
> Currently, only the HE IE in management frames is updated with
> respect to MU-MIMO configurations, but this change is not
> reflected in the hardware. Add support to propagate MU-MIMO
> configurations to the hardware as well.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Co-developed-by: Muna Sinada <quic_msinada@quicinc.com>
> Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/mac.c | 214 +++++++++++++++++---------
>  drivers/net/wireless/ath/ath12k/mac.h |  15 ++
>  drivers/net/wireless/ath/ath12k/wmi.h |  28 +---
>  3 files changed, 155 insertions(+), 102 deletions(-)
> 

[...]

>  static void ath12k_bss_assoc(struct ath12k *ar,
>  			     struct ath12k_vif *arvif,
>  			     struct ieee80211_bss_conf *bss_conf)

drivers/net/wireless/ath/ath12k/mac.c:2816:13: warning: context imbalance in 'ath12k_bss_assoc' - wrong count at exit

see reason below

>  {
>  	struct ieee80211_vif *vif = arvif->vif;
>  	struct ath12k_wmi_peer_assoc_arg peer_arg;
> +	struct ieee80211_sta_he_cap he_cap;
>  	struct ieee80211_sta *ap_sta;
>  	struct ath12k_peer *peer;
>  	bool is_auth = false;
> +	u32 hemode = 0;
>  	int ret;
>  
>  	lockdep_assert_held(&ar->conf_mutex);
> @@ -2556,8 +2660,28 @@ static void ath12k_bss_assoc(struct ath12k *ar,
>  
>  	ath12k_peer_assoc_prepare(ar, vif, ap_sta, &peer_arg, false);
>  
> +	/* he_cap here is updated at assoc success for sta mode only */
> +	he_cap = ap_sta->deflink.he_cap;
> +
> +	/* ap_sta->deflink.he_cap must be protected by rcu_read_lock */
> +	ret = ath12k_mac_vif_recalc_sta_he_txbf(ar, vif, &he_cap, &hemode);
> +	if (ret) {
> +		ath12k_warn(ar->ab, "failed to recalc he txbf for vdev %i on bss %pM: %d\n",
> +			    arvif->vdev_id, bss_conf->bssid, ret);
> +		return;

bad return within rcu_read_lock() critical section

> +	}
> +
>  	rcu_read_unlock();
>  


