Return-Path: <linux-wireless+bounces-27413-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 564AFB7F3AF
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 15:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89309582A98
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 02:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53856223DFB;
	Wed, 17 Sep 2025 02:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CHCW0yG5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1A221B19D
	for <linux-wireless@vger.kernel.org>; Wed, 17 Sep 2025 02:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758075253; cv=none; b=OAOavQf1dBQPDJnIZ38I9Wigj9env9Z9xvquSEKlaHMucYhL6nxMSlFB2snV3qPC6ceWn1ahxRsAN1dI/299fFWoUFexCYnmeMJvULcoYhSR4QBx3HhE18OspCSh1AQrCZU35cQ2w0IfJRhsJSnlU6cKJNT06N46tUJNlwn5cPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758075253; c=relaxed/simple;
	bh=PylWe/OBT121LhrGr8DsX5yf/UcQvy7TNV1odNafpJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fy4RmBrZJ3De+wOWDTN6IoxHyH+r3ztJf01FDUZBf/iOSIWIEiQNSIo4dNCDmYwb88g4jQi+DsrsakeOiV0YyaDv+RqYSlYe4MKdtVTsNT+nt8ssiTfXFawBkxKMy3MLA1jx7rG1ZvXCnTSztIFnIQKKgKb8mdDU87+BAQuYHds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CHCW0yG5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GLZtje025162
	for <linux-wireless@vger.kernel.org>; Wed, 17 Sep 2025 02:14:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y6PXnaCKircHqE0zpOy6rcGb6NhFU+uxlmOaqFcHnIY=; b=CHCW0yG5L+UF9wRy
	89NolCtVZ/UIsL/kDLS6n8VXr2C4s/gNn8MjVQo6Aw7Aiuse6PMmSbks9/8ABzg1
	tE0Ur0dw1ZkFEMJQH0u7/7wtVNVGdCc7J9+9w+JbZYFheqH40DpiCHYHJpwObwot
	Vqmq+wzEV/0XjPpa/+mGlvID5n9j20TEFHrdB3uMigztMiekZloiSrG+uphfw7cW
	iI04I2TQPfeKjLcazjRTYIF+d+MvJfpsADzAw9mzw8bw+0EHiB9utzkL6gJDAbAu
	fvL4XkMWmh5xBNGomDSumbwfsN0Y7EgOeOh83TEYmd39QSfiN/l6Kwf7Urk3MrIv
	Bkki9g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxwgj4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 17 Sep 2025 02:14:10 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-25177b75e38so72330525ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 19:14:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758075249; x=1758680049;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y6PXnaCKircHqE0zpOy6rcGb6NhFU+uxlmOaqFcHnIY=;
        b=D6224kgBQmrMfTPiWsr042wezVac1s6C85qqVhFqT/y4bCALQ8bDg7S4RvPeqAThKU
         c5perL+LvEsjRj4E5v2Lb29LJ34+lDsIpCMWLY6cw0r7ONr/UTBQjQ0yl6Ny/fNJAlp7
         ui7SzLTb4nAlk2LZWa9ll6Vr0CooOrRySXJJYLO9/aYihgTTdjiSYPZYLa9jenSjY+iO
         4MVo4/PivgUggC2VETGAJPSE2A0GxsSjVC5wRRQtc6ThHLSCBdo3oWEWEuG8+xS9FGPk
         CmyBdohAsFasyLYsW6f/8bVqmDn0FB2AfD2N/QC8isX6UaU4tsMfjVjQP944bqNnmTzK
         jPMQ==
X-Gm-Message-State: AOJu0YwjyDHvwjhEPeVfn0IQHg/aIoZ9Wzaov6R5m/Fyh/nd52jIA69d
	818+B5agrGROLSMV60Qk6yJPQnLvSUQ1ohvT6F9nFXQd1S+K7J13Md8c5tLwpJN2LmBeGRObQnZ
	22c0wtEUtL34Hxn9j/avLDu7Kq2rN34my6REuki55qmigcg/gJ5Iz50kfNZhIT6tpSv8zCyXVwI
	5K3w==
X-Gm-Gg: ASbGncveD858q8BTUkR7HvMt/7OciD0VwQLRrX/zZzZuur8h0AMNO6f6nfNtRCd1C/2
	hdAnSz+kxAaS0gFITXEOA57aqkElfVqPyrmK3gHWdLmOOcFG65lWm5rDx1AxMhNZZ+acSt59I3d
	FkULdzHUVqzIcI+IuJ2Njas+oV5/uodEDiJF0jlju999AUiUBMdoHFbN3PeZc8r0/KeSIeEGyx/
	7IHehx/OEULTktEdp03XwSC3dshAcUzQIorUdlALvda6gvihoUvIqgyHQ8JCIK6/CkgtqxoYDJv
	hNngYHTQAJteznlBhBpKiK3+SoxIihRhV7/RHA5EPAt9QL0xcYIa3wH/HxmnlQD2ZhArj8f863Y
	TfZ6M6wnTlGN0WifQbImggqu/rdfNTkudvVzRjw==
X-Received: by 2002:a17:903:174e:b0:262:79a:9405 with SMTP id d9443c01a7336-268118b93e8mr4650475ad.3.1758075248671;
        Tue, 16 Sep 2025 19:14:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFv/sCoZBfDtNsTK8AEI0QIhh1SGDUDrsrq4iG0nzF6cZu5QWu9IpxONwtvoKsCch7JgstOPg==
X-Received: by 2002:a17:903:174e:b0:262:79a:9405 with SMTP id d9443c01a7336-268118b93e8mr4650245ad.3.1758075248175;
        Tue, 16 Sep 2025 19:14:08 -0700 (PDT)
Received: from [10.133.33.224] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2638eb9e75bsm96412485ad.3.2025.09.16.19.14.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 19:14:07 -0700 (PDT)
Message-ID: <97ed8dfb-9abe-45e1-9545-ffafd8f98ffc@oss.qualcomm.com>
Date: Wed, 17 Sep 2025 10:14:02 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: Add support to set per-radio RTS
 threshold
To: Roopni Devanathan <quic_rdevanat@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250826105714.1188131-1-quic_rdevanat@quicinc.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250826105714.1188131-1-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=do/bC0g4 c=1 sm=1 tr=0 ts=68ca1972 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=VItAEOD5pU9O0TDtwIoA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: kcwlRiksHza1xmMNqIBYSszn3UsG3dCH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXy3NUwTazkiX+
 g96ICj9XbCaCfXsaU73xFQbxAtj0uCZTRY02Cs3coAgaC20FxscmzLN+cgksFUl7h1rA1mIXQDh
 kVhUli5R/A4W1zCcABmRyvN/BcyY103zUKrNWefWvaVEXXVIixD8RKf3eKtCiHtMmCiQR4z9r81
 0UxbgXGK9MxoeHDEiS6FrbaQZ68GVwEbsNCeNobOdNnRg4ELbyJ+oCU3AyyoyohWGTZje5jorU3
 yI747Rp12Zr7dTYaqgHTh+Onv2BEcK4dv+DdvrzROdOgFgMUKTvNLZZpSgaiOuHSj9vP9qKgX5P
 EPwB4eY/escstqKJWwCGUhrEl0Un7LwukF/aHXivCGQcuXbzqQQ2CoiILXmxynzSR3FInh7XeQe
 Vy8olp+o
X-Proofpoint-ORIG-GUID: kcwlRiksHza1xmMNqIBYSszn3UsG3dCH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-16_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=0 phishscore=0 priorityscore=1501
 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202



On 8/26/2025 6:57 PM, Roopni Devanathan wrote:
> Currently, command to set RTS threshold makes changes to the threshold of
> all radios in the multi-radio wiphy. But each radio in a multi-radio wiphy
> can have different RTS threshold requirements.
> 
> To support this requirement, use the index of radio for which the RTS
> threshold needs to be changed from mac80211 - radio_idx. Based on the value
> passed, set the RTS threshold value for the corresponding radios. Following
> are the possible values of radio_idx and the corresponding behavior in
> multi-radio wiphys:
>  1. radio_idx is -1: consider RTS threshold as a global parameter, i.e.,
>     make changes to all the radios in a wiphy. If setting RTS threshold
>     fails for any radio, then the previous RTS threshold values of
>     respective radios will be restored.
>  2. radio_idx denotes a specific radio: make changes in RTS threshold to
>     that radio alone.
>  3. radio_idx is any other number: report it as an invalid number.
> 
> In case of single-radio wiphys, continue with the existing behavior, i.e.,
> set the passed RTS threshold value to the radio present.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/core.h |  3 +-
>  drivers/net/wireless/ath/ath12k/mac.c  | 50 ++++++++++++++++++++++----
>  2 files changed, 45 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index 519f826f56c8..da7e99f2ca0b 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -1,7 +1,7 @@
>  /* SPDX-License-Identifier: BSD-3-Clause-Clear */
>  /*
>   * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
> - * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>   */
>  
>  #ifndef ATH12K_CORE_H
> @@ -730,6 +730,7 @@ struct ath12k {
>  	u32 txpower_scale;
>  	u32 power_scale;
>  	u32 chan_tx_pwr;
> +	u32 rts_threshold;
>  	u32 num_stations;
>  	u32 max_num_stations;
>  
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index bd1ec3b2c084..c0e0423464e3 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: BSD-3-Clause-Clear
>  /*
>   * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
> - * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>   */
>  
>  #include <net/mac80211.h>
> @@ -9848,6 +9848,7 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
>  
>  	param_id = WMI_VDEV_PARAM_RTS_THRESHOLD;
>  	param_value = hw->wiphy->rts_threshold;
> +	ar->rts_threshold = param_value;
>  	ret = ath12k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
>  					    param_id, param_value);
>  	if (ret) {
> @@ -11675,16 +11676,32 @@ static int ath12k_mac_op_set_rts_threshold(struct ieee80211_hw *hw,
>  					   int radio_idx, u32 value)
>  {
>  	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
> +	struct wiphy *wiphy = hw->wiphy;
>  	struct ath12k *ar;
> -	int param_id = WMI_VDEV_PARAM_RTS_THRESHOLD, ret = 0, i;
> +	int param_id = WMI_VDEV_PARAM_RTS_THRESHOLD;
> +	int ret = 0, ret_err, i;
>  
>  	lockdep_assert_wiphy(hw->wiphy);
>  
> -	/* Currently we set the rts threshold value to all the vifs across
> -	 * all radios of the single wiphy.
> -	 * TODO Once support for vif specific RTS threshold in mac80211 is
> -	 * available, ath12k can make use of it.
> -	 */
> +	if (radio_idx >= wiphy->n_radio || radio_idx < -1)
> +		return -EINVAL;
> +
> +	if (radio_idx != -1) {
> +		/* Update RTS threshold in specified radio */
> +		ar = ath12k_ah_to_ar(ah, radio_idx);
> +		ret = ath12k_set_vdev_param_to_all_vifs(ar, param_id, value);
> +		if (ret) {
> +			ath12k_warn(ar->ab,
> +				    "failed to set RTS config for all vdevs of pdev %d",
> +				    ar->pdev->pdev_id);
> +			return ret;
> +		}
> +
> +		ar->rts_threshold = value;
> +		return 0;
> +	}
> +
> +	/* Radio_index passed is -1, so set RTS threshold for all radios. */
>  	for_each_ar(ah, ar, i) {
>  		ret = ath12k_set_vdev_param_to_all_vifs(ar, param_id, value);
>  		if (ret) {
> @@ -11693,6 +11710,25 @@ static int ath12k_mac_op_set_rts_threshold(struct ieee80211_hw *hw,
>  			break;
>  		}
>  	}
> +	if (!ret) {
> +		/* Setting new RTS threshold for vdevs of all radios passed, so update
> +		 * the RTS threshold value for all radios
> +		 */
> +		for_each_ar(ah, ar, i)
> +			ar->rts_threshold = value;
> +		return 0;
> +	}
> +
> +	/* RTS threshold config failed, revert to the previous RTS threshold */
> +	for (i = i - 1; i >= 0; i--) {
> +		ar = ath12k_ah_to_ar(ah, i);
> +		ret_err = ath12k_set_vdev_param_to_all_vifs(ar, param_id,
> +							    ar->rts_threshold);
> +		if (ret_err)
> +			ath12k_warn(ar->ab,
> +				    "failed to restore RTS threshold for all vdevs of pdev %d",
> +				    ar->pdev->pdev_id);
> +	}
>  
>  	return ret;
>  }
> 
> base-commit: 95bf875b89b48a95a82aca922eeaf19d52543028

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>



