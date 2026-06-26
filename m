Return-Path: <linux-wireless+bounces-38121-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Tr81EHgdPmr0/wgAu9opvQ
	(envelope-from <linux-wireless+bounces-38121-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 08:34:32 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A45926CAA9E
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 08:34:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=morsemicro-com.20251104.gappssmtp.com header.s=20251104 header.b="HFWg/otl";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38121-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38121-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=morsemicro.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7ACC330DCA35
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 06:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904E9239567;
	Fri, 26 Jun 2026 06:31:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275333D647F
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 06:31:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782455493; cv=none; b=IGY05m6kp4TG8N13gDjMB7oPHyhOl0x3HGsv30YB3J+XZjLd0t/Ezg68gQzWm3bOrSOgaUz+fUMLJdZ3Hdr7d3GO03Tbwe5ZxfcKT1dpLXln4xmjovhBDowJfTusnm0+Gw5Q/wXS9qy//pbh6ChV82+4O6Tnn6fRytrVUMqPqTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782455493; c=relaxed/simple;
	bh=QQW9Ol2/MUfeGEuwtKsfzyPtq+MjMH6Ai2GK2K8NzL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sCMuY8xUufGEVC83pS9+QbY84qhzvo5wmPoADOJd3SWJjthVFJopiTJvbmwn6n/Ikd38LUx4a7IDf1MUkub4gQ3YPojUYIeBw/ErYztR96A4ueus6xLKMnN5bIoglZlBubPg8J5Z55jnwPOyBCw960UwK99h1mWrGzOhVXhSdXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=HFWg/otl; arc=none smtp.client-ip=74.125.82.41
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-139b914bab6so963495c88.1
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 23:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1782455491; x=1783060291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wz9LdKc+WOQveKA65LpatpPFRey7w6xBDumiPvbIa+4=;
        b=HFWg/otlzY2SkwZTVxqbLybokJMlidclwYDTMUBU5qWc2QFzIDRBIKAUpUoZyrft6x
         7WndhXmIOkU6TDZvVGc/qpGWgG+c12clQGw/tq3X1vSddQfd/+pSLRfpJRhcxybYz/Dn
         HL135J5uEz0fAkXXfHkeStNT8P87fbBcmqt/yinGIr+zEldRvtn8GzBYwAVcDbZRCI45
         Cut3DD6J/P642OXyRzRNMP2qJF5JtGMRth8lReFU6CcoaVfVzCon4NBWFbtR9HCE6Qkn
         GndTAP7WP3C2ETXvPoJhC0kHd4RgNvWiuN//FFZbBkOt6p8Bopc3WtefH4uLbGDYnQA5
         IkOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782455491; x=1783060291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wz9LdKc+WOQveKA65LpatpPFRey7w6xBDumiPvbIa+4=;
        b=Bq5ZY/mz5e40oPknVa6BKjk9BEP+IJm/pZmv/3RPQREvZRli2TJIhxxUda7TwMxIHS
         zukYcBXseuWW6xAoFRftdx+kp83NSWEE/D25eH6FyJYlhtwKBuo68NRSHEa9g5QHNhkq
         9Fsa4hhV8TKam7GSY1Git95E3e642y/+4/zVsmwYWdmIhU3g9OgiQXTiOTfrqO508TMM
         pOlUaSQZbHWNCE6PyavqSZQNB3fUPDqu/tWAqSIGHNH6Z6DvqUO5UKnHewvYX3zH8p/B
         tl+REzt2APNsFhBu+Xc2SxTcJO8bgs2dlRgQngvXnjsnUQl/JHHsethTY11cKqxP6GCS
         8zLw==
X-Forwarded-Encrypted: i=1; AFNElJ+KT/6isez5o2HSfDjfxga5VJzmX3Soa6VMST6c/H3LpiPkJTJlOTrlxwBWo/fmd2KAUd3dcj7X6SnfL8U1XQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQRBGlV0GmBfM36w9ZOA3lCvcnObREJmreOssPaY+oCbhi7rOS
	aoMQxmPlZWWk2rgYo4uF2kjDTet45XlfO7xoJlQ8Wytv0s96d/0o0a+pDgme4AaUAV0=
X-Gm-Gg: AfdE7cmJ2rProQoKHr17CiYf6PDBWw7ZF6Q+uyr1yVaKXMYZoX/qHPFxQr5CKkrqKj7
	M4MpzlE4uI95T9QaufM3jb3voyw8GQFdZXlRiXiulvjz9V/EcHSbZohLDBwTdYYT7Ahwf1cfW3H
	rQZPRz8fmJJm+AYbqPiqfwMwxTwZx/5SlLsjxIhhY2fM3KWCxIr6srl3S12wes2PpOTCJk7XEX8
	6/J+g7VQCXhzjgFItflnEsbZqmvMTo/mEH9mb6yEv5mJdBcV3nYh+/NHIGE7GQWC6gDvmLwP910
	glyP4NwReZuYNYOVmKg581WNMlFWDpmOuF8oEZeRxk6f0PqwTP4+7aV2AKlOiAW97CtLY4RnHhp
	rglK/8h9dD4g5T5ZG0Q39BRZbUN//+CI/KJb3zBgbzHrMi/Qm6E9eCaBYJgQxEvx/oiqofXbtVS
	p2rcD2OQCl/StYzYZH6XeYkAOtXnYek7hNInYfGf63AtrlJBreUoVveIo0WOeDYoRAct9a5zYqH
	B4pZm6GQmb36VrlmyBn
X-Received: by 2002:a05:7022:1b09:b0:138:243e:ce97 with SMTP id a92af1059eb24-139dbb188c9mr4414165c88.4.1782455491106;
        Thu, 25 Jun 2026 23:31:31 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d91006bcsm15463687c88.13.2026.06.25.23.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 23:31:30 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next v3 10/33] wifi: mm81x: add fw.h
Date: Fri, 26 Jun 2026 16:29:06 +1000
Message-ID: <20260626063014.1275235-11-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260626063014.1275235-1-lachlan.hodges@morsemicro.com>
References: <20260626063014.1275235-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-38121-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:lachlan.hodges@morsemicro.com,m:dan.callaghan@morsemicro.com,m:arien.judge@morsemicro.com,m:ayman.grais@morsemicro.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[morsemicro-com.20251104.gappssmtp.com:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,morsemicro.com:email,morsemicro.com:mid,morsemicro.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A45926CAA9E

(Patches split per file for review, will be a single commit alongside
SDIO ids once review is complete. See cover letter for more
information)

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 drivers/net/wireless/morsemicro/mm81x/fw.h | 141 +++++++++++++++++++++
 1 file changed, 141 insertions(+)
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/fw.h

diff --git a/drivers/net/wireless/morsemicro/mm81x/fw.h b/drivers/net/wireless/morsemicro/mm81x/fw.h
new file mode 100644
index 000000000000..d590ad3121c1
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/mm81x/fw.h
@@ -0,0 +1,141 @@
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
+#include <linux/elf.h>
+#include "yaps_hw.h"
+
+#define BCF_DATABASE_SIZE (1024)
+#define MM81X_FW_DIR "morsemicro"
+#define MM81X_FW_EXT ".bin"
+
+#define MAX_BCF_NAME_LEN 64
+
+/* FW_CAPABILITIES_FLAGS_WIDTH = ceil(MM81X_CAPS_MAX_HW_LEN / 32) */
+#define FW_CAPABILITIES_FLAGS_WIDTH (4)
+
+struct mm81x_elf32_ehdr {
+	unsigned char e_ident[EI_NIDENT];
+	__le16 e_type;
+	__le16 e_machine;
+	__le32 e_version;
+	__le32 e_entry;
+	__le32 e_phoff;
+	__le32 e_shoff;
+	__le32 e_flags;
+	__le16 e_ehsize;
+	__le16 e_phentsize;
+	__le16 e_phnum;
+	__le16 e_shentsize;
+	__le16 e_shnum;
+	__le16 e_shstrndx;
+} __packed;
+
+struct mm81x_elf32_shdr {
+	__le32 sh_name;
+	__le32 sh_type;
+	__le32 sh_flags;
+	__le32 sh_addr;
+	__le32 sh_offset;
+	__le32 sh_size;
+	__le32 sh_link;
+	__le32 sh_info;
+	__le32 sh_addralign;
+	__le32 sh_entsize;
+} __packed;
+
+struct mm81x_elf32_phdr {
+	__le32 p_type;
+	__le32 p_offset;
+	__le32 p_vaddr;
+	__le32 p_paddr;
+	__le32 p_filesz;
+	__le32 p_memsz;
+	__le32 p_flags;
+	__le32 p_align;
+} __packed;
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
+int mm81x_fw_init(struct mm81x *mors, bool reset);
+int mm81x_fw_parse_ext_host_tbl(struct mm81x *mors);
+
+#endif /* !_MM81X_FW_H_ */
-- 
2.43.0


