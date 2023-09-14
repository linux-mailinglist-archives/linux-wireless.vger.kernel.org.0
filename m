Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE38579F687
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Sep 2023 03:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbjINBxB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Sep 2023 21:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbjINBxB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Sep 2023 21:53:01 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AADC1BCB
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 18:52:57 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38E0Vs28017937;
        Thu, 14 Sep 2023 01:52:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=lbpPq+1iRvxhVw2cDaYE6K8Me4D9TcKA4U/Ecbpy/qc=;
 b=lMeIizz144ifaVWkwdbBYKhir2A+E/NIFvEai/c8dTsvalk9Yxvo/5UscdkCke3c/ils
 doWALJGgbbA8PJAIG+yjKU1KkXKwo4nIJspjGe4j6wQ3ousZOSJN16MjYRSZSbAnFwrn
 hQUGCB0phUNphSbUMoLH3RnpMQ4ppALiPB7QCM0RXd26/XM+jRzXa8t+8duaGKG9ElMm
 mBQ70WyPKDK+3XxbpHvtl9islJgCcVRDJnLiYCnkfz/6MqbUnsr/GKY0erFfxjld5vlB
 jVmZQHpJZDOCcT7VcTdTLggLk+KRpyDAQXSs1s3SM8V/uETd1/7dvCpk2dz2ocomeMJ3 jg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t3qqa84md-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 01:52:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38E1qnRP027137
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 01:52:49 GMT
Received: from [10.111.183.186] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 13 Sep
 2023 18:52:49 -0700
Message-ID: <e0645b4c-4d9c-46b0-85e9-8964d82fb2e9@quicinc.com>
Date:   Wed, 13 Sep 2023 18:52:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: read country code from SMBIOS for WCN7850
Content-Language: en-US
To:     Wen Gong <quic_wgong@quicinc.com>, <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <kvalo@kernel.org>
References: <20230913105156.17618-1-quic_wgong@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230913105156.17618-1-quic_wgong@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 328ACcJjH2A6BLEZV7uehBrbPTeyP4JC
X-Proofpoint-GUID: 328ACcJjH2A6BLEZV7uehBrbPTeyP4JC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_19,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 phishscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140014
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/13/2023 3:51 AM, Wen Gong wrote:
> This read the country code from SMBIOS and send the country code
> to firmware, firmware will indicate the regulatory domain info of the
> country code and then ath12k will use the info.
> 
> dmesg:
> [ 1242.637253] ath12k_pci 0000:02:00.0: worldwide regdomain setting from SMBIOS
> [ 1242.637259] ath12k_pci 0000:02:00.0: bdf variant name not found.
> [ 1242.637261] ath12k_pci 0000:02:00.0: SMBIOS bdf variant name not set.
> [ 1242.927543] ath12k_pci 0000:02:00.0: set current country pdev id 0 alpha2 00
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

> ---
> depends on 5 patches in public review:
> Wen Gong:
> 
> https://lore.kernel.org/linux-wireless/20230905105637.10230-1-quic_wgong@quicinc.com/
> wifi: ath12k: add read variant from SMBIOS for download board data
> 
> https://lore.kernel.org/linux-wireless/20230906082948.18452-1-quic_wgong@quicinc.com/
> wifi: ath12k: add read variant from SMBIOS for download board data
> [PATCH 0/4] wifi: ath12k: add 11d scan offload support and handle country code for WCN7850
>    wifi: ath12k: add configure country code for WCN7850
>    wifi: ath12k: add 11d scan offload support
>    wifi: ath12k: avoid firmware crash when reg set for WCN7850
>    wifi: ath12k: store and send country code to firmware after recovery
> 
>   drivers/net/wireless/ath/ath12k/core.c | 26 +++++++++++++++++++++++--
>   drivers/net/wireless/ath/ath12k/core.h | 27 +++++++++++++++++++++++++-
>   drivers/net/wireless/ath/ath12k/mac.c  | 11 +++++++++++
>   3 files changed, 61 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
> index 4c4abeba39c8..de9b7604eaa2 100644
> --- a/drivers/net/wireless/ath/ath12k/core.c
> +++ b/drivers/net/wireless/ath/ath12k/core.c
> @@ -377,7 +377,7 @@ static void ath12k_core_stop(struct ath12k_base *ab)
>   	/* De-Init of components as needed */
>   }
>   
> -static void ath12k_core_check_bdfext(const struct dmi_header *hdr, void *data)
> +static void ath12k_core_check_cc_code_bdfext(const struct dmi_header *hdr, void *data)
>   {
>   	struct ath12k_base *ab = data;
>   	const char *magic = ATH12K_SMBIOS_BDF_EXT_MAGIC;
> @@ -399,6 +399,28 @@ static void ath12k_core_check_bdfext(const struct dmi_header *hdr, void *data)
>   		return;
>   	}
>   
> +	spin_lock_bh(&ab->base_lock);
> +
> +	switch (smbios->country_code_flag) {
> +	case ATH12K_SMBIOS_CC_ISO:
> +		ab->new_alpha2[0] = u16_get_bits(smbios->cc_code, 0xff00);
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
> @@ -438,7 +460,7 @@ static void ath12k_core_check_bdfext(const struct dmi_header *hdr, void *data)
>   int ath12k_core_check_smbios(struct ath12k_base *ab)
>   {
>   	ab->qmi.target.bdf_ext[0] = '\0';
> -	dmi_walk(ath12k_core_check_bdfext, ab);
> +	dmi_walk(ath12k_core_check_cc_code_bdfext, ab);
>   
>   	if (ab->qmi.target.bdf_ext[0] == '\0')
>   		return -ENODATA;
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index 35a3b6357eb5..d35b97520e6d 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -142,9 +142,34 @@ struct ath12k_ext_irq_grp {
>   	struct net_device napi_ndev;
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
> index 0df154c34f8f..ba292c2873d1 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -7509,6 +7509,17 @@ static int __ath12k_mac_register(struct ath12k *ar)
>   		goto err_unregister_hw;
>   	}
>   
> +	if (ar->ab->hw_params->current_cc_support && ab->new_alpha2[0]) {
> +		struct wmi_set_current_country_params set_current_param = {};
> +
> +		memcpy(&set_current_param.alpha2, ab->new_alpha2, 2);
> +		memcpy(&ar->alpha2, ab->new_alpha2, 2);
> +		ret = ath12k_wmi_send_set_current_country_cmd(ar, &set_current_param);
> +		if (ret)
> +			ath12k_warn(ar->ab,
> +				    "failed set cc code for mac register: %d\n", ret);
> +	}
> +
>   	return 0;
>   
>   err_unregister_hw:
> 
> base-commit: 3f257461ab0ab19806bae2bfde4c3cd88dbf050e
> prerequisite-patch-id: 2ee4ca0fc2ff95861b978c44b2cb04771c927ee1
> prerequisite-patch-id: a341b369c2d9f319970dff05a117cc4c6c85c31c
> prerequisite-patch-id: 04c82a480f25fa06001c9ff3fb1d30630f9ec82a
> prerequisite-patch-id: 9ba56bba555d7c1b7dea4ad394d39d8397e79754
> prerequisite-patch-id: 7c1c0cda8e48fee003376e035ac2b472d22cbae9

