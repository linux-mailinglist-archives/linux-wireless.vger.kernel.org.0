Return-Path: <linux-wireless+bounces-29768-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCF1CC079B
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 02:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21A7730145B4
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 01:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490C32773F9;
	Tue, 16 Dec 2025 01:38:54 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848FD24A078
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 01:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765849134; cv=none; b=GFXqQe6jfRTHtgdwoVqPljHQHHofJPSn7UNHcX2KrmDU+eCOaKA5irzB+wd5t2k1sjAIOGKyap140VmSs+R65Xf/n3ZnRM/ouTX49xpCXr+q5F8OIzrfkLOH1ekKdIK9F1cGTRsMVfPWXJwWNqHgdQHs5X7aKDc1R8nZlxhsD0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765849134; c=relaxed/simple;
	bh=6CtRnXEgpbiOBI1t02xJH6BcpoTEh/0gnjnb3A7aLMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jZWlnkUt8GxwOehVGVPuMpuDpcDbFa/FgZF5osuS6LyKnqpkmnShaVZ30HMyT9PVEGZG9LZjmStEq1eByCPe6M6efHPaA9KSNjOCsH1DuRSPivZq1s2EhfV19xc1ollIiLXI5+ET6vdAUn7NJOZsGRBecuaf0dvA1dV6pjLb188=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7c76607b968so1843444a34.3
        for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 17:38:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765849131; x=1766453931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Lj81YOSEfulTeNkBJglpZnxAwznIMi5NkA9Ofeq2Hc=;
        b=FgjJxFkaUt39EHlReQFkP6Ul8sM4pQ0QnQB7EpJqVi0UfWhjTKyqrMfgGzygvEE2kf
         9IoY+7Ye6kAMbwUKfNYzNm9njnSvWVTGjyhwwxYfDn3gCz98PoZnBtwal+eidfxKhKKH
         ZwdHsO3fBLFolzoj1ejk0S7XEc7bxh3rDYKx0HxMgU6i5M9s5yTJM2eIpo8dq1nidlXy
         ePJ5BilokPZhLhpIURp6lyj5aLw1WEhxvufmFluDNLkutBx1okH+ANgSbGiGvrsds7S9
         CTp1c6MsFyF1HMMpnPT3v70E0Ffv9Ql246K2inpZ3i0KcBXbP0JHh9tsqXopPbclLmzN
         WKNQ==
X-Gm-Message-State: AOJu0Yw6FFNQaqvztfidzH+zAeWAnlE1efmuQUZNZqAmvtVAkmjIuq/N
	co9Mzrsj5xZql1JgoeUsjTd5ZWW0hetz+ewsjjqky67PQha8Q1U6bYQD
X-Gm-Gg: AY/fxX7uYY56IO8GqZg2G76WN4PVM2N4Cp2jk3ms4VPtQtDCU0WCInPWgy90RLcE+2H
	TuUPdEj9d7tpavwqPLKVNLmJa4g/0LrEkxmTnz84YcBCXH+Q0iQKiZ1l7MJlQIKQ8kSx/uVGTxY
	fmcRXDxHwND/8hWlllhotXVT1S4I+PcL1Kb1fn+C/nSPbD1httQ5nTUE8PosAIzpqnvU2hKA3oS
	i6Isd9jc323JMDERvtxQrUL2aeIheHbj/Mlt3YxHK+U3TfW9TXLMWgFOA04fdbhw/Y9be9oHBYo
	Z7JSB2028b3t8wcHxPcfwaeB8ZS/YzlrLCBdA88aPHlW1vBILOY0KXIlejz2kiNLsYzD9dl56wT
	E/wJp8NR/iHKtglwIxIeRHiLVPnHBtLP9OQIuhqjvw8UxMH+QcXb21N1etmln0ZTG6XSF40Ra5R
	jZ0kTBhd7bfe/uCnWgeXPo3pUr4iR/hwqchI5tyrjqgcYWBg==
X-Google-Smtp-Source: AGHT+IG+YBuaqZS//xUlJYuIXroK6xy+Si9MeuUheCN9NI9oRVBHDenS8dshqBPVtG5aDNNVk/sgRA==
X-Received: by 2002:a05:6830:4487:b0:7c7:565c:4ce0 with SMTP id 46e09a7af769-7cae82e9a30mr6041699a34.1.1765849131449;
        Mon, 15 Dec 2025 17:38:51 -0800 (PST)
Received: from sean-HP-EliteBook-830-G6.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cadb34577dsm10574104a34.30.2025.12.15.17.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 17:38:51 -0800 (PST)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@kernel.org
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>,
	Quan Zhou <quan.zhou@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7925: fix potential deadlock in mt7925_roc_abort_sync
Date: Mon, 15 Dec 2025 19:38:49 -0600
Message-ID: <20251216013849.17976-1-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

roc_abort_sync() can deadlock with roc_work(). roc_work() holds
dev->mt76.mutex, while cancel_work_sync() waits for roc_work()
to finish. If the caller already owns the same mutex, both
sides block and no progress is possible.

This deadlock can occur during station removal when
mt76_sta_state() -> mt76_sta_remove() ->
mt7925_mac_sta_remove_link() -> mt7925_mac_link_sta_remove() ->
mt7925_roc_abort_sync() invokes cancel_work_sync() while
roc_work() is still running and holding dev->mt76.mutex.

This avoids the mutex deadlock and preserves exactly-once
work ownership.

Fixes: 45064d19fd3a ("wifi: mt76: mt7925: fix a potential association failure upon resuming")
Co-developed-by: Quan Zhou <quan.zhou@mediatek.com>
Signed-off-by: Quan Zhou <quan.zhou@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index ac3d485a2f78..11f551dea2f1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -449,12 +449,16 @@ void mt7925_roc_abort_sync(struct mt792x_dev *dev)
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
-					     mt7925_roc_iter, (void *)phy);
+
+	cancel_work(&phy->roc_work);
+
+	ieee80211_iterate_interfaces(mt76_hw(dev),
+				     IEEE80211_IFACE_ITER_RESUME_ALL,
+				     mt7925_roc_iter, (void *)phy);
 }
 EXPORT_SYMBOL_GPL(mt7925_roc_abort_sync);
 
-- 
2.43.0


