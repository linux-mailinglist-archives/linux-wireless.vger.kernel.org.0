Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BD5714C88
	for <lists+linux-wireless@lfdr.de>; Mon, 29 May 2023 16:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjE2Oy6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 May 2023 10:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjE2Oy5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 May 2023 10:54:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD20B7
        for <linux-wireless@vger.kernel.org>; Mon, 29 May 2023 07:54:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F359D618D3
        for <linux-wireless@vger.kernel.org>; Mon, 29 May 2023 14:54:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01AF0C433EF;
        Mon, 29 May 2023 14:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685372095;
        bh=SMHn6wTSbVnhz3UizFfT772MdT40Cv5srR/7EX50dPc=;
        h=From:To:Cc:Subject:Date:From;
        b=rbhyxAD0txxLqDj6Md2m+pRpkh+sCQpcs1dwdTy7Z3a3qO6PWDaV5XKca3+BRql3B
         sVIIGH8dqDJL77QqCTqhiHggAcvklgQzeWEVkHTsnveQV7jJgmVxEswnHFf4IpgJra
         qt1K7NDpRSEGMZs6yphfUqOrmtXS2F/hPF4uucr6QqwDKcioeHBJ7kZ2X1niQF7m9o
         YqVfjXAdfaw75hrd05jtiyGE4bLB2sqP8MUFXrNyk0Alean7vPoIYEjH0DbdsaryIY
         hQZGBjec1InXSEDmRVY/iPdaZJ8GDurUvNiYg1qIK8eoVGDmckryBK0uNDGNEhXyEA
         Nv6uMne8rIxsg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7996: rely on mt76_sta_stats in mt76_wcid
Date:   Mon, 29 May 2023 16:54:32 +0200
Message-Id: <183a95ac89a4f5cb567e09fd214ef134ffc2329f.1685371997.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mt76 now accounts station stats in mt76_sta_stats available in mt76_wcid
struct. Get rid of mt7996 private copy.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    | 7 ++++---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h | 2 --
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 130eb7b4fd91..0bd097ece25c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1319,9 +1319,10 @@ mt7996_mac_tx_free(struct mt7996_dev *dev, void *data, int len)
 }
 
 static bool
-mt7996_mac_add_txs_skb(struct mt7996_dev *dev, struct mt76_wcid *wcid, int pid,
-		       __le32 *txs_data, struct mt76_sta_stats *stats)
+mt7996_mac_add_txs_skb(struct mt7996_dev *dev, struct mt76_wcid *wcid,
+		       int pid, __le32 *txs_data)
 {
+	struct mt76_sta_stats *stats = &wcid->stats;
 	struct ieee80211_supported_band *sband;
 	struct mt76_dev *mdev = &dev->mt76;
 	struct mt76_phy *mphy;
@@ -1483,7 +1484,7 @@ static void mt7996_mac_add_txs(struct mt7996_dev *dev, void *data)
 
 	msta = container_of(wcid, struct mt7996_sta, wcid);
 
-	mt7996_mac_add_txs_skb(dev, wcid, pid, txs_data, &msta->stats);
+	mt7996_mac_add_txs_skb(dev, wcid, pid, txs_data);
 
 	if (!wcid->sta)
 		goto out;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 0975774fe244..c7917e301c87 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -1187,7 +1187,7 @@ static void mt7996_ethtool_worker(void *wi_data, struct ieee80211_sta *sta)
 	if (msta->vif->mt76.idx != wi->idx)
 		return;
 
-	mt76_ethtool_worker(wi, &msta->stats, true);
+	mt76_ethtool_worker(wi, &msta->wcid.stats, true);
 }
 
 static
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 4d7dcb95a620..c9f0e541abe4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -106,8 +106,6 @@ struct mt7996_sta {
 	unsigned long jiffies;
 	unsigned long ampdu_state;
 
-	struct mt76_sta_stats stats;
-
 	struct mt76_connac_sta_key_conf bip;
 
 	struct {
-- 
2.40.1

