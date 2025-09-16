Return-Path: <linux-wireless+bounces-27382-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F874B7DBA5
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2B8C460EFC
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 22:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C842E0415;
	Tue, 16 Sep 2025 22:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="HEo6qvGE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp2.infineon.com (smtp2.infineon.com [217.10.52.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C747230C620
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 22:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061512; cv=none; b=jl/0zNFDU3rO6mVKiKV0bz7p8Bdi5MAetH5MN7ccJaWt0WHMyjS6zw8jm6IPUaa1r93Ki7T//Nj6bk6+K/+cB02a+/efd2ntSngkkAvM0BN7DE7fpqHuEcdhKd5q9DS7v/68qiRmtf7vkm/vgMkkkrDuKQm+PXe+y3ri/dCxxRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061512; c=relaxed/simple;
	bh=cCfw8t7BMiaqGq9T2dpGRIKljpRqWKfuDObqwGvtwGs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sa9Vl/+TC7J8pJ96a7DZNV1ORc+p1Ap7R802kDuG4VcM7ZUkTpVVZy3qRBlWI29dEduthgZrjXa5WN4NZzZP8u7q8YCuLFHtILjaM+vLa2DnfK+OEuOaclcJvIgmt6g5idkAKB9rS0cCgQUD5eYtcsebHoHspY+sorQVD3dvl5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=HEo6qvGE; arc=none smtp.client-ip=217.10.52.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1758061509; x=1789597509;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cCfw8t7BMiaqGq9T2dpGRIKljpRqWKfuDObqwGvtwGs=;
  b=HEo6qvGEuWkywSvjTSYKDzv/bQ3aDCPPgNij2VHaH+2jJrqodQDvCuBg
   CpUA5AbZYNj5NrHXO/TL8V58q7ljYJDVtK/VRncp3/dqGXa8ufn7wpRWQ
   uPf1HzkB9mHGAukihOflr42POJNFoIlPFK3apCI6zKP/qDj4iDueOGJy0
   c=;
X-CSE-ConnectionGUID: nYkt4fPhTNaOAOctD/8wtg==
X-CSE-MsgGUID: cA+RvGHwQseoTteL+S9SHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="125093608"
X-IronPort-AV: E=Sophos;i="6.18,270,1751234400"; 
   d="scan'208";a="125093608"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE814.infineon.com) ([172.23.29.40])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:25:07 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE814.infineon.com
 (172.23.29.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 17 Sep
 2025 00:25:06 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 17 Sep 2025 00:25:03 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH wireless-next 27/57] wifi: inffmac: add firmware.c/h
Date: Wed, 17 Sep 2025 03:47:47 +0530
Message-ID: <20250916221821.4387-33-gokulkumar.sivakumar@infineon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916221821.4387-1-gokulkumar.sivakumar@infineon.com>
References: <20250916221821.4387-1-gokulkumar.sivakumar@infineon.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MUCSE819.infineon.com (172.23.29.45) To
 MUCSE827.infineon.com (172.23.29.20)

Driver implementation for handling various types of Device firmware files
like binaries, NVRAM, CLM BLOB.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 .../net/wireless/infineon/inffmac/firmware.c  | 983 ++++++++++++++++++
 .../net/wireless/infineon/inffmac/firmware.h  | 108 ++
 2 files changed, 1091 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/firmware.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/firmware.h

diff --git a/drivers/net/wireless/infineon/inffmac/firmware.c b/drivers/net/wireless/infineon/inffmac/firmware.c
new file mode 100644
index 000000000000..9ea05c1119d7
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/firmware.c
@@ -0,0 +1,983 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2013 Broadcom Corporation
+ *
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#include <linux/efi.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/device.h>
+#include <linux/firmware.h>
+#include <linux/module.h>
+#include <linux/bcm47xx_nvram.h>
+
+#include "debug.h"
+#include "firmware.h"
+#include "core.h"
+#include "common.h"
+#include "chip.h"
+
+#define INFF_FW_MAX_NVRAM_SIZE			64000
+#define INFF_FW_NVRAM_DEVPATH_LEN		19	/* devpath0=pcie/1/4/ */
+#define INFF_FW_NVRAM_PCIEDEV_LEN		20	/* pcie/1/4/ + \0 */
+#define INFF_FW_DEFAULT_BOARDREV		"boardrev=0xff"
+#define INFF_FW_MACADDR_FMT			"macaddr=%pM"
+#define INFF_FW_MACADDR_LEN			(7 + ETH_ALEN * 3)
+
+enum nvram_parser_state {
+	ST_IDLE,
+	ST_KEY,
+	ST_VALUE,
+	ST_COMMENT,
+	ST_END
+};
+
+/**
+ * struct nvram_parser - internal info for parser.
+ *
+ * @state: current parser state.
+ * @data: input buffer being parsed.
+ * @nvram: output buffer with parse result.
+ * @nvram_len: length of parse result.
+ * @line: current line.
+ * @column: current column in line.
+ * @pos: byte offset in input buffer.
+ * @entry: start position of key,value entry.
+ * @multi_dev_v1: detect pcie multi device v1 (compressed).
+ * @multi_dev_v2: detect pcie multi device v2.
+ * @boardrev_found: nvram contains boardrev information.
+ * @strip_mac: strip the MAC address.
+ */
+struct nvram_parser {
+	enum nvram_parser_state state;
+	const u8 *data;
+	u8 *nvram;
+	u32 nvram_len;
+	u32 line;
+	u32 column;
+	u32 pos;
+	u32 entry;
+	bool multi_dev_v1;
+	bool multi_dev_v2;
+	bool boardrev_found;
+	bool strip_mac;
+};
+
+/*
+ * is_nvram_char() - check if char is a valid one for NVRAM entry
+ *
+ * It accepts all printable ASCII chars except for '#' which opens a comment.
+ * Please note that ' ' (space) while accepted is not a valid key name char.
+ */
+static bool is_nvram_char(char c)
+{
+	/* comment marker excluded */
+	if (c == '#')
+		return false;
+
+	/* key and value may have any other readable character */
+	return (c >= 0x20 && c < 0x7f);
+}
+
+static bool is_whitespace(char c)
+{
+	return (c == ' ' || c == '\r' || c == '\n' || c == '\t');
+}
+
+static enum nvram_parser_state inff_nvram_handle_idle(struct nvram_parser *nvp)
+{
+	char c;
+
+	c = nvp->data[nvp->pos];
+	if (c == '\n')
+		return ST_COMMENT;
+	if (is_whitespace(c) || c == '\0')
+		goto proceed;
+	if (c == '#')
+		return ST_COMMENT;
+	if (is_nvram_char(c)) {
+		nvp->entry = nvp->pos;
+		return ST_KEY;
+	}
+	inff_dbg(INFO, "warning: ln=%d:col=%d: ignoring invalid character\n",
+		 nvp->line, nvp->column);
+proceed:
+	nvp->column++;
+	nvp->pos++;
+	return ST_IDLE;
+}
+
+static enum nvram_parser_state inff_nvram_handle_key(struct nvram_parser *nvp)
+{
+	enum nvram_parser_state st = nvp->state;
+	char c;
+
+	c = nvp->data[nvp->pos];
+	if (c == '=') {
+		/* ignore RAW1 by treating as comment */
+		if (strncmp(&nvp->data[nvp->entry], "RAW1", 4) == 0)
+			st = ST_COMMENT;
+		else
+			st = ST_VALUE;
+		if (strncmp(&nvp->data[nvp->entry], "devpath", 7) == 0)
+			nvp->multi_dev_v1 = true;
+		if (strncmp(&nvp->data[nvp->entry], "pcie/", 5) == 0)
+			nvp->multi_dev_v2 = true;
+		if (strncmp(&nvp->data[nvp->entry], "boardrev", 8) == 0)
+			nvp->boardrev_found = true;
+		/* strip macaddr if platform MAC overrides */
+		if (nvp->strip_mac &&
+		    strncmp(&nvp->data[nvp->entry], "macaddr", 7) == 0)
+			st = ST_COMMENT;
+	} else if (!is_nvram_char(c) || c == ' ') {
+		inff_dbg(INFO, "warning: ln=%d:col=%d: '=' expected, skip invalid key entry\n",
+			 nvp->line, nvp->column);
+		return ST_COMMENT;
+	}
+
+	nvp->column++;
+	nvp->pos++;
+	return st;
+}
+
+static enum nvram_parser_state
+inff_nvram_handle_value(struct nvram_parser *nvp)
+{
+	char c;
+	char *skv;
+	char *ekv;
+	u32 cplen;
+
+	c = nvp->data[nvp->pos];
+	if (!is_nvram_char(c)) {
+		/* key,value pair complete */
+		ekv = (u8 *)&nvp->data[nvp->pos];
+		skv = (u8 *)&nvp->data[nvp->entry];
+		cplen = ekv - skv;
+		if (nvp->nvram_len + cplen + 1 >= INFF_FW_MAX_NVRAM_SIZE)
+			return ST_END;
+		/* copy to output buffer */
+		memcpy(&nvp->nvram[nvp->nvram_len], skv, cplen);
+		nvp->nvram_len += cplen;
+		nvp->nvram[nvp->nvram_len] = '\0';
+		nvp->nvram_len++;
+		return ST_IDLE;
+	}
+	nvp->pos++;
+	nvp->column++;
+	return ST_VALUE;
+}
+
+static enum nvram_parser_state
+inff_nvram_handle_comment(struct nvram_parser *nvp)
+{
+	char *eoc, *sol;
+
+	sol = (char *)&nvp->data[nvp->pos];
+	eoc = strchr(sol, '\n');
+	if (!eoc) {
+		eoc = strchr(sol, '\0');
+		if (!eoc)
+			return ST_END;
+	}
+
+	/* eat all moving to next line */
+	nvp->line++;
+	nvp->column = 1;
+	nvp->pos += (eoc - sol) + 1;
+	return ST_IDLE;
+}
+
+static enum nvram_parser_state inff_nvram_handle_end(struct nvram_parser *nvp)
+{
+	/* final state */
+	return ST_END;
+}
+
+static enum nvram_parser_state
+(*nv_parser_states[])(struct nvram_parser *nvp) = {
+	inff_nvram_handle_idle,
+	inff_nvram_handle_key,
+	inff_nvram_handle_value,
+	inff_nvram_handle_comment,
+	inff_nvram_handle_end
+};
+
+static int inff_init_nvram_parser(struct nvram_parser *nvp,
+				  const u8 *data, size_t data_len)
+{
+	size_t size;
+
+	memset(nvp, 0, sizeof(*nvp));
+	nvp->data = data;
+	/* Limit size to MAX_NVRAM_SIZE, some files contain lot of comment */
+	if (data_len > INFF_FW_MAX_NVRAM_SIZE)
+		size = INFF_FW_MAX_NVRAM_SIZE;
+	else
+		size = data_len;
+	/* Add space for properties we may add */
+	size += strlen(INFF_FW_DEFAULT_BOARDREV) + 1;
+	size += INFF_FW_MACADDR_LEN + 1;
+	/* Alloc for extra 0 byte + roundup by 4 + length field */
+	size += 1 + 3 + sizeof(u32);
+	nvp->nvram = kzalloc(size, GFP_KERNEL);
+	if (!nvp->nvram)
+		return -ENOMEM;
+
+	nvp->line = 1;
+	nvp->column = 1;
+	return 0;
+}
+
+/* inff_fw_strip_multi_v1 :Some nvram files contain settings for multiple
+ * devices. Strip it down for one device, use domain_nr/bus_nr to determine
+ * which data is to be returned. v1 is the version where nvram is stored
+ * compressed and "devpath" maps to index for valid entries.
+ */
+static void inff_fw_strip_multi_v1(struct nvram_parser *nvp, u16 domain_nr,
+				   u16 bus_nr)
+{
+	/* Device path with a leading '=' key-value separator */
+	char pci_path[20];
+	size_t pci_len;
+	char pcie_path[20];
+	size_t pcie_len;
+
+	u32 i, j;
+	bool found;
+	u8 *nvram;
+	u8 id;
+
+	nvram = kzalloc(nvp->nvram_len + 1 + 3 + sizeof(u32), GFP_KERNEL);
+	if (!nvram)
+		goto fail;
+
+	/* min length: devpath0=pcie/1/4/ + 0:x=y */
+	if (nvp->nvram_len < INFF_FW_NVRAM_DEVPATH_LEN + 6)
+		goto fail;
+
+	/* First search for the devpathX and see if it is the configuration
+	 * for domain_nr/bus_nr. Search complete nvp
+	 */
+	snprintf(pci_path, sizeof(pci_path), "=pci/%d/%d", domain_nr,
+		 bus_nr);
+	pci_len = strlen(pci_path);
+	snprintf(pcie_path, sizeof(pcie_path), "=pcie/%d/%d", domain_nr,
+		 bus_nr);
+	pcie_len = strlen(pcie_path);
+	found = false;
+	i = 0;
+	while (i < nvp->nvram_len - INFF_FW_NVRAM_DEVPATH_LEN) {
+		/* Format: devpathX=pcie/Y/Z/
+		 * Y = domain_nr, Z = bus_nr, X = virtual ID
+		 */
+		if (strncmp(&nvp->nvram[i], "devpath", 7) == 0 &&
+		    (!strncmp(&nvp->nvram[i + 8], pci_path, pci_len) ||
+		     !strncmp(&nvp->nvram[i + 8], pcie_path, pcie_len))) {
+			id = nvp->nvram[i + 7] - '0';
+			found = true;
+			break;
+		}
+		while (nvp->nvram[i] != 0)
+			i++;
+		i++;
+	}
+	if (!found)
+		goto fail;
+
+	/* Now copy all valid entries, release old nvram and assign new one */
+	i = 0;
+	j = 0;
+	while (i < nvp->nvram_len) {
+		if ((nvp->nvram[i] - '0' == id) && (nvp->nvram[i + 1] == ':')) {
+			i += 2;
+			if (strncmp(&nvp->nvram[i], "boardrev", 8) == 0)
+				nvp->boardrev_found = true;
+			while (nvp->nvram[i] != 0) {
+				nvram[j] = nvp->nvram[i];
+				i++;
+				j++;
+			}
+			nvram[j] = 0;
+			j++;
+		}
+		while (nvp->nvram[i] != 0)
+			i++;
+		i++;
+	}
+	kfree(nvp->nvram);
+	nvp->nvram = nvram;
+	nvp->nvram_len = j;
+	return;
+
+fail:
+	kfree(nvram);
+	nvp->nvram_len = 0;
+}
+
+/* inff_fw_strip_multi_v2 :Some nvram files contain settings for multiple
+ * devices. Strip it down for one device, use domain_nr/bus_nr to determine
+ * which data is to be returned. v2 is the version where nvram is stored
+ * uncompressed, all relevant valid entries are identified by
+ * pcie/domain_nr/bus_nr:
+ */
+static void inff_fw_strip_multi_v2(struct nvram_parser *nvp, u16 domain_nr,
+				   u16 bus_nr)
+{
+	char prefix[INFF_FW_NVRAM_PCIEDEV_LEN];
+	size_t len;
+	u32 i, j;
+	u8 *nvram;
+
+	nvram = kzalloc(nvp->nvram_len + 1 + 3 + sizeof(u32), GFP_KERNEL);
+	if (!nvram) {
+		nvp->nvram_len = 0;
+		return;
+	}
+
+	/* Copy all valid entries, release old nvram and assign new one.
+	 * Valid entries are of type pcie/X/Y/ where X = domain_nr and
+	 * Y = bus_nr.
+	 */
+	snprintf(prefix, sizeof(prefix), "pcie/%d/%d/", domain_nr, bus_nr);
+	len = strlen(prefix);
+	i = 0;
+	j = 0;
+	while (i < nvp->nvram_len - len) {
+		if (strncmp(&nvp->nvram[i], prefix, len) == 0) {
+			i += len;
+			if (strncmp(&nvp->nvram[i], "boardrev", 8) == 0)
+				nvp->boardrev_found = true;
+			while (nvp->nvram[i] != 0) {
+				nvram[j] = nvp->nvram[i];
+				i++;
+				j++;
+			}
+			nvram[j] = 0;
+			j++;
+		}
+		while (nvp->nvram[i] != 0)
+			i++;
+		i++;
+	}
+	kfree(nvp->nvram);
+	nvp->nvram = nvram;
+	nvp->nvram_len = j;
+}
+
+static void inff_fw_add_defaults(struct nvram_parser *nvp)
+{
+	if (nvp->boardrev_found)
+		return;
+
+	memcpy(&nvp->nvram[nvp->nvram_len], &INFF_FW_DEFAULT_BOARDREV,
+	       strlen(INFF_FW_DEFAULT_BOARDREV));
+	nvp->nvram_len += strlen(INFF_FW_DEFAULT_BOARDREV);
+	nvp->nvram[nvp->nvram_len] = '\0';
+	nvp->nvram_len++;
+}
+
+static void inff_fw_add_macaddr(struct nvram_parser *nvp, u8 *mac)
+{
+	int len;
+
+	len = scnprintf(&nvp->nvram[nvp->nvram_len], INFF_FW_MACADDR_LEN + 1,
+			INFF_FW_MACADDR_FMT, mac);
+	WARN_ON(len != INFF_FW_MACADDR_LEN);
+	nvp->nvram_len += len + 1;
+}
+
+/* inff_nvram_strip :Takes a buffer of "<var>=<value>\n" lines read from a fil
+ * and ending in a NUL. Removes carriage returns, empty lines, comment lines,
+ * and converts newlines to NULs. Shortens buffer as needed and pads with NULs.
+ * End of buffer is completed with token identifying length of buffer.
+ */
+static void *inff_fw_nvram_strip(const u8 *data, size_t data_len,
+				 u32 *new_length, u16 domain_nr, u16 bus_nr,
+				 struct device *dev)
+{
+	struct nvram_parser nvp;
+	u32 pad;
+	u32 token;
+	__le32 token_le;
+	u8 mac[ETH_ALEN];
+
+	if (inff_init_nvram_parser(&nvp, data, data_len) < 0)
+		return NULL;
+
+	if (eth_platform_get_mac_address(dev, mac) == 0)
+		nvp.strip_mac = true;
+
+	while (nvp.pos < data_len) {
+		nvp.state = nv_parser_states[nvp.state](&nvp);
+		if (nvp.state == ST_END)
+			break;
+	}
+	if (nvp.multi_dev_v1) {
+		nvp.boardrev_found = false;
+		inff_fw_strip_multi_v1(&nvp, domain_nr, bus_nr);
+	} else if (nvp.multi_dev_v2) {
+		nvp.boardrev_found = false;
+		inff_fw_strip_multi_v2(&nvp, domain_nr, bus_nr);
+	}
+
+	if (nvp.nvram_len == 0) {
+		kfree(nvp.nvram);
+		return NULL;
+	}
+
+	inff_fw_add_defaults(&nvp);
+
+	if (nvp.strip_mac)
+		inff_fw_add_macaddr(&nvp, mac);
+
+	pad = nvp.nvram_len;
+	*new_length = roundup(nvp.nvram_len + 1, 4);
+	while (pad != *new_length) {
+		nvp.nvram[pad] = 0;
+		pad++;
+	}
+
+	token = *new_length / 4;
+	token = (~token << 16) | (token & 0x0000FFFF);
+	token_le = cpu_to_le32(token);
+
+	memcpy(&nvp.nvram[*new_length], &token_le, sizeof(token_le));
+	*new_length += sizeof(token_le);
+
+	return nvp.nvram;
+}
+
+void inff_fw_nvram_free(void *nvram)
+{
+	kfree(nvram);
+}
+
+struct inff_fw {
+	struct device *dev;
+	struct inff_fw_request *req;
+	u32 curpos;
+	unsigned int board_index;
+	void (*done)(struct device *dev, int err, struct inff_fw_request *req);
+};
+
+#ifdef CONFIG_EFI
+/* In some cases the EFI-var stored nvram contains "ccode=ALL" or "ccode=XV"
+ * to specify "worldwide" compatible settings, but these 2 ccode-s do not work
+ * properly. "ccode=ALL" causes channels 12 and 13 to not be available,
+ * "ccode=XV" causes all 5GHz channels to not be available. So we replace both
+ * with "ccode=X2" which allows channels 12+13 and 5Ghz channels in
+ * no-Initiate-Radiation mode. This means that we will never send on these
+ * channels without first having received valid wifi traffic on the channel.
+ */
+static void inff_fw_fix_efi_nvram_ccode(char *data, unsigned long data_len)
+{
+	char *ccode;
+
+	ccode = strnstr((char *)data, "ccode=ALL", data_len);
+	if (!ccode)
+		ccode = strnstr((char *)data, "ccode=XV\r", data_len);
+	if (!ccode)
+		return;
+
+	ccode[6] = 'X';
+	ccode[7] = '2';
+	ccode[8] = '\r';
+}
+
+static u8 *inff_fw_nvram_from_efi(size_t *data_len_ret)
+{
+	efi_guid_t guid = EFI_GUID(0x74b00bd9, 0x805a, 0x4d61, 0xb5, 0x1f,
+				   0x43, 0x26, 0x81, 0x23, 0xd1, 0x13);
+	unsigned long data_len = 0;
+	efi_status_t status;
+	u8 *data = NULL;
+
+	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE))
+		return NULL;
+
+	status = efi.get_variable(L"nvram", &guid, NULL, &data_len, NULL);
+	if (status != EFI_BUFFER_TOO_SMALL)
+		goto fail;
+
+	data = kmalloc(data_len, GFP_KERNEL);
+	if (!data)
+		goto fail;
+
+	status = efi.get_variable(L"nvram", &guid, NULL, &data_len, data);
+	if (status != EFI_SUCCESS)
+		goto fail;
+
+	inff_fw_fix_efi_nvram_ccode(data, data_len);
+	inff_info("Using nvram EFI variable\n");
+
+	*data_len_ret = data_len;
+	return data;
+fail:
+	kfree(data);
+	return NULL;
+}
+#else
+static inline u8 *inff_fw_nvram_from_efi(size_t *data_len) { return NULL; }
+#endif
+
+static void inff_fw_free_request(struct inff_fw_request *req)
+{
+	struct inff_fw_item *item;
+	int i;
+
+	for (i = 0, item = &req->items[0]; i < req->n_items; i++, item++) {
+		if (item->type == INFF_FW_TYPE_BINARY ||
+		    item->type == INFF_FW_TYPE_TRXS ||
+		    item->type == INFF_FW_TYPE_TRXSE)
+			release_firmware(item->binary);
+		else if (item->type == INFF_FW_TYPE_NVRAM)
+			inff_fw_nvram_free(item->nv_data.data);
+	}
+	kfree(req);
+}
+
+static int inff_fw_request_nvram_done(const struct firmware *fw, void *ctx)
+{
+	struct inff_fw *fwctx = ctx;
+	struct inff_fw_item *cur;
+	bool free_bcm47xx_nvram = false;
+	bool kfree_nvram = false;
+	u32 nvram_length = 0;
+	void *nvram = NULL;
+	u8 *data = NULL;
+	size_t data_len;
+
+	inff_dbg(TRACE, "enter: dev=%s\n", dev_name(fwctx->dev));
+
+	cur = &fwctx->req->items[fwctx->curpos];
+
+	if (fw && fw->data) {
+		data = (u8 *)fw->data;
+		data_len = fw->size;
+	} else {
+		data = inff_fw_nvram_from_efi(&data_len);
+		if (data)
+			kfree_nvram = true;
+		else if (!(cur->flags & INFF_FW_REQF_OPTIONAL))
+			goto fail;
+	}
+
+	if (data)
+		nvram = inff_fw_nvram_strip(data, data_len, &nvram_length,
+					    fwctx->req->domain_nr,
+					    fwctx->req->bus_nr,
+					    fwctx->dev);
+
+	if (free_bcm47xx_nvram)
+		bcm47xx_nvram_release_contents(data);
+	if (kfree_nvram)
+		kfree(data);
+
+	release_firmware(fw);
+	if (!nvram && !(cur->flags & INFF_FW_REQF_OPTIONAL))
+		goto fail;
+
+	inff_dbg(TRACE, "nvram %p len %d\n", nvram, nvram_length);
+	cur->nv_data.data = nvram;
+	cur->nv_data.len = nvram_length;
+	return 0;
+
+fail:
+	return -ENOENT;
+}
+
+static int inff_fw_complete_request(const struct firmware *fw,
+				    struct inff_fw *fwctx)
+{
+	struct inff_fw_item *cur = &fwctx->req->items[fwctx->curpos];
+	int ret = 0;
+
+	inff_dbg(TRACE, "firmware %s %sfound\n", cur->path, fw ? "" : "not ");
+
+	switch (cur->type) {
+	case INFF_FW_TYPE_NVRAM:
+		ret = inff_fw_request_nvram_done(fw, fwctx);
+		break;
+	case INFF_FW_TYPE_BINARY:
+	case INFF_FW_TYPE_TRXSE:
+	case INFF_FW_TYPE_TRXS:
+	case INFF_FW_TYPE_CLM:
+		if (fw)
+			cur->binary = fw;
+		else
+			ret = -ENOENT;
+		break;
+	default:
+		/* something fishy here so bail out early */
+		inff_err("unknown fw type: %d\n", cur->type);
+		release_firmware(fw);
+		ret = -EINVAL;
+	}
+
+	return (cur->flags & INFF_FW_REQF_OPTIONAL) ? 0 : ret;
+}
+
+static char *inff_alt_fw_path(const char *path, const char *board_type)
+{
+	char base[INFF_FW_NAME_LEN];
+	const char *suffix;
+	char *ret;
+
+	if (!board_type)
+		return NULL;
+
+	suffix = strrchr(path, '.');
+	if (!suffix || suffix == path)
+		return NULL;
+
+	/* strip extension at the end */
+	strscpy(base, path, INFF_FW_NAME_LEN);
+	base[suffix - path] = 0;
+
+	ret = kasprintf(GFP_KERNEL, "%s.%s%s", base, board_type, suffix);
+	if (!ret)
+		inff_err("out of memory allocating firmware path for '%s'\n",
+			 path);
+
+	inff_dbg(TRACE, "FW alt path: %s\n", ret);
+
+	return ret;
+}
+
+static int inff_fw_request_firmware(const struct firmware **fw,
+				    struct inff_fw *fwctx)
+{
+	struct inff_fw_item *cur = &fwctx->req->items[fwctx->curpos];
+	unsigned int i;
+	int ret;
+
+	/* Files can be board-specific, first try board-specific paths */
+	for (i = 0; i < ARRAY_SIZE(fwctx->req->board_types); i++) {
+		char *alt_path;
+
+		if (!fwctx->req->board_types[i])
+			goto fallback;
+		alt_path = inff_alt_fw_path(cur->path,
+					    fwctx->req->board_types[i]);
+		if (!alt_path)
+			goto fallback;
+
+		ret = request_firmware_direct(fw, alt_path, fwctx->dev);
+		kfree(alt_path);
+		if (ret)
+			inff_info("no board-specific nvram available (ret=%d), device will use %s\n",
+				  ret, cur->path);
+		else
+			return ret;
+	}
+
+fallback:
+	return request_firmware(fw, cur->path, fwctx->dev);
+}
+
+static void inff_fw_request_done(const struct firmware *fw, void *ctx)
+{
+	struct inff_fw *fwctx = ctx;
+	struct inff_fw_item *cur = &fwctx->req->items[fwctx->curpos];
+	char alt_path[INFF_FW_NAME_LEN];
+	int ret;
+
+	if (!fw && cur->type == INFF_FW_TYPE_TRXS) {
+		strscpy(alt_path, cur->path, INFF_FW_NAME_LEN);
+		/* strip 'se' from .trxse at the end */
+		//alt_path[strlen(alt_path) - ] = 0;
+		ret = request_firmware(&fw, alt_path, fwctx->dev);
+		if (!ret)
+			cur->path = alt_path;
+	}
+	if (!fw && cur->type == INFF_FW_TYPE_TRXSE) {
+		strscpy(alt_path, cur->path, INFF_FW_NAME_LEN);
+		/* strip 'se' from .trxse at the end */
+		alt_path[strlen(alt_path) - 2] = 0;
+		ret = request_firmware(&fw, alt_path, fwctx->dev);
+		if (!ret)
+			cur->path = alt_path;
+	}
+
+	ret = inff_fw_complete_request(fw, fwctx);
+
+	while (ret == 0 && ++fwctx->curpos < fwctx->req->n_items) {
+		inff_fw_request_firmware(&fw, fwctx);
+		ret = inff_fw_complete_request(fw, ctx);
+	}
+
+	if (ret) {
+		inff_fw_free_request(fwctx->req);
+		fwctx->req = NULL;
+	}
+	fwctx->done(fwctx->dev, ret, fwctx->req);
+	kfree(fwctx);
+}
+
+static void inff_fw_request_done_alt_path(const struct firmware *fw, void *ctx)
+{
+	struct inff_fw *fwctx = ctx;
+	struct inff_fw_item *first = &fwctx->req->items[0];
+	const char *board_type, *alt_path;
+	int ret = 0;
+
+	if (fw) {
+		inff_fw_request_done(fw, ctx);
+		return;
+	}
+
+	/* Try next board firmware */
+	if (fwctx->board_index < ARRAY_SIZE(fwctx->req->board_types)) {
+		board_type = fwctx->req->board_types[fwctx->board_index++];
+		if (!board_type)
+			goto fallback;
+		alt_path = inff_alt_fw_path(first->path, board_type);
+		if (!alt_path)
+			goto fallback;
+
+		if (!fw) {
+			ret = request_firmware_nowait(THIS_MODULE, true, alt_path,
+						      fwctx->dev, GFP_KERNEL, fwctx,
+						      inff_fw_request_done_alt_path);
+		}
+		kfree(alt_path);
+
+		if (ret < 0)
+			inff_fw_request_done(fw, ctx);
+		return;
+	}
+
+fallback:
+	/* Fall back to canonical path if board firmware not found */
+	ret = request_firmware_nowait(THIS_MODULE, true, first->path,
+				      fwctx->dev, GFP_KERNEL, fwctx,
+				      inff_fw_request_done);
+
+	if (ret < 0)
+		inff_fw_request_done(fw, ctx);
+}
+
+static bool inff_fw_request_is_valid(struct inff_fw_request *req)
+{
+	struct inff_fw_item *item;
+	int i;
+
+	if (!req->n_items)
+		return false;
+
+	for (i = 0, item = &req->items[0]; i < req->n_items; i++, item++) {
+		if (!item->path)
+			return false;
+	}
+	return true;
+}
+
+int inff_fw_get_firmware_sync(struct device *dev, struct inff_fw_request *req,
+			      void (*fw_cb)(struct device *dev, int err,
+					    struct inff_fw_request *req))
+{
+	struct inff_fw_item *first = &req->items[0];
+	struct inff_fw *fwctx;
+	char *alt_path = NULL;
+	const struct firmware *fw;
+	int ret = -ENOENT;
+
+	inff_dbg(TRACE, "enter: dev=%s\n", dev_name(dev));
+
+	if (!inff_fw_request_is_valid(req))
+		return -EINVAL;
+
+	if (req->n_items > 1)
+		return -EINVAL;
+
+	fwctx = kzalloc(sizeof(*fwctx), GFP_KERNEL);
+	if (!fwctx)
+		return -ENOMEM;
+
+	fwctx->dev = dev;
+	fwctx->req = req;
+	fwctx->done = fw_cb;
+
+	/* First try alternative board-specific path if any */
+	if (fwctx->req->board_types[0])
+		alt_path = inff_alt_fw_path(first->path,
+					    fwctx->req->board_types[0]);
+	if (alt_path) {
+		/* Do not fallback to user-mode helper if file does not exist */
+		ret = request_firmware_direct(&fw, alt_path, fwctx->dev);
+		kfree(alt_path);
+	}
+
+	if (ret == -ENOENT)
+		ret = request_firmware(&fw, first->path, fwctx->dev);
+
+	inff_fw_request_done(fw, fwctx);
+
+	return ret;
+}
+
+int inff_fw_get_firmwares(struct device *dev, struct inff_fw_request *req,
+			  void (*fw_cb)(struct device *dev, int err,
+					struct inff_fw_request *req))
+{
+	struct inff_fw_item *first = &req->items[0];
+	struct inff_fw *fwctx;
+	char *alt_path = NULL;
+	int ret;
+
+	inff_dbg(TRACE, "enter: dev=%s\n", dev_name(dev));
+	if (!fw_cb)
+		return -EINVAL;
+
+	if (!inff_fw_request_is_valid(req))
+		return -EINVAL;
+
+	fwctx = kzalloc(sizeof(*fwctx), GFP_KERNEL);
+	if (!fwctx)
+		return -ENOMEM;
+
+	fwctx->dev = dev;
+	fwctx->req = req;
+	fwctx->done = fw_cb;
+
+	/* First try alternative board-specific path if any */
+	if (fwctx->req->board_types[0])
+		alt_path = inff_alt_fw_path(first->path,
+					    fwctx->req->board_types[0]);
+	if (alt_path) {
+		fwctx->board_index++;
+		ret = request_firmware_nowait(THIS_MODULE, true, alt_path,
+					      fwctx->dev, GFP_KERNEL, fwctx,
+					      inff_fw_request_done_alt_path);
+		kfree(alt_path);
+	} else {
+		ret = request_firmware_nowait(THIS_MODULE, true, first->path,
+					      fwctx->dev, GFP_KERNEL, fwctx,
+					      inff_fw_request_done);
+	}
+	if (ret < 0)
+		inff_fw_request_done(NULL, fwctx);
+
+	return 0;
+}
+
+struct inff_fw_request *
+inff_fw_alloc_request(char mp_path[], u32 chip, u32 chiprev,
+		      const struct inff_firmware_mapping mapping_table[],
+		      u32 table_size, struct inff_fw_name *fwnames,
+		      u32 n_fwnames)
+{
+	struct inff_fw_request *fwreq;
+	char chipname[12];
+	size_t mp_path_len;
+	u32 i, j;
+	char end = '\0';
+
+	if (chiprev >= BITS_PER_TYPE(u32)) {
+		inff_err("Invalid chip revision %u\n", chiprev);
+		return NULL;
+	}
+
+	for (i = 0; i < table_size; i++) {
+		if (mapping_table[i].chipid == chip &&
+		    mapping_table[i].revmask & BIT(chiprev))
+			break;
+	}
+
+	inff_chip_name(chip, chiprev, chipname, sizeof(chipname));
+
+	if (i == table_size) {
+		inff_err("Unknown chip %s\n", chipname);
+		return NULL;
+	}
+
+	fwreq = kzalloc(struct_size(fwreq, items, n_fwnames), GFP_KERNEL);
+	if (!fwreq)
+		return NULL;
+
+	inff_info("using %s for chip %s\n",
+		  mapping_table[i].fw_base, chipname);
+
+	mp_path_len = strnlen(mp_path, INFF_FW_ALTPATH_LEN);
+	if (mp_path_len)
+		end = mp_path[mp_path_len - 1];
+
+	fwreq->n_items = n_fwnames;
+
+	for (j = 0; j < n_fwnames; j++) {
+		fwreq->items[j].path = fwnames[j].path;
+		fwnames[j].path[0] = '\0';
+		/* check if firmware path is provided by module parameter */
+		if (mp_path[0] != '\0') {
+			strscpy(fwnames[j].path, mp_path,
+				INFF_FW_NAME_LEN);
+
+			if (end != '/') {
+				strlcat(fwnames[j].path, "/",
+					INFF_FW_NAME_LEN);
+			}
+		}
+		strlcat(fwnames[j].path, mapping_table[i].fw_base,
+			INFF_FW_NAME_LEN);
+		strlcat(fwnames[j].path, fwnames[j].extension,
+			INFF_FW_NAME_LEN);
+		fwreq->items[j].path = fwnames[j].path;
+
+		if (!strncmp(fwnames[j].extension, ".trxse", 6)) {
+			fwreq->items[j].type = INFF_FW_TYPE_TRXSE;
+		} else if (!strncmp(fwnames[j].extension, ".trxs", 5)) {
+			fwreq->items[j].type = INFF_FW_TYPE_TRXS;
+		} else if (!strncmp(fwnames[j].extension, ".txt", 4)) {
+			fwreq->items[j].type = INFF_FW_TYPE_NVRAM;
+			fwreq->items[j].flags = INFF_FW_REQF_OPTIONAL;
+		} else if (!strncmp(fwnames[j].extension, ".clm_blob", 9)) {
+			fwreq->items[j].type = INFF_FW_TYPE_CLM;
+			fwreq->items[j].flags = INFF_FW_REQF_OPTIONAL;
+		}
+	}
+
+	return fwreq;
+}
+
+struct inff_fw_request *
+inff_prepare_fw_request(char mp_path[], struct inff_chip *ci,
+			const struct inff_firmware_mapping *name_map,
+			int map_size, const char *board_type)
+{
+	struct inff_fw_request *fwreq;
+	struct inff_fw_name fwnames[INFF_FW_BIN_MAX_TYPE];
+	struct inff_chip_specific *chip_spec = &ci->chip_spec;
+	struct inff_fw_dataset *fw_data = &chip_spec->fwdata[0];
+
+	if (fw_data[INFF_FW_CODE].fwnames.extension) {
+		fwnames[INFF_FW_CODE].extension = fw_data[INFF_FW_CODE].fwnames.extension;
+		fwnames[INFF_FW_CODE].path = fw_data[INFF_FW_CODE].fwnames.path;
+	} else {
+		inff_err("chip 0x%x uninitialized with fw code file extension\n",
+			 ci->chip);
+		return NULL;
+	}
+
+	if (fw_data[INFF_FW_NVRAM].fwnames.extension) {
+		fwnames[INFF_FW_NVRAM].extension = fw_data[INFF_FW_NVRAM].fwnames.extension;
+		fwnames[INFF_FW_NVRAM].path = fw_data[INFF_FW_NVRAM].fwnames.path;
+	}
+
+	if (fw_data[INFF_FW_CLM].fwnames.extension) {
+		fwnames[INFF_FW_CLM].extension = fw_data[INFF_FW_CLM].fwnames.extension;
+		fwnames[INFF_FW_CLM].path = fw_data[INFF_FW_CLM].fwnames.path;
+	}
+
+	fwreq = inff_fw_alloc_request(mp_path, ci->chip, ci->chiprev, name_map,
+				      map_size, fwnames, ARRAY_SIZE(fwnames));
+	if (!fwreq)
+		return NULL;
+
+	fwreq->board_types[0] = board_type;
+
+	return fwreq;
+}
diff --git a/drivers/net/wireless/infineon/inffmac/firmware.h b/drivers/net/wireless/infineon/inffmac/firmware.h
new file mode 100644
index 000000000000..444a463b8140
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/firmware.h
@@ -0,0 +1,108 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2013 Broadcom Corporation
+ *
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef INFF_FIRMWARE_H
+#define INFF_FIRMWARE_H
+
+#define INFF_FW_REQF_OPTIONAL		0x0001
+
+#define	INFF_FW_NAME_LEN		320
+
+#define INFF_FW_MAX_BOARD_TYPES	8
+
+#define INFF_FW_DEFAULT_PATH		"infineon/"
+
+/* forward declaration */
+struct inff_chip;
+
+/**
+ * struct inff_firmware_mapping - Used to map chipid/revmask to firmware
+ *	filename and nvram filename. Each bus type implementation should create
+ *	a table of firmware mappings (using the macros defined below).
+ *
+ * @chipid: ID of chip.
+ * @revmask: bitmask of revisions, e.g. 0x10 means rev 4 only, 0xf means rev 0-3
+ * @fw: name of the firmware file.
+ * @nvram: name of nvram file.
+ */
+struct inff_firmware_mapping {
+	u32 chipid;
+	u32 revmask;
+	const char *fw_base;
+};
+
+/* Firmware and Country Local Matrix files */
+#define INFF_FW_ENTRY(chipid, mask, name) \
+	{ chipid, mask, INFF_ ## name ## _FIRMWARE_BASENAME }
+
+void inff_fw_nvram_free(void *nvram);
+
+enum inff_fw_type {
+	INFF_FW_TYPE_BINARY,
+	INFF_FW_TYPE_NVRAM,
+	INFF_FW_TYPE_TRXSE,
+	INFF_FW_TYPE_TRXS,
+	INFF_FW_TYPE_CLM,
+};
+
+struct inff_fw_item {
+	const char *path;
+	enum inff_fw_type type;
+	u16 flags;
+	union {
+		const struct firmware *binary;
+		struct {
+			void *data;
+			u32 len;
+		} nv_data;
+	};
+};
+
+struct inff_fw_request {
+	u16 domain_nr;
+	u16 bus_nr;
+	u32 n_items;
+	const char *board_types[INFF_FW_MAX_BOARD_TYPES];
+	struct inff_fw_item items[] __counted_by(n_items);
+};
+
+struct inff_fw_name {
+	const char *extension;
+	char *path;
+};
+
+struct inff_fw_request *
+inff_fw_alloc_request(char mp_path[], u32 chip, u32 chiprev,
+		      const struct inff_firmware_mapping mapping_table[],
+		      u32 table_size, struct inff_fw_name *fwnames,
+		      u32 n_fwnames);
+
+/*
+ * Request firmware(s) asynchronously. When the asynchronous request
+ * fails it will not use the callback, but call device_release_driver()
+ * instead which will call the driver .remove() callback.
+ */
+int inff_fw_get_firmwares(struct device *dev, struct inff_fw_request *req,
+			  void (*fw_cb)(struct device *dev, int err,
+					struct inff_fw_request *req));
+
+/**
+ * Request single firmware synchronously.
+ * Callback is called on a valid request
+ * whether it succeeds or not.
+ */
+int inff_fw_get_firmware_sync(struct device *dev, struct inff_fw_request *req,
+			      void (*fw_cb)(struct device *dev, int err,
+					    struct inff_fw_request *req));
+
+struct inff_fw_request *
+inff_prepare_fw_request(char mp_path[], struct inff_chip *ci,
+			const struct inff_firmware_mapping *name_map,
+			int map_size, const char *board_type);
+
+#endif /* INFF_FIRMWARE_H */
-- 
2.25.1


