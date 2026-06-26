Return-Path: <linux-wireless+bounces-38137-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LirQHeAdPmoQAAkAu9opvQ
	(envelope-from <linux-wireless+bounces-38137-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 08:36:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 120486CAADB
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 08:36:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=morsemicro-com.20251104.gappssmtp.com header.s=20251104 header.b="mt/Gx6m8";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38137-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38137-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=morsemicro.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C78123046E2B
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 06:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF973DCDA6;
	Fri, 26 Jun 2026 06:33:11 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0373DCD9B
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 06:33:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782455591; cv=none; b=ZaqI/7QJhqXkgKLMZFVoTH52+QAGmNsQd0SjuVTX1ap/2u4rsvOtaOwIVipQzT7h1mC6uPP09s7dmfIrnbdF4XedTai50+aFXvNeAhwI6UKUcP5fTdtSecQFfw+sJkcR+LcLUi4tjHNuxj84nqnrf+CxtJCRFUhXflQDp/NLrHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782455591; c=relaxed/simple;
	bh=H4S4Vyzaexfx1ebghr+0pinXB2Moyt67SAIpt7j0AWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UHLAs4JGhbl+KyHcKP/2kO2An2mqbURi4TB50JgCvLQAaA97zAMVMCPYhweRv8adUVW76trRCj+34GQofIgHf9y7hWqHI9nzkPcNe3b2Za/kn39GQBhk3nmPFvwJwTLvxKPgm+qXeDxJNhL4O8Jc/Gt8wk9q+nVjIBvD6kF89HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=mt/Gx6m8; arc=none smtp.client-ip=74.125.82.49
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1384ebe7a10so345205c88.1
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 23:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1782455588; x=1783060388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJnpO92li0kE+uWjGB7SHe7DGm1rsXTxY86XjNmpcH8=;
        b=mt/Gx6m86sd813XtQm1KaZ27dljDhbaxtl9YWFJAe3+B0YiFbdc88wbV9JO+j+6+0t
         iO+hXsMlwF1Na+ePZQYkmvs6Kg2UhFuw/lYdamBATmEdT7H5UdxhR5PJ3MuKX5ECsweO
         dDqY1Muqwi4CmZ3x2sYmVZaPBZhZmxMi+IWfm3t8BqJcPCQNGAFIPeLovCV9nf4TgOWl
         ugU9nkFiBJmzjUWEosUEO7ktaWEIcpY8iupMjKKXiIZZJF48Gk5MWWIkc+VqDf2YO8QA
         U0x8YMy7ZWi1j+QyBWgciHZxZ4cAILMBi8CvR51NR8XRsAdrZmHcOLbKFiEI+9srT4Ca
         GXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782455588; x=1783060388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oJnpO92li0kE+uWjGB7SHe7DGm1rsXTxY86XjNmpcH8=;
        b=jU0tNTFxh6izRgnpsKRthmQD+T0nuD15LLB+vNFCIohrwcWYkE3XwyRAxtk41ZqpZE
         r844PHB9nCl4a5LACrqDKmdWUqP+3FSn+rFe05Sw+quE16cg2xAF1KSuk+0ofXm50RxC
         66TaTrgavgbdZy3i3ByO1A1M9auNNZpUzEbkwtATJhOVLD9JYqXP4O62xKjvo5OWDK8B
         /mUBTnOhKdYp6HzQ0KBfOvemTL+vc27jxBrFganQnybkEV454nNO2c7ONr6WNk5dpbb2
         ZKicgzofyjeZuJa2BIlQSv/WxHXBsV0scnDLwyHsbRbv1GzTeQcOPfVF0fz5NoAxWgAc
         JDeQ==
X-Forwarded-Encrypted: i=1; AFNElJ9IjmKzAYMftfbUIScrHmBX2A345/2q7aMYtuwY/o3dkdfLSmSjZ74SmRjdrfG1KJFetl64MB14sXWqTd4NNA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+kyk2EJ0BatcKVXG1bzCg4BUz5A4HY+Ffr2ccTPiRaIrZ/H0H
	L7WaVLBu/izvNegRNKVrTAhI81pUkn3xpkubth5rq2hi3PG0/qgFkiFvGcWaadvLxMo=
X-Gm-Gg: AfdE7clk0zj/1M3qh1f106SM+AMOb9EBUU43nmYFDm8KcJSaQlno25RppQxoJyEjD8D
	6wlabVm0/Y9CuXKvRij+NYxlgKg4Z0lRbs0thLL9pPKxSveOzR8MVk5Escsw4HEpeNvSa/YMsY2
	iPv1Q0mQtI9knCUtkH8B3Rdvu5mEjLj6lTuDztuHulpkI9nQ13ldyWONRXypTK8jzUwvDs5Y0hh
	SLtD3oDz/S9Oi1meQ6gQHpyp/cVKgw15qEL9Wlw3g++Ie2y0b7McWpsTXeRDgA+d9psC8d78y6D
	ivM9erdbIqZufj+4vh4kdiCGiCy3/yhA6Gip8mDAQJhlHaSzoWc+fuJ3+fj5QAhR3f54/GvaS2W
	W6vkKz+wlsbS4AcUKjMJn+8v24/00ajFabveeDXhNLtQ0HLg/06SDJVm/crQgg2esdVHApmYGcG
	CA6lTeAP8h3T8gMETras9hFRXZxDUYJdSkTnQyQyZKXRkc2T0ICpqAGCSQYKgTXYRgRcPZpLg2/
	U+3Z9pVbLEvuIWb3SiX
X-Received: by 2002:a05:7022:7f15:b0:139:819b:3b86 with SMTP id a92af1059eb24-139dbb6ace5mr3296307c88.32.1782455587858;
        Thu, 25 Jun 2026 23:33:07 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d91006bcsm15463687c88.13.2026.06.25.23.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 23:33:07 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next v3 26/33] wifi: mm81x: add skbq.h
Date: Fri, 26 Jun 2026 16:29:22 +1000
Message-ID: <20260626063014.1275235-27-lachlan.hodges@morsemicro.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-38137-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:lachlan.hodges@morsemicro.com,m:dan.callaghan@morsemicro.com,m:arien.judge@morsemicro.com,m:ayman.grais@morsemicro.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,morsemicro.com:email,morsemicro.com:mid,morsemicro.com:from_mime,morsemicro-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 120486CAADB

(Patches split per file for review, will be a single commit alongside
SDIO ids once review is complete. See cover letter for more
information)

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 drivers/net/wireless/morsemicro/mm81x/skbq.h | 218 +++++++++++++++++++
 1 file changed, 218 insertions(+)
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/skbq.h

diff --git a/drivers/net/wireless/morsemicro/mm81x/skbq.h b/drivers/net/wireless/morsemicro/mm81x/skbq.h
new file mode 100644
index 000000000000..9930493141cf
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
+	struct mm81x *mors;
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
+void mm81x_skbq_purge_aged(struct mm81x *mors, struct mm81x_skbq *mq);
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
+void mm81x_skbq_init(struct mm81x *mors, struct mm81x_skbq *mq, u16 flags);
+void mm81x_skbq_finish(struct mm81x_skbq *mq);
+void mm81x_skbq_pull_hdr_post_tx(struct sk_buff *skb);
+void mm81x_skbq_mon_dump(struct mm81x *mors, struct seq_file *file);
+void mm81x_skbq_skb_finish(struct mm81x_skbq *mq, struct sk_buff *skb,
+			   struct mm81x_skb_tx_status *tx_sts);
+void mm81x_skbq_tx_flush(struct mm81x_skbq *mq);
+int mm81x_skbq_check_for_stale_tx(struct mm81x *mors, struct mm81x_skbq *mq);
+void mm81x_skbq_may_wake_tx_queues(struct mm81x *mors);
+u32 mm81x_skbq_count_tx_ready(struct mm81x_skbq *mq);
+u32 mm81x_skbq_count(struct mm81x_skbq *mq);
+u32 mm81x_skbq_pending_count(struct mm81x_skbq *mq);
+void mm81x_skbq_data_traffic_pause(struct mm81x *mors);
+void mm81x_skbq_data_traffic_resume(struct mm81x *mors);
+bool mm81x_skbq_validate_checksum(u8 *data);
+
+#endif /* !_MM81X_SKBQ_H_ */
-- 
2.43.0


