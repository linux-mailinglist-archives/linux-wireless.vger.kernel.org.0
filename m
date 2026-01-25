Return-Path: <linux-wireless+bounces-31152-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGYIDAecdmmqSwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31152-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Jan 2026 23:41:11 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9837682B94
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Jan 2026 23:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 548483004203
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Jan 2026 22:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7DB30E856;
	Sun, 25 Jan 2026 22:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t32smtp-sign002.email header.i=@t32smtp-sign002.email header.b="UYuq4HuG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail60.out.titan.email (mail60.out.titan.email [209.209.25.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03A730DEA2
	for <linux-wireless@vger.kernel.org>; Sun, 25 Jan 2026 22:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.209.25.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769380866; cv=none; b=MrASgt973siUWhEsofanxOQ/uiXCVUZwVAdFkwRe2IF31JwccfX8Y9fuVJVpC42fRnUJd8GUxMGKTVUo3SnhHulWfC54LKz6lL4waC0HJsxkYHAltOR0t3c/aYeTD9MJRgUL4PIXzO5Splun4KIBagqqAC9AR6mfDNcALlig5Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769380866; c=relaxed/simple;
	bh=iIIBFLPRPsYhTak99v0uHCObUibxsek2DuXjyA0PsTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kb4w1dhMTgsi5uGtaeMQPHN8hppk/l+1AYOO0ULGYH7aO6nu5mHlYAn7OLUL3ex/2UueCSn0AT7WCFmP0i+wcYITQYfd6lpP0s216pANEb40+OZ7mhDwpxuIBapKgbE+a6MyMjsN63Zh/3OpSjb2fHK/Ki5y5GCnrTvwKHU1Ai8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (1024-bit key) header.d=t32smtp-sign002.email header.i=@t32smtp-sign002.email header.b=UYuq4HuG; arc=none smtp.client-ip=209.209.25.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
Received: from localhost (localhost [127.0.0.1])
	by smtp-out.flockmail.com (Postfix) with ESMTP id 4dzmSr4vvWz9rvZ;
	Sun, 25 Jan 2026 22:25:16 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=x2ErXq9Ev2USPtMF2OE1uhjqgpnXYZlZITRWCnNrb9M=;
	c=relaxed/relaxed; d=t32smtp-sign002.email;
	h=cc:message-id:mime-version:date:to:subject:from:from:to:cc:subject:date:message-id:in-reply-to:reply-to:references;
	q=dns/txt; s=titan1; t=1769379916; v=1;
	b=UYuq4HuGdZD/0MFKH9KSwkxaYwSyS3aL+fMrm9SEGTxGRBNb1AOnghEWxbR9XNCXyMMYRRih
	L1phlVAR7QIU5OtsWCpgKmNLdy0kWNiDGebu/OlZKMqXL/iZqrVOxZDjfPQFfmx4PQfCUTIJjiq
	5XcOk1Y3bGnYL5NbCsdpul98=
Received: from fedora (unknown [176.100.43.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp-out.flockmail.com (Postfix) with ESMTPSA id 4dzmSq6xdGz9rwH;
	Sun, 25 Jan 2026 22:25:15 +0000 (UTC)
Feedback-ID: :lucid_duck@justthetip.ca:justthetip.ca:flockmailId
From: Lucid Duck <lucid_duck@justthetip.ca>
To: linux-wireless@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Lucid Duck <lucid_duck@justthetip.ca>
Subject: [PATCH] wifi: mt76: connac: fix txpower_cur not being updated
Date: Sun, 25 Jan 2026 14:22:35 -0800
Message-ID: <20260125222235.36565-1-lucid_duck@justthetip.ca>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1769379916530732897.13754.6154912364071717633@prod-use1-smtp-out1003.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=TPG/S0la c=1 sm=1 tr=0 ts=6976984c
	a=yrWfAsoAw4/hpWCXcRwPxQ==:117 a=yrWfAsoAw4/hpWCXcRwPxQ==:17
	a=CEWIc4RMnpUA:10 a=ThxqNdz_AAAA:8 a=5E6bk7XWnT_lC0rFHdsA:9
	a=X5WbqfxFh8zCdCUNm0Nt:22
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[t32smtp-sign002.email:s=titan1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[justthetip.ca];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-31152-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[t32smtp-sign002.email:+];
	FROM_NEQ_ENVFROM(0.00)[lucid_duck@justthetip.ca,linux-wireless@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,t32smtp-sign002.email:dkim]
X-Rspamd-Queue-Id: 9837682B94
X-Rspamd-Action: no action

The mt76_connac_mcu_set_rate_txpower() function sends TX power settings
to the firmware but never updates phy->txpower_cur. This causes
mt76_get_txpower() to return stale or incorrect values (typically
showing 3 dBm regardless of actual transmit power) when userspace
queries TX power via nl80211.

This affects MT7921 and other connac-based devices. Users observe:
  $ iw dev wlan0 info
  ...
  txpower 3.00 dBm

The firmware receives and applies the correct power level, but the
reported value is wrong because txpower_cur is never set.

Fix by updating phy->txpower_cur after successfully configuring TX
power, matching the behavior of other mt76 drivers like mt7915.

Signed-off-by: Lucid Duck <lucid_duck@justthetip.ca>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 045771228..7cd357419 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -2251,7 +2251,7 @@ mt76_connac_mcu_rate_txpower_band(struct mt76_phy *phy,
 
 int mt76_connac_mcu_set_rate_txpower(struct mt76_phy *phy)
 {
-	int err;
+	int err, tx_power;
 
 	if (phy->cap.has_2ghz) {
 		err = mt76_connac_mcu_rate_txpower_band(phy,
@@ -2272,6 +2272,12 @@ int mt76_connac_mcu_set_rate_txpower(struct mt76_phy *phy)
 			return err;
 	}
 
+	/* Update txpower_cur for accurate reporting via nl80211 */
+	tx_power = 2 * phy->hw->conf.power_level;
+	if (!tx_power)
+		tx_power = 127;
+	phy->txpower_cur = tx_power;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_set_rate_txpower);
-- 
2.52.0


