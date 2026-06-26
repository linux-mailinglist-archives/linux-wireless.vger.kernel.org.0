Return-Path: <linux-wireless+bounces-38141-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id j3n7IKwfPmpuAAkAu9opvQ
	(envelope-from <linux-wireless+bounces-38141-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 08:43:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFA56CAB9E
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 08:43:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=morsemicro-com.20251104.gappssmtp.com header.s=20251104 header.b=lwuwmqf7;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38141-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38141-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=morsemicro.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 69CB7309AD9C
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 06:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801593DB651;
	Fri, 26 Jun 2026 06:33:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAFF3DB32E
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 06:33:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782455616; cv=none; b=kPgMI0v3uxXD9gboM5h8wENvlebf5HLgbgJQ1jnAShTdlplIkp4yxLHluiBuZEWwEFdL4OQ1nRiu0tptVXbM039swBvTceNPq0d78yQjvxvo0M4nX/P/hbTrSbGyWGwZ0vQxERSKF6qWLdxWLD1rAthdTUnoYTwg777GNPQh/Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782455616; c=relaxed/simple;
	bh=5dKum5j9f8COBjoKjWs0+IOq5KViO3pwCJ8iK34qHpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BaQXmodAMK8uoi0KCFaTlPXYzyhxi7R39HGPB7k42bOuTEa7UialYdCGOTMmWvSoyR+xgw1MnbxS7bUePpT3cUmiN5bYoA5qhUH/jFKu4qNwlz7T36+FGys8+nIezSerT0xEHDD7Aayjd7ijEqJpvXbR8Nx79LOLjW//RGvkGjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=lwuwmqf7; arc=none smtp.client-ip=74.125.82.41
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-139aff562e1so923378c88.1
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 23:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1782455614; x=1783060414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1K0+as58BYD3JHPlAyDGosD3rUgJATa1zay3HH5bMbE=;
        b=lwuwmqf7gur1B9U7/O9Wmb1RJTduf/4ogzHDq+GnfUeP73n02dFvVoV2DbukbKXCwu
         li+K1Co8aGk6ncw5heHp6BpgmSsvuzQh5PSjjUT4P3/YPP4bbIItjg3tHGJqWEFp+0nE
         CxZebsiVWUuxmJxRL66Veef/kQVjuTHfYkbYNiCIvsNzw1KLAyjARGmkKdtDt8Dj/SWN
         IJHrmDf666DrpV2FK9JG8Lr+VPGO8EqnOzazWBvFl5YzZzdLDrImK9Z9b1Pg2QOHaYaV
         aIok+8LvNP5azFtBtCeg4GxVRPk6Ft+vQQKU/35tCJoEVOhxqJDip7RqvHQ7QiJuMxys
         RDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782455614; x=1783060414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1K0+as58BYD3JHPlAyDGosD3rUgJATa1zay3HH5bMbE=;
        b=cs9TewQAT2ktUzpF7C/Qrk53WziYmQy30xAZr4WOkPxh2Z8vpAMqv0mPxXJ5JiF/8a
         99wgsQ4WDWFVkYh24brH0a6x52LHQ7ieL2AeZOrRvO56+5YegieX//WjQGtEIyD7PxxV
         5rP9GSPmnPhz1mu1PhIbSkHA8QTXboXYhrzvgzKNe5vhzdsAF50eih+L9Trz4pbXs3iV
         ahqxNiwOyKvqyjo/1nPG53RAYtrSHqcl+7I0yS2U3PG8BsjRO3QWdGJId9aOZ4Gpw8x+
         jHbP3QcOhIpeFSM7uYyqKGk/JmRCurK10xDIQmZuQRyx7Bc7lhzFb9QXgVXTBh2PX8jP
         /INQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Isb1enoobecX9Yaf4AZxG+B2PQrLnutas+qgTi4yqMe64LqeOSNgCam+m2zCGPQeajtYrFMRWOPBLpgCl8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnbUE1zbhOHyiu1QkcvEimE7nP6RjbvSxylZBcWz6m7FW2C5i9
	k4VwPp4mAuPlcrWgGiueb2U9HtZSiHZzEP8Ak49Hwk0qGTTV22O+OKlpI1iil9YhMG4=
X-Gm-Gg: AfdE7clNkzYXgeYu2EhXSZsO1o+Z1o1ggIsnzvw/D4x0LXFL4h01zX7hTaemxwBjNuY
	XRUCddEYKz2YT+bzzZiL7iq0l/PfPTFSYpVn78DAWU8OMA0xD8AanyEywGxBiAvXQOKiM2yJ1xC
	u6nUFOPreMZ5V81OlS5fDwG7d2fZYVsES9ToJTa8VB1J8/zJX7zD9duCLjMHHqzUYAGcqpCrFqk
	mzVOVfOUgyRPkQgyOjPsn2oFBrHP1zxjrVqn5F5mdEFQrMehjLLGFwwX+pmeC2LMCXdF2C4/dmy
	tykvpdaP+tQq/vwA0J6Kduq7okGCaXwju4drSqhbUIUPuhMynBJHlJKyNX9NSceEVvOTC9ajfaj
	lKrCMt50GxZGrTJAAYRRTCgYs5y2d6tBpe8er52434WboABCrURadWHX1xrfaw8yMZYPaahg46O
	nMqUoa8xnZ53/4bQbZBVQLJg+95FF4gf51rmToKTMJxrTxrGhjaM3iJY1LcTO/fi1xkGBFCQcKq
	t5VW1K7fVnDdwWLSlx+uVFxHjYoudE=
X-Received: by 2002:a05:7022:117:b0:138:407c:1d17 with SMTP id a92af1059eb24-139dbac81f5mr5005914c88.33.1782455613472;
        Thu, 25 Jun 2026 23:33:33 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d91006bcsm15463687c88.13.2026.06.25.23.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 23:33:33 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next v3 30/33] wifi: mm81x: add yaps_hw.c
Date: Fri, 26 Jun 2026 16:29:26 +1000
Message-ID: <20260626063014.1275235-31-lachlan.hodges@morsemicro.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-38141-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:lachlan.hodges@morsemicro.com,m:dan.callaghan@morsemicro.com,m:arien.judge@morsemicro.com,m:ayman.grais@morsemicro.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,morsemicro.com:email,morsemicro.com:mid,morsemicro.com:from_mime,morsemicro-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7EFA56CAB9E

(Patches split per file for review, will be a single commit alongside
SDIO ids once review is complete. See cover letter for more
information)

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 .../net/wireless/morsemicro/mm81x/yaps_hw.c   | 702 ++++++++++++++++++
 1 file changed, 702 insertions(+)
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/yaps_hw.c

diff --git a/drivers/net/wireless/morsemicro/mm81x/yaps_hw.c b/drivers/net/wireless/morsemicro/mm81x/yaps_hw.c
new file mode 100644
index 000000000000..3d641d23c35b
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/mm81x/yaps_hw.c
@@ -0,0 +1,702 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2017-2026 Morse Micro
+ */
+#include "yaps_hw.h"
+#include "bus.h"
+#include "hif.h"
+#include "yaps.h"
+
+#define YAPS_HW_WINDOW_SIZE_BYTES 32768
+#define YAPS_MAX_PKT_SIZE_BYTES 16128
+#define YAPS_METADATA_PAGE_COUNT 1
+
+#define YAPS_PHANDLE_CORRUPTION_WAR_EXTRA_PAGE 1
+
+#define YAPS_PAGE_SIZE 256
+
+/* Calculate padding required for yaps transaction */
+#define YAPS_CALC_PADDING(_bytes) ((_bytes) & 0x3 ? (4 - ((_bytes) & 0x3)) : 0)
+
+#define YAPS_RESERVED_PAGE_SIZE 256
+
+/*
+ * Yaps data stream delimiter is a 32 bit word with the following fields:
+ *
+ * pkt_size (14 bits) - Packet size not including delimiter or padding
+ * pool_id  (3  bits) - Pool that pages should be allocated from.
+ * padding  (2  bits) - Padding required to bring packet to word (4 byte)
+ * irq      (1  bit ) - Raise a PKT_IRQ on the YDS this is sent to
+ * reserved (5  bits) - Reserved, must write as 0
+ * crc      (7  bits) - YAPS CRC
+ */
+
+/* Packet size not including delimiter or padding */
+#define YAPS_DELIM_GET_PKT_SIZE(_delim) \
+	(((_delim) & 0x3FFF) - YAPS_RESERVED_PAGE_SIZE)
+#define YAPS_DELIM_SET_PKT_SIZE(_pkt_size) \
+	(((_pkt_size) & 0x3FFF) + YAPS_RESERVED_PAGE_SIZE)
+#define YAPS_DELIM_GET_PHANDLE_SIZE(_delim) (((_delim) & 0x3FFF))
+
+/* Pool that pages should be allocated from. */
+#define YAPS_DELIM_SET_POOL_ID(_pool_id) (((_pool_id) & 0x7) << 14)
+
+/* Padding required to bring packet to word (4 byte) boundary */
+#define YAPS_DELIM_GET_PADDING(_delim) (((_delim) >> 17) & 0x3)
+#define YAPS_DELIM_SET_PADDING(_padding) (((_padding) & 0x3) << 17)
+
+/* Raise a PKT_IRQ on the YDS this is sent to */
+#define YAPS_DELIM_SET_IRQ(_irq) (((_irq) & 0x1) << 19)
+
+/* YAPS CRC */
+#define YAPS_DELIM_GET_CRC(_delim) (((_delim) >> 25) & 0x7F)
+#define YAPS_DELIM_SET_CRC(_crc) (((_crc) & 0x7F) << 25)
+
+struct mm81x_yaps_status_regs {
+	/* Allocation pools */
+	u32 tc_tx_pool_num_pages;
+	u32 tc_cmd_pool_num_pages;
+	u32 tc_beacon_pool_num_pages;
+	u32 tc_mgmt_pool_num_pages;
+	u32 fc_rx_pool_num_pages;
+	u32 fc_resp_pool_num_pages;
+	u32 fc_tx_sts_pool_num_pages;
+	u32 fc_aux_pool_num_pages;
+	u32 tc_tx_num_pkts;
+	u32 tc_cmd_num_pkts;
+	u32 tc_beacon_num_pkts;
+	u32 tc_mgmt_num_pkts;
+	u32 fc_num_pkts;
+	u32 fc_done_num_pkts;
+	u32 fc_rx_bytes_in_queue;
+	u32 tc_delim_crc_fail_detected;
+	u32 fc_host_ysl_status;
+	u32 lock;
+} __packed __aligned(8);
+
+struct mm81x_yaps_hw_status_regs {
+	__le32 tc_tx_pool_num_pages;
+	__le32 tc_cmd_pool_num_pages;
+	__le32 tc_beacon_pool_num_pages;
+	__le32 tc_mgmt_pool_num_pages;
+	__le32 fc_rx_pool_num_pages;
+	__le32 fc_resp_pool_num_pages;
+	__le32 fc_tx_sts_pool_num_pages;
+	__le32 fc_aux_pool_num_pages;
+	__le32 tc_tx_num_pkts;
+	__le32 tc_cmd_num_pkts;
+	__le32 tc_beacon_num_pkts;
+	__le32 tc_mgmt_num_pkts;
+	__le32 fc_num_pkts;
+	__le32 fc_done_num_pkts;
+	__le32 fc_rx_bytes_in_queue;
+	__le32 tc_delim_crc_fail_detected;
+	__le32 fc_host_ysl_status;
+	__le32 lock;
+} __packed __aligned(8);
+
+struct mm81x_yaps_hw_aux_data {
+	unsigned long access_lock;
+
+	u32 yds_addr;
+	u32 ysl_addr;
+	u32 status_regs_addr;
+
+	/* Alloc pool sizes */
+	u16 tc_tx_pool_size;
+	u16 tc_cmd_pool_size;
+	u8 tc_beacon_pool_size;
+	u8 tc_mgmt_pool_size;
+	u8 fc_rx_pool_size;
+	u8 fc_resp_pool_size;
+	u8 fc_tx_sts_pool_size;
+	u8 fc_aux_pool_size;
+
+	/* To chip/from chip queue sizes */
+	u8 tc_tx_q_size;
+	u8 tc_cmd_q_size;
+	u8 tc_beacon_q_size;
+	u8 tc_mgmt_q_size;
+	u8 fc_q_size;
+	u8 fc_done_q_size;
+
+	u16 reserved_yaps_page_size;
+
+	/* Buffers to/from chip to support large contiguous reads/writes */
+	char *to_chip_buffer;
+	char *from_chip_buffer;
+
+	/* status registers in host endian */
+	struct mm81x_yaps_status_regs status_regs;
+
+	/* DMA target buffer in firmware endian */
+	struct mm81x_yaps_hw_status_regs hw_status_regs;
+};
+
+static int mm81x_yaps_hw_lock(struct mm81x_yaps *yaps)
+{
+	if (test_and_set_bit_lock(0, &yaps->aux_data->access_lock))
+		return -1;
+	return 0;
+}
+
+static void mm81x_yaps_hw_unlock(struct mm81x_yaps *yaps)
+{
+	clear_bit_unlock(0, &yaps->aux_data->access_lock);
+}
+
+static void
+mm81x_yaps_hw_fill_aux_data_from_hw_tbl(struct mm81x_yaps_hw_aux_data *a,
+					struct mm81x_yaps_hw_table *t)
+{
+	a->ysl_addr = __le32_to_cpu(t->ysl_addr);
+	a->yds_addr = __le32_to_cpu(t->yds_addr);
+	a->status_regs_addr = __le32_to_cpu(t->status_regs_addr);
+	a->tc_tx_pool_size = __le16_to_cpu(t->tc_tx_pool_size);
+	a->fc_rx_pool_size = __le16_to_cpu(t->fc_rx_pool_size);
+	a->tc_cmd_pool_size = t->tc_cmd_pool_size;
+	a->tc_beacon_pool_size = t->tc_beacon_pool_size;
+	a->tc_mgmt_pool_size = t->tc_mgmt_pool_size;
+	a->fc_resp_pool_size = t->fc_resp_pool_size;
+	a->fc_tx_sts_pool_size = t->fc_tx_sts_pool_size;
+	a->fc_aux_pool_size = t->fc_aux_pool_size;
+	a->tc_tx_q_size = t->tc_tx_q_size;
+	a->tc_cmd_q_size = t->tc_cmd_q_size;
+	a->tc_beacon_q_size = t->tc_beacon_q_size;
+	a->tc_mgmt_q_size = t->tc_mgmt_q_size;
+	a->fc_q_size = t->fc_q_size;
+	a->fc_done_q_size = t->fc_done_q_size;
+	a->reserved_yaps_page_size = le16_to_cpu(t->yaps_reserved_page_size);
+}
+
+static u8 mm81x_yaps_hw_crc(u32 word)
+{
+	u8 crc = 0;
+	u8 byte;
+	int i;
+
+	/* Mask to look at only non-CRC bits */
+	word &= 0x1ffffff;
+
+	for (i = 0; i < 4; i++) {
+		byte = (word >> 24) & 0xff;
+		crc = crc7_be(crc, &byte, 1);
+		word <<= 8;
+	}
+
+	return crc >> 1;
+}
+
+static u32 mm81x_write_pkts_h_build_delim(struct mm81x_yaps *yaps,
+					  unsigned int size, u8 pool_id,
+					  bool irq)
+{
+	u32 delim = 0;
+
+	delim |= YAPS_DELIM_SET_PKT_SIZE(size);
+	delim |= YAPS_DELIM_SET_PADDING(YAPS_CALC_PADDING(size));
+	delim |= YAPS_DELIM_SET_POOL_ID(pool_id);
+	delim |= YAPS_DELIM_SET_IRQ(irq);
+	delim |= YAPS_DELIM_SET_CRC(mm81x_yaps_hw_crc(delim));
+	return delim;
+}
+
+void mm81x_yaps_hw_enable_irqs(struct mm81x *mors, bool enable)
+{
+	mm81x_hw_irq_enable(mors, MM81X_INT_YAPS_FC_PKT_WAITING_IRQN, enable);
+	mm81x_hw_irq_enable(mors, MM81X_INT_YAPS_FC_PACKET_FREED_UP_IRQN,
+			    enable);
+}
+
+void mm81x_yaps_hw_read_table(struct mm81x *mors,
+			      struct mm81x_yaps_hw_table *tbl_ptr)
+{
+	mm81x_yaps_hw_fill_aux_data_from_hw_tbl(mors->hif.u.yaps.aux_data,
+						tbl_ptr);
+	mm81x_yaps_hw_enable_irqs(mors, true);
+}
+
+static unsigned int mm81x_write_pkts_h_pages_required(struct mm81x_yaps *yaps,
+						      unsigned int size_bytes)
+{
+	/* Always account for the first metadata page */
+	return DIV_ROUND_UP(size_bytes +
+				    yaps->aux_data->reserved_yaps_page_size,
+			    YAPS_PAGE_SIZE) +
+	       YAPS_METADATA_PAGE_COUNT +
+	       YAPS_PHANDLE_CORRUPTION_WAR_EXTRA_PAGE;
+}
+
+/*
+ * Checks if a single pkt will fit in the chip using the pool/alloc holding
+ * information from the last status register read.
+ */
+static bool mm81x_write_pkts_h_will_fit(struct mm81x_yaps *yaps,
+					struct mm81x_yaps_pkt *pkt, bool update)
+{
+	bool will_fit = true;
+	const int pages_required =
+		mm81x_write_pkts_h_pages_required(yaps, pkt->skb->len);
+	int *pool_pages_avail = NULL;
+	int *pkts_in_queue = NULL;
+	int queue_pkts_avail = 0;
+
+	switch (pkt->tc_queue) {
+	case MM81X_YAPS_TX_Q:
+		pool_pages_avail =
+			&yaps->aux_data->status_regs.tc_tx_pool_num_pages;
+		pkts_in_queue = &yaps->aux_data->status_regs.tc_tx_num_pkts;
+		queue_pkts_avail =
+			yaps->aux_data->tc_tx_q_size - *pkts_in_queue;
+		break;
+	case MM81X_YAPS_CMD_Q:
+		pool_pages_avail =
+			&yaps->aux_data->status_regs.tc_cmd_pool_num_pages;
+		pkts_in_queue = &yaps->aux_data->status_regs.tc_cmd_num_pkts;
+		queue_pkts_avail =
+			yaps->aux_data->tc_cmd_q_size - *pkts_in_queue;
+		break;
+	case MM81X_YAPS_BEACON_Q:
+		pool_pages_avail =
+			&yaps->aux_data->status_regs.tc_beacon_pool_num_pages;
+		pkts_in_queue = &yaps->aux_data->status_regs.tc_beacon_num_pkts;
+		queue_pkts_avail =
+			yaps->aux_data->tc_beacon_q_size - *pkts_in_queue;
+		break;
+	case MM81X_YAPS_MGMT_Q:
+		pool_pages_avail =
+			&yaps->aux_data->status_regs.tc_mgmt_pool_num_pages;
+		pkts_in_queue = &yaps->aux_data->status_regs.tc_mgmt_num_pkts;
+		queue_pkts_avail =
+			yaps->aux_data->tc_mgmt_q_size - *pkts_in_queue;
+		break;
+	default:
+		dev_err(yaps->mors->dev, "yaps invalid tc queue");
+		return false;
+	}
+
+	WARN_ON(queue_pkts_avail < 0);
+
+	if (pages_required > *pool_pages_avail)
+		will_fit = false;
+
+	if (queue_pkts_avail == 0)
+		will_fit = false;
+
+	if (will_fit && update) {
+		*pool_pages_avail -= pages_required;
+		*pkts_in_queue += 1;
+	}
+
+	return will_fit;
+}
+
+static int mm81x_write_pkts_h_err_check(struct mm81x_yaps *yaps,
+					struct mm81x_yaps_pkt *pkt)
+{
+	if (pkt->skb->len + yaps->aux_data->reserved_yaps_page_size >
+	    YAPS_MAX_PKT_SIZE_BYTES)
+		return -EMSGSIZE;
+	if (pkt->tc_queue >= MM81X_YAPS_NUM_TC_Q)
+		return -EINVAL;
+	if (!mm81x_write_pkts_h_will_fit(yaps, pkt, true))
+		return -EAGAIN;
+
+	return 0;
+}
+
+static int mm81x_yaps_hw_write_pkts(struct mm81x_yaps *yaps,
+				    struct mm81x_yaps_pkt *pkts, int num_pkts,
+				    int *num_pkts_sent)
+{
+	int ret = 0;
+	int i;
+	u32 delim = 0;
+	int tx_len;
+	int batch_txn_len = 0;
+	int pkts_pending = 0;
+	bool delim_irq = false;
+	char *to_chip_buffer_aligned =
+		PTR_ALIGN(yaps->aux_data->to_chip_buffer,
+			  mm81x_bus_get_alignment(yaps->mors));
+	char *write_buf = to_chip_buffer_aligned;
+
+	ret = mm81x_yaps_hw_lock(yaps);
+	if (ret) {
+		dev_dbg(yaps->mors->dev, "yaps lock failed %d", ret);
+		return ret;
+	}
+
+	*num_pkts_sent = 0;
+
+	/* Check packet conditions */
+	ret = mm81x_write_pkts_h_err_check(yaps, &pkts[0]);
+	if (ret)
+		goto exit;
+
+	/* Batch packets into larger transactions */
+	for (i = 0; i < num_pkts; ++i) {
+		u32 pkt_size =
+			pkts[i].skb->len + YAPS_CALC_PADDING(pkts[i].skb->len);
+		tx_len = pkt_size + sizeof(delim);
+
+		/*
+		 * Send when we have reached window size, don't split pkt over
+		 * boundary
+		 */
+		if ((batch_txn_len + tx_len) > YAPS_HW_WINDOW_SIZE_BYTES) {
+			ret = mm81x_dm_write(yaps->mors,
+					     yaps->aux_data->yds_addr,
+					     to_chip_buffer_aligned,
+					     batch_txn_len);
+
+			batch_txn_len = 0;
+			if (ret)
+				goto exit;
+			write_buf = to_chip_buffer_aligned;
+			*num_pkts_sent += pkts_pending;
+			pkts_pending = 0;
+		}
+
+		if ((i + 1) == num_pkts) {
+			/* The last packet in the queue has IRQ set */
+			delim_irq = true;
+		} else {
+			/*
+			 * Since this is not the last packet, we can check for
+			 * the next one. In case of errors in the next packet
+			 * set the IRQ
+			 */
+			ret = mm81x_write_pkts_h_err_check(yaps, &pkts[i + 1]);
+			if (ret)
+				delim_irq = true;
+		}
+
+		/* Build stream header*/
+		delim = mm81x_write_pkts_h_build_delim(
+			yaps, pkt_size, pkts[i].tc_queue, delim_irq);
+		*((__le32 *)write_buf) = cpu_to_le32(delim);
+		memcpy(write_buf + sizeof(delim), pkts[i].skb->data,
+		       pkts[i].skb->len);
+
+		write_buf += tx_len;
+		batch_txn_len += tx_len;
+		pkts_pending++;
+
+		if (ret)
+			goto exit;
+	}
+
+exit:
+	if (batch_txn_len > 0) {
+		ret = mm81x_dm_write(yaps->mors, yaps->aux_data->yds_addr,
+				     to_chip_buffer_aligned, batch_txn_len);
+		*num_pkts_sent += pkts_pending;
+	}
+
+	mm81x_yaps_hw_unlock(yaps);
+	return ret;
+}
+
+static bool mm81x_read_pkts_h_is_valid_delim(u32 delim)
+{
+	u8 calc_crc = mm81x_yaps_hw_crc(delim);
+	int pkt_size = YAPS_DELIM_GET_PHANDLE_SIZE(delim);
+	int padding = YAPS_DELIM_GET_PADDING(delim);
+
+	if (calc_crc != YAPS_DELIM_GET_CRC(delim))
+		return false;
+
+	if (pkt_size == 0)
+		return false;
+
+	if ((pkt_size + padding) > YAPS_MAX_PKT_SIZE_BYTES)
+		return false;
+
+	/* Pkt length + padding should not require more padding */
+	if (YAPS_CALC_PADDING(pkt_size) != padding)
+		return false;
+
+	return true;
+}
+
+static int mm81x_read_pkts_h_bytes_remaining(struct mm81x_yaps *yaps)
+{
+	u32 bytes_in_queue = yaps->aux_data->status_regs.fc_rx_bytes_in_queue;
+	u32 delim_overhead =
+		yaps->aux_data->status_regs.fc_num_pkts * sizeof(u32);
+	u32 reserved_bytes = yaps->aux_data->status_regs.fc_num_pkts *
+			     yaps->aux_data->reserved_yaps_page_size;
+
+	if (WARN_ON(bytes_in_queue > INT_MAX) ||
+	    WARN_ON(delim_overhead > INT_MAX) ||
+	    WARN_ON(reserved_bytes > INT_MAX))
+		return -EIO;
+
+	return (int)bytes_in_queue;
+}
+
+static int mm81x_yaps_hw_read_pkts(struct mm81x_yaps *yaps,
+				   struct mm81x_yaps_pkt *pkts,
+				   int num_pkts_max, int *num_pkts_received)
+{
+	int ret;
+	int i = 0;
+	char *from_chip_buffer_aligned =
+		PTR_ALIGN(yaps->aux_data->from_chip_buffer,
+			  mm81x_bus_get_alignment(yaps->mors));
+	char *read_ptr = from_chip_buffer_aligned;
+	int bytes_remaining = mm81x_read_pkts_h_bytes_remaining(yaps);
+	bool again = false;
+
+	*num_pkts_received = 0;
+
+	if (num_pkts_max == 0 || bytes_remaining == 0)
+		return 0;
+	if (bytes_remaining < 0)
+		return bytes_remaining;
+
+	if (bytes_remaining > YAPS_HW_WINDOW_SIZE_BYTES) {
+		bytes_remaining = YAPS_HW_WINDOW_SIZE_BYTES;
+		again = true;
+	}
+
+	/*
+	 * This is more coarse-grained than it needs to be - once the data
+	 * is read into a local buffer the lock can be released, however
+	 * access to from_chip_buffer will need to be protected with its
+	 * own lock
+	 */
+	ret = mm81x_yaps_hw_lock(yaps);
+	if (ret) {
+		dev_dbg(yaps->mors->dev, "yaps lock failed %d", ret);
+		return ret;
+	}
+
+	/* Read all available packets to the buffer */
+	ret = mm81x_dm_read(yaps->mors, yaps->aux_data->ysl_addr,
+			    from_chip_buffer_aligned, bytes_remaining);
+
+	if (ret)
+		goto exit;
+
+	/* Split serialised packets from buffer */
+	while (i < num_pkts_max && bytes_remaining > 0) {
+		u32 delim;
+		int total_len;
+		int pkt_size;
+
+		delim = le32_to_cpu(*((__le32 *)read_ptr));
+		read_ptr += sizeof(delim);
+		bytes_remaining -= sizeof(delim);
+
+		/* End of stream */
+		if (!delim)
+			break;
+
+		if (!mm81x_read_pkts_h_is_valid_delim(delim)) {
+			/*
+			 * This will start a hunt for a valid delimiter. Given
+			 * the CRC is only 7 bit it's possible to find an
+			 * invalid block with a valid delimiter, leading to
+			 * desynchronisation.
+			 */
+			dev_warn(yaps->mors->dev, "yaps invalid delim");
+			break;
+		}
+
+		/* Total length in chip */
+		pkt_size = YAPS_DELIM_GET_PKT_SIZE(delim);
+		total_len = pkt_size + YAPS_DELIM_GET_PADDING(delim);
+
+		if (pkts[i].skb)
+			dev_err(yaps->mors->dev, "yaps packet leak");
+
+		/* SKB doesn't want padding */
+		pkts[i].skb = dev_alloc_skb(pkt_size);
+		if (!pkts[i].skb) {
+			ret = -ENOMEM;
+			dev_err(yaps->mors->dev, "yaps no mem for skb");
+			goto exit;
+		}
+		skb_put(pkts[i].skb, pkt_size);
+
+		if (total_len <= bytes_remaining) {
+			memcpy(pkts[i].skb->data, read_ptr, pkt_size);
+			read_ptr += total_len;
+			bytes_remaining -= total_len;
+		} else {
+			const int read_overhang_len =
+				total_len - bytes_remaining;
+			const int pkt_overhang_len = pkt_size - bytes_remaining;
+
+			memcpy(pkts[i].skb->data, read_ptr, bytes_remaining);
+			read_ptr = from_chip_buffer_aligned;
+
+			ret = mm81x_dm_read(
+				yaps->mors,
+				/* Offset by 4 to avoid retry logic */
+				yaps->aux_data->ysl_addr + 4, read_ptr,
+				read_overhang_len);
+
+			if (ret)
+				goto exit;
+
+			memcpy(pkts[i].skb->data + bytes_remaining, read_ptr,
+			       pkt_overhang_len);
+			read_ptr += read_overhang_len;
+			bytes_remaining = 0;
+		}
+
+		*num_pkts_received += 1;
+		i++;
+	}
+
+	if (again)
+		ret = -EAGAIN;
+
+exit:
+	mm81x_yaps_hw_unlock(yaps);
+	return ret;
+}
+
+static int mm81x_yaps_hw_update_status(struct mm81x_yaps *yaps)
+{
+	int ret;
+	int tc_total_pkt_count;
+	unsigned long reg_read_timeout;
+	struct mm81x_yaps_status_regs *r = &yaps->aux_data->status_regs;
+	struct mm81x_yaps_hw_status_regs *hw_r = &yaps->aux_data->hw_status_regs;
+
+	ret = mm81x_yaps_hw_lock(yaps);
+	if (ret) {
+		dev_dbg(yaps->mors->dev, "yaps lock failed %d", ret);
+		return ret;
+	}
+
+	reg_read_timeout = jiffies + msecs_to_jiffies(100);
+	do {
+		if (time_after(jiffies, reg_read_timeout)) {
+			dev_err(yaps->mors->dev,
+				"timed out reading status registers: %d", ret);
+			ret = -ETIMEDOUT;
+			break;
+		}
+
+		ret = mm81x_dm_read(yaps->mors,
+				    yaps->aux_data->status_regs_addr,
+				    (u8 *)hw_r, sizeof(*hw_r));
+	} while (!ret && le32_to_cpu(hw_r->lock));
+
+	if (ret) {
+		if (ret != -ENODEV) {
+			dev_err(yaps->mors->dev,
+				"error reading yaps status registers: %d", ret);
+		}
+		goto exit_unlock;
+	}
+
+	r->tc_tx_pool_num_pages = le32_to_cpu(hw_r->tc_tx_pool_num_pages);
+	r->tc_cmd_pool_num_pages = le32_to_cpu(hw_r->tc_cmd_pool_num_pages);
+	r->tc_beacon_pool_num_pages = le32_to_cpu(hw_r->tc_beacon_pool_num_pages);
+	r->tc_mgmt_pool_num_pages = le32_to_cpu(hw_r->tc_mgmt_pool_num_pages);
+	r->fc_rx_pool_num_pages = le32_to_cpu(hw_r->fc_rx_pool_num_pages);
+	r->fc_resp_pool_num_pages = le32_to_cpu(hw_r->fc_resp_pool_num_pages);
+	r->fc_tx_sts_pool_num_pages = le32_to_cpu(hw_r->fc_tx_sts_pool_num_pages);
+	r->fc_aux_pool_num_pages = le32_to_cpu(hw_r->fc_aux_pool_num_pages);
+	r->tc_tx_num_pkts = le32_to_cpu(hw_r->tc_tx_num_pkts);
+	r->tc_cmd_num_pkts = le32_to_cpu(hw_r->tc_cmd_num_pkts);
+	r->tc_beacon_num_pkts = le32_to_cpu(hw_r->tc_beacon_num_pkts);
+	r->tc_mgmt_num_pkts = le32_to_cpu(hw_r->tc_mgmt_num_pkts);
+	r->fc_num_pkts = le32_to_cpu(hw_r->fc_num_pkts);
+	r->fc_done_num_pkts = le32_to_cpu(hw_r->fc_done_num_pkts);
+	r->fc_rx_bytes_in_queue = le32_to_cpu(hw_r->fc_rx_bytes_in_queue);
+	r->tc_delim_crc_fail_detected = le32_to_cpu(hw_r->tc_delim_crc_fail_detected);
+	r->lock = le32_to_cpu(hw_r->lock);
+	r->fc_host_ysl_status = le32_to_cpu(hw_r->fc_host_ysl_status);
+
+	tc_total_pkt_count = r->tc_tx_num_pkts + r->tc_cmd_num_pkts +
+			     r->tc_beacon_num_pkts + r->tc_mgmt_num_pkts;
+
+	if (r->tc_delim_crc_fail_detected) {
+		/*
+		 * Host and chip have become desynchronised. This can happen if
+		 * the chip crashes during a YAPS transaction. We cannot
+		 * recover from this.
+		 */
+		dev_err(yaps->mors->dev,
+			"to-chip yaps delimiter CRC fail, pkt_count=%d",
+			tc_total_pkt_count);
+		ret = -EIO;
+	}
+
+	if (mm81x_read_pkts_h_bytes_remaining(yaps))
+		set_bit(MM81X_HIF_EVT_RX_PEND, &yaps->mors->hif.event_flags);
+
+exit_unlock:
+	mm81x_yaps_hw_unlock(yaps);
+	return ret;
+}
+
+static const struct mm81x_yaps_ops mm81x_yaps_hw_ops = {
+	.write_pkts = mm81x_yaps_hw_write_pkts,
+	.read_pkts = mm81x_yaps_hw_read_pkts,
+	.update_status = mm81x_yaps_hw_update_status,
+};
+
+int mm81x_yaps_hw_init(struct mm81x *mors)
+{
+	int ret = 0;
+	struct mm81x_yaps *yaps = NULL;
+	int aux_data_len = sizeof(struct mm81x_yaps_hw_aux_data);
+	int alignment = mm81x_bus_get_alignment(mors);
+
+	yaps = &mors->hif.u.yaps;
+	yaps->aux_data = kzalloc(aux_data_len, GFP_KERNEL);
+	if (!yaps->aux_data) {
+		ret = -ENOMEM;
+		goto err_exit;
+	}
+
+	yaps->aux_data->to_chip_buffer =
+		kzalloc(YAPS_HW_WINDOW_SIZE_BYTES + alignment - 1, GFP_KERNEL);
+	if (!yaps->aux_data->to_chip_buffer) {
+		ret = -ENOMEM;
+		goto err_exit;
+	}
+
+	yaps->aux_data->from_chip_buffer =
+		kzalloc(YAPS_HW_WINDOW_SIZE_BYTES + alignment - 1, GFP_KERNEL);
+	if (!yaps->aux_data->from_chip_buffer) {
+		ret = -ENOMEM;
+		goto err_exit;
+	}
+
+	if (!IS_ALIGNED((uintptr_t)&yaps->aux_data->status_regs, alignment)) {
+		dev_warn(mors->dev,
+			 "Status registers are not aligned to %d bytes",
+			 alignment);
+	}
+
+	yaps->ops = &mm81x_yaps_hw_ops;
+	return ret;
+
+err_exit:
+	mm81x_yaps_hw_finish(mors);
+	return ret;
+}
+
+void mm81x_yaps_hw_finish(struct mm81x *mors)
+{
+	struct mm81x_yaps *yaps;
+
+	yaps = &mors->hif.u.yaps;
+	if (yaps->aux_data) {
+		kfree(yaps->aux_data->from_chip_buffer);
+		yaps->aux_data->from_chip_buffer = NULL;
+		kfree(yaps->aux_data->to_chip_buffer);
+		yaps->aux_data->to_chip_buffer = NULL;
+		kfree(yaps->aux_data);
+		yaps->aux_data = NULL;
+	}
+}
-- 
2.43.0


