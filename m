Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F43D597D55
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Aug 2022 06:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243269AbiHREWV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Aug 2022 00:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243246AbiHREWG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Aug 2022 00:22:06 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF9040BC3
        for <linux-wireless@vger.kernel.org>; Wed, 17 Aug 2022 21:22:05 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27I3eQfR024636;
        Thu, 18 Aug 2022 04:21:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=sDt2pUVvNL5NMH1DaPKU/BL8yWNQQkSCTpehVEGOdwY=;
 b=YGlt+mRX1e37guteY1oMCFd97CkoPsjYzt9beCltzLcabwhL04s7/JWC3CSY0FHaj1DH
 el39lNcqOqvAQbpBZ0qE1mPFW/1HAt3ggimzz752+CyWD+k/IuBTHkgOHBrDuC2XKd6p
 zm8VED4rCvAQ3sgtzJo8rrnDxki4aKkrKPM4DQul7VzSR9wBKvYB47rloRpF3hMwmI+6
 6f9QCBYDfm19c/x6ySrQofEz/obdujzfa/tU3NpJnoa93adyDkT09dL9iQE92J6xzbCn
 cesGUJzFDMeWMkBnNPTdxrb4/mWrktjN1RMPSJZxRGh0B8XdvuUTBLMke77f63koPZF1 0w== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j0w7hm452-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 04:21:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27I4Gu0F012160
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 04:16:57 GMT
Received: from [10.110.78.115] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 17 Aug
 2022 12:25:26 -0700
Message-ID: <4b5421a2-f111-b7f2-4eeb-6404e8f390d6@quicinc.com>
Date:   Wed, 17 Aug 2022 12:25:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 38/50] wifi: ath12k: add peer.h
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>
CC:     <ath12k@lists.infradead.org>
References: <20220812161003.27279-1-kvalo@kernel.org>
 <20220812161003.27279-39-kvalo@kernel.org>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220812161003.27279-39-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: J_cgEeO4wdv-dPvDnSx8NP_PJijxEX1x
X-Proofpoint-GUID: J_cgEeO4wdv-dPvDnSx8NP_PJijxEX1x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_02,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 mlxlogscore=999 suspectscore=0 spamscore=0 impostorscore=0 adultscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208180014
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/12/2022 9:09 AM, Kalle Valo wrote:
> From: Kalle Valo <quic_kvalo@quicinc.com>
> 
> (Patches split into one patch per file for easier review, but the final
> commit will be one big patch. See the cover letter for more info.)
> 
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath12k/peer.h | 69 ++++++++++++++++++++++++++++++++++
>   1 file changed, 69 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/peer.h b/drivers/net/wireless/ath/ath12k/peer.h
> new file mode 100644
> index 000000000000..d0346e8b1b60
> --- /dev/null
> +++ b/drivers/net/wireless/ath/ath12k/peer.h
> @@ -0,0 +1,69 @@
> +/* SPDX-License-Identifier: BSD-3-Clause-Clear */
> +/*
> + * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
> + * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef ATH12K_PEER_H
> +#define ATH12K_PEER_H
> +
> +#include "dp_rx.h"
> +
> +struct ppdu_user_delayba {
> +	u8 reserved0;
> +	u16 sw_peer_id;
> +	u32 info0;
> +	u16 ru_end;
> +	u16 ru_start;
> +	u32 info1;
> +	u32 rate_flags;
> +	u32 resp_rate_flags;
> +} __packed;

(reviewing this out of order since I saw strange usage in dp_rx.c review)

the above struct seems to be a host-only struct that is only written by 
ath12k_copy_to_delay_stats() and only read by ath12k_copy_to_bar(). 
Therefore use of __packed seems unnecessary, especially since due to the 
layout that will cause many members to be unaligned. In addition the 
reserved0 member is not used, and since this is a host-only struct, is 
unnecessary.

an alternative implementation would be to use the actual hardware 
definition here, struct htt_ppdu_stats_user_rate, and then functions 
ath12k_copy_to_delay_stats() and ath12k_copy_to_bar() could be simple 
struct assignments.

> +
> +struct ath12k_peer {
> +	struct list_head list;
> +	struct ieee80211_sta *sta;
> +	int vdev_id;
> +	u8 addr[ETH_ALEN];
> +	int peer_id;
> +	u16 ast_hash;
> +	u8 pdev_idx;
> +	u16 hw_peer_id;
> +
> +	/* protected by ab->data_lock */
> +	struct ieee80211_key_conf *keys[WMI_MAX_KEY_INDEX + 1];
> +	struct ath12k_dp_rx_tid rx_tid[IEEE80211_NUM_TIDS + 1];
> +
> +	/* Info used in MMIC verification of
> +	 * RX fragments
> +	 */
> +	struct crypto_shash *tfm_mmic;
> +	u8 mcast_keyidx;
> +	u8 ucast_keyidx;
> +	u16 sec_type;
> +	u16 sec_type_grp;
> +	struct ppdu_user_delayba ppdu_stats_delayba;
> +	bool delayba_flag;
> +	bool is_authorized;
> +};
> +
> +void ath12k_peer_unmap_event(struct ath12k_base *ab, u16 peer_id);
> +void ath12k_peer_map_event(struct ath12k_base *ab, u8 vdev_id, u16 peer_id,
> +			   u8 *mac_addr, u16 ast_hash, u16 hw_peer_id);
> +struct ath12k_peer *ath12k_peer_find(struct ath12k_base *ab, int vdev_id,
> +				     const u8 *addr);
> +struct ath12k_peer *ath12k_peer_find_by_addr(struct ath12k_base *ab,
> +					     const u8 *addr);
> +struct ath12k_peer *ath12k_peer_find_by_id(struct ath12k_base *ab, int peer_id);
> +void ath12k_peer_cleanup(struct ath12k *ar, u32 vdev_id);
> +int ath12k_peer_delete(struct ath12k *ar, u32 vdev_id, u8 *addr);
> +int ath12k_peer_create(struct ath12k *ar, struct ath12k_vif *arvif,
> +		       struct ieee80211_sta *sta,
> +		       struct ath12k_wmi_peer_create_arg *arg);
> +int ath12k_wait_for_peer_delete_done(struct ath12k *ar, u32 vdev_id,
> +				     const u8 *addr);
> +struct ath12k_peer *ath12k_peer_find_by_vdev_id(struct ath12k_base *ab,
> +						int vdev_id);
> +struct ath12k_peer *ath12k_peer_find_by_ast(struct ath12k_base *ab, int ast_hash);
> +
> +#endif /* _PEER_H_ */
> 

