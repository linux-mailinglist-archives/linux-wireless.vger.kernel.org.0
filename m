Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 841F83CD1E
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2019 15:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404034AbfFKNg6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jun 2019 09:36:58 -0400
Received: from mail.neratec.com ([46.140.151.2]:47108 "EHLO mail.neratec.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403885AbfFKNg6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jun 2019 09:36:58 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.neratec.com (Postfix) with ESMTP id 83704CE037C;
        Tue, 11 Jun 2019 15:36:56 +0200 (CEST)
Received: from mail.neratec.com ([127.0.0.1])
        by localhost (mail.neratec.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Qj05xX-R65vF; Tue, 11 Jun 2019 15:36:56 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.neratec.com (Postfix) with ESMTP id 60FE8CE0391;
        Tue, 11 Jun 2019 15:36:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.neratec.com 60FE8CE0391
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=neratec.com;
        s=9F5C293A-195B-11E9-BBA5-B4F3B9D999CA; t=1560260216;
        bh=yArwEU6daWaFYRDc/nGFrc6sv1fgiX3c6YkMQ05tYNk=;
        h=From:To:Date:Message-Id;
        b=AVvqjA1LgVlsSnyJrObFggwjiUKniFpSqRY2sr3lCz3QicAZ0VBjxomRrRYmFwgk/
         53j1hcMcWCIY2+wkpujxKKIkuxJGEt4Fk8KL2jDizw7FL+0TgRSdZEQ5WYdSLC7RP5
         633Dl2x7dDFSfFtmLpbiiVsMyEkhnHL9rDk0vG5wFZRY/JfaMM82LvhJYqWyFBLGFS
         K74N2fXaktQRHdFxU4H6ySdp50kk4G2QaTBUTjIeP5XXtaFFgCjZzC4WYrlPKxewZx
         6gt8V9Jn1w9kFmRY1iVAJK1dAHlzLtvT2Bj2T+1RQfAUdctC3x2CDV9GT8ozyx/Y3K
         UYoHRNiCP1L9g==
X-Virus-Scanned: amavisd-new at neratec.com
Received: from mail.neratec.com ([127.0.0.1])
        by localhost (mail.neratec.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id e2QVJmLtjwjt; Tue, 11 Jun 2019 15:36:56 +0200 (CEST)
Received: from zefir.lan.neratec.com (zefir.lan.neratec.com [172.29.101.12])
        by mail.neratec.com (Postfix) with ESMTPSA id 42CEECE037C;
        Tue, 11 Jun 2019 15:36:56 +0200 (CEST)
From:   Zefir Kurtisi <zefir.kurtisi@neratec.com>
To:     linux-wireless@vger.kernel.org
Cc:     kvalo@codeaurora.org, nbd@nbd.name
Subject: [PATCH v2] ath9k: correctly handle short radar pulses (fixes 3c0efb745a)
Date:   Tue, 11 Jun 2019 15:36:56 +0200
Message-Id: <20190611133656.16964-1-zefir.kurtisi@neratec.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190611131006.29715-1-zefir.kurtisi@neratec.com>
References: <20190611131006.29715-1-zefir.kurtisi@neratec.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Changes to v1:
* typos fixed in commit-message
--

In commit '3c0efb745a17 ("ath9k: discard undersized packets")'
the lower bound of RX packets was set to 10 (min ACK size) to
filter those that would otherwise be treated as invalid at
mac80211.

Alas, short radar pulses are reported as PHY_ERROR frames
with length set to 3. Therefore their detection stopped
working after that commit.

NOTE: ath9k drivers built thereafter will not pass DFS
certification.

This extends the criteria for short packets to explicitly
handle PHY_ERROR frames.

Signed-off-by: Zefir Kurtisi <zefir.kurtisi@neratec.com>
---
 drivers/net/wireless/ath/ath9k/recv.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/recv.c b/drivers/net/wireless/ath/ath9k/recv.c
index 4e97f7f3b2a3..5519c144d1f1 100644
--- a/drivers/net/wireless/ath/ath9k/recv.c
+++ b/drivers/net/wireless/ath/ath9k/recv.c
@@ -815,6 +815,7 @@ static int ath9k_rx_skb_preprocess(struct ath_softc *sc,
 	struct ath_common *common = ath9k_hw_common(ah);
 	struct ieee80211_hdr *hdr;
 	bool discard_current = sc->rx.discard_next;
+	bool is_phyerr;
 
 	/*
 	 * Discard corrupt descriptors which are marked in
@@ -827,8 +828,11 @@ static int ath9k_rx_skb_preprocess(struct ath_softc *sc,
 
 	/*
 	 * Discard zero-length packets and packets smaller than an ACK
+	 * which are not PHY_ERROR (short radar pulses have a length of 3)
 	 */
-	if (rx_stats->rs_datalen < 10) {
+	is_phyerr = rx_stats->rs_status & ATH9K_RXERR_PHY;
+	if (!rx_stats->rs_datalen ||
+	    (rx_stats->rs_datalen < 10 && !is_phyerr)) {
 		RX_STAT_INC(sc, rx_len_err);
 		goto corrupt;
 	}
-- 
2.17.1

