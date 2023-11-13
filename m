Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077887E99FA
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Nov 2023 11:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjKMKQ3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Nov 2023 05:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKMKQ2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Nov 2023 05:16:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6482AD7C
        for <linux-wireless@vger.kernel.org>; Mon, 13 Nov 2023 02:16:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62CAEC433C7;
        Mon, 13 Nov 2023 10:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699870584;
        bh=NZf6KRQ4WgFQvItiTWcRRhYVigRw48ovJsLdzKwat0g=;
        h=From:To:Cc:Subject:Date:From;
        b=sNugpiIV5J8R15/rRaCVzE/Qn7NCJCbla7qpoj9beYYJW0pYceHq2f+cOV8dGe8Xd
         S+QJAAh4vmS3xFXmLfnbsanXc1RyFmO/gTxr8WMP8TLQ66tFVanpo3r2WH4DyWqyFW
         azyfdf50UbI13WrS2lUSAdnQ/pMfKpF2jX6leSx809yXb8h725qtt/Wu01CNR1FQJn
         imRlJM6+ct0XbfU+zkVnMijQ+80DC9nc72u5ObeZpGtFnDvFFLy4LUoo2LFPhCpjLv
         5ksrzNLOj8FLXX8X2MheMTorbAC5VD1fgQfUFln3WE8jgz8r5E7Tk9/LL11LWsLBCb
         fFj6tkA/vuP8A==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, deren.wu@mediatek.com
Subject: [PATCH] wifi: mt76: mt7925: remove iftype from mt7925_init_eht_caps signature
Date:   Mon, 13 Nov 2023 11:16:19 +0100
Message-ID: <dafe6eebb84574fb375f0ade5b68feca6259bf76.1699870431.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Get rid of nl80211_iftype from mt7925_init_eht_caps routine signature
since it is not actually used.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 15c2fb0bcb1b..a080df58120f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -154,8 +154,7 @@ mt7925_init_he_caps(struct mt792x_phy *phy, enum nl80211_band band,
 
 static void
 mt7925_init_eht_caps(struct mt792x_phy *phy, enum nl80211_band band,
-		     struct ieee80211_sband_iftype_data *data,
-		     enum nl80211_iftype iftype)
+		     struct ieee80211_sband_iftype_data *data)
 {
 	struct ieee80211_sta_eht_cap *eht_cap = &data->eht_cap;
 	struct ieee80211_eht_cap_elem_fixed *eht_cap_elem = &eht_cap->eht_cap_elem;
@@ -256,7 +255,7 @@ __mt7925_set_stream_he_eht_caps(struct mt792x_phy *phy,
 
 		data[n].types_mask = BIT(i);
 		mt7925_init_he_caps(phy, band, &data[n], i);
-		mt7925_init_eht_caps(phy, band, &data[n], i);
+		mt7925_init_eht_caps(phy, band, &data[n]);
 
 		n++;
 	}
-- 
2.41.0

