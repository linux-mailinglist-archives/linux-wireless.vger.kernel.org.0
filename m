Return-Path: <linux-wireless+bounces-32249-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKsSOvAZoWlhqQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32249-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:13:36 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5004E1B289B
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 22B5D30622BE
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 04:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F1B341AB1;
	Fri, 27 Feb 2026 04:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="2WwZsf1q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11662345CB2
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 04:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772165567; cv=none; b=OrSOuw5tb/Fmssexg3YyYfaBPIztAdL4fuR0lRQkL3mtscR3G4eb5o40DTm/qCe/cYFZrEzSy3GAxj/UR8K+yIyfflBKxLO960qBbLWejs4BtJ+8aFZgAk12KpNdyuqe50eMblDU2j047IEL6zSwShvoBp9TMw6mcD8iaNc05GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772165567; c=relaxed/simple;
	bh=SVQBPn6DQzxSEuHRKgwRqMhg0vyE6Lv9d2v2kwxtbHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hH9PbP27DoMvanmuJw1aAwQRCpzidPeytaC6230RK1xkoqSAqiBFCigVDsQ0tXTDNgTj5tNHfzbX8TWr8wbftNlIcvpdmF5CPrqfqbijFiARgrWAKA6FOCp+MN1/tlRS0pYtgYUVd/+N9tp9iKMojsXeBTQ/7nuG28cSAc/D5/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=2WwZsf1q; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c70bb8ffb24so619955a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 20:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1772165565; x=1772770365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zUoo2b1I5ue/n++f7Rqxo7PVmXlT7y9IKhV0b0rYvvw=;
        b=2WwZsf1qzR8MUGupJGGRpB1Hj0oIGwugaNlDmtsznyc/2yPs2jAM8edA3jY1PQLbl0
         Q/DTD30PTo+WqLc3m0cH0l77BI9eY9ITczRRGCSwnRnZuFl0HIsxrMwQVppcG4J4VoN1
         e2vn7Si1gB+JC5YpAy/7OYogMvdAwoaWYFtd5QVBBAINdcTOodlWQZn9NjnfL8TN4Dbw
         raMID32esKXzaXnnHI8HBwCTFK4nJENBwM1yXcgxPOQZkvtWa3HqY4Stdyo90CNfsqqp
         BJ7A37NLIJpA2hWC/UzxdOJ/eq1ZBav1tfceZNZfHvtJNA6OMx9jHRTAIRaxKellB/h6
         XLJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772165565; x=1772770365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zUoo2b1I5ue/n++f7Rqxo7PVmXlT7y9IKhV0b0rYvvw=;
        b=s76FFWCYV3p3mJa+d8lkf0f1ZMb+YTWiC3Jd3NxvUkgFm5a35ibMA3UkNwkF3/w5u9
         saw+1vAuh+46CrE3lIYc4ytFptEe50fRYNuZpTZUvxxDRQ9mMwxZEq/KHFNCqeJP5p28
         oxgY8I6Q/dEhCW/Ln94xxl5OiCG3IVvUm968lrYEjAr2pdbOTFzYrpnmVv7nBvd5Hc1M
         jMVaUtx4Z/RzS+pXoDkoJJ373AVnu6AoZAGCzsXHFsyXzDeaQ5zR0EuG15xXAukGuiv1
         nSIa/oM8esJDsuvlQ5lMrvXP/iP6uEjV5V13mdFtt1jHCitNw1NtmjMN0BEwQIIDSbAt
         C37Q==
X-Forwarded-Encrypted: i=1; AJvYcCXmzdEbAeBxM6G51WSbmc+ZMP3+dYOqax7WroTn1PLyBQ/Gh4DK85tPcV3XzzXxvNDzFITg9o9+XkQDExqNTg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKyz3R8a29VSMeBCsDDmtzq/wEaYmBolD4SJtUk6xo5yLGuV1p
	60yzHtieWd6/GFxfR4czg76SAHlWHM3qnqB9wUjdo47VfggYTz3QtSr8I26KzG3e6fE=
X-Gm-Gg: ATEYQzygyZ5xXI41Gzx8clvdMhff8zw7nrijXTwL1YgOx59Aw4p8qKKrGPxjr6JFPqh
	4VmUPUvK69Z1KS9GfOlWlALADXppXDY0U7qtP2a+vfILoacBltlBUCzt05K1Blg+BaMVi6a8Sfg
	dAzbsEGMML8a0i6w8p3EOPYMhcI91ltF5hv+fpj9nsv8ytbLV6IvNaya7XR5UiqYzobQ3bddqNj
	DTkPkREMyWANMqSFxMIyhNq7fe3NTnHKOfd+Ttug1WFHuxS/BhkmXGrmoW06ZrKNxeugLTlrYbH
	EuN4VSdOqHFA+AmlzC8VkW6fUz8FgLI4HiYGPJ2XwE9W6AObOlkwHZRpIQjuYy60wlNS6CzpPqR
	Rm4FC3X2I4/0iWE7bk2YO32VYJbcFOpAJnZfOLA87qz/Lfl4mKqyv9LKRgRB+sUvLgYCrpyhL7a
	wfEhSvaflmE7LIA0LRz1wCYqNPhCz8hd4aia6sPCAU6T6croH2lCTQIF3ZN/rT3yYp2T0BgSsnn
	wOZWVI6+YdVfu9UiaLTRjjtRuGDGR4=
X-Received: by 2002:a05:6a20:9145:b0:38c:627f:872b with SMTP id adf61e73a8af0-395c3b0f8e1mr1712302637.59.1772165565498;
        Thu, 26 Feb 2026 20:12:45 -0800 (PST)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6ba5eesm41682865ad.68.2026.02.26.20.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 20:12:45 -0800 (PST)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next 10/35] wifi: mm81x: add fw.h
Date: Fri, 27 Feb 2026 15:10:20 +1100
Message-ID: <20260227041108.66508-11-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260227041108.66508-1-lachlan.hodges@morsemicro.com>
References: <20260227041108.66508-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[morsemicro-com.20230601.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32249-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,morsemicro.com:mid,morsemicro.com:email,morsemicro-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 5004E1B289B
X-Rspamd-Action: no action

(Patches split per file for review, see cover letter for more
information)

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 drivers/net/wireless/morsemicro/mm81x/fw.h | 107 +++++++++++++++++++++
 1 file changed, 107 insertions(+)
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/fw.h

diff --git a/drivers/net/wireless/morsemicro/mm81x/fw.h b/drivers/net/wireless/morsemicro/mm81x/fw.h
new file mode 100644
index 000000000000..6d1e66934248
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/mm81x/fw.h
@@ -0,0 +1,107 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2017-2026 Morse Micro
+ */
+
+#ifndef _MM81X_FW_H_
+#define _MM81X_FW_H_
+
+#include <linux/firmware.h>
+#include <linux/completion.h>
+#include "yaps_hw.h"
+
+#define BCF_DATABASE_SIZE (1024)
+#define MM81X_FW_DIR "morsemicro"
+#define MM81X_FW_EXT ".bin"
+
+#define IFLASH_BASE_ADDR 0x400000
+#define DFLASH_BASE_ADDR 0xC00000
+
+#define MAX_BCF_NAME_LEN 64
+
+/* FW_CAPABILITIES_FLAGS_WIDTH = ceil(MM81X_CAPS_MAX_HW_LEN / 32) */
+#define FW_CAPABILITIES_FLAGS_WIDTH (4)
+
+/* Checkpatch does not like Camel Case */
+#define mm81x_elf_ehdr Elf32_Ehdr
+#define mm81x_elf_shdr Elf32_Shdr
+#define mm81x_elf_phdr Elf32_Phdr
+
+enum mm81x_fw_info_tlv_type {
+	MM81X_FW_INFO_TLV_BCF_ADDR = 1,
+};
+
+struct mm81x_fw_info_tlv {
+	__le16 type;
+	__le16 length;
+	u8 val[];
+} __packed;
+
+enum mm81x_fw_ext_host_tbl_tag {
+	/* The S1G capability tag */
+	MM81X_FW_HOST_TABLE_TAG_S1G_CAPABILITIES = 0,
+	MM81X_FW_HOST_TABLE_TAG_PAGER_BYPASS_TX_STATUS = 1,
+	MM81X_FW_HOST_TABLE_TAG_INSERT_SKB_CHECKSUM = 2,
+	MM81X_FW_HOST_TABLE_TAG_YAPS_TABLE = 3,
+	MM81X_FW_HOST_TABLE_TAG_PAGER_PKT_MEMORY = 4,
+	MM81X_FW_HOST_TABLE_TAG_PAGER_BYPASS_CMD_RESP = 5,
+};
+
+struct ext_host_tbl_tlv_hdr {
+	/* The tag used to identify which capability this represents */
+	__le16 tag;
+	/* The length of the capability structure including this header */
+	__le16 length;
+} __packed;
+
+struct ext_host_tbl_s1g_caps {
+	struct ext_host_tbl_tlv_hdr header;
+	__le32 flags[FW_CAPABILITIES_FLAGS_WIDTH];
+	/*
+	 * The minimum A-MPDU start spacing required by firmware.
+	 * Value | Description
+	 * ------|------------
+	 * 0     | No restriction
+	 * 1     | 1/4 us
+	 * 2     | 1/2 us
+	 * 3     | 1 us
+	 * 4     | 2 us
+	 * 5     | 4 us
+	 * 6     | 8 us
+	 * 7     | 16 us
+	 */
+	u8 ampdu_mss;
+	u8 beamformee_sts_capability;
+	u8 number_sounding_dimensions;
+	/*
+	 * The maximum A-MPDU length. This is the exponent value such that
+	 * (2^(13 + exponent) - 1) is the length
+	 */
+	u8 maximum_ampdu_length;
+	/*
+	 * Offset to apply to the specification's MMSS table to signal further
+	 * minimum MPDU start spacing.
+	 */
+	u8 mm81x_mmss_offset;
+} __packed;
+
+struct ext_host_tbl_insert_skb_checksum {
+	struct ext_host_tbl_tlv_hdr header;
+	u8 insert_and_validate_checksum;
+};
+
+struct ext_host_tbl_yaps_table {
+	struct ext_host_tbl_tlv_hdr header;
+	struct mm81x_yaps_hw_table yaps_table;
+} __packed;
+
+struct ext_host_tbl {
+	__le32 ext_host_tbl_length;
+	u8 dev_mac_addr[6];
+	u8 ext_host_table_data_tlvs[];
+} __packed;
+
+int mm81x_fw_init(struct mm81x *mm, bool reset);
+int mm81x_fw_parse_ext_host_tbl(struct mm81x *mm);
+
+#endif /* !_MM81X_FW_H_ */
-- 
2.43.0


