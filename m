Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9136A7DC2F9
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Oct 2023 00:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjJ3XMY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Oct 2023 19:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjJ3XMX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Oct 2023 19:12:23 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51259109
        for <linux-wireless@vger.kernel.org>; Mon, 30 Oct 2023 16:12:20 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UM8Y8S030506;
        Mon, 30 Oct 2023 23:12:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=WKsxlaQLvPcDc5UzVxRMV8mvHwKQYX85CmaXeW37o7I=;
 b=P9HIOCw+fJgSWHgl0tp1AVIBByBF4dNa4Wbh9hMMs/YLOquXZqcoYB1FWFXi5vgnA1TZ
 vgGdcYT9JWMxYqHjGPQ15KFtaUdcl6opF3cc/T+50GmOzIWIEnX0PUZhnx/7dH91Q4zU
 tV1OAcUrF7+28tLQHBsfrVenvQr/mHHiYR1FN22kFl6bU/fFKkTjKrItsDBlz8AX3Zr7
 mcW7WgPF+iyGcanOJrpqwrB6rDG06lM1H2n5u3DM3tgS4AiITH2fDGdL7ClkjNxaL47d
 OPVdQi/miYZTlDRC9a3GIqB6JXjGFtwMCyiYnmQV19UVCSk2D97Ue44Ku02fINdouYm3 Ag== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u2dey19m7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 23:12:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39UNCFNd025180
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 23:12:15 GMT
Received: from [10.48.245.206] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 30 Oct
 2023 16:12:14 -0700
Message-ID: <c7787488-3a2e-406f-96fe-f6bb293fd441@quicinc.com>
Date:   Mon, 30 Oct 2023 16:12:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] wifi: ath12k: indicate NON MBSSID vdev by default
 during vdev start
Content-Language: en-US
To:     Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>,
        <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Sriram R <quic_srirrama@quicinc.com>
References: <20231030222700.18914-1-quic_rajkbhag@quicinc.com>
 <20231030222700.18914-3-quic_rajkbhag@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231030222700.18914-3-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ruO_TKmXQkPFBm8dKtB-ja_woRB1Ok-b
X-Proofpoint-GUID: ruO_TKmXQkPFBm8dKtB-ja_woRB1Ok-b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310240000 definitions=main-2310300182
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/30/2023 3:26 PM, Raj Kumar Bhagat wrote:
> From: Sriram R <quic_srirrama@quicinc.com>
> 
> When any VDEV is started, MBSSID flags are passed to firmware to
> indicate if its a MBSSID/EMA AP vdev. If the interface is not an AP
> or if the AP doesn't support MBSSID, the vdev needs to be brought up
> as a non MBSSID vdev. Set these flags as a non MBSSID AP by default
> which can be updated as and when MBSSID support is added in ath12k.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath12k/mac.c | 5 +++++
>   drivers/net/wireless/ath/ath12k/wmi.c | 1 +
>   drivers/net/wireless/ath/ath12k/wmi.h | 8 ++++++++
>   3 files changed, 14 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index fc0d14ea3..594aa18e7 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -5987,6 +5987,11 @@ ath12k_mac_vdev_start_restart(struct ath12k_vif *arvif,
>   	arg.pref_tx_streams = ar->num_tx_chains;
>   	arg.pref_rx_streams = ar->num_rx_chains;
>   
> +	/* Fill the MBSSID flags to indicate AP is non MBSSID by default
> +	 * Corresponding flags would be updated with MBSSID support.
> +	 */
> +	arg.mbssid_flags = WMI_VDEV_FLAGS_NON_MBSSID_AP;
> +
>   	if (arvif->vdev_type == WMI_VDEV_TYPE_AP) {
>   		arg.ssid = arvif->u.ap.ssid;
>   		arg.ssid_len = arvif->u.ap.ssid_len;
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
> index 0e5bf5ce8..88ec77dee 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.c
> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> @@ -1024,6 +1024,7 @@ int ath12k_wmi_vdev_start(struct ath12k *ar, struct wmi_vdev_start_req_arg *arg,
>   	cmd->regdomain = cpu_to_le32(arg->regdomain);
>   	cmd->he_ops = cpu_to_le32(arg->he_ops);
>   	cmd->punct_bitmap = cpu_to_le32(arg->punct_bitmap);
> +	cmd->mbssid_flags = cpu_to_le32(arg->mbssid_flags);
>   
>   	if (!restart) {
>   		if (arg->ssid) {
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
> index 8e1eda7aa..dfe9eb0cb 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.h
> +++ b/drivers/net/wireless/ath/ath12k/wmi.h
> @@ -2269,6 +2269,14 @@ struct ath12k_wmi_hal_reg_capabilities_ext_arg {
>   	u32 high_5ghz_chan;
>   };
>   
> +enum {
> +	WMI_VDEV_FLAGS_NON_MBSSID_AP       = BIT(0),

only the 1st one is used. do we need the rest at this point?
perhaps add the others as they are needed?

> +	WMI_VDEV_FLAGS_TRANSMIT_AP         = BIT(1),
> +	WMI_VDEV_FLAGS_NON_TRANSMIT_AP     = BIT(2),
> +	WMI_VDEV_FLAGS_EMA_MODE            = BIT(3),
> +	WMI_VDEV_FLAGS_SCAN_MODE_VAP       = BIT(4),

note that "vap" is a non-standard term that ideally should not be used 
in ath12k (although a few references are present)

> +};

these seem to be added at some random place in the file. considering 
that these are applicable to the mbssid_flags in struct 
wmi_vdev_start_request_cmd, I'd suggest:

1) defining the enum just before this struct
2) naming the enum, i.e. wmi_vdev_mbssid_flags
3) using a prefix that matches the name, i.e. 
WMI_VDEV_MBSSID_FLAGS_NON_MBSSID_AP
4) in struct wmi_vdev_start_request_cmd add a comment to:
	__le32 mbssid_flags; /* uses enum wmi_vdev_mbssid_flags */

/jeff
