Return-Path: <linux-wireless+bounces-19101-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2C5A3A058
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Feb 2025 15:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54EE81884BDF
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Feb 2025 14:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0902A24113C;
	Tue, 18 Feb 2025 14:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mEJ+RA7u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CA0269CF4
	for <linux-wireless@vger.kernel.org>; Tue, 18 Feb 2025 14:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739889798; cv=none; b=INKL9+a7IHgRt2W/bczchfFQZiyzeVx9YhZLDQHix2zxuNiWdutnV3XaFbs4wJ5crM6Jrqjo5eLUEnBQlatHn0DSkW7Yl9Mc9/lcOV1FgV9dekYUTs//3cdRz5AOWDz9mRFu2enjrulL4gPxU53iT3j9ov+TJi94cwtBK9HQ51E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739889798; c=relaxed/simple;
	bh=ZUN1DnMg6Y4UZHOiZONj4Og+MbLZS7wRcv4TLzm/+cs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WqLO5QF4oZhiJC58kf2HPFaM4a7joIe+kGsn0tzvC1NGZG9WV1rsyAaDeeKT5qXYYLRDGgNSRCCnMplatiDUVOaEed6dZ97Syx6jtxfaiAkPHAr7Ri/9hM3etgmKoeqUGRyE4rD8ys8xyhW2GVz/xZ6Znx7w6sPaSI84Ny39o+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mEJ+RA7u; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ICHaMN017072
	for <linux-wireless@vger.kernel.org>; Tue, 18 Feb 2025 14:43:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wc4bBPikx8M1D/qS6gPzUHEJ3hRfPJf5/zbuzn2mR0Q=; b=mEJ+RA7uyXgSiG+5
	7UHuyBc5VPSy00xDnyvbk/A9mBp9IWPhzl35fyV3uyX49V4p7u5+w0pqan9qqS+j
	xrQf8bL+pQHlVAGsbEPl2auQFs7XKdv47L002tuc4gceCdasAZpE4q2KYhgQEmYr
	O4W9ebRBuDGUf9m6ZfmAdlR8pAvfdehjk5Ep7rU1wZn32Zf3oX53FuxqZK3VFJgx
	ofZNg99fJpR20lOsA7noTsJCa9JSQpYHidU+m5g0foYzsZ5EkOPrB/dk/aewOjxK
	+vuxUCe0VmsJSCniWmWHGQCncNgheXEMoO5NeZhABdKc5yK3v+d6Lk26zWOYnKZ2
	1/+Aug==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ut7uw43y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 18 Feb 2025 14:43:15 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fc518f0564so5641415a91.2
        for <linux-wireless@vger.kernel.org>; Tue, 18 Feb 2025 06:43:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739889794; x=1740494594;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wc4bBPikx8M1D/qS6gPzUHEJ3hRfPJf5/zbuzn2mR0Q=;
        b=iMynC/fRmyJozT1hapRa0cb9TaAmnUC+ypUBrNnF4GJ07ZWeF9CJ7zurymMZJ3WNHl
         Y9ZnBymRmGg7mA2ng6GbingO57BcjufZ+HHQOq2KvXjE8KZ5FplIzdIC+cfJd/2d8m5/
         mwx5VreaoNSuqyE7qlLjAoloHER3/vNyWD7QjTVkVwKa6kAm6u7kXyN8+SFrLXXXH+fo
         z9GoDacSqEEbNBVCaF1PWwQxFLfOS7+dViXpLnEdQm8+CV0a3zHINpx1JVTfhxtlvMC/
         RXYm/uHeiWG5EIkPBFBKwI68yrZSs7T3mCN1Vg4dW4Me5AhHfnirld8h/JblI8iqSubd
         jSWg==
X-Gm-Message-State: AOJu0YxtobBk5rVIKxW6irscK3PzLAh0IUl2BexIFu28IGpzNKcXLmod
	ZmXRympihwAQp8sxSPXsvpd/1qouAfL7KuVqWIf6nEr9YYTzMrY1L7GGt3Jgj4h3gQbLgd/9RvG
	wnEvFstX8tnjDCNFpRdp+V37yPVoan2dX8RwsG0exIHQw6VSvugQ/4J/AO1vcM71EMng71xWJpA
	==
X-Gm-Gg: ASbGncsnNHZbBCLdryJUIu0/KscbqjlEZ+sWrBZaxj3CMTk3yVi/TMST0+XjqaOjkau
	FNKAkELBPaEcGp57ya3+vJxMLZ6e+419JlL8PnwWg4SenMBDe0l9DPn/UfYSUybkwk5bWWoa46h
	HJx1opoYnOFBHw7qy6SmvskwpaejGUrKPPueSCCPND6Lw1WCnxpsesuaeczmj1ooWdKVBDXBcnT
	zoaN5uGOhDvAzk9DpITwjrYEkiSJBcpvR0cguFxNrhSYjsMANX437PqVk0cxgiZR63HrKv8qQLc
	vhMyMTbgST2glslKnVH2j8WTfzEGhgDd3mjLvvbpAA==
X-Received: by 2002:a05:6a00:4f95:b0:730:794e:7aca with SMTP id d2e1a72fcca58-732618c1c26mr23605629b3a.16.1739889793937;
        Tue, 18 Feb 2025 06:43:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6JW86niQkX8/a40QxX7mpOHyFCN1rRgNkhk2f/HbmgOidCwc/CPTiYzifP7Qw3SmAvLGgMw==
X-Received: by 2002:a05:6a00:4f95:b0:730:794e:7aca with SMTP id d2e1a72fcca58-732618c1c26mr23605565b3a.16.1739889793360;
        Tue, 18 Feb 2025 06:43:13 -0800 (PST)
Received: from [192.168.29.221] ([49.37.208.137])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73249fe96b4sm9345326b3a.75.2025.02.18.06.43.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 06:43:12 -0800 (PST)
Message-ID: <73645538-06c2-48b7-a95d-9e47b06674b0@oss.qualcomm.com>
Date: Tue, 18 Feb 2025 20:13:09 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V10 1/9] wifi: ath12k: push HE MU-MIMO params to hardware
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Muna Sinada <quic_msinada@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
References: <20250213012439.278373-1-quic_pradeepc@quicinc.com>
 <20250213012439.278373-2-quic_pradeepc@quicinc.com>
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250213012439.278373-2-quic_pradeepc@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: HVlMUt4JDrAzullKBm_wMYFl6zB7x2Hf
X-Proofpoint-ORIG-GUID: HVlMUt4JDrAzullKBm_wMYFl6zB7x2Hf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_07,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 mlxscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502180109

> @@ -3219,6 +3219,126 @@ static int ath12k_setup_peer_smps(struct ath12k *ar, struct ath12k_link_vif *arv
>   					 ath12k_smps_map[smps]);
>   }
>   
> +static int ath12k_mac_set_he_txbf_conf(struct ath12k_link_vif *arvif)
> +{
> +	struct ath12k_vif *ahvif = arvif->ahvif;
> +	struct ath12k *ar = arvif->ar;
> +	u32 param = WMI_VDEV_PARAM_SET_HEMU_MODE;
> +	u32 value = 0;
> +	int ret;
> +	struct ieee80211_bss_conf *link_conf;
> +
> +	link_conf = ath12k_mac_get_link_bss_conf(arvif);
> +	if (!link_conf) {
> +		ath12k_warn(ar->ab, "unable to access bss link conf in txbf conf\n");
> +		return false;

Return some err value like -EINVAL? Please check the return type - int 
vs bool.

> +	}
> +
> +	if (!link_conf->he_support)
> +		return true;

FWIW, this should return 0? Since if HE is not enabled, then nothing to 
do, so caller should get success only? Or else in legacy case the 
failure print will uncessarily come.

> +
> +	if (link_conf->he_su_beamformer) {
> +		value |= u32_encode_bits(HE_SU_BFER_ENABLE, HE_MODE_SU_TX_BFER);
> +		if (link_conf->he_mu_beamformer &&
> +		    ahvif->vdev_type == WMI_VDEV_TYPE_AP)
> +			value |= u32_encode_bits(HE_MU_BFER_ENABLE, HE_MODE_MU_TX_BFER);
> +	}
> +
> +	if (ahvif->vif->type != NL80211_IFTYPE_MESH_POINT) {
> +		value |= u32_encode_bits(HE_DL_MUOFDMA_ENABLE, HE_MODE_DL_OFDMA) |
> +			 u32_encode_bits(HE_UL_MUOFDMA_ENABLE, HE_MODE_UL_OFDMA);
> +
> +		if (link_conf->he_full_ul_mumimo)
> +			value |= u32_encode_bits(HE_UL_MUMIMO_ENABLE, HE_MODE_UL_MUMIMO);
> +
> +		if (link_conf->he_su_beamformee)
> +			value |= u32_encode_bits(HE_SU_BFEE_ENABLE, HE_MODE_SU_TX_BFEE);
> +	}
> +
> +	ret = ath12k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id, param, value);
> +	if (ret) {
> +		ath12k_warn(ar->ab, "failed to set vdev %d HE MU mode: %d\n",
> +			    arvif->vdev_id, ret);
> +		return ret;
> +	}
> +
> +	param = WMI_VDEV_PARAM_SET_HE_SOUNDING_MODE;
> +	value =	u32_encode_bits(HE_VHT_SOUNDING_MODE_ENABLE, HE_VHT_SOUNDING_MODE) |
> +		u32_encode_bits(HE_TRIG_NONTRIG_SOUNDING_MODE_ENABLE,
> +				HE_TRIG_NONTRIG_SOUNDING_MODE);
> +	ret = ath12k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
> +					    param, value);
> +	if (ret) {
> +		ath12k_warn(ar->ab, "failed to set vdev %d sounding mode: %d\n",
> +			    arvif->vdev_id, ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ath12k_mac_vif_recalc_sta_he_txbf(struct ath12k *ar,
> +					     struct ath12k_link_vif *arvif,
> +					     struct ieee80211_sta_he_cap *he_cap,
> +					     int *hemode)
> +{
> +	struct ieee80211_vif *vif = arvif->ahvif->vif;
> +	struct ieee80211_he_cap_elem he_cap_elem = {};
> +	struct ieee80211_sta_he_cap *cap_band;
> +	struct cfg80211_chan_def def;
> +	u8 link_id = arvif->link_id;
> +	struct ieee80211_bss_conf *link_conf;
> +
> +	link_conf = ath12k_mac_get_link_bss_conf(arvif);
> +
> +	if (!link_conf) {
> +		ath12k_warn(ar->ab, "unable to access bss link conf in recalc txbf conf\n");
> +		return 0;

Is it still safe to return to caller succes (0) when link conf does not 
exist ?

> +	}
> +
> +	if (!link_conf->he_support)
> +		return 0;
> +
> +	if (vif->type != NL80211_IFTYPE_STATION)
> +		return -EINVAL;
> +
> +	if (WARN_ON(ath12k_mac_vif_link_chan(vif, link_id, &def)))
> +		return -EINVAL;
> +
> +	if (def.chan->band == NL80211_BAND_2GHZ)
> +		cap_band = &ar->mac.iftype[NL80211_BAND_2GHZ][vif->type].he_cap;
> +	else
> +		cap_band = &ar->mac.iftype[NL80211_BAND_5GHZ][vif->type].he_cap;
> +
> +	memcpy(&he_cap_elem, &cap_band->he_cap_elem, sizeof(he_cap_elem));
> +
> +	*hemode = 0;
> +	if (HECAP_PHY_SUBFME_GET(he_cap_elem.phy_cap_info)) {
> +		if (HECAP_PHY_SUBFMR_GET(he_cap->he_cap_elem.phy_cap_info))
> +			*hemode |= u32_encode_bits(HE_SU_BFEE_ENABLE, HE_MODE_SU_TX_BFEE);
> +		if (HECAP_PHY_MUBFMR_GET(he_cap->he_cap_elem.phy_cap_info))
> +			*hemode |= u32_encode_bits(HE_MU_BFEE_ENABLE, HE_MODE_MU_TX_BFEE);
> +	}
> +
> +	if (vif->type != NL80211_IFTYPE_MESH_POINT) {
> +		*hemode |= u32_encode_bits(HE_DL_MUOFDMA_ENABLE, HE_MODE_DL_OFDMA) |
> +			  u32_encode_bits(HE_UL_MUOFDMA_ENABLE, HE_MODE_UL_OFDMA);
> +
> +		if (HECAP_PHY_ULMUMIMO_GET(he_cap_elem.phy_cap_info))
> +			if (HECAP_PHY_ULMUMIMO_GET(he_cap->he_cap_elem.phy_cap_info))
> +				*hemode |= u32_encode_bits(HE_UL_MUMIMO_ENABLE,
> +							  HE_MODE_UL_MUMIMO);
> +
> +		if (u32_get_bits(*hemode, HE_MODE_MU_TX_BFEE))
> +			*hemode |= u32_encode_bits(HE_SU_BFEE_ENABLE, HE_MODE_SU_TX_BFEE);
> +
> +		if (u32_get_bits(*hemode, HE_MODE_MU_TX_BFER))
> +			*hemode |= u32_encode_bits(HE_SU_BFER_ENABLE, HE_MODE_SU_TX_BFER);
> +	}
> +
> +	return 0;
> +}
> +
>   static u32 ath12k_mac_ieee80211_sta_bw_to_wmi(struct ath12k *ar,
>   					      struct ieee80211_link_sta *link_sta)
>   {
> @@ -3264,6 +3384,7 @@ static void ath12k_bss_assoc(struct ath12k *ar,
>   	struct ath12k_sta *ahsta;
>   	struct ath12k_peer *peer;
>   	bool is_auth = false;
> +	u32 hemode = 0;
>   	int ret;
>   
>   	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
> @@ -3307,8 +3428,26 @@ static void ath12k_bss_assoc(struct ath12k *ar,
>   
>   	ath12k_peer_assoc_prepare(ar, arvif, arsta, peer_arg, false);
>   
> +	/* link_sta->he_cap must be protected by rcu_read_lock */
> +	ret = ath12k_mac_vif_recalc_sta_he_txbf(ar, arvif, &link_sta->he_cap, &hemode);
> +	if (ret) {
> +		ath12k_warn(ar->ab, "failed to recalc he txbf for vdev %i on bss %pM: %d\n",
> +			    arvif->vdev_id, bss_conf->bssid, ret);
> +		rcu_read_unlock();
> +		return;
> +	}
> +
>   	rcu_read_unlock();
>   
> +	/* keep this before ath12k_wmi_send_peer_assoc_cmd() */
> +	ret = ath12k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
> +					    WMI_VDEV_PARAM_SET_HEMU_MODE, hemode);
> +	if (ret) {
> +		ath12k_warn(ar->ab, "failed to submit vdev param txbf 0x%x: %d\n",
> +			    hemode, ret);
> +		return;
> +	}
> +
>   	ret = ath12k_wmi_send_peer_assoc_cmd(ar, peer_arg);
>   	if (ret) {
>   		ath12k_warn(ar->ab, "failed to run peer assoc for %pM vdev %i: %d\n",
> @@ -3873,6 +4012,13 @@ static void ath12k_mac_bss_info_changed(struct ath12k *ar,
>   		ether_addr_copy(arvif->bssid, info->bssid);
>   
>   	if (changed & BSS_CHANGED_BEACON_ENABLED) {
> +		if (info->enable_beacon) {
> +			ret = ath12k_mac_set_he_txbf_conf(arvif);
> +			if (ret)
> +				ath12k_warn(ar->ab,
> +					    "failed to set HE TXBF config for vdev: %d\n",
> +					    arvif->vdev_id

So when you bring up AP in non-HE mode i.e HT/VHT and all, this print 
will appear which will be misleading.

-- 
Aditya

