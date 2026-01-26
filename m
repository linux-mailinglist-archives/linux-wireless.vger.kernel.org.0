Return-Path: <linux-wireless+bounces-31185-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PLNLrurd2kZkAEAu9opvQ
	(envelope-from <linux-wireless+bounces-31185-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 19:00:27 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 558498BDBB
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 19:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 43EDD301C103
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 18:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A813234A790;
	Mon, 26 Jan 2026 18:00:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36D0239E7F
	for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 18:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769450423; cv=none; b=dv8hdCqgAfLxIXxWu+CU7cza/J0zViBCu0nQjvpXJomryj53lPxv/AY8U+rp6GygVjY775GKjbRgnpJp+rAr8Mv5lUxG7jUi9meDih5+9Pfmu55rGtfJQeIHD47G4ldvqdjddbgYdjfRKWElXcW7MwtqXV4lqLgkDFrCWhYr8EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769450423; c=relaxed/simple;
	bh=m8lCZYrtv6Qoifxxy6t6zkh7mSRUSw2fRiy0Gt/9m2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FPjiW6cyp+iwPUx/z2NsL7ASzMzy1/fOmV4rVwv0oW07zf60VGvXShkNmFeEbkQSC77ixwk7syhDxvlOLJQOikM5uundxaEbiyYD3X1TxZrjQ6Se/wb+3eyPG5sxYkf6OVghsQq3hfBp8EY5VcI+1NjXmNDRNVhjMl64KMZZltc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-45c958d480aso1423607b6e.1
        for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 10:00:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769450419; x=1770055219;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MtP8Go2M3C9++DiSDULRDE+5Pn2l5CFyfesMiTCa6/g=;
        b=kh4Of84PN3flYRnZO/EKnzxw6maRpNewBfzbtuxzH3O2uizy5XdV3xmuYTnXkHVRqO
         6nt/kpfF1jk9TuvVqBkfytkRJ0Pzk2sMNUXweUCIZlrChP8he7Y42rLLIK9b24pKBqLN
         +izuH+HdFObYjymwD0rLX1qX3F27qG3bIA/vwV4ASmHCCLVh83jQR1oh6hPy3GKeM57x
         SYO49nlcORh5IpxbefL1TGRaTZShG4ahc3ShaOBlZUKm+z//6N8Tk6jOfjrj4QkvrM1Q
         ErQcplJyfG2V5bzcGxMoDyuaxWYkDCoj6d+FA8+3iIgEQeSovsB+ZvcVv8nXQGAwMA9n
         XXCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOOgKdnUlGaBGnVzfPvbAVqkPHdlB5Nv/mWVH9AXlTSzdJl7EdyAMkVWJcdmFw77BgfcMTC7E5mVrU0C0eDA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy57Rtsl71OsU0Ih9S2Pgmf/zC8OFDUoxGZaVJHe7WOTDF83qq1
	qCr8uS2KOYlSGTeEgoYEwV+Nm7Pw40ng3Yy7cBvDRrIrh6wC7kcwUNKs
X-Gm-Gg: AZuq6aJsJHBIZvOOeT41jV4UpIER5u3E7olSi4e/AxRgPLltjPOCZAacaPyE4DBFmXN
	pD297xjnDltNbJRLrdumPCJ9mpnkRETBjuTerm0ZPv41iUfpCcanVmaBXbvvqoE4Yfe1kQ9/2rj
	5w4P3k72IVtReI79p27dCSHV4xCMu28pADNXvOfSPx/cDSPXkI5el5kp9dSGSZbbUDdXam318Jt
	QEBJCWf50t5+1oCokGfRh3u+ZhtuRGq+HTVzjq6SQGxP83bMgYqUTP/0swBdwcyT2fkypmMPF5h
	6u+qoFJ97wTaCjytnrMAiANTRYht59C7rXZ7DF6u7wRqkFGvorqFyjrtQbDinLXov2ACzQidoTO
	ug15I3kQGiyiQegvyKJo/5MOX0Ub9+91YTYX6+yP5SFNA6yYejJBTwXN2ZUf3FT6ud0d6x79lRc
	yaknlLugG9yrBc4pBMmYA0RWJpGKh/NkoIpaWkZ/gyx+pK0HxTfZ3I8XM4oTP159rBPwjmDbZxK
	qWVhmW6lg==
X-Received: by 2002:a05:6830:3143:b0:7c6:d0b2:8eb6 with SMTP id 46e09a7af769-7d1701d7c73mr2647850a34.15.1769450419085;
        Mon, 26 Jan 2026 10:00:19 -0800 (PST)
Received: from sean-HP-EliteBook-830-G6.. (65-36-108-159.dyn.grandenetworks.net. [65.36.108.159])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d15b3d31d4sm8173838a34.21.2026.01.26.10.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 10:00:18 -0800 (PST)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo@kernel.org
Cc: allan.wang@mediatek.com,
	quan.zhou@mediatek.com,
	leon.yen@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7921: fix potential deadlock in mt7921_roc_abort_sync
Date: Mon, 26 Jan 2026 12:00:13 -0600
Message-ID: <20260126180013.8167-1-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-31185-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 558498BDBB
X-Rspamd-Action: no action

From: Sean Wang <sean.wang@mediatek.com>

roc_abort_sync() can deadlock with roc_work(). roc_work() holds
dev->mt76.mutex, while cancel_work_sync() waits for roc_work()
to finish. If the caller already owns the same mutex, both
sides block and no progress is possible.

This deadlock can occur during station removal when
mt76_sta_state() -> mt76_sta_remove() -> mt7921_mac_sta_remove() ->
mt7921_roc_abort_sync() invokes cancel_work_sync() while
roc_work() is still running and holding dev->mt76.mutex.

This avoids the mutex deadlock and preserves exactly-once
work ownership.

Fixes: 352d966126e6 ("wifi: mt76: mt7921: fix a potential association failure upon resuming")
Co-developed-by: Quan Zhou <quan.zhou@mediatek.com>
Signed-off-by: Quan Zhou <quan.zhou@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 05793a786644..ddb81ca6bda0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -371,12 +371,15 @@ void mt7921_roc_abort_sync(struct mt792x_dev *dev)
 {
 	struct mt792x_phy *phy = &dev->phy;
 
+	if (!test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
+		return;
+
 	timer_delete_sync(&phy->roc_timer);
-	cancel_work_sync(&phy->roc_work);
-	if (test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
-		ieee80211_iterate_interfaces(mt76_hw(dev),
-					     IEEE80211_IFACE_ITER_RESUME_ALL,
-					     mt7921_roc_iter, (void *)phy);
+	cancel_work(&phy->roc_work);
+
+	ieee80211_iterate_interfaces(mt76_hw(dev),
+				     IEEE80211_IFACE_ITER_RESUME_ALL,
+				     mt7921_roc_iter, (void *)phy);
 }
 EXPORT_SYMBOL_GPL(mt7921_roc_abort_sync);
 
-- 
2.43.0


