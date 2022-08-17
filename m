Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E76597CCD
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Aug 2022 06:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243048AbiHRERW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Aug 2022 00:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242969AbiHRERP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Aug 2022 00:17:15 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DA49082A
        for <linux-wireless@vger.kernel.org>; Wed, 17 Aug 2022 21:17:13 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27HLRYKk004487;
        Thu, 18 Aug 2022 04:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=X6hVRp9DMi8VBf/VJ9jda9XU4iYMCXLDe+c2+MZseAE=;
 b=XXgIeFXQ1qwVGa8KZhUso0MqYcHPPh+sa1SraXVZyJg3xA0rb7iBMWNMxrmgx7C9BlQe
 Hb7R5f8vLDL0zt8bJOWnX6GaxPdKIH+2Sni9x1BIvka7shOeITOwb3B1mBbnqo/b+wEe
 UvSqoBgPN0wKMiSWwL39Xw0dDWBKmW3ik8pKsxBqVpmaZGPfLuWhOy07S9Sp6DBhvQgK
 Qqz3PQjlNACXFYz/PJF9q+HD7F/4thwvrebARZExwAUCU4fnjnxoD+uAhdnCV9Ci/TFO
 o99YRJILZ59CTlblZdrRlTcLTgtP86lXLW23NtTVVWRbwopru1pIMjPskC1st/u+3LB1 +Q== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j12hhjkp2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 04:16:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27I4Gu0A012160
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 04:16:56 GMT
Received: from [10.110.78.115] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 17 Aug
 2022 16:52:46 -0700
Message-ID: <681e43b3-51c0-ed6c-4607-d60127650283@quicinc.com>
Date:   Wed, 17 Aug 2022 16:52:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 19/50] wifi: ath12k: add hal.c
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>
CC:     <ath12k@lists.infradead.org>
References: <20220812161003.27279-1-kvalo@kernel.org>
 <20220812161003.27279-20-kvalo@kernel.org>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220812161003.27279-20-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YkjPgBSJYuzT4H5jwqMKFf_nSe67yQoS
X-Proofpoint-ORIG-GUID: YkjPgBSJYuzT4H5jwqMKFf_nSe67yQoS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_02,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 mlxscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208180014
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
>   drivers/net/wireless/ath/ath12k/hal.c | 2179 +++++++++++++++++++++++++++++++++
>   1 file changed, 2179 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c

snip

> +static void ath12k_hal_srng_src_hw_init(struct ath12k_base *ab,
> +					struct hal_srng *srng)
> +{

snip

> +	/* interrupt setup */
> +	/* NOTE: IPQ8074 v2 requires the interrupt timer threshold in the
> +	 * unit of 8 usecs instead of 1 usec (as required by v1).

why do we care about IPQ8074 when it isn't supported by this driver?
and where is the 8 us vs 1 us logic anyway?

> +	 */
> +	val = u32_encode_bits(srng->intr_timer_thres_us,
> +			      HAL_TCL1_RING_CONSR_INT_SETUP_IX0_INTR_TMR_THOLD);

snip

> +static void ath12k_hal_srng_update_hp_tp_addr(struct ath12k_base *ab,
> +					      int shadow_cfg_idx,
> +					  enum hal_ring_type ring_type,
> +					  int ring_num)

inconsistent indentation?
snip

> +void ath12k_hal_srng_shadow_update_hp_tp(struct ath12k_base *ab,
> +					 struct hal_srng *srng)
> +{
> +	lockdep_assert_held(&srng->lock);
> +
> +	/* check whether the ring is emptry. Update the shadow

s/emptry/empty/

> +	 * HP only when then ring isn't' empty.
> +	 */
> +	if (srng->ring_dir == HAL_SRNG_DIR_SRC &&
> +	    *srng->u.src_ring.tp_addr != srng->u.src_ring.hp)
> +		ath12k_hal_srng_access_end(ab, srng);
> +}
> +

snip

> +void ath12k_hal_srng_deinit(struct ath12k_base *ab)
> +{
> +	struct ath12k_hal *hal = &ab->hal;
> +
> +	ath12k_hal_unregister_srng_lock_keys(ab);
> +	ath12k_hal_free_cont_rdp(ab);
> +	ath12k_hal_free_cont_wrp(ab);
> +	kfree(hal->srng_config);

perhaps set hal->srng_config = NULL so that there isn't a dangling pointer?

snip
