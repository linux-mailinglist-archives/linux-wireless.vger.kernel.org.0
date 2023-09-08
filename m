Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24F9798963
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Sep 2023 16:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbjIHO7Z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Sep 2023 10:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbjIHO7Y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Sep 2023 10:59:24 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70F41BF1
        for <linux-wireless@vger.kernel.org>; Fri,  8 Sep 2023 07:59:20 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 388EN0SP004450;
        Fri, 8 Sep 2023 14:59:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6D6qYbYpEcf4esNMY6TtZg9WSdLv68TD2EQbp9g4Wzo=;
 b=W1ujV+iuzOK+jKoaO1gYwQgQOG0cq0MaxXOsCD3b2kwPbYqZ8yAD5S875fCl0RMRho3V
 R6MLayhElUbsgeYul5ay8zgZHnZYUsv+XzjVvT8Jio2hC+F6v3Tcy/cDMy/Kx6WBLOAd
 SW1hDPn3egfF6LJOuVOIvyQw1DkPDBW1taMIHgan/BZaF2z23Za037oO57f3Mn1Ne3j4
 NuNhrKLby01OtoV+ueq2FZ1ujhy5PgjXloDmGE0x4+iMZO4Uw2nfFVJHCP/GCQj07Ub2
 CSjL6DCoea/iDpDMYqGCj0QA+oxfsbGWoRxxtA0jW0CULS3CsnS2YNkvhpnqNNjZ6aeA 2A== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t01b50k9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 14:59:14 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 388ExDJX032487
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 8 Sep 2023 14:59:13 GMT
Received: from [10.111.180.119] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 8 Sep
 2023 07:59:13 -0700
Message-ID: <51437508-874e-4e6f-8b6e-89b49e4c9704@quicinc.com>
Date:   Fri, 8 Sep 2023 07:59:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] wifi: ath12k: add 11d scan offload support
Content-Language: en-US
To:     Wen Gong <quic_wgong@quicinc.com>, <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230906082948.18452-1-quic_wgong@quicinc.com>
 <20230906082948.18452-3-quic_wgong@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230906082948.18452-3-quic_wgong@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GVZJ8FIVp1yeQKtwqgj-DTj2B6EwW0L5
X-Proofpoint-ORIG-GUID: GVZJ8FIVp1yeQKtwqgj-DTj2B6EwW0L5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_10,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309080138
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/6/2023 1:29 AM, Wen Gong wrote:
> Add handler for WMI_11D_NEW_COUNTRY_EVENTID, WMI_11D_SCAN_START_CMDID,
> WMI_11D_SCAN_STOP_CMDID.
> 
> The priority of 11d scan WMI_SCAN_PRIORITY_MEDIUM in firmware, the
> priority of hw scan is WMI_SCAN_PRIORITY_LOW, then the 11d scan will
> cancel the hw scan which is running. To avoid this, change the priority
> of the 1st hw scan to WMI_SCAN_PRIORITY_MEDIUM. Add wait_for_completion_timeout
> for ar->scan.completed in ath12k_reg_update_chan_list(), plus the existing
> wait in ath12k_scan_stop(), then ath12k have 2 place to wait the
> ar->scan.completed, they run in different thread, thus it is possible to
> happen that the two threads both enter wait status. To handle this scenario,
> ath12k should change the complete() to complete_all() for the ar->scan.completed,
> this also work well when it is only one thread wait for ar->scan.completed.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath12k/core.c |  35 ++++-
>   drivers/net/wireless/ath/ath12k/core.h |  16 +++
>   drivers/net/wireless/ath/ath12k/mac.c  | 170 ++++++++++++++++++++++++-
>   drivers/net/wireless/ath/ath12k/mac.h  |   7 +
>   drivers/net/wireless/ath/ath12k/reg.c  |  37 +++++-
>   drivers/net/wireless/ath/ath12k/reg.h  |   3 +-
>   drivers/net/wireless/ath/ath12k/wmi.c  | 123 +++++++++++++++++-
>   drivers/net/wireless/ath/ath12k/wmi.h  |  25 ++++
>   8 files changed, 406 insertions(+), 10 deletions(-)

...

> diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
> index 8940b8154091..890063c9e268 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.h
> +++ b/drivers/net/wireless/ath/ath12k/wmi.h
> @@ -3792,6 +3792,28 @@ struct wmi_init_country_cmd {
>   	} cc_info;
>   } __packed;
>   
> +struct wmi_11d_scan_start_params {
> +	u32 vdev_id;
> +	u32 scan_period_msec;
> +	u32 start_interval_msec;
> +};
> +
> +struct wmi_11d_scan_start_cmd {
> +	__le32 tlv_header;
> +	__le32 vdev_id;
> +	__le32 scan_period_msec;
> +	__le32 start_interval_msec;
> +} __packed;
> +
> +struct wmi_11d_scan_stop_cmd {
> +	__le32 tlv_header;
> +	__le32 vdev_id;
> +} __packed;
> +
> +struct wmi_11d_new_cc_ev {

one nit: does not conform to the naming convention:
  * _event means that this is a firmware event sent from firmware to host

> +	__le32 new_alpha2;
> +} __packed;
> +
>   struct wmi_delba_send_cmd {
>   	__le32 tlv_header;
>   	__le32 vdev_id;
> @@ -4897,6 +4919,9 @@ int ath12k_wmi_peer_rx_reorder_queue_setup(struct ath12k *ar,
>   					   dma_addr_t paddr, u8 tid,
>   					   u8 ba_window_size_valid,
>   					   u32 ba_window_size);
> +int ath12k_wmi_send_11d_scan_start_cmd(struct ath12k *ar,
> +				       struct wmi_11d_scan_start_params *param);
> +int ath12k_wmi_send_11d_scan_stop_cmd(struct ath12k *ar, u32 vdev_id);
>   int
>   ath12k_wmi_rx_reord_queue_remove(struct ath12k *ar,
>   				 struct ath12k_wmi_rx_reorder_queue_remove_arg *arg);

