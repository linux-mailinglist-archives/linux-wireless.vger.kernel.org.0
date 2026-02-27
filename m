Return-Path: <linux-wireless+bounces-32268-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CE3IBXgboWlhqQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32268-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:20:08 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AB17B1B29AD
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F3D733075CF0
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 04:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C23A346773;
	Fri, 27 Feb 2026 04:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="OUYpJf2F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8334D347FE3
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 04:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772165692; cv=none; b=tOI+1ZURW9KMSsLisvLCv6UPSinNXcZJGSUdk+9RStJDV8K2MsXYES1/IQPHsy3zvWXLdqd5abNEq/usxLpYe0S5XrtbeA9EF9rOeTFAUXsN4CE7mcHCASmoF3k1WZB6J1OLSF2qLQDkY/kjhRAuLyO3QAhz3vI9egJDKfV7WYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772165692; c=relaxed/simple;
	bh=/veuNcEsl77Ej2yRT55uWlm82sFLKFIr3InyYPPpOT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hEEStagBOV+Ph2wVY309WImijqGacS1UCXcKpDyz/zAHlR13JAIJEXCTVg0WxiR0XjugjLpxK3vHNTQ3Igeb1KhUx97X8i511ts+UiRhOLrW6U/PSutyx2nbz115rLiXIsBYeRphlL/y129c5ZOS+y43nEpd4NvNZTXG6D2bSXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=OUYpJf2F; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ade1806c28so9817095ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 20:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1772165690; x=1772770490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=apgcYgGwBg1k+6TL5ZyRcYFilrb6pdqHm0LYgSaQdC8=;
        b=OUYpJf2FqoJYKF6+cQ8UuHR6fbCRrNWkZs57PRjI7XJdS9wfHyGf93pZcjby40XCJn
         6H6QpH21Z4by9iPmJcjM2ouIVDe+2QhKgQEoZtr7CMw4Fri8hV/0nDluJScHX0RTwU4e
         FcEfpfOtmxNjJK4k/RhHfjKZvse/4dCNcEtsnDIw+/yqaQkgs1pia1LqWRPoI2DLRTGW
         v+eB94WYZmlnYuv0HAJUtCAB9QD4Z/lYPe9itsKgId1txsqPH8ESBHWSY4nz0J16OS/+
         U8Wcvde3/Zcj6D67TU4hNGTN/dIm57AraUawT52hetUKZofvJUb/UWNP2QKYrSc/KjJN
         3wzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772165690; x=1772770490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=apgcYgGwBg1k+6TL5ZyRcYFilrb6pdqHm0LYgSaQdC8=;
        b=Jb/sUNNGsHl8gsOlFYW4etNROhPf4omV6TaufcoWapPhU+CuK+h3iVG1kiUvX/bMGT
         +4VmcH3u28jBootsZ4LhyWbGbvHHH7jeG+5Ol9CyGlt5s4oJF5Zft5InnwdVShrYI2Qp
         0eV6s001nHgno7F2ye9Ga9pcIfE2IU1Gr2zUOfLw0SHZCLx2aRnyYNa56OdsVIXjBkl5
         6OU6MB3hkZ8xzrd8U/GBh9E+oXkn3WmbgkXZ5N3OJcgq1txGAVUsNtw+mrQWQulhZBX6
         T9bSHqmQdA1FFL6ZggxDiI59nop7ivQUk5qekbJIDhQEdEcsTL5Nb0zEFA17vBm5euwZ
         W6Ug==
X-Forwarded-Encrypted: i=1; AJvYcCXSffbXoydAJy1PSbWn1B2cVoJSKTqJKWb1Q/clWrTPovQNS7VEYOf2kYg6RMyM0FVPQFG8G3xgxV82nV/5iA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhYH2lY3m+WJ32H6pm6s3e4ZTMCxfHIEPf1GxxxGJFMN6XLnxa
	LPX3ONcJQR0cymTQTTpgC7aLFEoDF5qAILV/WzRMfw6mP7lzsl3nMm9Hq8PEvmJH3Ec=
X-Gm-Gg: ATEYQzwsN62STCAu4FIUNRpsaVTQl8AhQVprO3Ir3lmJV7ztz1GJmjdHdy0PyYqU8fA
	g7RtMr1+gbgsIF5ly89DxPtZ+m5ul1jVp44Gfd/I9vTes6nRGCvmx+jP5Wbc5dYy42gip4H3dsz
	uEfFPl6jy79jesM5P9Nx4PWAYKumCJ5l2BmoI8OPEmuNmR/0sO46eNWbEUCnDK2Pes+gxQNZ92x
	3MW0O/8lZJRYuWtU2vJlMBOHIAhmH1wVJR2PmTo1bnRDPVHvi4GtDOTTnf+DKYleTiRjsmd4M+G
	HOdRFOg6GzHtzZcAzsAcK5BHmTyewoLeCA757MOtoUe92SMDZllQluTEVcAGEQd6hzn5vge8fMF
	bOo8CmohqDJebgBWu1vO6VFnpQ4b8h07BMbfg82pQbOW7Ii9gSi7faHNxkyhRJwXxgNedmdPm2i
	oJQ8yuaBa0maISOnR3VD/xgQv1+E4nQUFi2nroAMpNTdgaedRILJlQyvaaaSNZ+EXJunh4apFX8
	GcNjYwrzRCFfrSdtXHheNW01Sscr2U=
X-Received: by 2002:a17:903:2442:b0:2ad:bdc2:e053 with SMTP id d9443c01a7336-2ae2e40a197mr12684295ad.20.1772165689747;
        Thu, 26 Feb 2026 20:14:49 -0800 (PST)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6ba5eesm41682865ad.68.2026.02.26.20.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 20:14:49 -0800 (PST)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next 29/35] wifi: mm81x: add yaps_hw.c
Date: Fri, 27 Feb 2026 15:10:39 +1100
Message-ID: <20260227041108.66508-30-lachlan.hodges@morsemicro.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[morsemicro-com.20230601.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32268-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[morsemicro.com:mid,morsemicro.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,morsemicro-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: AB17B1B29AD
X-Rspamd-Action: no action

(Patches split per file for review, see cover letter for more
information)

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 .../net/wireless/morsemicro/mm81x/yaps_hw.c   | 683 ++++++++++++++++++
 1 file changed, 683 insertions(+)
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/yaps_hw.c

diff --git a/drivers/net/wireless/morsemicro/mm81x/yaps_hw.c b/drivers/net/wireless/morsemicro/mm81x/yaps_hw.c
new file mode 100644
index 000000000000..6601faa8b38b
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/mm81x/yaps_hw.c
@@ -0,0 +1,683 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2017-2026 Morse Micro
+ */
+#include "yaps_hw.h"
+#include "bus.h"
+#include "debug.h"
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
+struct mm81x_yaps_hw_status_registers {
+	/* Allocation pools */
+	u32 tc_tx_pool_num_pages;
+	u32 tc_cmd_pool_num_pages;
+	u32 tc_beacon_pool_num_pages;
+	u32 tc_mgmt_pool_num_pages;
+	u32 fc_rx_pool_num_pages;
+	u32 fc_resp_pool_num_pages;
+	u32 fc_tx_sts_pool_num_pages;
+	u32 fc_aux_pool_num_pages;
+
+	/* To chip/From chip queues for YDS/YSL */
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
+	/* Status registers for queues and aloc pools on chip */
+	struct mm81x_yaps_hw_status_registers status_regs;
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
+void mm81x_yaps_hw_enable_irqs(struct mm81x *mm, bool enable)
+{
+	mm81x_hw_irq_enable(mm, MM81X_INT_YAPS_FC_PKT_WAITING_IRQN, enable);
+	mm81x_hw_irq_enable(mm, MM81X_INT_YAPS_FC_PACKET_FREED_UP_IRQN, enable);
+}
+
+void mm81x_yaps_hw_read_table(struct mm81x *mm,
+			      struct mm81x_yaps_hw_table *tbl_ptr)
+{
+	mm81x_yaps_hw_fill_aux_data_from_hw_tbl(mm->hif.u.yaps.aux_data,
+						tbl_ptr);
+	mm81x_yaps_hw_enable_irqs(mm, true);
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
+		mm81x_err(yaps->mm, "yaps invalid tc queue");
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
+	if (pkt->tc_queue > MM81X_YAPS_NUM_TC_Q)
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
+			  mm81x_bus_get_alignment(yaps->mm));
+	char *write_buf = to_chip_buffer_aligned;
+
+	ret = mm81x_yaps_hw_lock(yaps);
+	if (ret) {
+		mm81x_dbg(yaps->mm, MM81X_DBG_ANY, "yaps lock failed %d", ret);
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
+			ret = mm81x_dm_write(yaps->mm, yaps->aux_data->yds_addr,
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
+		ret = mm81x_dm_write(yaps->mm, yaps->aux_data->yds_addr,
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
+			  mm81x_bus_get_alignment(yaps->mm));
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
+		mm81x_dbg(yaps->mm, MM81X_DBG_ANY, "yaps lock failed %d", ret);
+		return ret;
+	}
+
+	/* Read all available packets to the buffer */
+	ret = mm81x_dm_read(yaps->mm, yaps->aux_data->ysl_addr,
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
+			mm81x_warn(yaps->mm, "yaps invalid delim");
+			break;
+		}
+
+		/* Total length in chip */
+		pkt_size = YAPS_DELIM_GET_PKT_SIZE(delim);
+		total_len = pkt_size + YAPS_DELIM_GET_PADDING(delim);
+
+		if (pkts[i].skb)
+			mm81x_err(yaps->mm, "yaps packet leak");
+
+		/* SKB doesn't want padding */
+		pkts[i].skb = dev_alloc_skb(pkt_size);
+		if (!pkts[i].skb) {
+			ret = -ENOMEM;
+			mm81x_err(yaps->mm, "yaps no mem for skb");
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
+				yaps->mm,
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
+
+	struct mm81x_yaps_hw_status_registers *r = &yaps->aux_data->status_regs;
+
+	ret = mm81x_yaps_hw_lock(yaps);
+	if (ret) {
+		mm81x_dbg(yaps->mm, MM81X_DBG_ANY, "yaps lock failed %d", ret);
+		return ret;
+	}
+
+	reg_read_timeout = jiffies + msecs_to_jiffies(100);
+	do {
+		if (time_after(jiffies, reg_read_timeout)) {
+			mm81x_err(yaps->mm,
+				  "timed out reading status registers: %d",
+				  ret);
+			ret = -ETIMEDOUT;
+			break;
+		}
+
+		ret = mm81x_dm_read(yaps->mm, yaps->aux_data->status_regs_addr,
+				    (u8 *)r, sizeof(*r));
+	} while (!ret && r->lock);
+
+	if (ret) {
+		if (ret != -ENODEV) {
+			mm81x_err(yaps->mm,
+				  "error reading yaps status registers: %d",
+				  ret);
+		}
+		goto exit_unlock;
+	}
+
+	r->tc_tx_pool_num_pages = mm81x_fle32_to_cpu(r->tc_tx_pool_num_pages);
+	r->tc_cmd_pool_num_pages = mm81x_fle32_to_cpu(r->tc_cmd_pool_num_pages);
+	r->tc_beacon_pool_num_pages =
+		mm81x_fle32_to_cpu(r->tc_beacon_pool_num_pages);
+	r->tc_mgmt_pool_num_pages =
+		mm81x_fle32_to_cpu(r->tc_mgmt_pool_num_pages);
+	r->fc_rx_pool_num_pages = mm81x_fle32_to_cpu(r->fc_rx_pool_num_pages);
+	r->fc_resp_pool_num_pages =
+		mm81x_fle32_to_cpu(r->fc_resp_pool_num_pages);
+	r->fc_tx_sts_pool_num_pages =
+		mm81x_fle32_to_cpu(r->fc_tx_sts_pool_num_pages);
+	r->fc_aux_pool_num_pages = mm81x_fle32_to_cpu(r->fc_aux_pool_num_pages);
+	r->tc_tx_num_pkts = mm81x_fle32_to_cpu(r->tc_tx_num_pkts);
+	r->tc_cmd_num_pkts = mm81x_fle32_to_cpu(r->tc_cmd_num_pkts);
+	r->tc_beacon_num_pkts = mm81x_fle32_to_cpu(r->tc_beacon_num_pkts);
+	r->tc_mgmt_num_pkts = mm81x_fle32_to_cpu(r->tc_mgmt_num_pkts);
+	r->fc_num_pkts = mm81x_fle32_to_cpu(r->fc_num_pkts);
+	r->fc_done_num_pkts = mm81x_fle32_to_cpu(r->fc_done_num_pkts);
+	r->fc_rx_bytes_in_queue = mm81x_fle32_to_cpu(r->fc_rx_bytes_in_queue);
+	r->tc_delim_crc_fail_detected =
+		mm81x_fle32_to_cpu(r->tc_delim_crc_fail_detected);
+	r->lock = mm81x_fle32_to_cpu(r->lock);
+	r->fc_host_ysl_status = mm81x_fle32_to_cpu(r->fc_host_ysl_status);
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
+		mm81x_err(yaps->mm,
+			  "to-chip yaps delimiter CRC fail, pkt_count=%d",
+			  tc_total_pkt_count);
+		ret = -EIO;
+	}
+
+	if (mm81x_read_pkts_h_bytes_remaining(yaps))
+		set_bit(MM81X_HIF_EVT_RX_PEND, &yaps->mm->hif.event_flags);
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
+int mm81x_yaps_hw_init(struct mm81x *mm)
+{
+	int ret = 0;
+	struct mm81x_yaps *yaps = NULL;
+	int aux_data_len = sizeof(struct mm81x_yaps_hw_aux_data);
+	int alignment = mm81x_bus_get_alignment(mm);
+
+	yaps = &mm->hif.u.yaps;
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
+		mm81x_warn(mm, "Status registers are not aligned to %d bytes",
+			   alignment);
+	}
+
+	yaps->ops = &mm81x_yaps_hw_ops;
+	return ret;
+
+err_exit:
+	mm81x_yaps_hw_finish(mm);
+	return ret;
+}
+
+void mm81x_yaps_hw_finish(struct mm81x *mm)
+{
+	struct mm81x_yaps *yaps;
+
+	yaps = &mm->hif.u.yaps;
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


