Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61225597CE3
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Aug 2022 06:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243069AbiHRERZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Aug 2022 00:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242791AbiHRERS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Aug 2022 00:17:18 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2925391D14
        for <linux-wireless@vger.kernel.org>; Wed, 17 Aug 2022 21:17:15 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27HKJlOL031903;
        Thu, 18 Aug 2022 04:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=iT9X7SXwayF9xOqopb7/1nsUrmz+VNVpTOA1ND2aswc=;
 b=LDuVXj8NghJF90+pnM45BKyVysbZI6PXxZORvOcsrfEHzMvPiZyqdOWhf4GuUx+qSQ/U
 S0le9YCPysy/M+dJYkVpcc0ID0RK0jDknxs1ThVR+BNOlaXmxdR0zSEST9tGme7gpEcI
 HEhWirh4p21Ra06FnsRQ0WY0YKBAkI7vrrDfsXEHQD5whyu6BAg78ydBfVgJc2ePCltn
 0+MsQRN4yzLOOjCzmhenIZ/fmdYuW9OrbwmS3cbpvdTr1u8Aa02aB3aa6qqWFIWlL2aW
 aYLoDZjSUiXYK/uBTWrlpsVwCNaFlcqjc/LTgIZwHnx63N1ZDbGJZnKbBMOFt+3LZUqY Mg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j0w7hm3pd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 04:16:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27I4Gu0K012160
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 04:16:57 GMT
Received: from [10.110.78.115] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 17 Aug
 2022 16:19:31 -0700
Message-ID: <b2cd5b02-60ca-c788-af71-9f36f6a8ede3@quicinc.com>
Date:   Wed, 17 Aug 2022 16:19:30 -0700
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
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: n0gse20sMfB8NDqoXeaehShhsdG2Jk3q
X-Proofpoint-GUID: n0gse20sMfB8NDqoXeaehShhsdG2Jk3q
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
>   drivers/net/wireless/ath/ath12k/dp_rx.c | 4308 +++++++++++++++++++++++++++++++
>   1 file changed, 4308 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c

review part 2
snip

> +static int ath12k_dp_rx_pdev_srng_alloc(struct ath12k *ar)
> +{
> +	struct ath12k_pdev_dp *dp = &ar->dp;
> +	struct ath12k_base *ab = ar->ab;
> +	int i;
> +	int ret;
> +	u32 mac_id = dp->mac_id;
> +
> +	if (!ar->ab->hw_params->rxdma1_enable) {
> +		/* init mon status buffer reap timer */
> +		timer_setup(&ar->ab->mon_reap_timer,
> +			    ath12k_dp_service_mon_ring, 0);
> +		return 0;
> +	}

the timer_setup() seems like strange logic to have in a function named 
ath12k_dp_rx_pdev_srng_alloc() -- that doesn't have anything to do with 
srng allocation

perhaps that should be in a separate properly-named function?

snip

> +static void ath12k_dp_reo_cmd_free(struct ath12k_dp *dp, void *ctx,
> +				   enum hal_reo_cmd_status status)
> +{
> +	struct ath12k_dp_rx_tid *rx_tid = ctx;
> +
> +	if (status != HAL_REO_CMD_SUCCESS)
> +		ath12k_warn(dp->ab, "failed to flush rx tid hw desc, tid %d status %d\n",
> +			    rx_tid->tid, status);
> +
> +	dma_unmap_single(dp->ab->dev, rx_tid->paddr, rx_tid->size,
> +			 DMA_BIDIRECTIONAL);
> +	kfree(rx_tid->vaddr);

you don't want to set rx_tid->vaddr = NULL so that there isn't a 
dangling pointer?

> +}
> +
> +static int ath12k_dp_reo_cmd_send(struct ath12k_base *ab, struct ath12k_dp_rx_tid *rx_tid,
> +				  enum hal_reo_cmd_type type,
> +				  struct ath12k_hal_reo_cmd *cmd,
> +				  void (*cb)(struct ath12k_dp *dp, void *ctx,
> +					     enum hal_reo_cmd_status status))
> +{
> +	struct ath12k_dp *dp = &ab->dp;
> +	struct ath12k_dp_rx_reo_cmd *dp_cmd;
> +	struct hal_srng *cmd_ring;
> +	int cmd_num;
> +
> +	cmd_ring = &ab->hal.srng_list[dp->reo_cmd_ring.ring_id];
> +	cmd_num = ath12k_hal_reo_cmd_send(ab, cmd_ring, type, cmd);
> +
> +	/* cmd_num should start from 1, during failure return the error code */
> +	if (cmd_num < 0)
> +		return cmd_num;
> +
> +	/* reo cmd ring descriptors has cmd_num starting from 1 */
> +	if (cmd_num == 0)
> +		return -EINVAL;
> +
> +	if (!cb)
> +		return 0;
> +
> +	/* Can this be optimized so that we keep the pending command list only
> +	 * for tid delete command to free up the resoruce on the command status

s/resoruce/resource/

> +	 * indication?
> +	 */
> +	dp_cmd = kzalloc(sizeof(*dp_cmd), GFP_ATOMIC);
> +
> +	if (!dp_cmd)
> +		return -ENOMEM;
> +
> +	memcpy(&dp_cmd->data, rx_tid, sizeof(struct ath12k_dp_rx_tid));

sizeof(*rx_tid) is preferred

> +	dp_cmd->cmd_num = cmd_num;
> +	dp_cmd->handler = cb;
> +
> +	spin_lock_bh(&dp->reo_cmd_lock);
> +	list_add_tail(&dp_cmd->list, &dp->reo_cmd_list);
> +	spin_unlock_bh(&dp->reo_cmd_lock);
> +
> +	return 0;
> +}
> +
> +static void ath12k_dp_reo_cache_flush(struct ath12k_base *ab,
> +				      struct ath12k_dp_rx_tid *rx_tid)
> +{
> +	struct ath12k_hal_reo_cmd cmd = {0};
> +	unsigned long tot_desc_sz, desc_sz;
> +	int ret;
> +
> +	tot_desc_sz = rx_tid->size;
> +	desc_sz = ath12k_hal_reo_qdesc_size(0, HAL_DESC_REO_NON_QOS_TID);
> +
> +	while (tot_desc_sz > desc_sz) {
> +		tot_desc_sz -= desc_sz;
> +		cmd.addr_lo = lower_32_bits(rx_tid->paddr + tot_desc_sz);
> +		cmd.addr_hi = upper_32_bits(rx_tid->paddr);
> +		ret = ath12k_dp_reo_cmd_send(ab, rx_tid,
> +					     HAL_REO_CMD_FLUSH_CACHE, &cmd,
> +					     NULL);
> +		if (ret)
> +			ath12k_warn(ab,
> +				    "failed to send HAL_REO_CMD_FLUSH_CACHE, tid %d (%d)\n",
> +				    rx_tid->tid, ret);
> +	}
> +
> +	memset(&cmd, 0, sizeof(cmd));
> +	cmd.addr_lo = lower_32_bits(rx_tid->paddr);
> +	cmd.addr_hi = upper_32_bits(rx_tid->paddr);
> +	cmd.flag |= HAL_REO_CMD_FLG_NEED_STATUS;

why |= instead of just =? flag will always be 0 at this point

> +	ret = ath12k_dp_reo_cmd_send(ab, rx_tid,
> +				     HAL_REO_CMD_FLUSH_CACHE,
> +				     &cmd, ath12k_dp_reo_cmd_free);
> +	if (ret) {
> +		ath12k_err(ab, "failed to send HAL_REO_CMD_FLUSH_CACHE cmd, tid %d (%d)\n",
> +			   rx_tid->tid, ret);
> +		dma_unmap_single(ab->dev, rx_tid->paddr, rx_tid->size,
> +				 DMA_BIDIRECTIONAL);
> +		kfree(rx_tid->vaddr);

you don't want to set rx_tid->vaddr = NULL so that there isn't a 
dangling pointer?

> +	}
> +}
> +
> +static void ath12k_dp_rx_tid_del_func(struct ath12k_dp *dp, void *ctx,
> +				      enum hal_reo_cmd_status status)
> +{
> +	struct ath12k_base *ab = dp->ab;
> +	struct ath12k_dp_rx_tid *rx_tid = ctx;
> +	struct ath12k_dp_rx_reo_cache_flush_elem *elem, *tmp;
> +
> +	if (status == HAL_REO_CMD_DRAIN) {
> +		goto free_desc;
> +	} else if (status != HAL_REO_CMD_SUCCESS) {
> +		/* Shouldn't happen! Cleanup in case of other failure? */
> +		ath12k_warn(ab, "failed to delete rx tid %d hw descriptor %d\n",
> +			    rx_tid->tid, status);
> +		return;
> +	}
> +
> +	elem = kzalloc(sizeof(*elem), GFP_ATOMIC);
> +	if (!elem)
> +		goto free_desc;
> +
> +	elem->ts = jiffies;
> +	memcpy(&elem->data, rx_tid, sizeof(*rx_tid));
> +
> +	spin_lock_bh(&dp->reo_cmd_lock);
> +	list_add_tail(&elem->list, &dp->reo_cmd_cache_flush_list);
> +	dp->reo_cmd_cache_flush_count++;
> +
> +	/* Flush and invalidate aged REO desc from HW cache */
> +	list_for_each_entry_safe(elem, tmp, &dp->reo_cmd_cache_flush_list,
> +				 list) {
> +		if (dp->reo_cmd_cache_flush_count > ATH12K_DP_RX_REO_DESC_FREE_THRES ||
> +		    time_after(jiffies, elem->ts +
> +			       msecs_to_jiffies(ATH12K_DP_RX_REO_DESC_FREE_TIMEOUT_MS))) {
> +			list_del(&elem->list);
> +			dp->reo_cmd_cache_flush_count--;
> +			spin_unlock_bh(&dp->reo_cmd_lock);
> +
> +			ath12k_dp_reo_cache_flush(ab, &elem->data);
> +			kfree(elem);
> +			spin_lock_bh(&dp->reo_cmd_lock);

is this really a safe iteration if you unlock & lock in the middle?
what prevents the tmp node from being deleted during this window?

> +		}
> +	}
> +	spin_unlock_bh(&dp->reo_cmd_lock);
> +
> +	return;
> +free_desc:
> +	dma_unmap_single(ab->dev, rx_tid->paddr, rx_tid->size,
> +			 DMA_BIDIRECTIONAL);
> +	kfree(rx_tid->vaddr);

you don't want to set rx_tid->vaddr = NULL so that there isn't a 
dangling pointer?

> +}

snip

> +void ath12k_dp_rx_peer_tid_delete(struct ath12k *ar,
> +				  struct ath12k_peer *peer, u8 tid)
> +{
> +	struct ath12k_hal_reo_cmd cmd = {0};
> +	struct ath12k_dp_rx_tid *rx_tid = &peer->rx_tid[tid];
> +	int ret;
> +
> +	if (!rx_tid->active)
> +		return;
> +
> +	cmd.flag = HAL_REO_CMD_FLG_NEED_STATUS;
> +	cmd.addr_lo = lower_32_bits(rx_tid->paddr);
> +	cmd.addr_hi = upper_32_bits(rx_tid->paddr);
> +	cmd.upd0 |= HAL_REO_CMD_UPD0_VLD;

why |= instead of just =?

> +	ret = ath12k_dp_reo_cmd_send(ar->ab, rx_tid,
> +				     HAL_REO_CMD_UPDATE_RX_QUEUE, &cmd,
> +				     ath12k_dp_rx_tid_del_func);
> +	if (ret) {
> +		ath12k_err(ar->ab, "failed to send HAL_REO_CMD_UPDATE_RX_QUEUE cmd, tid %d (%d)\n",
> +			   tid, ret);
> +		dma_unmap_single(ar->ab->dev, rx_tid->paddr, rx_tid->size,
> +				 DMA_BIDIRECTIONAL);
> +		kfree(rx_tid->vaddr);

you don't want to set rx_tid->vaddr = NULL so that there isn't a 
dangling pointer?

> +	}
> +
> +	ath12k_peer_rx_tid_qref_reset(ar->ab, peer->peer_id, tid);
> +
> +	rx_tid->active = false;
> +}

snip

> +int ath12k_dp_rx_peer_tid_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_id,
> +				u8 tid, u32 ba_win_sz, u16 ssn,
> +				enum hal_pn_type pn_type)
> +{
> +	struct ath12k_base *ab = ar->ab;
> +	struct ath12k_dp *dp = &ab->dp;
> +	struct hal_rx_reo_queue *addr_aligned;
> +	struct ath12k_peer *peer;
> +	struct ath12k_dp_rx_tid *rx_tid;
> +	u32 hw_desc_sz;
> +	void *vaddr;
> +	dma_addr_t paddr;
> +	int ret;
> +
> +	spin_lock_bh(&ab->base_lock);
> +
> +	peer = ath12k_peer_find(ab, vdev_id, peer_mac);
> +	if (!peer) {
> +		spin_unlock_bh(&ab->base_lock);
> +		ath12k_warn(ab, "failed to find the peer to set up rx tid\n");

should you log the peer_mac?

snip

> +int ath12k_dp_rx_peer_pn_replay_config(struct ath12k_vif *arvif,
> +				       const u8 *peer_addr,
> +				       enum set_key_cmd key_cmd,
> +				       struct ieee80211_key_conf *key)
> +{
> +	struct ath12k *ar = arvif->ar;
> +	struct ath12k_base *ab = ar->ab;
> +	struct ath12k_hal_reo_cmd cmd = {0};
> +	struct ath12k_peer *peer;
> +	struct ath12k_dp_rx_tid *rx_tid;
> +	u8 tid;
> +	int ret = 0;
> +
> +	/* NOTE: Enable PN/TSC replay check offload only for unicast frames.
> +	 * We use mac80211 PN/TSC replay check functionality for bcast/mcast
> +	 * for now.
> +	 */
> +	if (!(key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
> +		return 0;
> +
> +	cmd.flag |= HAL_REO_CMD_FLG_NEED_STATUS;
> +	cmd.upd0 |= HAL_REO_CMD_UPD0_PN |

why |= instead of just = for both of the above?

> +		    HAL_REO_CMD_UPD0_PN_SIZE |
> +		    HAL_REO_CMD_UPD0_PN_VALID |
> +		    HAL_REO_CMD_UPD0_PN_CHECK |
> +		    HAL_REO_CMD_UPD0_SVLD;
> +
> +	switch (key->cipher) {
> +	case WLAN_CIPHER_SUITE_TKIP:
> +	case WLAN_CIPHER_SUITE_CCMP:
> +	case WLAN_CIPHER_SUITE_CCMP_256:
> +	case WLAN_CIPHER_SUITE_GCMP:
> +	case WLAN_CIPHER_SUITE_GCMP_256:
> +		if (key_cmd == SET_KEY) {
> +			cmd.upd1 |= HAL_REO_CMD_UPD1_PN_CHECK;
> +			cmd.pn_size = 48;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	spin_lock_bh(&ab->base_lock);
> +
> +	peer = ath12k_peer_find(ab, arvif->vdev_id, peer_addr);
> +	if (!peer) {
> +		ath12k_warn(ab, "failed to find the peer to configure pn replay detection\n");


should you log the peer_addr?

also it is preferable to unlock first, and then log

snip

> +static int ath12k_get_ppdu_user_index(struct htt_ppdu_stats *ppdu_stats,
> +				      u16 peer_id)
> +{
> +	int i;
> +
> +	for (i = 0; i < HTT_PPDU_STATS_MAX_USERS - 1; i++) {
> +		if (ppdu_stats->user_stats[i].is_valid_peer_id) {
> +			if (peer_id == ppdu_stats->user_stats[i].peer_id)
> +				return i;
> +		} else {
> +			return i;
> +		}

is the user_stats[] array maintained in a manner where the 
"is_valid_peer_id" records are always at the beginning of the array?

if not, then don't you have an issue if entry 0 has is_valid_peer_id = 
false and entry 1 has is_valid_peer_id = true and peer_id is matching 
since in that case you'd return 0 instead of 1?

> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int ath12k_htt_tlv_ppdu_stats_parse(struct ath12k_base *ab,
> +					   u16 tag, u16 len, const void *ptr,
> +					   void *data)
> +{
> +	struct htt_ppdu_stats_info *ppdu_info;
> +	struct htt_ppdu_user_stats *user_stats;
> +	int cur_user;
> +	u16 peer_id;
> +
> +	ppdu_info = (struct htt_ppdu_stats_info *)data;

unnecessary typecast from void*

> +
> +	switch (tag) {
> +	case HTT_PPDU_STATS_TAG_COMMON:
> +		if (len < sizeof(struct htt_ppdu_stats_common)) {
> +			ath12k_warn(ab, "Invalid len %d for the tag 0x%x\n",
> +				    len, tag);
> +			return -EINVAL;
> +		}
> +		memcpy(&ppdu_info->ppdu_stats.common, ptr,
> +		       sizeof(struct htt_ppdu_stats_common));
> +		break;
> +	case HTT_PPDU_STATS_TAG_USR_RATE:
> +		if (len < sizeof(struct htt_ppdu_stats_user_rate)) {
> +			ath12k_warn(ab, "Invalid len %d for the tag 0x%x\n",
> +				    len, tag);
> +			return -EINVAL;
> +		}
> +
> +		peer_id = ((struct htt_ppdu_stats_user_rate *)ptr)->sw_peer_id;
> +		cur_user = ath12k_get_ppdu_user_index(&ppdu_info->ppdu_stats,
> +						      peer_id);
> +		if (cur_user < 0)
> +			return -EINVAL;
> +		user_stats = &ppdu_info->ppdu_stats.user_stats[cur_user];
> +		user_stats->peer_id = peer_id;
> +		user_stats->is_valid_peer_id = true;
> +		memcpy(&user_stats->rate, ptr,
> +		       sizeof(struct htt_ppdu_stats_user_rate));
> +		user_stats->tlv_flags |= BIT(tag);
> +		break;
> +	case HTT_PPDU_STATS_TAG_USR_COMPLTN_COMMON:
> +		if (len < sizeof(struct htt_ppdu_stats_usr_cmpltn_cmn)) {
> +			ath12k_warn(ab, "Invalid len %d for the tag 0x%x\n",
> +				    len, tag);
> +			return -EINVAL;
> +		}
> +
> +		peer_id = ((struct htt_ppdu_stats_usr_cmpltn_cmn *)ptr)->sw_peer_id;
> +		cur_user = ath12k_get_ppdu_user_index(&ppdu_info->ppdu_stats,
> +						      peer_id);
> +		if (cur_user < 0)
> +			return -EINVAL;
> +		user_stats = &ppdu_info->ppdu_stats.user_stats[cur_user];
> +		user_stats->peer_id = peer_id;
> +		user_stats->is_valid_peer_id = true;
> +		memcpy(&user_stats->cmpltn_cmn, ptr,
> +		       sizeof(struct htt_ppdu_stats_usr_cmpltn_cmn));
> +		user_stats->tlv_flags |= BIT(tag);
> +		break;
> +	case HTT_PPDU_STATS_TAG_USR_COMPLTN_ACK_BA_STATUS:
> +		if (len <
> +		    sizeof(struct htt_ppdu_stats_usr_cmpltn_ack_ba_status)) {
> +			ath12k_warn(ab, "Invalid len %d for the tag 0x%x\n",
> +				    len, tag);
> +			return -EINVAL;
> +		}
> +
> +		peer_id =
> +		((struct htt_ppdu_stats_usr_cmpltn_ack_ba_status *)ptr)->sw_peer_id;

descendant should be indented to aid readability
is it necessary to split this line?

> +		cur_user = ath12k_get_ppdu_user_index(&ppdu_info->ppdu_stats,
> +						      peer_id);
> +		if (cur_user < 0)
> +			return -EINVAL;
> +		user_stats = &ppdu_info->ppdu_stats.user_stats[cur_user];
> +		user_stats->peer_id = peer_id;
> +		user_stats->is_valid_peer_id = true;
> +		memcpy(&user_stats->ack_ba, ptr,
> +		       sizeof(struct htt_ppdu_stats_usr_cmpltn_ack_ba_status));
> +		user_stats->tlv_flags |= BIT(tag);
> +		break;
> +	}
> +	return 0;
> +}

snip

> +static void ath12k_copy_to_delay_stats(struct ath12k_peer *peer,
> +				       struct htt_ppdu_user_stats *usr_stats)
> +{
> +	peer->ppdu_stats_delayba.sw_peer_id = usr_stats->rate.sw_peer_id;
> +	peer->ppdu_stats_delayba.info0 = usr_stats->rate.info0;
> +	peer->ppdu_stats_delayba.ru_end = usr_stats->rate.ru_end;
> +	peer->ppdu_stats_delayba.ru_start = usr_stats->rate.ru_start;
> +	peer->ppdu_stats_delayba.info1 = usr_stats->rate.info1;
> +	peer->ppdu_stats_delayba.rate_flags = usr_stats->rate.rate_flags;
> +	peer->ppdu_stats_delayba.resp_rate_flags = usr_stats->rate.resp_rate_flags;
> +
> +	peer->delayba_flag = true;
> +}
> +
> +static void ath12k_copy_to_bar(struct ath12k_peer *peer,
> +			       struct htt_ppdu_user_stats *usr_stats)
> +{
> +	usr_stats->rate.sw_peer_id = peer->ppdu_stats_delayba.sw_peer_id;
> +	usr_stats->rate.info0 = peer->ppdu_stats_delayba.info0;
> +	usr_stats->rate.ru_end = peer->ppdu_stats_delayba.ru_end;
> +	usr_stats->rate.ru_start = peer->ppdu_stats_delayba.ru_start;
> +	usr_stats->rate.info1 = peer->ppdu_stats_delayba.info1;
> +	usr_stats->rate.rate_flags = peer->ppdu_stats_delayba.rate_flags;
> +	usr_stats->rate.resp_rate_flags = peer->ppdu_stats_delayba.resp_rate_flags;
> +
> +	peer->delayba_flag = false;
> +}

see my comment in peer.h review about the above two functions

snip

> +static void ath12k_htt_pktlog(struct ath12k_base *ab, struct sk_buff *skb)
> +{
> +	struct htt_pktlog_msg *data = (struct htt_pktlog_msg *)skb->data;
> +	struct ath_pktlog_hdr *hdr = (struct ath_pktlog_hdr *)data;
> +	struct ath12k *ar;
> +	u8 pdev_id;
> +
> +	pdev_id = u32_get_bits(data->hdr, HTT_T2H_PPDU_STATS_INFO_PDEV_ID);
> +	ar = ath12k_mac_get_ar_by_pdev_id(ab, pdev_id);
> +	if (!ar) {
> +		ath12k_warn(ab, "invalid pdev id %d on htt pktlog\n", pdev_id);
> +		return;
> +	}
> +	hdr->m_timestamp = ar->pdev->timestamp;
> +
> +	trace_ath12k_htt_pktlog(ar, data->payload, hdr->size,
> +				ar->ab->pktlog_defs_checksum);
> +}

I am really confused about the above function.
The first two declarations have both data and hdr point to the skb->data.
So one would assume these are related structures.  But instead we have:
struct ath_pktlog_hdr {
	u16 flags;
	u16 missed_cnt;
	u16 log_type;
	u16 size;
	u32 timestamp;
	u32 type_specific_data;
	struct mlo_timestamp m_timestamp;
	u8 payload[];
};

struct htt_pktlog_msg {
	u32 hdr;
	u8 payload[0];
};

this means the pdev_id = u32_get_bits() logic is somehow extracting the 
pdev_id from the fields that hold the flags+missed_cnt
and the logic to write hdr->m_timestamp is somewhere in the middle of 
the htt_pktlog_msg payload[].

now the only thing that I can guess is that the htt_pktlog_msg payload[] 
begins with:
	u16 log_type;
	u16 size;
	u32 timestamp;
	u32 type_specific_data;
	struct mlo_timestamp m_timestamp;

but if so, that is less than clear from the code and declarations

> +
> +static void ath12k_htt_backpressure_event_handler(struct ath12k_base *ab,
> +						  struct sk_buff *skb)
> +{
> +	u32 *data = (u32 *)skb->data;
> +	u8 pdev_id, ring_type, ring_id, pdev_idx;
> +	u16 hp, tp;
> +	u32 backpressure_time;
> +	struct ath12k_bp_stats *bp_stats;
> +
> +	pdev_id = u32_get_bits(*data, HTT_BACKPRESSURE_EVENT_PDEV_ID_M);
> +	ring_type = u32_get_bits(*data, HTT_BACKPRESSURE_EVENT_RING_TYPE_M);
> +	ring_id = u32_get_bits(*data, HTT_BACKPRESSURE_EVENT_RING_ID_M);
> +	++data;
> +
> +	hp = u32_get_bits(*data, HTT_BACKPRESSURE_EVENT_HP_M);
> +	tp = u32_get_bits(*data, HTT_BACKPRESSURE_EVENT_TP_M);
> +	++data;
> +
> +	backpressure_time = *data;

I believe the above code would be much clearer if skb->data was typecast 
to a struct pointer and assignments referenced members of the struct, 
just like most/all of the functions that follow.
and as I've written before, I further believe that having accessor 
functions/macros would make it even clearer.

snip

> +static void ath12k_dp_rx_h_undecap_nwifi(struct ath12k *ar,
> +					 struct sk_buff *msdu,
> +					 enum hal_encrypt_type enctype,
> +					 struct ieee80211_rx_status *status)
> +{
> +	struct ath12k_base *ab = ar->ab;
> +	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
> +	u8 decap_hdr[DP_MAX_NWIFI_HDR_LEN];
> +	struct ieee80211_hdr *hdr;
> +	size_t hdr_len;
> +	u8 *crypto_hdr;
> +	u16 qos_ctl = 0;

nit: initializer always overwritten
> +
> +	/* pull decapped header */
> +	hdr = (struct ieee80211_hdr *)msdu->data;
> +	hdr_len = ieee80211_hdrlen(hdr->frame_control);
> +	skb_pull(msdu, hdr_len);
> +
> +	/*  Rebuild qos header */
> +	hdr->frame_control |= __cpu_to_le16(IEEE80211_STYPE_QOS_DATA);
> +
> +	/* Reset the order bit as the HT_Control header is stripped */
> +	hdr->frame_control &= ~(__cpu_to_le16(IEEE80211_FCTL_ORDER));
> +
> +	qos_ctl = rxcb->tid;

snip

> +static void ath12k_get_dot11_hdr_from_rx_desc(struct ath12k *ar,
> +					      struct sk_buff *msdu,
> +					      struct ath12k_skb_rxcb *rxcb,
> +					      struct ieee80211_rx_status *status,
> +					      enum hal_encrypt_type enctype)
> +{
> +	struct hal_rx_desc *rx_desc = rxcb->rx_desc;
> +	struct ath12k_base *ab = ar->ab;
> +	size_t hdr_len, crypto_len;
> +	struct ieee80211_hdr *hdr;
> +	u16 qos_ctl = 0;

nit: initializer always overwritten

snip

> +		qos_ctl = rxcb->tid;
> +		if (ath12k_dp_rx_h_mesh_ctl_present(ab, rx_desc))
> +			qos_ctl |= IEEE80211_QOS_CTL_MESH_CONTROL_PRESENT;
> +
> +		/* TODO: Add other QoS ctl fields when required */
> +		memcpy(msdu->data + (hdr_len - IEEE80211_QOS_CTL_LEN),
> +		       &qos_ctl, IEEE80211_QOS_CTL_LEN);
> +	}
> +}
> +

snip

> +static void ath12k_dp_rx_deliver_msdu(struct ath12k *ar, struct napi_struct *napi,
> +				      struct sk_buff *msdu,
> +				      struct ieee80211_rx_status *status)
> +{
> +	struct ath12k_base *ab = ar->ab;
> +	static const struct ieee80211_radiotap_he known = {
> +		.data1 = cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_DATA_MCS_KNOWN |
> +				     IEEE80211_RADIOTAP_HE_DATA1_BW_RU_ALLOC_KNOWN),
> +		.data2 = cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA2_GI_KNOWN),
> +	};
> +	struct ieee80211_radiotap_he *he = NULL;

nit: initializer always overwritten

> +	struct ieee80211_rx_status *rx_status;
> +	struct ieee80211_sta *pubsta = NULL;
> +	struct ath12k_peer *peer;
> +	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
> +	u8 decap = DP_RX_DECAP_TYPE_RAW;
> +	bool is_mcbc = rxcb->is_mcbc;
> +	bool is_eapol = rxcb->is_eapol;
> +
> +	if (status->encoding == RX_ENC_HE && !(status->flag & RX_FLAG_RADIOTAP_HE) &&
> +	    !(status->flag & RX_FLAG_SKIP_MONITOR)) {
> +		he = skb_push(msdu, sizeof(known));
> +		memcpy(he, &known, sizeof(known));

this is only use of 'he' hence initializer is unnecessary

> +		status->flag |= RX_FLAG_RADIOTAP_HE;
> +	}
> +
> +	if (!(status->flag & RX_FLAG_ONLY_MONITOR))
> +		decap = ath12k_dp_rx_h_decap_type(ab, rxcb->rx_desc);
> +
> +	spin_lock_bh(&ab->base_lock);
> +	peer = ath12k_dp_rx_h_find_peer(ab, msdu);
> +	if (peer && peer->sta)
> +		pubsta = peer->sta;

could just unconditionally have pubsta = peer ? peer->sta : NULL
then initializer would be unnecessary

snip

> +static int ath12k_dp_rx_process_msdu(struct ath12k *ar,
> +				     struct sk_buff *msdu,
> +				     struct sk_buff_head *msdu_list,
> +				     struct ieee80211_rx_status *rx_status)
> +{
> +	struct ath12k_base *ab = ar->ab;
> +	struct hal_rx_desc *rx_desc, *lrx_desc;
> +	struct ath12k_skb_rxcb *rxcb;
> +	struct sk_buff *last_buf;
> +	u8 l3_pad_bytes;
> +	u16 msdu_len;
> +	int ret;
> +	u32 hal_rx_desc_sz = ar->ab->hw_params->hal_desc_sz;
> +
> +	last_buf = ath12k_dp_rx_get_msdu_last_buf(msdu_list, msdu);
> +	if (!last_buf) {
> +		ath12k_warn(ab,
> +			    "No valid Rx buffer to access MSDU_END tlv\n");
> +		ret = -EIO;
> +		goto free_out;
> +	}
> +
> +	rx_desc = (struct hal_rx_desc *)msdu->data;
> +	lrx_desc = (struct hal_rx_desc *)last_buf->data;
> +	if (!ath12k_dp_rx_h_msdu_done(ab, lrx_desc)) {
> +		ath12k_warn(ab, "msdu_done bit in msdu_end is not set\n");
> +		ret = -EIO;
> +		goto free_out;
> +	}
> +
> +	rxcb = ATH12K_SKB_RXCB(msdu);
> +	rxcb->rx_desc = rx_desc;
> +	msdu_len = ath12k_dp_rx_h_msdu_len(ab, lrx_desc);
> +	l3_pad_bytes = ath12k_dp_rx_h_l3pad(ab, lrx_desc);
> +
> +	if (rxcb->is_frag) {
> +		skb_pull(msdu, hal_rx_desc_sz);
> +	} else if (!rxcb->is_continuation) {
> +		if ((msdu_len + hal_rx_desc_sz) > DP_RX_BUFFER_SIZE) {
> +			ret = -EINVAL;
> +			ath12k_warn(ab, "invalid msdu len %u\n", msdu_len);
> +			ath12k_dbg_dump(ab, ATH12K_DBG_DATA, NULL, "", rx_desc,
> +					sizeof(struct hal_rx_desc));
> +			goto free_out;
> +		}
> +		skb_put(msdu, hal_rx_desc_sz + l3_pad_bytes + msdu_len);
> +		skb_pull(msdu, hal_rx_desc_sz + l3_pad_bytes);
> +	} else {
> +		ret = ath12k_dp_rx_msdu_coalesce(ar, msdu_list,
> +						 msdu, last_buf,
> +						 l3_pad_bytes, msdu_len);
> +		if (ret) {
> +			ath12k_warn(ab,
> +				    "failed to coalesce msdu rx buffer%d\n", ret);
> +			goto free_out;
> +		}
> +	}
> +
> +	ath12k_dp_rx_h_ppdu(ar, rx_desc, rx_status);
> +	ath12k_dp_rx_h_mpdu(ar, msdu, rx_desc, rx_status);
> +
> +	rx_status->flag |= RX_FLAG_SKIP_MONITOR | RX_FLAG_DUP_VALIDATED;
> +
> +	return 0;
> +
> +free_out:
> +	return ret;
> +}
> +
> +static void ath12k_dp_rx_process_received_packets(struct ath12k_base *ab,
> +						  struct napi_struct *napi,
> +						  struct sk_buff_head *msdu_list,
> +						  int ring_id)
> +{
> +	struct ieee80211_rx_status rx_status = {0};

initializing just on entry seems wrong, see below

> +	struct ath12k_skb_rxcb *rxcb;
> +	struct sk_buff *msdu;
> +	struct ath12k *ar;
> +	u8 mac_id;
> +	int ret;
> +
> +	if (skb_queue_empty(msdu_list))
> +		return;
> +
> +	rcu_read_lock();
> +
> +	while ((msdu = __skb_dequeue(msdu_list))) {
> +		rxcb = ATH12K_SKB_RXCB(msdu);
> +		mac_id = rxcb->mac_id;
> +		ar = ab->pdevs[mac_id].ar;
> +		if (!rcu_dereference(ab->pdevs_active[mac_id])) {
> +			dev_kfree_skb_any(msdu);
> +			continue;
> +		}
> +
> +		if (test_bit(ATH12K_CAC_RUNNING, &ar->dev_flags)) {
> +			dev_kfree_skb_any(msdu);
> +			continue;
> +		}
> +
> +		ret = ath12k_dp_rx_process_msdu(ar, msdu, msdu_list, &rx_status);

you don't need to reinitialize rx_status for every iteration of the loop?

> +		if (ret) {
> +			ath12k_dbg(ab, ATH12K_DBG_DATA,
> +				   "Unable to process msdu %d", ret);
> +			dev_kfree_skb_any(msdu);
> +			continue;
> +		}
> +
> +		ath12k_dp_rx_deliver_msdu(ar, napi, msdu, &rx_status);
> +	}
> +
> +	rcu_read_unlock();
> +}

snip

> +int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
> +			     int budget)
> +{
> +	u32 msdu_cookies[HAL_NUM_RX_MSDUS_PER_LINK_DESC];
> +	struct dp_link_desc_bank *link_desc_banks;
> +	enum hal_rx_buf_return_buf_manager rbm;
> +	struct hal_rx_msdu_link *link_desc_va;
> +	int tot_n_bufs_reaped, quota, ret, i;
> +	struct hal_reo_dest_ring *reo_desc;
> +	struct dp_rxdma_ring *rx_ring;
> +	struct dp_srng *reo_except;
> +	u32 desc_bank, num_msdus;
> +	struct hal_srng *srng;
> +	struct ath12k_dp *dp;
> +	int mac_id;
> +	struct ath12k *ar;
> +	dma_addr_t paddr;
> +	bool is_frag;
> +	u8 drop = 0;

bool?
snip

> +int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
> +				 struct napi_struct *napi, int budget)
> +{
> +	struct ath12k *ar;
> +	struct ath12k_dp *dp = &ab->dp;
> +	struct dp_rxdma_ring *rx_ring;
> +	struct hal_rx_wbm_rel_info err_info;
> +	struct hal_srng *srng;
> +	struct sk_buff *msdu;
> +	struct sk_buff_head msdu_list[MAX_RADIOS];
> +	struct ath12k_skb_rxcb *rxcb;
> +	void *rx_desc;
> +	int mac_id;
> +	int num_buffs_reaped = 0;
> +	int total_num_buffs_reaped = 0;
> +	struct ath12k_rx_desc_info *desc_info;
> +	int ret, i;
> +
> +	for (i = 0; i < ab->num_radios; i++)
> +		__skb_queue_head_init(&msdu_list[i]);
> +
> +	srng = &ab->hal.srng_list[dp->rx_rel_ring.ring_id];
> +	rx_ring = &dp->rx_refill_buf_ring;
> +
> +	spin_lock_bh(&srng->lock);
> +
> +	ath12k_hal_srng_access_begin(ab, srng);
> +
> +	while (budget) {
> +		rx_desc = ath12k_hal_srng_dst_get_next_entry(ab, srng);
> +		if (!rx_desc)
> +			break;
> +
> +		ret = ath12k_hal_wbm_desc_parse_err(ab, rx_desc, &err_info);
> +		if (ret) {
> +			ath12k_warn(ab,
> +				    "failed to parse rx error in wbm_rel ring desc %d\n",
> +				    ret);
> +			continue;
> +		}
> +
> +		desc_info = (struct ath12k_rx_desc_info *)err_info.rx_desc;
> +
> +		/* retry manual desc retrieval if hw cc is not done */
> +		if (!desc_info) {
> +			desc_info = ath12k_dp_get_rx_desc(ab, err_info.cookie);
> +			if (!desc_info) {
> +				ath12k_warn(ab, "Invalid cookie in manual desc retrival");
> +				continue;
> +			}
> +		}
> +
> +		/* FIXME: Extract mac id correctly. Since descs are not tied
> +		 * to mac, we can extract from vdev id in ring desc.
> +		 */
> +		mac_id = 0;
> +
> +		if (desc_info->magic != ATH12K_DP_RX_DESC_MAGIC)
> +			ath12k_warn(ab, "WBM RX err, Check HW CC implementation");
> +
> +		msdu = desc_info->skb;
> +		desc_info->skb = NULL;
> +
> +		spin_lock_bh(&dp->rx_desc_lock);
> +		list_move_tail(&desc_info->list, &dp->rx_desc_free_list);
> +		spin_unlock_bh(&dp->rx_desc_lock);
> +
> +		rxcb = ATH12K_SKB_RXCB(msdu);
> +		dma_unmap_single(ab->dev, rxcb->paddr,
> +				 msdu->len + skb_tailroom(msdu),
> +				 DMA_FROM_DEVICE);
> +
> +		num_buffs_reaped++;
> +		total_num_buffs_reaped++;

why are two separate counters needed? seem they will have the same value 
always

> +
> +		if (!err_info.continuation)
> +			budget--;
> +
> +		if (err_info.push_reason !=
> +		    HAL_REO_DEST_RING_PUSH_REASON_ERR_DETECTED) {
> +			dev_kfree_skb_any(msdu);
> +			continue;
> +		}
> +
> +		rxcb->err_rel_src = err_info.err_rel_src;
> +		rxcb->err_code = err_info.err_code;
> +		rxcb->rx_desc = (struct hal_rx_desc *)msdu->data;
> +		__skb_queue_tail(&msdu_list[mac_id], msdu);
> +
> +		rxcb->is_first_msdu = err_info.first_msdu;
> +		rxcb->is_last_msdu = err_info.last_msdu;
> +		rxcb->is_continuation = err_info.continuation;
> +	}
> +
> +	ath12k_hal_srng_access_end(ab, srng);
> +
> +	spin_unlock_bh(&srng->lock);
> +
> +	if (!total_num_buffs_reaped)
> +		goto done;
> +
> +	ath12k_dp_rx_bufs_replenish(ab, 0, rx_ring, num_buffs_reaped,
> +				    ab->hw_params->hal_params->rx_buf_rbm, true);
> +
> +	rcu_read_lock();
> +	for (i = 0; i <  ab->num_radios; i++) {
> +		if (!rcu_dereference(ab->pdevs_active[i])) {
> +			__skb_queue_purge(&msdu_list[i]);
> +			continue;
> +		}
> +
> +		ar = ab->pdevs[i].ar;
> +
> +		if (test_bit(ATH12K_CAC_RUNNING, &ar->dev_flags)) {
> +			__skb_queue_purge(&msdu_list[i]);
> +			continue;
> +		}
> +
> +		while ((msdu = __skb_dequeue(&msdu_list[i])) != NULL)
> +			ath12k_dp_rx_wbm_err(ar, napi, msdu, &msdu_list[i]);
> +	}
> +	rcu_read_unlock();
> +done:
> +	return total_num_buffs_reaped;
> +}

snip
