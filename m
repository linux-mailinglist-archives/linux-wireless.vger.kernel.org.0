Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3B931FDCA
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Feb 2021 18:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbhBSRXA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Feb 2021 12:23:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:34630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229527AbhBSRW7 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Feb 2021 12:22:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 88CDB64E04;
        Fri, 19 Feb 2021 17:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613755339;
        bh=Pglaa2VdcLC3H+ELhNQHc7RDI8qfKklPc+E0f3Vy4RQ=;
        h=From:To:Cc:Subject:Date:From;
        b=czmo/OEodsGp+UTc4A6z5P8IgKPdzcmnSzi6hpw80mylY9Im2BXtCWu9bE+JYejrZ
         tga/J3GiHS8n1H1q6QK65n8Er43HjkFraDo4yyP02f0Zolxg7+d//qCxoqaXdmuNGp
         s5UBE60N4y9eSXHdB+qkxy8BnT4Glw16BsqmmQshWnDj+lL3qqvDm9CCYfKGIX2luk
         tN1MT1Q+E1p7Jh5dcqWakQHPQNJefD8nXy845vXCjB/QrBWI110r3Pmrp7CP/ZaG+C
         CKXFjwOWBBSltgqMxojP0gQtzKPiBo2E5O19TGwG86nI1HsNano71riPLOkFCrikpB
         pnjaUixQF1JKg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH] mt76: mt7615: fix memory leak in mt7615_coredump_work
Date:   Fri, 19 Feb 2021 18:22:11 +0100
Message-Id: <5e42d2f0735bc7af8b03365cca056a3a38a650fe.1613755089.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Similar to the issue fixed in mt7921_coredump_work, fix a possible memory
leak in mt7615_coredump_work routine.

Fixes: d2bf7959d9c0f ("mt76: mt7663: introduce coredump support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 9bae2f66e1ce..3c4fbe275f49 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -2313,8 +2313,10 @@ void mt7615_coredump_work(struct work_struct *work)
 			break;
 
 		skb_pull(skb, sizeof(struct mt7615_mcu_rxd));
-		if (data + skb->len - dump > MT76_CONNAC_COREDUMP_SZ)
-			break;
+		if (data + skb->len - dump > MT76_CONNAC_COREDUMP_SZ) {
+			dev_kfree_skb(skb);
+			continue;
+		}
 
 		memcpy(data, skb->data, skb->len);
 		data += skb->len;
-- 
2.29.2

