Return-Path: <linux-wireless+bounces-21624-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FABBA9128E
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 07:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B03111905657
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 05:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDFFF9D9;
	Thu, 17 Apr 2025 05:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="B+q0mz7T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F612A94A
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 05:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744867009; cv=none; b=eEeU6lmWQQwtQScxQ9HZn0qXJFiQNv0g+qAMVykhGrc3+/0GmEE6MSfwCrm8a9zNrlXbV8taphVaFUIw4yKN+BWRkfNygWCGCeDw9JTOIssy3E8EuPE0ByIdYnOj7sBMZl3YFqXzhHrUH9/SbbcbUwC/xF2ee3b8v7EB7dxnmTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744867009; c=relaxed/simple;
	bh=b8clCM91/8l1orQg81knHQKDmstycyeW7KXP+s3mZgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gd1ZIluhjtkJtXupDjZWAnEgRUdrv89xhh2D+qUDOJ7TTNM9h/r84IBSTD3yzveac+64CuaO1PKloFX3G7EZvlR8OCPnFE9HM1jwluQqSbbn5PdhPTUwqCfbrPuiILywyySU4mdt5zrDQASFO+TvFw/swLVirLu9lXgHrT13inc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=B+q0mz7T; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53GNbBlt026243;
	Thu, 17 Apr 2025 05:16:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	opocN3IdDBFvwxeezJSMeRl0abWKxrQVzbQU0gzefCk=; b=B+q0mz7TdkaAGoZy
	OqHkVmHCo52jtegXVmY5BUTml5KYmPcTyIg9Gmlb4e/jyXyxkVcg20FkinAeduXw
	Bm6bODW9EmuBU7uwrvmZSUE19u+YfWcCJpb2vTJ0+ganmxc9mH/7gIvPV03OgQqs
	AHU3nk3vS9Loo14MyOaKxgmxj16Md2bJjM7l/kG5wY7Xr5e4lqW5WEzGtwGrkAhK
	FBqPO2mzLmljUfpBVA3ZYrNPQ623lArnCgB3t6A60ytPGdjHCxRDHzcf83D/BFhb
	oWlzfabhtP81SqW3Z4HzEUkjomclLfqB2ArUxUPnOhgQcePoP7Xh/8wy+vJ08BOl
	5k3C4A==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yfs1dn3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 05:16:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53H5GfgI014801
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 05:16:41 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 16 Apr
 2025 22:16:39 -0700
Message-ID: <b4ec5baa-b6f2-42ba-ad6d-4742d6b53cb4@quicinc.com>
Date: Thu, 17 Apr 2025 13:16:37 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v5] wifi: ath12k: read country code from SMBIOS
 for WCN7850
To: Kang Yang <kang.yang@oss.qualcomm.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Wen Gong <quic_wgong@quicinc.com>
References: <20250417024227.1712-1-kang.yang@oss.qualcomm.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <20250417024227.1712-1-kang.yang@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=P9I6hjAu c=1 sm=1 tr=0 ts=68008eba cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=3EeBUfc7dGaKCxx2Rn8A:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: MIj1zIfWWXPTRsJLSS9witFsL0h1CSmf
X-Proofpoint-ORIG-GUID: MIj1zIfWWXPTRsJLSS9witFsL0h1CSmf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_01,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 phishscore=0 suspectscore=0
 mlxscore=0 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170039



On 4/17/2025 10:42 AM, Kang Yang wrote:
> From: Wen Gong <quic_wgong@quicinc.com>
> 
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
> Signed-off-by: Kang Yang <kang.yang@oss.qualcomm.com>
> ---
> 
> Note: This patch is an old patch in public review written by
> Wen Gong. Just resend it for him.
> Link: https://lore.kernel.org/linux-wireless/20230913105156.17618-1-quic_wgong@quicinc.com/
> 
> v5:
>     1. fix "From" header.
>     2. rebase on tag: ath/main(ath-202504141512).
>     3. change quic email to oss email.
> v4:
>     1. fix assignment error for case ATH12K_SMBIOS_CC_ISO.
>     2. rebase on tag: ath/main(ath-202503251458).
> v3:
>     1. rebase on tag: ath-202503172347.
>     2. add branch tag.
>     3. add descripition for Wen Gong.
> v2:
>     1. rebase on tag: ath/main(ath-202502181756).
>     2. rewrite commit message.
> 
> ---
>  drivers/net/wireless/ath/ath12k/core.c | 26 +++++++++++++++++++++++--
>  drivers/net/wireless/ath/ath12k/core.h | 27 +++++++++++++++++++++++++-
>  drivers/net/wireless/ath/ath12k/mac.c  | 11 +++++++++++
>  3 files changed, 61 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
> index 9b23329f1bf2..b5ade9c7530d 100644
> --- a/drivers/net/wireless/ath/ath12k/core.c
> +++ b/drivers/net/wireless/ath/ath12k/core.c
> @@ -697,7 +697,7 @@ static void ath12k_core_stop(struct ath12k_base *ab)
>  	/* De-Init of components as needed */
>  }
>  
> -static void ath12k_core_check_bdfext(const struct dmi_header *hdr, void *data)
> +static void ath12k_core_check_cc_code_bdfext(const struct dmi_header *hdr, void *data)
>  {
>  	struct ath12k_base *ab = data;
>  	const char *magic = ATH12K_SMBIOS_BDF_EXT_MAGIC;
> @@ -719,6 +719,28 @@ static void ath12k_core_check_bdfext(const struct dmi_header *hdr, void *data)
>  		return;
>  	}
>  
> +	spin_lock_bh(&ab->base_lock);
> +
> +	switch (smbios->country_code_flag) {
> +	case ATH12K_SMBIOS_CC_ISO:
> +		ab->new_alpha2[0] = u16_get_bits(smbios->cc_code >> 8, 0xff);
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
>  	if (!smbios->bdf_enabled) {
>  		ath12k_dbg(ab, ATH12K_DBG_BOOT, "bdf variant name not found.\n");
>  		return;
> @@ -758,7 +780,7 @@ static void ath12k_core_check_bdfext(const struct dmi_header *hdr, void *data)
>  int ath12k_core_check_smbios(struct ath12k_base *ab)
>  {
>  	ab->qmi.target.bdf_ext[0] = '\0';
> -	dmi_walk(ath12k_core_check_bdfext, ab);
> +	dmi_walk(ath12k_core_check_cc_code_bdfext, ab);
>  
>  	if (ab->qmi.target.bdf_ext[0] == '\0')
>  		return -ENODATA;
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index 44e02ebb1071..3f9fcd4d6f20 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -175,9 +175,34 @@ struct ath12k_ext_irq_grp {
>  	struct net_device *napi_ndev;
>  };
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
>  struct ath12k_smbios_bdf {
>  	struct dmi_header hdr;
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
>  	u8 bdf_enabled;
>  	u8 bdf_ext[];
>  } __packed;
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 7af12733a1ff..aee3080a934c 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -11550,6 +11550,17 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
>  			goto err_unregister_hw;
>  		}
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
>  		ath12k_fw_stats_init(ar);
>  		ath12k_debugfs_register(ar);
>  	}
> 
> base-commit: b80c52642c1159c2596776b39b06eb1c2e36baff

Reviewed-by: Baochen Qiang <quic_bqiang@quicinc.com>



