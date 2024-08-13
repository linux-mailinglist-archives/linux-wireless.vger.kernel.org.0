Return-Path: <linux-wireless+bounces-11364-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 044C3950B07
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 19:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F08B1C24D6C
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 17:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B761A2C17;
	Tue, 13 Aug 2024 17:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SwUu1zaH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB5B1A3BD3
	for <linux-wireless@vger.kernel.org>; Tue, 13 Aug 2024 17:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723568506; cv=none; b=icAxeT+EL3DCL0u4KJj6sd9VmzD/QGLk0FuGe93fpQwFsZKBXuFf2pElcva9wFWXXzaUJRRffVn5hlAmUtkbmevPMNlw7ibNTdU9Mg+X0/EFf33/WFU8VnQ7oGGqsoDwBodJeZiYScDxhiEptQ1E8oK6hy99C4NOMSObIwPja+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723568506; c=relaxed/simple;
	bh=klGcsRBC4IPLZ/TvXwKI2rPP31otTf5wy3V3Nl20b4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uxFIUWrJoZKQJtlSeh3H4Pz2BDjfDOG/uftcROKgYQDkH6oE0cloaji1krBv3z0JGBf+/XQU9tWiGsHMLGhMN/AIjMEJUcEsEs6zHai1w1c0fpc+m05B6OnKUOoA7Xo8esbtwZVnLp706K78kGctfkZ8lP8Lg2T5/novo/QUS8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SwUu1zaH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47DGVMpQ004654;
	Tue, 13 Aug 2024 17:01:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VaB0O0eAbVK6kLsBtbX6uojTt2HJPXa6hN5/qBfz8ig=; b=SwUu1zaHgpjc0PXK
	UNqFghtP+MhHElM/XbF773DaBJD/n81ttL0NJFNseSkSzOjuncmuJp/pJN2mLesV
	ONWkLRsBMS5eBtJwIBrFYQE7j1S6C+IyK480CYrutOYhpgUVvRH921VfCI8+oen9
	L/PXqLqkM4uNsVbV2vtQZ0R+H2Fcyp0WVgeWyg4uHcvtK24r51MQKxxzO//Zm6+Q
	QvcVQ7S90EOUc4HLLpfS8PXB/AH69Wuu+9SQKO3MZS2nvO20JBxeJ1B/jLbhxIa0
	GUxGHqiLAWFOnZJuim9RLS9lUbDfdcV13Hb0hR0agTZYc1aCFS7GX43PufRTCrHn
	gLy48A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4103ws1r7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 17:01:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47DH1ejp018372
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 17:01:40 GMT
Received: from [10.111.178.117] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 13 Aug
 2024 10:01:40 -0700
Message-ID: <2fa2f672-e71c-45e0-b8df-5c972b1d24d0@quicinc.com>
Date: Tue, 13 Aug 2024 10:01:39 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] wifi: ath12k: Add Support for enabling or
 disabling specific features based on ACPI bitflag
To: Lingbo Kong <quic_lingbok@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240809025055.6495-1-quic_lingbok@quicinc.com>
 <20240809025055.6495-3-quic_lingbok@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240809025055.6495-3-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tPb2A580-WHfalm5iD7qtChi6tl8oAOy
X-Proofpoint-ORIG-GUID: tPb2A580-WHfalm5iD7qtChi6tl8oAOy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_07,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408130124

On 8/8/2024 7:50 PM, Lingbo Kong wrote:
> Currently, ath12k does not support enable or disable specific features by
> ACPI bitflag.
> 
> To address this issue, obtain the ACPI bitflag value and use it to
> selectively enable or disable specific features.
> 
> This patch will not affect QCN9274, because only WCN7850 supports ACPI.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
> ---
> v2:
> 1.support functions for cases where CONFIG_ACPI is disabled
> 
>  drivers/net/wireless/ath/ath12k/acpi.c | 41 ++++++++++++++++++++++++--
>  drivers/net/wireless/ath/ath12k/acpi.h | 18 +++++++++++
>  drivers/net/wireless/ath/ath12k/core.c |  3 ++
>  drivers/net/wireless/ath/ath12k/core.h |  3 ++
>  drivers/net/wireless/ath/ath12k/mac.c  |  3 +-
>  5 files changed, 64 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/acpi.c b/drivers/net/wireless/ath/ath12k/acpi.c
> index d83f7e58fb7a..a3f3d0712722 100644
> --- a/drivers/net/wireless/ath/ath12k/acpi.c
> +++ b/drivers/net/wireless/ath/ath12k/acpi.c
> @@ -29,7 +29,14 @@ static int ath12k_acpi_dsm_get_data(struct ath12k_base *ab, int func)
>  	}
>  
>  	if (obj->type == ACPI_TYPE_INTEGER) {
> -		ab->acpi.func_bit = obj->integer.value;
> +		switch (func) {
> +		case ATH12K_ACPI_DSM_FUNC_SUPPORT_FUNCS:
> +			ab->acpi.func_bit = obj->integer.value;
> +			break;
> +		case ATH12K_ACPI_DSM_FUNC_DISABLE_FLAG:
> +			ab->acpi.bit_flag = obj->integer.value;
> +			break;
> +		}
>  	} else if (obj->type == ACPI_TYPE_BUFFER) {
>  		switch (func) {
>  		case ATH12K_ACPI_DSM_FUNC_SUPPORT_FUNCS:
> @@ -261,24 +268,52 @@ static int ath12k_acpi_set_tas_params(struct ath12k_base *ab)
>  	return 0;
>  }
>  
> +bool ath12k_acpi_get_disable_rfkill(struct ath12k_base *ab)
> +{
> +	return ab->acpi.acpi_disable_rfkill;
> +}
> +
> +bool ath12k_acpi_get_disable_11be(struct ath12k_base *ab)
> +{
> +	return ab->acpi.acpi_disable_11be;
> +}

IMO the above functions would be better if you remove "get_" from the names.
"get" is an action verb and usually action verbs return error codes.
removing "get" makes them predicates which normally return bool.

And based upon the usage, IMO they become even better as:
ath12k_acpi_rfkill_disabled()
ath12k_acpi_11be_disabled()

Since then they work very well in 'if' statements

> +
>  int ath12k_acpi_start(struct ath12k_base *ab)
>  {
>  	acpi_status status;
>  	u8 *buf;
>  	int ret;
>  
> +	ab->acpi.acpi_tas_enable = false;
> +	ab->acpi.acpi_disable_11be = false;
> +	ab->acpi.acpi_disable_rfkill = false;
> +
>  	if (!ab->hw_params->acpi_guid)
>  		/* not supported with this hardware */
>  		return 0;
>  
> -	ab->acpi.acpi_tas_enable = false;
> -
>  	ret = ath12k_acpi_dsm_get_data(ab, ATH12K_ACPI_DSM_FUNC_SUPPORT_FUNCS);
>  	if (ret) {
>  		ath12k_dbg(ab, ATH12K_DBG_BOOT, "failed to get ACPI DSM data: %d\n", ret);
>  		return ret;
>  	}
>  
> +	if (ATH12K_ACPI_FUNC_BIT_VALID(ab->acpi, ATH12K_ACPI_FUNC_BIT_DISABLE_FLAG)) {
> +		ret = ath12k_acpi_dsm_get_data(ab, ATH12K_ACPI_DSM_FUNC_DISABLE_FLAG);
> +		if (ret) {
> +			ath12k_warn(ab, "failed to get ACPI DISABLE FLAG: %d\n", ret);
> +			return ret;
> +		}
> +
> +		if (ATH12K_ACPI_CHEK_BIT_VALID(ab->acpi,
> +					       ATH12K_ACPI_DSM_DISABLE_11BE_BIT))
> +			ab->acpi.acpi_disable_11be = true;
> +
> +		if (!ATH12K_ACPI_CHEK_BIT_VALID(ab->acpi,
> +						ATH12K_ACPI_DSM_DISABLE_RFKILL_BIT))
> +			ab->acpi.acpi_disable_rfkill = true;
> +	}
> +
>  	if (ATH12K_ACPI_FUNC_BIT_VALID(ab->acpi, ATH12K_ACPI_FUNC_BIT_TAS_CFG)) {
>  		ret = ath12k_acpi_dsm_get_data(ab, ATH12K_ACPI_DSM_FUNC_TAS_CFG);
>  		if (ret) {
> diff --git a/drivers/net/wireless/ath/ath12k/acpi.h b/drivers/net/wireless/ath/ath12k/acpi.h
> index 7ec7a2e72e40..4b154cfdbd39 100644
> --- a/drivers/net/wireless/ath/ath12k/acpi.h
> +++ b/drivers/net/wireless/ath/ath12k/acpi.h
> @@ -9,6 +9,7 @@
>  #include <linux/acpi.h>
>  
>  #define ATH12K_ACPI_DSM_FUNC_SUPPORT_FUNCS	0
> +#define ATH12K_ACPI_DSM_FUNC_DISABLE_FLAG	2
>  #define ATH12K_ACPI_DSM_FUNC_BIOS_SAR		4
>  #define ATH12K_ACPI_DSM_FUNC_GEO_OFFSET		5
>  #define ATH12K_ACPI_DSM_FUNC_INDEX_CCA		6
> @@ -16,6 +17,7 @@
>  #define ATH12K_ACPI_DSM_FUNC_TAS_DATA		9
>  #define ATH12K_ACPI_DSM_FUNC_INDEX_BAND_EDGE		10
>  
> +#define ATH12K_ACPI_FUNC_BIT_DISABLE_FLAG		BIT(1)
>  #define ATH12K_ACPI_FUNC_BIT_BIOS_SAR			BIT(3)
>  #define ATH12K_ACPI_FUNC_BIT_GEO_OFFSET			BIT(4)
>  #define ATH12K_ACPI_FUNC_BIT_CCA			BIT(5)
> @@ -25,6 +27,7 @@
>  
>  #define ATH12K_ACPI_NOTIFY_EVENT			0x86
>  #define ATH12K_ACPI_FUNC_BIT_VALID(_acdata, _func)	(((_acdata).func_bit) & (_func))
> +#define ATH12K_ACPI_CHEK_BIT_VALID(_acdata, _func)	(((_acdata).bit_flag) & (_func))
>  
>  #define ATH12K_ACPI_TAS_DATA_VERSION		0x1
>  #define ATH12K_ACPI_TAS_DATA_ENABLE		0x1
> @@ -51,6 +54,9 @@
>  #define ATH12K_ACPI_DSM_FUNC_MIN_BITMAP_SIZE	1
>  #define ATH12K_ACPI_DSM_FUNC_MAX_BITMAP_SIZE	4
>  
> +#define ATH12K_ACPI_DSM_DISABLE_11BE_BIT	BIT(0)
> +#define ATH12K_ACPI_DSM_DISABLE_RFKILL_BIT	BIT(2)
> +
>  #define ATH12K_ACPI_DSM_GEO_OFFSET_DATA_SIZE (ATH12K_ACPI_GEO_OFFSET_DATA_OFFSET + \
>  					      ATH12K_ACPI_BIOS_SAR_GEO_OFFSET_LEN)
>  #define ATH12K_ACPI_DSM_BIOS_SAR_DATA_SIZE (ATH12K_ACPI_POWER_LIMIT_DATA_OFFSET + \
> @@ -62,6 +68,8 @@
>  
>  int ath12k_acpi_start(struct ath12k_base *ab);
>  void ath12k_acpi_stop(struct ath12k_base *ab);
> +bool ath12k_acpi_get_disable_rfkill(struct ath12k_base *ab);
> +bool ath12k_acpi_get_disable_11be(struct ath12k_base *ab);
>  
>  #else
>  
> @@ -74,6 +82,16 @@ static inline void ath12k_acpi_stop(struct ath12k_base *ab)
>  {
>  }
>  
> +static inline bool ath12k_acpi_get_disable_rfkill(struct ath12k_base *ab)
> +{
> +	return false;
> +}
> +
> +static inline bool ath12k_acpi_get_disable_11be(struct ath12k_base *ab)
> +{
> +	return false;
> +}
> +
>  #endif /* CONFIG_ACPI */
>  
>  #endif /* ATH12K_ACPI_H */
> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
> index 51252e8bc1ae..bda7d40075c4 100644
> --- a/drivers/net/wireless/ath/ath12k/core.c
> +++ b/drivers/net/wireless/ath/ath12k/core.c
> @@ -30,6 +30,9 @@ static int ath12k_core_rfkill_config(struct ath12k_base *ab)
>  	if (!(ab->target_caps.sys_cap_info & WMI_SYS_CAP_INFO_RFKILL))
>  		return 0;
>  
> +	if (ath12k_acpi_get_disable_rfkill(ab))
> +		return 0;

As noted previously IMO this is much better
	if (ath12k_acpi_rfkill_disabled(ab))

> +
>  	for (i = 0; i < ab->num_radios; i++) {
>  		ar = ab->pdevs[i].ar;
>  
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index cdfd43a7321a..cac6647f2776 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -940,6 +940,9 @@ struct ath12k_base {
>  		u32 func_bit;
>  		bool acpi_tas_enable;
>  		bool acpi_bios_sar_enable;
> +		bool acpi_disable_11be;
> +		bool acpi_disable_rfkill;
> +		u32 bit_flag;
>  		u8 tas_cfg[ATH12K_ACPI_DSM_TAS_CFG_SIZE];
>  		u8 tas_sar_power_table[ATH12K_ACPI_DSM_TAS_DATA_SIZE];
>  		u8 bios_sar_data[ATH12K_ACPI_DSM_BIOS_SAR_DATA_SIZE];
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index a3248d977532..4be88834e62b 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -5483,7 +5483,8 @@ static void ath12k_mac_copy_eht_cap(struct ath12k *ar,
>  
>  	memset(eht_cap, 0, sizeof(struct ieee80211_sta_eht_cap));
>  
> -	if (!(test_bit(WMI_TLV_SERVICE_11BE, ar->ab->wmi_ab.svc_map)))
> +	if (!(test_bit(WMI_TLV_SERVICE_11BE, ar->ab->wmi_ab.svc_map)) ||
> +	    ath12k_acpi_get_disable_11be(ar->ab))

ath12k_acpi_11be_disabled()

>  		return;
>  
>  	eht_cap->has_eht = true;


