Return-Path: <linux-wireless+bounces-11019-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A81BB9495FA
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 18:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 513DF281C95
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 16:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B3647A66;
	Tue,  6 Aug 2024 16:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dvEGv7G7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B2A46434;
	Tue,  6 Aug 2024 16:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722963433; cv=none; b=X20q+ldrP/HnUsoId1DZR7TQFN5NNTF3r/uFLYWbMxDXzd3Rnu+nqZnnEcV90O2VTZTu0iOfJlZsKGMwbSo9ooLemXa1D4emXAVl132mNgePyi+T2+FdlLcvnaFLUz3YOOZvni5f5kmr8McHaq1W1Ww4rJGICZHd0Q2CD9sZ33k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722963433; c=relaxed/simple;
	bh=yXSSj0OKIjSuoijmFTTFpnwQq3sFBOvfEK9wVIIxsdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WOO2HV/wlh7iHvY9xgtVK6ehMObY6idkoHcJWLMSUrmYvIiwWvp2EN0N7LFVImMmSYm0KPW8/QFTOKuHaqXhG01uYkMfN+19bQ+Wf859Zx3rqhVwtFsvmNQkAY+gOpCwCnw5IuhGodwQO2m6FKZdsbU1YGlJKp3J54LNR3zyEnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dvEGv7G7; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 476GukMk116693;
	Tue, 6 Aug 2024 11:56:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722963406;
	bh=mQjTipe4OQ4FhVMs34OkjvA09o7h2p1kQzb44d14ZWY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=dvEGv7G7+qXmiwA/K6ohQL/PqOgrmx5mepJVFP6QUi58eiEY10VP52ucI84pUroCW
	 C9PdLNlTdY/DESV29BNNCSUDh+XJgEpfr/OJqzhIv18fCoYlTv9/UXtu4jpa7ZEIXG
	 s6g6X9vv+JRllEQ+AIy0M6yTFB8bC/N2TPapDunk=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 476GukoC064220
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Aug 2024 11:56:46 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Aug 2024 11:56:45 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Aug 2024 11:56:45 -0500
Received: from [10.250.212.206] ([10.250.212.206])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 476GugcT027612;
	Tue, 6 Aug 2024 11:56:43 -0500
Message-ID: <dd1864c2-70db-4df0-beb2-814c7e26afb1@ti.com>
Date: Tue, 6 Aug 2024 19:56:42 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/17] Add cc33xx.h, cc33xx_i.h
To: Krzysztof Kozlowski <krzk@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Breno Leitao <leitao@debian.org>,
        Justin Stitt <justinstitt@google.com>,
        Kees Cook <keescook@chromium.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Khan, Sabeeh" <sabeeh-khan@ti.com>
References: <20240521171841.884576-1-michael.nemanov@ti.com>
 <20240521171841.884576-2-michael.nemanov@ti.com>
 <383554c5-aef5-4c3f-bf67-dfdc83324897@kernel.org>
Content-Language: en-US
From: "Nemanov, Michael" <michael.nemanov@ti.com>
In-Reply-To: <383554c5-aef5-4c3f-bf67-dfdc83324897@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 5/22/2024 12:38 PM, Krzysztof Kozlowski wrote:
> 
>> +	struct core_status *core_status;
>> +	u8 last_fw_rls_idx;
>> +	u8 command_result[CC33XX_CMD_MAX_SIZE];
>> +	u16 result_length;
>> +	struct partial_rx_frame partial_rx;
>> +
>> +	unsigned long flags;
>> +
>> +	void *nvs_mac_addr;
>> +	size_t nvs_mac_addr_len;
>> +	struct cc33xx_fw_download *fw_download;
>> +
>> +	struct mac_address addresses[CC33XX_NUM_MAC_ADDRESSES];
>> +
>> +	unsigned long links_map[BITS_TO_LONGS(CC33XX_MAX_LINKS)];
>> +	unsigned long roles_map[BITS_TO_LONGS(CC33XX_MAX_ROLES)];
>> +	unsigned long roc_map[BITS_TO_LONGS(CC33XX_MAX_ROLES)];
>> +	unsigned long rate_policies_map[BITS_TO_LONGS(CC33XX_MAX_RATE_POLICIES)];
>> +
>> +	u8 session_ids[CC33XX_MAX_LINKS];
>> +
>> +	struct list_head wlvif_list;
>> +
>> +	u8 sta_count;
>> +	u8 ap_count;
>> +
>> +	struct cc33xx_acx_mem_map *target_mem_map;
>> +
>> +	/* Accounting for allocated / available TX blocks on HW */
>> +
>> +	u32 tx_blocks_available;
>> +	u32 tx_allocated_blocks;
>> +
>> +	/* Accounting for allocated / available Tx packets in HW */
>> +
>> +	u32 tx_allocated_pkts[NUM_TX_QUEUES];
>> +
>> +	/* Time-offset between host and chipset clocks */
>> +
>> +	/* Frames scheduled for transmission, not handled yet */
>> +	int tx_queue_count[NUM_TX_QUEUES];
>> +	unsigned long queue_stop_reasons[NUM_TX_QUEUES * CC33XX_NUM_MAC_ADDRESSES];
>> +
>> +	/* Frames received, not handled yet by mac80211 */
>> +	struct sk_buff_head deferred_rx_queue;
>> +
>> +	/* Frames sent, not returned yet to mac80211 */
>> +	struct sk_buff_head deferred_tx_queue;
>> +
>> +	struct work_struct tx_work;
>> +	struct workqueue_struct *freezable_wq;
>> +
>> +	/*freezable wq for netstack_work*/
>> +	struct workqueue_struct *freezable_netstack_wq;
>> +
>> +	/* Pending TX frames */
>> +	unsigned long tx_frames_map[BITS_TO_LONGS(CC33XX_MAX_TX_DESCRIPTORS)];
>> +	struct sk_buff *tx_frames[CC33XX_MAX_TX_DESCRIPTORS];
>> +	int tx_frames_cnt;
>> +
>> +	/* FW Rx counter */
>> +	u32 rx_counter;
>> +
>> +	/* Intermediate buffer, used for packet aggregation */
>> +	u8 *aggr_buf;
>> +	u32 aggr_buf_size;
>> +	size_t max_transaction_len;
>> +
>> +	/* Reusable dummy packet template */
>> +	struct sk_buff *dummy_packet;
>> +
>> +	/* Network stack work  */
>> +	struct work_struct netstack_work;
>> +	/* FW log buffer */
>> +	u8 *fwlog;
>> +
>> +	/* Number of valid bytes in the FW log buffer */
>> +	ssize_t fwlog_size;
>> +
>> +	/* Hardware recovery work */
>> +	struct work_struct recovery_work;
>> +
>> +	struct work_struct irq_deferred_work;
>> +
>> +	/* Reg domain last configuration */
>> +	DECLARE_BITMAP(reg_ch_conf_last, 64);
>> +	/* Reg domain pending configuration */
>> +	DECLARE_BITMAP(reg_ch_conf_pending, 64);
>> +
>> +	/* Lock-less list for deferred event handling */
>> +	struct llist_head event_list;
>> +	/* The mbox event mask */
>> +	u32 event_mask;
>> +	/* events to unmask only when ap interface is up */
>> +	u32 ap_event_mask;
>> +
>> +	/* Are we currently scanning */
>> +	struct cc33xx_vif *scan_wlvif;
>> +	struct cc33xx_scan scan;
>> +	struct delayed_work scan_complete_work;
>> +
>> +	struct ieee80211_vif *roc_vif;
>> +	struct delayed_work roc_complete_work;
>> +
>> +	struct cc33xx_vif *sched_vif;
>> +
>> +	u8 mac80211_scan_stopped;
>> +
>> +	/* The current band */
>> +	enum nl80211_band band;
>> +
>> +	/* in dBm */
>> +	int power_level;
>> +
>> +	struct cc33xx_stats stats;
>> +
>> +	__le32 *buffer_32;
>> +
>> +	/* Current chipset configuration */
>> +	struct cc33xx_conf_file conf;
>> +
>> +	bool enable_11a;
>> +
>> +	/* bands supported by this instance of cc33xx */
>> +	struct ieee80211_supported_band bands[CC33XX_NUM_BANDS];
>> +
>> +	/* wowlan trigger was configured during suspend.
>> +	 * (currently, only "ANY" and "PATTERN" trigger is supported)
>> +	 */
>> +
>> +	bool keep_device_power;
>> +
>> +	/* AP-mode - links indexed by HLID. The global and broadcast links
>> +	 * are always active.
>> +	 */
>> +	struct cc33xx_link links[CC33XX_MAX_LINKS];
>> +
>> +	/* number of currently active links */
>> +	int active_link_count;
>> +
>> +	/* AP-mode - a bitmap of links currently in PS mode according to FW */
>> +	unsigned long ap_fw_ps_map;
>> +
>> +	/* AP-mode - a bitmap of links currently in PS mode in mac80211 */
>> +	unsigned long ap_ps_map;
>> +
>> +	/* Quirks of specific hardware revisions */
>> +	unsigned int quirks;
>> +
>> +	/* number of currently active RX BA sessions */
>> +	int ba_rx_session_count;
>> +
>> +	/* AP-mode - number of currently connected stations */
>> +	int active_sta_count;
>> +
>> +	/* last wlvif we transmitted from */
>> +	struct cc33xx_vif *last_wlvif;
>> +
>> +	/* work to fire when Tx is stuck */
>> +	struct delayed_work tx_watchdog_work;
>> +
>> +	/* HW HT (11n) capabilities */
>> +	struct ieee80211_sta_ht_cap ht_cap[CC33XX_NUM_BANDS];
>> +
>> +	/* the current dfs region */
>> +	enum nl80211_dfs_regions dfs_region;
>> +	bool radar_debug_mode;
>> +
>> +	/* RX Data filter rule state - enabled/disabled */
>> +	/* used in CONFIG PM AND W8 Code */
>> +	unsigned long rx_filter_enabled[BITS_TO_LONGS(CC33XX_MAX_RX_FILTERS)];
>> +
>> +	/* mutex for protecting the tx_flush function */
>> +	struct mutex flush_mutex;
>> +
>> +	/* sleep auth value currently configured to FW */
>> +	int sleep_auth;
>> +
>> +	/*ble_enable value - 1=enabled, 0=disabled. */
>> +	int ble_enable;
>> +
>> +	/* parameters for joining a TWT agreement */
>> +	int min_wake_duration_usec;
>> +	int min_wake_interval_mantissa;
>> +	int min_wake_interval_exponent;
>> +	int max_wake_interval_mantissa;
>> +	int max_wake_interval_exponent;
>> +
>> +	/* the number of allocated MAC addresses in this chip */
>> +	int num_mac_addr;
>> +
>> +	/* sta role index - if 0 - wlan0 primary station interface,
>> +	 * if 1 - wlan2 - secondary station interface
>> +	 */
>> +	u8 sta_role_idx;
>> +
>> +	u16 max_cmd_size;
>> +
>> +	struct completion nvs_loading_complete;
>> +	struct completion command_complete;
>> +
>> +	/* dynamic fw traces */
>> +	u32 dynamic_fw_traces;
>> +
>> +	/* buffer for sending commands to FW */
>> +	u8 cmd_buf[CC33XX_CMD_BUFFER_SIZE];
>> +
>> +	/* number of keys requiring extra spare mem-blocks */
>> +	int extra_spare_key_count;
> 
> This entire struct is quite unmanageable...
> 

 From what I saw many wireless drivers hold their private members in a 
single structure of roughly the same size. Most of these are unrelated 
to each other so I doubt grouping them in sub-structures will improve 
readability.



