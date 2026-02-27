Return-Path: <linux-wireless+bounces-32264-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIoOALwcoWlhqQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32264-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:25:32 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3421B2ABE
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AC5131DB286
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 04:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CED3542CA;
	Fri, 27 Feb 2026 04:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="DH4khm4Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E15534DCF2
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 04:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772165666; cv=none; b=rPz0ZZ68OrKZYeDvsSEmtK/nU9QFnUfQFPSKOD/Wt5dY0bCnI6gRNoS0BWfR6tEyLOdzgd8uVrke0OlJXcyHiQ5Tg7qJvuw9KpATqHhjGgqnRWFwpOjVGsduvsxkrNgXG/z/DE948m3VM5XkJvjhx4GeVqJN6dh+/nYghRDPHF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772165666; c=relaxed/simple;
	bh=8B4ghXoq7ok+C23JuxbofDhYcftBC03C6LASiH4pLiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aK1zEOUZaOn8mjtYFrb0BrFk4GirAPXQWxiKNmM3lLX4S+drhvbrhmX+pN/xOXvI+qeVdlMgJXI6aJs7m0g9sv1UoiSM4hJeKbltONyMogxLKi+jnd+yGq576Z+bKSyAtESKVTYQNbsfKwRghC+FZqo9O2S7QgkKZyk0d1lRkYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=DH4khm4Z; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ada721eda1so7177475ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 20:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1772165664; x=1772770464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pN7m9qJueBxKoQd57mqyl5RqAky+iC+HY9vPH6Ht0Fw=;
        b=DH4khm4ZTGohgBSzDLJatPhZDGHkzOYHPpDQ/IgJVbnmmr/jZpy2+lzcuf000eY6xM
         mxWTYmswJh492RAy9UPvjcA/PQoLOjTWpWAa992rZkwV0aOzRE8dixKNNPJtmsUTfdo4
         ek1cswl6otfqk/ex0dTYLf06DP0fPZy937FOKlJk1+hOUZv5iSyrhpGdSCE9s2HMr1Ov
         iASugXA8cF3Fxp7NsTAI38veJs5GBGD9issKiZlcgml2RlI1Qhl3OrNCTvk1dhif4YJ1
         9UEtrzihrTV87WWZQ9YuFcU4x+pFCl8YapWK4NXwUJE7xjkmETCW9mC2rOXMpZxTZ2OP
         Stew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772165664; x=1772770464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pN7m9qJueBxKoQd57mqyl5RqAky+iC+HY9vPH6Ht0Fw=;
        b=NlWDKfv2RLp7hVru33z2d3k+MvsL4SPZpTvBrUZSF/lOBPMVHY1pa4tA5MCrCaKuOu
         kigop5HQbSnSmgZPPrbiZwXn158hbeW+0PRB4zaTR78OVPNYvkoLLTw92/uPwFbFQ2G8
         ypublLiPGhZ9rcH+CWN1IGc+dUFJdYqACwki4Q9gARvnVruxZHoXhUhZY50z6PMBpBe4
         AdyVUwD31aimLg7CbDrqxLBlFHl7aDTqzc1aV+6xkIg50RyKZzasS2oxG2y2egun8Hzf
         Gn4c9ju5OEMOCOIC6k1taF19+dKrgwAYklnP6dVvlxWMY2U6CJAqm7aa0/RjmFm5QbJ6
         SFeg==
X-Forwarded-Encrypted: i=1; AJvYcCXxTiUFJeOACVdgGMH+3j7limIDbeLSQFuCDW/P9+M/LKBqq3UDc9JHCLjUR12vt3q/bKPBNZZRNaIhWbNdhA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxmOPOPM4ljHuwulX6LrbJhnqB5RpQs7/YCs+FF5cxe7+fElVJ+
	rSg8gMmgjrDvWwTp0k3bdVKSlNWPcOSJ+2xBVpC7oznozvsOTP14nvaQQpWkmHjav8Q=
X-Gm-Gg: ATEYQzy7KdNK8qzz4aOdIiiJlbzydWLPmqooQ0m+GPyTujB4LcUXDuWd41Bcm0drayy
	HmwMBP8BRBpu54Ne2VIvaFZk9GM4I9ThR6R5x/tMReMOfN07qEyGqrBLOi9/zvJ9T3AzEc5sji/
	96D091yaK9fhxGhcA9uhJ6XDG+/kvBi/bMVjL1QdkWNPON9K8c31iyt0j1x9OFIH6Dx6qa+26OK
	D2lDMtYM5I5KBcq9q2/ebjA+SucgQxDS+XBW9dDoGgBxwwk+K9KLG9k1q/bjwB/ubz0QG3Vi3rJ
	N0RpoLJdO2iKa2uIIswyN+N/BT1ibP/RbRfmvJ9v0GnQfia6ztR4TmqI9BvKP8NJtko0/ausuC1
	ZmQ/oP/1LzroV1e5vd21EznpiOmRNOS/JawNG5gMqe6AXqrsSYcuxEG3n4RnVsC/10CKlSK38Z0
	T4mhv4wJolSg4NjrUbvdmT59GtZsRgulHhRVmCrvegyMxWpXf4gBkY4wkST6vFAVe8WniM2GTy5
	JvgbVyVwSG424FXy/GWbMZD/z4EGt0=
X-Received: by 2002:a17:902:cf0b:b0:2a0:9d16:5fb4 with SMTP id d9443c01a7336-2ae2e401db9mr14101225ad.18.1772165664494;
        Thu, 26 Feb 2026 20:14:24 -0800 (PST)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6ba5eesm41682865ad.68.2026.02.26.20.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 20:14:24 -0800 (PST)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next 25/35] wifi: mm81x: add skbq.h
Date: Fri, 27 Feb 2026 15:10:35 +1100
Message-ID: <20260227041108.66508-26-lachlan.hodges@morsemicro.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[morsemicro-com.20230601.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32264-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,morsemicro.com:mid,morsemicro.com:email,morsemicro-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 9C3421B2ABE
X-Rspamd-Action: no action

(Patches split per file for review, see cover letter for more
information)

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 drivers/net/wireless/morsemicro/mm81x/skbq.h | 218 +++++++++++++++++++
 1 file changed, 218 insertions(+)
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/skbq.h

diff --git a/drivers/net/wireless/morsemicro/mm81x/skbq.h b/drivers/net/wireless/morsemicro/mm81x/skbq.h
new file mode 100644
index 000000000000..0ccd1291ac95
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/mm81x/skbq.h
@@ -0,0 +1,218 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2017-2026 Morse Micro
+ */
+
+#ifndef _MM81X_SKBQ_H_
+#define _MM81X_SKBQ_H_
+
+#include <linux/skbuff.h>
+#include <linux/workqueue.h>
+#include "rate_code.h"
+
+/* Sync value of skb header to indicate a valid skb */
+#define MM81X_SKB_HEADER_SYNC (0xAA)
+/* Sync value indicating that the chip owns this skb */
+#define MM81X_SKB_HEADER_CHIP_OWNED_SYNC (0xBB)
+
+enum mm81x_tx_status_and_conf_flags {
+	MM81X_TX_STATUS_FLAGS_NO_ACK = BIT(0),
+	MM81X_TX_STATUS_FLAGS_NO_REPORT = BIT(1),
+	MM81X_TX_CONF_FLAGS_CTL_AMPDU = BIT(2),
+	MM81X_TX_CONF_FLAGS_HW_ENCRYPT = BIT(3),
+	MM81X_TX_CONF_FLAGS_VIF_ID = (BIT(4) | BIT(5) | BIT(6) | BIT(7) |
+				      BIT(8) | BIT(9) | BIT(10) | BIT(11)),
+	MM81X_TX_CONF_FLAGS_KEY_IDX = (BIT(12) | BIT(13) | BIT(14)),
+	MM81X_TX_STATUS_FLAGS_PS_FILTERED = (BIT(15)),
+	MM81X_TX_CONF_IGNORE_TWT = (BIT(16)),
+	MM81X_TX_STATUS_PAGE_INVALID = (BIT(17)),
+	MM81X_TX_CONF_NO_PS_BUFFER = (BIT(18)),
+	MM81X_TX_STATUS_DUTY_CYCLE_CANT_SEND = (BIT(19)),
+	MM81X_TX_CONF_HAS_PV1_BPN_IN_BODY = (BIT(21)),
+	MM81X_TX_CONF_FLAGS_SEND_AFTER_DTIM = (BIT(22)),
+	MM81X_TX_STATUS_WAS_AGGREGATED = (BIT(23)),
+	MM81X_TX_CONF_FLAGS_FULLMAC_REPORT = BIT(24),
+	MM81X_TX_CONF_FLAGS_IMMEDIATE_REPORT = (BIT(31))
+};
+
+/* Getter and setter macros for vif id */
+#define MM81X_TX_CONF_FLAGS_VIF_ID_MASK (0xFF)
+#define MM81X_TX_CONF_FLAGS_VIF_ID_SET(x) \
+	(((x) & MM81X_TX_CONF_FLAGS_VIF_ID_MASK) << 4)
+#define MM81X_TX_CONF_FLAGS_VIF_ID_GET(x) \
+	(((x) & MM81X_TX_CONF_FLAGS_VIF_ID) >> 4)
+
+/* Getter and setter macros for key index */
+#define MM81X_TX_CONF_FLAGS_KEY_IDX_SET(x) (((x) & 0x07) << 12)
+#define MM81X_TX_CONF_FLAGS_KEY_IDX_GET(x) \
+	(((x) & MM81X_TX_CONF_FLAGS_KEY_IDX) >> 12)
+
+enum mm81x_rx_status_flags {
+	MM81X_RX_STATUS_FLAGS_ERROR = BIT(0),
+	MM81X_RX_STATUS_FLAGS_DECRYPTED = BIT(1),
+	MM81X_RX_STATUS_FLAGS_FCS_INCLUDED = BIT(2),
+	MM81X_RX_STATUS_FLAGS_EOF = BIT(3),
+	MM81X_RX_STATUS_FLAGS_AMPDU = BIT(4),
+	MM81X_RX_STATUS_FLAGS_NDP = BIT(7),
+	MM81X_RX_STATUS_FLAGS_UPLINK = BIT(8),
+	MM81X_RX_STATUS_FLAGS_RI = (BIT(9) | BIT(10)),
+	MM81X_RX_STATUS_FLAGS_NDP_TYPE = (BIT(11) | BIT(12) | BIT(13)),
+	MM81X_RX_STATUS_FLAGS_CRC_ERROR = BIT(14),
+	MM81X_RX_STATUS_FLAGS_VIF_ID = GENMASK(24, 17),
+};
+
+/* Getter and Setter macros for vif id */
+#define MM81X_RX_STATUS_FLAGS_VIF_ID_MASK (0xFF)
+#define MM81X_RX_STATUS_FLAGS_VIF_ID_SET(x) \
+	(((x) & MM81X_RX_STATUS_FLAGS_VIF_ID_MASK) << 17)
+#define MM81X_RX_STATUS_FLAGS_VIF_ID_GET(x) \
+	(((x) & MM81X_RX_STATUS_FLAGS_VIF_ID) >> 17)
+#define MM81X_RX_STATUS_FLAGS_VIF_ID_CLEAR(x) \
+	((x) & ~(MM81X_RX_STATUS_FLAGS_VIF_ID_MASK << 17))
+
+/* Getter macro for guard interval */
+#define MM81X_RX_STATUS_FLAGS_UPL_IND_GET(x) \
+	(((x) & MM81X_RX_STATUS_FLAGS_UPLINK) >> 8)
+
+/* Getter macro for response indication */
+#define MM81X_RX_STATUS_FLAGS_RI_GET(x) (((x) & MM81X_RX_STATUS_FLAGS_RI) >> 9)
+
+/* Getter macro for NDP type */
+#define MM81X_RX_STATUS_FLAGS_NDP_TYPE_GET(x) \
+	(((x) & MM81X_RX_STATUS_FLAGS_NDP_TYPE) >> 11)
+
+enum mm81x_skb_channel {
+	MM81X_SKB_CHAN_DATA = 0x0,
+	MM81X_SKB_CHAN_NDP_FRAMES = 0x1,
+	MM81X_SKB_CHAN_DATA_NOACK = 0x2,
+	MM81X_SKB_CHAN_BEACON = 0x3,
+	MM81X_SKB_CHAN_MGMT = 0x4,
+	MM81X_SKB_CHAN_INTERNAL_CRIT_BEACON = 0x80,
+	MM81X_SKB_CHAN_COMMAND = 0xFE,
+	MM81X_SKB_CHAN_TX_STATUS = 0xFF
+};
+
+#define MM81X_SKB_MAX_RATES (4)
+
+struct mm81x_skb_rate_info {
+	mm81x_rate_code_t mm81x_ratecode;
+	u8 count;
+} __packed;
+
+struct mm81x_skb_tx_status {
+	__le32 flags;
+	__le32 pkt_id;
+	u8 tid;
+	u8 channel;
+	__le16 ampdu_info;
+	struct mm81x_skb_rate_info rates[MM81X_SKB_MAX_RATES];
+} __packed;
+
+#define MM81X_TXSTS_AMPDU_INFO_GET_TAG(x) (((x) >> 10) & 0x3F)
+#define MM81X_TXSTS_AMPDU_INFO_GET_LEN(x) (((x) >> 5) & 0x1F)
+#define MM81X_TXSTS_AMPDU_INFO_GET_SUC(x) ((x) & 0x1F)
+
+struct mm81x_skb_tx_info {
+	__le32 flags;
+	__le32 pkt_id;
+	u8 tid;
+	u8 tid_params;
+	u8 mmss_params;
+	u8 padding[1];
+	struct mm81x_skb_rate_info rates[MM81X_SKB_MAX_RATES];
+} __packed;
+
+#define TX_INFO_TID_PARAMS_MAX_REORDER_BUF 0x1f
+#define TX_INFO_TID_PARAMS_AMPDU_ENABLED 0x20
+#define TX_INFO_TID_PARAMS_AMSDU_SUPPORTED 0x40
+#define TX_INFO_TID_PARAMS_USE_LEGACY_BA 0x80
+
+/* Bitmap for MMSS (Minimum MPDU start spacing) parameters
+ * +-----------+-----------+
+ * | Morse     | MMSS set  |
+ * | MMSS      | by S1G cap|
+ * | offset    | IE        |
+ * |-----------|-----------|
+ * |b7|b6|b5|b4|b3|b2|b1|b0|
+ */
+#define TX_INFO_MMSS_PARAMS_MMSS_MASK GENMASK(3, 0)
+#define TX_INFO_MMSS_PARAMS_MMSS_OFFSET_START 4
+#define TX_INFO_MMSS_PARAMS_MMSS_OFFSET_MASK GENMASK(7, 4)
+#define TX_INFO_MMSS_PARAMS_SET_MMSS(x) ((x) & TX_INFO_MMSS_PARAMS_MMSS_MASK)
+#define TX_INFO_MMSS_PARAMS_SET_MMSS_OFFSET(x)            \
+	(((x) << TX_INFO_MMSS_PARAMS_MMSS_OFFSET_START) & \
+	 TX_INFO_MMSS_PARAMS_MMSS_OFFSET_MASK)
+
+struct mm81x_skb_rx_status {
+	__le32 flags;
+	mm81x_rate_code_t mm81x_ratecode;
+	__le16 rssi;
+	__le16 freq_100khz;
+	u8 bss_color;
+	s8 noise_dbm;
+	/** Padding for word alignment */
+	u8 padding[2];
+	__le64 rx_timestamp_us;
+} __packed;
+
+struct mm81x_skb_hdr {
+	u8 sync;
+	u8 channel;
+	__le16 len;
+	u8 offset;
+	u8 checksum_lower;
+	__le16 checksum_upper;
+	union {
+		struct mm81x_skb_tx_info tx_info;
+		struct mm81x_skb_tx_status tx_status;
+		struct mm81x_skb_rx_status rx_status;
+	};
+} __packed;
+
+#define MM81X_SKBQ_SIZE (4 * 128 * 1024)
+
+struct mm81x;
+
+struct mm81x_skbq {
+	struct mm81x *mm;
+	u32 pkt_seq; /* SKB sequence used in tx_status */
+	u16 flags;
+	u32 skbq_size; /* current off loaded size */
+	spinlock_t lock;
+	struct sk_buff_head skbq;
+	struct sk_buff_head pending; /* packets sent pending feedback */
+	struct work_struct dispatch_work;
+};
+
+void mm81x_skbq_purge(struct mm81x_skbq *mq, struct sk_buff_head *skbq);
+void mm81x_skbq_purge_aged(struct mm81x *mm, struct mm81x_skbq *mq);
+u32 mm81x_skbq_space(struct mm81x_skbq *mq);
+u32 mm81x_skbq_size(struct mm81x_skbq *mq);
+int mm81x_skbq_deq_num_skb(struct mm81x_skbq *mq, struct sk_buff_head *skbq,
+			   int num_skb);
+struct sk_buff *mm81x_skbq_alloc_skb(struct mm81x_skbq *mq,
+				     unsigned int length);
+int mm81x_skbq_skb_tx(struct mm81x_skbq *mq, struct sk_buff **skb,
+		      struct mm81x_skb_tx_info *tx_info, u8 channel);
+int mm81x_skbq_put(struct mm81x_skbq *mq, struct sk_buff *skb);
+void mm81x_skbq_enq(struct mm81x_skbq *mq, struct sk_buff_head *skbq);
+void mm81x_skbq_enq_prepend(struct mm81x_skbq *mq, struct sk_buff_head *skbq);
+void mm81x_skbq_tx_complete(struct mm81x_skbq *mq, struct sk_buff_head *skbq);
+struct sk_buff *mm81x_skbq_tx_pending(struct mm81x_skbq *mq);
+void mm81x_skbq_init(struct mm81x *mm, struct mm81x_skbq *mq, u16 flags);
+void mm81x_skbq_finish(struct mm81x_skbq *mq);
+void mm81x_skbq_pull_hdr_post_tx(struct sk_buff *skb);
+void mm81x_skbq_mon_dump(struct mm81x *mm, struct seq_file *file);
+void mm81x_skbq_skb_finish(struct mm81x_skbq *mq, struct sk_buff *skb,
+			   struct mm81x_skb_tx_status *tx_sts);
+void mm81x_skbq_tx_flush(struct mm81x_skbq *mq);
+int mm81x_skbq_check_for_stale_tx(struct mm81x *mm, struct mm81x_skbq *mq);
+void mm81x_skbq_may_wake_tx_queues(struct mm81x *mm);
+u32 mm81x_skbq_count_tx_ready(struct mm81x_skbq *mq);
+u32 mm81x_skbq_count(struct mm81x_skbq *mq);
+u32 mm81x_skbq_pending_count(struct mm81x_skbq *mq);
+void mm81x_skbq_data_traffic_pause(struct mm81x *mm);
+void mm81x_skbq_data_traffic_resume(struct mm81x *mm);
+bool mm81x_skbq_validate_checksum(u8 *data);
+
+#endif /* !_MM81X_SKBQ_H_ */
-- 
2.43.0


