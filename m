Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAA431813A6
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2020 09:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgCKIrW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Mar 2020 04:47:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:55836 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728263AbgCKIrV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Mar 2020 04:47:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9D9B8AEC1;
        Wed, 11 Mar 2020 08:47:18 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Jiri Slaby <jirislaby@gmail.com>,
        Nick Kossifidis <mickflemm@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 2/7] ath5k: Use scnprintf() for avoiding potential buffer overflow
Date:   Wed, 11 Mar 2020 09:47:08 +0100
Message-Id: <20200311084713.18220-3-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200311084713.18220-1-tiwai@suse.de>
References: <20200311084713.18220-1-tiwai@suse.de>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since snprintf() returns the would-be-output size instead of the
actual output size, the succeeding calls may go beyond the given
buffer limit.  Fix it by replacing with scnprintf().

Cc: Jiri Slaby <jirislaby@gmail.com>
Cc: Nick Kossifidis <mickflemm@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/net/wireless/ath/ath5k/debug.c | 174 ++++++++++++++++-----------------
 1 file changed, 87 insertions(+), 87 deletions(-)

diff --git a/drivers/net/wireless/ath/ath5k/debug.c b/drivers/net/wireless/ath/ath5k/debug.c
index 94f70047d3fc..2eaba1ccab20 100644
--- a/drivers/net/wireless/ath/ath5k/debug.c
+++ b/drivers/net/wireless/ath/ath5k/debug.c
@@ -201,35 +201,35 @@ static ssize_t read_file_beacon(struct file *file, char __user *user_buf,
 	u64 tsf;
 
 	v = ath5k_hw_reg_read(ah, AR5K_BEACON);
-	len += snprintf(buf + len, sizeof(buf) - len,
+	len += scnprintf(buf + len, sizeof(buf) - len,
 		"%-24s0x%08x\tintval: %d\tTIM: 0x%x\n",
 		"AR5K_BEACON", v, v & AR5K_BEACON_PERIOD,
 		(v & AR5K_BEACON_TIM) >> AR5K_BEACON_TIM_S);
 
-	len += snprintf(buf + len, sizeof(buf) - len, "%-24s0x%08x\n",
+	len += scnprintf(buf + len, sizeof(buf) - len, "%-24s0x%08x\n",
 		"AR5K_LAST_TSTP", ath5k_hw_reg_read(ah, AR5K_LAST_TSTP));
 
-	len += snprintf(buf + len, sizeof(buf) - len, "%-24s0x%08x\n\n",
+	len += scnprintf(buf + len, sizeof(buf) - len, "%-24s0x%08x\n\n",
 		"AR5K_BEACON_CNT", ath5k_hw_reg_read(ah, AR5K_BEACON_CNT));
 
 	v = ath5k_hw_reg_read(ah, AR5K_TIMER0);
-	len += snprintf(buf + len, sizeof(buf) - len, "%-24s0x%08x\tTU: %08x\n",
+	len += scnprintf(buf + len, sizeof(buf) - len, "%-24s0x%08x\tTU: %08x\n",
 		"AR5K_TIMER0 (TBTT)", v, v);
 
 	v = ath5k_hw_reg_read(ah, AR5K_TIMER1);
-	len += snprintf(buf + len, sizeof(buf) - len, "%-24s0x%08x\tTU: %08x\n",
+	len += scnprintf(buf + len, sizeof(buf) - len, "%-24s0x%08x\tTU: %08x\n",
 		"AR5K_TIMER1 (DMA)", v, v >> 3);
 
 	v = ath5k_hw_reg_read(ah, AR5K_TIMER2);
-	len += snprintf(buf + len, sizeof(buf) - len, "%-24s0x%08x\tTU: %08x\n",
+	len += scnprintf(buf + len, sizeof(buf) - len, "%-24s0x%08x\tTU: %08x\n",
 		"AR5K_TIMER2 (SWBA)", v, v >> 3);
 
 	v = ath5k_hw_reg_read(ah, AR5K_TIMER3);
-	len += snprintf(buf + len, sizeof(buf) - len, "%-24s0x%08x\tTU: %08x\n",
+	len += scnprintf(buf + len, sizeof(buf) - len, "%-24s0x%08x\tTU: %08x\n",
 		"AR5K_TIMER3 (ATIM)", v, v);
 
 	tsf = ath5k_hw_get_tsf64(ah);
-	len += snprintf(buf + len, sizeof(buf) - len,
+	len += scnprintf(buf + len, sizeof(buf) - len,
 		"TSF\t\t0x%016llx\tTU: %08x\n",
 		(unsigned long long)tsf, TSF_TO_TU(tsf));
 
@@ -320,16 +320,16 @@ static ssize_t read_file_debug(struct file *file, char __user *user_buf,
 	unsigned int len = 0;
 	unsigned int i;
 
-	len += snprintf(buf + len, sizeof(buf) - len,
+	len += scnprintf(buf + len, sizeof(buf) - len,
 		"DEBUG LEVEL: 0x%08x\n\n", ah->debug.level);
 
 	for (i = 0; i < ARRAY_SIZE(dbg_info) - 1; i++) {
-		len += snprintf(buf + len, sizeof(buf) - len,
+		len += scnprintf(buf + len, sizeof(buf) - len,
 			"%10s %c 0x%08x - %s\n", dbg_info[i].name,
 			ah->debug.level & dbg_info[i].level ? '+' : ' ',
 			dbg_info[i].level, dbg_info[i].desc);
 	}
-	len += snprintf(buf + len, sizeof(buf) - len,
+	len += scnprintf(buf + len, sizeof(buf) - len,
 		"%10s %c 0x%08x - %s\n", dbg_info[i].name,
 		ah->debug.level == dbg_info[i].level ? '+' : ' ',
 		dbg_info[i].level, dbg_info[i].desc);
@@ -383,60 +383,60 @@ static ssize_t read_file_antenna(struct file *file, char __user *user_buf,
 	unsigned int i;
 	unsigned int v;
 
-	len += snprintf(buf + len, sizeof(buf) - len, "antenna mode\t%d\n",
+	len += scnprintf(buf + len, sizeof(buf) - len, "antenna mode\t%d\n",
 		ah->ah_ant_mode);
-	len += snprintf(buf + len, sizeof(buf) - len, "default antenna\t%d\n",
+	len += scnprintf(buf + len, sizeof(buf) - len, "default antenna\t%d\n",
 		ah->ah_def_ant);
-	len += snprintf(buf + len, sizeof(buf) - len, "tx antenna\t%d\n",
+	len += scnprintf(buf + len, sizeof(buf) - len, "tx antenna\t%d\n",
 		ah->ah_tx_ant);
 
-	len += snprintf(buf + len, sizeof(buf) - len, "\nANTENNA\t\tRX\tTX\n");
+	len += scnprintf(buf + len, sizeof(buf) - len, "\nANTENNA\t\tRX\tTX\n");
 	for (i = 1; i < ARRAY_SIZE(ah->stats.antenna_rx); i++) {
-		len += snprintf(buf + len, sizeof(buf) - len,
+		len += scnprintf(buf + len, sizeof(buf) - len,
 			"[antenna %d]\t%d\t%d\n",
 			i, ah->stats.antenna_rx[i], ah->stats.antenna_tx[i]);
 	}
-	len += snprintf(buf + len, sizeof(buf) - len, "[invalid]\t%d\t%d\n",
+	len += scnprintf(buf + len, sizeof(buf) - len, "[invalid]\t%d\t%d\n",
 			ah->stats.antenna_rx[0], ah->stats.antenna_tx[0]);
 
 	v = ath5k_hw_reg_read(ah, AR5K_DEFAULT_ANTENNA);
-	len += snprintf(buf + len, sizeof(buf) - len,
+	len += scnprintf(buf + len, sizeof(buf) - len,
 			"\nAR5K_DEFAULT_ANTENNA\t0x%08x\n", v);
 
 	v = ath5k_hw_reg_read(ah, AR5K_STA_ID1);
-	len += snprintf(buf + len, sizeof(buf) - len,
+	len += scnprintf(buf + len, sizeof(buf) - len,
 		"AR5K_STA_ID1_DEFAULT_ANTENNA\t%d\n",
 		(v & AR5K_STA_ID1_DEFAULT_ANTENNA) != 0);
-	len += snprintf(buf + len, sizeof(buf) - len,
+	len += scnprintf(buf + len, sizeof(buf) - len,
 		"AR5K_STA_ID1_DESC_ANTENNA\t%d\n",
 		(v & AR5K_STA_ID1_DESC_ANTENNA) != 0);
-	len += snprintf(buf + len, sizeof(buf) - len,
+	len += scnprintf(buf + len, sizeof(buf) - len,
 		"AR5K_STA_ID1_RTS_DEF_ANTENNA\t%d\n",
 		(v & AR5K_STA_ID1_RTS_DEF_ANTENNA) != 0);
-	len += snprintf(buf + len, sizeof(buf) - len,
+	len += scnprintf(buf + len, sizeof(buf) - len,
 		"AR5K_STA_ID1_SELFGEN_DEF_ANT\t%d\n",
 		(v & AR5K_STA_ID1_SELFGEN_DEF_ANT) != 0);
 
 	v = ath5k_hw_reg_read(ah, AR5K_PHY_AGCCTL);
-	len += snprintf(buf + len, sizeof(buf) - len,
+	len += scnprintf(buf + len, sizeof(buf) - len,
 		"\nAR5K_PHY_AGCCTL_OFDM_DIV_DIS\t%d\n",
 		(v & AR5K_PHY_AGCCTL_OFDM_DIV_DIS) != 0);
 
 	v = ath5k_hw_reg_read(ah, AR5K_PHY_RESTART);
-	len += snprintf(buf + len, sizeof(buf) - len,
+	len += scnprintf(buf + len, sizeof(buf) - len,
 		"AR5K_PHY_RESTART_DIV_GC\t\t%x\n",
 		(v & AR5K_PHY_RESTART_DIV_GC) >> AR5K_PHY_RESTART_DIV_GC_S);
 
 	v = ath5k_hw_reg_read(ah, AR5K_PHY_FAST_ANT_DIV);
-	len += snprintf(buf + len, sizeof(buf) - len,
+	len += scnprintf(buf + len, sizeof(buf) - len,
 		"AR5K_PHY_FAST_ANT_DIV_EN\t%d\n",
 		(v & AR5K_PHY_FAST_ANT_DIV_EN) != 0);
 
 	v = ath5k_hw_reg_read(ah, AR5K_PHY_ANT_SWITCH_TABLE_0);
-	len += snprintf(buf + len, sizeof(buf) - len,
+	len += scnprintf(buf + len, sizeof(buf) - len,
 			"\nAR5K_PHY_ANT_SWITCH_TABLE_0\t0x%08x\n", v);
 	v = ath5k_hw_reg_read(ah, AR5K_PHY_ANT_SWITCH_TABLE_1);
-	len += snprintf(buf + len, sizeof(buf) - len,
+	len += scnprintf(buf + len, sizeof(buf) - len,
 			"AR5K_PHY_ANT_SWITCH_TABLE_1\t0x%08x\n", v);
 
 	if (len > sizeof(buf))
@@ -495,36 +495,36 @@ static ssize_t read_file_misc(struct file *file, char __user *user_buf,
 	unsigned int len = 0;
 	u32 filt = ath5k_hw_get_rx_filter(ah);
 
-	len += snprintf(buf + len, sizeof(buf) - len, "bssid-mask: %pM\n",
+	len += scnprintf(buf + len, sizeof(buf) - len, "bssid-mask: %pM\n",
 			ah->bssidmask);
-	len += snprintf(buf + len, sizeof(buf) - len, "filter-flags: 0x%x ",
+	len += scnprintf(buf + len, sizeof(buf) - len, "filter-flags: 0x%x ",
 			filt);
 	if (filt & AR5K_RX_FILTER_UCAST)
-		len += snprintf(buf + len, sizeof(buf) - len, " UCAST");
+		len += scnprintf(buf + len, sizeof(buf) - len, " UCAST");
 	if (filt & AR5K_RX_FILTER_MCAST)
-		len += snprintf(buf + len, sizeof(buf) - len, " MCAST");
+		len += scnprintf(buf + len, sizeof(buf) - len, " MCAST");
 	if (filt & AR5K_RX_FILTER_BCAST)
-		len += snprintf(buf + len, sizeof(buf) - len, " BCAST");
+		len += scnprintf(buf + len, sizeof(buf) - len, " BCAST");
 	if (filt & AR5K_RX_FILTER_CONTROL)
-		len += snprintf(buf + len, sizeof(buf) - len, " CONTROL");
+		len += scnprintf(buf + len, sizeof(buf) - len, " CONTROL");
 	if (filt & AR5K_RX_FILTER_BEACON)
-		len += snprintf(buf + len, sizeof(buf) - len, " BEACON");
+		len += scnprintf(buf + len, sizeof(buf) - len, " BEACON");
 	if (filt & AR5K_RX_FILTER_PROM)
-		len += snprintf(buf + len, sizeof(buf) - len, " PROM");
+		len += scnprintf(buf + len, sizeof(buf) - len, " PROM");
 	if (filt & AR5K_RX_FILTER_XRPOLL)
-		len += snprintf(buf + len, sizeof(buf) - len, " XRPOLL");
+		len += scnprintf(buf + len, sizeof(buf) - len, " XRPOLL");
 	if (filt & AR5K_RX_FILTER_PROBEREQ)
-		len += snprintf(buf + len, sizeof(buf) - len, " PROBEREQ");
+		len += scnprintf(buf + len, sizeof(buf) - len, " PROBEREQ");
 	if (filt & AR5K_RX_FILTER_PHYERR_5212)
-		len += snprintf(buf + len, sizeof(buf) - len, " PHYERR-5212");
+		len += scnprintf(buf + len, sizeof(buf) - len, " PHYERR-5212");
 	if (filt & AR5K_RX_FILTER_RADARERR_5212)
-		len += snprintf(buf + len, sizeof(buf) - len, " RADARERR-5212");
+		len += scnprintf(buf + len, sizeof(buf) - len, " RADARERR-5212");
 	if (filt & AR5K_RX_FILTER_PHYERR_5211)
 		snprintf(buf + len, sizeof(buf) - len, " PHYERR-5211");
 	if (filt & AR5K_RX_FILTER_RADARERR_5211)
-		len += snprintf(buf + len, sizeof(buf) - len, " RADARERR-5211");
+		len += scnprintf(buf + len, sizeof(buf) - len, " RADARERR-5211");
 
-	len += snprintf(buf + len, sizeof(buf) - len, "\nopmode: %s (%d)\n",
+	len += scnprintf(buf + len, sizeof(buf) - len, "\nopmode: %s (%d)\n",
 			ath_opmode_to_string(ah->opmode), ah->opmode);
 
 	if (len > sizeof(buf))
@@ -551,65 +551,65 @@ static ssize_t read_file_frameerrors(struct file *file, char __user *user_buf,
 	unsigned int len = 0;
 	int i;
 
-	len += snprintf(buf + len, sizeof(buf) - len,
+	len += scnprintf(buf + len, sizeof(buf) - len,
 			"RX\n---------------------\n");
-	len += snprintf(buf + len, sizeof(buf) - len, "CRC\t%u\t(%u%%)\n",
+	len += scnprintf(buf + len, sizeof(buf) - len, "CRC\t%u\t(%u%%)\n",
 			st->rxerr_crc,
 			st->rx_all_count > 0 ?
 				st->rxerr_crc * 100 / st->rx_all_count : 0);
-	len += snprintf(buf + len, sizeof(buf) - len, "PHY\t%u\t(%u%%)\n",
+	len += scnprintf(buf + len, sizeof(buf) - len, "PHY\t%u\t(%u%%)\n",
 			st->rxerr_phy,
 			st->rx_all_count > 0 ?
 				st->rxerr_phy * 100 / st->rx_all_count : 0);
 	for (i = 0; i < 32; i++) {
 		if (st->rxerr_phy_code[i])
-			len += snprintf(buf + len, sizeof(buf) - len,
+			len += scnprintf(buf + len, sizeof(buf) - len,
 				" phy_err[%u]\t%u\n",
 				i, st->rxerr_phy_code[i]);
 	}
 
-	len += snprintf(buf + len, sizeof(buf) - len, "FIFO\t%u\t(%u%%)\n",
+	len += scnprintf(buf + len, sizeof(buf) - len, "FIFO\t%u\t(%u%%)\n",
 			st->rxerr_fifo,
 			st->rx_all_count > 0 ?
 				st->rxerr_fifo * 100 / st->rx_all_count : 0);
-	len += snprintf(buf + len, sizeof(buf) - len, "decrypt\t%u\t(%u%%)\n",
+	len += scnprintf(buf + len, sizeof(buf) - len, "decrypt\t%u\t(%u%%)\n",
 			st->rxerr_decrypt,
 			st->rx_all_count > 0 ?
 				st->rxerr_decrypt * 100 / st->rx_all_count : 0);
-	len += snprintf(buf + len, sizeof(buf) - len, "MIC\t%u\t(%u%%)\n",
+	len += scnprintf(buf + len, sizeof(buf) - len, "MIC\t%u\t(%u%%)\n",
 			st->rxerr_mic,
 			st->rx_all_count > 0 ?
 				st->rxerr_mic * 100 / st->rx_all_count : 0);
-	len += snprintf(buf + len, sizeof(buf) - len, "process\t%u\t(%u%%)\n",
+	len += scnprintf(buf + len, sizeof(buf) - len, "process\t%u\t(%u%%)\n",
 			st->rxerr_proc,
 			st->rx_all_count > 0 ?
 				st->rxerr_proc * 100 / st->rx_all_count : 0);
-	len += snprintf(buf + len, sizeof(buf) - len, "jumbo\t%u\t(%u%%)\n",
+	len += scnprintf(buf + len, sizeof(buf) - len, "jumbo\t%u\t(%u%%)\n",
 			st->rxerr_jumbo,
 			st->rx_all_count > 0 ?
 				st->rxerr_jumbo * 100 / st->rx_all_count : 0);
-	len += snprintf(buf + len, sizeof(buf) - len, "[RX all\t%u]\n",
+	len += scnprintf(buf + len, sizeof(buf) - len, "[RX all\t%u]\n",
 			st->rx_all_count);
-	len += snprintf(buf + len, sizeof(buf) - len, "RX-all-bytes\t%u\n",
+	len += scnprintf(buf + len, sizeof(buf) - len, "RX-all-bytes\t%u\n",
 			st->rx_bytes_count);
 
-	len += snprintf(buf + len, sizeof(buf) - len,
+	len += scnprintf(buf + len, sizeof(buf) - len,
 			"\nTX\n---------------------\n");
-	len += snprintf(buf + len, sizeof(buf) - len, "retry\t%u\t(%u%%)\n",
+	len += scnprintf(buf + len, sizeof(buf) - len, "retry\t%u\t(%u%%)\n",
 			st->txerr_retry,
 			st->tx_all_count > 0 ?
 				st->txerr_retry * 100 / st->tx_all_count : 0);
-	len += snprintf(buf + len, sizeof(buf) - len, "FIFO\t%u\t(%u%%)\n",
+	len += scnprintf(buf + len, sizeof(buf) - len, "FIFO\t%u\t(%u%%)\n",
 			st->txerr_fifo,
 			st->tx_all_count > 0 ?
 				st->txerr_fifo * 100 / st->tx_all_count : 0);
-	len += snprintf(buf + len, sizeof(buf) - len, "filter\t%u\t(%u%%)\n",
+	len += scnprintf(buf + len, sizeof(buf) - len, "filter\t%u\t(%u%%)\n",
 			st->txerr_filt,
 			st->tx_all_count > 0 ?
 				st->txerr_filt * 100 / st->tx_all_count : 0);
-	len += snprintf(buf + len, sizeof(buf) - len, "[TX all\t%u]\n",
+	len += scnprintf(buf + len, sizeof(buf) - len, "[TX all\t%u]\n",
 			st->tx_all_count);
-	len += snprintf(buf + len, sizeof(buf) - len, "TX-all-bytes\t%u\n",
+	len += scnprintf(buf + len, sizeof(buf) - len, "TX-all-bytes\t%u\n",
 			st->tx_bytes_count);
 
 	if (len > sizeof(buf))
@@ -670,56 +670,56 @@ static ssize_t read_file_ani(struct file *file, char __user *user_buf,
 	char buf[700];
 	unsigned int len = 0;
 
-	len += snprintf(buf + len, sizeof(buf) - len,
+	len += scnprintf(buf + len, sizeof(buf) - len,
 			"HW has PHY error counters:\t%s\n",
 			ah->ah_capabilities.cap_has_phyerr_counters ?
 			"yes" : "no");
-	len += snprintf(buf + len, sizeof(buf) - len,
+	len += scnprintf(buf + len, sizeof(buf) - len,
 			"HW max spur immunity level:\t%d\n",
 			as->max_spur_level);
-	len += snprintf(buf + len, sizeof(buf) - len,
+	len += scnprintf(buf + len, sizeof(buf) - len,
 		"\nANI state\n--------------------------------------------\n");
-	len += snprintf(buf + len, sizeof(buf) - len, "operating mode:\t\t\t");
+	len += scnprintf(buf + len, sizeof(buf) - len, "operating mode:\t\t\t");
 	switch (as->ani_mode) {
 	case ATH5K_ANI_MODE_OFF:
-		len += snprintf(buf + len, sizeof(buf) - len, "OFF\n");
+		len += scnprintf(buf + len, sizeof(buf) - len, "OFF\n");
 		break;
 	case ATH5K_ANI_MODE_MANUAL_LOW:
-		len += snprintf(buf + len, sizeof(buf) - len,
+		len += scnprintf(buf + len, sizeof(buf) - len,
 			"MANUAL LOW\n");
 		break;
 	case ATH5K_ANI_MODE_MANUAL_HIGH:
-		len += snprintf(buf + len, sizeof(buf) - len,
+		len += scnprintf(buf + len, sizeof(buf) - len,
 			"MANUAL HIGH\n");
 		break;
 	case ATH5K_ANI_MODE_AUTO:
-		len += snprintf(buf + len, sizeof(buf) - len, "AUTO\n");
+		len += scnprintf(buf + len, sizeof(buf) - len, "AUTO\n");
 		break;
 	default:
-		len += snprintf(buf + len, sizeof(buf) - len,
+		len += scnprintf(buf + len, sizeof(buf) - len,
 			"??? (not good)\n");
 		break;
 	}
-	len += snprintf(buf + len, sizeof(buf) - len,
+	len += scnprintf(buf + len, sizeof(buf) - len,
 			"noise immunity level:\t\t%d\n",
 			as->noise_imm_level);
-	len += snprintf(buf + len, sizeof(buf) - len,
+	len += scnprintf(buf + len, sizeof(buf) - len,
 			"spur immunity level:\t\t%d\n",
 			as->spur_level);
-	len += snprintf(buf + len, sizeof(buf) - len,
+	len += scnprintf(buf + len, sizeof(buf) - len,
 			"firstep level:\t\t\t%d\n",
 			as->firstep_level);
-	len += snprintf(buf + len, sizeof(buf) - len,
+	len += scnprintf(buf + len, sizeof(buf) - len,
 			"OFDM weak signal detection:\t%s\n",
 			as->ofdm_weak_sig ? "on" : "off");
-	len += snprintf(buf + len, sizeof(buf) - len,
+	len += scnprintf(buf + len, sizeof(buf) - len,
 			"CCK weak signal detection:\t%s\n",
 			as->cck_weak_sig ? "on" : "off");
 
-	len += snprintf(buf + len, sizeof(buf) - len,
+	len += scnprintf(buf + len, sizeof(buf) - len,
 			"\nMIB INTERRUPTS:\t\t%u\n",
 			st->mib_intr);
-	len += snprintf(buf + len, sizeof(buf) - len,
+	len += scnprintf(buf + len, sizeof(buf) - len,
 			"beacon RSSI average:\t%d\n",
 			(int)ewma_beacon_rssi_read(&ah->ah_beacon_rssi_avg));
 
@@ -728,35 +728,35 @@ static ssize_t read_file_ani(struct file *file, char __user *user_buf,
 	_struct.cycles > 0 ? \
 	_struct._field * 100 / _struct.cycles : 0
 
-	len += snprintf(buf + len, sizeof(buf) - len,
+	len += scnprintf(buf + len, sizeof(buf) - len,
 			"profcnt tx\t\t%u\t(%d%%)\n",
 			CC_PRINT(as->last_cc, tx_frame));
-	len += snprintf(buf + len, sizeof(buf) - len,
+	len += scnprintf(buf + len, sizeof(buf) - len,
 			"profcnt rx\t\t%u\t(%d%%)\n",
 			CC_PRINT(as->last_cc, rx_frame));
-	len += snprintf(buf + len, sizeof(buf) - len,
+	len += scnprintf(buf + len, sizeof(buf) - len,
 			"profcnt busy\t\t%u\t(%d%%)\n",
 			CC_PRINT(as->last_cc, rx_busy));
 #undef CC_PRINT
-	len += snprintf(buf + len, sizeof(buf) - len, "profcnt cycles\t\t%u\n",
+	len += scnprintf(buf + len, sizeof(buf) - len, "profcnt cycles\t\t%u\n",
 			as->last_cc.cycles);
-	len += snprintf(buf + len, sizeof(buf) - len,
+	len += scnprintf(buf + len, sizeof(buf) - len,
 			"listen time\t\t%d\tlast: %d\n",
 			as->listen_time, as->last_listen);
-	len += snprintf(buf + len, sizeof(buf) - len,
+	len += scnprintf(buf + len, sizeof(buf) - len,
 			"OFDM errors\t\t%u\tlast: %u\tsum: %u\n",
 			as->ofdm_errors, as->last_ofdm_errors,
 			as->sum_ofdm_errors);
-	len += snprintf(buf + len, sizeof(buf) - len,
+	len += scnprintf(buf + len, sizeof(buf) - len,
 			"CCK errors\t\t%u\tlast: %u\tsum: %u\n",
 			as->cck_errors, as->last_cck_errors,
 			as->sum_cck_errors);
-	len += snprintf(buf + len, sizeof(buf) - len,
+	len += scnprintf(buf + len, sizeof(buf) - len,
 			"AR5K_PHYERR_CNT1\t%x\t(=%d)\n",
 			ath5k_hw_reg_read(ah, AR5K_PHYERR_CNT1),
 			ATH5K_ANI_OFDM_TRIG_HIGH - (ATH5K_PHYERR_CNT_MAX -
 			ath5k_hw_reg_read(ah, AR5K_PHYERR_CNT1)));
-	len += snprintf(buf + len, sizeof(buf) - len,
+	len += scnprintf(buf + len, sizeof(buf) - len,
 			"AR5K_PHYERR_CNT2\t%x\t(=%d)\n",
 			ath5k_hw_reg_read(ah, AR5K_PHYERR_CNT2),
 			ATH5K_ANI_CCK_TRIG_HIGH - (ATH5K_PHYERR_CNT_MAX -
@@ -836,13 +836,13 @@ static ssize_t read_file_queue(struct file *file, char __user *user_buf,
 	struct ath5k_buf *bf, *bf0;
 	int i, n;
 
-	len += snprintf(buf + len, sizeof(buf) - len,
+	len += scnprintf(buf + len, sizeof(buf) - len,
 			"available txbuffers: %d\n", ah->txbuf_len);
 
 	for (i = 0; i < ARRAY_SIZE(ah->txqs); i++) {
 		txq = &ah->txqs[i];
 
-		len += snprintf(buf + len, sizeof(buf) - len,
+		len += scnprintf(buf + len, sizeof(buf) - len,
 			"%02d: %ssetup\n", i, txq->setup ? "" : "not ");
 
 		if (!txq->setup)
@@ -854,9 +854,9 @@ static ssize_t read_file_queue(struct file *file, char __user *user_buf,
 			n++;
 		spin_unlock_bh(&txq->lock);
 
-		len += snprintf(buf + len, sizeof(buf) - len,
+		len += scnprintf(buf + len, sizeof(buf) - len,
 				"  len: %d bufs: %d\n", txq->txq_len, n);
-		len += snprintf(buf + len, sizeof(buf) - len,
+		len += scnprintf(buf + len, sizeof(buf) - len,
 				"  stuck: %d\n", txq->txq_stuck);
 	}
 
-- 
2.16.4

