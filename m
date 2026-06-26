Return-Path: <linux-wireless+bounces-38139-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XIb7LdoePmpCAAkAu9opvQ
	(envelope-from <linux-wireless+bounces-38139-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 08:40:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E72F6CAB47
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 08:40:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=morsemicro-com.20251104.gappssmtp.com header.s=20251104 header.b=y4y8ptyT;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38139-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38139-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=morsemicro.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F0BE730D695F
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 06:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01443DCDB8;
	Fri, 26 Jun 2026 06:33:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55743DCDAD
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 06:33:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782455603; cv=none; b=pzsXHs7E/1x+XtL5/CuNDjuNcf1NfoR3ZQ8xH1j9i+abU+s+YkCMgjLeiiUFAGV6qnxCq/lmu7teYQHdDr7B4oRCsCerrYLx0+KCZgZtASyvXl8kqFEJhO4Za9dU3ybj2Vwhxhuu8AIZ2vrj2vTaUvbfOcJZHWHnteiRuWlUDvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782455603; c=relaxed/simple;
	bh=Nh5hXJoerSsK3BOh/Ru0guiWLdzTWqDIKxg4OqedMZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tvb7NbTC4+7n1rAgcYV3/fJFa5/yKKMeNhzIFpwedpOdCD5/bgS39Qoh4VFUw4uXE45VHjIePDBhMVk+ZElMf4WVeEXSAKnwxo0pg0kHHHczUdm685TKa/cJXE9LqNzw70DzI6RjKBb/crpU+uCLdgvEBfzfJtL1Ah0WJ3VyXNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=y4y8ptyT; arc=none smtp.client-ip=74.125.82.49
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-13986d61b4eso1857517c88.0
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 23:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1782455601; x=1783060401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OyRu9KHMZPbieykMCRAUuGbTAxlO2AxWOXQ8oChrQ9s=;
        b=y4y8ptyT5FFUg2iwICMautJ9OE9rS+JI+loHRcQ6kRdiiGEQMJNkG/PdAEpWP+IIKd
         chM4/fEjf8+6XUi6x076hIDrBMMzstgjslXquvZaxNRfRisQkKqlxlzwO93qmxd+nq81
         mdEvcOG/Mn7jfuVGhE958VRIYEFDNDRHZYVgDA9Iv3NEmCyP7A6kSdy9o63yrHKKFMeI
         Zu4UMdBTLqQfgUzs834LSVvOFf2MsE384P3Y523GjO20FeucBKTA80vfSHGnNfZHfcdt
         OdeIBV6rTqTpU1XUCk9V24wJko8wh9A7cv5ksTHRq5jjagUQNmLRg2GfDrQFDJpfd1ew
         79Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782455601; x=1783060401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OyRu9KHMZPbieykMCRAUuGbTAxlO2AxWOXQ8oChrQ9s=;
        b=QiKUSrKFDaefATjwLWxMDKdGY0YTm60gYuTQnaZTVrD+0SHraxL4uHsGIBzY6oHDIm
         PcSJc42mtiVg0WeL6iSGJ/FPIbtJC3wqyjErdd8o4q+otBwp/raNWHXtjrYMtvka7FHX
         5vQ4sjgmMtSKnu33iAGEIX9NR+c05kvNLaaj6uUrDkoGXJioJg570P1HVSjRw5zJqc9L
         MXA6DnSDCXS+1ClQsurfIWCPTmIcXnDFLsMFtaJTnNKPwBFhxrm1MsZuTMdunOr+vJfZ
         51I5qJKs+THHWiZGoVtExgsrbxZkMC7MB4rau5FXc6J9DC9Mv07Fq7HkV+slE0hGQ2ca
         hngw==
X-Forwarded-Encrypted: i=1; AFNElJ8v13qpWMnZ0WxJ1cTsIGtlS+9uaepxBCqG35OhFWpeDR0GbMMEajBHC9/eWwx7l9X9ah7+527khQEb0fT6OA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwqyCj8tBpfGUYVKxZ7xC/jgbkaWJy1OjWv/QKfv9phdJdseyov
	QmeVyUd8/Iv15ogcJbjl2hB5ryonbxS0/INLsfh//kudmlSwI4IL3PrszOO0KoX7owiYbnweklM
	aA6iMJxM=
X-Gm-Gg: AfdE7cmv1Lsv+qVKMwx/JNLDoG26Twvz1GKbn+aM72EKobgrsK14N9LWkSBmOAy/SgJ
	DerhxoOF6tEGWRxz4CpRlnavQYnFiHjQRlqdqzKfNLT7kQh1zdONMJhbJunV2qIpXZv66OzmvZ0
	rwgy4FWyWNvOKRmN9J/B0CMDuJZIBUo0QEFB92H8/2i0lo/dg97hZX0tuOk0OryyxNhFTFHBsIW
	mp3rU2XivTfrpOkW5sFZ86f3dqtTco+v6dJj9hD8bM+tmhWwVFOYVQkfv630BwA5JYymAG+mGza
	LJM0J0Ht1CtreoULM+vS5RSpBLqZwi1P931T8jNfDACSVLvX9IytCkl39eemaJ3h5aMNuxEAlwD
	L5Jqco0YBNdBCN1DGFVwNOr+G1Cynha602Y/blGep7WJNUblX9BKWwNN8HYJ4SPiLIaQTiyXdCh
	Mnmlt9Rb5QwT3Jy+QuFz+mhAMdsVgMY5u2taQjxZQpKZzoyC7F5eKGo5Xv8EC8B9skV8S1aY9Oc
	u6WTxVfqWQW5bjvDPJY
X-Received: by 2002:a05:7022:1b08:b0:139:ce50:9ec7 with SMTP id a92af1059eb24-139dbaabc83mr5051041c88.6.1782455600898;
        Thu, 25 Jun 2026 23:33:20 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d91006bcsm15463687c88.13.2026.06.25.23.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 23:33:20 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next v3 28/33] wifi: mm81x: add yaps.c
Date: Fri, 26 Jun 2026 16:29:24 +1000
Message-ID: <20260626063014.1275235-29-lachlan.hodges@morsemicro.com>
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
	TAGGED_FROM(0.00)[bounces-38139-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,morsemicro.com:email,morsemicro.com:mid,morsemicro.com:from_mime,morsemicro-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6E72F6CAB47

(Patches split per file for review, will be a single commit alongside
SDIO ids once review is complete. See cover letter for more
information)

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 drivers/net/wireless/morsemicro/mm81x/yaps.c | 704 +++++++++++++++++++
 1 file changed, 704 insertions(+)
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/yaps.c

diff --git a/drivers/net/wireless/morsemicro/mm81x/yaps.c b/drivers/net/wireless/morsemicro/mm81x/yaps.c
new file mode 100644
index 000000000000..bdadb822bf9a
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/mm81x/yaps.c
@@ -0,0 +1,704 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2017-2026 Morse Micro
+ */
+#include <linux/gpio.h>
+#include <linux/random.h>
+#include <linux/timer.h>
+#include <linux/bitops.h>
+#include <linux/slab.h>
+#include "hif.h"
+#include "ps.h"
+#include "bus.h"
+#include "command.h"
+#include "skbq.h"
+
+/* This is a fail safe timeout */
+#define CHIP_FULL_RECOVERY_TIMEOUT_MS 30
+
+/* Defined as the max number of MPDUs per AMPDU */
+#define MAX_PKTS_PER_TX_TXN 16
+#define MAX_PKTS_PER_RX_TXN 32
+
+static int mm81x_yaps_alloc_pkt_buffers(struct mm81x_yaps *yaps)
+{
+	yaps->hw.to_chip_pkts = kcalloc(MAX_PKTS_PER_TX_TXN,
+					sizeof(*yaps->hw.to_chip_pkts),
+					GFP_KERNEL);
+	if (!yaps->hw.to_chip_pkts)
+		return -ENOMEM;
+
+	yaps->hw.from_chip_pkts = kcalloc(MAX_PKTS_PER_RX_TXN,
+					  sizeof(*yaps->hw.from_chip_pkts),
+					  GFP_KERNEL);
+	if (!yaps->hw.from_chip_pkts) {
+		kfree(yaps->hw.to_chip_pkts);
+		yaps->hw.to_chip_pkts = NULL;
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void mm81x_yaps_free_pkt_buffers(struct mm81x_yaps *yaps)
+{
+	kfree(yaps->hw.from_chip_pkts);
+	yaps->hw.from_chip_pkts = NULL;
+	kfree(yaps->hw.to_chip_pkts);
+	yaps->hw.to_chip_pkts = NULL;
+}
+
+static int mm81x_yaps_write_pkts(struct mm81x_yaps *yaps,
+				 struct mm81x_yaps_pkt *pkts, int num_pkts,
+				 int *num_pkts_sent)
+{
+	return yaps->ops->write_pkts(yaps, pkts, num_pkts, num_pkts_sent);
+}
+
+static int mm81x_yaps_read_pkts(struct mm81x_yaps *yaps,
+				struct mm81x_yaps_pkt *pkts, int num_pkts_max,
+				int *num_pkts_received)
+{
+	return yaps->ops->read_pkts(yaps, pkts, num_pkts_max,
+				    num_pkts_received);
+}
+
+static int mm81x_yaps_update_status(struct mm81x_yaps *yaps)
+{
+	return yaps->ops->update_status(yaps);
+}
+
+/* Mappings between sk_buff, skbq and yaps */
+static struct mm81x_skbq *mm81x_yaps_tc_q_from_aci(struct mm81x *mors, int aci)
+{
+	struct mm81x_yaps *yaps = &mors->hif.u.yaps;
+
+	if (aci >= ARRAY_SIZE(yaps->data_tx_qs))
+		return NULL;
+	return &yaps->data_tx_qs[aci];
+}
+
+static void mm81x_yaps_get_tx_qs(struct mm81x *mors, struct mm81x_skbq **qs,
+				 int *num_qs)
+{
+	*qs = mors->hif.u.yaps.data_tx_qs;
+	*num_qs = YAPS_TX_SKBQ_MAX;
+}
+
+static struct mm81x_skbq *mm81x_yaps_get_bcn_tc_q(struct mm81x *mors)
+{
+	return &mors->hif.u.yaps.beacon_q;
+}
+
+static struct mm81x_skbq *mm81x_yaps_get_mgmt_tc_q(struct mm81x *mors)
+{
+	return &mors->hif.u.yaps.mgmt_q;
+}
+
+static struct mm81x_skbq *mm81x_yaps_get_tx_cmd_queue(struct mm81x *mors)
+{
+	return &mors->hif.u.yaps.cmd_q;
+}
+
+static int mm81x_yaps_irq_handler(struct mm81x *mors, u32 status)
+{
+	if (status & BIT(MM81X_INT_YAPS_FC_PKT_WAITING_IRQN))
+		set_bit(MM81X_HIF_EVT_RX_PEND, &mors->hif.event_flags);
+
+	if (status & BIT(MM81X_INT_YAPS_FC_PACKET_FREED_UP_IRQN)) {
+		timer_delete_sync_try(&mors->hif.u.yaps.chip_queue_full.timer);
+		set_bit(MM81X_HIF_EVT_TX_PACKET_FREED_UP_PEND,
+			&mors->hif.event_flags);
+	}
+
+	queue_work(mors->chip_wq, &mors->hif_work);
+	return 0;
+}
+
+const struct mm81x_hif_ops mm81x_yaps_ops = {
+	.init = mm81x_yaps_init,
+	.flush_tx_data = mm81x_yaps_flush_tx_data,
+	.flush_cmds = mm81x_yaps_flush_cmds,
+	.get_tx_status_pending_count = mm81x_yaps_get_tx_status_pending_count,
+	.get_tx_buffered_count = mm81x_yaps_get_tx_buffered_count,
+	.finish = mm81x_yaps_finish,
+	.skbq_get_tx_qs = mm81x_yaps_get_tx_qs,
+	.get_tx_beacon_queue = mm81x_yaps_get_bcn_tc_q,
+	.get_tx_mgmt_queue = mm81x_yaps_get_mgmt_tc_q,
+	.get_tx_cmd_queue = mm81x_yaps_get_tx_cmd_queue,
+	.get_tx_data_queue = mm81x_yaps_tc_q_from_aci,
+	.handle_irq = mm81x_yaps_irq_handler
+};
+
+static int mm81x_yaps_read_pkt(struct mm81x_yaps *yaps, struct sk_buff *skb)
+{
+	struct mm81x *mors = yaps->mors;
+	struct sk_buff_head skbq;
+	struct mm81x_skbq *mq = NULL;
+	struct mm81x_skb_hdr *hdr;
+	int skb_bytes_remaining;
+	int skb_len;
+	int ret = 0;
+
+	if (!skb) {
+		ret = -EINVAL;
+		goto exit_return_page;
+	}
+
+	__skb_queue_head_init(&skbq);
+
+	hdr = (struct mm81x_skb_hdr *)skb->data;
+	if (hdr->sync != MM81X_SKB_HEADER_SYNC) {
+		dev_err(mors->dev, "sync value error [0xAA:%d], hdr.len %d",
+			hdr->sync, hdr->len);
+		ret = -EIO;
+		goto exit_return_page;
+	}
+
+	if (yaps->mors->hif.validate_skb_checksum &&
+	    !mm81x_skbq_validate_checksum(skb->data)) {
+		dev_dbg(yaps->mors->dev,
+			"SKB checksum is invalid hdr:[c:%02X s:%02X len:%d]",
+			hdr->channel, hdr->sync, hdr->len);
+
+		if (hdr->channel != MM81X_SKB_CHAN_TX_STATUS) {
+			ret = -EIO;
+			goto exit;
+		}
+	}
+
+	switch (hdr->channel) {
+	case MM81X_SKB_CHAN_DATA:
+	case MM81X_SKB_CHAN_NDP_FRAMES:
+	case MM81X_SKB_CHAN_TX_STATUS:
+	case MM81X_SKB_CHAN_DATA_NOACK:
+	case MM81X_SKB_CHAN_BEACON:
+	case MM81X_SKB_CHAN_MGMT:
+		mq = &yaps->data_rx_q;
+		break;
+	case MM81X_SKB_CHAN_COMMAND:
+		mq = &yaps->cmd_resp_q;
+		break;
+	default:
+		dev_err(mors->dev, "channel value error [%d]", hdr->channel);
+		ret = -EIO;
+		goto exit_return_page;
+	}
+
+	skb_len = sizeof(*hdr) + hdr->offset + le16_to_cpu(hdr->len);
+	skb_bytes_remaining = mm81x_skbq_space(mq);
+
+	if (skb_len > skb_bytes_remaining) {
+		dev_err(mors->dev,
+			"Page will not fit in SKBQ, dropping - len %d remain %d",
+			skb_len, skb_bytes_remaining);
+		ret = -ENOMEM;
+		/* Queue work to clear backlog */
+		queue_work(mors->net_wq, &mq->dispatch_work);
+		goto exit_return_page;
+	}
+
+	skb_trim(skb, skb_len);
+	__skb_queue_tail(&skbq, skb);
+
+	if (skb_queue_len(&skbq))
+		mm81x_skbq_enq(mq, &skbq);
+
+	/* push packets up in a different context */
+	queue_work(mors->net_wq, &mq->dispatch_work);
+
+	goto exit;
+
+exit_return_page:
+	if (ret && mq) {
+		dev_err(mors->dev, "failed %d", ret);
+		mm81x_skbq_purge(mq, &skbq);
+		goto exit;
+	}
+
+exit:
+	if (ret && skb)
+		dev_kfree_skb(skb);
+
+	return ret;
+}
+
+static int mm81x_yaps_tx(struct mm81x_yaps *yaps, struct mm81x_skbq *mq)
+{
+	int i;
+	int ret = 0;
+	int num_skbs = 0;
+	int tc_pkt_idx = 0;
+	int num_pkts_sent = 0;
+	struct sk_buff *skb;
+	struct sk_buff_head skbq_to_send;
+	struct sk_buff_head skbq_sent;
+	struct sk_buff_head skbq_failed;
+	struct sk_buff *pfirst, *pnext;
+	struct mm81x *mors = yaps->mors;
+	struct mm81x_skb_hdr *hdr;
+
+	/* Check there is something on the queue */
+	spin_lock_bh(&mq->lock);
+	skb = skb_peek(&mq->skbq);
+	spin_unlock_bh(&mq->lock);
+	if (!skb)
+		return 0;
+
+	__skb_queue_head_init(&skbq_to_send);
+	__skb_queue_head_init(&skbq_sent);
+	__skb_queue_head_init(&skbq_failed);
+
+	if (mq == &yaps->cmd_q)
+		/* Purge timed-out commands (this should not happen) */
+		mm81x_skbq_purge(mq, &mq->pending);
+	else if (mq == &yaps->mgmt_q && skb_queue_len(&mq->skbq) > 0)
+		/*
+		 * Purge old mgmt frames that have not been sent due to
+		 * congestion
+		 */
+		mm81x_skbq_purge_aged(mors, mq);
+
+	num_skbs =
+		mm81x_skbq_deq_num_skb(mq, &skbq_to_send, MAX_PKTS_PER_TX_TXN);
+
+	skb_queue_walk_safe(&skbq_to_send, pfirst, pnext) {
+		enum mm81x_yaps_to_chip_q tc_queue;
+
+		hdr = (struct mm81x_skb_hdr *)pfirst->data;
+		switch (hdr->channel) {
+		case MM81X_SKB_CHAN_COMMAND:
+			tc_queue = MM81X_YAPS_CMD_Q;
+			break;
+		case MM81X_SKB_CHAN_BEACON:
+			tc_queue = MM81X_YAPS_BEACON_Q;
+			break;
+		case MM81X_SKB_CHAN_MGMT:
+			tc_queue = MM81X_YAPS_MGMT_Q;
+			break;
+		default:
+			tc_queue = MM81X_YAPS_TX_Q;
+			break;
+		}
+		yaps->hw.to_chip_pkts[tc_pkt_idx].tc_queue = tc_queue;
+		yaps->hw.to_chip_pkts[tc_pkt_idx].skb = pfirst;
+		tc_pkt_idx++;
+	}
+
+	/* Send queued packets to chip */
+	ret = mm81x_yaps_update_status(yaps);
+	if (ret)
+		return ret;
+
+	ret = mm81x_yaps_write_pkts(yaps, yaps->hw.to_chip_pkts, tc_pkt_idx,
+				    &num_pkts_sent);
+
+	/* Move sent packets to done queue */
+	for (i = 0; i < num_pkts_sent; ++i) {
+		pfirst = __skb_dequeue(&skbq_to_send);
+		__skb_queue_tail(&skbq_sent, pfirst);
+	}
+
+	for (i = num_pkts_sent; i < num_skbs; ++i) {
+		pfirst = __skb_dequeue(&skbq_to_send);
+		__skb_queue_tail(&skbq_failed, pfirst);
+	}
+
+	if (skb_queue_len(&skbq_failed) > 0) {
+		mm81x_skbq_enq_prepend(mq, &skbq_failed);
+
+		/* queue full, can't requeue */
+		if (skb_queue_len(&skbq_failed) > 0) {
+			dev_warn(mors->dev,
+				 "can't requeue failed pkts, purging");
+			__skb_queue_purge(&skbq_failed);
+		}
+	}
+
+	if (skb_queue_len(&skbq_sent) > 0)
+		mm81x_skbq_tx_complete(mq, &skbq_sent);
+
+	return ret;
+}
+
+/* Returns true if there are TX data pages waiting to be sent */
+static bool mm81x_yaps_tx_data_handler(struct mm81x_yaps *yaps)
+{
+	s16 aci;
+	u32 count = 0;
+	struct mm81x *mors = yaps->mors;
+
+	for (aci = MM81X_ACI_VO; aci >= 0; aci--) {
+		struct mm81x_skbq *data_q = mm81x_yaps_tc_q_from_aci(mors, aci);
+
+		if (!mm81x_is_data_tx_allowed(mors))
+			break;
+
+		yaps->chip_queue_full.is_full = mm81x_yaps_tx(yaps, data_q);
+		count += mm81x_skbq_count(data_q);
+
+		if (yaps->chip_queue_full.is_full)
+			break;
+
+		if (aci == MM81X_ACI_BE)
+			break;
+	}
+
+	/*
+	 * Data has potentially been transmitted from the data SKBQs.
+	 * If the mac80211 TX data Qs were previously stopped, now would
+	 * be a good time to check if they can be started again.
+	 */
+	mm81x_skbq_may_wake_tx_queues(mors);
+
+	return (count > 0) && mm81x_is_data_tx_allowed(mors);
+}
+
+/* Returns true if there are commands waiting to be sent */
+static bool mm81x_yaps_tx_cmd_handler(struct mm81x_yaps *yaps)
+{
+	struct mm81x_skbq *cmd_q = &yaps->cmd_q;
+
+	mm81x_yaps_tx(yaps, cmd_q);
+
+	return mm81x_skbq_count(cmd_q) > 0;
+}
+
+static bool mm81x_yaps_tx_beacon_handler(struct mm81x_yaps *yaps)
+{
+	struct mm81x_skbq *beacon_q = &yaps->beacon_q;
+
+	mm81x_yaps_tx(yaps, beacon_q);
+
+	return mm81x_skbq_count(beacon_q) > 0;
+}
+
+static bool mm81x_yaps_tx_mgmt_handler(struct mm81x_yaps *yaps)
+{
+	struct mm81x_skbq *mgmt_q = &yaps->mgmt_q;
+
+	mm81x_yaps_tx(yaps, mgmt_q);
+
+	return mm81x_skbq_count(mgmt_q) > 0;
+}
+
+/* Returns true if there are populated RX pages left in the device */
+static bool mm81x_yaps_rx_handler(struct mm81x_yaps *yaps)
+{
+	int ret = 0;
+	int i;
+	int num_pks_received;
+
+	ret = mm81x_yaps_update_status(yaps);
+	if (ret)
+		goto exit;
+
+	ret = mm81x_yaps_read_pkts(yaps, yaps->hw.from_chip_pkts,
+				   MAX_PKTS_PER_RX_TXN, &num_pks_received);
+	if (ret && ret != -EAGAIN) {
+		dev_err(yaps->mors->dev, "YAPS read_pkts fail: %d", ret);
+		goto exit;
+	}
+
+	for (i = 0; i < num_pks_received; ++i) {
+		mm81x_yaps_read_pkt(yaps, yaps->hw.from_chip_pkts[i].skb);
+		yaps->hw.from_chip_pkts[i].skb = NULL;
+	}
+
+exit:
+	if (ret == -ENOMEM || ret == -EAGAIN)
+		return true;
+	else
+		return false;
+}
+
+void mm81x_yaps_stale_tx_work(struct work_struct *work)
+{
+	int i;
+	int flushed = 0;
+	struct mm81x *mors = container_of(work, struct mm81x, tx_stale_work);
+	struct mm81x_yaps *yaps;
+
+	yaps = &mors->hif.u.yaps;
+	flushed += mm81x_skbq_check_for_stale_tx(mors, &yaps->beacon_q);
+	flushed += mm81x_skbq_check_for_stale_tx(mors, &yaps->mgmt_q);
+
+	for (i = 0; i < ARRAY_SIZE(yaps->data_tx_qs); i++)
+		flushed += mm81x_skbq_check_for_stale_tx(mors,
+							 &yaps->data_tx_qs[i]);
+
+	if (!flushed)
+		return;
+
+	dev_dbg(mors->dev, "Flushed %d stale TX SKBs", flushed);
+
+	if (mors->ps.enable && !mors->ps.suspended &&
+	    (mm81x_yaps_get_tx_buffered_count(mors) == 0)) {
+		/* Evaluate ps to check if it was gated on a stale tx status */
+		queue_delayed_work(mors->chip_wq, &mors->ps.delayed_eval_work,
+				   0);
+	}
+}
+
+void mm81x_yaps_work(struct work_struct *work)
+{
+	struct mm81x *mors = container_of(work, struct mm81x, hif_work);
+	unsigned long *flags = &mors->hif.event_flags;
+	struct mm81x_yaps *yaps = &mors->hif.u.yaps;
+
+	if (test_bit(MM81X_STATE_CHIP_UNRESPONSIVE, &mors->state_flags))
+		return;
+
+	if (!*flags)
+		return;
+
+	/* Disable power save in case it is running */
+	mm81x_ps_disable(mors);
+	mm81x_claim_bus(mors);
+
+	/*
+	 * Handle any populated RX pages from chip first to
+	 * avoid dropping pkts due to full on-chip buffers.
+	 * Check if all pages were removed, set event flags if not.
+	 */
+	if (test_and_clear_bit(MM81X_HIF_EVT_RX_PEND, flags)) {
+		if (mm81x_yaps_rx_handler(yaps))
+			set_bit(MM81X_HIF_EVT_RX_PEND, flags);
+	}
+
+	/* TX any commands before considering data */
+	if (test_and_clear_bit(MM81X_HIF_EVT_TX_COMMAND_PEND, flags)) {
+		if (mm81x_yaps_tx_cmd_handler(yaps))
+			set_bit(MM81X_HIF_EVT_TX_COMMAND_PEND, flags);
+	}
+
+	/* TX beacons before considering mgmt/data */
+	if (test_and_clear_bit(MM81X_HIF_EVT_TX_BEACON_PEND, flags)) {
+		if (mm81x_yaps_tx_beacon_handler(yaps))
+			set_bit(MM81X_HIF_EVT_TX_BEACON_PEND, flags);
+	}
+
+	/* TX mgmt before considering data */
+	if (test_and_clear_bit(MM81X_HIF_EVT_TX_MGMT_PEND, flags)) {
+		if (mm81x_yaps_tx_mgmt_handler(yaps))
+			set_bit(MM81X_HIF_EVT_TX_MGMT_PEND, flags);
+	}
+
+	/* Pause TX data Qs */
+	if (test_and_clear_bit(MM81X_HIF_EVT_DATA_TRAFFIC_PAUSE_PEND, flags)) {
+		test_and_clear_bit(MM81X_HIF_EVT_DATA_TRAFFIC_RESUME_PEND,
+				   flags);
+		mm81x_skbq_data_traffic_pause(mors);
+	}
+
+	/* Resume TX data Qs  */
+	if (test_and_clear_bit(MM81X_HIF_EVT_DATA_TRAFFIC_RESUME_PEND, flags))
+		mm81x_skbq_data_traffic_resume(mors);
+
+	/* Handle chip queue status */
+	if (test_and_clear_bit(MM81X_HIF_EVT_TX_PACKET_FREED_UP_PEND, flags))
+		yaps->chip_queue_full.is_full = false;
+
+	/* Check to see if the queue is full or
+	 * long enough has past since the queue was full
+	 */
+	if (yaps->chip_queue_full.is_full &&
+	    time_before(jiffies, yaps->chip_queue_full.retry_expiry))
+		goto exit;
+
+	/* Finally TX any data */
+	if (test_and_clear_bit(MM81X_HIF_EVT_TX_DATA_PEND, flags)) {
+		if (mm81x_yaps_tx_data_handler(yaps))
+			set_bit(MM81X_HIF_EVT_TX_DATA_PEND, flags);
+
+		if (yaps->chip_queue_full.is_full) {
+			yaps->chip_queue_full.retry_expiry =
+				jiffies +
+				msecs_to_jiffies(CHIP_FULL_RECOVERY_TIMEOUT_MS);
+			mod_timer(&yaps->chip_queue_full.timer,
+				  yaps->chip_queue_full.retry_expiry);
+		}
+	}
+
+exit:
+
+	/* Disable power save in case it is running */
+	mm81x_release_bus(mors);
+	mm81x_ps_enable(mors);
+
+	/* Don't requeue work if we are shutting down. */
+	if (yaps->finish)
+		return;
+	/*
+	 * Evaluate all events except MM81X_HIF_EVT_TX_DATA_PEND in case data
+	 * tx queue is full
+	 */
+	if ((*flags) & ~(1 << MM81X_HIF_EVT_TX_DATA_PEND))
+		queue_work(mors->chip_wq, &mors->hif_work);
+	/*
+	 * if data tx queue is not full and the work hasn't been queued let's
+	 * queue it
+	 */
+	else if (!yaps->chip_queue_full.is_full && *flags)
+		queue_work(mors->chip_wq, &mors->hif_work);
+}
+
+int mm81x_yaps_get_tx_status_pending_count(struct mm81x *mors)
+{
+	int i = 0;
+	int count = 0;
+	struct mm81x_yaps *yaps;
+
+	yaps = &mors->hif.u.yaps;
+	count += skb_queue_len(&yaps->beacon_q.pending);
+	count += skb_queue_len(&yaps->mgmt_q.pending);
+	count += skb_queue_len(&yaps->cmd_q.pending);
+
+	for (i = 0; i < ARRAY_SIZE(yaps->data_tx_qs); i++)
+		count += skb_queue_len(&yaps->data_tx_qs[i].pending);
+
+	return count;
+}
+
+int mm81x_yaps_get_tx_buffered_count(struct mm81x *mors)
+{
+	int i = 0;
+	int count = 0;
+	struct mm81x_yaps *yaps;
+
+	yaps = &mors->hif.u.yaps;
+	count += skb_queue_len(&yaps->beacon_q.skbq) +
+		 skb_queue_len(&yaps->beacon_q.pending);
+	count += skb_queue_len(&yaps->mgmt_q.skbq) +
+		 skb_queue_len(&yaps->mgmt_q.pending);
+	count += skb_queue_len(&yaps->cmd_q.skbq) +
+		 skb_queue_len(&yaps->cmd_q.pending);
+
+	for (i = 0; i < ARRAY_SIZE(yaps->data_tx_qs); i++)
+		count += mm81x_skbq_count_tx_ready(&yaps->data_tx_qs[i]) +
+			 skb_queue_len(&yaps->data_tx_qs[i].pending);
+
+	return count;
+}
+
+static void mm81x_yaps_tx_q_full_timer(struct timer_list *t)
+{
+	struct mm81x_yaps *yaps =
+		timer_container_of(yaps, t, chip_queue_full.timer);
+
+	queue_work(yaps->mors->chip_wq, &yaps->mors->hif_work);
+}
+
+static void mm81x_yaps_q_chip_full_timer_init(struct mm81x_yaps *yaps)
+{
+	timer_setup(&yaps->chip_queue_full.timer, mm81x_yaps_tx_q_full_timer,
+		    0);
+}
+
+static void mm81x_yaps_q_chip_full_timer_finish(struct mm81x_yaps *yaps)
+{
+	timer_delete_sync_try(&yaps->chip_queue_full.timer);
+}
+
+int mm81x_yaps_init(struct mm81x *mors)
+{
+	int i, ret;
+	struct mm81x_yaps *yaps;
+
+	ret = mm81x_yaps_hw_init(mors);
+	if (ret) {
+		dev_err(mors->dev, "mm81x_yaps_hw_init failed %d", ret);
+		return ret;
+	}
+
+	yaps = &mors->hif.u.yaps;
+	yaps->mors = mors;
+
+	mm81x_claim_bus(mors);
+
+	ret = mm81x_yaps_alloc_pkt_buffers(yaps);
+	if (ret) {
+		dev_err(mors->dev, "Failed to allocate YAPS packet buffers: %d",
+			ret);
+		mm81x_yaps_hw_finish(mors);
+		mm81x_release_bus(mors);
+		return ret;
+	}
+
+	/* YAPS is bi-directional */
+	mm81x_skbq_init(mors, &yaps->data_rx_q,
+			MM81X_HIF_FLAGS_DATA | MM81X_HIF_FLAGS_DIR_TO_HOST);
+	mm81x_skbq_init(mors, &yaps->beacon_q,
+			MM81X_HIF_FLAGS_DATA | MM81X_HIF_FLAGS_DIR_TO_HOST);
+	mm81x_skbq_init(mors, &yaps->mgmt_q,
+			MM81X_HIF_FLAGS_DATA | MM81X_HIF_FLAGS_DIR_TO_HOST);
+
+	for (i = 0; i < ARRAY_SIZE(yaps->data_tx_qs); i++) {
+		mm81x_skbq_init(mors, &yaps->data_tx_qs[i],
+				MM81X_HIF_FLAGS_DATA |
+					MM81X_HIF_FLAGS_DIR_TO_CHIP);
+	}
+
+	mm81x_skbq_init(mors, &yaps->cmd_q,
+			MM81X_HIF_FLAGS_COMMAND | MM81X_HIF_FLAGS_DIR_TO_CHIP);
+	mm81x_skbq_init(mors, &yaps->cmd_resp_q,
+			MM81X_HIF_FLAGS_COMMAND | MM81X_HIF_FLAGS_DIR_TO_HOST);
+
+	mm81x_yaps_q_chip_full_timer_init(yaps);
+	INIT_WORK(&mors->hif_work, mm81x_yaps_work);
+	INIT_WORK(&mors->tx_stale_work, mm81x_yaps_stale_tx_work);
+	mm81x_release_bus(mors);
+	mm81x_hw_enable_stop_notifications(mors, true);
+	return 0;
+}
+
+void mm81x_yaps_finish(struct mm81x *mors)
+{
+	int i;
+	struct mm81x_yaps *yaps;
+
+	mm81x_yaps_hw_enable_irqs(mors, false);
+
+	yaps = &mors->hif.u.yaps;
+	yaps->finish = true;
+
+	mm81x_skbq_finish(&yaps->data_rx_q);
+	mm81x_skbq_finish(&yaps->beacon_q);
+	mm81x_skbq_finish(&yaps->mgmt_q);
+
+	for (i = 0; i < ARRAY_SIZE(yaps->data_tx_qs); i++)
+		mm81x_skbq_finish(&yaps->data_tx_qs[i]);
+
+	mm81x_skbq_finish(&yaps->cmd_q);
+	mm81x_skbq_finish(&yaps->cmd_resp_q);
+
+	mm81x_yaps_q_chip_full_timer_finish(yaps);
+
+	cancel_work_sync(&mors->hif_work);
+	cancel_work_sync(&mors->tx_stale_work);
+
+	mm81x_yaps_free_pkt_buffers(yaps);
+	mm81x_yaps_hw_finish(mors);
+}
+
+void mm81x_yaps_flush_tx_data(struct mm81x *mors)
+{
+	int i;
+	struct mm81x_yaps *yaps = &mors->hif.u.yaps;
+
+	mm81x_skbq_tx_flush(&yaps->beacon_q);
+	mm81x_skbq_tx_flush(&yaps->mgmt_q);
+
+	for (i = 0; i < ARRAY_SIZE(yaps->data_tx_qs); i++)
+		mm81x_skbq_tx_flush(&yaps->data_tx_qs[i]);
+}
+
+void mm81x_yaps_flush_cmds(struct mm81x *mors)
+{
+	struct mm81x_yaps *yaps = &mors->hif.u.yaps;
+
+	if (yaps->flags & MM81X_HIF_FLAGS_COMMAND) {
+		mm81x_skbq_finish(&yaps->cmd_q);
+		mm81x_skbq_finish(&yaps->cmd_resp_q);
+	}
+}
-- 
2.43.0


