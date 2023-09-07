Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19C8796FCB
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Sep 2023 07:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbjIGFLP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Sep 2023 01:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjIGFLP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Sep 2023 01:11:15 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CA3CF9
        for <linux-wireless@vger.kernel.org>; Wed,  6 Sep 2023 22:11:11 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38740iQR000349;
        Thu, 7 Sep 2023 05:11:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=NkgTf100L4BOAJr3olFLS/P1LzhLfZm+gIIir/FI3PA=;
 b=LFCSIp0TJMA37Ot4MTajyoVA/jUzZOBI8x6C40+CiM847gbkjqMZKqH83zpbH3IqJaum
 Z2705S1bFPWlmDfMOR8WzCyjeoCQ257sxzy+DBkB09I6439itUsH8t1suRYa9treM1RB
 20APHQNo8s9vhqW5YKjQGXl4iN0IYiIKi7gRCdOgkEUFKTa9HIkg9mMNdfxiUnCTBK8I
 l0I0spW90yK8bLWyCp26cCTk6agtMjXU0uQTpV6Y6aDS3CmGV8+PXKUZXi1o6Z8005Fb
 EhcB7ki6gUSvSLG6Q2OxbdO7aNEZoeGFTu3HDigSIbLfdKs34HxQPlC6XHZUZWntFskl 2g== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sxq23agaq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 05:11:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3875B7O5007584
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Sep 2023 05:11:07 GMT
Received: from [10.111.180.119] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 6 Sep
 2023 22:11:07 -0700
Message-ID: <51377366-584d-4854-ab30-552e15100dee@quicinc.com>
Date:   Wed, 6 Sep 2023 22:11:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] wifi: ath12k: add band edge channel power for WCN7850
Content-Language: en-US
To:     Lingbo Kong <quic_lingbok@quicinc.com>,
        <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230905024904.3882-1-quic_lingbok@quicinc.com>
 <20230905024904.3882-5-quic_lingbok@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230905024904.3882-5-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YpmCBb3FzDSRsceIbSdVg0GLiKCqyXn2
X-Proofpoint-GUID: YpmCBb3FzDSRsceIbSdVg0GLiKCqyXn2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_12,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=998 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309070044
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/4/2023 7:49 PM, Lingbo Kong wrote:
> ath12k need to retrieve band edge channel power table by invoking ACPI _DSM
> method, then pass the table to firmware.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath12k/acpi.c | 29 ++++++++++++++++++
>   drivers/net/wireless/ath/ath12k/acpi.h |  6 +++-
>   drivers/net/wireless/ath/ath12k/core.h |  1 +
>   drivers/net/wireless/ath/ath12k/wmi.c  | 41 ++++++++++++++++++++++++++
>   drivers/net/wireless/ath/ath12k/wmi.h  |  3 ++
>   5 files changed, 79 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/acpi.c b/drivers/net/wireless/ath/ath12k/acpi.c
> index a9931e17bd17..389b900df170 100644
> --- a/drivers/net/wireless/ath/ath12k/acpi.c
> +++ b/drivers/net/wireless/ath/ath12k/acpi.c
> @@ -82,6 +82,16 @@ static int ath12k_acpi_dsm_get_data(struct ath12k_base *ab, int func)
>   			memcpy(&ab->acdata->cca_data, obj->buffer.pointer,
>   			       obj->buffer.length);
>   			break;
> +		case ATH12K_ACPI_DSM_FUNC_INDEX_BAND_EDGE:
> +			if (obj->buffer.length != ATH12K_ACPI_DSM_BAND_EDGE_DATA_SIZE) {
> +				ath12k_err(ab, "Invalid BAND EDGE data size %d\n",
> +					   obj->buffer.length);
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +			memcpy(&ab->acdata->band_edge_power, obj->buffer.pointer,
> +			       obj->buffer.length);
> +			break;
>   		}
>   	} else {
>   		ath12k_err(ab,
> @@ -311,6 +321,25 @@ int ath12k_get_acpi_all_data(struct ath12k_base *ab)
>   		}
>   	}
>   
> +	if (ATH12K_ACPI_FUNC_BIT_VALID(ab->acdata, ATH12K_ACPI_FUNC_BIT_BAND_EDGE_CHAN_POWER)) {
> +		ret = ath12k_acpi_dsm_get_data(ab,
> +					       ATH12K_ACPI_DSM_FUNC_INDEX_BAND_EDGE);
> +		if (ret) {
> +			ath12k_err(ab, "failed to get band edge channel power %d\n", ret);
> +			goto err_free_acdata;
> +		}
> +
> +		if (ab->acdata->band_edge_power[0] == ATH12K_ACPI_BAND_EDGE_VERSION &&
> +		    ab->acdata->band_edge_power[1] == ATH12K_ACPI_BAND_EDGE_ENABLE_FLAG) {
> +			ret = ath12k_wmi_pdev_set_band_edge_power(ab,
> +								  ab->acdata->band_edge_power);
> +			if (ret) {
> +				ath12k_err(ab, "set band edge channel power failed %d\n", ret);
> +				goto err_free_acdata;
> +			}
> +		}
> +	}
> +
>   	status = acpi_install_notify_handler(ACPI_HANDLE(ab->dev),
>   					     ACPI_DEVICE_NOTIFY,
>   					     acpi_dsm_notify, ab);
> diff --git a/drivers/net/wireless/ath/ath12k/acpi.h b/drivers/net/wireless/ath/ath12k/acpi.h
> index acdf8d851fba..1acfd7696dfc 100644
> --- a/drivers/net/wireless/ath/ath12k/acpi.h
> +++ b/drivers/net/wireless/ath/ath12k/acpi.h
> @@ -14,18 +14,21 @@
>   #define ATH12K_ACPI_DSM_FUNC_INDEX_BIOS_SAR		4
>   #define ATH12K_ACPI_DSM_FUNC_INDEX_GEO_OFFSET		5
>   #define ATH12K_ACPI_DSM_FUNC_INDEX_CCA			6
> +#define ATH12K_ACPI_DSM_FUNC_INDEX_BAND_EDGE		10
>   
>   #define ATH12K_ACPI_DSM_TAS_CFG_SIZE			108
>   #define ATH12K_ACPI_DSM_TAS_DATA_SIZE			69
>   #define ATH12K_ACPI_DSM_BIOS_SAR_DATA_SIZE		34
>   #define ATH12K_ACPI_DSM_GEO_OFFSET_DATA_SIZE		19
>   #define ATH12K_ACPI_DSM_CCA_DATA_SIZE			41
> +#define ATH12K_ACPI_DSM_BAND_EDGE_DATA_SIZE		100
>   
>   #define ATH12K_ACPI_FUNC_BIT_BIOS_SAR			BIT(3)
>   #define ATH12K_ACPI_FUNC_BIT_GEO_OFFSET			BIT(4)
>   #define ATH12K_ACPI_FUNC_BIT_CCA			BIT(5)
>   #define ATH12K_ACPI_FUNC_BIT_TAS_CFG			BIT(7)
>   #define ATH12K_ACPI_FUNC_BIT_TAS_DATA			BIT(8)
> +#define ATH12K_ACPI_FUNC_BIT_BAND_EDGE_CHAN_POWER	BIT(9)
>   
>   #define ATH12K_ACPI_NOTIFY_EVENT			0x86
>   #define ATH12K_ACPI_FUNC_BIT_VALID(_acdata, _func)	((((_acdata)->func_bit) & (_func)) != 0)
> @@ -44,7 +47,8 @@
>   #define ATH12K_ACPI_CCA_THR_ENABLE_FLAG		0x1
>   #define ATH12K_ACPI_CCA_THR_OFFSET_LEN		36
>   #define ATH12K_ACPI_CCA_THR_OFFSET_DATA_OFFSET	5
> -
> +#define ATH12K_ACPI_BAND_EDGE_VERSION		0x1
> +#define ATH12K_ACPI_BAND_EDGE_ENABLE_FLAG	0x1
>   
>   int ath12k_get_acpi_all_data(struct ath12k_base *ab);
>   void acpi_dsm_notify(acpi_handle handle, u32 event, void *data);
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index d57e2013b0fe..d06c3984aef9 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -781,6 +781,7 @@ struct ath12k_base {
>   		u8 bios_sar_data[ATH12K_ACPI_DSM_BIOS_SAR_DATA_SIZE];
>   		u8 geo_offset_data[ATH12K_ACPI_DSM_GEO_OFFSET_DATA_SIZE];
>   		u8 cca_data[ATH12K_ACPI_DSM_CCA_DATA_SIZE];
> +		u8 band_edge_power[ATH12K_ACPI_DSM_BAND_EDGE_DATA_SIZE];
>   	} *acdata;
>   
>   	/* must be last */
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
> index 3f66807b7961..345bdd50adb2 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.c
> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> @@ -7113,3 +7113,44 @@ int ath12k_wmi_pdev_set_cca_thr_table_param(struct ath12k_base *ab,
>   	}
>   	return ret;
>   }
> +
> +int ath12k_wmi_pdev_set_band_edge_power(struct ath12k_base *ab,
> +					const u8 *pchan_table)
> +{
> +	struct ath12k_wmi_base *wmi_ab = &ab->wmi_ab;
> +	struct wmi_pdev_set_bios_interface_cmd *cmd;
> +	struct wmi_tlv *tlv;
> +	struct sk_buff *skb;
> +	int ret;
> +	u8 *buf_ptr;
> +	u32 len, len_aligned;
> +
> +	len_aligned = roundup(ATH12K_ACPI_DSM_BAND_EDGE_DATA_SIZE, sizeof(u32));
> +	len = sizeof(*cmd) + TLV_HDR_SIZE + len_aligned;
> +
> +	skb = ath12k_wmi_alloc_skb(wmi_ab, len);
> +	if (!skb)
> +		return -ENOMEM;
> +
> +	cmd = (struct wmi_pdev_set_bios_interface_cmd *)skb->data;
> +	cmd->tlv_header =
> +		cpu_to_le32(ath12k_wmi_tlv_cmd_hdr(WMI_TAG_PDEV_SET_BIOS_INTERFACE_CMD_PARAMS,

remove cpu_to_le32()

> +						   sizeof(*cmd)));
> +	cmd->pdev_id = cpu_to_le32(WMI_PDEV_ID_SOC);
> +	cmd->param_type_id = cpu_to_le32(WMI_BIOS_PARAM_TYPE_BANDEDGE_CTL_POWER);
> +	cmd->length = cpu_to_le32(ATH12K_ACPI_DSM_BAND_EDGE_DATA_SIZE);
> +
> +	buf_ptr = skb->data + sizeof(*cmd);
> +	tlv = (struct wmi_tlv *)buf_ptr;
> +	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_BYTE, len_aligned);
> +	buf_ptr += TLV_HDR_SIZE;
> +	memcpy(buf_ptr, pchan_table, ATH12K_ACPI_DSM_BAND_EDGE_DATA_SIZE);
> +
> +	ret = ath12k_wmi_cmd_send(&wmi_ab->wmi[0], skb, WMI_PDEV_SET_BIOS_INTERFACE_CMDID);
> +	if (ret) {
> +		ath12k_warn(ab, "failed to send WMI_PDEV_SET_BIOS_INTERFACE_CMDID %d\n", ret);
> +		dev_kfree_skb(skb);
> +	}
> +
> +	return ret;
> +}
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
> index 7607cd7ab699..73d790d405cd 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.h
> +++ b/drivers/net/wireless/ath/ath12k/wmi.h
> @@ -4808,6 +4808,7 @@ enum bios_param_type {
>   	WMI_BIOS_PARAM_CCA_THRESHOLD_TYPE	=	0,
>   	WMI_BIOS_PARAM_TAS_CONFIG_TYPE		=	1,
>   	WMI_BIOS_PARAM_TAS_DATA_TYPE		=	2,
> +	WMI_BIOS_PARAM_TYPE_BANDEDGE_CTL_POWER	=	3,
>   	WMI_BIOS_PARAM_TYPE_MAX,
>   };
>   
> @@ -4955,4 +4956,6 @@ int ath12k_wmi_pdev_set_bios_geo_table_param(struct ath12k_base *ab,
>   					     u8 *pgeo_table);
>   int ath12k_wmi_pdev_set_cca_thr_table_param(struct ath12k_base *ab,
>   					    u8 *pcca_table);
> +int ath12k_wmi_pdev_set_band_edge_power(struct ath12k_base *ab,
> +					const u8 *pchan_table);
>   #endif

