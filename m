Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023F06F4065
	for <lists+linux-wireless@lfdr.de>; Tue,  2 May 2023 11:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbjEBJt1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 May 2023 05:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbjEBJtS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 May 2023 05:49:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F778527D
        for <linux-wireless@vger.kernel.org>; Tue,  2 May 2023 02:49:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C92786216E
        for <linux-wireless@vger.kernel.org>; Tue,  2 May 2023 09:49:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D506AC4339B;
        Tue,  2 May 2023 09:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683020953;
        bh=ZIpmGSH0TJPrlVHIEpiIMmL0R7hx6OvL5SWw+TDNq5g=;
        h=From:To:Cc:Subject:Date:From;
        b=K49UL84e5Tm56FlZ3kd9Qj6Zgj0xQialKTuKtyeTbEBsQjM4Tt4VXGoQwhqP2T2xM
         DNii4wWM66lZEePvOdKrpSkxgBy1ZI8l2ga291vpkLpqHoULoamvWh1w3C329j8ViZ
         Z+oGm7YXOmy5NCNiCMR7mB8jDxpht0mKc0POdKaSgBME14oUOXLHVNd+yrKclW3csh
         okw+b9Oa4wj5pDWVSAco/5RuDn34qrbT1HbFjMtfeDHk6D04mb8fwSFlrL9Z01GKYf
         Rf/yHjj1lJrdAvH1qXAa8Yd9BB/rT0IsTFCI6uJUV+toKhlXJQB3jqTxymZrbZnvVl
         U55YomKXbgCfA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next] wifi: mt76: mt76x02: remove WEP support
Date:   Tue,  2 May 2023 11:49:05 +0200
Message-Id: <d560f1a16c9024b6e4029bd0baf53384f4552f5a.1683020788.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Get rid of WEP support in mt76x02_set_key routine since it is not longer
supported upstream.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index dcbb5c605dfe..a9b770831844 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -413,12 +413,9 @@ int mt76x02_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	struct mt76x02_sta *msta;
 	struct mt76_wcid *wcid;
 	int idx = key->keyidx;
-	int ret;
 
 	/* fall back to sw encryption for unsupported ciphers */
 	switch (key->cipher) {
-	case WLAN_CIPHER_SUITE_WEP40:
-	case WLAN_CIPHER_SUITE_WEP104:
 	case WLAN_CIPHER_SUITE_TKIP:
 	case WLAN_CIPHER_SUITE_CCMP:
 		break;
@@ -471,16 +468,6 @@ int mt76x02_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	}
 	mt76_wcid_key_setup(&dev->mt76, wcid, key);
 
-	if (!msta) {
-		if (key || wcid->hw_key_idx == idx) {
-			ret = mt76x02_mac_wcid_set_key(dev, wcid->idx, key);
-			if (ret)
-				return ret;
-		}
-
-		return mt76x02_mac_shared_key_setup(dev, mvif->idx, idx, key);
-	}
-
 	return mt76x02_mac_wcid_set_key(dev, msta->wcid.idx, key);
 }
 EXPORT_SYMBOL_GPL(mt76x02_set_key);
-- 
2.40.1

