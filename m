Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89B677667C
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Aug 2023 19:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjHIRcm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Aug 2023 13:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjHIRcm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Aug 2023 13:32:42 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69E68E
        for <linux-wireless@vger.kernel.org>; Wed,  9 Aug 2023 10:32:41 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 379H0Xmi022716;
        Wed, 9 Aug 2023 17:32:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6AHvfRviNYYMLqCQhBtcOKnIbQvezgBEt2zxX8gATyA=;
 b=SyM+Ve0Y3FFSniJO3YNIQjgF6Zh4AIDeaVGJko45sQ55lBVoAU1JLd4U9beIRH/0Cd7n
 IsIFDZqJXbtbx3vgsXX1nxcbm9O031DhVWVup9mXZv0wgGOOjW6Z/xClEqjimW1Pvu5/
 HM7HhdHAzGtAdZYLUkYCUrF1J60SExnfSqxC4r/HYnQtdAZ0iKFXsbMZJeCVEQPcCJIt
 kysKWg4Sng4mKEGlcieJolqttek7DZFBzCI1M1ecKcBI+g9WAsNPXRfcDjEwCbfnYTlR
 tefS6eMFDg2APbxEJs9xFcCkUzeZ7B3J4+ROQ01imx88Nvx24zGD1CtGKJZlqXFOjuE8 Gw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sc00522sh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 17:32:37 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 379HWaZM026475
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 9 Aug 2023 17:32:36 GMT
Received: from [10.111.180.219] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 9 Aug
 2023 10:32:35 -0700
Message-ID: <3d022dad-99b2-0b4e-adab-4ac5147c989c@quicinc.com>
Date:   Wed, 9 Aug 2023 10:32:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath12k: add check max message length while
 scanning with extraie
Content-Language: en-US
To:     Wen Gong <quic_wgong@quicinc.com>, <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230809081657.13858-1-quic_wgong@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230809081657.13858-1-quic_wgong@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fEucNUWo4bI6GhE1lbm15JeNeJ6YWFsp
X-Proofpoint-GUID: fEucNUWo4bI6GhE1lbm15JeNeJ6YWFsp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_14,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 adultscore=0 phishscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308090153
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/9/2023 1:16 AM, Wen Gong wrote:
> Currently the extraie length is directly used to allocate skb buffer. When
> the length of skb is greater than the max message length which firmware
> supports, error will happen in firmware side.
> 
> Hence add check for the skb length and drop extraie when overflow and
> print a message.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>

Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>

> ---
> v2: seperate to another patch per johannes.
> 
>   drivers/net/wireless/ath/ath12k/wmi.c | 20 +++++++++++++-------
>   1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
> index 9ed33e2d6da0..e964d6003ea9 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.c
> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> @@ -2240,12 +2240,6 @@ int ath12k_wmi_send_scan_start_cmd(struct ath12k *ar,
>   	if (arg->num_bssid)
>   		len += sizeof(*bssid) * arg->num_bssid;
>   
> -	len += TLV_HDR_SIZE;
> -	if (arg->extraie.len)
> -		extraie_len_with_pad =
> -			roundup(arg->extraie.len, sizeof(u32));
> -	len += extraie_len_with_pad;
> -
>   	if (arg->num_hint_bssid)
>   		len += TLV_HDR_SIZE +
>   		       arg->num_hint_bssid * sizeof(*hint_bssid);
> @@ -2254,6 +2248,18 @@ int ath12k_wmi_send_scan_start_cmd(struct ath12k *ar,
>   		len += TLV_HDR_SIZE +
>   		       arg->num_hint_s_ssid * sizeof(*s_ssid);
>   
> +	len += TLV_HDR_SIZE;
> +	if (arg->extraie.len)
> +		extraie_len_with_pad =
> +			roundup(arg->extraie.len, sizeof(u32));
> +	if (extraie_len_with_pad <= (wmi->wmi_ab->max_msg_len[ar->pdev_idx] - len)) {
> +		len += extraie_len_with_pad;
> +	} else {
> +		ath12k_warn(ar->ab, "discard large size %d bytes extraie for scan start\n",
> +			    arg->extraie.len);
> +		extraie_len_with_pad = 0;
> +	}
> +
>   	skb = ath12k_wmi_alloc_skb(wmi->wmi_ab, len);
>   	if (!skb)
>   		return -ENOMEM;
> @@ -2343,7 +2349,7 @@ int ath12k_wmi_send_scan_start_cmd(struct ath12k *ar,
>   	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_BYTE, len);
>   	ptr += TLV_HDR_SIZE;
>   
> -	if (arg->extraie.len)
> +	if (extraie_len_with_pad)
>   		memcpy(ptr, arg->extraie.ptr,
>   		       arg->extraie.len);
>   
> 
> base-commit: 3f257461ab0ab19806bae2bfde4c3cd88dbf050e

