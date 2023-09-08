Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3F77989B3
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Sep 2023 17:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244372AbjIHPQO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Sep 2023 11:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240290AbjIHPQO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Sep 2023 11:16:14 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D713E71
        for <linux-wireless@vger.kernel.org>; Fri,  8 Sep 2023 08:16:09 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 388DgDQV007105;
        Fri, 8 Sep 2023 15:16:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=GgYk4JXeuoN4g+vS9YWqPG+6KcyHqWsj3XhCDJYYaew=;
 b=bYmxxj2F/rekeyzr2ltHjc+a8xR3NoOOzBkzELzRdf/5JRxuHPm1sZyggf6K7zlKIeEO
 C0ZPF9BiSY1fQsxUDDv/EACh4TJ0gKaWe6cCANHbZPFrDtXnmXZ9arLEZAtt5+J8ObaR
 YKxJjmNkhVSSqvaiehplv5YQ8BiiGC/os0vIbZZuQ2yqrBAknU6Q59rVPSxrd68L+8FM
 9tsAWtYgc0eveqeeqcfJxgbNYJqhn/Ia5Q/ax92r9acRE7Pa96q+aEgeaC0uJzbR15YJ
 P1xaM4s0HiOp4f2rjVCct7oMz/Xiysk3OwCR8aefv2ko8/piWp5JnBdWJye1gDIEKsbh 0w== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t023wrk4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 15:16:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 388FG4ht018899
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 8 Sep 2023 15:16:04 GMT
Received: from [10.111.180.119] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 8 Sep
 2023 08:16:03 -0700
Message-ID: <8b2a0893-c866-42f6-8567-e70bcadbc6c1@quicinc.com>
Date:   Fri, 8 Sep 2023 08:16:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] wifi: ath12k: add configure country code for WCN7850
Content-Language: en-US
To:     Wen Gong <quic_wgong@quicinc.com>, <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230906082948.18452-1-quic_wgong@quicinc.com>
 <20230906082948.18452-2-quic_wgong@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230906082948.18452-2-quic_wgong@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hP71YJkU6AwPH9QmzwVqNHCm4U7Jf0p8
X-Proofpoint-ORIG-GUID: hP71YJkU6AwPH9QmzwVqNHCm4U7Jf0p8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_12,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309080141
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/6/2023 1:29 AM, Wen Gong wrote:
> Add handler to send WMI_SET_CURRENT_COUNTRY_CMDID to firmware which
> is used for WCN7850.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath12k/wmi.c | 36 +++++++++++++++++++++++++++
>   drivers/net/wireless/ath/ath12k/wmi.h | 13 ++++++++++
>   2 files changed, 49 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
> index 9ed33e2d6da0..aa87b559eff1 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.c
> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> @@ -2844,6 +2844,42 @@ int ath12k_wmi_send_init_country_cmd(struct ath12k *ar,
>   	return ret;
>   }
>   
> +int ath12k_wmi_send_set_current_country_cmd(struct ath12k *ar,
> +					    struct wmi_set_current_country_params *param)
> +{
> +	struct ath12k_wmi_pdev *wmi = ar->wmi;
> +	struct wmi_set_current_country_cmd *cmd;
> +	struct sk_buff *skb;
> +	int ret;
> +
> +	skb = ath12k_wmi_alloc_skb(wmi->wmi_ab, sizeof(*cmd));
> +	if (!skb)
> +		return -ENOMEM;
> +
> +	cmd = (struct wmi_set_current_country_cmd *)skb->data;
> +	cmd->tlv_header =
> +		ath12k_wmi_tlv_cmd_hdr(WMI_TAG_SET_CURRENT_COUNTRY_CMD,
> +				       sizeof(*cmd));
> +
> +	cmd->pdev_id = cpu_to_le32(ar->pdev->pdev_id);
> +	memcpy(&cmd->new_alpha2, &param->alpha2, 3);
> +	ret = ath12k_wmi_cmd_send(wmi, skb, WMI_SET_CURRENT_COUNTRY_CMDID);
> +
> +	ath12k_dbg(ar->ab, ATH12K_DBG_WMI,
> +		   "set current country pdev id %d alpha2 %c%c\n",
> +		   ar->pdev->pdev_id,
> +		   param->alpha2[0],
> +		   param->alpha2[1]);
> +
> +	if (ret) {
> +		ath12k_warn(ar->ab,
> +			    "failed to send WMI_SET_CURRENT_COUNTRY_CMDID: %d\n", ret);
> +		dev_kfree_skb(skb);
> +	}
> +
> +	return ret;
> +}
> +
>   int
>   ath12k_wmi_send_twt_enable_cmd(struct ath12k *ar, u32 pdev_id)
>   {
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
> index 8c047a9623f9..8940b8154091 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.h
> +++ b/drivers/net/wireless/ath/ath12k/wmi.h
> @@ -3749,6 +3749,16 @@ struct ath12k_wmi_ap_ps_arg {
>   	u32 value;
>   };
>   
> +struct wmi_set_current_country_params {
> +	u8 alpha2[3];

having looked though the set of patches, I'm curious why this is [3] and 
not [2] (or IMO more correctly, [REG_ALPHA2_LEN]).
Isn't this read/written as two octets everywhere and never treated as a 
NUL-terminated string?

> +};
> +
> +struct wmi_set_current_country_cmd {
> +	__le32 tlv_header;
> +	__le32 pdev_id;
> +	__le32 new_alpha2;
> +} __packed;
> +
>   enum set_init_cc_type {
>   	WMI_COUNTRY_INFO_TYPE_ALPHA,
>   	WMI_COUNTRY_INFO_TYPE_COUNTRY_CODE,
> @@ -4879,6 +4889,9 @@ int ath12k_wmi_send_bcn_offload_control_cmd(struct ath12k *ar,
>   					    u32 vdev_id, u32 bcn_ctrl_op);
>   int ath12k_wmi_send_init_country_cmd(struct ath12k *ar,
>   				     struct ath12k_wmi_init_country_arg *arg);
> +int
> +ath12k_wmi_send_set_current_country_cmd(struct ath12k *ar,
> +					struct wmi_set_current_country_params *param);
>   int ath12k_wmi_peer_rx_reorder_queue_setup(struct ath12k *ar,
>   					   int vdev_id, const u8 *addr,
>   					   dma_addr_t paddr, u8 tid,

