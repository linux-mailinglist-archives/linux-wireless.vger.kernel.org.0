Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631E377E39E
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Aug 2023 16:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343595AbjHPOcT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Aug 2023 10:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245404AbjHPOcM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Aug 2023 10:32:12 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FF3271F
        for <linux-wireless@vger.kernel.org>; Wed, 16 Aug 2023 07:32:04 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37GC8URe016793;
        Wed, 16 Aug 2023 14:31:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=jwMHsnumhiM5iIO6GefpbZ6p/tzVbuBW5JsEh/NMYIM=;
 b=jb++5KwJE6bgWwTsiG4jgS4BqbTz2pXlJPEjOuQ3Odp02rcVN1NaXN4O3I//wU6+esSt
 ftbOH+qdmpTWZxLrFstRfY8OPQNOOF5pDleVA8eyaQ5lAvxhr9ZSzL6WbpCkRvcpVc48
 TAaKzuS3QgoXmggmBdnuy9wEx4mETTrQ0QEFH6WBipRnX3YGI+p6UZckFruZ1ZBmZvrd
 GpokHPvWQn3S3+H6nshO7y08sm+STv0rKZ1CPdY2Z69OmUQgFqEJNyJEzcA/xwSzymgH
 droWPYMUz0GUiY7bzp3IWe0yXswsXRWwN3uVz67Bq6fEMo2eVr4X5Tkq519PcYu5DSos AA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sgnje1ab1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 14:31:47 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37GEVl1D018969
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 14:31:47 GMT
Received: from [10.48.240.144] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 16 Aug
 2023 07:31:46 -0700
Message-ID: <e8b1cbce-3139-a922-85ee-970756027d87@quicinc.com>
Date:   Wed, 16 Aug 2023 07:31:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Remove unused declarations
Content-Language: en-US
To:     Yue Haibing <yuehaibing@huawei.com>, <kvalo@kernel.org>
CC:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20230816130550.50896-1-yuehaibing@huawei.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230816130550.50896-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3AN0QtSUJI4l4bLrjleyGTnuQaQa4UkG
X-Proofpoint-ORIG-GUID: 3AN0QtSUJI4l4bLrjleyGTnuQaQa4UkG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_14,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 mlxlogscore=729 spamscore=0 mlxscore=0 impostorscore=0 suspectscore=0
 clxscore=1011 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308160125
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/16/2023 6:05 AM, Yue Haibing wrote:
> Commit d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> declared but never implemented these, remove it.

Note that the ath12k driver is under active development, and due to the 
manner in which this driver was originally upstreamed (staring with just 
core functionality) it is very possible that prototypes are present in 
the current upstream code that are not currently being used, but which 
will be used in the future.

However, since there are currently no implementations, it seems logical 
to remove them for now. They can always be added back when the 
implementations are provided.

And for four of these ath11k also has unused prototypes, so feel free to 
submit a patch for those.

Further details below

> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

> ---
>   drivers/net/wireless/ath/ath12k/ce.h   | 3 ---
>   drivers/net/wireless/ath/ath12k/core.h | 1 -
>   drivers/net/wireless/ath/ath12k/qmi.h  | 2 --
>   drivers/net/wireless/ath/ath12k/wmi.h  | 2 --
>   4 files changed, 8 deletions(-)


> 
> diff --git a/drivers/net/wireless/ath/ath12k/ce.h b/drivers/net/wireless/ath/ath12k/ce.h
> index 17cf16235e0b..79af3b6159f1 100644
> --- a/drivers/net/wireless/ath/ath12k/ce.h
> +++ b/drivers/net/wireless/ath/ath12k/ce.h
> @@ -176,9 +176,6 @@ int ath12k_ce_alloc_pipes(struct ath12k_base *ab);
>   void ath12k_ce_free_pipes(struct ath12k_base *ab);
>   int ath12k_ce_get_attr_flags(struct ath12k_base *ab, int ce_id);
>   void ath12k_ce_poll_send_completed(struct ath12k_base *ab, u8 pipe_id);
> -int ath12k_ce_map_service_to_pipe(struct ath12k_base *ab, u16 service_id,
> -				  u8 *ul_pipe, u8 *dl_pipe);
> -int ath12k_ce_attr_attach(struct ath12k_base *ab);

These were inherited from ath11k, and are unused there as well. These 
can go. Also feel free to submit a similar patch for ath11k

>   void ath12k_ce_get_shadow_config(struct ath12k_base *ab,
>   				 u32 **shadow_cfg, u32 *shadow_cfg_len);
>   #endif
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index 4389ff40b49d..d873b573dac6 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -788,7 +788,6 @@ int ath12k_core_fetch_board_data_api_1(struct ath12k_base *ab,
>   int ath12k_core_fetch_bdf(struct ath12k_base *ath12k,
>   			  struct ath12k_board_data *bd);
>   void ath12k_core_free_bdf(struct ath12k_base *ab, struct ath12k_board_data *bd);
> -int ath12k_core_check_dt(struct ath12k_base *ath12k);

This was inherited from ath11k, and it is in use there.
I'm not sure if the underlying functionality will be required on ath12k, 
but if so, the prototype can be added back when the function 
implementation is added. So this can be removed

>   
>   void ath12k_core_halt(struct ath12k *ar);
>   int ath12k_core_resume(struct ath12k_base *ab);
> diff --git a/drivers/net/wireless/ath/ath12k/qmi.h b/drivers/net/wireless/ath/ath12k/qmi.h
> index df76149c49f5..15944f5f33ab 100644
> --- a/drivers/net/wireless/ath/ath12k/qmi.h
> +++ b/drivers/net/wireless/ath/ath12k/qmi.h
> @@ -562,8 +562,6 @@ struct qmi_wlanfw_wlan_cfg_resp_msg_v01 {
>   int ath12k_qmi_firmware_start(struct ath12k_base *ab,
>   			      u32 mode);
>   void ath12k_qmi_firmware_stop(struct ath12k_base *ab);
> -void ath12k_qmi_event_work(struct work_struct *work);
> -void ath12k_qmi_msg_recv_work(struct work_struct *work);

These were inherited from ath11k, and are unused there as well. These 
can go. Also feel free to submit a similar patch for ath11k

>   void ath12k_qmi_deinit_service(struct ath12k_base *ab);
>   int ath12k_qmi_init_service(struct ath12k_base *ab);
>   
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
> index 8c047a9623f9..c75a6fa1f7e0 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.h
> +++ b/drivers/net/wireless/ath/ath12k/wmi.h
> @@ -4855,8 +4855,6 @@ int ath12k_wmi_vdev_install_key(struct ath12k *ar,
>   				struct wmi_vdev_install_key_arg *arg);
>   int ath12k_wmi_pdev_bss_chan_info_request(struct ath12k *ar,
>   					  enum wmi_bss_chan_info_req_type type);
> -int ath12k_wmi_send_stats_request_cmd(struct ath12k *ar, u32 stats_id,
> -				      u32 vdev_id, u32 pdev_id);

This was inherited from ath11k, and it is in use there.
I expect this API will be implemented in the future since it is used by 
the DebugFS code which is not yet present. That said, the prototype can 
be added back when the function implementation is added. So this can be 
removed


>   int ath12k_wmi_send_pdev_temperature_cmd(struct ath12k *ar);
>   int ath12k_wmi_send_peer_flush_tids_cmd(struct ath12k *ar,
>   					u8 peer_addr[ETH_ALEN],

