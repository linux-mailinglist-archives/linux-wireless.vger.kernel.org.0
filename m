Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E63A5288B1
	for <lists+linux-wireless@lfdr.de>; Mon, 16 May 2022 17:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237074AbiEPPXv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 May 2022 11:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbiEPPXs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 May 2022 11:23:48 -0400
Received: from ns.iliad.fr (ns.iliad.fr [212.27.33.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D693BFBD
        for <linux-wireless@vger.kernel.org>; Mon, 16 May 2022 08:23:45 -0700 (PDT)
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id B5AB2201F3;
        Mon, 16 May 2022 17:23:43 +0200 (CEST)
Received: from sakura (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id B28052019F;
        Mon, 16 May 2022 17:23:43 +0200 (CEST)
Message-ID: <cd2735a40da7f4fcc5323e3fca3775e7b5402ece.camel@freebox.fr>
Subject: [PATCH] ath10k: fix misreported tx bandwidth for 160Mhz
From:   Maxime Bizon <mbizon@freebox.fr>
Reply-To: mbizon@freebox.fr
To:     Kalle Valo <kvalo@kernel.org>
Cc:     ath10k@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>
Date:   Mon, 16 May 2022 17:23:43 +0200
Organization: Freebox
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Mon May 16 17:23:43 2022 +0200 (CEST)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Because of this missing switch case, 160Mhz transmit was reported as
20Mhz, leading to wrong airtime calculation and AQL limiting max
throughput.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 drivers/net/wireless/ath/ath10k/htt_rx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireless/ath/ath10k/htt_rx.c
index 771252dd6d4e..e8727c0b0171 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -3884,6 +3884,10 @@ ath10k_update_per_peer_tx_stats(struct ath10k *ar,
 		arsta->tx_info.status.rates[0].flags |=
 				IEEE80211_TX_RC_80_MHZ_WIDTH;
 		break;
+	case RATE_INFO_BW_160:
+		arsta->tx_info.status.rates[0].flags |=
+				IEEE80211_TX_RC_160_MHZ_WIDTH;
+		break;
 	}
 
 	if (peer_stats->succ_pkts) {
-- 
2.17.1


