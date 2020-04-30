Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07301BF1EE
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2020 09:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgD3H7r (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Apr 2020 03:59:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:49106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbgD3H7r (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Apr 2020 03:59:47 -0400
Received: from localhost.localdomain.com (unknown [151.48.130.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C4E820838;
        Thu, 30 Apr 2020 07:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588233586;
        bh=XwZZ3X2QcyIEbrJyTLwyjUo+RQKYXCcvBb8PPP5q1mw=;
        h=From:To:Cc:Subject:Date:From;
        b=kamgEIWit0T5LfqKCWQZvHL5nB1kQf5y+Cy2/C2hpogLn0uYybt4ISb9XtkK/X99S
         p9Wop5C3MFjXwrk2xcvucfs5XCJEhvFizO/33XeS5Gt0BgiD+FTFn6RY4wQcT9wFM5
         hxe/x8E9AH3ancl5bleKr1TBdeX6wnaL4wyqueLk=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH] mt76: mt7615: do not mark sched_scan disabled in mt7615_scan_work
Date:   Thu, 30 Apr 2020 09:59:31 +0200
Message-Id: <c265ff87ff0286968cb527bf51c1f8b734fad582.1588233520.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For the moment offload firmware supports just one entry in the scheduled
scan plan and so it runs till it is disabled by the userspace.
Do not mark the hw scheduled scan as disabled in mt7615_scan_work
after receiving a scan result

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 23bc7f1262d0..5e54c7ffae0b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -818,7 +818,6 @@ void mt7615_scan_work(struct work_struct *work)
 			clear_bit(MT76_HW_SCANNING, &phy->mt76->state);
 			ieee80211_scan_completed(phy->mt76->hw, &info);
 		} else {
-			clear_bit(MT76_HW_SCHED_SCANNING, &phy->mt76->state);
 			ieee80211_sched_scan_results(phy->mt76->hw);
 		}
 		dev_kfree_skb(skb);
-- 
2.25.4

