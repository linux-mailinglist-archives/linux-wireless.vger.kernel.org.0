Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1036469402
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Dec 2021 11:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237997AbhLFKnS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Dec 2021 05:43:18 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:35823 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237966AbhLFKnS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Dec 2021 05:43:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638787189; x=1670323189;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OPdkGArWcWfjTqAuLVBeNO1DiIN0RvTpNRqvo2IMEuk=;
  b=Rx1qwq+Bx+PUJyQ3lgI8Jng9X3aWAq7OC5R6N8aoV2fIBouoXICGyrIX
   eLb2iPshDKZpljhDGp0wLsDQwgGbhlPlZRiSY9eklv5Aive0n0glRxVJD
   ybdr1orxx05gFninFHfLpGd3m1PlPGgJ4i2E+rORc4TPR96rKXVxUsO8+
   0=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 06 Dec 2021 02:39:49 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 02:39:46 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 6 Dec 2021 02:39:45 -0800
Received: from [10.231.195.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 6 Dec 2021
 02:39:44 -0800
Message-ID: <1a56923f-af70-cdfe-8d89-e3ef111bab72@quicinc.com>
Date:   Mon, 6 Dec 2021 18:39:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2] ath11k: report rssi of each chain to mac80211
Content-Language: en-US
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20211118102331.10726-1-quic_wgong@quicinc.com>
 <871r335iif.fsf@codeaurora.org>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <871r335iif.fsf@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/26/2021 6:16 PM, Kalle Valo wrote:
> Wen Gong <quic_wgong@quicinc.com> writes:
>
>> Command "iw wls1 station dump" does not show each chain's rssi currently.
>>
>> This patch is to change like this:
>> If the rssi of each chain from mon status is invalid, then ath11k send
>> wmi cmd WMI_REQUEST_STATS_CMDID with flag WMI_REQUEST_RSSI_PER_CHAIN_STAT
>> to firmware, and parse the rssi of chain in wmi WMI_UPDATE_STATS_EVENTID,
>> then report them to mac80211.
> A bit more information about the design would be nice. With mon status I
> guess you mean ath11k_hal_rx_parse_mon_status()? How is performance and
> power consumption affected here? Especially I'm worried how often this
> new WMI command is sent, is it only when ath11k_mac_op_sta_statistics()
> is called?

yes, it is ath11k_hal_rx_parse_mon_status().

I did a test in Ubuntu20, after STATION connected to AP, ath11k_mac_op_sta_statistics()
is only called each 6 seconds by NetworkManager in below stack.
This patch is similar with "ath10k: add rx bitrate report for SDIO"(https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/drivers/net/wireless/ath/ath10k?id=0f7cb26830a6e740455a7064e46ff1e926197ecb). And it does not
impact performance. Also the 1 wmi/event for each 6 seconds does not impact power consumption.

Also I add check similar with ath10k/SDIO only for WCN6855/QCA6390.

[  797.005587] CPU: 0 PID: 701 Comm: NetworkManager Tainted: G        W  
OE     5.13.0-rc6-wt-ath+ #2
[  797.005596] Hardware name: LENOVO 418065C/418065C, BIOS 83ET63WW 
(1.33 ) 07/29/2011
[  797.005600] RIP: 0010:ath11k_mac_op_sta_statistics+0x2f/0x1b0 [ath11k]
[  797.005644] Code: 41 56 41 55 4c 8d aa 58 01 00 00 41 54 55 48 89 d5 
53 48 8b 82 58 01 00 00 48 89 cb 4c 8b 70 20 49 8b 06 4c 8b a0 90 08 00 
00 <0f> 0b 48 8b 82 b8 01 00 00 48 ba 00 00 00 00 01 00 00 00 48 89 81
[  797.005651] RSP: 0018:ffffb1fc80a4b890 EFLAGS: 00010282
[  797.005658] RAX: ffff8a5726200000 RBX: ffffb1fc80a4b958 RCX: 
ffffb1fc80a4b958
[  797.005664] RDX: ffff8a5726a609f0 RSI: ffff8a581247f598 RDI: 
ffff8a5702878800
[  797.005668] RBP: ffff8a5726a609f0 R08: 0000000000000000 R09: 
0000000000000000
[  797.005672] R10: 0000000000000000 R11: 0000000000000007 R12: 
02dd68024f75f480
[  797.005676] R13: ffff8a5726a60b48 R14: ffff8a5702879f40 R15: 
ffff8a5726a60000
[  797.005681] FS:  00007f632c52a380(0000) GS:ffff8a583a200000(0000) 
knlGS:0000000000000000
[  797.005687] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  797.005692] CR2: 00007fb025d69000 CR3: 00000001124f6005 CR4: 
00000000000606f0
[  797.005698] Call Trace:
[  797.005710]  sta_set_sinfo+0xa7/0xb80 [mac80211]
[  797.005820]  ieee80211_get_station+0x50/0x70 [mac80211]
[  797.005925]  nl80211_get_station+0xd1/0x200 [cfg80211]
[  797.006045]  genl_family_rcv_msg_doit.isra.15+0x111/0x140
[  797.006059]  genl_rcv_msg+0xe6/0x1e0
[  797.006065]  ? nl80211_dump_station+0x220/0x220 [cfg80211]
[  797.006223]  ? nl80211_send_station.isra.72+0xf50/0xf50 [cfg80211]
[  797.006348]  ? genl_family_rcv_msg_doit.isra.15+0x140/0x140
[  797.006355]  netlink_rcv_skb+0xb9/0xf0
[  797.006363]  genl_rcv+0x24/0x40
[  797.006369]  netlink_unicast+0x18e/0x290
[  797.006375]  netlink_sendmsg+0x30f/0x450
[  797.006382]  sock_sendmsg+0x5b/0x60
[  797.006393]  ____sys_sendmsg+0x219/0x240
[  797.006403]  ? copy_msghdr_from_user+0x5c/0x90
[  797.006413]  ? ____sys_recvmsg+0xf5/0x190
[  797.006422]  ___sys_sendmsg+0x88/0xd0
[  797.006432]  ? copy_msghdr_from_user+0x5c/0x90
[  797.006443]  ? ___sys_recvmsg+0x9e/0xd0
[  797.006454]  ? __fget_files+0x58/0x90
[  797.006461]  ? __fget_light+0x2d/0x70
[  797.006466]  ? do_epoll_wait+0xce/0x720
[  797.006476]  ? __sys_sendmsg+0x63/0xa0
[  797.006485]  __sys_sendmsg+0x63/0xa0
[  797.006497]  do_syscall_64+0x3c/0xb0
[  797.006509]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  797.006519] RIP: 0033:0x7f632d99912d
[  797.006526] Code: 28 89 54 24 1c 48 89 74 24 10 89 7c 24 08 e8 ca ee 
ff ff 8b 54 24 1c 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 2e 00 00 00 0f 
05 <48> 3d 00 f0 ff ff 77 2f 44 89 c7 48 89 44 24 08 e8 fe ee ff ff 48
[  797.006533] RSP: 002b:00007ffd80808c00 EFLAGS: 00000293 ORIG_RAX: 
000000000000002e
[  797.006540] RAX: ffffffffffffffda RBX: 0000563dab99d840 RCX: 
00007f632d99912d
[  797.006545] RDX: 0000000000000000 RSI: 00007ffd80808c50 RDI: 
000000000000000b
[  797.006549] RBP: 00007ffd80808c50 R08: 0000000000000000 R09: 
0000000000001000
[  797.006552] R10: 0000563dab96f010 R11: 0000000000000293 R12: 
0000563dab99d840
[  797.006556] R13: 0000563dabbb28c0 R14: 00007f632dad4280 R15: 
0000563dabab11c0
[  797.006563] ---[ end trace c9dcf08920c9945c ]---

>
> And I think this only works when CONFIG_ATH11K_DEBUGFS is enabled,
> right?
yes, if not enable CONFIG_ATH11K_DEBUGFS, then no value get from firmware.
>> --- a/drivers/net/wireless/ath/ath11k/core.h
>> +++ b/drivers/net/wireless/ath/ath11k/core.h
>> @@ -382,6 +382,7 @@ struct ath11k_sta {
>>   	u64 rx_duration;
>>   	u64 tx_duration;
>>   	u8 rssi_comb;
>> +	s8 chain_signal[IEEE80211_MAX_CHAINS];
>>   	struct ath11k_htt_tx_stats *tx_stats;
>>   	struct ath11k_rx_peer_stats *rx_stats;
>>   
>> @@ -412,6 +413,12 @@ enum ath11k_state {
>>   /* Antenna noise floor */
>>   #define ATH11K_DEFAULT_NOISE_FLOOR -95
>>   
>> +/* signed value, 11111111h, it is full bit value, invalid */
>> +#define ATH11K_INVALID_RSSI_FULL -1
> The comment is really providing any value, please remove.
Ok, will remove the comment
>> +/* signed value, 10000000h, it is empty value, invalid */
>> +#define ATH11K_INVALID_RSSI_EMPTY -128
> Same here.
Ok, will remove the comment
>> --- a/drivers/net/wireless/ath/ath11k/debugfs.h
>> +++ b/drivers/net/wireless/ath/ath11k/debugfs.h
>> @@ -117,6 +117,7 @@ void ath11k_debugfs_unregister(struct ath11k *ar);
>>   void ath11k_debugfs_fw_stats_process(struct ath11k_base *ab, struct sk_buff *skb);
>>   
>>   void ath11k_debugfs_fw_stats_init(struct ath11k *ar);
>> +int ath11k_debug_get_fw_stats(struct ath11k *ar, u32 pdev_id, u32 vdev_id, u32 stats_id);
> ath11k_debugfs_get_fw_stats
will change it.
>
>> --- a/drivers/net/wireless/ath/ath11k/hal_rx.c
>> +++ b/drivers/net/wireless/ath/ath11k/hal_rx.c
>> @@ -1080,6 +1080,9 @@ ath11k_hal_rx_parse_mon_status_tlv(struct ath11k_base *ab,
>>   		break;
>>   	}
>>   	case HAL_PHYRX_RSSI_LEGACY: {
>> +		int i;
>> +		bool db2dbm = test_bit(WMI_TLV_SERVICE_HW_DB2DBM_CONVERSION_SUPPORT,
>> +				       ab->wmi_ab.svc_map);
>>   		struct hal_rx_phyrx_rssi_legacy_info *rssi =
>>   			(struct hal_rx_phyrx_rssi_legacy_info *)tlv_data;
>>   
>> @@ -1090,6 +1093,16 @@ ath11k_hal_rx_parse_mon_status_tlv(struct ath11k_base *ab,
>>   		ppdu_info->rssi_comb =
>>   			FIELD_GET(HAL_RX_PHYRX_RSSI_LEGACY_INFO_INFO1_RSSI_COMB,
>>   				  __le32_to_cpu(rssi->info0));
>> +
>> +		if (db2dbm) {
>> +			for (i = 0; i < ARRAY_SIZE(rssi->preamble); i++) {
>> +				u32 rssi2040 = __le32_to_cpu(rssi->preamble[i].rssi_2040);
>> +
>> +				ppdu_info->rssi_chain_pri20[i] =
>> +					FIELD_GET(HAL_RX_PHYRX_RSSI_PREAMBLE_PRI20,
>> +						  rssi2040);
> le32_get_bits() makes the code simpler.
ok.
>
>>   int ath11k_wmi_pull_fw_stats(struct ath11k_base *ab, struct sk_buff *skb,
>>   			     struct ath11k_fw_stats *stats)
>>   {
>> +	struct ath11k *ar;
>>   	const void **tb;
>>   	const struct wmi_stats_event *ev;
>> +	const struct wmi_per_chain_rssi_stats *rssi;
>> +	const struct wmi_rssi_stats *stats_rssi;
>> +	struct ieee80211_sta *sta;
>> +	struct ath11k_sta *arsta;
>>   	const void *data;
>> -	int i, ret;
>> +	const struct wmi_tlv *tlv;
>> +	u16 tlv_tag, tlv_len;
>> +	int i, ret, rssi_num = 0;
>>   	u32 len = skb->len;
>>   
>>   	tb = ath11k_wmi_tlv_parse_alloc(ab, skb->data, len, GFP_ATOMIC);
>> @@ -5447,12 +5456,18 @@ int ath11k_wmi_pull_fw_stats(struct ath11k_base *ab, struct sk_buff *skb,
>>   
>>   	ev = tb[WMI_TAG_STATS_EVENT];
>>   	data = tb[WMI_TAG_ARRAY_BYTE];
>> +	rssi = tb[WMI_TAG_PER_CHAIN_RSSI_STATS];
>>   	if (!ev || !data) {
>>   		ath11k_warn(ab, "failed to fetch update stats ev");
>>   		kfree(tb);
>>   		return -EPROTO;
>>   	}
>>   
>> +	if (rssi && (ev->stats_id & WMI_REQUEST_RSSI_PER_CHAIN_STAT))
>> +		rssi_num = rssi->num_per_chain_rssi_stats;
>> +
>> +	ar = ath11k_mac_get_ar_by_pdev_id(ab, ev->pdev_id);
>> +
>>   	ath11k_dbg(ab, ATH11K_DBG_WMI,
>>   		   "wmi stats update ev pdev_id %d pdev %i vdev %i bcn %i\n",
>>   		   ev->pdev_id,
>> @@ -5533,6 +5548,96 @@ int ath11k_wmi_pull_fw_stats(struct ath11k_base *ab, struct sk_buff *skb,
>>   		list_add_tail(&dst->list, &stats->bcn);
>>   	}
>>   
>> +	ath11k_dbg(ab, ATH11K_DBG_WMI,
>> +		   "wmi stats id 0x%x num chain %d\n",
>> +		   ev->stats_id,
>> +		   rssi_num);
>> +
>> +	if (rssi_num) {
>> +		/* This TLV of WMI_TAG_PER_CHAIN_RSSI_STATS is followed by
>> +		 * another TLV of array of structs
>> +		 * wmi_rssi_stats rssi_stats[num_per_chain_rssi_stats].
>> +		 * So add check integrity for the TLVs.
>> +		 * rssi is behind the TLV of WMI_TAG_PER_CHAIN_RSSI_STATS.
>> +		 */
>> +		tlv = (struct wmi_tlv *)((u8 *)rssi - sizeof(*tlv));
>> +		tlv_len = FIELD_GET(WMI_TLV_LEN, tlv->header);
>> +
>> +		/* Skip wmi_per_chain_rssi_stats to get the TLV of array structs */
>> +		tlv = (struct wmi_tlv *)((u8 *)rssi + tlv_len);
>> +		if (((u8 *)tlv - skb->data) >= skb->len)
>> +			goto fin;
>> +
>> +		tlv_tag = FIELD_GET(WMI_TLV_TAG, tlv->header);
>> +		if (tlv_tag != WMI_TAG_ARRAY_STRUCT)
>> +			rssi_num = 0;
>> +
>> +		/* Skip array struct TLV to get the array of structs */
>> +		tlv++;
>> +		if (((u8 *)tlv - skb->data) >= skb->len)
>> +			goto fin;
>> +
>> +		tlv_len = FIELD_GET(WMI_TLV_LEN, tlv->header);
>> +	}
>> +
>> +	for (i = 0; i < rssi_num; i++) {
>> +		struct ath11k_vif *arvif;
>> +		int j;
>> +
>> +		stats_rssi = (struct wmi_rssi_stats *)((u8 *)tlv + i *
>> +			(sizeof(*tlv) + tlv_len));
>> +		if (((u8 *)stats_rssi - skb->data) >= skb->len)
>> +			goto fin;
>> +
>> +		tlv_tag = FIELD_GET(WMI_TLV_TAG, stats_rssi->tlv_header);
>> +		if (tlv_tag != WMI_TAG_RSSI_STATS) {
>> +			ath11k_warn(ab, "invalid rssi stats TLV data\n");
>> +			break;
>> +		}
> In this function there's a lot of pointer arithmetic and casting, can't
> you use ath11k_wmi_tlv_parse_alloc() & friends for parsing the TLVs?
will change like ath11k_wmi_tlv_dma_buf_parse().
>> --- a/drivers/net/wireless/ath/ath11k/wmi.h
>> +++ b/drivers/net/wireless/ath/ath11k/wmi.h
>> @@ -4394,6 +4394,20 @@ struct wmi_stats_event {
>>   	u32 num_peer_extd2_stats;
>>   } __packed;
>>   
>> +#define WMI_MAX_CHAINS 8
> This is already defined on line 27.
>
