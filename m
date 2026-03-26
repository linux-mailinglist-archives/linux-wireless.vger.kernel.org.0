Return-Path: <linux-wireless+bounces-34019-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIDbCB7CxWnfBQUAu9opvQ
	(envelope-from <linux-wireless+bounces-34019-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 00:32:46 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CB233D15F
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 00:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A0F3304AD1B
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 23:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462DC3BE645;
	Thu, 26 Mar 2026 23:32:41 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF573BED28
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 23:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774567960; cv=none; b=Czu98+2KQH6JG5AIJ+lBWJQOJAbfgAg7VEFGxb/mRZOKR7yr3JAimmG/qluW5iMKp+wIAClGJuYH7ChavtX6cNZLPciiH+y3KtA0T7y8IXed8vLZXMUcKx2ytVYw4rhvWvE4sqJQdQXOQgveR0daXiWPCwKfieMG+aTy8nPmhZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774567960; c=relaxed/simple;
	bh=xGTGXikS4JqfrfKY/gM0rFRga49Ih2vR19rEFj5+2dk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=NgAJ7c8m7JLBqryUrqILWJLsYVXkghID6fdh2i4lwxSn+Z3B1KHo1/sam7WvHTRtzPTGMWpO9k2hdoro3oTygNuqt4X+ZQtSH8G3z91dAKc6Nas4z6Xu6MbeVB5sguUtFezflfeF1MD4hawv9vIUD+PZnYjzqDeuXKSdUUPMM50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.14.115] (v115.vpnx.molgen.mpg.de [141.14.14.115])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6602C4C2C37F0A;
	Fri, 27 Mar 2026 00:32:00 +0100 (CET)
Message-ID: <7af13762-3e98-4d77-bde2-c14cdb3b1e3c@molgen.mpg.de>
Date: Fri, 27 Mar 2026 00:31:59 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH ath-current] wifi: ath10k: fix station lookup failure
 during disconnect
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
 Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
References: <20260325-ath10k-station-lookup-failure-v1-1-2e0c970f25d5@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260325-ath10k-station-lookup-failure-v1-1-2e0c970f25d5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-34019-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mpg.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,molgen.mpg.de:mid]
X-Rspamd-Queue-Id: 87CB233D15F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Dear Baochen,


Thank you for sending the patch out.

Am 25.03.26 um 04:05 schrieb Baochen Qiang:
> Recent commit [1] moved station statistics collection to an earlier stage
> of the disconnect flow. With this change in place, ath10k fails to resolve
> the station entry when handling a peer stats event triggered during
> disconnect, resulting in log messages such as:
> 
> wlp58s0: deauthenticating from 74:1a:e0:e7:b4:c8 by local choice (Reason: 3=DEAUTH_LEAVING)
> ath10k_pci 0000:3a:00.0: not found station for peer stats
> ath10k_pci 0000:3a:00.0: failed to parse stats info tlv: -22
> 
> The failure occurs because ath10k relies on ieee80211_find_sta_by_ifaddr()
> for station lookup. That function uses local->sta_hash, but by the time
> the peer stats request is triggered during disconnect, mac80211 has
> already removed the station from that hash table, leading to lookup
> failure.
> 
> Before commit [1], this issue was not visible because the transition from
> IEEE80211_STA_NONE to IEEE80211_STA_NOTEXIST prevented ath10k from sending
> a peer stats request at all: ath10k_mac_sta_get_peer_stats_info() would
> fail early to find the peer and skip requesting statistics.
> 
> Fix this by switching the lookup path to ath10k_peer_find(), which queries
> ath10k's internal peer table. At the point where the firmware emits the
> peer stats event, the peer entry is still present in the driver's list,
> ensuring lookup succeeds.

Out of curiosity, how can the statistics be printed?

> Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00309-QCARMSWPZ-1
> 
> Fixes: a203dbeeca15 ("wifi: mac80211: collect station statistics earlier when disconnect") # [1]
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Closes: https://lore.kernel.org/ath10k/57671b89-ec9f-4e6c-992c-45eb8e75929c@molgen.mpg.de
> Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
> ---
>   drivers/net/wireless/ath/ath10k/wmi-tlv.c | 26 +++++++++++++++-----------
>   1 file changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
> index ec8e91707f84..01f2d1fa9d7d 100644
> --- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
> +++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
> @@ -3,7 +3,7 @@
>    * Copyright (c) 2005-2011 Atheros Communications Inc.
>    * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
>    * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
> - * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>    */
>   #include "core.h"
>   #include "debug.h"
> @@ -14,6 +14,7 @@
>   #include "wmi-tlv.h"
>   #include "p2p.h"
>   #include "testmode.h"
> +#include "txrx.h"
>   #include <linux/bitfield.h>
>   
>   /***************/
> @@ -224,8 +225,9 @@ static int ath10k_wmi_tlv_parse_peer_stats_info(struct ath10k *ar, u16 tag, u16
>   						const void *ptr, void *data)
>   {
>   	const struct wmi_tlv_peer_stats_info *stat = ptr;
> -	struct ieee80211_sta *sta;
> +	u32 vdev_id = *(u32 *)data;
>   	struct ath10k_sta *arsta;
> +	struct ath10k_peer *peer;
>   
>   	if (tag != WMI_TLV_TAG_STRUCT_PEER_STATS_INFO)
>   		return -EPROTO;
> @@ -241,20 +243,20 @@ static int ath10k_wmi_tlv_parse_peer_stats_info(struct ath10k *ar, u16 tag, u16
>   		   __le32_to_cpu(stat->last_tx_rate_code),
>   		   __le32_to_cpu(stat->last_tx_bitrate_kbps));
>   
> -	rcu_read_lock();
> -	sta = ieee80211_find_sta_by_ifaddr(ar->hw, stat->peer_macaddr.addr, NULL);
> -	if (!sta) {
> -		rcu_read_unlock();
> -		ath10k_warn(ar, "not found station for peer stats\n");
> +	guard(spinlock_bh)(&ar->data_lock);
> +
> +	peer = ath10k_peer_find(ar, vdev_id, stat->peer_macaddr.addr);
> +	if (!peer || !peer->sta) {
> +		ath10k_warn(ar, "not found %s with vdev id %u mac addr %pM for peer stats\n",
> +			    peer ? "sta" : "peer", vdev_id, stat->peer_macaddr.addr);
>   		return -EINVAL;
>   	}
>   
> -	arsta = (struct ath10k_sta *)sta->drv_priv;
> +	arsta = (struct ath10k_sta *)peer->sta->drv_priv;
>   	arsta->rx_rate_code = __le32_to_cpu(stat->last_rx_rate_code);
>   	arsta->rx_bitrate_kbps = __le32_to_cpu(stat->last_rx_bitrate_kbps);
>   	arsta->tx_rate_code = __le32_to_cpu(stat->last_tx_rate_code);
>   	arsta->tx_bitrate_kbps = __le32_to_cpu(stat->last_tx_bitrate_kbps);
> -	rcu_read_unlock();
>   
>   	return 0;
>   }
> @@ -266,6 +268,7 @@ static int ath10k_wmi_tlv_op_pull_peer_stats_info(struct ath10k *ar,
>   	const struct wmi_tlv_peer_stats_info_ev *ev;
>   	const void *data;
>   	u32 num_peer_stats;
> +	u32 vdev_id;
>   	int ret;
>   
>   	tb = ath10k_wmi_tlv_parse_alloc(ar, skb->data, skb->len, GFP_ATOMIC);
> @@ -284,15 +287,16 @@ static int ath10k_wmi_tlv_op_pull_peer_stats_info(struct ath10k *ar,
>   	}
>   
>   	num_peer_stats = __le32_to_cpu(ev->num_peers);
> +	vdev_id = __le32_to_cpu(ev->vdev_id);
>   
>   	ath10k_dbg(ar, ATH10K_DBG_WMI,
>   		   "wmi tlv peer stats info update peer vdev id %d peers %i more data %d\n",
> -		   __le32_to_cpu(ev->vdev_id),
> +		   vdev_id,
>   		   num_peer_stats,
>   		   __le32_to_cpu(ev->more_data));
>   
>   	ret = ath10k_wmi_tlv_iter(ar, data, ath10k_wmi_tlv_len(data),
> -				  ath10k_wmi_tlv_parse_peer_stats_info, NULL);
> +				  ath10k_wmi_tlv_parse_peer_stats_info, &vdev_id);
>   	if (ret)
>   		ath10k_warn(ar, "failed to parse stats info tlv: %d\n", ret);

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

