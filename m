Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0983D596659
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Aug 2022 02:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238075AbiHQAh0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Aug 2022 20:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238071AbiHQAhY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Aug 2022 20:37:24 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2D5923C4
        for <linux-wireless@vger.kernel.org>; Tue, 16 Aug 2022 17:37:16 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27GNSaux020235;
        Wed, 17 Aug 2022 00:37:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=y81cjkN+/y7I79zdn2eXvOkWrpupcI4sxkAdlBDlyo0=;
 b=GSnaVEmTj2dTey2R3RAy5CjxC4mU8REYOdYMx0I6Z5sg8q9ZXIkj8WDryv1ucJDsbEzc
 sdjsz4LbYmcvEVXCZYVlVeMaOXR9wZBdumAcmuNMZHEBBhfQQU0AAMlyDoNz69wsOtvT
 BjaDnsIRT5bgfPNpJxstu1vMYxXd9Z1UCI5igRUj/S6+9Of1bkp1WVhr0k7/CEwKfeks
 1gsrhaZ/lYw95630NjJsK1/fjggb3E0gB/eWXpLPF7fWAszW521MdTkgKBQS7igmd8bl
 02e4aDwPuIclDvtrzTMGJK+cYkxCMfUY1m2Xo48K4gXULx9Ldxb7WrRjcSxip0dBsc9R EQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j01w0vedk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 00:37:05 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27H0b4iE019027
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 00:37:04 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 16 Aug 2022 17:37:04 -0700
Received: from [10.110.78.115] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 16 Aug
 2022 17:37:03 -0700
Message-ID: <576a0720-fe45-36bd-abd1-b772dbe380b0@quicinc.com>
Date:   Tue, 16 Aug 2022 17:37:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 15/50] wifi: ath12k: add dp_rx.c
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>
CC:     <ath12k@lists.infradead.org>
References: <20220812161003.27279-1-kvalo@kernel.org>
 <20220812161003.27279-16-kvalo@kernel.org>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220812161003.27279-16-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: oPtYrkNBob7cO_CVA93XmtJIe-UPdR2e
X-Proofpoint-GUID: oPtYrkNBob7cO_CVA93XmtJIe-UPdR2e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-16_08,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxscore=0 malwarescore=0 spamscore=0 suspectscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 mlxlogscore=863 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208170000
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
>   drivers/net/wireless/ath/ath12k/dp_rx.c | 4308 +++++++++++++++++++++++++++++++
>   1 file changed, 4308 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c

snip

> +static u16 ath12k_dp_rx_h_frag_no(struct ath12k_base *ab,
> +				  struct sk_buff *skb)
> +{
> +	struct ieee80211_hdr *hdr;
> +
> +	hdr = (struct ieee80211_hdr *)(skb->data + ab->hw_params->hal_desc_sz);
> +	return le16_to_cpu(hdr->seq_ctrl) & IEEE80211_SCTL_FRAG;

should there be an ieee80211.h function for this? we already have:
ieee80211_is_first_frag()
ieee80211_is_frag()

> +}

snip

> +static int ath12k_dp_purge_mon_ring(struct ath12k_base *ab)
> +{
> +	int i, reaped = 0;
> +	unsigned long timeout = jiffies + msecs_to_jiffies(DP_MON_PURGE_TIMEOUT_MS);
> +
> +	do {
> +		for (i = 0; i < ab->hw_params->num_rxmda_per_pdev; i++)
> +			reaped += ath12k_dp_mon_process_ring(ab, i, NULL,
> +							     DP_MON_SERVICE_BUDGET,
> +							     ATH12K_DP_RX_MONITOR_MODE);
> +
> +		/* nothing more to reap */
> +		if (reaped < DP_MON_SERVICE_BUDGET)
> +			return 0;
> +
> +	} while (time_before(jiffies, timeout));

i'm very confused by this loop.
1) 'reaped' is only initialized at the begining of the function.
2) inside the loop the first time we call ath12k_dp_mon_process_ring() 
'reaped' will be the # of packets reaped in that first iteration.
3) if this is < DP_MON_SERVICE_BUDGET then we will exit the function.
4) if this is >= DP_MON_SERVICE_BUDGET then we will loop again. in all 
of the subsequent iterations 'reaped' will be increased by the number of 
packets reaped (which could be 0!!!), and that ongoing sum will always 
be >= DP_MON_SERVICE_BUDGET (at least until we wrap the counter!!) and 
hence even if we don't reap any packets in the subsequent calls we will 
continue to loop until we exceed the timeout.

So it seems that 'reaped' should be initialized to 0 inside the do loop.

In addition it seems strange to have a budget but then not defer 
additional processing, i.e. yield(), if you use up the budget.

> +
> +	ath12k_warn(ab, "dp mon ring purge timeout");
> +
> +	return -ETIMEDOUT;
> +}
> +
> +/* Returns number of Rx buffers replenished */
> +int ath12k_dp_rx_bufs_replenish(struct ath12k_base *ab, int mac_id,
> +				struct dp_rxdma_ring *rx_ring,
> +				int req_entries,
> +				enum hal_rx_buf_return_buf_manager mgr,
> +				bool hw_cc)
> +{
> +	struct ath12k_buffer_addr *desc;
> +	struct hal_srng *srng;
> +	struct sk_buff *skb;
> +	int num_free;
> +	int num_remain;
> +	int buf_id;
> +	u32 cookie;
> +	dma_addr_t paddr;
> +	struct ath12k_dp *dp = &ab->dp;
> +	struct ath12k_rx_desc_info *rx_desc;
> +
> +	req_entries = min(req_entries, rx_ring->bufs_max);
> +
> +	srng = &ab->hal.srng_list[rx_ring->refill_buf_ring.ring_id];
> +
> +	spin_lock_bh(&srng->lock);
> +
> +	ath12k_hal_srng_access_begin(ab, srng);
> +
> +	num_free = ath12k_hal_srng_src_num_free(ab, srng, true);
> +	if (!req_entries && (num_free > (rx_ring->bufs_max * 3) / 4))
> +		req_entries = num_free;
> +
> +	req_entries = min(num_free, req_entries);
> +	num_remain = req_entries;
> +
> +	while (num_remain > 0) {
> +		skb = dev_alloc_skb(DP_RX_BUFFER_SIZE +
> +				    DP_RX_BUFFER_ALIGN_SIZE);
> +		if (!skb)
> +			break;
> +
> +		if (!IS_ALIGNED((unsigned long)skb->data,
> +				DP_RX_BUFFER_ALIGN_SIZE)) {
> +			skb_pull(skb,
> +				 PTR_ALIGN(skb->data, DP_RX_BUFFER_ALIGN_SIZE) -
> +				 skb->data);
> +		}
> +
> +		paddr = dma_map_single(ab->dev, skb->data,
> +				       skb->len + skb_tailroom(skb),
> +				       DMA_FROM_DEVICE);
> +		if (dma_mapping_error(ab->dev, paddr))
> +			goto fail_free_skb;
> +
> +		if (hw_cc) {

hw_cc is a very cryptic name. is there a better name for this?
presumably this has something to do with hardware giving us unique 
cookies so we don't have idr overhead?

> +			spin_lock_bh(&dp->rx_desc_lock);
> +
> +			/* Get desc from free list and store in used list
> +			 * for cleanup purposes
> +			 *
> +			 * TODO: pass the removed descs rather than
> +			 * add/read to optimize
> +			 */
> +			rx_desc = list_first_entry_or_null(&dp->rx_desc_free_list,
> +							   struct ath12k_rx_desc_info,
> +							   list);
> +			if (!rx_desc) {
> +				spin_unlock_bh(&dp->rx_desc_lock);
> +				goto fail_dma_unmap;
> +			}
> +
> +			rx_desc->skb = skb;
> +			cookie = rx_desc->cookie;
> +			list_del(&rx_desc->list);
> +			list_add_tail(&rx_desc->list, &dp->rx_desc_used_list);
> +
> +			spin_unlock_bh(&dp->rx_desc_lock);
> +		} else {
> +			spin_lock_bh(&rx_ring->idr_lock);
> +			buf_id = idr_alloc(&rx_ring->bufs_idr, skb, 0,
> +					   rx_ring->bufs_max * 3, GFP_ATOMIC);
> +			spin_unlock_bh(&rx_ring->idr_lock);
> +			if (buf_id < 0)
> +				goto fail_idr_remove;
> +			cookie = u32_encode_bits(mac_id,
> +						 DP_RXDMA_BUF_COOKIE_PDEV_ID) |
> +				 u32_encode_bits(buf_id,
> +						 DP_RXDMA_BUF_COOKIE_BUF_ID);
> +		}
> +
> +		desc = ath12k_hal_srng_src_get_next_entry(ab, srng);
> +		if (!desc)
> +			goto fail_list_desc_add;
> +
> +		ATH12K_SKB_RXCB(skb)->paddr = paddr;
> +
> +		num_remain--;
> +
> +		ath12k_hal_rx_buf_addr_info_set(desc, paddr, cookie, mgr);
> +	}
> +
> +	ath12k_hal_srng_access_end(ab, srng);
> +
> +	spin_unlock_bh(&srng->lock);
> +
> +	return req_entries - num_remain;
> +
> +fail_list_desc_add:
> +	if (hw_cc) {
> +		spin_lock_bh(&dp->rx_desc_lock);
> +		list_del(&rx_desc->list);
> +		list_add_tail(&rx_desc->list, &dp->rx_desc_free_list);
> +		rx_desc->skb = NULL;
> +		spin_unlock_bh(&dp->rx_desc_lock);
> +	}
> +fail_idr_remove:

should the idr_remove logic be if (!hw_cc) since it will only be added 
above in the if (hw_cc) else path?

> +	spin_lock_bh(&rx_ring->idr_lock);
> +	idr_remove(&rx_ring->bufs_idr, buf_id);
> +	spin_unlock_bh(&rx_ring->idr_lock);
> +fail_dma_unmap:
> +	dma_unmap_single(ab->dev, paddr, skb->len + skb_tailroom(skb),
> +			 DMA_FROM_DEVICE);
> +fail_free_skb:
> +	dev_kfree_skb_any(skb);
> +
> +	ath12k_hal_srng_access_end(ab, srng);
> +
> +	spin_unlock_bh(&srng->lock);
> +
> +	return req_entries - num_remain;
> +}

I've only reviewed up to this point, but want to checkpoint my review 
for the workday.
