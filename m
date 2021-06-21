Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E433AE4AC
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jun 2021 10:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbhFUIXt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Jun 2021 04:23:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:59346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229618AbhFUIXs (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Jun 2021 04:23:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 379516109F;
        Mon, 21 Jun 2021 08:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624263694;
        bh=ydaDWQzg2e/0ELpm1tAPsh6ySt6S5KLu9QTSAOpbsyI=;
        h=From:To:Cc:Subject:Date:From;
        b=GUhh90tSLvDNRupwqbljiGx0VCFJBYuZkrX3be0htCY+V3gpZwLjFAOPEVqLBBbw+
         Pt69qrFr2pjqLy51Xka0o9SnFOk4+9Xj2WMOJuq8lPYk7SxJX6hwjoGapcOj79Vilr
         exgSGjoyYdzD/celxxAK6eacQB4k0ckpKfwS7UyP2bpBFK3rhwZWTVN93+p8L0wYLk
         JG9ZkOiJpILY25326CAXe7Wx/hXADQYYkNGyUKQdij+p+wCJORXT7s7IQIfj5/o/qh
         TxHfm2WG/qUvO7gKqX8p23oh/Obxqu7fVqQzXwk7F2I3uMIT7crbBzPWpShyfx0nL7
         XpgVkFfK91FvQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7915: fix endianness warning in mt7915_mac_add_txs_skb
Date:   Mon, 21 Jun 2021 10:21:31 +0200
Message-Id: <f89ce20876121f9c5731fcaab76661682e2a3369.1624263628.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix the following sparse warning in mt7915_mac_add_txs_skb routine:

drivers/net/wireless/mediatek/mt76/mt7915/mac.c:1235:29:
	warning: cast to restricted __le32
drivers/net/wireless/mediatek/mt76/mt7915/mac.c:1235:23:
	warning: restricted __le32 degrades to integer

Fixes: 3de4cb1756565 ("mt76: mt7915: add support for tx status reporting")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 2462704094b0..bbc996f86b5c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1232,7 +1232,7 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, int pid,
 		goto out;
 
 	info = IEEE80211_SKB_CB(skb);
-	if (!(txs_data[0] & le32_to_cpu(MT_TXS0_ACK_ERROR_MASK)))
+	if (!(txs_data[0] & cpu_to_le32(MT_TXS0_ACK_ERROR_MASK)))
 		info->flags |= IEEE80211_TX_STAT_ACK;
 
 	info->status.ampdu_len = 1;
-- 
2.31.1

