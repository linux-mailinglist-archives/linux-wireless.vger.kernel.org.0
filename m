Return-Path: <linux-wireless+bounces-37770-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4Aa6Lu/cLWrJlgQAu9opvQ
	(envelope-from <linux-wireless+bounces-37770-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 00:42:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB1E67FF22
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 00:42:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37770-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37770-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65F99300D6B8
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jun 2026 22:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921CE3451CD;
	Sat, 13 Jun 2026 22:42:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7555B223DCE
	for <linux-wireless@vger.kernel.org>; Sat, 13 Jun 2026 22:42:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781390566; cv=none; b=M8w2NlwebKdXLIxl712COozEu76oxFNsi9MlKXI2jVgzAO9As5JHkEyoaInHF3Bq8PACp2Y8BvZY1X7OhL8uI4eeDp9hkopO0EhUPkTZRRIZ9uhU1weH2O8xcLB3PSyJyBrRpMFzmTrBzkpjvlV/66BsS/oB0d74oRnQJ/ObomI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781390566; c=relaxed/simple;
	bh=Uq5Ig4xpqkY1y4bFSiRy1dX99SWrzb63XvtAlBT10Ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V3PCROKOURo/JfLRB4jFhUbxvbJiiodZiW3GKg6zBxzyal74HOzgAyARehi7M/ncUH7IoaeNd6SP8VjZSHbCrs+SzGSLVUy7/ZLpyERHOnrCcWGS6VmbUeAwVC+kNRxhjo9oEGPaGnoH6nZQepiXn9XYGRvhCQ0f3rDnVNDOa6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.172
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-307263ad0cbso3285931eec.0
        for <linux-wireless@vger.kernel.org>; Sat, 13 Jun 2026 15:42:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781390565; x=1781995365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HRPTT3/6G4lP2VEfu1IORtyPMTNcjVGbmV1lNT9rjb0=;
        b=Aa7fEf8XjKcXR8ausaSVgZYWqxa2d0N/y6WAMhI1OGm383ebIWvCKC2iS4AD6rHnL3
         tEJ7EQNceqB7akRDNglerUqnBHT9wlhj5B5ANSlsJeqf6KDRjOEgqiWpimzDstSiXL7H
         Y0irrE9fAG3QDy5NzTFK3KWDT+QOAuAOKOve3BgJItHY/fqnLZjwzkWIzsVlzFwtUx3I
         wyyFETSzPMj7GX72YSK7fmRZidiHWukp8nILTpuqAOShiYraC3Neh+JJ0EQcwKOTjaPU
         rKjVybVbLkRZvAouNK9ZkB/yLcTCxJqNJxq+A3cgZ5KLCIY62ApUm/sPmd86wkZ+Ld2P
         cUQw==
X-Gm-Message-State: AOJu0YybMaeSXDrFUQPZkE+FSdtD147RvWASrMzEEhjuhvzzFlG+pa4f
	F2kwzvsMTquN/ROZAfmfZCl4Y/1d/JmITnU279QGfOMqH6LwAD6PmF2/
X-Gm-Gg: Acq92OFPbPlyLkE+hdsm9bz5VedXc8JBclaG7QGo7k6UKOEzvtrqdVW3Erq356UddcD
	wlBUyxw/bCI0tvL3/ciAWQJUUmXT0uSWq8fwEJYs/p7+1gXCYnF/xxZwXZ0HAaOVENhHXA3mu5I
	8soVQmfwrCR32d9NUs2uwgQmgkgNS7qbUHhIargQa6/+RZ+W1bWygeMD620U4vy2WKYaCkCVHFH
	VjxVFR6winacchmexwvQfr/YxM2ZGaQuexvKijBT9XLd+m9KdeMZle9r6pQ9RvEaDgzaTPU2oyd
	ztVgsuaA/Qto39Nx66Pi+NKvKsh1Q2gbeFHxcW/nBiDul/rB6SW1cxwedGXiRDEyJNzO+SqYniz
	XxliYPDFtCe1Pw7Xxlxo1uSXVfPOMQaRTGEwg1sZKaq9ZqXnkTKLg76qMZBg2GzfNB1FPbSxiUC
	iM9YN7tCKsU1BMJ9ktIxg96dqRvdj6F+lM58PpB6jdjqmB7pR/xAfuKipFGy1SGAks0389SaYc3
	HucdDZTThKTsdJhoR78V0tR//Rvc9sFBCLiwk50
X-Received: by 2002:a05:7300:df41:b0:2d9:5cd9:b8ff with SMTP id 5a478bee46e88-309356121d0mr2697668eec.6.1781390564540;
        Sat, 13 Jun 2026 15:42:44 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.. (114-34-228-194.hinet-ip.hinet.net. [114.34.228.194])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081eb95450sm11104825eec.28.2026.06.13.15.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 15:42:44 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 6/6] wifi: mt76: mt792x: quiesce USB paths on disconnect
Date: Sat, 13 Jun 2026 17:41:31 -0500
Message-ID: <20260613224131.2396026-7-sean.wang@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-37770-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 3CB1E67FF22

From: Sean Wang <sean.wang@mediatek.com>

USB disconnect can leave reset/init work, TX worker, and MCU waiters active
while the device is being removed. Stop those paths before unregistering
the device to avoid teardown waiting on firmware or queue activity after
disconnect.

Run WFSYS reset after USB queue deinit so removal does not issue the reset
while USB traffic may still be queued.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt792x_usb.c   | 20 ++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
index c4da1b900d47..e5d2d2f6a388 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
@@ -230,9 +230,9 @@ EXPORT_SYMBOL_GPL(mt792xu_mcu_power_on);
 static void mt792xu_cleanup(struct mt792x_dev *dev)
 {
 	clear_bit(MT76_STATE_INITIALIZED, &dev->mphy.state);
-	mt792xu_wfsys_reset(dev);
 	skb_queue_purge(&dev->mt76.mcu.res_q);
 	mt76u_queues_deinit(&dev->mt76);
+	mt792xu_wfsys_reset(dev);
 }
 
 static u32 mt792xu_uhw_rr(struct mt76_dev *dev, u32 addr)
@@ -494,13 +494,27 @@ void mt792xu_disconnect(struct usb_interface *usb_intf)
 {
 	struct mt792x_dev *dev = usb_get_intfdata(usb_intf);
 
-	mt792xu_reset_work_cleanup(dev);
+	if (!dev)
+		return;
+
+	set_bit(MT76_RESET, &dev->mphy.state);
+	set_bit(MT76_MCU_RESET, &dev->mphy.state);
+	clear_bit(MT76_STATE_RUNNING, &dev->mphy.state);
+	wake_up(&dev->mt76.mcu.wait);
+	skb_queue_purge(&dev->mt76.mcu.res_q);
+
+	cancel_work_sync(&dev->reset_work);
 	cancel_work_sync(&dev->init_work);
-	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mphy.state))
+	mt76_worker_disable(&dev->mt76.tx_worker);
+	mt792xu_reset_work_cleanup(dev);
+	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mphy.state)) {
+		set_bit(MT76_REMOVED, &dev->mphy.state);
 		return;
+	}
 
 	mt76_unregister_device(&dev->mt76);
 	mt792xu_cleanup(dev);
+	set_bit(MT76_REMOVED, &dev->mphy.state);
 
 	usb_set_intfdata(usb_intf, NULL);
 
-- 
2.43.0


