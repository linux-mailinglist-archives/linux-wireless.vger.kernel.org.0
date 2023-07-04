Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA28A7477EE
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jul 2023 19:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjGDRh0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Jul 2023 13:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjGDRhY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Jul 2023 13:37:24 -0400
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE3E10D7
        for <linux-wireless@vger.kernel.org>; Tue,  4 Jul 2023 10:37:22 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:99b:0:640:5ae0:0])
        by forward101a.mail.yandex.net (Yandex) with ESMTP id 7479A46C85;
        Tue,  4 Jul 2023 20:37:20 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id JbWSfGGDViE0-MWC7JUU3;
        Tue, 04 Jul 2023 20:37:20 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1688492240;
        bh=gbYg+lFLvg7+x8qiBmJOV1lCnuPpK7be9jfNm+8ZynA=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=TWeSNr/oSiTqZNZe2hCUYLKsOfhEGXNeKUGbSgsuhmKYyy2p9i2ZyeqPMutpZi7MI
         I1RsmAPiiJJMAnEKKXKuxzstmt2+gEtlX9H6p7c6kfNu8sXHc27ZcdH7QdEZE36Uhy
         twl0Ake5PoxZqaadUNTWGx/QJEdL5BfAcNw4CXWM=
Authentication-Results: mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: ath12k: relax list iteration in ath12k_mac_vif_unref()
Date:   Tue,  4 Jul 2023 20:37:12 +0300
Message-ID: <20230704173718.73462-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In 'ath12k_mac_vif_unref()', 'dp->tx_desc_used_list[i]'
is not altered so 'list_for_each_entry()' should be safe.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/ath/ath12k/mac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 1bb9802ef569..a58c374f23f7 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5201,7 +5201,7 @@ static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
 
 static void ath12k_mac_vif_unref(struct ath12k_dp *dp, struct ieee80211_vif *vif)
 {
-	struct ath12k_tx_desc_info *tx_desc_info, *tmp1;
+	struct ath12k_tx_desc_info *tx_desc_info;
 	struct ath12k_skb_cb *skb_cb;
 	struct sk_buff *skb;
 	int i;
@@ -5209,8 +5209,8 @@ static void ath12k_mac_vif_unref(struct ath12k_dp *dp, struct ieee80211_vif *vif
 	for (i = 0; i < ATH12K_HW_MAX_QUEUES; i++) {
 		spin_lock_bh(&dp->tx_desc_lock[i]);
 
-		list_for_each_entry_safe(tx_desc_info, tmp1, &dp->tx_desc_used_list[i],
-					 list) {
+		list_for_each_entry(tx_desc_info, &dp->tx_desc_used_list[i],
+				    list) {
 			skb = tx_desc_info->skb;
 			if (!skb)
 				continue;
-- 
2.41.0

