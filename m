Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D0159469C
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Aug 2022 01:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352317AbiHOW7X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Aug 2022 18:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245413AbiHOW5d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Aug 2022 18:57:33 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1C3753B8
        for <linux-wireless@vger.kernel.org>; Mon, 15 Aug 2022 12:56:14 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27FJGs94013672;
        Mon, 15 Aug 2022 19:55:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=CeTh6pYdJ5DfG5Gt9a3Hy+5vdGO5mweCdbpBGJrOBHk=;
 b=fMTSOjlDVYSR6MQwS+/Rxof5HeFYFTVGTdfkWL9JeDn9QL5q4FcnDMtbVMhiunQmnZtV
 aboeXA7KjKI0CosO4QXgyQ3uXbdXH222XwMnk9WjMR61fhgu2JRd0PUrPFcNdHV/9s7C
 BFtArc/KJrnnvnsF+q66LaI2PETpJPfw45+tev/DbkMSrWoVN6/c/NIrgACScq8AznZJ
 51sSV6fhgEhrSSlMgFdz0n4sq5CRaYQAs/o8xWrpsWgDWNEjUqkIungjPnX3ErofVp0z
 7FyWqhDXChohsv5KPwNjXy/aGUFufpC07A9sL2IraSzwVS4vpqH3JXtWeg/Jx4X29Uu6 7A== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hx58f66p4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 19:55:59 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27FJtxUL022585
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 19:55:59 GMT
Received: from [10.110.78.115] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 15 Aug
 2022 12:55:58 -0700
Message-ID: <d9403714-d7ef-3a7c-0448-e5b2b0a60c34@quicinc.com>
Date:   Mon, 15 Aug 2022 12:55:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 07/50] wifi: ath12k: add dbring.c
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>
CC:     <ath12k@lists.infradead.org>
References: <20220812161003.27279-1-kvalo@kernel.org>
 <20220812161003.27279-8-kvalo@kernel.org>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220812161003.27279-8-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6HBKM-7X986xxwtaCFIEIv8MuAAk4nhQ
X-Proofpoint-GUID: 6HBKM-7X986xxwtaCFIEIv8MuAAk4nhQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_08,2022-08-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 adultscore=0 bulkscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=940 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208150076
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
>   drivers/net/wireless/ath/ath12k/dbring.c | 356 +++++++++++++++++++++++++++++++
>   1 file changed, 356 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/dbring.c b/drivers/net/wireless/ath/ath12k/dbring.c
> new file mode 100644
> index 000000000000..92824c0f245e
> --- /dev/null
> +++ b/drivers/net/wireless/ath/ath12k/dbring.c

snip

> +static int ath12k_dbring_fill_bufs(struct ath12k *ar,
> +				   struct ath12k_dbring *ring,
> +				   gfp_t gfp)
> +{
> +	struct ath12k_dbring_element *buff;
> +	struct hal_srng *srng;
> +	int num_remain, req_entries, num_free;
> +	u32 align;
> +	int size, ret;
> +
> +	srng = &ar->ab->hal.srng_list[ring->refill_srng.ring_id];

there are several references to ar->ab in this function.
suggest being consistent with ath12k_dbring_bufs_replenish() and define:
	struct ath12k_base *ab = ar->ab;
and then s/ar->ab/ab/ in those accesses

this suggestion applies to other functions below since there are 
multiple functions which have multiple ar->ab dereferences

> +
> +	spin_lock_bh(&srng->lock);
> +
> +	num_free = ath12k_hal_srng_src_num_free(ar->ab, srng, true);
> +	req_entries = min(num_free, ring->bufs_max);
> +	num_remain = req_entries;
> +	align = ring->buf_align;
> +	size = sizeof(*buff) + ring->buf_sz + align - 1;
> +
> +	while (num_remain > 0) {
> +		buff = kzalloc(size, gfp);
> +		if (!buff)
> +			break;
> +
> +		ret = ath12k_dbring_bufs_replenish(ar, ring, buff, gfp);
> +		if (ret) {
> +			ath12k_warn(ar->ab, "failed to replenish db ring num_remain %d req_ent %d\n",
> +				    num_remain, req_entries);
> +			kfree(buff);
> +			break;
> +		}
> +		num_remain--;
> +	}
> +
> +	spin_unlock_bh(&srng->lock);
> +
> +	return num_remain;
> +}
> +

snip

> +int ath12k_dbring_buf_setup(struct ath12k *ar,
> +			    struct ath12k_dbring *ring,
> +			    struct ath12k_dbring_cap *db_cap)
> +{
> +	struct ath12k_base *ab = ar->ab;
> +	struct hal_srng *srng;
> +	int ret;
> +
> +	srng = &ab->hal.srng_list[ring->refill_srng.ring_id];
> +	ring->bufs_max = ring->refill_srng.size /
> +		ath12k_hal_srng_get_entrysize(ab, HAL_RXDMA_DIR_BUF);
> +
> +	ring->buf_sz = db_cap->min_buf_sz;
> +	ring->buf_align = db_cap->min_buf_align;
> +	ring->pdev_id = db_cap->pdev_id;
> +	ring->hp_addr = ath12k_hal_srng_get_hp_addr(ar->ab, srng);
> +	ring->tp_addr = ath12k_hal_srng_get_tp_addr(ar->ab, srng);

s/ar->ab/ab/ in both of the above since you already have ab = ar->ab

> +
> +	ret = ath12k_dbring_fill_bufs(ar, ring, GFP_KERNEL);
> +
> +	return ret;
> +}
