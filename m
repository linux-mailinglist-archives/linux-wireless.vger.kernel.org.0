Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4623B312513
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Feb 2021 16:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhBGPQz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 7 Feb 2021 10:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhBGPQo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 7 Feb 2021 10:16:44 -0500
X-Greylist: delayed 392 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 07 Feb 2021 07:16:03 PST
Received: from mail.blocktrron.ovh (mars.blocktrron.ovh [IPv6:2001:41d0:401:3000::cbd])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CFEC061788
        for <linux-wireless@vger.kernel.org>; Sun,  7 Feb 2021 07:16:03 -0800 (PST)
Received: from localhost.localdomain (p200300e53f3fbd004aa0d92dd69c6c60.dip0.t-ipconnect.de [IPv6:2003:e5:3f3f:bd00:4aa0:d92d:d69c:6c60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.blocktrron.ovh (Postfix) with ESMTPSA id BD7631E948;
        Sun,  7 Feb 2021 16:09:27 +0100 (CET)
From:   David Bauer <mail@david-bauer.net>
To:     linux-wireless@vger.kernel.org
Cc:     lorenzo@kernel.org, nbd@nbd.name
Subject: [PATCH] mt76: mt76x0: disable GTK offloading
Date:   Sun,  7 Feb 2021 16:09:17 +0100
Message-Id: <20210207150917.75536-1-mail@david-bauer.net>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When operating two VAP on a MT7610 with encryption (PSK2, SAE, OWE),
only the first one to be created will transmit properly encrypteded
frames.

All subsequently created VAPs will sent out frames with the payload left
unencrypted, breaking multicast traffic (ICMP6 NDP) and potentially
disclosing information to a third party.

Disable GTK offloading and encrypt these frames in software to
circumvent this issue. THis only seems to be necessary on MT7610 chips,
as MT7612 is not affected from our testing.

Signed-off-by: David Bauer <mail@david-bauer.net>
---
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index 7ac20d3c16d7..aaa597b941cd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -447,6 +447,10 @@ int mt76x02_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	    !(key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
 		return -EOPNOTSUPP;
 
+	/* MT76x0 GTK offloading does not work with more than one VIF */
+	if (is_mt76x0(dev) && !(key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
+		return -EOPNOTSUPP;
+
 	msta = sta ? (struct mt76x02_sta *)sta->drv_priv : NULL;
 	wcid = msta ? &msta->wcid : &mvif->group_wcid;
 
-- 
2.30.0

