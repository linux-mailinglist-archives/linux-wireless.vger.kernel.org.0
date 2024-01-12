Return-Path: <linux-wireless+bounces-1838-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C11AA82C54D
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 19:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56B7C280E43
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 18:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B4F25607;
	Fri, 12 Jan 2024 18:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AH2Z89xV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405B025602
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 18:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40CFSTQM003125;
	Fri, 12 Jan 2024 18:15:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Nig09iz58XsyzUBOBL/CTQh1yntfAaIG9cqfSf2ISQI=; b=AH
	2Z89xV3v0n6GK3Kqs/d/anqCS1ncU5mTxihTnmEY1OuqKIpvThiWkld3jOZmxMVH
	XfEmjdMDWX9J7zh8mNU//5eL5N+Cv5pEmZd6Dxhp+DP0FI+o2FzGgUIVVYREMnoa
	kqu3hO0YWAbIbDDY84r60O2XyxQq7M8C2EScmiaMyf8TietLK7zFhDpGLBc3ddgL
	pFTX0sreW6F0V+wLZc+OEBV5v9ih9gZHfFZwZjtJjM0kufrjYOmTARaTcoY/haFS
	mP0SU7LgeJlnVOHGFIhhv7rzvvcBonsw4dAv+iZZnjUlUlfaTLQjnV5bdr6Wr3/R
	48B2NHXj7fZgoHTX2MkQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vk1x19cjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 18:15:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40CIFowY010768
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 18:15:50 GMT
Received: from [10.110.16.29] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 12 Jan
 2024 10:15:49 -0800
Message-ID: <9e950030-2781-4fd7-84f1-cb7fd6197e6b@quicinc.com>
Date: Fri, 12 Jan 2024 10:15:48 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/12] wifi: ath12k: modify regulatory support for single
 wiphy architecture
Content-Language: en-US
To: Sriram R <quic_srirrama@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240111045045.28377-1-quic_srirrama@quicinc.com>
 <20240111045045.28377-10-quic_srirrama@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240111045045.28377-10-quic_srirrama@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jx1DHwfWv8qbIxtUS1zE87xDa4A6siao
X-Proofpoint-GUID: jx1DHwfWv8qbIxtUS1zE87xDa4A6siao
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 mlxscore=0 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401120142

On 1/10/2024 8:50 PM, Sriram R wrote:
> With all the radios being combined and registered as a single
> mac80211 hw/wiphy, separate regd built from firmware rules need
> not be updated to cfg80211. Rather we can pick one of the regd
> built from the rules to update to cfg80211 for the whole
> registered device. We prefer 6 GHz pdev based rules since it has
> the rules for all bands. If the hw doesn't support 6 GHz, then update
> rules from one of the pdevs.

Do you need to handle the case where there are multiple instances of
hardware that have divergent regds? I'm thinking of a case where there
are 3 underlying hardware platforms, one that is 2 GHz, one that is 5
GHz, and one that is 6 GHz, and each of them has a regd that only has
the rules for the supported band. In such a case wouldn't you need to
aggregate the rules in the wiphy, not just pick one of the sets of rules?

If that is not an expected case, ideally you should describe the
requirements & assumptions that are in play here.

> 
> Also, when regulatory notification is received, update to all the
> underlying radios/ar so that it becomes aware of the change and as
> well us it updates its local regd with the new country rules. Later
> pick the appropriate pdev's regd(6 GHz if available) and apply to
> cfg80211.

Here again, can you elaborate on the requirements and assumptions? Do
you update all channels to each hardware, even if each hardware only
supports a single band?

> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/core.h |  2 +
>  drivers/net/wireless/ath/ath12k/mac.c  |  2 +
>  drivers/net/wireless/ath/ath12k/reg.c  | 60 ++++++++++++++++++++++----
>  3 files changed, 55 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index 883556313fb0..ac7b48cc2e7e 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -630,6 +630,8 @@ struct ath12k_hw {
>  	struct mutex conf_mutex;
>  
>  	u8 num_radio;
> +	bool regd_updated;
> +	bool use_6ghz_regd;
>  	struct ath12k radio[] __aligned(sizeof(void *));
>  };
>  
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 25d82c6fe89a..2f19d6c5b741 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -7948,6 +7948,7 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
>  	struct ath12k_wmi_hal_reg_capabilities_ext_arg *reg_cap;
>  	void *channels;
>  	u32 phy_id;
> +	struct ath12k_hw *ah = ar->ah;
>  
>  	BUILD_BUG_ON((ARRAY_SIZE(ath12k_2ghz_channels) +
>  		      ARRAY_SIZE(ath12k_5ghz_channels) +
> @@ -8000,6 +8001,7 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
>  			ath12k_mac_update_ch_list(ar, band,
>  						  reg_cap->low_5ghz_chan,
>  						  reg_cap->high_5ghz_chan);
> +			ah->use_6ghz_regd = true;
>  		}
>  
>  		if (reg_cap->low_5ghz_chan < ATH12K_MIN_6G_FREQ) {
> diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
> index da64482f1024..3a3f66d8ea11 100644
> --- a/drivers/net/wireless/ath/ath12k/reg.c
> +++ b/drivers/net/wireless/ath/ath12k/reg.c
> @@ -50,7 +50,7 @@ ath12k_reg_notifier(struct wiphy *wiphy, struct regulatory_request *request)
>  	struct ath12k_wmi_init_country_arg arg;
>  	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
>  	struct ath12k *ar = ath12k_ah_to_ar(ah, 0);
> -	int ret;
> +	int ret, i;
>  
>  	ath12k_dbg(ar->ab, ATH12K_DBG_REG,
>  		   "Regulatory Notification received for %s\n", wiphy_name(wiphy));
> @@ -85,10 +85,17 @@ ath12k_reg_notifier(struct wiphy *wiphy, struct regulatory_request *request)
>  	memcpy(&arg.cc_info.alpha2, request->alpha2, 2);
>  	arg.cc_info.alpha2[2] = 0;
>  
> -	ret = ath12k_wmi_send_init_country_cmd(ar, &arg);
> -	if (ret)
> -		ath12k_warn(ar->ab,
> -			    "INIT Country code set to fw failed : %d\n", ret);
> +	/* Allow fresh updates to wiphy regd */
> +	ah->regd_updated = false;
> +
> +	/* Send the reg change request to all the radios */
> +	for (i = 0; i < ah->num_radio; i++) {
> +		ret = ath12k_wmi_send_init_country_cmd(ar, &arg);
> +		if (ret)
> +			ath12k_warn(ar->ab,
> +				    "INIT Country code set to fw failed : %d\n", ret);
> +		ar++;
> +	}
>  }
>  
>  int ath12k_reg_update_chan_list(struct ath12k *ar)
> @@ -204,8 +211,31 @@ int ath12k_regd_update(struct ath12k *ar, bool init)
>  	struct ieee80211_regdomain *regd, *regd_copy = NULL;
>  	int ret, regd_len, pdev_id;
>  	struct ath12k_base *ab;
> +	struct ath12k_hw *ah;
> +	int i;
>  
>  	ab = ar->ab;
> +	ah = ar->ah;
> +
> +	/* If one of the radios within ah has already updated the regd for
> +	 * the wiphy, then avoid setting regd again
> +	 */
> +	if (ah->regd_updated)
> +		return 0;
> +
> +	/* firmware provides reg rules which are similar for 2 GHz and 5 GHz
> +	 * pdev but 6 GHz pdev has superset of all rules including rules for
> +	 * all bands, we prefer 6 GHz pdev's rules to be used for setup of
> +	 * the wiphy regd.
> +	 * If 6 GHz pdev was part of the ath12k_hw, wait for the 6 GHz pdev,
> +	 * else pick the first pdev which calls this function and use its
> +	 * regd to update global hw regd.
> +	 * The regd_updated flag set at the end will not allow any further
> +	 * updates.
> +	 */
> +	if (ah->use_6ghz_regd && !ar->supports_6ghz)
> +		return 0;
> +
>  	pdev_id = ar->pdev_idx;
>  
>  	spin_lock_bh(&ab->base_lock);
> @@ -258,10 +288,22 @@ int ath12k_regd_update(struct ath12k *ar, bool init)
>  	if (ret)
>  		goto err;
>  
> -	if (ar->state == ATH12K_STATE_ON) {
> -		ret = ath12k_reg_update_chan_list(ar);
> -		if (ret)
> -			goto err;
> +	ah->regd_updated = true;
> +
> +	/* Apply the new regd to all the radios, this is expected to be received only once
> +	 * since we check for ah->regd_updated and allow here only once
> +	 */
> +	ar = ah->radio;
> +	ab = ar->ab;
> +
> +	for (i = 0; i < ah->num_radio; i++) {
> +		if (ar->state == ATH12K_STATE_ON) {
> +			ret = ath12k_reg_update_chan_list(ar);
> +			if (ret)
> +				goto err;
> +		}
> +		ar++;
> +		ab = ar->ab;
>  	}
>  
>  	return 0;


