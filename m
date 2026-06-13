Return-Path: <linux-wireless+bounces-37769-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id T9TWF+fcLWrGlgQAu9opvQ
	(envelope-from <linux-wireless+bounces-37769-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 00:42:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FF767FF1E
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 00:42:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37769-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37769-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBBD5300D45D
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jun 2026 22:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5953451CD;
	Sat, 13 Jun 2026 22:42:42 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930E4223DCE
	for <linux-wireless@vger.kernel.org>; Sat, 13 Jun 2026 22:42:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781390562; cv=none; b=q+Nz31+Cb8fvFLrzaNQf2ZcyXygZMQOjMuDWt3tCK+Ngk/qvmElk08ONPUirBvyAQqTvXq4DvuSEta3yTAGCQ+FEyr8WiLt42DIBOwgoufIksxblGPO1xtwpOWp06LOUfO+Df65i9M3+2bmNbHJ98VlZFdEqZHAEqyQG66vUJ50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781390562; c=relaxed/simple;
	bh=Kch+kbXMA/cvSe054BtEMpAyMG9wvaplzK5ljlxs6sY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pKia2TH9BOACVSvSt/zXX+d4ZdafmnylHaSTOorrtf6zgENYsiqvdFy4RftQ9/TQEbh/mknr8bgG/ygLTxb8NeuJlgGhC0380hzjWbyx3kYpwjTwewqMkKxWRsds+5KRI3/ifxAlmpUGDlfa8ORyZNMBL8oa3kTw8r3j7ICeg7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.173
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-30807ba471bso6139163eec.1
        for <linux-wireless@vger.kernel.org>; Sat, 13 Jun 2026 15:42:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781390561; x=1781995361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BsMgY2EJgIXW9akcAvoEYiqLT3dQNyDwGK85vWbbGj8=;
        b=DNkEGMfbgPTpORK+A26P7wNwW+9XXqOJtVSLoEqYIrSrA8IxjXahDfUaoBcA4XQ/VO
         RocRoqFwjsDHqZ24z5UnFxSU+3kcwIs0wC57xm+sg1oBxBxkaLtXsVNvxjlFhFStD2E3
         jxQS6bGR7dF6/TrhEKaFHgY9VUi2B/vGKg+gKnzH5euIJo6lq5zlbgy/dtdlFNBDfEWN
         3lcZH/GjsAWZKUWCG78wDyPXbDEwdAOev22HboHYqre6+LKI12vhcipqvHVbF8yutwdb
         ao0Tmuhrja4hFq1z34UWaQGM45kbiWQR1zkIaUJueOw9156hpCZNZpS3yiPDuACHIAvI
         iu7g==
X-Gm-Message-State: AOJu0YyPTPZhSesP4hjDOMkibOj7o9mMpE+/UKZt6htcnPuFFDiApRrD
	V9WezzPaOIPdebSpS4VGfNsdC7qkFLGvYmhZuUrOW3CeM9SIt1PVu26f
X-Gm-Gg: Acq92OE3YSDqSoNDKxqVcPysad7WEtoRo9U1eqfK1aT38i0GK5l/FZxulSe7roUxYaI
	VIGDwJ19BiKrslF8fBMyNxOmrwO1OKIUjCzg3exDuS32B6xgV2RLAilyHuvwwShWRIRpL3fGaDw
	7xoxtuV/lho8NdBWEnocGd218vkI71UBkteAxXC1yCbIHYwOF5cBkzGbeISaofJ5vg36PqB2z/H
	vinJZKzGuPbG3E4WTxlzBZiajOjC7uOvna2MeI+SCKOy4imAuRx0bC85vlusTDGbnlPFemk/okU
	o1XCaKg9StijxPEGHYh7/mi5YdBBWydJ1sT5wsi/mfpe5fjQDgCS1WZUkmr8jJVqLErbIlkCChn
	XUW/QBrDMS19eq44RLQUO5XCUogscWNupBiRJHeIzbu2HeXos969XHtMJCwtCUugCfcxJg20utP
	O2yyPx3IOwXrQgaH8YxdfxvdA1/7y3tXM3DNdsjUALiuhClRbAI/w0GDgvytbUHy6wSrxAf5Pst
	JOqC+io4sNoZEeEoI/IWi9HeabyvK0AAmYbsLbc
X-Received: by 2002:a05:7300:e68b:b0:304:18be:55a5 with SMTP id 5a478bee46e88-30820056b92mr5093064eec.22.1781390560742;
        Sat, 13 Jun 2026 15:42:40 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.. (114-34-228-194.hinet-ip.hinet.net. [114.34.228.194])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081eb95450sm11104825eec.28.2026.06.13.15.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 15:42:40 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 5/6] wifi: mt76: mt792x: enable USB UDMA TX timeout
Date: Sat, 13 Jun 2026 17:41:30 -0500
Message-ID: <20260613224131.2396026-6-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260613224131.2396026-1-sean.wang@kernel.org>
References: <20260613224131.2396026-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:sean.wang@mediatek.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37769-lists,linux-wireless=lfdr.de];
	FORGED_SENDER(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mediatek.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B3FF767FF1E

From: Sean Wang <sean.wang@mediatek.com>

Configure the USB UDMA TX timeout limit and enable timeout detection
during DMA initialization, matching the vendor driver setup. Use a
longer timeout to avoid false alarms.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt792x_usb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
index 43191a8a9ea4..c4da1b900d47 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
@@ -11,6 +11,7 @@
 #include "mt792x.h"
 #include "mt76_connac2_mac.h"
 
+#define MT792X_USB_TX_TIMEOUT_LIMIT	50000
 #define MT792X_USB_UDMA_IDLE_TIMEOUT	1000
 
 static int mt792xu_read32(struct mt76_dev *dev, u32 addr, void *buf)
@@ -396,6 +397,10 @@ int mt792xu_dma_init(struct mt792x_dev *dev, bool resume)
 	mt76_set(dev, MT_UDMA_WLCFG_0,
 		 MT_WL_RX_EN | MT_WL_TX_EN |
 		 MT_WL_RX_MPSZ_PAD0 | MT_TICK_1US_EN);
+	mt76_rmw(dev, MT_UDMA_WLCFG_1, MT_WL_TX_TMOUT_LMT,
+		 FIELD_PREP(MT_WL_TX_TMOUT_LMT,
+			    MT792X_USB_TX_TIMEOUT_LIMIT));
+	mt76_set(dev, MT_UDMA_WLCFG_0, MT_WL_TX_TMOUT_FUNC_EN);
 	mt76_clear(dev, MT_UDMA_WLCFG_0,
 		   MT_WL_RX_AGG_TO | MT_WL_RX_AGG_LMT);
 	mt76_clear(dev, MT_UDMA_WLCFG_1, MT_WL_RX_AGG_PKT_LMT);
-- 
2.43.0


