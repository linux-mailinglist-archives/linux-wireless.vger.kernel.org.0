Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90490595EDD
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Aug 2022 17:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbiHPPRg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Aug 2022 11:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235452AbiHPPRf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Aug 2022 11:17:35 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B4E82D0A
        for <linux-wireless@vger.kernel.org>; Tue, 16 Aug 2022 08:17:34 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27GFHLRC011720;
        Tue, 16 Aug 2022 15:17:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=VSbOLMveQu0tfWD2ljfDNoYn7Zn13+98BKstK8J1TeA=;
 b=oLXqGMqvpH9hr/jl5/vNeu8z/fUhd12mCKMU2qozGRYnksynsgcP5IsaxJahT+REBXzy
 mBDBvOFN6YS6+5KHtnLiRAvaYyLXi0B5yAEzurgcxU9EhQ7X/CMRQr1CszXShdrfTkKz
 pfFlXv4w91OS/1ry56rMQtegyDgby8DHRBcwBkH6mibLImfNkyD3puD4NQfTYAfjj/H/
 0j/g1I/J+TSb9JpMPwp47Vcl/msMXj/mbL1gK9RH6Z6wWSI0ntA3DiVpDbbQRHOQiCaL
 oq4l1Jb+DMWa253l48jxxabqGifEO4SXYwLhcJRUh/BcttVogOYrcrwbEM9RPMZHlEST 9Q== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j08rs91k0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Aug 2022 15:17:21 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27GFHKFZ017419
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Aug 2022 15:17:20 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 16 Aug 2022 08:17:20 -0700
Received: from [10.110.78.115] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 16 Aug
 2022 08:17:19 -0700
Message-ID: <65a4750f-1798-a624-0a2e-96930f8ec816@quicinc.com>
Date:   Tue, 16 Aug 2022 08:17:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 11/50] wifi: ath12k: add dp.c
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>
CC:     <ath12k@lists.infradead.org>
References: <20220812161003.27279-1-kvalo@kernel.org>
 <20220812161003.27279-12-kvalo@kernel.org>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220812161003.27279-12-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: z5Ns5fWgWWHdukcExMqgkpe0xYuiDwkb
X-Proofpoint-GUID: z5Ns5fWgWWHdukcExMqgkpe0xYuiDwkb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-16_08,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2208160059
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
>   drivers/net/wireless/ath/ath12k/dp.c | 1560 ++++++++++++++++++++++++++++++++++
>   1 file changed, 1560 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
> new file mode 100644
> index 000000000000..351bb24e08a0
> --- /dev/null
> +++ b/drivers/net/wireless/ath/ath12k/dp.c

snip

> +int ath12k_dp_peer_setup(struct ath12k *ar, int vdev_id, const u8 *addr)
> +{
> +	struct ath12k_base *ab = ar->ab;
> +	struct ath12k_peer *peer;
> +	u32 reo_dest;
> +	int ret = 0, tid;
> +
> +	/* NOTE: reo_dest ring id starts from 1 unlike mac_id which starts from 0 */
> +	reo_dest = ar->dp.mac_id + 1;
> +	ret = ath12k_wmi_set_peer_param(ar, addr, vdev_id,
> +					WMI_PEER_SET_DEFAULT_ROUTING,
> +					DP_RX_HASH_ENABLE | (reo_dest << 1));
> +
> +	if (ret) {
> +		ath12k_warn(ab, "failed to set default routing %d peer :%pM vdev_id :%d\n",
> +			    ret, addr, vdev_id);
> +		return ret;
> +	}
> +
> +	for (tid = 0; tid <= IEEE80211_NUM_TIDS; tid++) {
> +		ret = ath12k_dp_rx_peer_tid_setup(ar, addr, vdev_id, tid, 1, 0,
> +						  HAL_PN_TYPE_NONE);
> +		if (ret) {
> +			ath12k_warn(ab, "failed to setup rxd tid queue for tid %d: %d\n",
> +				    tid, ret);
> +			goto peer_clean;
> +		}
> +	}
> +
> +	ret = ath12k_dp_rx_peer_frag_setup(ar, addr, vdev_id);
> +	if (ret) {
> +		ath12k_warn(ab, "failed to setup rx defrag context\n");
> +		return ret;

why does this failure simply return whereas just previously upon the 
failure of ath12k_dp_rx_peer_tid_setup() we goto peer_clean. don't we 
need to do the peer_clean logic here as well to undo the 
ath12k_dp_rx_peer_tid_setup() calls?

> +	}
> +
> +	/* TODO: Setup other peer specific resource used in data path */
> +
> +	return 0;
> +
> +peer_clean:
> +	spin_lock_bh(&ab->base_lock);
> +
> +	peer = ath12k_peer_find(ab, vdev_id, addr);
> +	if (!peer) {
> +		ath12k_warn(ab, "failed to find the peer to del rx tid\n");
> +		spin_unlock_bh(&ab->base_lock);
> +		return -ENOENT;
> +	}
> +
> +	for (; tid >= 0; tid--)
> +		ath12k_dp_rx_peer_tid_delete(ar, peer, tid);
> +
> +	spin_unlock_bh(&ab->base_lock);
> +
> +	return ret;
> +}

snip

> +static
> +void ath12k_dp_tx_get_vdev_bank_config(struct ath12k_base *ab, struct ath12k_vif *arvif,
> +				       u32 *bank_config)

rather than be a void function with a writable param, why not return the 
bank_config as the function return value?

> +{
> +	enum hal_encrypt_type encrypt_type = 0;

I would expect an enum initializer to be one of the enumerators.
0 is HAL_ENCRYPT_TYPE_WEP_40 -- is that really the correct value?

> +
> +	/* Only valid for raw frames with HW crypto enabled.
> +	 * With SW crypto, mac80211 sets key per packet
> +	 */
> +	if (arvif->tx_encap_type == HAL_TCL_ENCAP_TYPE_RAW &&
> +	    test_bit(ATH12K_FLAG_HW_CRYPTO_DISABLED, &ab->dev_flags))
> +		encrypt_type = ath12k_dp_tx_get_encrypt_type(arvif->key_cipher);
> +
> +	*bank_config |= u32_encode_bits(arvif->tx_encap_type,
> +					HAL_TX_BANK_CONFIG_ENCAP_TYPE) |
> +			u32_encode_bits(encrypt_type,
> +					HAL_TX_BANK_CONFIG_ENCRYPT_TYPE);
> +	*bank_config |= u32_encode_bits(0, HAL_TX_BANK_CONFIG_SRC_BUFFER_SWAP) |
> +			u32_encode_bits(0, HAL_TX_BANK_CONFIG_LINK_META_SWAP) |
> +			u32_encode_bits(0, HAL_TX_BANK_CONFIG_EPD);
> +
> +	/* only valid if idx_lookup_override is not set in tcl_data_cmd */
> +	*bank_config |= u32_encode_bits(0, HAL_TX_BANK_CONFIG_INDEX_LOOKUP_EN);
> +
> +	*bank_config |= u32_encode_bits(arvif->hal_addr_search_flags & HAL_TX_ADDRX_EN,
> +					HAL_TX_BANK_CONFIG_ADDRX_EN) |
> +			u32_encode_bits(!!(arvif->hal_addr_search_flags &
> +					HAL_TX_ADDRY_EN),
> +					HAL_TX_BANK_CONFIG_ADDRY_EN);
> +
> +	*bank_config |= u32_encode_bits(ieee80211_vif_is_mesh(arvif->vif) ? 3 : 0,
> +					HAL_TX_BANK_CONFIG_MESH_EN) |
> +			u32_encode_bits(arvif->vdev_id_check_en,
> +					HAL_TX_BANK_CONFIG_VDEV_ID_CHECK_EN);
> +
> +	*bank_config |= u32_encode_bits(0, HAL_TX_BANK_CONFIG_DSCP_TIP_MAP_ID);
> +}
> +
> +static int ath12k_dp_tx_get_bank_profile(struct ath12k_base *ab, struct ath12k_vif *arvif,
> +					 struct ath12k_dp *dp)
> +{
> +	int bank_id = DP_INVALID_BANK_ID;
> +	int i;
> +	u32 bank_config = 0;

this initializer would be unnecessary if 
ath12k_dp_tx_get_vdev_bank_config() returns the config as the function 
return value instead of doing so by reference via a function param

> +	bool configure_register = false;
> +
> +	/* convert vdev params into hal_tx_bank_config */
> +	ath12k_dp_tx_get_vdev_bank_config(ab, arvif, &bank_config);
> +
> +	spin_lock_bh(&dp->tx_bank_lock);
> +	/* TODO: implement using idr kernel framework*/
> +	for (i = 0; i < dp->num_bank_profiles; i++) {
> +		if (dp->bank_profiles[i].is_configured &&
> +		    (dp->bank_profiles[i].bank_config ^ bank_config) == 0) {
> +			bank_id = i;
> +			goto inc_ref_and_return;
> +		}
> +		if (!dp->bank_profiles[i].is_configured ||
> +		    !dp->bank_profiles[i].num_users) {
> +			bank_id = i;
> +			goto configure_and_return;
> +		}
> +	}
> +
> +	if (bank_id == DP_INVALID_BANK_ID) {
> +		spin_unlock_bh(&dp->tx_bank_lock);
> +		ath12k_err(ab, "unable to find TX bank!");
> +		return bank_id;
> +	}
> +
> +configure_and_return:
> +	dp->bank_profiles[bank_id].is_configured = true;
> +	dp->bank_profiles[bank_id].bank_config = bank_config;
> +	configure_register = true;
> +inc_ref_and_return:
> +	dp->bank_profiles[bank_id].num_users++;
> +	spin_unlock_bh(&dp->tx_bank_lock);
> +
> +	if (configure_register)
> +		ath12k_hal_tx_configure_bank_register(ab, bank_config, bank_id);
> +
> +	ath12k_dbg(ab, ATH12K_DBG_DP_HTT, "dp_htt tcl bank_id %d input 0x%x match 0x%x num_users %u",
> +		   bank_id, bank_config, dp->bank_profiles[bank_id].bank_config,
> +		   dp->bank_profiles[bank_id].num_users);
> +
> +	return bank_id;
> +}
> +
> +void ath12k_dp_tx_put_bank_profile(struct ath12k_dp *dp, u8 bank_id)
> +{
> +	spin_lock_bh(&dp->tx_bank_lock);
> +	dp->bank_profiles[bank_id].num_users--;
> +	spin_unlock_bh(&dp->tx_bank_lock);
> +}
> +
> +static void ath12k_dp_deinit_bank_profiles(struct ath12k_base *ab)
> +{
> +	struct ath12k_dp *dp = &ab->dp;
> +
> +	kfree(dp->bank_profiles);

suggest setting dp->bank_profiles = NULL to avoid dangling pointer to 
freed memory

> +}
> +

snip

> +static void ath12k_dp_srng_common_cleanup(struct ath12k_base *ab)
> +{
> +	struct ath12k_dp *dp = &ab->dp;
> +	int i;
> +
> +	ath12k_dp_srng_cleanup(ab, &dp->wbm_desc_rel_ring);
> +	ath12k_dp_srng_cleanup(ab, &dp->tcl_cmd_ring);
> +	ath12k_dp_srng_cleanup(ab, &dp->tcl_status_ring);
> +	for (i = 0; i < ab->hw_params->max_tx_ring; i++) {
> +		ath12k_dp_srng_cleanup(ab, &dp->tx_ring[i].tcl_data_ring);
> +		ath12k_dp_srng_cleanup(ab, &dp->tx_ring[i].tcl_comp_ring);
> +	}
> +	ath12k_dp_srng_cleanup(ab, &dp->reo_reinject_ring);
> +	ath12k_dp_srng_cleanup(ab, &dp->rx_rel_ring);
> +	ath12k_dp_srng_cleanup(ab, &dp->reo_except_ring);
> +	ath12k_dp_srng_cleanup(ab, &dp->reo_cmd_ring);
> +	ath12k_dp_srng_cleanup(ab, &dp->reo_status_ring);

i'm used to seeing deinit code do things in reverse order of init code, 
but the above is doing things in the same order. yes it probably doesn't 
matter in this case, but if you consistently deinit in reverse order of 
init then you'll get it right in the cases where it does matter

> +}
> +

snip

> +int ath12k_dp_service_srng(struct ath12k_base *ab,
> +			   struct ath12k_ext_irq_grp *irq_grp,
> +			   int budget)
> +{
> +	struct napi_struct *napi = &irq_grp->napi;
> +	int grp_id = irq_grp->grp_id;
> +	int work_done = 0;
> +	int i = 0, j;
> +	int tot_work_done = 0;
> +	bool flag;

not a fan of a bool named flag.

better would be a name that tells us what it means when the flag is set.

I see this issue throughout the dp_mon functions:
ath12k_dp_mon_process_ring(...bool flag)
ath12k_dp_mon_srng_process(...bool flag, ...)

looking further I see:
#define ATH12K_DP_TX_MONITOR_MODE 0
#define ATH12K_DP_RX_MONITOR_MODE 1
(note 0 and 1 are not bool enumerators)

and logic like:
	if (flag == ATH12K_DP_RX_MONITOR_MODE) {

so IMO based upon this kind of logic it would make more sense to have 
either:

an enum ath12k_dp_monitor_mode and use that everywhere, or
rename bool flag to bool rx_mode and use that everywhere


> +
> +	while (i < ab->hw_params->max_tx_ring) {
> +		if (ab->hw_params->ring_mask->tx[grp_id] &
> +			BIT(ab->hw_params->hal_ops->tcl_to_wbm_rbm_map[i].wbm_ring_num))
> +			ath12k_dp_tx_completion_handler(ab, i);
> +		i++;
> +	}
> +
> +	if (ab->hw_params->ring_mask->rx_err[grp_id]) {
> +		work_done = ath12k_dp_rx_process_err(ab, napi, budget);
> +		budget -= work_done;
> +		tot_work_done += work_done;
> +		if (budget <= 0)
> +			goto done;
> +	}
> +
> +	if (ab->hw_params->ring_mask->rx_wbm_rel[grp_id]) {
> +		work_done = ath12k_dp_rx_process_wbm_err(ab,
> +							 napi,
> +							 budget);
> +		budget -= work_done;
> +		tot_work_done += work_done;
> +
> +		if (budget <= 0)
> +			goto done;
> +	}
> +
> +	if (ab->hw_params->ring_mask->rx[grp_id]) {
> +		i = fls(ab->hw_params->ring_mask->rx[grp_id]) - 1;
> +		work_done = ath12k_dp_rx_process(ab, i, napi,
> +						 budget);
> +		budget -= work_done;
> +		tot_work_done += work_done;
> +		if (budget <= 0)
> +			goto done;
> +	}
> +
> +	if (ab->hw_params->ring_mask->rx_mon_dest[grp_id]) {
> +		for (i = 0; i < ab->num_radios; i++) {
> +			for (j = 0; j < ab->hw_params->num_rxmda_per_pdev; j++) {
> +				int id = i * ab->hw_params->num_rxmda_per_pdev + j;
> + > +				flag = ATH12K_DP_RX_MONITOR_MODE;

this is invariant so it should be assigned outside the loops. yes, the 
compiler will probably do that for you, but why not do it yourself?

> +
> +				if (ab->hw_params->ring_mask->rx_mon_dest[grp_id] &

isn't ab->hw_params->ring_mask->rx_mon_dest[grp_id] also invariant?

> +					BIT(id)) {

indentation the same as the code that follows makes it difficult to
distinguish the condition from the conditional code

> +					work_done =
> +					ath12k_dp_mon_process_ring(ab, id, napi, budget,

descendant is not indented from the first line, making it difficult to 
see the code structure

> +								   flag);
> +					budget -= work_done;
> +					tot_work_done += work_done;
> +
> +					if (budget <= 0)
> +						goto done;
> +				}
> +			}
> +		}
> +	}
> +
> +	if (ab->hw_params->ring_mask->tx_mon_dest[grp_id]) {

this block of code has the same issues as the RX block. in fact it seems 
that this block is identical to the block above other than the flag and 
the tx_mon_desc vs rx_mon_desc, so I'm curious if it could be refactored 
into a single function that could be used by both tx and rx instead of 
duplicating code

> +		for (i = 0; i < ab->num_radios; i++) {
> +			for (j = 0; j < ab->hw_params->num_rxmda_per_pdev; j++) {
> +				int id = i * ab->hw_params->num_rxmda_per_pdev + j;
> +
> +				flag = ATH12K_DP_TX_MONITOR_MODE;
> +
> +				if (ab->hw_params->ring_mask->tx_mon_dest[grp_id] &
> +					BIT(id)) {
> +					work_done =
> +					ath12k_dp_mon_process_ring(ab, id, napi, budget,
> +								   flag);
> +					budget -= work_done;
> +					tot_work_done += work_done;
> +
> +					if (budget <= 0)
> +						goto done;
> +				}
> +			}
> +		}
> +	}
> +
> +	if (ab->hw_params->ring_mask->reo_status[grp_id])
> +		ath12k_dp_rx_process_reo_status(ab);
> +
> +	if (ab->hw_params->ring_mask->host2rxdma[grp_id]) {
> +		struct ath12k_dp *dp = &ab->dp;
> +		struct dp_rxdma_ring *rx_ring = &dp->rx_refill_buf_ring;
> +
> +		ath12k_dp_rx_bufs_replenish(ab, 0, rx_ring, 0,
> +					    ab->hw_params->hal_params->rx_buf_rbm,
> +					    true);
> +	}
> +
> +	/* TODO: Implement handler for other interrupts */
> +
> +done:
> +	return tot_work_done;
> +}
> +

snip

> +int ath12k_dp_pdev_alloc(struct ath12k_base *ab)
> +{
> +	struct ath12k *ar;
> +	int ret;
> +	int i;
> +
> +	ret = ath12k_dp_rx_htt_setup(ab);
> +	if (ret)
> +		goto out;
> +
> +	/* TODO: Per-pdev rx ring unlike tx ring which is mapped to different AC's */
> +	for (i = 0; i < ab->num_radios; i++) {
> +		ar = ab->pdevs[i].ar;
> +		ret = ath12k_dp_rx_pdev_alloc(ab, i);
> +		if (ret) {
> +			ath12k_warn(ab, "failed to allocate pdev rx for pdev_id :%d\n",
> +				    i);
> +			goto err;
> +		}
> +		ret = ath12k_dp_rx_pdev_mon_attach(ar);
> +		if (ret) {
> +			ath12k_warn(ab, "failed to initialize mon pdev %d\n",
> +				    i);

nit: unnecssary line break

> +			goto err;
> +		}
> +	}
> +
> +	return 0;
> +
> +err:
> +	ath12k_dp_pdev_free(ab);
> +out:
> +	return ret;
> +}
> +
> +int ath12k_dp_htt_connect(struct ath12k_dp *dp)
> +{
> +	struct ath12k_htc_svc_conn_req conn_req;
> +	struct ath12k_htc_svc_conn_resp conn_resp;
> +	int status;
> +
> +	memset(&conn_req, 0, sizeof(conn_req));
> +	memset(&conn_resp, 0, sizeof(conn_resp));

consider using = {} initializers

> +
> +	conn_req.ep_ops.ep_tx_complete = ath12k_dp_htt_htc_tx_complete;
> +	conn_req.ep_ops.ep_rx_complete = ath12k_dp_htt_htc_t2h_msg_handler;
> +
> +	/* connect to control service */
> +	conn_req.service_id = ATH12K_HTC_SVC_ID_HTT_DATA_MSG;
> +
> +	status = ath12k_htc_connect_service(&dp->ab->htc, &conn_req,
> +					    &conn_resp);
> +
> +	if (status)
> +		return status;
> +
> +	dp->eid = conn_resp.eid;
> +
> +	return 0;
> +}
> +

snip

> +static void ath12k_dp_cc_cleanup(struct ath12k_base *ab)
> +{
> +	struct ath12k_rx_desc_info *desc_info, *tmp;
> +	struct ath12k_tx_desc_info *tx_desc_info, *tmp1;
> +	struct ath12k_dp *dp = &ab->dp;
> +	struct sk_buff *skb;
> +	int i;
> +
> +	if (!dp->spt_info)
> +		return;
> +
> +	/* RX Descriptor cleanup */
> +	spin_lock_bh(&dp->rx_desc_lock);
> +
> +	list_for_each_entry_safe(desc_info, tmp, &dp->rx_desc_used_list, list) {
> +		list_del(&desc_info->list);
> +		skb = desc_info->skb;
> +
> +		if (!skb)
> +			continue;
> +
> +		dma_unmap_single(ab->dev, ATH12K_SKB_RXCB(skb)->paddr,
> +				 skb->len + skb_tailroom(skb), DMA_FROM_DEVICE);
> +		dev_kfree_skb_any(skb);
> +	}
> +
> +	spin_unlock_bh(&dp->rx_desc_lock);
> +
> +	/* TX Descriptor cleanup */
> +	for (i = 0; i < ATH12K_HW_MAX_QUEUES; i++) {
> +		spin_lock_bh(&dp->tx_desc_lock[i]);
> +
> +		list_for_each_entry_safe(tx_desc_info, tmp1, &dp->tx_desc_used_list[i],
> +					 list) {
> +			list_del(&tx_desc_info->list);
> +			skb = tx_desc_info->skb;
> +
> +			if (!skb)
> +				continue;
> +
> +			dma_unmap_single(ab->dev, ATH12K_SKB_RXCB(skb)->paddr,

why RXCB() in the TX path?

> +					 skb->len, DMA_TO_DEVICE);
> +			dev_kfree_skb_any(skb);
> +		}
> +
> +		spin_unlock_bh(&dp->tx_desc_lock[i]);
> +	}
> +
> +	/* unmap SPT pages */
> +	for (i = 0; i < dp->num_spt_pages; i++) {
> +		if (!dp->spt_info[i].vaddr)
> +			continue;
> +
> +		dma_free_coherent(ab->dev, ATH12K_PAGE_SIZE,
> +				  dp->spt_info[i].vaddr, dp->spt_info[i].paddr);
> +		dp->spt_info[i].vaddr = NULL;
> +	}
> +
> +	kfree(dp->spt_info);
> +}
> +
