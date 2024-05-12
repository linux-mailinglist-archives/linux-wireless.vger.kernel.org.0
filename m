Return-Path: <linux-wireless+bounces-7568-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2648C37F9
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 20:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92C9AB20EE7
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 18:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B623A57877;
	Sun, 12 May 2024 18:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UyFKGzTP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F037054F8C
	for <linux-wireless@vger.kernel.org>; Sun, 12 May 2024 18:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715538844; cv=none; b=n4lVlyHgDLMR/oSmuPd14Fac9z3FbvbiIDXb2LcF6ds45B4aRnT+N4uftYDLmwi5nXUK44et3azJvfYZCeHiHg/YarBoDR6QPgF8nZMmjtF5Icw0Tm5fE9tjxY7awXJHIXwiR+/IriXREw0Y1s2SwcxN/W61vnBGEE8/nLAGces=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715538844; c=relaxed/simple;
	bh=eLdjQPJPMuMlctVMbrnG9bn6zsEAjmgVwlwKkobSoz8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dqa4WbGaDDdB6f52lI0c3E/gX5S2R93wE3Rpd6fUpvY0J/6DKSh7itEUpiPu2dU4PyxCe7JpZmTC0t0pjbsPX6oMayF698jTFe93HskK4BKIljxqNl6JqbslzT3c+dSexyAgCKfKWoLT9x4l1IluGggEC5wo5TOmYVYG7IZe6bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UyFKGzTP; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44CIXpT1114079;
	Sun, 12 May 2024 13:33:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715538831;
	bh=staKeuexgKjGv7j8lgXpmFwu88na94cZuDvb3H/ePcU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=UyFKGzTPFuHXwVcCZt+vpTqFhdR3Z6sli72lc12mbQQvXJdhvPoMVkBbe29yJREUh
	 eLYzJzt7/2MFznZAB9+RwUCY9Vw/I0PryEquYzi/txS0AQ6R2y5GZr+vwxRFerUD0R
	 OiJ0IfY98HnDk1LZEo2nqZxTjF/Fb6nrPpTCMS50=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44CIXpfp029129
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 12 May 2024 13:33:51 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 12
 May 2024 13:33:51 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 12 May 2024 13:33:51 -0500
Received: from localhost (uda0389739.dhcp.ti.com [137.167.1.114])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44CIXocL047375;
	Sun, 12 May 2024 13:33:50 -0500
From: <michael.nemanov@ti.com>
To: <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>
CC: <sabeeh-khan@ti.com>, Michael Nemanov <Michael.Nemanov@ti.com>,
        Michael
 Nemanov <michael.nemanov@ti.com>
Subject: [RFC PATCH 12/17] Add debugfs.c, debugfs.h
Date: Sun, 12 May 2024 21:32:42 +0300
Message-ID: <20240512183247.2190242-13-michael.nemanov@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240512183247.2190242-1-michael.nemanov@ti.com>
References: <20240512183247.2190242-1-michael.nemanov@ti.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Michael Nemanov <Michael.Nemanov@ti.com>

Files that expose HW stats and debug features.

Signed-off-by: Michael Nemanov <michael.nemanov@ti.com>
---
 drivers/net/wireless/ti/cc33xx/debugfs.c | 2201 ++++++++++++++++++++++
 drivers/net/wireless/ti/cc33xx/debugfs.h |   91 +
 2 files changed, 2292 insertions(+)
 create mode 100644 drivers/net/wireless/ti/cc33xx/debugfs.c
 create mode 100644 drivers/net/wireless/ti/cc33xx/debugfs.h

diff --git a/drivers/net/wireless/ti/cc33xx/debugfs.c b/drivers/net/wireless/ti/cc33xx/debugfs.c
new file mode 100644
index 000000000000..720f65a9732e
--- /dev/null
+++ b/drivers/net/wireless/ti/cc33xx/debugfs.c
@@ -0,0 +1,2201 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/* Copyright (C) 2022-2024 Texas Instruments Inc.*/
+
+#include "debugfs.h"
+#include "acx.h"
+#include "ps.h"
+#include "io.h"
+#include "tx.h"
+#include "../net/mac80211/ieee80211_i.h"
+
+#define CC33XX_DEBUGFS_FWSTATS_FILE(a, b, c) \
+	DEBUGFS_FWSTATS_FILE(a, b, c, cc33xx_acx_statistics)
+#define CC33XX_DEBUGFS_FWSTATS_FILE_ARRAY(a, b, c) \
+	DEBUGFS_FWSTATS_FILE_ARRAY(a, b, c, cc33xx_acx_statistics)
+
+CC33XX_DEBUGFS_FWSTATS_FILE(error, error_frame_non_ctrl, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(error, error_frame_ctrl, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(error, error_frame_during_protection, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(error, null_frame_tx_start, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(error, null_frame_cts_start, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(error, bar_retry, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(error, num_frame_cts_nul_flid, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(error, tx_abort_failure, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(error, tx_resume_failure, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(error, rx_cmplt_db_overflow_cnt, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(error, elp_while_rx_exch, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(error, elp_while_tx_exch, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(error, elp_while_tx, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(error, elp_while_nvic_pending, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(error, rx_excessive_frame_len, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(error, burst_mismatch, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(error, tbc_exch_mismatch, "%u");
+
+CC33XX_DEBUGFS_FWSTATS_FILE(tx, tx_prepared_descs, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(tx, tx_cmplt, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(tx, tx_template_prepared, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(tx, tx_data_prepared, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(tx, tx_template_programmed, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(tx, tx_data_programmed, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(tx, tx_burst_programmed, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(tx, tx_starts, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(tx, tx_stop, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(tx, tx_start_templates, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(tx, tx_start_int_templates, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(tx, tx_start_fw_gen, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(tx, tx_start_data, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(tx, tx_start_null_frame, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(tx, tx_exch, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(tx, tx_retry_template, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(tx, tx_retry_data, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE_ARRAY(tx, tx_retry_per_rate,
+				  NUM_OF_RATES_INDEXES);
+CC33XX_DEBUGFS_FWSTATS_FILE(tx, tx_exch_pending, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(tx, tx_exch_expiry, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(tx, tx_done_template, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(tx, tx_done_data, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(tx, tx_done_int_template, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(tx, tx_cfe1, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(tx, tx_cfe2, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(tx, frag_called, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(tx, frag_mpdu_alloc_failed, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(tx, frag_init_called, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(tx, frag_in_process_called, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(tx, frag_tkip_called, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(tx, frag_key_not_found, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(tx, frag_need_fragmentation, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(tx, frag_bad_mblk_num, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(tx, frag_failed, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(tx, frag_cache_hit, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(tx, frag_cache_miss, "%u");
+
+CC33XX_DEBUGFS_FWSTATS_FILE(rx, rx_beacon_early_term, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(rx, rx_out_of_mpdu_nodes, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(rx, rx_hdr_overflow, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(rx, rx_dropped_frame, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(rx, rx_done, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(rx, rx_defrag, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(rx, rx_defrag_end, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(rx, rx_cmplt, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(rx, rx_pre_complt, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(rx, rx_cmplt_task, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(rx, rx_phy_hdr, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(rx, rx_timeout, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(rx, rx_rts_timeout, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(rx, rx_timeout_wa, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(rx, defrag_called, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(rx, defrag_init_called, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(rx, defrag_in_process_called, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(rx, defrag_tkip_called, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(rx, defrag_need_defrag, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(rx, defrag_decrypt_failed, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(rx, decrypt_key_not_found, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(rx, defrag_need_decrypt, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(rx, rx_tkip_replays, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(rx, rx_xfr, "%u");
+
+CC33XX_DEBUGFS_FWSTATS_FILE(isr, irqs, "%u");
+
+CC33XX_DEBUGFS_FWSTATS_FILE(pwr, missing_bcns_cnt, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(pwr, rcvd_bcns_cnt, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(pwr, connection_out_of_sync, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE_ARRAY(pwr, cont_miss_bcns_spread,
+				  PWR_STAT_MAX_CONT_MISSED_BCNS_SPREAD);
+CC33XX_DEBUGFS_FWSTATS_FILE(pwr, rcvd_awake_bcns_cnt, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(pwr, sleep_time_count, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(pwr, sleep_time_avg, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(pwr, sleep_cycle_avg, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(pwr, sleep_percent, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(pwr, ap_sleep_active_conf, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(pwr, ap_sleep_user_conf, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(pwr, ap_sleep_counter, "%u");
+
+CC33XX_DEBUGFS_FWSTATS_FILE(rx_filter, beacon_filter, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(rx_filter, arp_filter, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(rx_filter, mc_filter, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(rx_filter, dup_filter, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(rx_filter, data_filter, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(rx_filter, ibss_filter, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(rx_filter, protection_filter, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(rx_filter, accum_arp_pend_requests, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(rx_filter, max_arp_queue_dep, "%u");
+
+CC33XX_DEBUGFS_FWSTATS_FILE_ARRAY(rx_rate, rx_frames_per_rates, 50);
+
+CC33XX_DEBUGFS_FWSTATS_FILE_ARRAY(aggr_size, tx_agg_rate,
+				  AGGR_STATS_TX_AGG);
+CC33XX_DEBUGFS_FWSTATS_FILE_ARRAY(aggr_size, tx_agg_len,
+				  AGGR_STATS_TX_AGG);
+CC33XX_DEBUGFS_FWSTATS_FILE_ARRAY(aggr_size, rx_size,
+				  AGGR_STATS_RX_SIZE_LEN);
+
+CC33XX_DEBUGFS_FWSTATS_FILE(pipeline, hs_tx_stat_fifo_int, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(pipeline, enc_tx_stat_fifo_int, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(pipeline, enc_rx_stat_fifo_int, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(pipeline, rx_complete_stat_fifo_int, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(pipeline, pre_proc_swi, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(pipeline, post_proc_swi, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(pipeline, sec_frag_swi, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(pipeline, pre_to_defrag_swi, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(pipeline, defrag_to_rx_xfer_swi, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(pipeline, dec_packet_in, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(pipeline, dec_packet_in_fifo_full, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(pipeline, dec_packet_out, "%u");
+
+CC33XX_DEBUGFS_FWSTATS_FILE_ARRAY(pipeline, pipeline_fifo_full,
+				  PIPE_STATS_HW_FIFO);
+
+CC33XX_DEBUGFS_FWSTATS_FILE_ARRAY(diversity, num_of_packets_per_ant,
+				  DIVERSITY_STATS_NUM_OF_ANT);
+CC33XX_DEBUGFS_FWSTATS_FILE(diversity, total_num_of_toggles, "%u");
+
+CC33XX_DEBUGFS_FWSTATS_FILE(thermal, irq_thr_low, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(thermal, irq_thr_high, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(thermal, tx_stop, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(thermal, tx_resume, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(thermal, false_irq, "%u");
+CC33XX_DEBUGFS_FWSTATS_FILE(thermal, adc_source_unexpected, "%u");
+
+CC33XX_DEBUGFS_FWSTATS_FILE_ARRAY(calib, fail_count,
+				  CC33XX_NUM_OF_CALIBRATIONS_ERRORS);
+CC33XX_DEBUGFS_FWSTATS_FILE(calib, calib_count, "%u");
+
+CC33XX_DEBUGFS_FWSTATS_FILE(roaming, rssi_level, "%d");
+
+CC33XX_DEBUGFS_FWSTATS_FILE(dfs, num_of_radar_detections, "%d");
+
+struct cc33xx_cmd_dfs_radar_debug {
+	struct cc33xx_cmd_header header;
+
+	u8 channel;
+	u8 padding[3];
+} __packed;
+
+/* ms */
+#define CC33XX_DEBUGFS_STATS_LIFETIME 1000
+#define MAX_VERSIONS_LEN	59
+#define MAX_VERSIONS_EXTENDED_LEN	86
+
+static int cc33xx_cmd_radar_detection_debug(struct cc33xx *cc, u8 channel)
+{
+	struct cc33xx_cmd_dfs_radar_debug *cmd;
+	int ret = 0;
+
+	cc33xx_debug(DEBUG_CMD, "cmd radar detection debug (chan %d)",
+		     channel);
+
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
+	if (!cmd)
+		return -ENOMEM;
+
+	cmd->channel = channel;
+
+	ret = cc33xx_cmd_send(cc, CMD_DFS_RADAR_DETECTION_DEBUG,
+			      cmd, sizeof(*cmd), 0);
+	if (ret < 0) {
+		cc33xx_error("failed to send radar detection debug command");
+		goto out_free;
+	}
+
+out_free:
+	kfree(cmd);
+	return ret;
+}
+
+static ssize_t conf_read(struct file *file, char __user *user_buf,
+			 size_t count, loff_t *ppos)
+{
+	struct cc33xx *cc = file->private_data;
+	struct cc33xx_conf_header header;
+	char *buf, *pos;
+	size_t len;
+	int ret;
+
+	len = CC33X_CONF_SIZE;
+	buf = kmalloc(len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	header.magic	= cpu_to_le32(CC33XX_CONF_MAGIC);
+	header.version	= cpu_to_le32(CC33XX_CONF_VERSION);
+	header.checksum	= 0;
+
+	mutex_lock(&cc->mutex);
+
+	pos = buf;
+	memcpy(pos, &header, sizeof(header));
+	pos += sizeof(header);
+	memcpy(pos, &cc->conf, sizeof(cc->conf));
+
+	mutex_unlock(&cc->mutex);
+
+	ret = simple_read_from_buffer(user_buf, count, ppos, buf, len);
+
+	kfree(buf);
+	return ret;
+}
+
+static const struct file_operations conf_ops = {
+	.read = conf_read,
+	.open = simple_open,
+	.llseek = default_llseek,
+};
+
+static ssize_t clear_fw_stats_write(struct file *file,
+				    const char __user *user_buf,
+				    size_t count, loff_t *ppos)
+{
+	struct cc33xx *cc = file->private_data;
+	int ret;
+
+	mutex_lock(&cc->mutex);
+
+	if (unlikely(cc->state != CC33XX_STATE_ON))
+		goto out;
+
+	ret = cc33xx_acx_clear_statistics(cc);
+	if (ret < 0) {
+		count = ret;
+		goto out;
+	}
+out:
+	mutex_unlock(&cc->mutex);
+	return count;
+}
+
+static const struct file_operations clear_fw_stats_ops = {
+	.write = clear_fw_stats_write,
+	.open = simple_open,
+	.llseek = default_llseek,
+};
+
+static ssize_t radar_detection_write(struct file *file,
+				     const char __user *user_buf,
+				     size_t count, loff_t *ppos)
+{
+	struct cc33xx *cc = file->private_data;
+	int ret;
+	u8 channel;
+
+	ret = kstrtou8_from_user(user_buf, count, 10, &channel);
+	if (ret < 0) {
+		cc33xx_warning("illegal channel");
+		return -EINVAL;
+	}
+
+	mutex_lock(&cc->mutex);
+
+	if (unlikely(cc->state != CC33XX_STATE_ON))
+		goto out;
+
+	ret = cc33xx_cmd_radar_detection_debug(cc, channel);
+	if (ret < 0)
+		count = ret;
+
+out:
+	mutex_unlock(&cc->mutex);
+	return count;
+}
+
+static const struct file_operations radar_detection_ops = {
+	.write = radar_detection_write,
+	.open = simple_open,
+	.llseek = default_llseek,
+};
+
+static ssize_t dynamic_fw_traces_write(struct file *file,
+				       const char __user *user_buf,
+				       size_t count, loff_t *ppos)
+{
+	struct cc33xx *cc = file->private_data;
+	unsigned long value;
+	int ret;
+
+	ret = kstrtoul_from_user(user_buf, count, 0, &value);
+	if (ret < 0)
+		return ret;
+
+	cc->dynamic_fw_traces = value;
+
+	return count;
+}
+
+static ssize_t dynamic_fw_traces_read(struct file *file, char __user *userbuf,
+				      size_t count, loff_t *ppos)
+{
+	struct cc33xx *cc = file->private_data;
+
+	return cc33xx_format_buffer(userbuf, count, ppos,
+				    "%d\n", cc->dynamic_fw_traces);
+}
+
+static const struct file_operations dynamic_fw_traces_ops = {
+	.read = dynamic_fw_traces_read,
+	.write = dynamic_fw_traces_write,
+	.open = simple_open,
+	.llseek = default_llseek,
+};
+
+#ifdef CONFIG_CFG80211_CERTIFICATION_ONUS
+static ssize_t radar_debug_mode_write(struct file *file,
+				      const char __user *user_buf,
+				      size_t count, loff_t *ppos)
+{
+	struct cc33xx *cc = file->private_data;
+	struct cc33xx_vif *wlvif;
+	unsigned long value;
+	int ret;
+
+	ret = kstrtoul_from_user(user_buf, count, 10, &value);
+	if (ret < 0) {
+		cc33xx_warning("illegal radar_debug_mode value!");
+		return -EINVAL;
+	}
+
+	/* valid values: 0/1 */
+	if (!(value == 0 || value == 1)) {
+		cc33xx_warning("value is not in valid!");
+		return -EINVAL;
+	}
+
+	mutex_lock(&cc->mutex);
+
+	cc->radar_debug_mode = value;
+
+	if (unlikely(cc->state != CC33XX_STATE_ON))
+		goto out;
+
+	cc33xx_for_each_wlvif_ap(cc, wlvif) {
+		cc33xx_cmd_generic_cfg(cc, wlvif,
+				       CC33XX_CFG_FEATURE_RADAR_DEBUG,
+				       cc->radar_debug_mode, 0);
+	}
+
+out:
+	mutex_unlock(&cc->mutex);
+	return count;
+}
+
+static ssize_t radar_debug_mode_read(struct file *file,
+				     char __user *userbuf,
+				     size_t count, loff_t *ppos)
+{
+	struct cc33xx *cc = file->private_data;
+
+	return cc33xx_format_buffer(userbuf, count, ppos,
+				    "%d\n", cc->radar_debug_mode);
+}
+
+static const struct file_operations radar_debug_mode_ops = {
+	.write = radar_debug_mode_write,
+	.read = radar_debug_mode_read,
+	.open = simple_open,
+	.llseek = default_llseek,
+};
+
+static inline void cc33xx_debugfs_add_files_helper(struct dentry *moddir)
+{
+	DEBUGFS_ADD(radar_debug_mode, moddir);
+}
+#else
+static inline void cc33xx_debugfs_add_files_helper(struct dentry *moddir) {}
+#endif /* CFG80211_CERTIFICATION_ONUS */
+
+/* debugfs macros idea from mac80211 */
+int cc33xx_format_buffer(char __user *userbuf, size_t count,
+			 loff_t *ppos, char *fmt, ...)
+{
+	va_list args;
+	char buf[DEBUGFS_FORMAT_BUFFER_SIZE];
+	int res;
+
+	va_start(args, fmt);
+	res = vscnprintf(buf, sizeof(buf), fmt, args);
+	va_end(args);
+
+	return simple_read_from_buffer(userbuf, count, ppos, buf, res);
+}
+
+void cc33xx_debugfs_update_stats(struct cc33xx *cc)
+{
+	mutex_lock(&cc->mutex);
+
+	if (unlikely(cc->state != CC33XX_STATE_ON))
+		goto out;
+
+	if (!cc->plt && time_after(jiffies, cc->stats.fw_stats_update +
+		msecs_to_jiffies(CC33XX_DEBUGFS_STATS_LIFETIME))) {
+		cc33xx_acx_statistics(cc, cc->stats.fw_stats);
+		cc->stats.fw_stats_update = jiffies;
+	}
+
+out:
+	mutex_unlock(&cc->mutex);
+}
+
+DEBUGFS_READONLY_FILE(retry_count, "%u", cc->stats.retry_count);
+DEBUGFS_READONLY_FILE(excessive_retries, "%u", cc->stats.excessive_retries);
+
+static ssize_t tx_queue_len_read(struct file *file, char __user *userbuf,
+				 size_t count, loff_t *ppos)
+{
+	struct cc33xx *cc = file->private_data;
+	u32 queue_len;
+	char buf[20];
+	int res;
+
+	queue_len = cc33xx_tx_total_queue_count(cc);
+
+	res = scnprintf(buf, sizeof(buf), "%u\n", queue_len);
+	return simple_read_from_buffer(userbuf, count, ppos, buf, res);
+}
+
+static const struct file_operations tx_queue_len_ops = {
+	.read = tx_queue_len_read,
+	.open = simple_open,
+	.llseek = default_llseek,
+};
+
+static ssize_t gpio_power_read(struct file *file, char __user *user_buf,
+			       size_t count, loff_t *ppos)
+{
+	struct cc33xx *cc = file->private_data;
+	bool state = test_bit(CC33XX_FLAG_GPIO_POWER, &cc->flags);
+
+	int res;
+	char buf[10];
+
+	res = scnprintf(buf, sizeof(buf), "%d\n", state);
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, res);
+}
+
+static ssize_t gpio_power_write(struct file *file, const char __user *user_buf,
+				size_t count, loff_t *ppos)
+{
+	struct cc33xx *cc = file->private_data;
+	unsigned long value;
+	int ret;
+
+	ret = kstrtoul_from_user(user_buf, count, 10, &value);
+	if (ret < 0) {
+		cc33xx_warning("illegal value in gpio_power");
+		return -EINVAL;
+	}
+
+	mutex_lock(&cc->mutex);
+
+	if (value)
+		cc33xx_power_on(cc);
+	else
+		cc33xx_power_off(cc);
+
+	mutex_unlock(&cc->mutex);
+	return count;
+}
+
+static const struct file_operations gpio_power_ops = {
+	.read = gpio_power_read,
+	.write = gpio_power_write,
+	.open = simple_open,
+	.llseek = default_llseek,
+};
+
+static ssize_t start_recovery_write(struct file *file,
+				    const char __user *user_buf,
+				    size_t count, loff_t *ppos)
+{
+	struct cc33xx *cc = file->private_data;
+
+	mutex_lock(&cc->mutex);
+	cc33xx_queue_recovery_work(cc);
+	mutex_unlock(&cc->mutex);
+
+	return count;
+}
+
+static const struct file_operations start_recovery_ops = {
+	.write = start_recovery_write,
+	.open = simple_open,
+	.llseek = default_llseek,
+};
+
+static ssize_t dynamic_ps_timeout_read(struct file *file, char __user *user_buf,
+				       size_t count, loff_t *ppos)
+{
+	struct cc33xx *cc = file->private_data;
+
+	return cc33xx_format_buffer(user_buf, count, ppos, "%d\n",
+				    cc->conf.host_conf.conn.dynamic_ps_timeout);
+}
+
+static ssize_t dynamic_ps_timeout_write(struct file *file,
+					const char __user *user_buf,
+					size_t count, loff_t *ppos)
+{
+	struct cc33xx *cc = file->private_data;
+	struct cc33xx_vif *wlvif;
+	unsigned long value;
+	int ret;
+
+	ret = kstrtoul_from_user(user_buf, count, 10, &value);
+	if (ret < 0) {
+		cc33xx_warning("illegal value in dynamic_ps");
+		return -EINVAL;
+	}
+
+	if (value < 1 || value > 65535) {
+		cc33xx_warning("dynamic_ps_timeout is not in valid range");
+		return -ERANGE;
+	}
+
+	mutex_lock(&cc->mutex);
+
+	cc->conf.host_conf.conn.dynamic_ps_timeout = value;
+
+	if (unlikely(cc->state != CC33XX_STATE_ON))
+		goto out;
+
+	/* In case we're already in PSM, trigger it again to set new timeout
+	 * immediately without waiting for re-association
+	 */
+
+	cc33xx_for_each_wlvif_sta(cc, wlvif) {
+		if (test_bit(WLVIF_FLAG_IN_PS, &wlvif->flags))
+			cc33xx_ps_set_mode(cc, wlvif, STATION_AUTO_PS_MODE);
+	}
+
+out:
+	mutex_unlock(&cc->mutex);
+	return count;
+}
+
+static const struct file_operations dynamic_ps_timeout_ops = {
+	.read = dynamic_ps_timeout_read,
+	.write = dynamic_ps_timeout_write,
+	.open = simple_open,
+	.llseek = default_llseek,
+};
+
+static ssize_t forced_ps_read(struct file *file, char __user *user_buf,
+			      size_t count, loff_t *ppos)
+{
+	struct cc33xx *cc = file->private_data;
+
+	return cc33xx_format_buffer(user_buf, count, ppos, "%d\n",
+				    cc->conf.host_conf.conn.forced_ps);
+}
+
+static ssize_t forced_ps_write(struct file *file, const char __user *user_buf,
+			       size_t count, loff_t *ppos)
+{
+	struct cc33xx *cc = file->private_data;
+	struct cc33xx_vif *wlvif;
+	unsigned long value;
+	int ret, ps_mode;
+
+	ret = kstrtoul_from_user(user_buf, count, 10, &value);
+	if (ret < 0) {
+		cc33xx_warning("illegal value in forced_ps");
+		return -EINVAL;
+	}
+
+	if (value != 1 && value != 0) {
+		cc33xx_warning("forced_ps should be either 0 or 1");
+		return -ERANGE;
+	}
+
+	mutex_lock(&cc->mutex);
+
+	if (cc->conf.host_conf.conn.forced_ps == value)
+		goto out;
+
+	cc->conf.host_conf.conn.forced_ps = value;
+
+	if (unlikely(cc->state != CC33XX_STATE_ON))
+		goto out;
+
+	/* In case we're already in PSM, trigger it again to switch mode
+	 * immediately without waiting for re-association
+	 */
+
+	ps_mode = value ? STATION_POWER_SAVE_MODE : STATION_AUTO_PS_MODE;
+
+	cc33xx_for_each_wlvif_sta(cc, wlvif) {
+		if (test_bit(WLVIF_FLAG_IN_PS, &wlvif->flags))
+			cc33xx_ps_set_mode(cc, wlvif, ps_mode);
+	}
+
+out:
+	mutex_unlock(&cc->mutex);
+	return count;
+}
+
+static const struct file_operations forced_ps_ops = {
+	.read = forced_ps_read,
+	.write = forced_ps_write,
+	.open = simple_open,
+	.llseek = default_llseek,
+};
+
+static ssize_t split_scan_timeout_read(struct file *file, char __user *user_buf,
+				       size_t count, loff_t *ppos)
+{
+	struct cc33xx *cc = file->private_data;
+
+	return cc33xx_format_buffer(user_buf, count, ppos, "%d\n",
+				    cc->conf.host_conf.scan.split_scan_timeout / 1000);
+}
+
+static ssize_t split_scan_timeout_write(struct file *file,
+					const char __user *user_buf,
+					size_t count, loff_t *ppos)
+{
+	struct cc33xx *cc = file->private_data;
+	unsigned long value;
+	int ret;
+
+	ret = kstrtoul_from_user(user_buf, count, 10, &value);
+	if (ret < 0) {
+		cc33xx_warning("illegal value in split_scan_timeout");
+		return -EINVAL;
+	}
+
+	if (value == 0)
+		cc33xx_info("split scan will be disabled");
+
+	mutex_lock(&cc->mutex);
+
+	cc->conf.host_conf.scan.split_scan_timeout = value * 1000;
+
+	mutex_unlock(&cc->mutex);
+	return count;
+}
+
+static const struct file_operations split_scan_timeout_ops = {
+	.read = split_scan_timeout_read,
+	.write = split_scan_timeout_write,
+	.open = simple_open,
+	.llseek = default_llseek,
+};
+
+#define DRIVER_STATE_BUF_LEN 1024
+
+#define DRIVER_STATE_PRINT(x, fmt)   \
+	(res += scnprintf(buf + res, DRIVER_STATE_BUF_LEN - res,\
+			  #x " = " fmt "\n", cc->x))
+
+#define DRIVER_STATE_PRINT_GENERIC(x, fmt, args...)   \
+	(res += scnprintf(buf + res, DRIVER_STATE_BUF_LEN - res,\
+			  #x " = " fmt "\n", args))
+
+#define DRIVER_STATE_PRINT_LONG(x) DRIVER_STATE_PRINT(x, "%ld")
+#define DRIVER_STATE_PRINT_INT(x)  DRIVER_STATE_PRINT(x, "%d")
+#define DRIVER_STATE_PRINT_STR(x)  DRIVER_STATE_PRINT(x, "%s")
+#define DRIVER_STATE_PRINT_LHEX(x) DRIVER_STATE_PRINT(x, "0x%lx")
+#define DRIVER_STATE_PRINT_HEX(x)  DRIVER_STATE_PRINT(x, "0x%x")
+
+static ssize_t driver_state_read(struct file *file, char __user *user_buf,
+				 size_t count, loff_t *ppos)
+{
+	struct cc33xx *cc = file->private_data;
+	int res = 0;
+	ssize_t ret;
+	char *buf;
+	struct cc33xx_vif *wlvif;
+
+	buf = kmalloc(DRIVER_STATE_BUF_LEN, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	mutex_lock(&cc->mutex);
+
+	cc33xx_for_each_wlvif_sta(cc, wlvif) {
+		if (!test_bit(WLVIF_FLAG_STA_ASSOCIATED, &wlvif->flags))
+			continue;
+
+		DRIVER_STATE_PRINT_GENERIC(channel, "%d (%s)", wlvif->channel,
+					   wlvif->p2p ? "P2P-CL" : "STA");
+	}
+
+	cc33xx_for_each_wlvif_ap(cc, wlvif)
+		DRIVER_STATE_PRINT_GENERIC(channel, "%d (%s)", wlvif->channel,
+					   wlvif->p2p ? "P2P-GO" : "AP");
+
+	DRIVER_STATE_PRINT_INT(tx_blocks_available);
+	DRIVER_STATE_PRINT_INT(tx_allocated_blocks);
+	DRIVER_STATE_PRINT_INT(tx_allocated_pkts[0]);
+	DRIVER_STATE_PRINT_INT(tx_allocated_pkts[1]);
+	DRIVER_STATE_PRINT_INT(tx_allocated_pkts[2]);
+	DRIVER_STATE_PRINT_INT(tx_allocated_pkts[3]);
+	DRIVER_STATE_PRINT_INT(tx_frames_cnt);
+	DRIVER_STATE_PRINT_LHEX(tx_frames_map[0]);
+	DRIVER_STATE_PRINT_INT(tx_queue_count[0]);
+	DRIVER_STATE_PRINT_INT(tx_queue_count[1]);
+	DRIVER_STATE_PRINT_INT(tx_queue_count[2]);
+	DRIVER_STATE_PRINT_INT(tx_queue_count[3]);
+	DRIVER_STATE_PRINT_LHEX(flags);
+	DRIVER_STATE_PRINT_INT(rx_counter);
+	DRIVER_STATE_PRINT_INT(state);
+	DRIVER_STATE_PRINT_INT(band);
+	DRIVER_STATE_PRINT_INT(power_level);
+	DRIVER_STATE_PRINT_INT(enable_11a);
+	DRIVER_STATE_PRINT_LHEX(ap_fw_ps_map);
+	DRIVER_STATE_PRINT_LHEX(ap_ps_map);
+	DRIVER_STATE_PRINT_HEX(quirks);
+	/* TODO: ref_clock and tcxo_clock were moved to wl12xx priv */
+
+#undef DRIVER_STATE_PRINT_INT
+#undef DRIVER_STATE_PRINT_LONG
+#undef DRIVER_STATE_PRINT_HEX
+#undef DRIVER_STATE_PRINT_LHEX
+#undef DRIVER_STATE_PRINT_STR
+#undef DRIVER_STATE_PRINT
+#undef DRIVER_STATE_BUF_LEN
+
+	mutex_unlock(&cc->mutex);
+
+	ret = simple_read_from_buffer(user_buf, count, ppos, buf, res);
+	kfree(buf);
+	return ret;
+}
+
+static const struct file_operations driver_state_ops = {
+	.read = driver_state_read,
+	.open = simple_open,
+	.llseek = default_llseek,
+};
+
+static ssize_t vifs_state_read(struct file *file, char __user *user_buf,
+			       size_t count, loff_t *ppos)
+{
+	struct cc33xx *cc = file->private_data;
+	struct cc33xx_vif *wlvif;
+	int ret, res = 0;
+	const int buf_size = 4096;
+	char *buf;
+	char tmp_buf[64];
+
+	buf = kzalloc(buf_size, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	mutex_lock(&cc->mutex);
+
+#define VIF_STATE_PRINT(x, fmt)				\
+	(res += scnprintf(buf + res, buf_size - res,	\
+			  #x " = " fmt "\n", wlvif->x))
+
+#define VIF_STATE_PRINT_LONG(x)  VIF_STATE_PRINT(x, "%ld")
+#define VIF_STATE_PRINT_INT(x)   VIF_STATE_PRINT(x, "%d")
+#define VIF_STATE_PRINT_STR(x)   VIF_STATE_PRINT(x, "%s")
+#define VIF_STATE_PRINT_LHEX(x)  VIF_STATE_PRINT(x, "0x%lx")
+#define VIF_STATE_PRINT_LLHEX(x) VIF_STATE_PRINT(x, "0x%llx")
+#define VIF_STATE_PRINT_HEX(x)   VIF_STATE_PRINT(x, "0x%x")
+
+#define VIF_STATE_PRINT_NSTR(x, len)				\
+	do {							\
+		memset(tmp_buf, 0, sizeof(tmp_buf));		\
+		memcpy(tmp_buf, wlvif->x,			\
+		       min_t(u8, len, sizeof(tmp_buf) - 1));	\
+		res += scnprintf(buf + res, buf_size - res,	\
+				 #x " = %s\n", tmp_buf);	\
+	} while (0)
+
+	cc33xx_for_each_wlvif(cc, wlvif) {
+		VIF_STATE_PRINT_INT(role_id);
+		VIF_STATE_PRINT_INT(bss_type);
+		VIF_STATE_PRINT_LHEX(flags);
+		VIF_STATE_PRINT_INT(p2p);
+		VIF_STATE_PRINT_INT(dev_role_id);
+		VIF_STATE_PRINT_INT(dev_hlid);
+
+		if (wlvif->bss_type == BSS_TYPE_STA_BSS ||
+		    wlvif->bss_type == BSS_TYPE_IBSS) {
+			VIF_STATE_PRINT_INT(sta.hlid);
+			VIF_STATE_PRINT_INT(sta.basic_rate_idx);
+			VIF_STATE_PRINT_INT(sta.ap_rate_idx);
+			VIF_STATE_PRINT_INT(sta.p2p_rate_idx);
+			VIF_STATE_PRINT_INT(sta.qos);
+		} else {
+			VIF_STATE_PRINT_INT(ap.global_hlid);
+			VIF_STATE_PRINT_INT(ap.bcast_hlid);
+			VIF_STATE_PRINT_LHEX(ap.sta_hlid_map[0]);
+			VIF_STATE_PRINT_INT(ap.mgmt_rate_idx);
+			VIF_STATE_PRINT_INT(ap.bcast_rate_idx);
+			VIF_STATE_PRINT_INT(ap.ucast_rate_idx[0]);
+			VIF_STATE_PRINT_INT(ap.ucast_rate_idx[1]);
+			VIF_STATE_PRINT_INT(ap.ucast_rate_idx[2]);
+			VIF_STATE_PRINT_INT(ap.ucast_rate_idx[3]);
+		}
+		VIF_STATE_PRINT_INT(last_tx_hlid);
+		VIF_STATE_PRINT_INT(tx_queue_count[0]);
+		VIF_STATE_PRINT_INT(tx_queue_count[1]);
+		VIF_STATE_PRINT_INT(tx_queue_count[2]);
+		VIF_STATE_PRINT_INT(tx_queue_count[3]);
+		VIF_STATE_PRINT_LHEX(links_map[0]);
+		VIF_STATE_PRINT_NSTR(ssid, wlvif->ssid_len);
+		VIF_STATE_PRINT_INT(band);
+		VIF_STATE_PRINT_INT(channel);
+		VIF_STATE_PRINT_HEX(bitrate_masks[0]);
+		VIF_STATE_PRINT_HEX(bitrate_masks[1]);
+		VIF_STATE_PRINT_HEX(basic_rate_set);
+		VIF_STATE_PRINT_HEX(basic_rate);
+		VIF_STATE_PRINT_HEX(rate_set);
+		VIF_STATE_PRINT_INT(beacon_int);
+		VIF_STATE_PRINT_INT(default_key);
+		VIF_STATE_PRINT_INT(aid);
+		VIF_STATE_PRINT_INT(psm_entry_retry);
+		VIF_STATE_PRINT_INT(power_level);
+		VIF_STATE_PRINT_INT(rssi_thold);
+		VIF_STATE_PRINT_INT(last_rssi_event);
+		VIF_STATE_PRINT_INT(ba_support);
+		VIF_STATE_PRINT_INT(ba_allowed);
+		VIF_STATE_PRINT_LLHEX(total_freed_pkts);
+	}
+
+#undef VIF_STATE_PRINT_INT
+#undef VIF_STATE_PRINT_LONG
+#undef VIF_STATE_PRINT_HEX
+#undef VIF_STATE_PRINT_LHEX
+#undef VIF_STATE_PRINT_LLHEX
+#undef VIF_STATE_PRINT_STR
+#undef VIF_STATE_PRINT_NSTR
+#undef VIF_STATE_PRINT
+
+	mutex_unlock(&cc->mutex);
+
+	ret = simple_read_from_buffer(user_buf, count, ppos, buf, res);
+	kfree(buf);
+	return ret;
+}
+
+static const struct file_operations vifs_state_ops = {
+	.read = vifs_state_read,
+	.open = simple_open,
+	.llseek = default_llseek,
+};
+
+static ssize_t dtim_interval_read(struct file *file, char __user *user_buf,
+				  size_t count, loff_t *ppos)
+{
+	struct cc33xx *cc = file->private_data;
+	u8 value;
+
+	if (cc->conf.core.wake_up_event == CONF_WAKE_UP_EVENT_DTIM ||
+	    cc->conf.core.wake_up_event == CONF_WAKE_UP_EVENT_N_DTIM)
+		value = cc->conf.core.listen_interval;
+	else
+		value = 0;
+
+	return cc33xx_format_buffer(user_buf, count, ppos, "%d\n", value);
+}
+
+static ssize_t dtim_interval_write(struct file *file,
+				   const char __user *user_buf,
+				   size_t count, loff_t *ppos)
+{
+	struct cc33xx *cc = file->private_data;
+	struct cc33xx_vif *wlvif = NULL;
+	struct ieee80211_sub_if_data *sdata = NULL;
+	struct ieee80211_vif *vif = NULL;
+	unsigned long value;
+	int ret;
+
+	ret = kstrtoul_from_user(user_buf, count, 10, &value);
+	if (ret < 0) {
+		cc33xx_warning("illegal value for dtim_interval");
+		return -EINVAL;
+	}
+
+	if (value < 1 || value > 10) {
+		cc33xx_warning("dtim value is not in valid range");
+		return -ERANGE;
+	}
+
+	mutex_lock(&cc->mutex);
+
+	cc->conf.core.listen_interval = value;
+
+	if (value == 1)
+		cc->conf.core.wake_up_event = CONF_WAKE_UP_EVENT_DTIM;
+	else
+		cc->conf.core.wake_up_event = CONF_WAKE_UP_EVENT_N_DTIM;
+
+	cc33xx_for_each_wlvif_sta(cc, wlvif) {
+		if (!cc33xx_is_p2p_mgmt(wlvif))	{
+			vif = cc33xx_wlvif_to_vif(wlvif);
+			sdata = vif_to_sdata(vif);
+			cc33xx_debug(DEBUG_CMD, "Setting LSI on interface %s",
+				     sdata->name);
+			ret = cc33xx_acx_wake_up_conditions(cc, wlvif,
+							    cc->conf.core.wake_up_event,
+						cc->conf.core.listen_interval);
+			if (ret < 0) {
+				vif = cc33xx_wlvif_to_vif(wlvif);
+				sdata = vif_to_sdata(vif);
+				cc33xx_warning("Failed to set LSI on interface %s",
+					       sdata->name);
+				return ret;
+			}
+		}
+	}
+	mutex_unlock(&cc->mutex);
+	return count;
+}
+
+static const struct file_operations dtim_interval_ops = {
+	.read = dtim_interval_read,
+	.write = dtim_interval_write,
+	.open = simple_open,
+	.llseek = default_llseek,
+};
+
+static ssize_t suspend_dtim_interval_read(struct file *file,
+					  char __user *user_buf,
+					  size_t count, loff_t *ppos)
+{
+	struct cc33xx *cc = file->private_data;
+	u8 value;
+
+	if (cc->conf.core.suspend_wake_up_event == CONF_WAKE_UP_EVENT_DTIM ||
+	    cc->conf.core.suspend_wake_up_event == CONF_WAKE_UP_EVENT_N_DTIM)
+		value = cc->conf.core.suspend_listen_interval;
+	else
+		value = 0;
+
+	return cc33xx_format_buffer(user_buf, count, ppos, "%d\n", value);
+}
+
+static ssize_t suspend_dtim_interval_write(struct file *file,
+					   const char __user *user_buf,
+					   size_t count, loff_t *ppos)
+{
+	struct cc33xx *cc = file->private_data;
+	unsigned long value;
+	int ret;
+
+	ret = kstrtoul_from_user(user_buf, count, 10, &value);
+	if (ret < 0) {
+		cc33xx_warning("illegal value for suspend_dtim_interval");
+		return -EINVAL;
+	}
+
+	if (value < 1 || value > 10) {
+		cc33xx_warning("suspend_dtim value is not in valid range");
+		return -ERANGE;
+	}
+
+	mutex_lock(&cc->mutex);
+
+	cc->conf.core.suspend_listen_interval = value;
+	/* for some reason there are different event types for 1 and >1 */
+	if (value == 1)
+		cc->conf.core.suspend_wake_up_event = CONF_WAKE_UP_EVENT_DTIM;
+	else
+		cc->conf.core.suspend_wake_up_event = CONF_WAKE_UP_EVENT_N_DTIM;
+
+	mutex_unlock(&cc->mutex);
+	return count;
+}
+
+static const struct file_operations suspend_dtim_interval_ops = {
+	.read = suspend_dtim_interval_read,
+	.write = suspend_dtim_interval_write,
+	.open = simple_open,
+	.llseek = default_llseek,
+};
+
+static ssize_t beacon_interval_read(struct file *file, char __user *user_buf,
+				    size_t count, loff_t *ppos)
+{
+	struct cc33xx *cc = file->private_data;
+	u8 value;
+
+	if (cc->conf.core.wake_up_event == CONF_WAKE_UP_EVENT_BEACON ||
+	    cc->conf.core.wake_up_event == CONF_WAKE_UP_EVENT_N_BEACONS)
+		value = cc->conf.core.listen_interval;
+	else
+		value = 0;
+
+	return cc33xx_format_buffer(user_buf, count, ppos, "%d\n", value);
+}
+
+static ssize_t beacon_interval_write(struct file *file,
+				     const char __user *user_buf,
+				     size_t count, loff_t *ppos)
+{
+	struct cc33xx *cc = file->private_data;
+	unsigned long value;
+	int ret;
+
+	ret = kstrtoul_from_user(user_buf, count, 10, &value);
+	if (ret < 0) {
+		cc33xx_warning("illegal value for beacon_interval");
+		return -EINVAL;
+	}
+
+	if (value < 1 || value > 255) {
+		cc33xx_warning("beacon interval value is not in valid range");
+		return -ERANGE;
+	}
+
+	mutex_lock(&cc->mutex);
+
+	cc->conf.core.listen_interval = value;
+	/* for some reason there are different event types for 1 and >1 */
+	if (value == 1)
+		cc->conf.core.wake_up_event = CONF_WAKE_UP_EVENT_BEACON;
+	else
+		cc->conf.core.wake_up_event = CONF_WAKE_UP_EVENT_N_BEACONS;
+
+	/* we don't reconfigure ACX_WAKE_UP_CONDITIONS now, so it will only
+	 * take effect on the next time we enter psm.
+	 */
+	mutex_unlock(&cc->mutex);
+	return count;
+}
+
+static const struct file_operations beacon_interval_ops = {
+	.read = beacon_interval_read,
+	.write = beacon_interval_write,
+	.open = simple_open,
+	.llseek = default_llseek,
+};
+
+static ssize_t beacon_filtering_write(struct file *file,
+				      const char __user *user_buf,
+				      size_t count, loff_t *ppos)
+{
+	struct cc33xx *cc = file->private_data;
+	struct cc33xx_vif *wlvif;
+	unsigned long value;
+	int ret;
+
+	ret = kstrtoul_from_user(user_buf, count, 0, &value);
+	if (ret < 0) {
+		cc33xx_warning("illegal value for beacon_filtering!");
+		return -EINVAL;
+	}
+
+	mutex_lock(&cc->mutex);
+
+	cc33xx_for_each_wlvif(cc, wlvif) {
+		ret = cc33xx_acx_beacon_filter_opt(cc, wlvif, !!value);
+	}
+
+	mutex_unlock(&cc->mutex);
+	return count;
+}
+
+static const struct file_operations beacon_filtering_ops = {
+	.write = beacon_filtering_write,
+	.open = simple_open,
+	.llseek = default_llseek,
+};
+
+static ssize_t fw_stats_raw_read(struct file *file, char __user *userbuf,
+				 size_t count, loff_t *ppos)
+{
+	struct cc33xx *cc = file->private_data;
+
+	cc33xx_debugfs_update_stats(cc);
+
+	return simple_read_from_buffer(userbuf, count, ppos,
+				       cc->stats.fw_stats,
+				       sizeof(struct cc33xx_acx_statistics));
+}
+
+static const struct file_operations fw_stats_raw_ops = {
+	.read = fw_stats_raw_read,
+	.open = simple_open,
+	.llseek = default_llseek,
+};
+
+static ssize_t sleep_auth_read(struct file *file, char __user *user_buf,
+			       size_t count, loff_t *ppos)
+{
+	struct cc33xx *cc = file->private_data;
+
+	return cc33xx_format_buffer(user_buf, count, ppos, "%d\n",
+				    cc->sleep_auth);
+}
+
+static ssize_t sleep_auth_write(struct file *file, const char __user *user_buf,
+				size_t count, loff_t *ppos)
+{
+	struct cc33xx *cc = file->private_data;
+	unsigned long value;
+	int ret;
+
+	ret = kstrtoul_from_user(user_buf, count, 0, &value);
+	if (ret < 0) {
+		cc33xx_warning("illegal value in sleep_auth");
+		return -EINVAL;
+	}
+
+	if (value > CC33XX_PSM_MAX) {
+		cc33xx_warning("sleep_auth must be between 0 and %d",
+			       CC33XX_PSM_MAX);
+		return -ERANGE;
+	}
+
+	mutex_lock(&cc->mutex);
+
+	cc->conf.host_conf.conn.sta_sleep_auth = value;
+
+	if (unlikely(cc->state != CC33XX_STATE_ON)) {
+		/* this will show up on "read" in case we are off */
+		cc->sleep_auth = value;
+		goto out;
+	}
+
+	cc33xx_acx_sleep_auth(cc, value);
+
+out:
+	mutex_unlock(&cc->mutex);
+	return count;
+}
+
+static const struct file_operations sleep_auth_ops = {
+	.read = sleep_auth_read,
+	.write = sleep_auth_write,
+	.open = simple_open,
+	.llseek = default_llseek,
+};
+
+static ssize_t ble_enable_read(struct file *file, char __user *user_buf,
+			       size_t count, loff_t *ppos)
+{
+	struct cc33xx *cc = file->private_data;
+
+	return cc33xx_format_buffer(user_buf, count, ppos,
+				    "%d\n", cc->ble_enable);
+}
+
+static ssize_t ble_enable_write(struct file *file, const char __user *user_buf,
+				size_t count, loff_t *ppos)
+{
+	struct cc33xx *cc = file->private_data;
+	unsigned long value;
+	int ret;
+
+	ret = kstrtoul_from_user(user_buf, count, 0, &value);
+
+	if (value == cc->ble_enable) {
+		cc33xx_warning("ble_enable is already %d", cc->ble_enable);
+		return -EINVAL;
+	}
+
+	if (value != 1) {
+		cc33xx_warning("illegal value in ble_enable (only value allowed is 1)");
+		cc33xx_warning("ble_enable can't be disabled after being enabled.");
+		return -EINVAL;
+	}
+
+	mutex_lock(&cc->mutex);
+
+	if (unlikely(cc->state != CC33XX_STATE_ON)) {
+		/* this will show up on "read" in case we are off */
+		cc->ble_enable = value;
+		goto out;
+	}
+
+	cc33xx_ble_enable(cc, value);
+out:
+	mutex_unlock(&cc->mutex);
+	return count;
+}
+
+static const struct file_operations ble_enable_ops = {
+	.read = ble_enable_read,
+	.write = ble_enable_write,
+	.open = simple_open,
+	.llseek = default_llseek,
+};
+
+static inline ssize_t set_tsf_read(struct file *file, char __user *user_buf,
+				   size_t count, loff_t *ppos)
+{
+	return cc33xx_format_buffer(user_buf, count, ppos, "%llx\n", 0LL);
+}
+
+static ssize_t set_tsf_write(struct file *file, const char __user *user_buf,
+			     size_t count, loff_t *ppos)
+{
+	struct cc33xx *cc = file->private_data;
+	unsigned long long value;
+	int ret;
+
+	ret = kstrtoull_from_user(user_buf, count, 0, &value);
+	if (ret < 0) {
+		cc33xx_warning("illegal value in set_tsf");
+		return -EINVAL;
+	}
+
+	mutex_lock(&cc->mutex);
+
+	if (unlikely(cc->state != CC33XX_STATE_ON))
+		goto out;
+
+	cc33xx_acx_set_tsf(cc, value);
+
+out:
+	mutex_unlock(&cc->mutex);
+	return count;
+}
+
+static const struct file_operations set_tsf_ops = {
+	.open = simple_open,
+	.read = set_tsf_read,
+	.write = set_tsf_write,
+	.llseek = default_llseek,
+};
+
+#define TWT_ACTION_SETUP	(1)
+#define TWT_ACTION_SUSPEND	(2)
+#define TWT_ACTION_RESUME	(3)
+#define TWT_ACTION_TERMINATE	(4)
+
+static ssize_t twt_action_read(struct file *file, char __user *user_buf,
+			       size_t count, loff_t *ppos)
+{
+	struct cc33xx *cc = file->private_data;
+
+	return cc33xx_format_buffer(user_buf, count, ppos, "%d %d %d %d %d\n",
+				    cc->min_wake_duration_usec,
+				    cc->min_wake_interval_mantissa,
+				    cc->min_wake_interval_exponent,
+				    cc->max_wake_interval_mantissa,
+				    cc->max_wake_interval_exponent);
+}
+
+static ssize_t twt_action_write(struct file *file,
+				const char __user *user_buf,
+				size_t count, loff_t *ppos)
+{
+	struct cc33xx *cc = file->private_data;
+
+	int min_wake_duration_usec = 0;
+	int min_wake_interval_mantissa = 0;
+	int min_wake_interval_exponent = 0;
+	int max_wake_interval_mantissa = 0;
+	int max_wake_interval_exponent = 0;
+	int twt_action_type;
+	u8 valid_params;
+	int ret;
+	int arg_count;
+	char *buffer;
+
+	buffer = kzalloc(count, GFP_KERNEL);
+	if (!buffer) {
+		ret = -ENOMEM;
+		cc33xx_warning("error in twt_action: %d", ret);
+		return ret;
+	}
+
+	ret = strncpy_from_user(buffer, user_buf, count);
+	if (-EFAULT == ret) {
+		cc33xx_warning("error in twt_action: %d", ret);
+		kfree(buffer);
+		return ret;
+	}
+
+	arg_count = sscanf(buffer, "%d %d %d %d %d %d", &twt_action_type,
+			   &min_wake_duration_usec, &min_wake_interval_mantissa,
+			   &min_wake_interval_exponent,
+			   &max_wake_interval_mantissa,
+			   &max_wake_interval_exponent);
+
+	kfree(buffer);
+
+#define TWT_ACTION_SETUP	(1)
+#define TWT_ACTION_SUSPEND	(2)
+#define TWT_ACTION_RESUME	(3)
+#define TWT_ACTION_TERMINATE	(4)
+
+	valid_params = 0;
+
+	if (twt_action_type == TWT_ACTION_SETUP && arg_count > 1) {
+		if (min_wake_duration_usec < 256) {
+			cc33xx_warning("error in twt_action: duration cannot be under 256 ");
+			return count;
+		}
+
+		if (min_wake_interval_mantissa <= 0) {
+			cc33xx_warning("error in twt_action: interval mantissa must be over 0 ");
+			return count;
+		}
+
+		if (min_wake_interval_exponent < 0 ||
+		    max_wake_interval_mantissa < 0 ||
+		    max_wake_interval_exponent < 0) {
+			cc33xx_warning("error in twt_action: negative value not allowed ");
+			return count;
+		}
+	}
+
+	mutex_lock(&cc->mutex);
+
+	if (unlikely(cc->state != CC33XX_STATE_ON))
+		goto out;
+
+	/* valid input is:
+	 * twt_action  [min_wake_duration_usec
+	 *		min_wake_interval_mantissa
+	 *		min_wake_interval_exponent
+	 *			[max_wake_interval_mantissa
+	 *			 max_wake_interval_exponent]]
+	 */
+	if (twt_action_type != TWT_ACTION_SETUP && arg_count != 1) {
+		cc33xx_warning("illegal arguments in twt_action");
+		cc33xx_warning("twt_action_type: %d", twt_action_type);
+		goto out;
+	}
+
+	switch (twt_action_type) {
+	case TWT_ACTION_SETUP:{
+		if (arg_count == 1) {
+		} else if (arg_count == 4) {
+			valid_params |= (MIN_WAKE_DURATION_VALID |
+					 MIN_WAKE_INTERVAL_MANTISSA_VALID |
+					 MIN_WAKE_INTERVAL_EXPONENT_VALID);
+		} else if (arg_count == 6) {
+			valid_params |= (MIN_WAKE_DURATION_VALID |
+					 MIN_WAKE_INTERVAL_MANTISSA_VALID |
+					 MIN_WAKE_INTERVAL_EXPONENT_VALID |
+					 MAX_WAKE_INTERVAL_MANTISSA_VALID |
+					 MAX_WAKE_INTERVAL_EXPONENT_VALID);
+		} else {
+			cc33xx_warning("illegal number of params for twt action setup");
+			break;
+		}
+
+		ret = cc33xx_acx_twt_setup(cc,
+					   min_wake_duration_usec, min_wake_interval_mantissa,
+			min_wake_interval_exponent, max_wake_interval_mantissa,
+			max_wake_interval_exponent, valid_params);
+		break;
+	}
+	case TWT_ACTION_SUSPEND: {
+		ret = cc33xx_acx_twt_suspend(cc);
+		break;
+	}
+	case TWT_ACTION_RESUME: {
+		ret = cc33xx_acx_twt_resume(cc);
+		break;
+	}
+	case TWT_ACTION_TERMINATE: {
+		ret = cc33xx_acx_twt_terminate(cc);
+		break;
+	}
+
+	default: {
+		cc33xx_warning("illegal twt command");
+		goto out;
+	}
+	}
+
+out:
+	mutex_unlock(&cc->mutex);
+	return count;
+}
+
+static const struct file_operations twt_action_ops = {
+	.open = simple_open,
+	.read = twt_action_read,
+	.write = twt_action_write,
+	.llseek = default_llseek,
+};
+
+static inline ssize_t dev_mem_read(struct file *file, char __user *user_buf,
+				   size_t count, loff_t *ppos)
+{
+	return 0;
+}
+
+static inline ssize_t dev_mem_write(struct file *file,
+				    const char __user *user_buf,
+				    size_t count, loff_t *ppos)
+{
+	return 0;
+}
+
+static loff_t dev_mem_seek(struct file *file, loff_t offset, int orig)
+{
+	/* only requests of dword-aligned size and offset are supported */
+	if (offset % 4)
+		return -EINVAL;
+
+	return no_seek_end_llseek(file, offset, orig);
+}
+
+static const struct file_operations dev_mem_ops = {
+	.open = simple_open,
+	.read = dev_mem_read,
+	.write = dev_mem_write,
+	.llseek = dev_mem_seek,
+};
+
+static ssize_t fw_logger_read(struct file *file, char __user *user_buf,
+			      size_t count, loff_t *ppos)
+{
+	struct cc33xx *cc = file->private_data;
+
+	return cc33xx_format_buffer(user_buf, count, ppos, "%d\n",
+				    cc->conf.host_conf.fwlog.output);
+}
+
+static ssize_t fw_logger_write(struct file *file, const char __user *user_buf,
+			       size_t count, loff_t *ppos)
+{
+	struct cc33xx *cc = file->private_data;
+	unsigned long value;
+	int ret;
+
+	ret = kstrtoul_from_user(user_buf, count, 0, &value);
+	if (ret < 0) {
+		cc33xx_warning("illegal value in fw_logger");
+		return -EINVAL;
+	}
+
+	if (value > 2 || value == 0) {
+		cc33xx_warning("fw_logger value must be 1-UART 2-SDIO");
+		return -ERANGE;
+	}
+
+	if (cc->conf.host_conf.fwlog.output == 0) {
+		cc33xx_warning("invalid operation - fw logger disabled by default, please change mode via wlconf");
+		return -EINVAL;
+	}
+
+	mutex_lock(&cc->mutex);
+
+	cc->conf.host_conf.fwlog.output = value;
+
+	cc33xx_cmd_config_fwlog(cc);
+
+	mutex_unlock(&cc->mutex);
+	return count;
+}
+
+static const struct file_operations fw_logger_ops = {
+	.open = simple_open,
+	.read = fw_logger_read,
+	.write = fw_logger_write,
+	.llseek = default_llseek,
+};
+
+static ssize_t antenna_select_read(struct file *file, char __user *user_buf,
+				   size_t count, loff_t *ppos)
+{
+	struct cc33xx *cc = file->private_data;
+
+	return cc33xx_format_buffer(user_buf, count, ppos, "%d\n",
+				    cc->antenna_selection);
+}
+
+static ssize_t antenna_select_write(struct file *file,
+				    const char __user *user_buf,
+				    size_t count, loff_t *ppos)
+{
+	struct cc33xx *cc = file->private_data;
+	int ret;
+	u8 selection;
+
+	ret = kstrtou8_from_user(user_buf, count, 0, &selection);
+	if (ret < 0) {
+		cc33xx_warning("illegal value in antenna_select");
+		return -EINVAL;
+	}
+
+	if (selection > 1) {
+		cc33xx_warning("selection should be either 0 or 1");
+		return -ERANGE;
+	}
+
+	mutex_lock(&cc->mutex);
+
+	if (unlikely(cc->state != CC33XX_STATE_ON))
+		goto out;
+
+	ret = cc33xx_acx_set_antenna_select(cc, selection);
+	if (ret == 0)
+		cc->antenna_selection = selection;
+
+out:
+	mutex_unlock(&cc->mutex);
+	return count;
+}
+
+static const struct file_operations antenna_select_ops = {
+	.open = simple_open,
+	.read = antenna_select_read,
+	.write = antenna_select_write,
+	.llseek = default_llseek,
+};
+
+static ssize_t get_versions_extended_read(struct file *file,
+					  char __user *user_buf,
+					  size_t count, loff_t *ppos)
+{
+	struct cc33xx *cc = file->private_data;
+	const char *driver_ver = cc->all_versions.driver_ver;
+	struct cc33xx_acx_fw_versions *fw_ver = cc->all_versions.fw_ver;
+
+	char all_versions_str[MAX_VERSIONS_EXTENDED_LEN];
+
+	sprintf(all_versions_str, "Driver Version: %s\n"
+		"Firmware Version: %u.%u.%u.%u\nPhy Version: %u.%u.%u.%u.%u.%u",
+		driver_ver,
+		le16_to_cpu(fw_ver->major_version), le16_to_cpu(fw_ver->minor_version),
+		le16_to_cpu(fw_ver->api_version), le16_to_cpu(fw_ver->build_version),
+		fw_ver->phy_version[5], fw_ver->phy_version[4],
+		fw_ver->phy_version[3], fw_ver->phy_version[2],
+		fw_ver->phy_version[1], fw_ver->phy_version[0]);
+
+	return cc33xx_format_buffer(user_buf, count, ppos, "%s\n",
+				    all_versions_str);
+}
+
+static const struct file_operations get_versions_extended_ops = {
+	.read = get_versions_extended_read,
+	.open = simple_open,
+	.llseek = default_llseek,
+};
+
+static ssize_t get_versions_read(struct file *file, char __user *user_buf,
+				 size_t count, loff_t *ppos)
+{
+	struct cc33xx *cc = file->private_data;
+	const char *driver_ver = cc->all_versions.driver_ver;
+	struct cc33xx_acx_fw_versions *fw_ver = cc->all_versions.fw_ver;
+
+	char all_versions_str[MAX_VERSIONS_LEN];
+
+	sprintf(all_versions_str,
+		"Driver Version: %s\nFirmware Version: %u.%u.%u",
+		driver_ver,
+		fw_ver->major_version, fw_ver->minor_version, fw_ver->api_version);
+
+	return cc33xx_format_buffer(user_buf, count, ppos, "%s\n",
+				    all_versions_str);
+}
+
+static const struct file_operations get_versions_ops = {
+	.read = get_versions_read,
+	.open = simple_open,
+	.llseek = default_llseek,
+};
+
+static ssize_t trigger_fw_assert_write(struct file *file,
+				       const char __user *user_buf,
+				       size_t count, loff_t *ppos)
+{
+	struct cc33xx *cc = file->private_data;
+
+	mutex_lock(&cc->mutex);
+
+	if (unlikely(cc->state != CC33XX_STATE_ON))
+		goto out;
+
+	cc33xx_acx_trigger_fw_assert(cc);
+
+out:
+	mutex_unlock(&cc->mutex);
+	return count;
+}
+
+static const struct file_operations trigger_fw_assert_ops = {
+	.open = simple_open,
+	.write = trigger_fw_assert_write,
+	.llseek = default_llseek,
+};
+
+static ssize_t burst_mode_read(struct file *file, char __user *user_buf,
+			       size_t count, loff_t *ppos)
+{
+	struct cc33xx *cc = file->private_data;
+
+	return cc33xx_format_buffer(user_buf, count, ppos,
+				    "%d\n", cc->burst_disable);
+}
+
+static ssize_t burst_mode_write(struct file *file, const char __user *user_buf,
+				size_t count, loff_t *ppos)
+{
+	struct cc33xx *cc = file->private_data;
+	int ret;
+	u8 burst_disable;
+
+	ret = kstrtou8_from_user(user_buf, count, 0, &burst_disable);
+	if (ret < 0) {
+		cc33xx_warning("illegal value in burst_mode");
+		return -EINVAL;
+	}
+
+	if (burst_disable > 1) {
+		cc33xx_warning("burst_disable should be either 0 or 1");
+		return -ERANGE;
+	}
+
+	mutex_lock(&cc->mutex);
+
+	if (unlikely(cc->state != CC33XX_STATE_ON))
+		goto out;
+
+	ret = cc33xx_acx_burst_mode_cfg(cc, burst_disable);
+	if (ret == 0)
+		cc->burst_disable = burst_disable;
+
+out:
+	mutex_unlock(&cc->mutex);
+	return count;
+}
+
+static const struct file_operations burst_mode_ops = {
+	.open = simple_open,
+	.read = burst_mode_read,
+	.write = burst_mode_write,
+	.llseek = default_llseek,
+};
+
+/* coex entities bitmap */
+#define  COEX_WIFI_ENABLE        (0x1)
+#define  COEX_BLE_ENABLE         (0x2)
+#define  COEX_SOC_ENABLE         (0x4)
+
+#define  MAX_COEX_STATISTICS_LEN (850)
+
+static ssize_t coex_statistics_read(struct file *file, char __user *user_buf,
+				    size_t count, loff_t *ppos)
+{
+	struct cc33xx *cc = file->private_data;
+	struct cc33xx_acx_coex_statistics *coex_stats_cmd;
+	char coex_statistics_str[MAX_COEX_STATISTICS_LEN];
+	struct cc33xx_coex_stat_and_entities *coex_stat_ent;
+	struct cc33xx_coex_statistics *coex_stats;
+	int res, restot = 0, ret = 0;
+
+	cc33xx_debug(DEBUG_CMD, "coex_statistics_read");
+
+	coex_stats_cmd = kzalloc(sizeof(*coex_stats_cmd),
+				 GFP_KERNEL);
+	if (!coex_stats_cmd)
+		return -ENOMEM;
+
+	coex_stat_ent = &coex_stats_cmd->coex_stat;
+	coex_stats = &coex_stat_ent->coex_statistics;
+
+	ret = cc33xx_cmd_interrogate(cc, READ_COEX_STATISTICS, coex_stats_cmd,
+				     sizeof(struct cc33xx_acx_coex_statistics),
+				     sizeof(struct cc33xx_acx_coex_statistics));
+
+	if (ret < 0) {
+		cc33xx_error("failed to send interrogate command");
+		goto out_free;
+	}
+
+	if (le16_to_cpu(coex_stats_cmd->header.cmd.status) == CMD_STATUS_INVALID_PARAM) {
+		cc33xx_error("Coex statistics are disabled");
+		goto out_free;
+	}
+
+	res = 0;
+
+	if (coex_stat_ent->coex_entities_bitmap & COEX_WIFI_ENABLE) {
+		res = snprintf(coex_statistics_str, MAX_COEX_STATISTICS_LEN,
+			       "wifi:\nrequest assertion/deassertion: %d/%d\r\n"
+			       "grant assertion/deassertion: %d/%d\r\n"
+			       "prio reject: %d\r\n"
+			       "grant during dual ant assertion/deassertion: %d/%d\r\n\n",
+			       le32_to_cpu(coex_stats->wifi_request_assertion_log),
+			       le32_to_cpu(coex_stats->wifi_request_de_assertion_log),
+			       le32_to_cpu(coex_stats->wifi_grant_assertion_log),
+			       le32_to_cpu(coex_stats->wifi_grant_deassertion_log),
+			       le32_to_cpu(coex_stats->wifi_prio_reject_log),
+			       le32_to_cpu(coex_stats->wifi_grant_during_dual_ant_assertion_log),
+			       le32_to_cpu(coex_stats->wifi_grant_during_dual_ant_deassertion_log));
+		restot = res;
+	}
+
+	if (coex_stat_ent->coex_entities_bitmap & COEX_BLE_ENABLE) {
+		res = snprintf(coex_statistics_str + restot,
+			       MAX_COEX_STATISTICS_LEN - restot, "ble:\n"
+			       "request assertion/deassertion: %d/%d\r\n"
+			       "grant assertion/deassertion: %d/%d\r\n"
+			       "tx high/low prio reject: %d/%d\r\n"
+			       "rx high/low prio reject: %d/%d\r\n\n",
+			       le32_to_cpu(coex_stats->ble_request_assertion_log),
+			       le32_to_cpu(coex_stats->ble_request_deassertion_log),
+			       le32_to_cpu(coex_stats->ble_grant_assertion_log),
+			       le32_to_cpu(coex_stats->ble_grant_deassertion_log),
+			       le32_to_cpu(coex_stats->ble_tx_high_prio_reject_log),
+			       le32_to_cpu(coex_stats->ble_tx_low_prio_reject_log),
+			       le32_to_cpu(coex_stats->ble_rx_high_prio_reject_log),
+			       le32_to_cpu(coex_stats->ble_rx_low_prio_reject_log));
+		restot += res;
+	}
+
+	if (coex_stat_ent->coex_entities_bitmap & COEX_SOC_ENABLE) {
+		res = snprintf(coex_statistics_str + restot,
+			       MAX_COEX_STATISTICS_LEN - restot,
+			       "External SoC:\n"
+			       "request assertion/deassertion: %d/%d\r\n"
+			       "grant assertion/deassertion: %d/%d\r\n"
+			       "high/low prio reject: %d/%d\r\n\n",
+			       le32_to_cpu(coex_stats->soc_request_assertion_log),
+			       le32_to_cpu(coex_stats->soc_request_deassertion_log),
+			       le32_to_cpu(coex_stats->soc_grant_assertion_log),
+			       le32_to_cpu(coex_stats->soc_grant_deassertion_log),
+			       le32_to_cpu(coex_stats->soc_high_prio_reject_log),
+			       le32_to_cpu(coex_stats->soc_low_prio_reject_log));
+		restot += res;
+	}
+
+	ret = simple_read_from_buffer(user_buf, count, ppos,
+				      coex_statistics_str, restot);
+
+out_free:
+	kfree(coex_stats_cmd);
+
+	return ret;
+}
+
+static ssize_t coex_statistics_write(struct file *file,
+				     const char __user *user_buf,
+				     size_t count, loff_t *ppos)
+{
+	struct cc33xx *cc = file->private_data;
+	unsigned int value;
+	struct cc33xx_acx_coex_statistics_cfg *coex_statictics;
+	int ret;
+
+	ret = kstrtouint_from_user(user_buf, count, 0, &value);
+	if (value > 2) {
+		cc33xx_warning("Parameter value must be 0-Disable Coex counters, 1-Enable Coex counters, 2-Reset Coex counters");
+		return -ERANGE;
+	}
+
+	cc33xx_debug(DEBUG_CMD, "coex statistics (%d)", value);
+
+	coex_statictics = kzalloc(sizeof(*coex_statictics),
+				  GFP_KERNEL);
+	if (!coex_statictics) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	coex_statictics->coex_statictics = value;
+
+	mutex_lock(&cc->mutex);
+
+	ret = cc33xx_cmd_configure(cc, START_COEX_STATISTICS_CFG,
+				   coex_statictics,
+				   sizeof(struct cc33xx_acx_coex_statistics_cfg));
+	if (ret < 0) {
+		cc33xx_error("failed to initiate coex statictics");
+		goto out_free;
+	}
+
+out_free:
+	kfree(coex_statictics);
+
+out:
+	mutex_unlock(&cc->mutex);
+
+	return count;
+}
+
+static const struct file_operations coex_statistics_ops = {
+	.open = simple_open,
+	.read = coex_statistics_read,
+	.write = coex_statistics_write,
+	.llseek = default_llseek,
+};
+
+static ssize_t antenna_diversity_enable_read(struct file *file,
+					     char __user *user_buf,
+					     size_t count, loff_t *ppos)
+{
+	struct cc33xx *cc = file->private_data;
+
+	return cc33xx_format_buffer(user_buf, count, ppos, "%d\n",
+				    cc->diversity.diversity_enable);
+}
+
+static ssize_t antenna_diversity_enable_write(struct file *file,
+					      const char __user *user_buf,
+					      size_t count, loff_t *ppos)
+{
+	struct cc33xx *cc = file->private_data;
+	int ret;
+	u8 diversity_enable;
+
+	ret = kstrtou8_from_user(user_buf, count, 0, &diversity_enable);
+	if (ret < 0) {
+		cc33xx_warning("illegal value in antenna_diversity_enable");
+		return -EINVAL;
+	}
+
+	if (cc->conf.phy.num_of_antennas == 1 && diversity_enable == 1) {
+		cc33xx_warning("diversity cannot be enabled when only one antenna on board");
+		return -EINVAL;
+	}
+
+	if (diversity_enable > 1) {
+		cc33xx_warning("diversity_enable should be either 0 or 1");
+		return -ERANGE;
+	}
+
+	mutex_lock(&cc->mutex);
+
+	if (unlikely(cc->state != CC33XX_STATE_ON))
+		goto out;
+
+	ret = cc33xx_acx_antenna_diversity_enable(cc, diversity_enable);
+	if (ret == 0)
+		cc->diversity.diversity_enable = diversity_enable;
+
+out:
+	mutex_unlock(&cc->mutex);
+	return count;
+}
+
+static const struct file_operations antenna_diversity_enable_ops = {
+	.open = simple_open,
+	.read = antenna_diversity_enable_read,
+	.write = antenna_diversity_enable_write,
+	.llseek = default_llseek,
+};
+
+static ssize_t antenna_diversity_set_rssi_threshold_read(struct file *file,
+							 char __user *user_buf,
+							 size_t count,
+							 loff_t *ppos)
+{
+	struct cc33xx *cc = file->private_data;
+
+	return cc33xx_format_buffer(user_buf, count, ppos, "%d\n",
+				    cc->diversity.rssi_threshold);
+}
+
+static ssize_t antenna_diversity_set_rssi_threshold_write(struct file *file,
+							  const char __user *user_buf,
+							  size_t count,
+							  loff_t *ppos)
+{
+	struct cc33xx *cc = file->private_data;
+	int ret;
+	s8 rssi_threshold;
+
+	ret = kstrtos8_from_user(user_buf, count, 0, &rssi_threshold);
+	if (ret < 0) {
+		cc33xx_warning("illegal value in antenna_diversity_set_rssi_threshold");
+		return -EINVAL;
+	}
+
+	mutex_lock(&cc->mutex);
+
+	if (unlikely(cc->state != CC33XX_STATE_ON))
+		goto out;
+
+	ret = cc33xx_acx_antenna_diversity_set_rssi_threshold(cc, rssi_threshold);
+	if (ret == 0)
+		cc->diversity.rssi_threshold = rssi_threshold;
+
+out:
+	mutex_unlock(&cc->mutex);
+	return count;
+}
+
+static const struct file_operations antenna_diversity_set_rssi_threshold_ops = {
+	.open = simple_open,
+	.read = antenna_diversity_set_rssi_threshold_read,
+	.write = antenna_diversity_set_rssi_threshold_write,
+	.llseek = default_llseek,
+};
+
+static ssize_t antenna_diversity_select_default_antenna_read(struct file *file,
+							     char __user *user_buf,
+							     size_t count,
+							     loff_t *ppos)
+{
+	struct cc33xx *cc = file->private_data;
+
+	return cc33xx_format_buffer(user_buf, count, ppos, "%d\n",
+				    cc->diversity.default_antenna);
+}
+
+static ssize_t antenna_diversity_select_default_antenna_write(struct file *file,
+							      const char __user *user_buf,
+							      size_t count,
+							      loff_t *ppos)
+{
+	struct cc33xx *cc = file->private_data;
+	int ret;
+	u8 default_antenna;
+
+	ret = kstrtou8_from_user(user_buf, count, 0, &default_antenna);
+	if (ret < 0) {
+		cc33xx_warning("illegal value in antenna_diversity_select_default_antenna");
+		return -EINVAL;
+	}
+
+	if (cc->conf.phy.num_of_antennas == 1) {
+		cc33xx_warning("cannot change default antenna in board with only one antenna");
+		return -EINVAL;
+	}
+
+	if (default_antenna > 1) {
+		cc33xx_warning("default_antenna should be either 0 or 1");
+		return -ERANGE;
+	}
+
+	mutex_lock(&cc->mutex);
+
+	if (unlikely(cc->state != CC33XX_STATE_ON))
+		goto out;
+
+	ret = cc33xx_acx_antenna_diversity_select_default_antenna(cc, default_antenna);
+	if (ret == 0)
+		cc->diversity.default_antenna = default_antenna;
+
+out:
+	mutex_unlock(&cc->mutex);
+	return count;
+}
+
+static const struct file_operations antenna_diversity_select_default_antenna_ops = {
+	.open = simple_open,
+	.read = antenna_diversity_select_default_antenna_read,
+	.write = antenna_diversity_select_default_antenna_write,
+	.llseek = default_llseek,
+};
+
+static int cc33xx_debugfs_add_files(struct cc33xx *cc,
+				    struct dentry *rootdir)
+{
+	struct dentry *stats, *moddir;
+
+	moddir = rootdir;
+	stats = debugfs_create_dir("fw_stats", rootdir);
+
+	DEBUGFS_ADD(tx_queue_len, rootdir);
+	DEBUGFS_ADD(retry_count, rootdir);
+	DEBUGFS_ADD(excessive_retries, rootdir);
+	DEBUGFS_ADD(gpio_power, rootdir);
+	DEBUGFS_ADD(start_recovery, rootdir);
+	DEBUGFS_ADD(driver_state, rootdir);
+	DEBUGFS_ADD(vifs_state, rootdir);
+	DEBUGFS_ADD(dtim_interval, rootdir);
+	DEBUGFS_ADD(suspend_dtim_interval, rootdir);
+	DEBUGFS_ADD(beacon_interval, rootdir);
+	DEBUGFS_ADD(beacon_filtering, rootdir);
+	DEBUGFS_ADD(dynamic_ps_timeout, rootdir);
+	DEBUGFS_ADD(forced_ps, rootdir);
+	DEBUGFS_ADD(split_scan_timeout, rootdir);
+	DEBUGFS_ADD(fw_stats_raw, rootdir);
+	DEBUGFS_ADD(sleep_auth, rootdir);
+	DEBUGFS_ADD(ble_enable, rootdir);
+	DEBUGFS_ADD(set_tsf, rootdir);
+	DEBUGFS_ADD(twt_action, rootdir);
+	DEBUGFS_ADD(fw_logger, rootdir);
+	DEBUGFS_ADD(antenna_select, rootdir);
+	DEBUGFS_ADD(get_versions, rootdir);
+	DEBUGFS_ADD(get_versions_extended, rootdir);
+	DEBUGFS_ADD(trigger_fw_assert, rootdir);
+	DEBUGFS_ADD(burst_mode, rootdir);
+	DEBUGFS_ADD(coex_statistics, rootdir);
+	DEBUGFS_ADD(clear_fw_stats, stats);
+	DEBUGFS_ADD(antenna_diversity_enable, rootdir);
+	DEBUGFS_ADD(antenna_diversity_set_rssi_threshold, rootdir);
+	DEBUGFS_ADD(antenna_diversity_select_default_antenna, rootdir);
+
+	DEBUGFS_ADD_PREFIX(dev, mem, rootdir);
+
+	DEBUGFS_FWSTATS_ADD(error, error_frame_non_ctrl);
+	DEBUGFS_FWSTATS_ADD(error, error_frame_ctrl);
+	DEBUGFS_FWSTATS_ADD(error, error_frame_during_protection);
+	DEBUGFS_FWSTATS_ADD(error, null_frame_tx_start);
+	DEBUGFS_FWSTATS_ADD(error, null_frame_cts_start);
+	DEBUGFS_FWSTATS_ADD(error, bar_retry);
+	DEBUGFS_FWSTATS_ADD(error, num_frame_cts_nul_flid);
+	DEBUGFS_FWSTATS_ADD(error, tx_abort_failure);
+	DEBUGFS_FWSTATS_ADD(error, tx_resume_failure);
+	DEBUGFS_FWSTATS_ADD(error, rx_cmplt_db_overflow_cnt);
+	DEBUGFS_FWSTATS_ADD(error, elp_while_rx_exch);
+	DEBUGFS_FWSTATS_ADD(error, elp_while_tx_exch);
+	DEBUGFS_FWSTATS_ADD(error, elp_while_tx);
+	DEBUGFS_FWSTATS_ADD(error, elp_while_nvic_pending);
+	DEBUGFS_FWSTATS_ADD(error, rx_excessive_frame_len);
+	DEBUGFS_FWSTATS_ADD(error, burst_mismatch);
+	DEBUGFS_FWSTATS_ADD(error, tbc_exch_mismatch);
+	DEBUGFS_FWSTATS_ADD(tx, tx_prepared_descs);
+	DEBUGFS_FWSTATS_ADD(tx, tx_cmplt);
+	DEBUGFS_FWSTATS_ADD(tx, tx_template_prepared);
+	DEBUGFS_FWSTATS_ADD(tx, tx_data_prepared);
+	DEBUGFS_FWSTATS_ADD(tx, tx_template_programmed);
+	DEBUGFS_FWSTATS_ADD(tx, tx_data_programmed);
+	DEBUGFS_FWSTATS_ADD(tx, tx_burst_programmed);
+	DEBUGFS_FWSTATS_ADD(tx, tx_starts);
+	DEBUGFS_FWSTATS_ADD(tx, tx_stop);
+	DEBUGFS_FWSTATS_ADD(tx, tx_start_templates);
+	DEBUGFS_FWSTATS_ADD(tx, tx_start_int_templates);
+	DEBUGFS_FWSTATS_ADD(tx, tx_start_fw_gen);
+	DEBUGFS_FWSTATS_ADD(tx, tx_start_data);
+	DEBUGFS_FWSTATS_ADD(tx, tx_start_null_frame);
+	DEBUGFS_FWSTATS_ADD(tx, tx_exch);
+	DEBUGFS_FWSTATS_ADD(tx, tx_retry_template);
+	DEBUGFS_FWSTATS_ADD(tx, tx_retry_data);
+	DEBUGFS_FWSTATS_ADD(tx, tx_retry_per_rate);
+	DEBUGFS_FWSTATS_ADD(tx, tx_exch_pending);
+	DEBUGFS_FWSTATS_ADD(tx, tx_exch_expiry);
+	DEBUGFS_FWSTATS_ADD(tx, tx_done_template);
+	DEBUGFS_FWSTATS_ADD(tx, tx_done_data);
+	DEBUGFS_FWSTATS_ADD(tx, tx_done_int_template);
+	DEBUGFS_FWSTATS_ADD(tx, tx_cfe1);
+	DEBUGFS_FWSTATS_ADD(tx, tx_cfe2);
+	DEBUGFS_FWSTATS_ADD(tx, frag_called);
+	DEBUGFS_FWSTATS_ADD(tx, frag_mpdu_alloc_failed);
+	DEBUGFS_FWSTATS_ADD(tx, frag_init_called);
+	DEBUGFS_FWSTATS_ADD(tx, frag_in_process_called);
+	DEBUGFS_FWSTATS_ADD(tx, frag_tkip_called);
+	DEBUGFS_FWSTATS_ADD(tx, frag_key_not_found);
+	DEBUGFS_FWSTATS_ADD(tx, frag_need_fragmentation);
+	DEBUGFS_FWSTATS_ADD(tx, frag_bad_mblk_num);
+	DEBUGFS_FWSTATS_ADD(tx, frag_failed);
+	DEBUGFS_FWSTATS_ADD(tx, frag_cache_hit);
+	DEBUGFS_FWSTATS_ADD(tx, frag_cache_miss);
+	DEBUGFS_FWSTATS_ADD(rx, rx_beacon_early_term);
+	DEBUGFS_FWSTATS_ADD(rx, rx_out_of_mpdu_nodes);
+	DEBUGFS_FWSTATS_ADD(rx, rx_hdr_overflow);
+	DEBUGFS_FWSTATS_ADD(rx, rx_dropped_frame);
+	DEBUGFS_FWSTATS_ADD(rx, rx_done);
+	DEBUGFS_FWSTATS_ADD(rx, rx_defrag);
+	DEBUGFS_FWSTATS_ADD(rx, rx_defrag_end);
+	DEBUGFS_FWSTATS_ADD(rx, rx_cmplt);
+	DEBUGFS_FWSTATS_ADD(rx, rx_pre_complt);
+	DEBUGFS_FWSTATS_ADD(rx, rx_cmplt_task);
+	DEBUGFS_FWSTATS_ADD(rx, rx_phy_hdr);
+	DEBUGFS_FWSTATS_ADD(rx, rx_timeout);
+	DEBUGFS_FWSTATS_ADD(rx, rx_rts_timeout);
+	DEBUGFS_FWSTATS_ADD(rx, rx_timeout_wa);
+	DEBUGFS_FWSTATS_ADD(rx, defrag_called);
+	DEBUGFS_FWSTATS_ADD(rx, defrag_init_called);
+	DEBUGFS_FWSTATS_ADD(rx, defrag_in_process_called);
+	DEBUGFS_FWSTATS_ADD(rx, defrag_tkip_called);
+	DEBUGFS_FWSTATS_ADD(rx, defrag_need_defrag);
+	DEBUGFS_FWSTATS_ADD(rx, defrag_decrypt_failed);
+	DEBUGFS_FWSTATS_ADD(rx, decrypt_key_not_found);
+	DEBUGFS_FWSTATS_ADD(rx, defrag_need_decrypt);
+	DEBUGFS_FWSTATS_ADD(rx, rx_tkip_replays);
+	DEBUGFS_FWSTATS_ADD(rx, rx_xfr);
+	DEBUGFS_FWSTATS_ADD(isr, irqs);
+	DEBUGFS_FWSTATS_ADD(pwr, missing_bcns_cnt);
+	DEBUGFS_FWSTATS_ADD(pwr, rcvd_bcns_cnt);
+	DEBUGFS_FWSTATS_ADD(pwr, connection_out_of_sync);
+	DEBUGFS_FWSTATS_ADD(pwr, cont_miss_bcns_spread);
+	DEBUGFS_FWSTATS_ADD(pwr, rcvd_awake_bcns_cnt);
+	DEBUGFS_FWSTATS_ADD(pwr, sleep_time_count);
+	DEBUGFS_FWSTATS_ADD(pwr, sleep_time_avg);
+	DEBUGFS_FWSTATS_ADD(pwr, sleep_cycle_avg);
+	DEBUGFS_FWSTATS_ADD(pwr, sleep_percent);
+	DEBUGFS_FWSTATS_ADD(pwr, ap_sleep_active_conf);
+	DEBUGFS_FWSTATS_ADD(pwr, ap_sleep_user_conf);
+	DEBUGFS_FWSTATS_ADD(pwr, ap_sleep_counter);
+	DEBUGFS_FWSTATS_ADD(rx_filter, beacon_filter);
+	DEBUGFS_FWSTATS_ADD(rx_filter, arp_filter);
+	DEBUGFS_FWSTATS_ADD(rx_filter, mc_filter);
+	DEBUGFS_FWSTATS_ADD(rx_filter, dup_filter);
+	DEBUGFS_FWSTATS_ADD(rx_filter, data_filter);
+	DEBUGFS_FWSTATS_ADD(rx_filter, ibss_filter);
+	DEBUGFS_FWSTATS_ADD(rx_filter, protection_filter);
+	DEBUGFS_FWSTATS_ADD(rx_filter, accum_arp_pend_requests);
+	DEBUGFS_FWSTATS_ADD(rx_filter, max_arp_queue_dep);
+	DEBUGFS_FWSTATS_ADD(rx_rate, rx_frames_per_rates);
+	DEBUGFS_FWSTATS_ADD(aggr_size, tx_agg_rate);
+	DEBUGFS_FWSTATS_ADD(aggr_size, tx_agg_len);
+	DEBUGFS_FWSTATS_ADD(aggr_size, rx_size);
+	DEBUGFS_FWSTATS_ADD(pipeline, hs_tx_stat_fifo_int);
+	DEBUGFS_FWSTATS_ADD(pipeline, enc_tx_stat_fifo_int);
+	DEBUGFS_FWSTATS_ADD(pipeline, enc_rx_stat_fifo_int);
+	DEBUGFS_FWSTATS_ADD(pipeline, rx_complete_stat_fifo_int);
+	DEBUGFS_FWSTATS_ADD(pipeline, pre_proc_swi);
+	DEBUGFS_FWSTATS_ADD(pipeline, post_proc_swi);
+	DEBUGFS_FWSTATS_ADD(pipeline, sec_frag_swi);
+	DEBUGFS_FWSTATS_ADD(pipeline, pre_to_defrag_swi);
+	DEBUGFS_FWSTATS_ADD(pipeline, defrag_to_rx_xfer_swi);
+	DEBUGFS_FWSTATS_ADD(pipeline, dec_packet_in);
+	DEBUGFS_FWSTATS_ADD(pipeline, dec_packet_in_fifo_full);
+	DEBUGFS_FWSTATS_ADD(pipeline, dec_packet_out);
+	DEBUGFS_FWSTATS_ADD(pipeline, pipeline_fifo_full);
+	DEBUGFS_FWSTATS_ADD(diversity, num_of_packets_per_ant);
+	DEBUGFS_FWSTATS_ADD(diversity, total_num_of_toggles);
+	DEBUGFS_FWSTATS_ADD(thermal, irq_thr_low);
+	DEBUGFS_FWSTATS_ADD(thermal, irq_thr_high);
+	DEBUGFS_FWSTATS_ADD(thermal, tx_stop);
+	DEBUGFS_FWSTATS_ADD(thermal, tx_resume);
+	DEBUGFS_FWSTATS_ADD(thermal, false_irq);
+	DEBUGFS_FWSTATS_ADD(thermal, adc_source_unexpected);
+	DEBUGFS_FWSTATS_ADD(calib, fail_count);
+	DEBUGFS_FWSTATS_ADD(calib, calib_count);
+	DEBUGFS_FWSTATS_ADD(roaming, rssi_level);
+	DEBUGFS_FWSTATS_ADD(dfs, num_of_radar_detections);
+
+	DEBUGFS_ADD(conf, moddir);
+	DEBUGFS_ADD(radar_detection, moddir);
+	cc33xx_debugfs_add_files_helper(moddir);
+	DEBUGFS_ADD(dynamic_fw_traces, moddir);
+
+	return 0;
+}
+
+void cc33xx_debugfs_reset(struct cc33xx *cc)
+{
+	if (!cc->stats.fw_stats)
+		return;
+
+	memset(cc->stats.fw_stats, 0, sizeof(struct cc33xx_acx_statistics));
+	cc->stats.retry_count = 0;
+	cc->stats.excessive_retries = 0;
+}
+
+int cc33xx_debugfs_init(struct cc33xx *cc)
+{
+	int ret;
+	struct dentry *rootdir;
+
+	rootdir = debugfs_create_dir(KBUILD_MODNAME, cc->hw->wiphy->debugfsdir);
+
+	cc->stats.fw_stats = kzalloc(sizeof(*cc->stats.fw_stats),
+				     GFP_KERNEL);
+	if (!cc->stats.fw_stats) {
+		ret = -ENOMEM;
+		goto out_remove;
+	}
+
+	cc->stats.fw_stats_update = jiffies;
+
+	ret = cc33xx_debugfs_add_files(cc, rootdir);
+	if (ret < 0)
+		goto out_exit;
+
+	goto out;
+
+out_exit:
+	cc33xx_debugfs_exit(cc);
+
+out_remove:
+	debugfs_remove_recursive(rootdir);
+
+out:
+	return ret;
+}
+
+void cc33xx_debugfs_exit(struct cc33xx *cc)
+{
+	kfree(cc->stats.fw_stats);
+	cc->stats.fw_stats = NULL;
+}
diff --git a/drivers/net/wireless/ti/cc33xx/debugfs.h b/drivers/net/wireless/ti/cc33xx/debugfs.h
new file mode 100644
index 000000000000..68b61fc3d553
--- /dev/null
+++ b/drivers/net/wireless/ti/cc33xx/debugfs.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+/* Copyright (C) 2022-2024 Texas Instruments Inc.*/
+
+#ifndef __DEBUGFS_H__
+#define __DEBUGFS_H__
+
+#include "cc33xx.h"
+
+__printf(4, 5) int cc33xx_format_buffer(char __user *userbuf, size_t count,
+					loff_t *ppos, char *fmt, ...);
+
+int cc33xx_debugfs_init(struct cc33xx *cc);
+void cc33xx_debugfs_exit(struct cc33xx *cc);
+void cc33xx_debugfs_reset(struct cc33xx *cc);
+void cc33xx_debugfs_update_stats(struct cc33xx *cc);
+
+#define DEBUGFS_FORMAT_BUFFER_SIZE 256
+
+#define DEBUGFS_READONLY_FILE(name, fmt, value...)			\
+static ssize_t name## _read(struct file *file, char __user *userbuf,	\
+			    size_t count, loff_t *ppos)			\
+{									\
+	struct cc33xx *cc = file->private_data;				\
+	return cc33xx_format_buffer(userbuf, count, ppos,		\
+				    fmt "\n", ##value);			\
+}									\
+									\
+static const struct file_operations name## _ops = {			\
+	.read = name## _read,						\
+	.open = simple_open,						\
+	.llseek	= generic_file_llseek,					\
+}
+
+#define DEBUGFS_ADD(name, parent)					\
+		debugfs_create_file(#name, 0400, parent,		\
+				    cc, &name## _ops)
+
+#define DEBUGFS_ADD_PREFIX(prefix, name, parent)			\
+		debugfs_create_file(#name, 0400, parent,		\
+				    cc, &prefix## _## name## _ops)
+
+#define DEBUGFS_FWSTATS_FILE(sub, name, fmt, struct_type)		\
+static ssize_t sub## _ ##name## _read(struct file *file,		\
+				      char __user *userbuf,		\
+				      size_t count, loff_t *ppos)	\
+{									\
+	struct cc33xx *cc = file->private_data;				\
+	struct struct_type *stats = cc->stats.fw_stats;			\
+									\
+	cc33xx_debugfs_update_stats(cc);				\
+									\
+	return cc33xx_format_buffer(userbuf, count, ppos, fmt "\n",	\
+				    stats->sub.name);			\
+}									\
+									\
+static const struct file_operations sub## _ ##name## _ops = {		\
+	.read = sub## _ ##name## _read,					\
+	.open = simple_open,						\
+	.llseek	= generic_file_llseek,					\
+}
+
+#define DEBUGFS_FWSTATS_FILE_ARRAY(sub, name, len, struct_type)		\
+static ssize_t sub## _ ##name## _read(struct file *file,		\
+				      char __user *userbuf,		\
+				      size_t count, loff_t *ppos)	\
+{									\
+	struct cc33xx *cc = file->private_data;				\
+	struct struct_type *stats = cc->stats.fw_stats;			\
+	char buf[DEBUGFS_FORMAT_BUFFER_SIZE] = "";			\
+	int res, i;							\
+									\
+	cc33xx_debugfs_update_stats(cc);				\
+									\
+	for (i = 0; i < (len); i++)					\
+		res = snprintf(buf, sizeof(buf), "%s[%d] = %d\n",	\
+			       buf, i, stats->sub.name[i]);		\
+									\
+	return cc33xx_format_buffer(userbuf, count, ppos, "%s", buf);	\
+}									\
+									\
+static const struct file_operations sub## _ ##name## _ops = {		\
+	.read = sub## _ ##name## _read,					\
+	.open = simple_open,						\
+	.llseek	= generic_file_llseek,					\
+}
+
+#define DEBUGFS_FWSTATS_ADD(sub, name)					\
+	DEBUGFS_ADD(sub## _ ##name, stats)
+
+#endif /* CC33XX_DEBUGFS_H */
-- 
2.25.1


