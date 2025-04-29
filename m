Return-Path: <linux-wireless+bounces-22177-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46403AA016F
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 06:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 990D6480E6B
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 04:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FA11922F4;
	Tue, 29 Apr 2025 04:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lIFpUnf4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A431EEE0
	for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 04:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745901678; cv=none; b=iMyJ/cQRGsxPnvq47b6drG34TCN3H/Fc+Mkr1b1x6BQMmzUURXNVKSm6nNX0+FUianaDEIUwIfbHvg1pDHXpyD5+XomqNtSs8VqXayFl0HIcNg16E64AkYVfpx2ur4i5hVINBlkEwFpMSjUfGbDSWfZ1OKatHVq89P8RAE5a/lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745901678; c=relaxed/simple;
	bh=uGsowBQ58Joa2xMhCPoUSmiTKapRP6MdCJuCDtYjeBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WvUjP7zr0HD1eYb2Osr0YO+mUg/l8AcflSGQZ2fFEmykVykPlQ4LKg6f1eCnS0+yPFYdCCiBllvlqNXD9Th5RZ/Er/mMtjDz3o8UTZuCMaFACtBDCLTEPCszZ4CiKVIhpT94NkLVieWRIXk2VxJNU3FMpafzLotIMvJ1H+NRFoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lIFpUnf4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SNr8QH014387;
	Tue, 29 Apr 2025 04:41:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RI9yfzh6gvLXjj/UXCrYFsAAL92KZZ6aqqe5+BxceRg=; b=lIFpUnf4Q4v2rTir
	MtT0EhclssUZNoEBK/ubxJrF5NcI7rmoSjucU55gwCvThJnFxMTkmab98CWhUpby
	fGiSiKdQgezRzPPe+6luX6w55N9XH2DuK/QeIBTGZNK4npA4Yk6VJKWdcqsHNPil
	+L/5aWYFzdn78XArl17HwDTmSQ53qduWxLYdIyK8xbdPMnDc+vmqN7fvqGqyiKFi
	1Wy6eflTlhcoCopclrIow7XkXROJXqB0mAECo0WGE3xgpbWOuDSDkiZBJ41T29uS
	EkxL9lhy0sGFAwGnx+FKdSBjkQvLIVacRgm4gPBBLacpwd9O17O5VDuDW5LCMXCV
	aKzFog==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 468rnn259w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 04:41:14 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53T4fESo003087
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 04:41:14 GMT
Received: from [10.216.24.29] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 28 Apr
 2025 21:41:12 -0700
Message-ID: <931e066d-ebe6-4a94-9831-bb1634ae7601@quicinc.com>
Date: Tue, 29 Apr 2025 10:11:09 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 2/3] wifi: ath12k: Add device dp stats support
To: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Vinith Kumar R
	<quic_vinithku@quicinc.com>
References: <20250425012802.698914-1-nithyanantham.paramasivam@oss.qualcomm.com>
 <20250425012802.698914-3-nithyanantham.paramasivam@oss.qualcomm.com>
From: Mahendran P <quic_mahep@quicinc.com>
Content-Language: en-US
In-Reply-To: <20250425012802.698914-3-nithyanantham.paramasivam@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8zssqQQb6VIFLiD5ouiZE8y6-rqjJ2A8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDAzMyBTYWx0ZWRfX+0QF9U2o7yvq ywj+KLBgbuTn2j7vYbC4Zw5eQGCZzmLxRT8oPEYQMQzNb18ZL9gfXEOT7FJcm9bfE1WZ+HvGLji oMXCiEZFfMA72OYy5amXSQCYivhiA46ZuKhGJ5GwfkRbcNCnpQoH9L9AwoBtg9WBEuA/1YnHN9B
 MIQs+nshc78l0k98C31vlpJ64OF4gYi/balv+P5n8Kk0t9q5/u1eKnRK+PYGzuTeCWSYGf59+r1 3TPrh/DhBrDyXiXJOGtCOTM2A+cjO+q0z+wORwont0ZEFiobpVhwkkcRsdurNrGVVUj6QlZIhXW NgEi6hVdzTp8KUvSYFoXtOKnLGVPPxNuHLPeylHdNGK40U0TB8jJC2DekmxK0tGuxrCNgtmJglY
 QBmvZmsV0qWEXKXWk8lE7fMmkYthDjl0+Rt+3eZWuLP1OVqd+iWK57jbsiuEcNG1sh8v0XRS
X-Proofpoint-GUID: 8zssqQQb6VIFLiD5ouiZE8y6-rqjJ2A8
X-Authority-Analysis: v=2.4 cv=V9990fni c=1 sm=1 tr=0 ts=6810586a cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=qXg5RoXZXzj2emjSrToA:9
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 mlxscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290033

On 4/25/2025 6:58 AM, Nithyanantham Paramasivam wrote:
> From: Vinith Kumar R <quic_vinithku@quicinc.com>
> 
> Add support for data path related device specific stats. This
> information helps to debug connectivity and performance issues
> in AP, STA, and Mesh modes.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Vinith Kumar R <quic_vinithku@quicinc.com>
> Signed-off-by: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath12k/core.h     |  7 +++++++
>  drivers/net/wireless/ath/ath12k/dp.h       |  3 +++
>  drivers/net/wireless/ath/ath12k/dp_rx.c    |  8 ++++++++
>  drivers/net/wireless/ath/ath12k/dp_tx.c    | 22 ++++++++++++++++++++--
>  drivers/net/wireless/ath/ath12k/hal_desc.h |  5 +++++
>  5 files changed, 43 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index 00c58fc0cc4b..99ef000aad7e 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -891,6 +891,13 @@ struct ath12k_device_dp_stats {
>  	u32 reo_error[HAL_REO_DEST_RING_ERROR_CODE_MAX];
>  	u32 hal_reo_error[DP_REO_DST_RING_MAX];
>  	struct ath12k_device_dp_tx_err_stats tx_err;
> +	u32 reo_rx[DP_REO_DST_RING_MAX][ATH12K_MAX_DEVICES];
> +	u32 rx_wbm_rel_source[HAL_WBM_REL_SRC_MODULE_MAX][ATH12K_MAX_DEVICES];
> +	u32 tqm_rel_reason[MAX_TQM_RELEASE_REASON];
> +	u32 fw_tx_status[MAX_FW_TX_STATUS];
> +	u32 tx_wbm_rel_source[HAL_WBM_REL_SRC_MODULE_MAX];
> +	u32 tx_enqueued[DP_TCL_NUM_RING_MAX];
> +	u32 tx_completed[DP_TCL_NUM_RING_MAX];
>  };
>  
>  struct ath12k_reg_freq {
> diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
> index 706d766d8c81..c4ddf30aa79f 100644
> --- a/drivers/net/wireless/ath/ath12k/dp.h
> +++ b/drivers/net/wireless/ath/ath12k/dp.h
> @@ -266,6 +266,9 @@ struct ath12k_pdev_dp {
>  /* Invalid TX Bank ID value */
>  #define DP_INVALID_BANK_ID -1
>  
> +#define MAX_TQM_RELEASE_REASON 15
> +#define MAX_FW_TX_STATUS 7
> +
>  struct ath12k_dp_tx_bank_profile {
>  	u8 is_configured;
>  	u32 num_users;
> diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
> index e81a117cbc06..313b11421a26 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
> @@ -2835,6 +2835,7 @@ int ath12k_dp_rx_process(struct ath12k_base *ab, int ring_id,
>  				 DMA_FROM_DEVICE);
>  
>  		num_buffs_reaped[device_id]++;
> +		ab->device_stats.reo_rx[ring_id][ab->device_id]++;
>  
>  		push_reason = le32_get_bits(desc->info0,
>  					    HAL_REO_DEST_RING_INFO0_PUSH_REASON);
> @@ -3982,6 +3983,7 @@ int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
>  	int num_buffs_reaped[ATH12K_MAX_DEVICES] = {};
>  	int total_num_buffs_reaped = 0;
>  	struct ath12k_rx_desc_info *desc_info;
> +	struct ath12k_device_dp_stats *device_stats = &ab->device_stats;
>  	struct ath12k_hw_link *hw_links = ag->hw_links;
>  	struct ath12k_base *partner_ab;
>  	u8 hw_link_id, device_id;
> @@ -4155,6 +4157,12 @@ int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
>  			dev_kfree_skb_any(msdu);
>  			continue;
>  		}
> +
> +		if (rxcb->err_rel_src < HAL_WBM_REL_SRC_MODULE_MAX) {
> +			device_id = ar->ab->device_id;
> +			device_stats->rx_wbm_rel_source[rxcb->err_rel_src][device_id]++;
> +		}
> +
>  		ath12k_dp_rx_wbm_err(ar, napi, msdu, &msdu_list);
>  	}
>  	rcu_read_unlock();
> diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
> index 128fa0e3c229..5a2b9c3f5e4b 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_tx.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
> @@ -477,6 +477,8 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
>  		arvif->link_stats.tx_enqueued++;
>  	spin_unlock_bh(&arvif->link_stats_lock);
>  
> +	ab->device_stats.tx_enqueued[ti.ring_id]++;
> +
>  	ath12k_hal_tx_cmd_desc_setup(ab, hal_tcl_desc, &ti);
>  
>  	ath12k_hal_srng_access_end(ab, tcl_ring);
> @@ -557,6 +559,7 @@ ath12k_dp_tx_htt_tx_complete_buf(struct ath12k_base *ab,
>  	info = IEEE80211_SKB_CB(msdu);
>  
>  	ar = skb_cb->ar;
> +	ab->device_stats.tx_completed[tx_ring->tcl_data_ring_id]++;
>  
>  	if (atomic_dec_and_test(&ar->dp.num_tx_pending))
>  		wake_up(&ar->dp.tx_empty_waitq);
> @@ -614,6 +617,7 @@ ath12k_dp_tx_process_htt_tx_complete(struct ath12k_base *ab, void *desc,
>  
>  	wbm_status = le32_get_bits(status_desc->info0,
>  				   HTT_TX_WBM_COMP_INFO0_STATUS);
> +	ab->device_stats.fw_tx_status[wbm_status]++;
>  
>  	switch (wbm_status) {
>  	case HAL_WBM_REL_HTT_TX_COMP_STATUS_OK:
> @@ -760,7 +764,8 @@ static void ath12k_dp_tx_update_txcompl(struct ath12k *ar, struct hal_tx_status
>  
>  static void ath12k_dp_tx_complete_msdu(struct ath12k *ar,
>  				       struct ath12k_tx_desc_params *desc_params,
> -				       struct hal_tx_status *ts)
> +				       struct hal_tx_status *ts,
> +				       int ring)
>  {
>  	struct ath12k_base *ab = ar->ab;
>  	struct ath12k_hw *ah = ar->ah;
> @@ -777,6 +782,7 @@ static void ath12k_dp_tx_complete_msdu(struct ath12k *ar,
>  	}
>  
>  	skb_cb = ATH12K_SKB_CB(msdu);
> +	ab->device_stats.tx_completed[ring]++;
>  
>  	dma_unmap_single(ab->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
>  	if (skb_cb->paddr_ext_desc) {
> @@ -907,6 +913,8 @@ void ath12k_dp_tx_completion_handler(struct ath12k_base *ab, int ring_id)
>  	struct hal_wbm_release_ring *desc;
>  	u8 pdev_id;
>  	u64 desc_va;
> +	enum hal_wbm_rel_src_module buf_rel_source;
> +	enum hal_wbm_tqm_rel_reason rel_status;
>  
>  	spin_lock_bh(&status_ring->lock);
>  
> @@ -963,6 +971,15 @@ void ath12k_dp_tx_completion_handler(struct ath12k_base *ab, int ring_id)
>  		desc_params.skb = tx_desc->skb;
>  		desc_params.skb_ext_desc = tx_desc->skb_ext_desc;
>  
> +		/* Find the HAL_WBM_RELEASE_INFO0_REL_SRC_MODULE value */
> +		buf_rel_source = le32_get_bits(tx_status->info0,
> +					       HAL_WBM_RELEASE_INFO0_REL_SRC_MODULE);
> +		ab->device_stats.tx_wbm_rel_source[buf_rel_source]++;
> +
> +		rel_status = le32_get_bits(tx_status->info0,
> +					   HAL_WBM_COMPL_TX_INFO0_TQM_RELEASE_REASON);
> +		ab->device_stats.tqm_rel_reason[rel_status]++;
> +
>  		/* Release descriptor as soon as extracting necessary info
>  		 * to reduce contention
>  		 */
> @@ -979,7 +996,8 @@ void ath12k_dp_tx_completion_handler(struct ath12k_base *ab, int ring_id)
>  		if (atomic_dec_and_test(&ar->dp.num_tx_pending))
>  			wake_up(&ar->dp.tx_empty_waitq);
>  
> -		ath12k_dp_tx_complete_msdu(ar, &desc_params, &ts);
> +		ath12k_dp_tx_complete_msdu(ar, &desc_params, &ts,
> +					   tx_ring->tcl_data_ring_id);
>  	}
>  }
>  
> diff --git a/drivers/net/wireless/ath/ath12k/hal_desc.h b/drivers/net/wireless/ath/ath12k/hal_desc.h
> index 49eededbfa9d..f31b4a37ee35 100644
> --- a/drivers/net/wireless/ath/ath12k/hal_desc.h
> +++ b/drivers/net/wireless/ath/ath12k/hal_desc.h
> @@ -1008,6 +1008,10 @@ enum hal_reo_entr_rxdma_ecode {
>  	HAL_REO_ENTR_RING_RXDMA_ECODE_FLOW_TIMEOUT_ERR,
>  	HAL_REO_ENTR_RING_RXDMA_ECODE_FLUSH_REQUEST_ERR,
>  	HAL_REO_ENTR_RING_RXDMA_ECODE_AMSDU_FRAG_ERR,
> +	HAL_REO_ENTR_RING_RXDMA_ECODE_MULTICAST_ECHO_ERR,
> +	HAL_REO_ENTR_RING_RXDMA_ECODE_AMSDU_MISMATCH_ERR,
> +	HAL_REO_ENTR_RING_RXDMA_ECODE_UNAUTH_WDS_ERR,
> +	HAL_REO_ENTR_RING_RXDMA_ECODE_GRPCAST_AMSDU_WDS_ERR,
>  	HAL_REO_ENTR_RING_RXDMA_ECODE_MAX,
>  };
>  
> @@ -1809,6 +1813,7 @@ enum hal_wbm_rel_src_module {
>  	HAL_WBM_REL_SRC_MODULE_REO,
>  	HAL_WBM_REL_SRC_MODULE_FW,
>  	HAL_WBM_REL_SRC_MODULE_SW,
> +	HAL_WBM_REL_SRC_MODULE_MAX,
>  };
>  
>  enum hal_wbm_rel_desc_type {

Reviewed-by: Mahendran P <quic_mahep@quicinc.com>


