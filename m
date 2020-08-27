Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1879325518F
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Aug 2020 01:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgH0XaG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Aug 2020 19:30:06 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:45054 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgH0XaF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Aug 2020 19:30:05 -0400
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id CC66713C2B1;
        Thu, 27 Aug 2020 16:30:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com CC66713C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1598571004;
        bh=orCbqzM8OVysPY23eVEHY/Rh4hYSbry4pU60VoHdFe4=;
        h=From:To:Cc:Subject:Date:From;
        b=rbQV9JhR0N9o6e572iW5bU1mBs/TXOqKXEMhzWcHilZOOKx6fJk6UTZPEnDFQp94T
         Du/5tbZS9rL5qrlLU4Cu9XP72VUUO3FkOkT9JNYOVybG5mrISxPJlUrj4VAKFSFF03
         DacEGPwM3RBc3yqWHQUHpV3onEemnRmyC0cD0xSg=
From:   greearb@candelatech.com
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Ben Greear <greearb@candelatech.com>
Subject: [PATCH 1/2] ath11k:  Support reading fwcfg file for driver options.
Date:   Thu, 27 Aug 2020 16:30:01 -0700
Message-Id: <20200827233002.21483-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

The QCA6390 NIC that I have randomizes the last two octets
each time the module loads.  So, introduce a 'fwcfg' option
so that we can specify a MAC for each radio.  This fwcfg
file will also let one specify the board file name.

Example fwcfg file:

mac = 00:03:7f:00:00:01

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 161 ++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/core.h |   9 ++
 drivers/net/wireless/ath/ath11k/wmi.c  |  12 +-
 3 files changed, 178 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 55de538aa785..3166b9a9f896 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -7,6 +7,7 @@
 #include <linux/slab.h>
 #include <linux/remoteproc.h>
 #include <linux/firmware.h>
+#include <linux/ctype.h>
 #include "core.h"
 #include "dp_tx.h"
 #include "dp_rx.h"
@@ -233,6 +234,8 @@ static int ath11k_core_fetch_board_data_api_n(struct ath11k_base *ab,
 	int ret, ie_id;
 
 	filename = ATH11K_BOARD_API2_FILE;
+	if (ab->fwcfg.bname[0])
+		filename = ab->fwcfg.bname;
 
 	if (!bd->fw)
 		bd->fw = ath11k_core_firmware_request(ab, filename);
@@ -310,6 +313,7 @@ static int ath11k_core_fetch_board_data_api_n(struct ath11k_base *ab,
 		data += ie_len;
 	}
 
+	strlcpy(ab->fw_board_name, filename, sizeof(ab->fw_board_name));
 out:
 	if (!bd->data || !bd->len) {
 		ath11k_err(ab,
@@ -326,16 +330,160 @@ static int ath11k_core_fetch_board_data_api_n(struct ath11k_base *ab,
 	return ret;
 }
 
+static int ath11k_fetch_fwcfg_file(struct ath11k_base *ab)
+{
+	char filename[100];
+	const char *buf;
+	size_t i = 0;
+	char val[100];
+	size_t key_idx;
+	size_t val_idx;
+	char c;
+	size_t sz;
+	int ret;
+	const struct firmware *fw;
+
+	ab->fwcfg.flags = 0;
+
+	/* fwcfg-<bus>-<id>.txt */
+	/* If this changes, change ath11k_read_fwinfo as well. */
+	scnprintf(filename, sizeof(filename), "%s/fwcfg-%s-%s.txt",
+		  ATH11K_FW_DIR, ath11k_bus_str(ab->hif.bus), dev_name(ab->dev));
+
+	ret = firmware_request_nowarn(&fw, filename, ab->dev);
+	if (ret)
+		ab->fwcfg_file = ERR_PTR(ret);
+	else
+		ab->fwcfg_file = fw;
+	if (IS_ERR(ab->fwcfg_file)) {
+		/* FW config file is optional, don't be scary. */
+		ath11k_dbg(ab, ATH11K_DBG_BOOT,
+			   "Could not find firmware config file %s, continuing with defaults.\n",
+			   filename);
+		return PTR_ERR(ab->fwcfg_file);
+	}
+
+	ath11k_dbg(ab, ATH11K_DBG_BOOT, "found firmware config file %s\n",
+		   filename);
+
+	/* Now, attempt to parse results.
+	 * Format is key=value
+	 */
+	buf = (const char *)(ab->fwcfg_file->data);
+	while (i < ab->fwcfg_file->size) {
+start_again:
+		/* First, eat space, or entire line if we have # as first char */
+		c = buf[i];
+		while (isspace(c)) {
+			i++;
+			if (i >= ab->fwcfg_file->size)
+				goto done;
+			c = buf[i];
+		}
+		/* Eat comment ? */
+		if (c == '#') {
+			i++;
+			while (i < ab->fwcfg_file->size) {
+				c = buf[i];
+				i++;
+				if (c == '\n')
+					goto start_again;
+			}
+			/* Found no newline, must be done. */
+			goto done;
+		}
+
+		/* If here, we have start of token, store it in 'filename' to save space */
+		key_idx = 0;
+		while (i < ab->fwcfg_file->size) {
+			c = buf[i];
+			if (c == '=') {
+				i++;
+				c = buf[i];
+				/* Eat any space after the '=' sign. */
+				while (i < ab->fwcfg_file->size) {
+					if (!isspace(c))
+						break;
+					i++;
+					c = buf[i];
+				}
+				break;
+			}
+			if (isspace(c)) {
+				i++;
+				continue;
+			}
+			filename[key_idx] = c;
+			key_idx++;
+			if (key_idx >= sizeof(filename)) {
+				/* Too long, bail out. */
+				goto done;
+			}
+			i++;
+		}
+		filename[key_idx] = 0; /* null terminate */
+
+		/* We have found the key, now find the value */
+		val_idx = 0;
+		while (i < ab->fwcfg_file->size) {
+			c = buf[i];
+			if (isspace(c))
+				break;
+			val[val_idx] = c;
+			val_idx++;
+			if (val_idx >= sizeof(val)) {
+				/* Too long, bail out. */
+				goto done;
+			}
+			i++;
+		}
+		val[val_idx] = 0; /* null terminate value */
+
+		/* We have key and value now. */
+		ath11k_warn(ab, "fwcfg key: %s  val: %s\n",
+			    filename, val);
+
+		/* Assign key and values as appropriate */
+		if (strcasecmp(filename, "mac") == 0) {
+			if (!mac_pton(val, ab->fwcfg.mac))
+				ath11k_warn(ab, "Failed to parse fwcfg mac address: %s\n",
+					    val);
+			else
+				ab->fwcfg.flags |= ATH11K_FWCFG_MAC;
+		} else if (strcasecmp(filename, "bname") == 0) {
+			sz = sizeof(ab->fwcfg.bname);
+			strncpy(ab->fwcfg.bname, val, sz);
+			ab->fwcfg.bname[sz - 1] = 0; /* ensure null term */
+		} else {
+			ath11k_warn(ab, "Unknown fwcfg key name -:%s:-, val: %s\n",
+				    filename, val);
+		}
+	}
+done:
+	return 0;
+}
+
 static int ath11k_core_fetch_board_data_api_1(struct ath11k_base *ab,
 					      struct ath11k_board_data *bd)
 {
-	bd->fw = ath11k_core_firmware_request(ab, ATH11K_DEFAULT_BOARD_FILE);
+	if (ab->fwcfg.bname[0])
+		bd->fw = ath11k_core_firmware_request(ab, ab->fwcfg.bname);
+	else
+		bd->fw = ath11k_core_firmware_request(ab, ATH11K_DEFAULT_BOARD_FILE);
 	if (IS_ERR(bd->fw))
 		return PTR_ERR(bd->fw);
 
 	bd->data = bd->fw->data;
 	bd->len = bd->fw->size;
 
+	/* Save firmware board name so we can display it later. */
+	if (ab->fwcfg.bname[0])
+		strlcpy(ab->fw_board_name, ab->fwcfg.bname,
+			sizeof(ab->fw_board_name));
+	else
+		strlcpy(ab->fw_board_name, ATH11K_DEFAULT_BOARD_FILE,
+			sizeof(ab->fw_board_name));
+
 	return 0;
 }
 
@@ -483,6 +631,13 @@ static int ath11k_core_start(struct ath11k_base *ab,
 {
 	int ret;
 
+	/* Load optional firmware config from file system */
+	if (!IS_ERR(ab->fwcfg_file)) {
+		release_firmware(ab->fwcfg_file);
+		ab->fwcfg_file = NULL;
+	}
+	ath11k_fetch_fwcfg_file(ab);
+
 	ret = ath11k_qmi_firmware_start(ab, mode);
 	if (ret) {
 		ath11k_err(ab, "failed to attach wmi: %d\n", ret);
@@ -865,6 +1020,10 @@ void ath11k_core_deinit(struct ath11k_base *ab)
 	ath11k_hif_power_down(ab);
 	ath11k_mac_destroy(ab);
 	ath11k_core_soc_destroy(ab);
+
+	if (!IS_ERR(ab->fwcfg_file))
+		release_firmware(ab->fwcfg_file);
+	ab->fwcfg_file = NULL;
 }
 EXPORT_SYMBOL(ath11k_core_deinit);
 
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index ef1a934221f0..bb22b41fefaa 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -685,6 +685,15 @@ struct ath11k_base {
 
 	const struct firmware *cal_file;
 
+	const struct firmware *fwcfg_file;
+	char fw_board_name[100]; /* whatever board file we actually loaded */
+	struct {
+#define ATH11K_FWCFG_MAC            BIT(0)
+		u32 flags; /* let us know which fields have been set */
+		char bname[100]; /* board file name */
+		u8 mac[ETH_ALEN]; /* MAC address to use */
+	} fwcfg;
+
 	/* Below regd's are protected by ab->data_lock */
 	/* This is the regd set for every radio
 	 * by the firmware during initializatin
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 03b669de3300..95f2af6bbdcd 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -5562,11 +5562,17 @@ static int ath11k_wmi_tlv_rdy_parse(struct ath11k_base *ab, u16 tag, u16 len,
 		ab->wlan_init_status = fixed_param.ready_event_min.status;
 		rdy_parse->num_extra_mac_addr =
 			fixed_param.ready_event_min.num_extra_mac_addr;
-
-		ether_addr_copy(ab->mac_addr,
-				fixed_param.ready_event_min.mac_addr.addr);
+		if (ab->fwcfg.flags & ATH11K_FWCFG_MAC)
+			ether_addr_copy(ab->mac_addr, ab->fwcfg.mac);
+		else
+			ether_addr_copy(ab->mac_addr,
+					fixed_param.ready_event_min.mac_addr.addr);
 		ab->pktlog_defs_checksum = fixed_param.pktlog_defs_checksum;
 		ab->wmi_ready = true;
+		ath11k_warn(ab, "tag-ready-event, using mac: %pM  NIC reported: %pM extra-mac: %d  status: %d\n",
+			    ab->mac_addr,
+			    fixed_param.ready_event_min.mac_addr.addr,
+			    rdy_parse->num_extra_mac_addr, ab->wlan_init_status);
 		break;
 	case WMI_TAG_ARRAY_FIXED_STRUCT:
 		addr_list = (struct wmi_mac_addr *)ptr;
-- 
2.26.2

