Return-Path: <linux-wireless+bounces-7942-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EA38CBDEE
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 11:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4271CB21D17
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 09:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3081080607;
	Wed, 22 May 2024 09:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L89waZat"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C8454720;
	Wed, 22 May 2024 09:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716370737; cv=none; b=dtBa9Li4oOzxwlEXcY6YE4yXjZ/37UnZtZDth7iDf8Z6mm9ZW7xPYlwyFN9r2Rz5U4NIElQIK4K5DOiFkQm6RpDjnQOOdsKKdSwjN+k5k48N2Om3RXPkbxIfxAEjMXksTqabtXfmlHvXJGpvZcKBQuQ0hdCrGu+1D+QASvbuwKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716370737; c=relaxed/simple;
	bh=Rphnt9V9HbqTZ6aTAZ5TcMiGGbis4kbzonmzn9RNRhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TS4sMOVrs/zNslZuCakIX9wuUYWpD0oZ7DljEObu+HR5nxwjGbK3wniHeSY91HRaVoO/X9oiteUKgTqhrs2UafuW5/nQi+flqsQZadGZMesQ+FV/nV+zMcaxvdmSo4nWOJqNTa33eA1eViu1TpvrxW1F2GSwCKA+cbBnCY3dxIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L89waZat; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6654C2BD11;
	Wed, 22 May 2024 09:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716370736;
	bh=Rphnt9V9HbqTZ6aTAZ5TcMiGGbis4kbzonmzn9RNRhg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L89waZatrRqdyUMYoz2Af9Xkuh+D53JlDGP9YyVtIkY2//rDtKOGLYG9vt3I6uV7c
	 IbV72fxSMVGATI3pNkahc2MilcZeSKzXpy9hPv0rpGO/qctVITyMfFQgR+06jTJmyu
	 xjP+xeQ09gKIIT5E3mwj8DAwfeMiriGnZ/YTWJzYvrzr62e0XjFg5KeHj6+H+5KZI0
	 vuPLjX3/FZ1lo4hYwloyPpTVCcH6voOxNOw5cdc1VdWqlKt4lIQ5j5dBtT/AE0Iohy
	 LSwycvZemBY3LSmW0UcP4NAx41fJj7TGmjPJ1nfdlCM3wCb/jVkWsr8N/hb/sLbcfJ
	 JiCgA8BQ1MMLw==
Message-ID: <383554c5-aef5-4c3f-bf67-dfdc83324897@kernel.org>
Date: Wed, 22 May 2024 11:38:51 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/17] Add cc33xx.h, cc33xx_i.h
To: michael.nemanov@ti.com, Kalle Valo <kvalo@kernel.org>,
 Johannes Berg <johannes.berg@intel.com>, Breno Leitao <leitao@debian.org>,
 Justin Stitt <justinstitt@google.com>, Kees Cook <keescook@chromium.org>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sabeeh Khan <sabeeh-khan@ti.com>
References: <20240521171841.884576-1-michael.nemanov@ti.com>
 <20240521171841.884576-2-michael.nemanov@ti.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240521171841.884576-2-michael.nemanov@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/05/2024 19:18, michael.nemanov@ti.com wrote:
> From: Michael Nemanov <Michael.Nemanov@ti.com>
> 
> These are header files with definitions common to the entire driver.

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching. For bindings, the preferred subjects are
explained here:
https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters


> 
> Signed-off-by: Michael Nemanov <michael.nemanov@ti.com>
> ---
>  drivers/net/wireless/ti/cc33xx/cc33xx.h   | 481 ++++++++++++++++++++++
>  drivers/net/wireless/ti/cc33xx/cc33xx_i.h | 459 +++++++++++++++++++++
>  2 files changed, 940 insertions(+)
>  create mode 100644 drivers/net/wireless/ti/cc33xx/cc33xx.h
>  create mode 100644 drivers/net/wireless/ti/cc33xx/cc33xx_i.h
> 
> diff --git a/drivers/net/wireless/ti/cc33xx/cc33xx.h b/drivers/net/wireless/ti/cc33xx/cc33xx.h
> new file mode 100644
> index 000000000000..3a2e56af4da7
> --- /dev/null
> +++ b/drivers/net/wireless/ti/cc33xx/cc33xx.h
> @@ -0,0 +1,481 @@
> +/* SPDX-License-Identifier: GPL-2.0-only
> + *
> + * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +#ifndef __CC33XX_H__
> +#define __CC33XX_H__
> +
> +#include "cc33xx_i.h"
> +#include "rx.h"
> +
> +/* Wireless Driver Version */
> +#define DRV_VERSION "1.7.0.108"
> +
> +/* The maximum number of Tx descriptors in all chip families */
> +#define CC33XX_MAX_TX_DESCRIPTORS 32
> +
> +#define CC33XX_CMD_MAX_SIZE          (896)
> +#define CC33XX_INI_PARAM_COMMAND_SIZE (16UL)
> +#define CC33XX_INI_CMD_MAX_SIZE      (CC33X_CONF_SIZE + CC33XX_INI_PARAM_COMMAND_SIZE + sizeof(int))
> +
> +#define CC33XX_CMD_BUFFER_SIZE ((CC33XX_INI_CMD_MAX_SIZE > CC33XX_CMD_MAX_SIZE)\
> +				? CC33XX_INI_CMD_MAX_SIZE : CC33XX_CMD_MAX_SIZE)
> +
> +#define CC33XX_NUM_MAC_ADDRESSES 3
> +
> +#define CC33XX_AGGR_BUFFER_SIZE		(8 * PAGE_SIZE)
> +
> +#define CC33XX_NUM_TX_DESCRIPTORS 32
> +#define CC33XX_NUM_RX_DESCRIPTORS 32
> +
> +#define CC33XX_RX_BA_MAX_SESSIONS 13
> +
> +#define CC33XX_MAX_AP_STATIONS 16
> +
> +struct cc33xx_tx_hw_descr;
> +struct cc33xx_rx_descriptor;
> +struct partial_rx_frame;
> +struct core_fw_status;
> +struct core_status;
> +
> +enum wl_rx_buf_align;
> +
> +struct driver_fw_versions {
> +	const char *driver_ver;
> +	struct cc33xx_acx_fw_versions *fw_ver;
> +};
> +
> +struct cc33xx_stats {
> +	void *fw_stats;
> +	unsigned long fw_stats_update;
> +	unsigned int retry_count;
> +	unsigned int excessive_retries;
> +};
> +
> +struct cc33xx_ant_diversity {
> +	u8 diversity_enable;
> +	s8 rssi_threshold;
> +	u8 default_antenna;
> +	u8 padding;
> +};
> +
> +struct cc33xx {
> +	bool initialized;
> +	struct ieee80211_hw *hw;
> +	bool mac80211_registered;
> +
> +	struct device *dev;
> +	struct platform_device *pdev;
> +
> +	struct cc33xx_if_operations *if_ops;
> +
> +	int wakeirq;
> +
> +	spinlock_t cc_lock; /* Protects critical sections */

Which ones. Your comment is entirely useless, just to satisfy checkpatch.

> +
> +	enum cc33xx_state state;
> +	bool plt;
> +	enum plt_mode plt_mode;
> +	u8 plt_role_id;
> +	u8 fem_manuf;
> +	u8 last_vif_count;
> +	struct mutex mutex; /* Protect all CC33xx operations */

?!? So double lock?

> +	struct core_status *core_status;
> +	u8 last_fw_rls_idx;
> +	u8 command_result[CC33XX_CMD_MAX_SIZE];
> +	u16 result_length;
> +	struct partial_rx_frame partial_rx;
> +
> +	unsigned long flags;
> +
> +	void *nvs_mac_addr;
> +	size_t nvs_mac_addr_len;
> +	struct cc33xx_fw_download *fw_download;
> +
> +	struct mac_address addresses[CC33XX_NUM_MAC_ADDRESSES];
> +
> +	unsigned long links_map[BITS_TO_LONGS(CC33XX_MAX_LINKS)];
> +	unsigned long roles_map[BITS_TO_LONGS(CC33XX_MAX_ROLES)];
> +	unsigned long roc_map[BITS_TO_LONGS(CC33XX_MAX_ROLES)];
> +	unsigned long rate_policies_map[BITS_TO_LONGS(CC33XX_MAX_RATE_POLICIES)];
> +
> +	u8 session_ids[CC33XX_MAX_LINKS];
> +
> +	struct list_head wlvif_list;
> +
> +	u8 sta_count;
> +	u8 ap_count;
> +
> +	struct cc33xx_acx_mem_map *target_mem_map;
> +
> +	/* Accounting for allocated / available TX blocks on HW */
> +
> +	u32 tx_blocks_available;
> +	u32 tx_allocated_blocks;
> +
> +	/* Accounting for allocated / available Tx packets in HW */
> +
> +	u32 tx_allocated_pkts[NUM_TX_QUEUES];
> +
> +	/* Time-offset between host and chipset clocks */
> +
> +	/* Frames scheduled for transmission, not handled yet */
> +	int tx_queue_count[NUM_TX_QUEUES];
> +	unsigned long queue_stop_reasons[NUM_TX_QUEUES * CC33XX_NUM_MAC_ADDRESSES];
> +
> +	/* Frames received, not handled yet by mac80211 */
> +	struct sk_buff_head deferred_rx_queue;
> +
> +	/* Frames sent, not returned yet to mac80211 */
> +	struct sk_buff_head deferred_tx_queue;
> +
> +	struct work_struct tx_work;
> +	struct workqueue_struct *freezable_wq;
> +
> +	/*freezable wq for netstack_work*/
> +	struct workqueue_struct *freezable_netstack_wq;
> +
> +	/* Pending TX frames */
> +	unsigned long tx_frames_map[BITS_TO_LONGS(CC33XX_MAX_TX_DESCRIPTORS)];
> +	struct sk_buff *tx_frames[CC33XX_MAX_TX_DESCRIPTORS];
> +	int tx_frames_cnt;
> +
> +	/* FW Rx counter */
> +	u32 rx_counter;
> +
> +	/* Intermediate buffer, used for packet aggregation */
> +	u8 *aggr_buf;
> +	u32 aggr_buf_size;
> +	size_t max_transaction_len;
> +
> +	/* Reusable dummy packet template */
> +	struct sk_buff *dummy_packet;
> +
> +	/* Network stack work  */
> +	struct work_struct netstack_work;
> +	/* FW log buffer */
> +	u8 *fwlog;
> +
> +	/* Number of valid bytes in the FW log buffer */
> +	ssize_t fwlog_size;
> +
> +	/* Hardware recovery work */
> +	struct work_struct recovery_work;
> +
> +	struct work_struct irq_deferred_work;
> +
> +	/* Reg domain last configuration */
> +	DECLARE_BITMAP(reg_ch_conf_last, 64);
> +	/* Reg domain pending configuration */
> +	DECLARE_BITMAP(reg_ch_conf_pending, 64);
> +
> +	/* Lock-less list for deferred event handling */
> +	struct llist_head event_list;
> +	/* The mbox event mask */
> +	u32 event_mask;
> +	/* events to unmask only when ap interface is up */
> +	u32 ap_event_mask;
> +
> +	/* Are we currently scanning */
> +	struct cc33xx_vif *scan_wlvif;
> +	struct cc33xx_scan scan;
> +	struct delayed_work scan_complete_work;
> +
> +	struct ieee80211_vif *roc_vif;
> +	struct delayed_work roc_complete_work;
> +
> +	struct cc33xx_vif *sched_vif;
> +
> +	u8 mac80211_scan_stopped;
> +
> +	/* The current band */
> +	enum nl80211_band band;
> +
> +	/* in dBm */
> +	int power_level;
> +
> +	struct cc33xx_stats stats;
> +
> +	__le32 *buffer_32;
> +
> +	/* Current chipset configuration */
> +	struct cc33xx_conf_file conf;
> +
> +	bool enable_11a;
> +
> +	/* bands supported by this instance of cc33xx */
> +	struct ieee80211_supported_band bands[CC33XX_NUM_BANDS];
> +
> +	/* wowlan trigger was configured during suspend.
> +	 * (currently, only "ANY" and "PATTERN" trigger is supported)
> +	 */
> +
> +	bool keep_device_power;
> +
> +	/* AP-mode - links indexed by HLID. The global and broadcast links
> +	 * are always active.
> +	 */
> +	struct cc33xx_link links[CC33XX_MAX_LINKS];
> +
> +	/* number of currently active links */
> +	int active_link_count;
> +
> +	/* AP-mode - a bitmap of links currently in PS mode according to FW */
> +	unsigned long ap_fw_ps_map;
> +
> +	/* AP-mode - a bitmap of links currently in PS mode in mac80211 */
> +	unsigned long ap_ps_map;
> +
> +	/* Quirks of specific hardware revisions */
> +	unsigned int quirks;
> +
> +	/* number of currently active RX BA sessions */
> +	int ba_rx_session_count;
> +
> +	/* AP-mode - number of currently connected stations */
> +	int active_sta_count;
> +
> +	/* last wlvif we transmitted from */
> +	struct cc33xx_vif *last_wlvif;
> +
> +	/* work to fire when Tx is stuck */
> +	struct delayed_work tx_watchdog_work;
> +
> +	/* HW HT (11n) capabilities */
> +	struct ieee80211_sta_ht_cap ht_cap[CC33XX_NUM_BANDS];
> +
> +	/* the current dfs region */
> +	enum nl80211_dfs_regions dfs_region;
> +	bool radar_debug_mode;
> +
> +	/* RX Data filter rule state - enabled/disabled */
> +	/* used in CONFIG PM AND W8 Code */
> +	unsigned long rx_filter_enabled[BITS_TO_LONGS(CC33XX_MAX_RX_FILTERS)];
> +
> +	/* mutex for protecting the tx_flush function */
> +	struct mutex flush_mutex;
> +
> +	/* sleep auth value currently configured to FW */
> +	int sleep_auth;
> +
> +	/*ble_enable value - 1=enabled, 0=disabled. */
> +	int ble_enable;
> +
> +	/* parameters for joining a TWT agreement */
> +	int min_wake_duration_usec;
> +	int min_wake_interval_mantissa;
> +	int min_wake_interval_exponent;
> +	int max_wake_interval_mantissa;
> +	int max_wake_interval_exponent;
> +
> +	/* the number of allocated MAC addresses in this chip */
> +	int num_mac_addr;
> +
> +	/* sta role index - if 0 - wlan0 primary station interface,
> +	 * if 1 - wlan2 - secondary station interface
> +	 */
> +	u8 sta_role_idx;
> +
> +	u16 max_cmd_size;
> +
> +	struct completion nvs_loading_complete;
> +	struct completion command_complete;
> +
> +	/* dynamic fw traces */
> +	u32 dynamic_fw_traces;
> +
> +	/* buffer for sending commands to FW */
> +	u8 cmd_buf[CC33XX_CMD_BUFFER_SIZE];
> +
> +	/* number of keys requiring extra spare mem-blocks */
> +	int extra_spare_key_count;

This entire struct is quite unmanageable...

> +
> +	u8 efuse_mac_address[ETH_ALEN];
> +
> +	u32 fuse_rom_structure_version;
> +	u32 device_part_number;
> +	u32 pg_version;
> +	u8	disable_5g;
> +	u8	disable_6g;

Please fix trivial whitespace issues.

This driver looks like having basic issues unresolved, really basic. I
advise to get internal TI review first, before you will be using
community resources for these trivial things.

Please also confirm that you also fixed all warnings from:
1. checkpatch --strict
2. smatch
3. sparse
4. coccinelle/coccicheck



Best regards,
Krzysztof


