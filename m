Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204357DF1C0
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Nov 2023 12:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjKBLzX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Nov 2023 07:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjKBLzW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Nov 2023 07:55:22 -0400
Received: from forward101c.mail.yandex.net (forward101c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D57C2
        for <linux-wireless@vger.kernel.org>; Thu,  2 Nov 2023 04:55:16 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-46.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-46.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:4212:0:640:eaad:0])
        by forward101c.mail.yandex.net (Yandex) with ESMTP id C696C608DE;
        Thu,  2 Nov 2023 14:55:12 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-46.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id BtVHt24DeOs0-Qk2MbnM3;
        Thu, 02 Nov 2023 14:55:12 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1698926112; bh=MWumY9TTCrkvyQHhFDPzxgCnP/7bIwwPhUbwTArOtU4=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=ovu6OuiIMvFEoYBNveqVJKaOPpJNztU+6sHJuI5ydB2d0H6fXYcCR+Av7lswIBd1U
         cQJ+wygJwkXUVUEUs2LBxETxXmaUjhE5YAfj7Jt6V7DCEjQTWMFGOxFnJ4fl8vbPei
         Nijnf6d5ImmS7mFaR9/K/sBDX/ZQFxyIwF5gvpio=
Authentication-Results: mail-nwsmtp-smtp-production-main-46.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Kalle Valo <kvalo@kernel.org>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: ath10k: simplify __ath10k_htt_tx_txq_recalc()
Date:   Thu,  2 Nov 2023 14:54:52 +0300
Message-ID: <20231102115459.69791-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since 'ieee80211_txq_get_depth()' allows NULL for 2nd and
3rd arguments, simplify '__ath10k_htt_tx_txq_recalc()' by
dropping unused 'frame_cnt'. Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/ath/ath10k/htt_tx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/htt_tx.c b/drivers/net/wireless/ath/ath10k/htt_tx.c
index be4d4536aaa8..5d814162e02b 100644
--- a/drivers/net/wireless/ath/ath10k/htt_tx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_tx.c
@@ -40,7 +40,6 @@ static void __ath10k_htt_tx_txq_recalc(struct ieee80211_hw *hw,
 	struct ath10k *ar = hw->priv;
 	struct ath10k_sta *arsta;
 	struct ath10k_vif *arvif = (void *)txq->vif->drv_priv;
-	unsigned long frame_cnt;
 	unsigned long byte_cnt;
 	int idx;
 	u32 bit;
@@ -67,7 +66,7 @@ static void __ath10k_htt_tx_txq_recalc(struct ieee80211_hw *hw,
 	bit = BIT(peer_id % 32);
 	idx = peer_id / 32;
 
-	ieee80211_txq_get_depth(txq, &frame_cnt, &byte_cnt);
+	ieee80211_txq_get_depth(txq, NULL, &byte_cnt);
 	count = ath10k_htt_tx_txq_calc_size(byte_cnt);
 
 	if (unlikely(peer_id >= ar->htt.tx_q_state.num_peers) ||
-- 
2.41.0

