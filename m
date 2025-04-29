Return-Path: <linux-wireless+bounces-22176-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 684E0AA016E
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 06:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 674E93A3EAC
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 04:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B5E21ABC1;
	Tue, 29 Apr 2025 04:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NByx44ts"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC67F1EEE0
	for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 04:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745901660; cv=none; b=QmOppYHl35IQeiW1H9s6o3fn7NbllnQ9e2vGt54fAGeLKgnqVNQE2xemmte6rYPDRS1/bO2uSornef1TugzSEYdyDXFd+JkNBhnn8pvDKQCrfWNXUQwqjjBTPxOuJ5eDqhwhEbAxXbCLWhQLdD30Y+xLGtzSKzUluIcqwDxfyMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745901660; c=relaxed/simple;
	bh=UqCjP2MU6+viURYxysYzrluUDGWtYyWsaPrbxWPjD0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HXf++ouMXGZBHtGiQihYjPobQJzLY4B0cR4aZwahUYyhsxkbWkM/BMEv70JAefmXU7Q8p7P2BoWMbbkrVB441F83nk4Am0ct9SktCIb/jvp/yDkPvAoU/9lBYmkFpNv1kBliH6bOeQixY0ZgPoWPUNjRILcYLYwsBMGwyRyELSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NByx44ts; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SNqJfQ015499;
	Tue, 29 Apr 2025 04:40:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NYHOGFHnRhcK8xUFqBsu/DGhNM8+kJExqx1CyO//Dng=; b=NByx44tsZPqZcr/T
	K4NrQd/0j7F4OaC7fWgS4wpRtlJ5xYlhpQMpDSHYkeo+Yy0sWQnMQORLGNHpLl4s
	EhVlOfB0NYygis6lxfsMRJvEy68sIEAxqIWBjHDAjvRT/Mj4nyIygzZgDkZXo0lv
	IcX4AqKNTjlMaJZa+/1P/c4BzC813ejJ0lJpvW2EdxHbwMeYHwE7HWe5wyD67tQl
	u5CSqnzw8vkB8PK3xQerom+A6vxHEAC1UVnp5nEQoVwwqwjEXpRRbylV4QeJPpK4
	pOnliiG1LkitHxrb3CTdmarHP7te+/xhJv/5AlMcYbpfxnqVOkw3RQxExychgTlP
	J1UhQQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 468qjwu7b4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 04:40:55 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53T4eseg020223
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 04:40:54 GMT
Received: from [10.216.24.29] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 28 Apr
 2025 21:40:52 -0700
Message-ID: <f6640c30-051b-4745-9d53-0d1c636a37dc@quicinc.com>
Date: Tue, 29 Apr 2025 10:10:49 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 1/3] wifi: ath12k: change soc name to device name
To: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Vinith Kumar R
	<quic_vinithku@quicinc.com>
References: <20250425012802.698914-1-nithyanantham.paramasivam@oss.qualcomm.com>
 <20250425012802.698914-2-nithyanantham.paramasivam@oss.qualcomm.com>
From: Mahendran P <quic_mahep@quicinc.com>
Content-Language: en-US
In-Reply-To: <20250425012802.698914-2-nithyanantham.paramasivam@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: se4WS5A3ZFnkVaEq2XbkP52BMtMD9gg0
X-Proofpoint-GUID: se4WS5A3ZFnkVaEq2XbkP52BMtMD9gg0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDAzMyBTYWx0ZWRfX+S4BarEGPZyt M7V7inEQnr//0j8X93wU20X/MRxg3WWuv0RSia4qIeqOClbShGjLP1fzqGPIUOkSqcxx88u/kmN 21vi3MXIqMiIyBXsZ84JPLRYEat+SA6Zmgz6TxfKUh9KHE8j9PyWOyR9iZUhaaJJMyOnfCXB3aW
 l6l2/Y2HWq7lrT46kXu87OsboC5A0RenMHhQZd+JqqrxNz3fDkbInCdfb62ZheY3OwgVuFkmSDV ORQ0Da0r889ThXMibhQeHbbo+BRdmtoHxv3fxk86sErZq4ddF56y0J3393Q7awuyVziqWHVS12B mlKS2q+R3oXfGaaHIAJOIg9cgHIKn/g7pZSu8jh4A802bC3k3nAkKv2rHmAfHrPdBBshM10rawr
 0BgwO6eayV7gArbCwQTup1kIkZ07s/eXxy2bdYlwdtfNXM45FsMTVMrNrNUcxy489FSbjJ6y
X-Authority-Analysis: v=2.4 cv=c/urQQ9l c=1 sm=1 tr=0 ts=68105857 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=tUqX22Vw91dtVU9NDxsA:9
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0 malwarescore=0
 clxscore=1015 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290033

On 4/25/2025 6:58 AM, Nithyanantham Paramasivam wrote:
> From: Vinith Kumar R <quic_vinithku@quicinc.com>
> 
> To have consistent nomenclature, replace the use of the term "soc"
> with the term "device".
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Vinith Kumar R <quic_vinithku@quicinc.com>
> Signed-off-by: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath12k/core.c   |  4 +--
>  drivers/net/wireless/ath/ath12k/core.h   | 16 +++++------
>  drivers/net/wireless/ath/ath12k/dp_rx.c  | 36 ++++++++++++------------
>  drivers/net/wireless/ath/ath12k/dp_tx.c  |  6 ++--
>  drivers/net/wireless/ath/ath12k/hal_rx.c |  6 ++--
>  5 files changed, 34 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
> index 7eccd9cf9036..2cfeb853289d 100644
> --- a/drivers/net/wireless/ath/ath12k/core.c
> +++ b/drivers/net/wireless/ath/ath12k/core.c
> @@ -1812,9 +1812,9 @@ static int ath12k_core_get_wsi_info(struct ath12k_hw_group *ag,
>  		of_node_put(next_rx_endpoint);
>  
>  		device_count++;
> -		if (device_count > ATH12K_MAX_SOCS) {
> +		if (device_count > ATH12K_MAX_DEVICES) {
>  			ath12k_warn(ab, "device count in DT %d is more than limit %d\n",
> -				    device_count, ATH12K_MAX_SOCS);
> +				    device_count, ATH12K_MAX_DEVICES);
>  			of_node_put(next_wsi_dev);
>  			return -EINVAL;
>  		}
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index 4b8f434e3e9a..00c58fc0cc4b 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -63,8 +63,8 @@
>  #define ATH12K_RECONFIGURE_TIMEOUT_HZ		(10 * HZ)
>  #define ATH12K_RECOVER_START_TIMEOUT_HZ		(20 * HZ)
>  
> -#define ATH12K_MAX_SOCS 3
> -#define ATH12K_GROUP_MAX_RADIO (ATH12K_MAX_SOCS * MAX_RADIOS)
> +#define ATH12K_MAX_DEVICES 3
> +#define ATH12K_GROUP_MAX_RADIO (ATH12K_MAX_DEVICES * MAX_RADIOS)
>  #define ATH12K_INVALID_GROUP_ID  0xFF
>  #define ATH12K_INVALID_DEVICE_ID 0xFF
>  
> @@ -875,7 +875,7 @@ struct ath12k_board_data {
>  	size_t len;
>  };
>  
> -struct ath12k_soc_dp_tx_err_stats {
> +struct ath12k_device_dp_tx_err_stats {
>  	/* TCL Ring Descriptor unavailable */
>  	u32 desc_na[DP_TCL_NUM_RING_MAX];
>  	/* Other failures during dp_tx due to mem allocation failure
> @@ -884,13 +884,13 @@ struct ath12k_soc_dp_tx_err_stats {
>  	atomic_t misc_fail;
>  };
>  
> -struct ath12k_soc_dp_stats {
> +struct ath12k_device_dp_stats {
>  	u32 err_ring_pkts;
>  	u32 invalid_rbm;
>  	u32 rxdma_error[HAL_REO_ENTR_RING_RXDMA_ECODE_MAX];
>  	u32 reo_error[HAL_REO_DEST_RING_ERROR_CODE_MAX];
>  	u32 hal_reo_error[DP_REO_DST_RING_MAX];
> -	struct ath12k_soc_dp_tx_err_stats tx_err;
> +	struct ath12k_device_dp_tx_err_stats tx_err;
>  };
>  
>  struct ath12k_reg_freq {
> @@ -919,7 +919,7 @@ struct ath12k_hw_group {
>  	u8 num_probed;
>  	u8 num_started;
>  	unsigned long flags;
> -	struct ath12k_base *ab[ATH12K_MAX_SOCS];
> +	struct ath12k_base *ab[ATH12K_MAX_DEVICES];
>  
>  	/* protects access to this struct */
>  	struct mutex mutex;
> @@ -933,7 +933,7 @@ struct ath12k_hw_group {
>  	struct ath12k_hw *ah[ATH12K_GROUP_MAX_RADIO];
>  	u8 num_hw;
>  	bool mlo_capable;
> -	struct device_node *wsi_node[ATH12K_MAX_SOCS];
> +	struct device_node *wsi_node[ATH12K_MAX_DEVICES];
>  	struct ath12k_mlo_memory mlo_mem;
>  	struct ath12k_hw_link hw_links[ATH12K_GROUP_MAX_RADIO];
>  	bool hw_link_id_init_done;
> @@ -1043,7 +1043,7 @@ struct ath12k_base {
>  
>  	/* Current DFS Regulatory */
>  	enum ath12k_dfs_region dfs_region;
> -	struct ath12k_soc_dp_stats soc_stats;
> +	struct ath12k_device_dp_stats device_stats;
>  #ifdef CONFIG_ATH12K_DEBUGFS
>  	struct dentry *debugfs_soc;
>  #endif
> diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
> index 1abfbd15f13c..e81a117cbc06 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
> @@ -2592,7 +2592,7 @@ static bool ath12k_dp_rx_check_nwifi_hdr_len_valid(struct ath12k_base *ab,
>  	if ((likely(hdr_len <= DP_MAX_NWIFI_HDR_LEN)))
>  		return true;
>  
> -	ab->soc_stats.invalid_rbm++;
> +	ab->device_stats.invalid_rbm++;
>  	WARN_ON_ONCE(1);
>  	return false;
>  }
> @@ -2755,9 +2755,9 @@ int ath12k_dp_rx_process(struct ath12k_base *ab, int ring_id,
>  			 struct napi_struct *napi, int budget)
>  {
>  	struct ath12k_hw_group *ag = ab->ag;
> -	struct list_head rx_desc_used_list[ATH12K_MAX_SOCS];
> +	struct list_head rx_desc_used_list[ATH12K_MAX_DEVICES];
>  	struct ath12k_hw_link *hw_links = ag->hw_links;
> -	int num_buffs_reaped[ATH12K_MAX_SOCS] = {};
> +	int num_buffs_reaped[ATH12K_MAX_DEVICES] = {};
>  	struct ath12k_rx_desc_info *desc_info;
>  	struct ath12k_dp *dp = &ab->dp;
>  	struct dp_rxdma_ring *rx_ring = &dp->rx_refill_buf_ring;
> @@ -2774,7 +2774,7 @@ int ath12k_dp_rx_process(struct ath12k_base *ab, int ring_id,
>  
>  	__skb_queue_head_init(&msdu_list);
>  
> -	for (device_id = 0; device_id < ATH12K_MAX_SOCS; device_id++)
> +	for (device_id = 0; device_id < ATH12K_MAX_DEVICES; device_id++)
>  		INIT_LIST_HEAD(&rx_desc_used_list[device_id]);
>  
>  	srng = &ab->hal.srng_list[dp->reo_dst_ring[ring_id].ring_id];
> @@ -2841,7 +2841,7 @@ int ath12k_dp_rx_process(struct ath12k_base *ab, int ring_id,
>  		if (push_reason !=
>  		    HAL_REO_DEST_RING_PUSH_REASON_ROUTING_INSTRUCTION) {
>  			dev_kfree_skb_any(msdu);
> -			ab->soc_stats.hal_reo_error[ring_id]++;
> +			ab->device_stats.hal_reo_error[ring_id]++;
>  			continue;
>  		}
>  
> @@ -2891,7 +2891,7 @@ int ath12k_dp_rx_process(struct ath12k_base *ab, int ring_id,
>  	if (!total_msdu_reaped)
>  		goto exit;
>  
> -	for (device_id = 0; device_id < ATH12K_MAX_SOCS; device_id++) {
> +	for (device_id = 0; device_id < ATH12K_MAX_DEVICES; device_id++) {
>  		if (!num_buffs_reaped[device_id])
>  			continue;
>  
> @@ -3608,9 +3608,9 @@ int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
>  			     int budget)
>  {
>  	struct ath12k_hw_group *ag = ab->ag;
> -	struct list_head rx_desc_used_list[ATH12K_MAX_SOCS];
> +	struct list_head rx_desc_used_list[ATH12K_MAX_DEVICES];
>  	u32 msdu_cookies[HAL_NUM_RX_MSDUS_PER_LINK_DESC];
> -	int num_buffs_reaped[ATH12K_MAX_SOCS] = {};
> +	int num_buffs_reaped[ATH12K_MAX_DEVICES] = {};
>  	struct dp_link_desc_bank *link_desc_banks;
>  	enum hal_rx_buf_return_buf_manager rbm;
>  	struct hal_rx_msdu_link *link_desc_va;
> @@ -3632,7 +3632,7 @@ int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
>  	tot_n_bufs_reaped = 0;
>  	quota = budget;
>  
> -	for (device_id = 0; device_id < ATH12K_MAX_SOCS; device_id++)
> +	for (device_id = 0; device_id < ATH12K_MAX_DEVICES; device_id++)
>  		INIT_LIST_HEAD(&rx_desc_used_list[device_id]);
>  
>  	reo_except = &ab->dp.reo_except_ring;
> @@ -3646,7 +3646,7 @@ int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
>  	while (budget &&
>  	       (reo_desc = ath12k_hal_srng_dst_get_next_entry(ab, srng))) {
>  		drop = false;
> -		ab->soc_stats.err_ring_pkts++;
> +		ab->device_stats.err_ring_pkts++;
>  
>  		ret = ath12k_hal_desc_reo_parse_err(ab, reo_desc, &paddr,
>  						    &desc_bank);
> @@ -3673,7 +3673,7 @@ int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
>  		if (rbm != partner_ab->dp.idle_link_rbm &&
>  		    rbm != HAL_RX_BUF_RBM_SW3_BM &&
>  		    rbm != partner_ab->hw_params->hal_params->rx_buf_rbm) {
> -			ab->soc_stats.invalid_rbm++;
> +			ab->device_stats.invalid_rbm++;
>  			ath12k_warn(ab, "invalid return buffer manager %d\n", rbm);
>  			ath12k_dp_rx_link_desc_return(partner_ab, reo_desc,
>  						      HAL_WBM_REL_BM_ACT_REL_MSDU);
> @@ -3720,7 +3720,7 @@ int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
>  
>  	spin_unlock_bh(&srng->lock);
>  
> -	for (device_id = 0; device_id < ATH12K_MAX_SOCS; device_id++) {
> +	for (device_id = 0; device_id < ATH12K_MAX_DEVICES; device_id++) {
>  		if (!num_buffs_reaped[device_id])
>  			continue;
>  
> @@ -3836,7 +3836,7 @@ static bool ath12k_dp_rx_h_reo_err(struct ath12k *ar, struct sk_buff *msdu,
>  	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
>  	bool drop = false;
>  
> -	ar->ab->soc_stats.reo_error[rxcb->err_code]++;
> +	ar->ab->device_stats.reo_error[rxcb->err_code]++;
>  
>  	switch (rxcb->err_code) {
>  	case HAL_REO_DEST_RING_ERROR_CODE_DESC_ADDR_ZERO:
> @@ -3909,7 +3909,7 @@ static bool ath12k_dp_rx_h_rxdma_err(struct ath12k *ar,  struct sk_buff *msdu,
>  	bool drop = false;
>  	u32 err_bitmap;
>  
> -	ar->ab->soc_stats.rxdma_error[rxcb->err_code]++;
> +	ar->ab->device_stats.rxdma_error[rxcb->err_code]++;
>  
>  	switch (rxcb->err_code) {
>  	case HAL_REO_ENTR_RING_RXDMA_ECODE_DECRYPT_ERR:
> @@ -3968,7 +3968,7 @@ static void ath12k_dp_rx_wbm_err(struct ath12k *ar,
>  int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
>  				 struct napi_struct *napi, int budget)
>  {
> -	struct list_head rx_desc_used_list[ATH12K_MAX_SOCS];
> +	struct list_head rx_desc_used_list[ATH12K_MAX_DEVICES];
>  	struct ath12k_hw_group *ag = ab->ag;
>  	struct ath12k *ar;
>  	struct ath12k_dp *dp = &ab->dp;
> @@ -3979,7 +3979,7 @@ int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
>  	struct sk_buff_head msdu_list, scatter_msdu_list;
>  	struct ath12k_skb_rxcb *rxcb;
>  	void *rx_desc;
> -	int num_buffs_reaped[ATH12K_MAX_SOCS] = {};
> +	int num_buffs_reaped[ATH12K_MAX_DEVICES] = {};
>  	int total_num_buffs_reaped = 0;
>  	struct ath12k_rx_desc_info *desc_info;
>  	struct ath12k_hw_link *hw_links = ag->hw_links;
> @@ -3991,7 +3991,7 @@ int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
>  	__skb_queue_head_init(&msdu_list);
>  	__skb_queue_head_init(&scatter_msdu_list);
>  
> -	for (device_id = 0; device_id < ATH12K_MAX_SOCS; device_id++)
> +	for (device_id = 0; device_id < ATH12K_MAX_DEVICES; device_id++)
>  		INIT_LIST_HEAD(&rx_desc_used_list[device_id]);
>  
>  	srng = &ab->hal.srng_list[dp->rx_rel_ring.ring_id];
> @@ -4115,7 +4115,7 @@ int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
>  	if (!total_num_buffs_reaped)
>  		goto done;
>  
> -	for (device_id = 0; device_id < ATH12K_MAX_SOCS; device_id++) {
> +	for (device_id = 0; device_id < ATH12K_MAX_DEVICES; device_id++) {
>  		if (!num_buffs_reaped[device_id])
>  			continue;
>  
> diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
> index 2136eeb278af..128fa0e3c229 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_tx.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
> @@ -350,7 +350,7 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
>  	default:
>  		/* TODO: Take care of other encap modes as well */
>  		ret = -EINVAL;
> -		atomic_inc(&ab->soc_stats.tx_err.misc_fail);
> +		atomic_inc(&ab->device_stats.tx_err.misc_fail);
>  		goto fail_remove_tx_buf;
>  	}
>  
> @@ -373,7 +373,7 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
>  map:
>  	ti.paddr = dma_map_single(ab->dev, skb->data, skb->len, DMA_TO_DEVICE);
>  	if (dma_mapping_error(ab->dev, ti.paddr)) {
> -		atomic_inc(&ab->soc_stats.tx_err.misc_fail);
> +		atomic_inc(&ab->device_stats.tx_err.misc_fail);
>  		ath12k_warn(ab, "failed to DMA map data Tx buffer\n");
>  		ret = -ENOMEM;
>  		goto fail_remove_tx_buf;
> @@ -448,7 +448,7 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
>  		 * desc because the desc is directly enqueued onto hw queue.
>  		 */
>  		ath12k_hal_srng_access_end(ab, tcl_ring);
> -		ab->soc_stats.tx_err.desc_na[ti.ring_id]++;
> +		ab->device_stats.tx_err.desc_na[ti.ring_id]++;
>  		spin_unlock_bh(&tcl_ring->lock);
>  		ret = -ENOMEM;
>  
> diff --git a/drivers/net/wireless/ath/ath12k/hal_rx.c b/drivers/net/wireless/ath/ath12k/hal_rx.c
> index 98eeccc68fcd..38af714b313e 100644
> --- a/drivers/net/wireless/ath/ath12k/hal_rx.c
> +++ b/drivers/net/wireless/ath/ath12k/hal_rx.c
> @@ -326,7 +326,7 @@ int ath12k_hal_desc_reo_parse_err(struct ath12k_base *ab,
>  				    HAL_REO_DEST_RING_INFO0_PUSH_REASON);
>  	err_code = le32_get_bits(desc->info0,
>  				 HAL_REO_DEST_RING_INFO0_ERROR_CODE);
> -	ab->soc_stats.reo_error[err_code]++;
> +	ab->device_stats.reo_error[err_code]++;
>  
>  	if (push_reason != HAL_REO_DEST_RING_PUSH_REASON_ERR_DETECTED &&
>  	    push_reason != HAL_REO_DEST_RING_PUSH_REASON_ROUTING_INSTRUCTION) {
> @@ -381,7 +381,7 @@ int ath12k_hal_wbm_desc_parse_err(struct ath12k_base *ab, void *desc,
>  		val = le32_get_bits(wbm_desc->buf_addr_info.info1,
>  				    BUFFER_ADDR_INFO1_RET_BUF_MGR);
>  		if (val != HAL_RX_BUF_RBM_SW3_BM) {
> -			ab->soc_stats.invalid_rbm++;
> +			ab->device_stats.invalid_rbm++;
>  			return -EINVAL;
>  		}
>  
> @@ -393,7 +393,7 @@ int ath12k_hal_wbm_desc_parse_err(struct ath12k_base *ab, void *desc,
>  		val = le32_get_bits(wbm_cc_desc->info0,
>  				    HAL_WBM_RELEASE_RX_CC_INFO0_RBM);
>  		if (val != HAL_RX_BUF_RBM_SW3_BM) {
> -			ab->soc_stats.invalid_rbm++;
> +			ab->device_stats.invalid_rbm++;
>  			return -EINVAL;
>  		}
>  

Reviewed-by: Mahendran P <quic_mahep@quicinc.com>


