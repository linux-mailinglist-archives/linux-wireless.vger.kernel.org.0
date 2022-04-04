Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220B44F1A8C
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Apr 2022 23:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379049AbiDDVSg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Apr 2022 17:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379548AbiDDRaM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Apr 2022 13:30:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8668124BF9
        for <linux-wireless@vger.kernel.org>; Mon,  4 Apr 2022 10:28:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2934760D29
        for <linux-wireless@vger.kernel.org>; Mon,  4 Apr 2022 17:28:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D16DC2BBE4;
        Mon,  4 Apr 2022 17:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649093294;
        bh=T8rWXhNuqO8D+8WJdfkxSjv2dbhMzpbfLsgE+/tuISI=;
        h=From:To:Cc:Subject:Date:From;
        b=SFfUPGaJdPuOq1Tgog0cxE/ULb180aIxCXcNm7E5or5ti2zq4YJqBwAJyuNDjh9mX
         ITc0HuXEF4qc2N1B+gR05gRODRSAKumTtPG+ckXIA/7pqbgekZptECwX16KB1Umxba
         NOV23Bywv8reyRTGT3B+owVzQI0w+b/OOpvXySXYk7rQwTFup9Y330bGi99FYHX1j0
         P+revV62irVoo3ZcFgL7vJW3RcjGQxm/QfRxAnDMntjsjQOqScJdn+nFacXllnWUEI
         PxFMODQSNlQmANPQ7gV8XQ1xtAP/j2AzCqZL3+XrU1Q2GmAB+6AKCRXNdv8g8vHoNr
         yVGWG2mHnqdSg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: mt7915: use 0xff to initialize bitrate_mask in mt7915_init_bitrate_mask
Date:   Mon,  4 Apr 2022 19:28:02 +0200
Message-Id: <a62fcd69daa16e9fe5a75fb6ea1a7198bc9072c8.1649093220.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use 0xff (GENMASK(7,0)) in mt7915_init_bitrate_mask routine in order to
initialize bitrate_mask structure in order to avoid truncating value in
memset().

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 865694c755cf..9b8defb15b4e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -174,14 +174,14 @@ static void mt7915_init_bitrate_mask(struct ieee80211_vif *vif)
 
 	for (i = 0; i < ARRAY_SIZE(mvif->bitrate_mask.control); i++) {
 		mvif->bitrate_mask.control[i].gi = NL80211_TXRATE_DEFAULT_GI;
-		mvif->bitrate_mask.control[i].he_gi = GENMASK(7, 0);
-		mvif->bitrate_mask.control[i].he_ltf = GENMASK(7, 0);
+		mvif->bitrate_mask.control[i].he_gi = 0xff;
+		mvif->bitrate_mask.control[i].he_ltf = 0xff;
 		mvif->bitrate_mask.control[i].legacy = GENMASK(31, 0);
-		memset(mvif->bitrate_mask.control[i].ht_mcs, GENMASK(7, 0),
+		memset(mvif->bitrate_mask.control[i].ht_mcs, 0xff,
 		       sizeof(mvif->bitrate_mask.control[i].ht_mcs));
-		memset(mvif->bitrate_mask.control[i].vht_mcs, GENMASK(15, 0),
+		memset(mvif->bitrate_mask.control[i].vht_mcs, 0xff,
 		       sizeof(mvif->bitrate_mask.control[i].vht_mcs));
-		memset(mvif->bitrate_mask.control[i].he_mcs, GENMASK(15, 0),
+		memset(mvif->bitrate_mask.control[i].he_mcs, 0xff,
 		       sizeof(mvif->bitrate_mask.control[i].he_mcs));
 	}
 }
-- 
2.35.1

