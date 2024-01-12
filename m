Return-Path: <linux-wireless+bounces-1835-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D454782C4A3
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 18:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 865621F24C74
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 17:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE322261E;
	Fri, 12 Jan 2024 17:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Zj3riIqV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BA422620
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 17:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40CFRUrw002077;
	Fri, 12 Jan 2024 17:24:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=9wAIbQZ/OE9RX7AchYjlMnl8kxaKodRBO+ZNSGanaqA=; b=Zj
	3riIqV0WAkyRO4XFwe6fW5kdOlG4C2xZgoCMA7y4rPQmE8QxJK/tHynkeBoPRe9/
	/2BRa3D+gWCBdTlApKZWP+8n/eYkrwBFiF+/D/AcdFoy6fugCSCNjU6G0MxdJ+KV
	Ms1pD8jsrtu7T6v6KerRM/z0Adsflff6aFPoZ4lvFpEOEQs3AkH75bE9rC0O4v4s
	8gjvp+B5krPmfxLZoYLReaFxp8yEAitgrO+XfEnoCrrUvOzNS2oFMMIRQcwzkSuL
	U7bo+sIAVIwhA9T/6aAn+08y2KeoPV6euec1v/HGnrN07F60U2OwFC6awfoYWQ8K
	E0WQGuPXXi/5Sg9yN27Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vk18d1crv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 17:24:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40CHO0GA008909
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 17:24:01 GMT
Received: from [10.110.16.29] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 12 Jan
 2024 09:24:00 -0800
Message-ID: <c35da30b-335c-4418-9d7c-0784ec9e8d30@quicinc.com>
Date: Fri, 12 Jan 2024 09:23:59 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/12] wifi: ath12k: Cache vdev configs before vdev create
Content-Language: en-US
To: Sriram R <quic_srirrama@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240111045045.28377-1-quic_srirrama@quicinc.com>
 <20240111045045.28377-8-quic_srirrama@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240111045045.28377-8-quic_srirrama@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: y1ESbIqP0ukk0ytPZw8tYbPG_N7LJhBY
X-Proofpoint-ORIG-GUID: y1ESbIqP0ukk0ytPZw8tYbPG_N7LJhBY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 mlxlogscore=701
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401120137

On 1/10/2024 8:50 PM, Sriram R wrote:
> Since the vdev create for a corresponding vif is deferred
> until a channel is assigned, cache the information which
> are received through mac80211 ops between add_interface()
> and assign_vif_chanctx() and set them once the vdev is
> created on one of the ath12k radios as the channel gets
> assigned via assign_vif_chanctx().
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> ---
...
> +static int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
> +				 struct ieee80211_vif *vif, struct ieee80211_sta *sta,
> +				 struct ieee80211_key_conf *key)
> +{
> +	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
> +	struct ath12k *ar;
> +	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
> +	int ret;
> +
> +	/* BIP needs to be done in software */
> +	if (key->cipher == WLAN_CIPHER_SUITE_AES_CMAC ||
> +	    key->cipher == WLAN_CIPHER_SUITE_BIP_GMAC_128 ||
> +	    key->cipher == WLAN_CIPHER_SUITE_BIP_GMAC_256 ||
> +	    key->cipher == WLAN_CIPHER_SUITE_BIP_CMAC_256)
> +		return 1;

I know this in the existing code, but what is the significance of
returning 1? Should this be returning a -errno like the error cases that
follow?

> +
> +	if (key->keyidx > WMI_MAX_KEY_INDEX)
> +		return -ENOSPC;
> +
> +	mutex_lock(&ah->conf_mutex);
> +
> +	ar = ath12k_get_ar_by_vif(hw, vif);
> +	if (!ar) {
> +		/* ar is expected to be valid when sta ptr is available */
> +		if (sta) {
> +			mutex_unlock(&ah->conf_mutex);
> +			WARN_ON_ONCE(1);
> +			return -EINVAL;
> +		}
> +		arvif->cache.key_conf.cmd = cmd;
> +		arvif->cache.key_conf.key = key;
> +		arvif->cache.key_conf.changed = true;
> +		mutex_unlock(&ah->conf_mutex);
> +		return 0;
> +	}
> +
> +	mutex_lock(&ar->conf_mutex);
> +	ret = ath12k_mac_set_key(ar, cmd, vif, sta, key);
>  	mutex_unlock(&ar->conf_mutex);
> +
>  	mutex_unlock(&ah->conf_mutex);
>  	return ret;
>  }


