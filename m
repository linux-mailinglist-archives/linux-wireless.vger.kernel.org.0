Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45902599139
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Aug 2022 01:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240215AbiHRXei (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Aug 2022 19:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238384AbiHRXeg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Aug 2022 19:34:36 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D701D7CDE
        for <linux-wireless@vger.kernel.org>; Thu, 18 Aug 2022 16:34:34 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27IMpZwb025402;
        Thu, 18 Aug 2022 23:34:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=T0kSSSS0HOQo+PSEsT9YbwAr8wdHWNYEWz81cB1dWvY=;
 b=nQh8p6YVvheeWiBwLkNhnDgb7R8MiJD8Yp29vvGqk5+2YTVhwXTjNz3oPiEWaHrEYLbT
 54Ycah0dcQ7Lkrf1NPQpx9bAWAQPYv4B9pqzCJlH9zjp5Z9hTm2/ujE6HpL6Neclney2
 iv2MZ8jJ+zLD6taWHkWrBty4D/G9Ma0bzAbn113gORRIhvxR6SeOKScPTj2aw6ZizAtc
 cHJAGFSfU47zFzM5ywmLWmRDiP5aYjfhDDzHIdqgkfzsLHzSMcPoddn00fsMSi9qem5T
 /JX2+FAXbIfxov84VzNjB+TagBsx0fN+GrYwaUqXsBGeEEkBtQiL5sNSQYbO4mkiBEWl 5w== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j13c05wgg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 23:34:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27INYRgu019060
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 23:34:27 GMT
Received: from [10.110.11.6] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 18 Aug
 2022 16:34:26 -0700
Message-ID: <c5a1b013-d53a-77b3-eaf8-05b5bbc23b0a@quicinc.com>
Date:   Thu, 18 Aug 2022 16:34:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 37/50] wifi: ath12k: add peer.c
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>
CC:     <ath12k@lists.infradead.org>
References: <20220812161003.27279-1-kvalo@kernel.org>
 <20220812161003.27279-38-kvalo@kernel.org>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220812161003.27279-38-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cMJYFegiPFGILyPcB9C5siktaAab8HDI
X-Proofpoint-GUID: cMJYFegiPFGILyPcB9C5siktaAab8HDI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_16,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208180086
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
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
>   drivers/net/wireless/ath/ath12k/peer.c | 343 +++++++++++++++++++++++++++++++++
>   1 file changed, 343 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/peer.c b/drivers/net/wireless/ath/ath12k/peer.c
> new file mode 100644
> index 000000000000..30ffdbbdcc7f
> --- /dev/null
> +++ b/drivers/net/wireless/ath/ath12k/peer.c
> @@ -0,0 +1,343 @@
> +// SPDX-License-Identifier: BSD-3-Clause-Clear
> +/*
> + * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
> + * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include "core.h"
> +#include "peer.h"
> +#include "debug.h"
> +
> +struct ath12k_peer *ath12k_peer_find(struct ath12k_base *ab, int vdev_id,
> +				     const u8 *addr)
> +{
> +	struct ath12k_peer *peer;
> +
> +	lockdep_assert_held(&ab->base_lock);
> +
> +	list_for_each_entry(peer, &ab->peers, list) {
> +		if (peer->vdev_id != vdev_id)
> +			continue;
> +		if (!ether_addr_equal(peer->addr, addr))
> +			continue;
> +
> +		return peer;
> +	}
> +
> +	return NULL;
> +}
> +
> +static struct ath12k_peer *ath12k_peer_find_by_pdev_idx(struct ath12k_base *ab,
> +							u8 pdev_idx, const u8 *addr)
> +{
> +	struct ath12k_peer *peer;
> +
> +	lockdep_assert_held(&ab->base_lock);
> +
> +	list_for_each_entry(peer, &ab->peers, list) {
> +		if (peer->pdev_idx != pdev_idx)
> +			continue;
> +		if (!ether_addr_equal(peer->addr, addr))
> +			continue;
> +
> +		return peer;
> +	}
> +
> +	return NULL;
> +}
> +
> +struct ath12k_peer *ath12k_peer_find_by_addr(struct ath12k_base *ab,
> +					     const u8 *addr)
> +{
> +	struct ath12k_peer *peer;
> +
> +	lockdep_assert_held(&ab->base_lock);
> +
> +	list_for_each_entry(peer, &ab->peers, list) {
> +		if (!ether_addr_equal(peer->addr, addr))
> +			continue;
> +
> +		return peer;
> +	}
> +
> +	return NULL;
> +}
> +
> +struct ath12k_peer *ath12k_peer_find_by_id(struct ath12k_base *ab,
> +					   int peer_id)
> +{
> +	struct ath12k_peer *peer;
> +
> +	lockdep_assert_held(&ab->base_lock);
> +
> +	list_for_each_entry(peer, &ab->peers, list)
> +		if (peer_id == peer->peer_id)
> +			return peer;
> +
> +	return NULL;
> +}
> +
> +struct ath12k_peer *ath12k_peer_find_by_vdev_id(struct ath12k_base *ab,
> +						int vdev_id)
> +{
> +	struct ath12k_peer *peer;
> +
> +	spin_lock_bh(&ab->base_lock);

the other ath12k_peer_find_*() functions expect the caller to take the 
lock, but in this one the function itself takes the lock. why the 
discrepancy? should these have a consistent interface? note that the 
returned peer won't be protected by the lock.

note i see this is only used in one place, and there it doesn't use the 
peer, it just checks if it exists.

perhaps rename this to bool ath12k_peer_exists_by_vdev() to justify the 
difference in locking?


> +
> +	list_for_each_entry(peer, &ab->peers, list) {
> +		if (vdev_id == peer->vdev_id) {
> +			spin_unlock_bh(&ab->base_lock);
> +			return peer;
> +		}
> +	}
> +	spin_unlock_bh(&ab->base_lock);
> +	return NULL;
> +}

[...]
