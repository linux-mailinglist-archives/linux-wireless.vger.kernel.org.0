Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95ECC78045D
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Aug 2023 05:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357521AbjHRDYG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Aug 2023 23:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357602AbjHRDX7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Aug 2023 23:23:59 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BEC3C0E
        for <linux-wireless@vger.kernel.org>; Thu, 17 Aug 2023 20:23:47 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RRnFV061PzFqjS;
        Fri, 18 Aug 2023 11:20:46 +0800 (CST)
Received: from [10.174.179.215] (10.174.179.215) by
 canpemm500007.china.huawei.com (7.192.104.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 18 Aug 2023 11:23:45 +0800
Subject: Re: [PATCH] wifi: ath12k: Remove unused declarations
To:     Jeff Johnson <quic_jjohnson@quicinc.com>, <kvalo@kernel.org>
CC:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20230816130550.50896-1-yuehaibing@huawei.com>
 <e8b1cbce-3139-a922-85ee-970756027d87@quicinc.com>
From:   Yue Haibing <yuehaibing@huawei.com>
Message-ID: <9200f152-8443-5c86-97f3-41e722ab7f1f@huawei.com>
Date:   Fri, 18 Aug 2023 11:23:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <e8b1cbce-3139-a922-85ee-970756027d87@quicinc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2023/8/16 22:31, Jeff Johnson wrote:
> On 8/16/2023 6:05 AM, Yue Haibing wrote:
>> Commit d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
>> declared but never implemented these, remove it.
> 
> Note that the ath12k driver is under active development, and due to the manner in which this driver was originally upstreamed (staring with just core functionality) it is very possible that prototypes are present in the current upstream code that are not currently being used, but which will be used in the future.
> 
> However, since there are currently no implementations, it seems logical to remove them for now. They can always be added back when the implementations are provided.
> 
> And for four of these ath11k also has unused prototypes, so feel free to submit a patch for those.

Thanks, this is done in https://patchwork.kernel.org/project/linux-wireless/patch/20230811104413.33668-1-yuehaibing@huawei.com

> 
> Further details below
> 
>>
>> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> 
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> 
>> ---
>>   drivers/net/wireless/ath/ath12k/ce.h   | 3 ---
>>   drivers/net/wireless/ath/ath12k/core.h | 1 -
>>   drivers/net/wireless/ath/ath12k/qmi.h  | 2 --
>>   drivers/net/wireless/ath/ath12k/wmi.h  | 2 --
>>   4 files changed, 8 deletions(-)
> 
> 
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/ce.h b/drivers/net/wireless/ath/ath12k/ce.h
>> index 17cf16235e0b..79af3b6159f1 100644
>> --- a/drivers/net/wireless/ath/ath12k/ce.h
>> +++ b/drivers/net/wireless/ath/ath12k/ce.h
>> @@ -176,9 +176,6 @@ int ath12k_ce_alloc_pipes(struct ath12k_base *ab);
>>   void ath12k_ce_free_pipes(struct ath12k_base *ab);
>>   int ath12k_ce_get_attr_flags(struct ath12k_base *ab, int ce_id);
>>   void ath12k_ce_poll_send_completed(struct ath12k_base *ab, u8 pipe_id);
>> -int ath12k_ce_map_service_to_pipe(struct ath12k_base *ab, u16 service_id,
>> -                  u8 *ul_pipe, u8 *dl_pipe);
>> -int ath12k_ce_attr_attach(struct ath12k_base *ab);
> 
> These were inherited from ath11k, and are unused there as well. These can go. Also feel free to submit a similar patch for ath11k
> 
>>   void ath12k_ce_get_shadow_config(struct ath12k_base *ab,
>>                    u32 **shadow_cfg, u32 *shadow_cfg_len);
>>   #endif
>> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
>> index 4389ff40b49d..d873b573dac6 100644
>> --- a/drivers/net/wireless/ath/ath12k/core.h
>> +++ b/drivers/net/wireless/ath/ath12k/core.h
>> @@ -788,7 +788,6 @@ int ath12k_core_fetch_board_data_api_1(struct ath12k_base *ab,
>>   int ath12k_core_fetch_bdf(struct ath12k_base *ath12k,
>>                 struct ath12k_board_data *bd);
>>   void ath12k_core_free_bdf(struct ath12k_base *ab, struct ath12k_board_data *bd);
>> -int ath12k_core_check_dt(struct ath12k_base *ath12k);
> 
> This was inherited from ath11k, and it is in use there.
> I'm not sure if the underlying functionality will be required on ath12k, but if so, the prototype can be added back when the function implementation is added. So this can be removed
> 
>>     void ath12k_core_halt(struct ath12k *ar);
>>   int ath12k_core_resume(struct ath12k_base *ab);
>> diff --git a/drivers/net/wireless/ath/ath12k/qmi.h b/drivers/net/wireless/ath/ath12k/qmi.h
>> index df76149c49f5..15944f5f33ab 100644
>> --- a/drivers/net/wireless/ath/ath12k/qmi.h
>> +++ b/drivers/net/wireless/ath/ath12k/qmi.h
>> @@ -562,8 +562,6 @@ struct qmi_wlanfw_wlan_cfg_resp_msg_v01 {
>>   int ath12k_qmi_firmware_start(struct ath12k_base *ab,
>>                     u32 mode);
>>   void ath12k_qmi_firmware_stop(struct ath12k_base *ab);
>> -void ath12k_qmi_event_work(struct work_struct *work);
>> -void ath12k_qmi_msg_recv_work(struct work_struct *work);
> 
> These were inherited from ath11k, and are unused there as well. These can go. Also feel free to submit a similar patch for ath11k
> 
>>   void ath12k_qmi_deinit_service(struct ath12k_base *ab);
>>   int ath12k_qmi_init_service(struct ath12k_base *ab);
>>   diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
>> index 8c047a9623f9..c75a6fa1f7e0 100644
>> --- a/drivers/net/wireless/ath/ath12k/wmi.h
>> +++ b/drivers/net/wireless/ath/ath12k/wmi.h
>> @@ -4855,8 +4855,6 @@ int ath12k_wmi_vdev_install_key(struct ath12k *ar,
>>                   struct wmi_vdev_install_key_arg *arg);
>>   int ath12k_wmi_pdev_bss_chan_info_request(struct ath12k *ar,
>>                         enum wmi_bss_chan_info_req_type type);
>> -int ath12k_wmi_send_stats_request_cmd(struct ath12k *ar, u32 stats_id,
>> -                      u32 vdev_id, u32 pdev_id);
> 
> This was inherited from ath11k, and it is in use there.
> I expect this API will be implemented in the future since it is used by the DebugFS code which is not yet present. That said, the prototype can be added back when the function implementation is added. So this can be removed
> 
> 
>>   int ath12k_wmi_send_pdev_temperature_cmd(struct ath12k *ar);
>>   int ath12k_wmi_send_peer_flush_tids_cmd(struct ath12k *ar,
>>                       u8 peer_addr[ETH_ALEN],
> 
> .
