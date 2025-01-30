Return-Path: <linux-wireless+bounces-18201-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 492DAA228DF
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 07:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E87D163C32
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 06:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855D233987;
	Thu, 30 Jan 2025 06:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ls2fR2Ib"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9872B158A09
	for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 06:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738218171; cv=none; b=o6x+wrmgVJBfgjYbJNymopb1p0UhxUQZvLVMh1gyNVbowjzdAOUcgSZuDtFAM5aFJTqWWdGAw68nJmfo+9sbZ5On/OgPrc1pKBKYNbaT4gjDJtuyTJS6A6pN7915dhE4zh1CQLEWGtPr181e6tzPqv81kmYl0ZWBcGv7Q9Jz0cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738218171; c=relaxed/simple;
	bh=X633afQCxXp7teNr7nwn++0it0TpEYKPIBeWWkpgg0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=c3c2Jg2cW+WUEqOEppRepTAeJUh6nhmkKTm07IBzj8h1tiVtatVGhOeboE93/pQAFlBkCdoFEg1d13IVZdL6o/uWTmWLyjdbkr+YzgBbWbU51927gr1MhcJ/ySRWLntY1eSN0tutFB/Q4EkTcGsDyXTWebeERGz4MB34RneUxW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ls2fR2Ib; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TMkkrh012288;
	Thu, 30 Jan 2025 06:22:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6FEhVCSTOFf9ZfDAMn0AD842alDW+g16B1XhGD2Xzkg=; b=ls2fR2Ib3QEp3bjJ
	ViM2LSphr+VbTMCbWhr8DGUTJrcjMUkRw2P3t6dD1xHm1G7NMl7A2046zHsUhntx
	YbOooKdB6l2yvDXT0NhQR3+cRvDBNZQ4/vnv734f2EJR+A/NIzDuD9kz1nqPumvQ
	OujVbeg/kZaofVzmrNmBTHHLF9LQ2tV4BXbpnVQDzQIw9l8WzH4m6NtHUb1kbmCU
	3DKYcHYd3UbiwHBsWSAliQIwmgFCIJfimgH/Gn3a42szUQexI1N5LQCNLfo1oQYt
	0ZniLnIXi3Ek2hCASj+kViC0sPE0mW8MhzdlZGRNUFCiSgUtL4g4LZITCW+TJgnk
	r5Bxog==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44fwe28p5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 06:22:38 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50U6MbLW005183
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 06:22:37 GMT
Received: from [10.216.38.203] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 29 Jan
 2025 22:22:35 -0800
Message-ID: <63417693-a9aa-bec4-f20d-ebff2fe7a26e@quicinc.com>
Date: Thu, 30 Jan 2025 11:52:32 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] wifi: ath12k: move firmware stats out of debugfs
Content-Language: en-US
To: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<aditya.kumar.singh@oss.qualcomm.com>
References: <20250127172202.1410429-1-rameshkumar.sundaram@oss.qualcomm.com>
 <20250127172202.1410429-2-rameshkumar.sundaram@oss.qualcomm.com>
From: Mahendran P <quic_mahep@quicinc.com>
In-Reply-To: <20250127172202.1410429-2-rameshkumar.sundaram@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XVCt_y-3SyywNgIZ6kHUzw5FTA4_8jvP
X-Proofpoint-GUID: XVCt_y-3SyywNgIZ6kHUzw5FTA4_8jvP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_03,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 clxscore=1011 malwarescore=0 adultscore=0 phishscore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501300047

On 1/27/2025 10:52 PM, Rameshkumar Sundaram wrote:
> From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
> 
> Currently, firmware stats, comprising pdev, vdev and beacon stats are
> part of debugfs. In firmware pdev stats, firmware reports the final
> Tx power used to transmit each packet. If driver wants to know the
> final Tx power being used at firmware level, it can leverage from
> firmware pdev stats.
> 
> Move firmware stats out of debugfs context in order to leverage
> the final Tx power reported in it even when debugfs is disabled.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
> Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath12k/core.c    | 45 +++++++++++
>  drivers/net/wireless/ath/ath12k/core.h    |  3 +
>  drivers/net/wireless/ath/ath12k/debugfs.c | 44 +----------
>  drivers/net/wireless/ath/ath12k/wmi.c     | 94 ++++++++++++++++++-----
>  4 files changed, 124 insertions(+), 62 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
> index 2dd0666959cd..122b407cd322 100644
> --- a/drivers/net/wireless/ath/ath12k/core.c
> +++ b/drivers/net/wireless/ath/ath12k/core.c
> @@ -1052,6 +1052,51 @@ bool ath12k_core_hw_group_start_ready(struct ath12k_hw_group *ag)
>  	return (ag->num_started == ag->num_devices);
>  }
>  
> +static void ath12k_fw_stats_pdevs_free(struct list_head *head)
> +{
> +	struct ath12k_fw_stats_pdev *i, *tmp;
> +
> +	list_for_each_entry_safe(i, tmp, head, list) {
> +		list_del(&i->list);
> +		kfree(i);
> +	}
> +}
> +
> +void ath12k_fw_stats_bcn_free(struct list_head *head)
> +{
> +	struct ath12k_fw_stats_bcn *i, *tmp;
> +
> +	list_for_each_entry_safe(i, tmp, head, list) {
> +		list_del(&i->list);
> +		kfree(i);
> +	}
> +}
> +
> +static void ath12k_fw_stats_vdevs_free(struct list_head *head)
> +{
> +	struct ath12k_fw_stats_vdev *i, *tmp;
> +
> +	list_for_each_entry_safe(i, tmp, head, list) {
> +		list_del(&i->list);
> +		kfree(i);
> +	}
> +}
> +
> +void ath12k_fw_stats_init(struct ath12k *ar)
> +{
> +	INIT_LIST_HEAD(&ar->fw_stats.vdevs);
> +	INIT_LIST_HEAD(&ar->fw_stats.pdevs);
> +	INIT_LIST_HEAD(&ar->fw_stats.bcn);
> +	init_completion(&ar->fw_stats_complete);
> +}
> +
> +void ath12k_fw_stats_free(struct ath12k_fw_stats *stats)
> +{
> +	ath12k_fw_stats_pdevs_free(&stats->pdevs);
> +	ath12k_fw_stats_vdevs_free(&stats->vdevs);
> +	ath12k_fw_stats_bcn_free(&stats->bcn);
> +}
> +
>  static void ath12k_core_trigger_partner(struct ath12k_base *ab)
>  {
>  	struct ath12k_hw_group *ag = ab->ag;
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index 28db100cfac0..e4f51ad6a59f 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -1198,6 +1198,9 @@ u32 ath12k_core_get_max_peers_per_radio(struct ath12k_base *ab);
>  u32 ath12k_core_get_max_num_tids(struct ath12k_base *ab);
>  
>  void ath12k_core_hw_group_set_mlo_capable(struct ath12k_hw_group *ag);
> +void ath12k_fw_stats_init(struct ath12k *ar);
> +void ath12k_fw_stats_bcn_free(struct list_head *head);
> +void ath12k_fw_stats_free(struct ath12k_fw_stats *stats);
>  
>  static inline const char *ath12k_scan_state_str(enum ath12k_scan_state state)
>  {
> diff --git a/drivers/net/wireless/ath/ath12k/debugfs.c b/drivers/net/wireless/ath/ath12k/debugfs.c
> index 6d6708486d14..4e4c2ef6a7ce 100644
> --- a/drivers/net/wireless/ath/ath12k/debugfs.c
> +++ b/drivers/net/wireless/ath/ath12k/debugfs.c
> @@ -69,43 +69,11 @@ void ath12k_debugfs_soc_destroy(struct ath12k_base *ab)
>  	 */
>  }
>  
> -static void ath12k_fw_stats_pdevs_free(struct list_head *head)
> -{
> -	struct ath12k_fw_stats_pdev *i, *tmp;
> -
> -	list_for_each_entry_safe(i, tmp, head, list) {
> -		list_del(&i->list);
> -		kfree(i);
> -	}
> -}
> -
> -static void ath12k_fw_stats_bcn_free(struct list_head *head)
> -{
> -	struct ath12k_fw_stats_bcn *i, *tmp;
> -
> -	list_for_each_entry_safe(i, tmp, head, list) {
> -		list_del(&i->list);
> -		kfree(i);
> -	}
> -}
> -
> -static void ath12k_fw_stats_vdevs_free(struct list_head *head)
> -{
> -	struct ath12k_fw_stats_vdev *i, *tmp;
> -
> -	list_for_each_entry_safe(i, tmp, head, list) {
> -		list_del(&i->list);
> -		kfree(i);
> -	}
> -}
> -
>  void ath12k_debugfs_fw_stats_reset(struct ath12k *ar)
>  {
>  	spin_lock_bh(&ar->data_lock);
>  	ar->fw_stats.fw_stats_done = false;
> -	ath12k_fw_stats_vdevs_free(&ar->fw_stats.vdevs);
> -	ath12k_fw_stats_bcn_free(&ar->fw_stats.bcn);
> -	ath12k_fw_stats_pdevs_free(&ar->fw_stats.pdevs);
> +	ath12k_fw_stats_free(&ar->fw_stats);
>  	spin_unlock_bh(&ar->data_lock);
>  }
>  
> @@ -221,10 +189,6 @@ ath12k_debugfs_fw_stats_process(struct ath12k *ar,
>  			num_bcn = 0;
>  		}
>  	}
> -	if (stats->stats_id == WMI_REQUEST_PDEV_STAT) {
> -		list_splice_tail_init(&stats->pdevs, &ar->fw_stats.pdevs);
> -		ar->fw_stats.fw_stats_done = true;
> -	}
>  }
>  
>  static int ath12k_open_vdev_stats(struct inode *inode, struct file *file)
> @@ -438,11 +402,7 @@ void ath12k_debugfs_fw_stats_register(struct ath12k *ar)
>  	debugfs_create_file("pdev_stats", 0600, fwstats_dir, ar,
>  			    &fops_pdev_stats);
>  
> -	INIT_LIST_HEAD(&ar->fw_stats.vdevs);
> -	INIT_LIST_HEAD(&ar->fw_stats.bcn);
> -	INIT_LIST_HEAD(&ar->fw_stats.pdevs);
> -
> -	init_completion(&ar->fw_stats_complete);
> +	ath12k_fw_stats_init(ar);
>  }
>  
>  void ath12k_debugfs_register(struct ath12k *ar)
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
> index 61aa5f509338..1a7af09853a4 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.c
> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> @@ -29,6 +29,7 @@ struct ath12k_wmi_svc_ready_parse {
>  
>  struct wmi_tlv_fw_stats_parse {
>  	const struct wmi_stats_event *ev;
> +	struct ath12k_fw_stats *stats;
>  };
>  
>  struct ath12k_wmi_dma_ring_caps_parse {
> @@ -7314,7 +7315,7 @@ static int ath12k_wmi_tlv_fw_stats_data_parse(struct ath12k_base *ab,
>  					      u16 len)
>  {
>  	const struct wmi_stats_event *ev = parse->ev;
> -	struct ath12k_fw_stats stats = {0};
> +	struct ath12k_fw_stats *stats = parse->stats;

make sure to add null check before using stats pointer

>  	struct ath12k *ar;
>  	struct ath12k_link_vif *arvif;
>  	struct ieee80211_sta *sta;
> @@ -7323,10 +7324,6 @@ static int ath12k_wmi_tlv_fw_stats_data_parse(struct ath12k_base *ab,
>  	int i, ret = 0;
>  	const void *data = ptr;
>  
> -	INIT_LIST_HEAD(&stats.vdevs);
> -	INIT_LIST_HEAD(&stats.bcn);
> -	INIT_LIST_HEAD(&stats.pdevs);
> -
>  	if (!ev) {
>  		ath12k_warn(ab, "failed to fetch update stats ev");
>  		return -EPROTO;
> @@ -7334,7 +7331,8 @@ static int ath12k_wmi_tlv_fw_stats_data_parse(struct ath12k_base *ab,
>  
>  	rcu_read_lock();
>  
> -	ar = ath12k_mac_get_ar_by_pdev_id(ab, le32_to_cpu(ev->pdev_id));
> +	stats->pdev_id = le32_to_cpu(ev->pdev_id);
> +	ar = ath12k_mac_get_ar_by_pdev_id(ab, stats->pdev_id);
>  	if (!ar) {
>  		ath12k_warn(ab, "invalid pdev id %d in update stats event\n",
>  			    le32_to_cpu(ev->pdev_id));
> @@ -7377,8 +7375,8 @@ static int ath12k_wmi_tlv_fw_stats_data_parse(struct ath12k_base *ab,
>  		if (!dst)
>  			continue;
>  		ath12k_wmi_pull_vdev_stats(src, dst);
> -		stats.stats_id = WMI_REQUEST_VDEV_STAT;
> -		list_add_tail(&dst->list, &stats.vdevs);
> +		stats->stats_id = WMI_REQUEST_VDEV_STAT;
> +		list_add_tail(&dst->list, &stats->vdevs);
>  	}
>  	for (i = 0; i < le32_to_cpu(ev->num_bcn_stats); i++) {
>  		const struct ath12k_wmi_bcn_stats_params *src;
> @@ -7396,8 +7394,8 @@ static int ath12k_wmi_tlv_fw_stats_data_parse(struct ath12k_base *ab,
>  		if (!dst)
>  			continue;
>  		ath12k_wmi_pull_bcn_stats(src, dst);
> -		stats.stats_id = WMI_REQUEST_BCN_STAT;
> -		list_add_tail(&dst->list, &stats.bcn);
> +		stats->stats_id = WMI_REQUEST_BCN_STAT;
> +		list_add_tail(&dst->list, &stats->bcn);
>  	}
>  	for (i = 0; i < le32_to_cpu(ev->num_pdev_stats); i++) {
>  		const struct ath12k_wmi_pdev_stats_params *src;
> @@ -7409,7 +7407,7 @@ static int ath12k_wmi_tlv_fw_stats_data_parse(struct ath12k_base *ab,
>  			goto exit;
>  		}
>  
> -		stats.stats_id = WMI_REQUEST_PDEV_STAT;
> +		stats->stats_id = WMI_REQUEST_PDEV_STAT;
>  
>  		data += sizeof(*src);
>  		len -= sizeof(*src);
> @@ -7421,11 +7419,9 @@ static int ath12k_wmi_tlv_fw_stats_data_parse(struct ath12k_base *ab,
>  		ath12k_wmi_pull_pdev_stats_base(&src->base, dst);
>  		ath12k_wmi_pull_pdev_stats_tx(&src->tx, dst);
>  		ath12k_wmi_pull_pdev_stats_rx(&src->rx, dst);
> -		list_add_tail(&dst->list, &stats.pdevs);
> +		list_add_tail(&dst->list, &stats->pdevs);
>  	}
>  
> -	complete(&ar->fw_stats_complete);
> -	ath12k_debugfs_fw_stats_process(ar, &stats);
>  exit:
>  	rcu_read_unlock();
>  	return ret;
> @@ -7451,16 +7447,74 @@ static int ath12k_wmi_tlv_fw_stats_parse(struct ath12k_base *ab,
>  	return ret;
>  }
>  
> +static int ath12k_wmi_pull_fw_stats(struct ath12k_base *ab, struct sk_buff *skb,
> +				    struct ath12k_fw_stats *stats)
> +{
> +	struct wmi_tlv_fw_stats_parse parse = {};
> +
> +	stats->stats_id = 0;
> +	parse.stats = stats;
> +
> +	return ath12k_wmi_tlv_iter(ab, skb->data, skb->len,
> +				   ath12k_wmi_tlv_fw_stats_parse,
> +				   &parse);
> +}
> +
>  static void ath12k_update_stats_event(struct ath12k_base *ab, struct sk_buff *skb)
>  {
> +	struct ath12k_fw_stats stats = {};
> +	struct ath12k *ar;
>  	int ret;
> -	struct wmi_tlv_fw_stats_parse parse = {};
>  
> -	ret = ath12k_wmi_tlv_iter(ab, skb->data, skb->len,
> -				  ath12k_wmi_tlv_fw_stats_parse,
> -				  &parse);
> -	if (ret)
> -		ath12k_warn(ab, "failed to parse fw stats %d\n", ret);
> +	INIT_LIST_HEAD(&stats.pdevs);
> +	INIT_LIST_HEAD(&stats.vdevs);
> +	INIT_LIST_HEAD(&stats.bcn);
> +
> +	ret = ath12k_wmi_pull_fw_stats(ab, skb, &stats);
> +	if (ret) {
> +		ath12k_warn(ab, "failed to pull fw stats: %d\n", ret);
> +		goto free;
> +	}
> +
> +	ath12k_dbg(ab, ATH12K_DBG_WMI, "event update stats");
> +
> +	rcu_read_lock();
> +	ar = ath12k_mac_get_ar_by_pdev_id(ab, stats.pdev_id);
> +	if (!ar) {
> +		rcu_read_unlock();
> +		ath12k_warn(ab, "failed to get ar for pdev_id %d: %d\n",
> +			    stats.pdev_id, ret);
> +		goto free;
> +	}
> +
> +	spin_lock_bh(&ar->data_lock);
> +
> +	/* WMI_REQUEST_PDEV_STAT can be requested via .get_txpower mac ops or via
> +	 * debugfs fw stats. Therefore, processing it separately.
> +	 */
> +	if (stats.stats_id == WMI_REQUEST_PDEV_STAT) {
> +		list_splice_tail_init(&stats.pdevs, &ar->fw_stats.pdevs);
> +		ar->fw_stats.fw_stats_done = true;
> +		goto complete;
> +	}
> +
> +	/* WMI_REQUEST_VDEV_STAT and WMI_REQUEST_BCN_STAT are currently requested only
> +	 * via debugfs fw stats. Hence, processing these in debugfs context.
> +	 */
> +	ath12k_debugfs_fw_stats_process(ar, &stats);
> +
> +complete:
> +	complete(&ar->fw_stats_complete);
> +	spin_unlock_bh(&ar->data_lock);
> +	rcu_read_unlock();
> +
> +	/* Since the stats's pdev, vdev and beacon list are spliced and reinitialised
> +	 * at this point, no need to free the individual list.
> +	 */
> +	return;
> +
> +free:
> +	ath12k_fw_stats_free(&stats);
>  }
>  
>  /* PDEV_CTL_FAILSAFE_CHECK_EVENT is received from FW when the frequency scanned


