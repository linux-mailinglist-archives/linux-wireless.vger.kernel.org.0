Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74AC4EC9E0
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Mar 2022 18:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348663AbiC3Qqs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Mar 2022 12:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348939AbiC3Qqq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Mar 2022 12:46:46 -0400
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130A51F0462
        for <linux-wireless@vger.kernel.org>; Wed, 30 Mar 2022 09:44:55 -0700 (PDT)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1648658694; bh=TCXTIKLByYkcWPAN15ugnvnT5+70dtEbuJhaMYUrHEk=;
        h=From:To:Cc:Subject:Date:From;
        b=EY2Dsnpx9t4nzpqnh+9mO8tECl8E+oM4r6jJTDxjDXcvjysXv+EgB1RCH3rhpwYHp
         dVL0sd8J3P+9JVfxRr3VEuUI5JvruQT9IQiLPozdWnPnf8CbXsWH9LLIyOs9ELViaU
         tvghP3Or4NJ0SARvk0Ew5pcKAn2gq10GBf8M5BxCUgwUjbFQ52vCzLCJ53ixhhBqjJ
         XO0Epfw5S4GgAuPo21pH1hZqy6EMpvT52YJCw76uvWSbLD8anz2iJeUUpcZqEsPCB4
         SO9NCtFs7co7Hy6RmcrAoERy/ngquKGclHx73IL9v70N7Sg77uuPWs+ZTO3TRC7yiy
         737oyoXLBECOg==
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v5.18] ath9k: Properly clear TX status area before reporting to mac80211
Date:   Wed, 30 Mar 2022 18:44:09 +0200
Message-Id: <20220330164409.16645-1-toke@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The ath9k driver was not properly clearing the status area in the
ieee80211_tx_info struct before reporting TX status to mac80211. Instead,
it was manually filling in fields, which meant that fields introduced later
were left as-is.

Conveniently, mac80211 actually provides a helper to zero out the status
area, so use that to make sure we zero everything.

The last commit touching the driver function writing the status information
seems to have actually been fixing an issue that was also caused by the
area being uninitialised; but it only added clearing of a single field
instead of the whole struct. That is now redundant, though, so revert that
commit and use it as a convenient Fixes tag.

Fixes: cc591d77aba1 ("ath9k: Make sure to zero status.tx_time before reporting TX status")
Reported-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@toke.dk>
---
 drivers/net/wireless/ath/ath9k/xmit.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/xmit.c b/drivers/net/wireless/ath/ath9k/xmit.c
index d0caf1de2bde..cbcf96ac303e 100644
--- a/drivers/net/wireless/ath/ath9k/xmit.c
+++ b/drivers/net/wireless/ath/ath9k/xmit.c
@@ -2553,6 +2553,8 @@ static void ath_tx_rc_status(struct ath_softc *sc, struct ath_buf *bf,
 	struct ath_hw *ah = sc->sc_ah;
 	u8 i, tx_rateindex;
 
+	ieee80211_tx_info_clear_status(tx_info);
+
 	if (txok)
 		tx_info->status.ack_signal = ts->ts_rssi;
 
@@ -2595,9 +2597,6 @@ static void ath_tx_rc_status(struct ath_softc *sc, struct ath_buf *bf,
 	}
 
 	tx_info->status.rates[tx_rateindex].count = ts->ts_longretry + 1;
-
-	/* we report airtime in ath_tx_count_airtime(), don't report twice */
-	tx_info->status.tx_time = 0;
 }
 
 static void ath_tx_processq(struct ath_softc *sc, struct ath_txq *txq)
-- 
2.35.1

