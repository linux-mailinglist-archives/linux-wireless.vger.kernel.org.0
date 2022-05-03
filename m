Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60AD517D00
	for <lists+linux-wireless@lfdr.de>; Tue,  3 May 2022 08:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiECGHy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 May 2022 02:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiECGHw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 May 2022 02:07:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD3D33351
        for <linux-wireless@vger.kernel.org>; Mon,  2 May 2022 23:04:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 700A5B81C89
        for <linux-wireless@vger.kernel.org>; Tue,  3 May 2022 06:04:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D87C385A4;
        Tue,  3 May 2022 06:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651557857;
        bh=JaeLcKSUKWQsW5Alndt0sH184FKi93Smpt1/is3vpHA=;
        h=From:To:Cc:Subject:Date:From;
        b=J/j0Wkg6UpjKxWZvnOObpehI351Y6yyC/EuUjSNIh3+JBI5KzUSNqUIJ5mYB5erxn
         4Xpeiqf/OY3Rs/MbwdI+FgMsHZ9APGDZL+oD7Ds8auwbqG8Iw9+dR4DaCVa4caX7RZ
         KJeqc9cNPGuSCECqGXlBcd0i7WlrJRmmfNQsm2ysElp2GfNpw/TZHf0Pw0cY2Cghou
         TKG85ITnhjc/lnFInP34Ix6do2p5CNeyV0HNx2hPm27rlVftokk0wtlhchWGjsFjNg
         GNSXSGV5Ew/BEySvqnUQF567WGnoahMdd831PzT5yCyg1oCevKicgOKXAh4+Refg5T
         hz5Qb5Thy6uOg==
From:   Kalle Valo <kvalo@kernel.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/2] ath11k: mac: fix too long line
Date:   Tue,  3 May 2022 09:04:14 +0300
Message-Id: <20220503060415.24499-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kalle Valo <quic_kvalo@quicinc.com>

checkpatch warns:

drivers/net/wireless/ath/ath11k/mac.c:7760: line length of 91 exceeds 90 columns

This was introduced by commit 046d2e7c50e3 ("mac80211: prepare sta handling for
MLO support").

Compile tested only.

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index c76cac5d6849..32fb0142124d 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -7735,6 +7735,7 @@ ath11k_mac_validate_vht_he_fixed_rate_settings(struct ath11k *ar, enum nl80211_b
 	bool he_fixed_rate = false, vht_fixed_rate = false;
 	struct ath11k_peer *peer, *tmp;
 	const u16 *vht_mcs_mask, *he_mcs_mask;
+	struct ieee80211_link_sta *deflink;
 	u8 vht_nss, he_nss;
 	bool ret = true;
 
@@ -7757,13 +7758,16 @@ ath11k_mac_validate_vht_he_fixed_rate_settings(struct ath11k *ar, enum nl80211_b
 	spin_lock_bh(&ar->ab->base_lock);
 	list_for_each_entry_safe(peer, tmp, &ar->ab->peers, list) {
 		if (peer->sta) {
-			if (vht_fixed_rate && (!peer->sta->deflink.vht_cap.vht_supported ||
-					       peer->sta->deflink.rx_nss < vht_nss)) {
+			deflink = &peer->sta->deflink;
+
+			if (vht_fixed_rate && (!deflink->vht_cap.vht_supported ||
+					       deflink->rx_nss < vht_nss)) {
 				ret = false;
 				goto out;
 			}
-			if (he_fixed_rate && (!peer->sta->deflink.he_cap.has_he ||
-					      peer->sta->deflink.rx_nss < he_nss)) {
+
+			if (he_fixed_rate && (!deflink->he_cap.has_he ||
+					      deflink->rx_nss < he_nss)) {
 				ret = false;
 				goto out;
 			}

base-commit: f39af96d352dd4f36a4a43601ea90561e17e5ca6
-- 
2.30.2

