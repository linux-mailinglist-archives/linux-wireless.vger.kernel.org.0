Return-Path: <linux-wireless+bounces-35655-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKxzLxji8mkmvQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35655-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 07:01:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 264ED49D73E
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 07:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A10FA306B2E6
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 04:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F0336826E;
	Thu, 30 Apr 2026 04:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b="sVFvlatF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0474C3624CB
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 04:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777525040; cv=none; b=iNCQ3Oed46sg//wmMbbn7F9ZK/lmKz86klQpMhIzfzrtCyH/fEFjaqzgNF99gX4BXhPpDXV5Cnle90bXv7Kf8gsaPhMPgnZe7eMc+zIEFTzkVv9c4jmofdCQpzM+p8GJvv7YynH9MyxGOEFPFXi/gpGTm62SYCdfMdLSvN474K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777525040; c=relaxed/simple;
	bh=QdSDdOo8/ooDSfTFcbjuMppOtxPRqkwzYrKVFz3e5FY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZSoQT+VGlULfBsnDSc3mMSh0WnUkfZi5iI+8E4enxjDLI1eDDJkaqGuDgh2V0ipdBPbIrbYSpUhKKm/XV3Xkiuf4WLtU/e9SXQkMmr9rqz4jMckO+Lb7WLOJ9CWSF/5Bu2gub8/MWkK92k2D1tyhd8ua+GScF0aYp1j9HU7kfII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=sVFvlatF; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-827270d50d4so506837b3a.3
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 21:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1777525038; x=1778129838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKGh8F/2xrvoivYNd36JzN/CNaB7UbaECFTw9h8o0dE=;
        b=sVFvlatFbS8esk9omJDIp0DONbF4lIOkm2gw78OcZpkm4KF1U8pltzSW41C8Jl5UaZ
         NaddH80OC1Ud5B+haAcYe83OCK86bTsKEcq/UaDKVdMRJBgGJBsE7VdGE9Z5eONuGyCk
         i8vLqmTlNWaGbgY3zQAqLwa54r1ryvK09jFD3pdR8G2c4z5gbhXsThvZ135Al2sXNN9n
         OoKQOggpL+DDGOfBJkqx+sZesFRjK5RTeFY0yzwnnQmJQEUcNNn3mj9o8/z3vyP1tCIP
         8QW/LGtaTA9ZkwWwWiPD1GHPSeHxd6W1kjJ65BqBy6fNgs3uXOFWqLm6Ft/+kBhAOZiY
         P8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777525038; x=1778129838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LKGh8F/2xrvoivYNd36JzN/CNaB7UbaECFTw9h8o0dE=;
        b=OmACKEZOU/Jo9082J57iQMrGZnPqa9XgOoGmGJXMmUnanuLZ7U0CPL4MGqjNJrHZ3k
         vbCZcKRS1uaS/zTGKvKvykzguVNro8ikt/6MAbW78ygk4chYU237kD5Ly6FHVI8W0uHZ
         6DO1eNFWpH1MvHPrWIFkOVWK2zF+Tq9ldJIzhA0rHWye3Q/kj5chYsn0ih9hkY9HgQiU
         x3bLrP1rfvT2BX7obipal2d3T+lGE1585VVkZ8YuhjEJriTSsKrPX9D6vJkTE/Uy5wux
         TQIGmjqDyiLL30jAn22CXae2IZw8Iuncy29NvqNLoxM2pgigf+CODw+Q5fBfwE+H5isx
         0UTQ==
X-Forwarded-Encrypted: i=1; AFNElJ/9/th+B5F9kmWGZXI/AuX5bmwa2u0BvG2Q2f4Gpkxal7LjjzWts5LaJ9lTp/HyD1Sk+FJkqMZzo535OWE/ww==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5Uo43IuEv2TIF0ZKnPL0BF+RggBTrFosOInLXJFcvHRDgOtC+
	bko6z9tKijFYHpIEj3K3slqpFdmSdMYm2SgtJAQBM8UY43cIWGt+UqH70wKPEUY6smPVskYD5Is
	QkOYK
X-Gm-Gg: AeBDieuv7z57jrnGkhYYSV7VGNbI4uJ8w/clvRH8vNlp9jqYHSLwT2zcRHo96CNf8pg
	m0N+wm1H1HVmGoO9He2ywsabDpZPMMpZOzVlzOmXxDmMq6FWMlfCmmIttxd2QetAMm8q4/Q1tep
	mQYBor/VR6hw3Z9VAoPa+03V7kmmHBr2jpfJeOXisAtIhwynRRTEcrN7AEBldRkL4DEk7BUKI6k
	pxhioLXRZ7kI7hT0iSM3hbrmqpR0JE4nWn5r9f2dOuX1H2lNgs8r2g2c9rhmyKpE+zryV2TcC0T
	wKpyznqvRfMikRb181gQmIrrGCiPSVIqsmaJ/SwOAFqXghvAHEWMAVGXuvzb0PjY4Qu46Qht4qR
	jdwnbi8Ad0+vN+F017e74l7jJrHAuZkAlzVFgubEGLGtqULFKcH4sUMb9MQM67wur3s0HyfLmM3
	ey0NgJYFYl6HbP9K5lCwdIl6vXVDgCz4Cuw4X2sxS2hUBelX4NpPFf9bPOk1xNhVvBgLlPxeYAD
	kd1sXJXCxjuxcS7gNcx4GgkJ4wUdDsk8bL5520qGQ==
X-Received: by 2002:a05:6a00:4196:b0:824:a01f:6335 with SMTP id d2e1a72fcca58-834fdb63d40mr1640768b3a.22.1777525038391;
        Wed, 29 Apr 2026 21:57:18 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed80df96sm3595073b3a.54.2026.04.29.21.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 21:57:18 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next v2 08/31] wifi: mm81x: add fw.h
Date: Thu, 30 Apr 2026 14:55:34 +1000
Message-ID: <20260430045615.334669-9-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430045615.334669-1-lachlan.hodges@morsemicro.com>
References: <20260430045615.334669-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 264ED49D73E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-35655-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MAILSPIKE_FAIL(0.00)[2600:3c0a:e001:db::12fc:5321:query timed out];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,morsemicro-com.20251104.gappssmtp.com:dkim,morsemicro.com:mid,morsemicro.com:email]

(Patches split per file for review, will be a single commit alongside
SDIO ids once review is complete. See cover letter for more
information)

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 drivers/net/wireless/morsemicro/mm81x/fw.h | 107 +++++++++++++++++++++
 1 file changed, 107 insertions(+)
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/fw.h

diff --git a/drivers/net/wireless/morsemicro/mm81x/fw.h b/drivers/net/wireless/morsemicro/mm81x/fw.h
new file mode 100644
index 000000000000..60477c59245d
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
+int mm81x_fw_init(struct mm81x *mors, bool reset);
+int mm81x_fw_parse_ext_host_tbl(struct mm81x *mors);
+
+#endif /* !_MM81X_FW_H_ */
-- 
2.43.0


