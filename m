Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85FCA7631C8
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jul 2023 11:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjGZJYF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jul 2023 05:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbjGZJXf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jul 2023 05:23:35 -0400
Received: from forward103c.mail.yandex.net (forward103c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E817C1BFF
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jul 2023 02:21:19 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:2481:0:640:e0:0])
        by forward103c.mail.yandex.net (Yandex) with ESMTP id 6563660043;
        Wed, 26 Jul 2023 12:21:17 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id GLH0FV0DRCg0-yw47g0Pz;
        Wed, 26 Jul 2023 12:21:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1690363277;
        bh=U9IgHL7mNlyyfl12D9f7wkhVJ0J0ccSpDZilKFxxF+I=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=U80GY3XVcnB4j947M5ExY/ZrLwhdElF/4CKvstspq1pc5B2ByMs+EdH0VXSvG3CM2
         3eUH9E0VfKVsR2Fdxdk8HvW6MwG17tMz106nc6yvwEpYPVmYq/GS8n8Ylu6p6ve3t8
         NLG7oaeMzdPpCOoCVUTZ4Mr+BJX3fZHP2BesvDoA=
Authentication-Results: mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Ziyang Huang <hzyitc@outlook.com>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: ath11k: simplify ath11k_mac_validate_vht_he_fixed_rate_settings()
Date:   Wed, 26 Jul 2023 12:21:02 +0300
Message-ID: <20230726092113.78794-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In 'ath11k_mac_validate_vht_he_fixed_rate_settings()', 'ar->ab->peers'
list is not altered so 'list_for_each_entry()' should be safe.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/ath/ath11k/mac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 8c77ade49437..2aadf2c387b6 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -8255,7 +8255,7 @@ ath11k_mac_validate_vht_he_fixed_rate_settings(struct ath11k *ar, enum nl80211_b
 					       const struct cfg80211_bitrate_mask *mask)
 {
 	bool he_fixed_rate = false, vht_fixed_rate = false;
-	struct ath11k_peer *peer, *tmp;
+	struct ath11k_peer *peer;
 	const u16 *vht_mcs_mask, *he_mcs_mask;
 	struct ieee80211_link_sta *deflink;
 	u8 vht_nss, he_nss;
@@ -8278,7 +8278,7 @@ ath11k_mac_validate_vht_he_fixed_rate_settings(struct ath11k *ar, enum nl80211_b
 
 	rcu_read_lock();
 	spin_lock_bh(&ar->ab->base_lock);
-	list_for_each_entry_safe(peer, tmp, &ar->ab->peers, list) {
+	list_for_each_entry(peer, &ar->ab->peers, list) {
 		if (peer->sta) {
 			deflink = &peer->sta->deflink;
 
-- 
2.41.0

