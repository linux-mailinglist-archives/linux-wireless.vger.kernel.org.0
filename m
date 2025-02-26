Return-Path: <linux-wireless+bounces-19450-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE12A452ED
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 03:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF0D217D49B
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 02:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD07216608;
	Wed, 26 Feb 2025 02:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="X8dCMW0B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4154B216E2C
	for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 02:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740536062; cv=none; b=TmHArsnQ0+4keoOcTk698qKutJKLsFLroBM6ghXBUOT5KVhuZfPS+HcaSo3W9UfoBfu50NIE1EjU4q7fVNd0CPWEDNoxLk1LqC2z2iNr/zfeygsUJamKTeS4YJXoHJCfcU6GLOxFpy0xGMQcMuP2F3v2rm8NgHjgXC/4kQYPzvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740536062; c=relaxed/simple;
	bh=GJioxgxoyUsEc/dsMF4HKC+98LZ7pTOCyA6049ek1vk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aNHwqn+5zefZlDRhgRA6Xu6eAvALP6qscph5NIzWc7zF+wvFCzt0injPpA79eeegBRKK4GehZWUr28UQtBarC+by0qiu3kMHMwp7hZb67hdoXT5w7j0Saaiua+OMZWtFqzGPe2pwKPkNAuuBZWNFbQqUIrdGjxyq3DknnXP0blw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=X8dCMW0B; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PMWqw1003400;
	Wed, 26 Feb 2025 02:14:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q9LCoylmiWyMJhxPlj3SH3dhjCGfftsUvLtDv1uVGN4=; b=X8dCMW0BcUUX2CID
	G1v4ETd53zTtAJRB2k4fM/DKw83eeFtNvA0Qr8Rqx8aS8VozgIsWZQoqyxCevmi8
	B/cjfqzne9966j4HFyfDJnZO6RuN4b73j1B9kylMiz5UqyJSs4WsgqUGbt+x7YHK
	zwJw3nlN+sHUNvNVWLIKbu+nLUYo0NK8vPIJ0G2ZFXaBwTyludH1BKuMPRIEzkvy
	Hnu33oFz0/tBwpE9WBFN28SF0dOrJlxcDppjtNJthrRIT6lcK+/x8Cq0zhjd9Z/1
	eBDnBCTER/em4FLi3FVd3x5PQyHD7pyW0s+XF7i7ghqOqqCGS3oowjNnppyz/ca+
	J+4LSw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prjgdb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 02:14:17 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51Q2EGQ2002812
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 02:14:16 GMT
Received: from [10.110.127.75] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 25 Feb
 2025 18:14:15 -0800
Message-ID: <0f330522-1bfb-47a6-a804-0b4a4493d152@quicinc.com>
Date: Wed, 26 Feb 2025 10:14:13 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath12k: read country code from SMBIOS for
 WCN7850
To: <ath12k@lists.infradead.org>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>
CC: <linux-wireless@vger.kernel.org>
References: <20250220062607.334-1-quic_kangyang@quicinc.com>
Content-Language: en-US
From: Kang Yang <quic_kangyang@quicinc.com>
In-Reply-To: <20250220062607.334-1-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GHoiP2IFZ7zZPrrGWGftjB81WUZ93HcJ
X-Proofpoint-GUID: GHoiP2IFZ7zZPrrGWGftjB81WUZ93HcJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_08,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260015



On 2/20/2025 2:26 PM, Kang Yang wrote:
> Read the country code from SMBIOS and send it to the firmware. The
> firmware will then indicate the regulatory domain information for
> the country code, which ath12k will use.
> 
> dmesg:
> [ 1242.637253] ath12k_pci 0000:02:00.0: worldwide regdomain setting from SMBIOS
> [ 1242.637259] ath12k_pci 0000:02:00.0: bdf variant name not found.
> [ 1242.637261] ath12k_pci 0000:02:00.0: SMBIOS bdf variant name not set.
> [ 1242.927543] ath12k_pci 0000:02:00.0: set current country pdev id 0 alpha2 00
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-02582-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
> ---
> 
> Depends-On:
>          [PATCH v11 0/4] wifi: ath12k: add 11d scan offload support and handle country code for WCN7850
>          https://lore.kernel.org/linux-wireless/20250220031056.216-1-quic_kangyang@quicinc.com/
> 
> v2:
>      1. rebase on tag: ath/main(ath-202502181756).
> 	2. rewrite commit message.
> 
> ---
>   drivers/net/wireless/ath/ath12k/core.c | 26 +++++++++++++++++++++++--
>   drivers/net/wireless/ath/ath12k/core.h | 27 +++++++++++++++++++++++++-
>   drivers/net/wireless/ath/ath12k/mac.c  | 11 +++++++++++
>   3 files changed, 61 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
> index 8eaf9dd95a6b..0bdd0cd4f071 100644
> --- a/drivers/net/wireless/ath/ath12k/core.c
> +++ b/drivers/net/wireless/ath/ath12k/core.c
> @@ -629,7 +629,7 @@ static void ath12k_core_stop(struct ath12k_base *ab)
>   	/* De-Init of components as needed */
>   }
>   
> -static void ath12k_core_check_bdfext(const struct dmi_header *hdr, void *data)
> +static void ath12k_core_check_cc_code_bdfext(const struct dmi_header *hdr, void *data)
>   {
>   	struct ath12k_base *ab = data;
>   	const char *magic = ATH12K_SMBIOS_BDF_EXT_MAGIC;
> @@ -651,6 +651,28 @@ static void ath12k_core_check_bdfext(const struct dmi_header *hdr, void *data)
>   		return;
>   	}
>   
> +	spin_lock_bh(&ab->base_lock);
> +
> +	switch (smbios->country_code_flag) {
> +	case ATH12K_SMBIOS_CC_ISO:
> +		ab->new_alpha2[0] = u16_get_bits(smbios->cc_code, 0xff);
> +		ab->new_alpha2[1] = u16_get_bits(smbios->cc_code, 0xff);
> +		ath12k_dbg(ab, ATH12K_DBG_BOOT, "boot smbios cc_code %c%c\n",
> +			   ab->new_alpha2[0], ab->new_alpha2[1]);
> +		break;
> +	case ATH12K_SMBIOS_CC_WW:
> +		ab->new_alpha2[0] = '0';
> +		ab->new_alpha2[1] = '0';
> +		ath12k_dbg(ab, ATH12K_DBG_BOOT, "boot smbios worldwide regdomain\n");
> +		break;
> +	default:
> +		ath12k_dbg(ab, ATH12K_DBG_BOOT, "boot ignore smbios country code setting %d\n",
> +			   smbios->country_code_flag);
> +		break;
> +	}
> +
> +	spin_unlock_bh(&ab->base_lock);
> +
>   	if (!smbios->bdf_enabled) {
>   		ath12k_dbg(ab, ATH12K_DBG_BOOT, "bdf variant name not found.\n");
>   		return;
> @@ -690,7 +712,7 @@ static void ath12k_core_check_bdfext(const struct dmi_header *hdr, void *data)
>   int ath12k_core_check_smbios(struct ath12k_base *ab)
>   {
>   	ab->qmi.target.bdf_ext[0] = '\0';
> -	dmi_walk(ath12k_core_check_bdfext, ab);
> +	dmi_walk(ath12k_core_check_cc_code_bdfext, ab);
>   
>   	if (ab->qmi.target.bdf_ext[0] == '\0')
>   		return -ENODATA;
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index 569ff02de09a..bd0c106b5098 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -172,9 +172,34 @@ struct ath12k_ext_irq_grp {
>   	struct net_device *napi_ndev;
>   };
>   
> +enum ath12k_smbios_cc_type {
> +	/* disable country code setting from SMBIOS */
> +	ATH12K_SMBIOS_CC_DISABLE = 0,
> +
> +	/* set country code by ANSI country name, based on ISO3166-1 alpha2 */
> +	ATH12K_SMBIOS_CC_ISO = 1,
> +
> +	/* worldwide regdomain */
> +	ATH12K_SMBIOS_CC_WW = 2,
> +};
> +
>   struct ath12k_smbios_bdf {
>   	struct dmi_header hdr;
> -	u32 padding;
> +	u8 features_disabled;
> +
> +	/* enum ath12k_smbios_cc_type */
> +	u8 country_code_flag;
> +
> +	/* To set specific country, you need to set country code
> +	 * flag=ATH12K_SMBIOS_CC_ISO first, then if country is United
> +	 * States, then country code value = 0x5553 ("US",'U' = 0x55, 'S'=
> +	 * 0x53). To set country to INDONESIA, then country code value =
> +	 * 0x4944 ("IN", 'I'=0x49, 'D'=0x44). If country code flag =
> +	 * ATH12K_SMBIOS_CC_WW, then you can use worldwide regulatory
> +	 * setting.
> +	 */
> +	u16 cc_code;
> +
>   	u8 bdf_enabled;
>   	u8 bdf_ext[];
>   } __packed;
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 3b60534fb0f4..e17a35759456 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -11502,6 +11502,17 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
>   			goto err_unregister_hw;
>   		}
>   
> +		if (ar->ab->hw_params->current_cc_support && ab->new_alpha2[0]) {
> +			struct wmi_set_current_country_arg current_cc = {};
> +
> +			memcpy(&current_cc.alpha2, ab->new_alpha2, 2);
> +			memcpy(&ar->alpha2, ab->new_alpha2, 2);
> +			ret = ath12k_wmi_send_set_current_country_cmd(ar, &current_cc);
> +			if (ret)
> +				ath12k_warn(ar->ab,
> +					    "failed set cc code for mac register: %d\n", ret);
> +		}
> +
>   		ath12k_debugfs_register(ar);
>   	}
>   
> 
> base-commit: f22471c17f5849b2f20e2c56ec9fcd9dd8d5bf28
> prerequisite-patch-id: 4d98208c1659b01545c48494f7a84c5ba4888da0
> prerequisite-patch-id: dc095f4a1f0d9f6c4f6f850fa1dfe3d804f41e47
> prerequisite-patch-id: 7bffae693031c27eadd2b3452a059bb224070e0b
> prerequisite-patch-id: 3711a8bb24847dd69c5805d7425416b239144898


Hi, jeff:
	Can you have a review on this patch and dependency patch-set
[PATCH v11 0/4] wifi: ath12k: add 11d scan offload support and handle 
country code for WCN7850



