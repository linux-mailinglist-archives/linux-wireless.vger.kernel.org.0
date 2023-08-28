Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A8378B386
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 16:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbjH1Or7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 10:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbjH1Orj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 10:47:39 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3E2DA
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 07:47:26 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37SB6ROK011221;
        Mon, 28 Aug 2023 14:47:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=LtEJ+DfcSuwg7tQh+ZeetnkwhEqUUalCmlNBAxHeNOA=;
 b=lsxr3gmI/tQQB3ozrD1aTbSuhbCGATZl1ha08SdYZhluOuK0eLNjrShXjS+1a7fDE1uM
 nMbzC/XEEDoua5zs5PYJ5N7skBLtyjtcr/FuaLeTHwA1MxbCGtqHr2cuk2xc8SjURvm+
 KChHcru7rY0wYCQNXUn353JCI4f5epIPB8gz2awCWutYgxhWLzcQesnBXRp2hAgKEhTu
 Pbx4x6RL39RS+9MV7uQqraL5cevtNloMLthQj6WN0IKW2suSL3hPNa+w3WWFaUs99JhH
 +ocAos+vrcTOs01W+I6/n5pxHGWn5GFYGx1J0bnpJmQmFZ4L5JvrLnRI3zvl82MniUri 5w== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sqapfktta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 14:47:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37SElMS4008074
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 14:47:22 GMT
Received: from [10.48.245.159] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 28 Aug
 2023 07:47:21 -0700
Message-ID: <dd1b11ee-696e-46f2-ad53-b80f4d0d9256@quicinc.com>
Date:   Mon, 28 Aug 2023 07:47:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] wifi: ath12k: enable 320 MHz bandwidth for 6 GHz band
 in EHT PHY capability for WCN7850
Content-Language: en-US
To:     Wen Gong <quic_wgong@quicinc.com>, <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230828040420.2165-1-quic_wgong@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230828040420.2165-1-quic_wgong@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: svM0Z4S_HjJjFoJCj0yDiWJ8exzf0Uc_
X-Proofpoint-GUID: svM0Z4S_HjJjFoJCj0yDiWJ8exzf0Uc_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_12,2023-08-28_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 adultscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308280130
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/27/2023 9:04 PM, Wen Gong wrote:
> 320 MHz bandwidth is reported only for single PHY mode for WCN7850, get it
> from WMI_HOST_HW_MODE_SINGLE ath12k_wmi_caps_ext_params and report it for
> 6 GHz band.
> 
> After this patch, "iw list" show 320MHz support for WCN7850:

nit: s/320MHz/320 MHz/ to conform to SI

> EHT Iftypes: managed
>          EHT PHY Capabilities: (0xe26f090010768800):
>                  320MHz in 6GHz Supported

unfortunate that 'iw' doesn't conform to SI representation

>          EHT bw=320 MHz, max NSS for MCS 8-9: Rx=0, Tx=0
>          EHT bw=320 MHz, max NSS for MCS 10-11: Rx=0, Tx=0
>          EHT bw=320 MHz, max NSS for MCS 12-13: Rx=0, Tx=0
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> ---
> v3:
>     1. fix "wmi.c:4199:69: warning: restricted __le32 degrades to integer"
>     2. s/capbility/capability/
>     3. change "u8 support_320mhz" to "u32 support_320mhz"
> 
> v2: change eht_cap_phy_info_5G to eht_cap_phy_info_5ghz.
> 
>   drivers/net/wireless/ath/ath12k/wmi.c | 22 ++++++++++++++++++++--
>   1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
> index 9ed33e2d6da0..5f46259cfa2a 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.c
> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> @@ -4148,14 +4148,22 @@ static void ath12k_wmi_eht_caps_parse(struct ath12k_pdev *pdev, u32 band,
>   				       __le32 cap_info_internal)
>   {
>   	struct ath12k_band_cap *cap_band = &pdev->cap.band[band];
> +	u32 support_320mhz;
>   	u8 i;
>   
> +	if (band == NL80211_BAND_6GHZ)
> +		support_320mhz = cap_band->eht_cap_phy_info[0] &
> +					IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ;
> +
>   	for (i = 0; i < WMI_MAX_EHTCAP_MAC_SIZE; i++)
>   		cap_band->eht_cap_mac_info[i] = le32_to_cpu(cap_mac_info[i]);
>   
>   	for (i = 0; i < WMI_MAX_EHTCAP_PHY_SIZE; i++)
>   		cap_band->eht_cap_phy_info[i] = le32_to_cpu(cap_phy_info[i]);
>   
> +	if (band == NL80211_BAND_6GHZ)
> +		cap_band->eht_cap_phy_info[0] |= support_320mhz;
> +
>   	cap_band->eht_mcs_20_only = le32_to_cpu(supp_mcs[0]);
>   	cap_band->eht_mcs_80 = le32_to_cpu(supp_mcs[1]);
>   	if (band != NL80211_BAND_2GHZ) {
> @@ -4177,10 +4185,19 @@ ath12k_wmi_tlv_mac_phy_caps_ext_parse(struct ath12k_base *ab,
>   				      const struct ath12k_wmi_caps_ext_params *caps,
>   				      struct ath12k_pdev *pdev)
>   {
> -	u32 bands;
> +	struct ath12k_band_cap *cap_band;
> +	u32 bands, support_320mhz;
>   	int i;
>   
>   	if (ab->hw_params->single_pdev_only) {
> +		if (caps->hw_mode_id == WMI_HOST_HW_MODE_SINGLE) {
> +			support_320mhz = le32_to_cpu(caps->eht_cap_phy_info_5ghz[0]) &
> +				IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ;
> +			cap_band = &pdev->cap.band[NL80211_BAND_6GHZ];
> +			cap_band->eht_cap_phy_info[0] |= support_320mhz;
> +			return 0;
> +		}
> +
>   		for (i = 0; i < ab->fw_pdev_count; i++) {
>   			struct ath12k_fw_pdev *fw_pdev = &ab->fw_pdev[i];
>   
> @@ -4236,7 +4253,8 @@ static int ath12k_wmi_tlv_mac_phy_caps_ext(struct ath12k_base *ab, u16 tag,
>   		return -EPROTO;
>   
>   	if (ab->hw_params->single_pdev_only) {
> -		if (ab->wmi_ab.preferred_hw_mode != le32_to_cpu(caps->hw_mode_id))
> +		if (ab->wmi_ab.preferred_hw_mode != le32_to_cpu(caps->hw_mode_id) &&
> +		    caps->hw_mode_id != WMI_HOST_HW_MODE_SINGLE)
>   			return 0;
>   	} else {
>   		for (i = 0; i < ab->num_radios; i++) {
> 
> base-commit: 3f257461ab0ab19806bae2bfde4c3cd88dbf050e

