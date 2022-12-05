Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30AA5642E0A
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Dec 2022 17:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbiLEQ7V (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Dec 2022 11:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbiLEQ7U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Dec 2022 11:59:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D794D2F1
        for <linux-wireless@vger.kernel.org>; Mon,  5 Dec 2022 08:59:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 218D3B81185
        for <linux-wireless@vger.kernel.org>; Mon,  5 Dec 2022 16:59:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65FBBC433D6;
        Mon,  5 Dec 2022 16:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670259556;
        bh=uuN8nVrkd5vVBtmOwUgjehsXg8q6T+5cB2U9uMYVYXw=;
        h=From:To:Cc:Subject:Date:From;
        b=NgbcKfPHW8VKLGpQ/dgQP2835DKw11GPVKDLIJyTf0CLaz5BitRwzXg/8z8prDVcC
         XvtFOkwU9a9jfdhzR9Oixxxl9ovvA0vXOIXX5b4GtjZwItTnXHHxNJ/q6I6RM5didV
         Tpo7fQaNHcBy4V8L0Fp5lGS/kERmhf+/mqazBJw8SmHkfv67Z9tZcge+N8NVy/PdK8
         HTaQ2fJ7CaRu0FFF38sGHe6AA4/1x7GTiuvN50r2kGFlik1rciEYfDFSBVjxJOoWDX
         EJl+t+tJJgDVoW4EbXNOn/mgfbkGK7BiO3Frs2hNo5+0kBJGQuB1BJXG3r7w7Lq6e+
         oIuGMcJ5c8G1g==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: mt76: mt76x0: fix oob access in mt76x0_phy_get_target_power
Date:   Mon,  5 Dec 2022 17:59:04 +0100
Message-Id: <57996b878eca414bc5e43a2a97eca960c4aba18c.1670259466.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

After 'commit ba45841ca5eb ("wifi: mt76: mt76x02: simplify struct
mt76x02_rate_power")', mt76x02 relies on ht[0-7] rate_power data for
vht mcs{0,7}, while it uses vth[0-1] rate_power for vht mcs {8,9}.
Fix a possible out-of-bound access in mt76x0_phy_get_target_power routine.

Fixes: ba45841ca5eb ("wifi: mt76: mt76x02: simplify struct mt76x02_rate_power")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76x0/phy.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c b/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
index 6c6c8ada7943..d543ef3de65b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
@@ -642,7 +642,12 @@ mt76x0_phy_get_target_power(struct mt76x02_dev *dev, u8 tx_mode,
 		if (tx_rate > 9)
 			return -EINVAL;
 
-		*target_power = cur_power + dev->rate_power.vht[tx_rate];
+		*target_power = cur_power;
+		if (tx_rate > 7)
+			*target_power += dev->rate_power.vht[tx_rate - 8];
+		else
+			*target_power += dev->rate_power.ht[tx_rate];
+
 		*target_pa_power = mt76x0_phy_get_rf_pa_mode(dev, 1, tx_rate);
 		break;
 	default:
-- 
2.38.1

