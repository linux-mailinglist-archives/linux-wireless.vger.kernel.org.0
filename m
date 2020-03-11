Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8676D1813A7
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2020 09:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbgCKIrX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Mar 2020 04:47:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:55896 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728547AbgCKIrX (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Mar 2020 04:47:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 58F60AF72;
        Wed, 11 Mar 2020 08:47:19 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Stanislav Yakovlev <stas.yakovlev@gmail.com>
Subject: [PATCH 6/7] ipw2x00: Use scnprintf() for avoiding potential buffer overflow
Date:   Wed, 11 Mar 2020 09:47:12 +0100
Message-Id: <20200311084713.18220-7-tiwai@suse.de>
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

Cc: Stanislav Yakovlev <stas.yakovlev@gmail.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/net/wireless/intel/ipw2x00/ipw2100.c   | 16 ++++-----
 drivers/net/wireless/intel/ipw2x00/ipw2200.c   | 48 +++++++++++++-------------
 drivers/net/wireless/intel/ipw2x00/libipw_rx.c |  4 +--
 drivers/net/wireless/intel/ipw2x00/libipw_wx.c |  8 ++---
 4 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2100.c b/drivers/net/wireless/intel/ipw2x00/ipw2100.c
index 5dfcce77d094..97ea6e2035e6 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2100.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2100.c
@@ -629,30 +629,30 @@ static char *snprint_line(char *buf, size_t count,
 	int out, i, j, l;
 	char c;
 
-	out = snprintf(buf, count, "%08X", ofs);
+	out = scnprintf(buf, count, "%08X", ofs);
 
 	for (l = 0, i = 0; i < 2; i++) {
-		out += snprintf(buf + out, count - out, " ");
+		out += scnprintf(buf + out, count - out, " ");
 		for (j = 0; j < 8 && l < len; j++, l++)
-			out += snprintf(buf + out, count - out, "%02X ",
+			out += scnprintf(buf + out, count - out, "%02X ",
 					data[(i * 8 + j)]);
 		for (; j < 8; j++)
-			out += snprintf(buf + out, count - out, "   ");
+			out += scnprintf(buf + out, count - out, "   ");
 	}
 
-	out += snprintf(buf + out, count - out, " ");
+	out += scnprintf(buf + out, count - out, " ");
 	for (l = 0, i = 0; i < 2; i++) {
-		out += snprintf(buf + out, count - out, " ");
+		out += scnprintf(buf + out, count - out, " ");
 		for (j = 0; j < 8 && l < len; j++, l++) {
 			c = data[(i * 8 + j)];
 			if (!isascii(c) || !isprint(c))
 				c = '.';
 
-			out += snprintf(buf + out, count - out, "%c", c);
+			out += scnprintf(buf + out, count - out, "%c", c);
 		}
 
 		for (; j < 8; j++)
-			out += snprintf(buf + out, count - out, " ");
+			out += scnprintf(buf + out, count - out, " ");
 	}
 
 	return buf;
diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2200.c b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
index 5ef6f87a48ac..60b5e08dd6df 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2200.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
@@ -223,30 +223,30 @@ static int snprint_line(char *buf, size_t count,
 	int out, i, j, l;
 	char c;
 
-	out = snprintf(buf, count, "%08X", ofs);
+	out = scnprintf(buf, count, "%08X", ofs);
 
 	for (l = 0, i = 0; i < 2; i++) {
-		out += snprintf(buf + out, count - out, " ");
+		out += scnprintf(buf + out, count - out, " ");
 		for (j = 0; j < 8 && l < len; j++, l++)
-			out += snprintf(buf + out, count - out, "%02X ",
+			out += scnprintf(buf + out, count - out, "%02X ",
 					data[(i * 8 + j)]);
 		for (; j < 8; j++)
-			out += snprintf(buf + out, count - out, "   ");
+			out += scnprintf(buf + out, count - out, "   ");
 	}
 
-	out += snprintf(buf + out, count - out, " ");
+	out += scnprintf(buf + out, count - out, " ");
 	for (l = 0, i = 0; i < 2; i++) {
-		out += snprintf(buf + out, count - out, " ");
+		out += scnprintf(buf + out, count - out, " ");
 		for (j = 0; j < 8 && l < len; j++, l++) {
 			c = data[(i * 8 + j)];
 			if (!isascii(c) || !isprint(c))
 				c = '.';
 
-			out += snprintf(buf + out, count - out, "%c", c);
+			out += scnprintf(buf + out, count - out, "%c", c);
 		}
 
 		for (; j < 8; j++)
-			out += snprintf(buf + out, count - out, " ");
+			out += scnprintf(buf + out, count - out, " ");
 	}
 
 	return out;
@@ -1279,12 +1279,12 @@ static ssize_t show_event_log(struct device *d,
 	log_len = log_size / sizeof(*log);
 	ipw_capture_event_log(priv, log_len, log);
 
-	len += snprintf(buf + len, PAGE_SIZE - len, "%08X", log_len);
+	len += scnprintf(buf + len, PAGE_SIZE - len, "%08X", log_len);
 	for (i = 0; i < log_len; i++)
-		len += snprintf(buf + len, PAGE_SIZE - len,
+		len += scnprintf(buf + len, PAGE_SIZE - len,
 				"\n%08X%08X%08X",
 				log[i].time, log[i].event, log[i].data);
-	len += snprintf(buf + len, PAGE_SIZE - len, "\n");
+	len += scnprintf(buf + len, PAGE_SIZE - len, "\n");
 	kfree(log);
 	return len;
 }
@@ -1298,13 +1298,13 @@ static ssize_t show_error(struct device *d,
 	u32 len = 0, i;
 	if (!priv->error)
 		return 0;
-	len += snprintf(buf + len, PAGE_SIZE - len,
+	len += scnprintf(buf + len, PAGE_SIZE - len,
 			"%08lX%08X%08X%08X",
 			priv->error->jiffies,
 			priv->error->status,
 			priv->error->config, priv->error->elem_len);
 	for (i = 0; i < priv->error->elem_len; i++)
-		len += snprintf(buf + len, PAGE_SIZE - len,
+		len += scnprintf(buf + len, PAGE_SIZE - len,
 				"\n%08X%08X%08X%08X%08X%08X%08X",
 				priv->error->elem[i].time,
 				priv->error->elem[i].desc,
@@ -1314,15 +1314,15 @@ static ssize_t show_error(struct device *d,
 				priv->error->elem[i].link2,
 				priv->error->elem[i].data);
 
-	len += snprintf(buf + len, PAGE_SIZE - len,
+	len += scnprintf(buf + len, PAGE_SIZE - len,
 			"\n%08X", priv->error->log_len);
 	for (i = 0; i < priv->error->log_len; i++)
-		len += snprintf(buf + len, PAGE_SIZE - len,
+		len += scnprintf(buf + len, PAGE_SIZE - len,
 				"\n%08X%08X%08X",
 				priv->error->log[i].time,
 				priv->error->log[i].event,
 				priv->error->log[i].data);
-	len += snprintf(buf + len, PAGE_SIZE - len, "\n");
+	len += scnprintf(buf + len, PAGE_SIZE - len, "\n");
 	return len;
 }
 
@@ -1350,7 +1350,7 @@ static ssize_t show_cmd_log(struct device *d,
 	     (i != priv->cmdlog_pos) && (len < PAGE_SIZE);
 	     i = (i + 1) % priv->cmdlog_len) {
 		len +=
-		    snprintf(buf + len, PAGE_SIZE - len,
+		    scnprintf(buf + len, PAGE_SIZE - len,
 			     "\n%08lX%08X%08X%08X\n", priv->cmdlog[i].jiffies,
 			     priv->cmdlog[i].retcode, priv->cmdlog[i].cmd.cmd,
 			     priv->cmdlog[i].cmd.len);
@@ -1358,9 +1358,9 @@ static ssize_t show_cmd_log(struct device *d,
 		    snprintk_buf(buf + len, PAGE_SIZE - len,
 				 (u8 *) priv->cmdlog[i].cmd.param,
 				 priv->cmdlog[i].cmd.len);
-		len += snprintf(buf + len, PAGE_SIZE - len, "\n");
+		len += scnprintf(buf + len, PAGE_SIZE - len, "\n");
 	}
-	len += snprintf(buf + len, PAGE_SIZE - len, "\n");
+	len += scnprintf(buf + len, PAGE_SIZE - len, "\n");
 	return len;
 }
 
@@ -9608,24 +9608,24 @@ static int ipw_wx_get_powermode(struct net_device *dev,
 	int level = IPW_POWER_LEVEL(priv->power_mode);
 	char *p = extra;
 
-	p += snprintf(p, MAX_WX_STRING, "Power save level: %d ", level);
+	p += scnprintf(p, MAX_WX_STRING, "Power save level: %d ", level);
 
 	switch (level) {
 	case IPW_POWER_AC:
-		p += snprintf(p, MAX_WX_STRING - (p - extra), "(AC)");
+		p += scnprintf(p, MAX_WX_STRING - (p - extra), "(AC)");
 		break;
 	case IPW_POWER_BATTERY:
-		p += snprintf(p, MAX_WX_STRING - (p - extra), "(BATTERY)");
+		p += scnprintf(p, MAX_WX_STRING - (p - extra), "(BATTERY)");
 		break;
 	default:
-		p += snprintf(p, MAX_WX_STRING - (p - extra),
+		p += scnprintf(p, MAX_WX_STRING - (p - extra),
 			      "(Timeout %dms, Period %dms)",
 			      timeout_duration[level - 1] / 1000,
 			      period_duration[level - 1] / 1000);
 	}
 
 	if (!(priv->power_mode & IPW_POWER_ENABLED))
-		p += snprintf(p, MAX_WX_STRING - (p - extra), " OFF");
+		p += scnprintf(p, MAX_WX_STRING - (p - extra), " OFF");
 
 	wrqu->data.length = p - extra + 1;
 
diff --git a/drivers/net/wireless/intel/ipw2x00/libipw_rx.c b/drivers/net/wireless/intel/ipw2x00/libipw_rx.c
index 0cb36d1b983a..5a2a723e480b 100644
--- a/drivers/net/wireless/intel/ipw2x00/libipw_rx.c
+++ b/drivers/net/wireless/intel/ipw2x00/libipw_rx.c
@@ -1156,7 +1156,7 @@ static int libipw_parse_info_param(struct libipw_info_element
 			for (i = 0; i < network->rates_len; i++) {
 				network->rates[i] = info_element->data[i];
 #ifdef CONFIG_LIBIPW_DEBUG
-				p += snprintf(p, sizeof(rates_str) -
+				p += scnprintf(p, sizeof(rates_str) -
 					      (p - rates_str), "%02X ",
 					      network->rates[i]);
 #endif
@@ -1183,7 +1183,7 @@ static int libipw_parse_info_param(struct libipw_info_element
 			for (i = 0; i < network->rates_ex_len; i++) {
 				network->rates_ex[i] = info_element->data[i];
 #ifdef CONFIG_LIBIPW_DEBUG
-				p += snprintf(p, sizeof(rates_str) -
+				p += scnprintf(p, sizeof(rates_str) -
 					      (p - rates_str), "%02X ",
 					      network->rates_ex[i]);
 #endif
diff --git a/drivers/net/wireless/intel/ipw2x00/libipw_wx.c b/drivers/net/wireless/intel/ipw2x00/libipw_wx.c
index 3d558b47168b..a0cf78c418ac 100644
--- a/drivers/net/wireless/intel/ipw2x00/libipw_wx.c
+++ b/drivers/net/wireless/intel/ipw2x00/libipw_wx.c
@@ -213,7 +213,7 @@ static char *libipw_translate_scan(struct libipw_device *ieee,
 	 * for given network. */
 	iwe.cmd = IWEVCUSTOM;
 	p = custom;
-	p += snprintf(p, MAX_CUSTOM_LEN - (p - custom),
+	p += scnprintf(p, MAX_CUSTOM_LEN - (p - custom),
 		      " Last beacon: %ums ago",
 		      elapsed_jiffies_msecs(network->last_scanned));
 	iwe.u.data.length = p - custom;
@@ -223,18 +223,18 @@ static char *libipw_translate_scan(struct libipw_device *ieee,
 	/* Add spectrum management information */
 	iwe.cmd = -1;
 	p = custom;
-	p += snprintf(p, MAX_CUSTOM_LEN - (p - custom), " Channel flags: ");
+	p += scnprintf(p, MAX_CUSTOM_LEN - (p - custom), " Channel flags: ");
 
 	if (libipw_get_channel_flags(ieee, network->channel) &
 	    LIBIPW_CH_INVALID) {
 		iwe.cmd = IWEVCUSTOM;
-		p += snprintf(p, MAX_CUSTOM_LEN - (p - custom), "INVALID ");
+		p += scnprintf(p, MAX_CUSTOM_LEN - (p - custom), "INVALID ");
 	}
 
 	if (libipw_get_channel_flags(ieee, network->channel) &
 	    LIBIPW_CH_RADAR_DETECT) {
 		iwe.cmd = IWEVCUSTOM;
-		p += snprintf(p, MAX_CUSTOM_LEN - (p - custom), "DFS ");
+		p += scnprintf(p, MAX_CUSTOM_LEN - (p - custom), "DFS ");
 	}
 
 	if (iwe.cmd == IWEVCUSTOM) {
-- 
2.16.4

