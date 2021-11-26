Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193DB45EB2D
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Nov 2021 11:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352966AbhKZKWB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Nov 2021 05:22:01 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:40122 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376644AbhKZKUB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Nov 2021 05:20:01 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637921808; h=Content-Type: MIME-Version: Message-ID: Date:
 References: In-Reply-To: Subject: Cc: To: From: Sender;
 bh=0gyYyj3E60srR37rnxeKVpgoau3J62kmCxQ0vQTWTKc=; b=i8YmzmmUZ5ArsBphe9mxqVbljcWwLlYRC5B2c+qNpT4rtnCMus6zH86KBdkI0N/CM7g7xST2
 diXqzb+TMWnHlkkjB0ZsuF+0rJIcqRh0xB6nnhpjNRMtcohvqs0wo6hbwCgeh2y08TBq6wlz
 0lcc5nyO63zu+PID2o7NlKtW6B8=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 61a0b40f4fca5da46d46b23c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 26 Nov 2021 10:16:47
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9EA22C4360D; Fri, 26 Nov 2021 10:16:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F0838C43616;
        Fri, 26 Nov 2021 10:16:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org F0838C43616
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2] ath11k: report rssi of each chain to mac80211
In-Reply-To: <20211118102331.10726-1-quic_wgong@quicinc.com> (Wen Gong's
        message of "Thu, 18 Nov 2021 05:23:31 -0500")
References: <20211118102331.10726-1-quic_wgong@quicinc.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Fri, 26 Nov 2021 12:16:40 +0200
Message-ID: <871r335iif.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> writes:

> Command "iw wls1 station dump" does not show each chain's rssi currently.
>
> This patch is to change like this:
> If the rssi of each chain from mon status is invalid, then ath11k send
> wmi cmd WMI_REQUEST_STATS_CMDID with flag WMI_REQUEST_RSSI_PER_CHAIN_STAT
> to firmware, and parse the rssi of chain in wmi WMI_UPDATE_STATS_EVENTID,
> then report them to mac80211.

A bit more information about the design would be nice. With mon status I
guess you mean ath11k_hal_rx_parse_mon_status()? How is performance and
power consumption affected here? Especially I'm worried how often this
new WMI command is sent, is it only when ath11k_mac_op_sta_statistics()
is called?

And I think this only works when CONFIG_ATH11K_DEBUGFS is enabled,
right?

> --- a/drivers/net/wireless/ath/ath11k/core.h
> +++ b/drivers/net/wireless/ath/ath11k/core.h
> @@ -382,6 +382,7 @@ struct ath11k_sta {
>  	u64 rx_duration;
>  	u64 tx_duration;
>  	u8 rssi_comb;
> +	s8 chain_signal[IEEE80211_MAX_CHAINS];
>  	struct ath11k_htt_tx_stats *tx_stats;
>  	struct ath11k_rx_peer_stats *rx_stats;
>  
> @@ -412,6 +413,12 @@ enum ath11k_state {
>  /* Antenna noise floor */
>  #define ATH11K_DEFAULT_NOISE_FLOOR -95
>  
> +/* signed value, 11111111h, it is full bit value, invalid */
> +#define ATH11K_INVALID_RSSI_FULL -1

The comment is really providing any value, please remove.

> +/* signed value, 10000000h, it is empty value, invalid */
> +#define ATH11K_INVALID_RSSI_EMPTY -128

Same here.

> --- a/drivers/net/wireless/ath/ath11k/debugfs.h
> +++ b/drivers/net/wireless/ath/ath11k/debugfs.h
> @@ -117,6 +117,7 @@ void ath11k_debugfs_unregister(struct ath11k *ar);
>  void ath11k_debugfs_fw_stats_process(struct ath11k_base *ab, struct sk_buff *skb);
>  
>  void ath11k_debugfs_fw_stats_init(struct ath11k *ar);
> +int ath11k_debug_get_fw_stats(struct ath11k *ar, u32 pdev_id, u32 vdev_id, u32 stats_id);

ath11k_debugfs_get_fw_stats

> --- a/drivers/net/wireless/ath/ath11k/hal_rx.c
> +++ b/drivers/net/wireless/ath/ath11k/hal_rx.c
> @@ -1080,6 +1080,9 @@ ath11k_hal_rx_parse_mon_status_tlv(struct ath11k_base *ab,
>  		break;
>  	}
>  	case HAL_PHYRX_RSSI_LEGACY: {
> +		int i;
> +		bool db2dbm = test_bit(WMI_TLV_SERVICE_HW_DB2DBM_CONVERSION_SUPPORT,
> +				       ab->wmi_ab.svc_map);
>  		struct hal_rx_phyrx_rssi_legacy_info *rssi =
>  			(struct hal_rx_phyrx_rssi_legacy_info *)tlv_data;
>  
> @@ -1090,6 +1093,16 @@ ath11k_hal_rx_parse_mon_status_tlv(struct ath11k_base *ab,
>  		ppdu_info->rssi_comb =
>  			FIELD_GET(HAL_RX_PHYRX_RSSI_LEGACY_INFO_INFO1_RSSI_COMB,
>  				  __le32_to_cpu(rssi->info0));
> +
> +		if (db2dbm) {
> +			for (i = 0; i < ARRAY_SIZE(rssi->preamble); i++) {
> +				u32 rssi2040 = __le32_to_cpu(rssi->preamble[i].rssi_2040);
> +
> +				ppdu_info->rssi_chain_pri20[i] =
> +					FIELD_GET(HAL_RX_PHYRX_RSSI_PREAMBLE_PRI20,
> +						  rssi2040);

le32_get_bits() makes the code simpler.

>  int ath11k_wmi_pull_fw_stats(struct ath11k_base *ab, struct sk_buff *skb,
>  			     struct ath11k_fw_stats *stats)
>  {
> +	struct ath11k *ar;
>  	const void **tb;
>  	const struct wmi_stats_event *ev;
> +	const struct wmi_per_chain_rssi_stats *rssi;
> +	const struct wmi_rssi_stats *stats_rssi;
> +	struct ieee80211_sta *sta;
> +	struct ath11k_sta *arsta;
>  	const void *data;
> -	int i, ret;
> +	const struct wmi_tlv *tlv;
> +	u16 tlv_tag, tlv_len;
> +	int i, ret, rssi_num = 0;
>  	u32 len = skb->len;
>  
>  	tb = ath11k_wmi_tlv_parse_alloc(ab, skb->data, len, GFP_ATOMIC);
> @@ -5447,12 +5456,18 @@ int ath11k_wmi_pull_fw_stats(struct ath11k_base *ab, struct sk_buff *skb,
>  
>  	ev = tb[WMI_TAG_STATS_EVENT];
>  	data = tb[WMI_TAG_ARRAY_BYTE];
> +	rssi = tb[WMI_TAG_PER_CHAIN_RSSI_STATS];
>  	if (!ev || !data) {
>  		ath11k_warn(ab, "failed to fetch update stats ev");
>  		kfree(tb);
>  		return -EPROTO;
>  	}
>  
> +	if (rssi && (ev->stats_id & WMI_REQUEST_RSSI_PER_CHAIN_STAT))
> +		rssi_num = rssi->num_per_chain_rssi_stats;
> +
> +	ar = ath11k_mac_get_ar_by_pdev_id(ab, ev->pdev_id);
> +
>  	ath11k_dbg(ab, ATH11K_DBG_WMI,
>  		   "wmi stats update ev pdev_id %d pdev %i vdev %i bcn %i\n",
>  		   ev->pdev_id,
> @@ -5533,6 +5548,96 @@ int ath11k_wmi_pull_fw_stats(struct ath11k_base *ab, struct sk_buff *skb,
>  		list_add_tail(&dst->list, &stats->bcn);
>  	}
>  
> +	ath11k_dbg(ab, ATH11K_DBG_WMI,
> +		   "wmi stats id 0x%x num chain %d\n",
> +		   ev->stats_id,
> +		   rssi_num);
> +
> +	if (rssi_num) {
> +		/* This TLV of WMI_TAG_PER_CHAIN_RSSI_STATS is followed by
> +		 * another TLV of array of structs
> +		 * wmi_rssi_stats rssi_stats[num_per_chain_rssi_stats].
> +		 * So add check integrity for the TLVs.
> +		 * rssi is behind the TLV of WMI_TAG_PER_CHAIN_RSSI_STATS.
> +		 */
> +		tlv = (struct wmi_tlv *)((u8 *)rssi - sizeof(*tlv));
> +		tlv_len = FIELD_GET(WMI_TLV_LEN, tlv->header);
> +
> +		/* Skip wmi_per_chain_rssi_stats to get the TLV of array structs */
> +		tlv = (struct wmi_tlv *)((u8 *)rssi + tlv_len);
> +		if (((u8 *)tlv - skb->data) >= skb->len)
> +			goto fin;
> +
> +		tlv_tag = FIELD_GET(WMI_TLV_TAG, tlv->header);
> +		if (tlv_tag != WMI_TAG_ARRAY_STRUCT)
> +			rssi_num = 0;
> +
> +		/* Skip array struct TLV to get the array of structs */
> +		tlv++;
> +		if (((u8 *)tlv - skb->data) >= skb->len)
> +			goto fin;
> +
> +		tlv_len = FIELD_GET(WMI_TLV_LEN, tlv->header);
> +	}
> +
> +	for (i = 0; i < rssi_num; i++) {
> +		struct ath11k_vif *arvif;
> +		int j;
> +
> +		stats_rssi = (struct wmi_rssi_stats *)((u8 *)tlv + i *
> +			(sizeof(*tlv) + tlv_len));
> +		if (((u8 *)stats_rssi - skb->data) >= skb->len)
> +			goto fin;
> +
> +		tlv_tag = FIELD_GET(WMI_TLV_TAG, stats_rssi->tlv_header);
> +		if (tlv_tag != WMI_TAG_RSSI_STATS) {
> +			ath11k_warn(ab, "invalid rssi stats TLV data\n");
> +			break;
> +		}

In this function there's a lot of pointer arithmetic and casting, can't
you use ath11k_wmi_tlv_parse_alloc() & friends for parsing the TLVs?

> --- a/drivers/net/wireless/ath/ath11k/wmi.h
> +++ b/drivers/net/wireless/ath/ath11k/wmi.h
> @@ -4394,6 +4394,20 @@ struct wmi_stats_event {
>  	u32 num_peer_extd2_stats;
>  } __packed;
>  
> +#define WMI_MAX_CHAINS 8

This is already defined on line 27.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
