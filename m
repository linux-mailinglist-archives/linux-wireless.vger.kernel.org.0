Return-Path: <linux-wireless+bounces-28015-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 835A4BE6B96
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 08:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A4294ED9E7
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 06:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A6930C37D;
	Fri, 17 Oct 2025 06:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jTPkjM6D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFFE222578
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 06:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760683107; cv=none; b=NosyQ0T5G/z8mPOJyhrx+r6QgmR5Dmwb9vMPkqwO+3aNyZdqQDVxAdNhW5jPep57V2/OQwxtF1imnpetSe0q802gF3rXTNSQXrxobgad/JO5shXByzmhKKYezoRHcIf8SPcc38eq5LyKFWvvmzBJ/yhERhEtMbl7nizVRFo99pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760683107; c=relaxed/simple;
	bh=GrBBYUqGHQdj0H87eMw6CRpe5enc9YIIA3z6kaiZpWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GZbsyJQgLZJglgKdWUFQ3eESndFj9d8JaZpzmqRWhMdAnr3QDqtbrcKSaFzR0lnG/1Av04gfEi/98wpIh2+c5+IAfgU0UxALlq5A0tDXlgK2HcPICloK6hb1ILtkRVeHw7tOL7udl0iT++T+wovpXwe3pRPeYz5/5IfBGim/Elk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jTPkjM6D; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GKLQOm001991
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 06:38:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gR2pJGNH53WLI1b856IvfyQUV7ab3YBLxjBakOT1Upk=; b=jTPkjM6DW63Tez13
	r/l9VsMRp4/rN+t+amCX5drYaasBi1NGaBIEQPEUvTKdCq3/5H/iKj3WL62wCBOr
	tiwymJocyWrMr1fhb2yk/ttxBOJjuoeMffyUpuJij3S1wDqaY4xKv5x2oW92ZN0h
	QKFlzSpiBeoaFP4vByV9UchyfjIQ91FCFI9amTD7gOr8IIhtSjf0O3UvLVYdpWQL
	Tl/esHyQUEZmdKVljca+QiXlN5wsSkwzI9MH1BK9G6mVwb81D2Hnef74Hb2jUvQ1
	ezOTdKjuQCgvLLQFJdZV3CUbsHcdxqqZNjRgAzgsWcGM+i4O8mVV9eyIiAKrJ+Ad
	eYdUrA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfa8k5t5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 06:38:23 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3304def7909so1422484a91.3
        for <linux-wireless@vger.kernel.org>; Thu, 16 Oct 2025 23:38:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760683102; x=1761287902;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gR2pJGNH53WLI1b856IvfyQUV7ab3YBLxjBakOT1Upk=;
        b=cIoMGJ8e8HQ2ldaScygHBCivgtgHmg4Gya0V8Em9eFeSOW4nIePJE6HnNlNu9N9zmK
         woxuxRk9d7zjAzZlqUKbFqndyIKi2vauJf5lCYB8NAdJtDD0diiIRcrLQRcn6YQSuQEH
         iwt/VkD8AWKa5ddklM++mKyf+Nmf9zDZArNX2264T8s15XiGLWaA0I2A6J6puCjlWCIo
         yn1teM73NZgLquHs40JgDoa5hL/xKU1PI2Oydnao6vGpPtsgHZHqgbedAbwix21fAS1s
         +1p1Zza9sGfhy9BkcEJiK3fzYFhJiVmJ8vhF6DRFcNYSmkTm76J6Jl45ofjSVGC7L7Y9
         kxkw==
X-Forwarded-Encrypted: i=1; AJvYcCUajXTOMUVZ3R/VvqY74n9vP3ZHhECL9acjy0inuaEarnF/HNUtVbupTsCF9lFkGl9sEKJhGQ+KPbaE2pZqzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDqBjbXwO1Qp3mVnOPUVb0+5eQf7CgOlqjEe4dE5We7zJK2VrE
	BLE69evZAM5s+fp/87q9SLFzD6l9UIP9hEL64MYzGeE+bp4W0yDYHibiX+PBUDcjWjiUyF/eUs2
	ux1q4seqUIkw+TBPfsC499cfRJkLh6kuSiV9t5cgGvsMlMFp7rn8y9k7D1wyCvY4y7aKAlA==
X-Gm-Gg: ASbGncut989bylZ7ewe5QIObao5f9Se4dqhUr3Y0BAJ6PuiKYJa0KAPM0r2sjNokWg1
	rwHU5Q1Qxjf224HmnbrzO/DdeJnr+gRv69Cdh51k5bSdaKaIpD2eHsi6NbsVJOfD2U7cZndiwqi
	P68z4jwQMay5Fsy3e/Kk8NrqOn2ZxkKGjCiHQWtvp9o8a0URyo+hZizXCcff3XS7NkfAFizK2k/
	QeAfo7OR95CYrSeiBoC6WQt1xdhcYa7aw+HFhdmqVg/krFpNVUAB0MixD22T9gYT21OMcmZEfhw
	g5XypAFPvGkCO5Jo0nF20LrpJJ8Gahrs8NBTZXimXAGbHgsARfFSXWph9s9nTBzc/FbVFneDIR5
	Ns2nHF+dK111+cT1g7LuM8hvJd6ti/yRXdZuaxToR7qbTmOO0d6c6GJ5J0BSTtHL5IthsOZ8=
X-Received: by 2002:a17:90b:3c02:b0:32c:38b0:593e with SMTP id 98e67ed59e1d1-33bcf85ffa4mr3003297a91.5.1760683102119;
        Thu, 16 Oct 2025 23:38:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtz+jLZ7w4KOYrT/4BbYVccTxZJSAgfm3dGTBNFWS458M6tDekNtDtuTh+AJv+SvphB/n43Q==
X-Received: by 2002:a17:90b:3c02:b0:32c:38b0:593e with SMTP id 98e67ed59e1d1-33bcf85ffa4mr3003267a91.5.1760683101633;
        Thu, 16 Oct 2025 23:38:21 -0700 (PDT)
Received: from [10.133.33.11] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a22b7b05csm4915019a12.23.2025.10.16.23.38.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 23:38:21 -0700 (PDT)
Message-ID: <c901bf67-cf08-4187-a29f-1b2b066bd8a4@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 14:38:15 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 ath-next] wifi: ath12k: add support for BSS color
 change
To: Wei Zhang <wei.zhang@oss.qualcomm.com>, jeff.johnson@oss.qualcomm.com
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
References: <20251017060100.1751692-1-wei.zhang@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251017060100.1751692-1-wei.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: oHCW3G6HGgrnNoEuF84Klc4OMDCUjVGs
X-Proofpoint-ORIG-GUID: oHCW3G6HGgrnNoEuF84Klc4OMDCUjVGs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNyBTYWx0ZWRfX27vxSjdRdsyq
 iJ67ZLuxibODcGjmJIkgVPb2NmT/+TNiVx6aF+s6+1x1BKGvx7Ly1nUQ0tbD3hJHnCLwu+OGJ2B
 53rVL8Z7ohfSQEvGpxr6UrKmb0uNl2KB2qSJuRd0kqHIRlwWpjj7U3CVs//1Qlh2Tu3bBxgECBY
 dcxaNBHY0EJiBkwYx2zY6xvIiWJ2kj74HWgymU8jrg33tec6+uah2hReFw5ARvYkHhN3Ahro9we
 vha1sqjjrGjmMFiKK6LluKXUyeoarLaf4xVdCtffheQGG2IqWHAjfJEQSlOqFWXnP2tn5qn+lxg
 pNjWt/iT6L6ARZdX6PCjTh1WgXYSyXNn7qOp64DQZ9fYEasqR7OH+u72oy1yWQNnhfP4WEfpL9A
 uPPARE4fyxCWjzLXKbp5kk+G3oahVg==
X-Authority-Analysis: v=2.4 cv=JLw2csKb c=1 sm=1 tr=0 ts=68f1e45f cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=6FjxNNwmztaAyVa-sjcA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110017



On 10/17/2025 2:01 PM, Wei Zhang wrote:
> Add support for handling BSS color collision events reported by firmware.
> 
> There are two scenarios where a BSS color collision may be detected:
> 1. The AP's MAC detects the collision directly, and firmware reports a
>    BSS color collision event to the host.
> 2. A STA associated with the AP detects the collision. The notification
>    frame from the peer is routed directly to the AP firmware, which handles
>    it and sends the BSS color collision event to the host.
> 
> Add logic to parse and handle such events, and pass the data
> up to mac80211.
> 
> Unlike CSA, firmware does not provide an offload mechanism for BSS color
> change. Instead, the color change process is triggered via beacon offload
> TX completion events sent by firmware.
> 
> BSS color feature is enabled depending on service flag advertised by
> firmware, based on which color change functionality is invoked.
> 
> This change builds upon the following ath11k patch.
> commit 886433a98425 ("ath11k: add support for BSS color change")
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.IOE_HMT.1.1-00011-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
> 
> Signed-off-by: Wei Zhang <wei.zhang@oss.qualcomm.com>
> ---
> Changes in v2:
> - Drop "This patch" from commit message
> ---
>  drivers/net/wireless/ath/ath12k/core.h |  1 +
>  drivers/net/wireless/ath/ath12k/mac.c  | 58 +++++++++++++++++++-
>  drivers/net/wireless/ath/ath12k/wmi.c  | 73 +++++++++++++++++++++++++-
>  drivers/net/wireless/ath/ath12k/wmi.h  | 24 +++++++++
>  4 files changed, 154 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index 02a32b9f3ac2..41da0efaa854 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -356,6 +356,7 @@ struct ath12k_link_vif {
>  	bool pairwise_key_done;
>  	u16 num_stations;
>  	bool is_csa_in_progress;
> +	struct wiphy_work bcn_tx_work;
>  };
>  
>  struct ath12k_vif {
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 86b79deacf03..eb9b9a322870 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -3834,6 +3834,38 @@ static void ath12k_recalculate_mgmt_rate(struct ath12k *ar,
>  		ath12k_warn(ar->ab, "failed to set beacon tx rate %d\n", ret);
>  }
>  
> +static void ath12k_mac_bcn_tx_event(struct ath12k_link_vif *arvif)
> +{
> +	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(arvif->ahvif);
> +	struct ieee80211_bss_conf *link_conf;
> +
> +	link_conf = ath12k_mac_get_link_bss_conf(arvif);
> +	if (!link_conf) {
> +		ath12k_warn(arvif->ar->ab, "failed to get link conf for vdev %u\n",
> +			    arvif->vdev_id);
> +		return;
> +	}
> +
> +	if (link_conf->color_change_active) {
> +		if (ieee80211_beacon_cntdwn_is_complete(vif, arvif->link_id)) {
> +			ieee80211_color_change_finish(vif, arvif->link_id);
> +			return;
> +		}
> +
> +		ieee80211_beacon_update_cntdwn(vif, arvif->link_id);
> +		ath12k_mac_setup_bcn_tmpl(arvif);
> +	}
> +}
> +
> +static void ath12k_mac_bcn_tx_work(struct wiphy *wiphy, struct wiphy_work *work)
> +{
> +	struct ath12k_link_vif *arvif = container_of(work, struct ath12k_link_vif,
> +						     bcn_tx_work);
> +
> +	lockdep_assert_wiphy(wiphy);
> +	ath12k_mac_bcn_tx_event(arvif);
> +}
> +
>  static void ath12k_mac_init_arvif(struct ath12k_vif *ahvif,
>  				  struct ath12k_link_vif *arvif, int link_id)
>  {
> @@ -3863,6 +3895,7 @@ static void ath12k_mac_init_arvif(struct ath12k_vif *ahvif,
>  	INIT_LIST_HEAD(&arvif->list);
>  	INIT_DELAYED_WORK(&arvif->connection_loss_work,
>  			  ath12k_mac_vif_sta_connection_loss_work);
> +	wiphy_work_init(&arvif->bcn_tx_work, ath12k_mac_bcn_tx_work);
>  
>  	arvif->num_stations = 0;
>  
> @@ -3900,6 +3933,7 @@ static void ath12k_mac_remove_link_interface(struct ieee80211_hw *hw,
>  	lockdep_assert_wiphy(ah->hw->wiphy);
>  
>  	cancel_delayed_work_sync(&arvif->connection_loss_work);
> +	wiphy_work_cancel(ath12k_ar_to_hw(ar)->wiphy, &arvif->bcn_tx_work);
>  
>  	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac remove link interface (vdev %d link id %d)",
>  		   arvif->vdev_id, arvif->link_id);
> @@ -4547,8 +4581,25 @@ static void ath12k_mac_bss_info_changed(struct ath12k *ar,
>  							    ATH12K_BSS_COLOR_AP_PERIODS,
>  							    info->he_bss_color.enabled);
>  			if (ret)
> -				ath12k_warn(ar->ab, "failed to set bss color collision on vdev %i: %d\n",
> +				ath12k_warn(ar->ab, "failed to set bss color collision on vdev %u: %d\n",
>  					    arvif->vdev_id,  ret);
> +
> +			param_id = WMI_VDEV_PARAM_BSS_COLOR;
> +			if (info->he_bss_color.enabled)
> +				param_value = info->he_bss_color.color <<
> +					      IEEE80211_HE_OPERATION_BSS_COLOR_OFFSET;
> +			else
> +				param_value = IEEE80211_HE_OPERATION_BSS_COLOR_DISABLED;
> +
> +			ret = ath12k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
> +							    param_id,
> +							    param_value);
> +			if (ret)
> +				ath12k_warn(ar->ab, "failed to set bss color param on vdev %u: %d\n",
> +					    arvif->vdev_id,  ret);
> +			else
> +				ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "bss color param 0x%x set on vdev %u\n",
> +					   param_value, arvif->vdev_id);
>  		} else if (vif->type == NL80211_IFTYPE_STATION) {
>  			ret = ath12k_wmi_send_bss_color_change_enable_cmd(ar,
>  									  arvif->vdev_id,
> @@ -13972,6 +14023,11 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
>  	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
>  	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_STA_TX_PWR);
>  	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_ACK_SIGNAL_SUPPORT);
> +	if (test_bit(WMI_TLV_SERVICE_BSS_COLOR_OFFLOAD,
> +		     ab->wmi_ab.svc_map)) {
> +		wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BSS_COLOR);
> +		ieee80211_hw_set(hw, DETECTS_COLOR_COLLISION);
> +	}
>  
>  	wiphy->cipher_suites = cipher_suites;
>  	wiphy->n_cipher_suites = ARRAY_SIZE(cipher_suites);
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
> index e76275bd6916..5075d86df36f 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.c
> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> @@ -14,6 +14,7 @@
>  #include <linux/uuid.h>
>  #include <linux/time.h>
>  #include <linux/of.h>
> +#include <linux/cleanup.h>
>  #include "core.h"
>  #include "debugfs.h"
>  #include "debug.h"
> @@ -190,6 +191,8 @@ static const struct ath12k_wmi_tlv_policy ath12k_wmi_tlv_policies[] = {
>  		.min_len = sizeof(struct wmi_11d_new_cc_event) },
>  	[WMI_TAG_PER_CHAIN_RSSI_STATS] = {
>  		.min_len = sizeof(struct wmi_per_chain_rssi_stat_params) },
> +	[WMI_TAG_OBSS_COLOR_COLLISION_EVT] = {
> +		.min_len = sizeof(struct wmi_obss_color_collision_event) },
>  };
>  
>  __le32 ath12k_wmi_tlv_hdr(u32 cmd, u32 len)
> @@ -3850,6 +3853,58 @@ int ath12k_wmi_fils_discovery(struct ath12k *ar, u32 vdev_id, u32 interval,
>  	return ret;
>  }
>  
> +static void
> +ath12k_wmi_obss_color_collision_event(struct ath12k_base *ab, struct sk_buff *skb)
> +{
> +	const struct wmi_obss_color_collision_event *ev;
> +	struct ath12k_link_vif *arvif;
> +	u32 vdev_id, evt_type;
> +	u64 bitmap;
> +
> +	const void **tb __free(kfree) = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	if (IS_ERR(tb)) {
> +		ath12k_warn(ab, "failed to parse OBSS color collision tlv %ld\n",
> +			    PTR_ERR(tb));
> +		return;
> +	}
> +
> +	ev = tb[WMI_TAG_OBSS_COLOR_COLLISION_EVT];
> +	if (!ev) {
> +		ath12k_warn(ab, "failed to fetch OBSS color collision event\n");
> +		return;
> +	}
> +
> +	vdev_id = le32_to_cpu(ev->vdev_id);
> +	evt_type = le32_to_cpu(ev->evt_type);
> +	bitmap = le64_to_cpu(ev->obss_color_bitmap);
> +
> +	guard(rcu)();
> +
> +	arvif = ath12k_mac_get_arvif_by_vdev_id(ab, vdev_id);
> +	if (!arvif) {
> +		ath12k_warn(ab, "no arvif found for vdev %u in OBSS color collision event\n",
> +			    vdev_id);
> +		return;
> +	}
> +
> +	switch (evt_type) {
> +	case WMI_BSS_COLOR_COLLISION_DETECTION:
> +		ieee80211_obss_color_collision_notify(arvif->ahvif->vif,
> +						      bitmap,
> +						      arvif->link_id);
> +		ath12k_dbg(ab, ATH12K_DBG_WMI,
> +			   "obss color collision detected vdev %u event %d bitmap %016llx\n",
> +			   vdev_id, evt_type, bitmap);
> +		break;
> +	case WMI_BSS_COLOR_COLLISION_DISABLE:
> +	case WMI_BSS_COLOR_FREE_SLOT_TIMER_EXPIRY:
> +	case WMI_BSS_COLOR_FREE_SLOT_AVAILABLE:
> +		break;
> +	default:
> +		ath12k_warn(ab, "unknown OBSS color collision event type %d\n", evt_type);
> +	}
> +}
> +
>  static void
>  ath12k_fill_band_to_mac_param(struct ath12k_base  *soc,
>  			      struct ath12k_wmi_pdev_band_arg *arg)
> @@ -7014,12 +7069,26 @@ static void ath12k_vdev_start_resp_event(struct ath12k_base *ab, struct sk_buff
>  
>  static void ath12k_bcn_tx_status_event(struct ath12k_base *ab, struct sk_buff *skb)
>  {
> +	struct ath12k_link_vif *arvif;
> +	struct ath12k *ar;
>  	u32 vdev_id, tx_status;
>  
>  	if (ath12k_pull_bcn_tx_status_ev(ab, skb, &vdev_id, &tx_status) != 0) {
>  		ath12k_warn(ab, "failed to extract bcn tx status");
>  		return;
>  	}
> +
> +	guard(rcu)();
> +
> +	arvif = ath12k_mac_get_arvif_by_vdev_id(ab, vdev_id);
> +	if (!arvif) {
> +		ath12k_warn(ab, "invalid vdev %u in bcn tx status\n",
> +			    vdev_id);
> +		return;
> +	}
> +
> +	ar = arvif->ar;
> +	wiphy_work_queue(ath12k_ar_to_hw(ar)->wiphy, &arvif->bcn_tx_work);
>  }
>  
>  static void ath12k_vdev_stopped_event(struct ath12k_base *ab, struct sk_buff *skb)
> @@ -9877,6 +9946,9 @@ static void ath12k_wmi_op_rx(struct ath12k_base *ab, struct sk_buff *skb)
>  	case WMI_PDEV_RSSI_DBM_CONVERSION_PARAMS_INFO_EVENTID:
>  		ath12k_wmi_rssi_dbm_conversion_params_info_event(ab, skb);
>  		break;
> +	case WMI_OBSS_COLOR_COLLISION_DETECTION_EVENTID:
> +		ath12k_wmi_obss_color_collision_event(ab, skb);
> +		break;
>  	/* add Unsupported events (rare) here */
>  	case WMI_TBTTOFFSET_EXT_UPDATE_EVENTID:
>  	case WMI_PEER_OPER_MODE_CHANGE_EVENTID:
> @@ -9887,7 +9959,6 @@ static void ath12k_wmi_op_rx(struct ath12k_base *ab, struct sk_buff *skb)
>  	/* add Unsupported events (frequent) here */
>  	case WMI_PDEV_GET_HALPHY_CAL_STATUS_EVENTID:
>  	case WMI_MGMT_RX_FW_CONSUMED_EVENTID:
> -	case WMI_OBSS_COLOR_COLLISION_DETECTION_EVENTID:
>  		/* debug might flood hence silently ignore (no-op) */
>  		break;
>  	case WMI_PDEV_UTF_EVENTID:
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
> index 64bd968989c8..911ef9d52817 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.h
> +++ b/drivers/net/wireless/ath/ath12k/wmi.h
> @@ -4928,6 +4928,24 @@ struct wmi_obss_spatial_reuse_params_cmd {
>  #define ATH12K_BSS_COLOR_STA_PERIODS				10000
>  #define ATH12K_BSS_COLOR_AP_PERIODS				5000
>  
> +/**
> + * enum wmi_bss_color_collision - Event types for BSS color collision handling
> + * @WMI_BSS_COLOR_COLLISION_DISABLE: Indicates that BSS color collision detection
> + *                                   is disabled.
> + * @WMI_BSS_COLOR_COLLISION_DETECTION: Event triggered when a BSS color collision
> + *                                     is detected.
> + * @WMI_BSS_COLOR_FREE_SLOT_TIMER_EXPIRY: Event indicating that the timer for waiting
> + *                                        on a free BSS color slot has expired.
> + * @WMI_BSS_COLOR_FREE_SLOT_AVAILABLE: Event indicating that a free BSS color slot
> + *                                     has become available.
> + */
> +enum wmi_bss_color_collision {
> +	WMI_BSS_COLOR_COLLISION_DISABLE = 0,
> +	WMI_BSS_COLOR_COLLISION_DETECTION,
> +	WMI_BSS_COLOR_FREE_SLOT_TIMER_EXPIRY,
> +	WMI_BSS_COLOR_FREE_SLOT_AVAILABLE,
> +};
> +
>  struct wmi_obss_color_collision_cfg_params_cmd {
>  	__le32 tlv_header;
>  	__le32 vdev_id;
> @@ -4945,6 +4963,12 @@ struct wmi_bss_color_change_enable_params_cmd {
>  	__le32 enable;
>  } __packed;
>  
> +struct wmi_obss_color_collision_event {
> +	__le32 vdev_id;
> +	__le32 evt_type;
> +	__le64 obss_color_bitmap;
> +} __packed;
> +
>  #define ATH12K_IPV4_TH_SEED_SIZE 5
>  #define ATH12K_IPV6_TH_SEED_SIZE 11
>  
> 
> base-commit: d5ce93f136fbee2b7afbe221f34ca881036f8de3

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


