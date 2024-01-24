Return-Path: <linux-wireless+bounces-2434-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2D583A03F
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jan 2024 04:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC3E9288F2F
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jan 2024 03:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C25833E1;
	Wed, 24 Jan 2024 03:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AR6h7f/I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A696EC131
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jan 2024 03:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706067936; cv=none; b=MInqLZQVK35WOcH2ldLMjjucfqWIGfLj+yMfYc2qdL9MLvxsL7DGp17SAheq7xyMSUwPZYOYwYR7GbYIUeMB/F7yw0ZePtOoKECFEq9uuwyuwGFnlbIc7bFFnlNm37gwe3Sm16w0xYUXcGps8ESE5OWbX/neCSzEYMZxSB73orw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706067936; c=relaxed/simple;
	bh=fNHotKgPZTVI6erNs8A9f6V6O5cayrWs+CoP121hb/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=l6mG/mnsOZ9KYjszc2S9Y+ekZczUiCITcrxJrWpkTjAysA2AX4hR+ZKBhFFJ0z5+mCwEjgvG0Sk2kPd1m1UyZTQOV/6bsX+rLAwKT+WhH2GevI3nM98OtpGphTYSAtIU/HLN4Zsi9bQhu8/SvRd03QV3HEO8zb3aRfmcdU81uMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AR6h7f/I; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40O0QgW6004784;
	Wed, 24 Jan 2024 03:45:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=WWKAAAAnPBkUkjsDmJiYhB4Dnqgfzv0jg+MiFihpv6c=; b=AR
	6h7f/IYu4I8WFyxiJGG7FKUhGvO4BjtDOpNz8pPTTvCctu4+7OS7/iYPgorHWvxR
	S+CeB/gIe4IM6bld5xdlOPYnGvh0EIan7h/PlZdGlggJ+4fwskNI63RNyIO6LwWt
	aMApi5Yb9PIZinyUIqT5ecJrYhc2Q5JYvjGORhEqDgsLzOsL5zdNzwH0Xz/fx+VL
	4/nZ+XSR9Jg9KxXY9bd0kayn5ea3S3xBH/cnvS6KLX6yfxdFdN/znWyYAyaI1ZUo
	bcFfYRuyKCP32cmWMrTf112AcY7n0mKkTyWZBTkHSHU72RR0tWlKE5cbBjlXhFRa
	c4IMI//kUE+dUeK/NxoQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vtmgxgp3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 03:45:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40O3jJpo006470
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 03:45:19 GMT
Received: from [10.110.18.75] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 23 Jan
 2024 19:45:19 -0800
Message-ID: <42fbabd5-d77d-430b-b2c1-e4e829fa0776@quicinc.com>
Date: Tue, 23 Jan 2024 19:45:18 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/15] wifi: iwlwifi: disable 160Mhz based on SSID
Content-Language: en-US
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Mukesh Sisodiya
	<mukesh.sisodiya@intel.com>,
        Mordechay Goodstein
	<mordechay.goodstein@intel.com>
References: <20240123180823.2441162-1-miriam.rachel.korenblit@intel.com>
 <20240123200528.776b395ee915.I558e8d0cf19dc862b1c4124df78a4cb690095bb2@changeid>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240123200528.776b395ee915.I558e8d0cf19dc862b1c4124df78a4cb690095bb2@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JC8c5rSnul8jJnuC3tedAd1zFu3nwpgk
X-Proofpoint-GUID: JC8c5rSnul8jJnuC3tedAd1zFu3nwpgk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_15,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401240026

On 1/23/2024 10:08 AM, Miri Korenblit wrote:
> From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
> 
> The driver should not send 160Mhz BW support for 5Ghz

s/Mhz/MHz/?
s/Ghz/GHz/?

> band in HE if PCI Subsystem read indicates no 160Mhz support.
> 
> Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
> Reviewed-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
> Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
> ---
>  drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 4 ++++
>  drivers/net/wireless/intel/iwlwifi/iwl-trans.h     | 3 ++-
>  drivers/net/wireless/intel/iwlwifi/pcie/drv.c      | 1 +
>  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
> index 3f62f10a7c37..67c7cda073e8 100644
> --- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
> +++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
> @@ -1061,6 +1061,10 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
>  			~IEEE80211_HE_PHY_CAP7_STBC_RX_ABOVE_80MHZ;
>  	}
>  
> +	if (trans->no_160)
> +		iftype_data->he_cap.he_cap_elem.phy_cap_info[0] &=
> +			~IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
> +
>  	if (trans->reduced_cap_sku) {
>  		memset(&iftype_data->eht_cap.eht_mcs_nss_supp.bw._320, 0,
>  		       sizeof(iftype_data->eht_cap.eht_mcs_nss_supp.bw._320));
> diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
> index 9e26c9eb6d83..9867e29a56ff 100644
> --- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
> +++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
> @@ -1069,6 +1069,7 @@ struct iwl_trans_txqs {
>   *	only valid for discrete (not integrated) NICs
>   * @invalid_tx_cmd: invalid TX command buffer
>   * @reduced_cap_sku: reduced capability supported SKU
> + * @no_160: device not supporting 160Mhz

MHz?

>   */
>  struct iwl_trans {
>  	bool csme_own;
> @@ -1092,7 +1093,7 @@ struct iwl_trans {
>  	char hw_id_str[52];
>  	u32 sku_id[3];
>  	bool reduced_cap_sku;
> -
> +	u8 no_160;
>  	u8 rx_mpdu_cmd, rx_mpdu_cmd_hdr_size;
>  
>  	bool pm_support;
> diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
> index 42680d8469f5..c80b02503b41 100644
> --- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
> +++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
> @@ -1394,6 +1394,7 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	if (dev_info) {
>  		iwl_trans->cfg = dev_info->cfg;
>  		iwl_trans->name = dev_info->name;
> +		iwl_trans->no_160 = dev_info->no_160 == IWL_CFG_NO_160;
>  	}
>  
>  #if IS_ENABLED(CONFIG_IWLMVM)


