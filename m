Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 295783273CA
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Feb 2021 19:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhB1SYD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 28 Feb 2021 13:24:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:38672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229715AbhB1SYD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 28 Feb 2021 13:24:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C564264E83;
        Sun, 28 Feb 2021 18:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614536602;
        bh=jFyHiIkrp/RHe67eZjWBJEthOvz0V3Gl9Z/K6y2DE9o=;
        h=From:To:Cc:Subject:Date:From;
        b=lDl7RtGcLuymDIPv14FBfJdani9rlSHgLz0aVcMUdPdI/MIWK1G/MwPMuh1my1tF0
         jmmK6B31D4YVrdXiMJjYh94D0rFWXp7micLnQmH7zUQ0PjRL1n+KNSMxPlGQIzfNMO
         AZuktwxs2561rbLmmBm+vzmZnfLlRr2LxQkqCZ1X8WAbttoRdovPGy0oQjOHjpd4kn
         65p4jJdp/6esuCWi/yyJBWAWiFLIO531kHzyTwFcWJ9zcL+l2WuzC2HjrxcjQBfQ6t
         H3U+keQV0XeZYlF5DWSwsopogmbm+iW+uxx7c6YrEr8D7+J9vMRa4PSoD6+/GetJeA
         5KsAk50iDpjFQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     kuba@kernel.org
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mt7601u: enable TDLS support
Date:   Sun, 28 Feb 2021 19:23:09 +0100
Message-Id: <8f9fd662cdbbb70ba896f1bea80e696b15011d3f.1614536496.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Notify mac80211 the mt7601u chipset support 802.11 TDLS. The feature has
been tested with a mt7610u peer.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt7601u/init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt7601u/init.c b/drivers/net/wireless/mediatek/mt7601u/init.c
index cada48800928..5d9e952b2966 100644
--- a/drivers/net/wireless/mediatek/mt7601u/init.c
+++ b/drivers/net/wireless/mediatek/mt7601u/init.c
@@ -610,6 +610,7 @@ int mt7601u_register_device(struct mt7601u_dev *dev)
 
 	wiphy->features |= NL80211_FEATURE_ACTIVE_MONITOR;
 	wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION);
+	wiphy->flags |= WIPHY_FLAG_SUPPORTS_TDLS;
 
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
 
-- 
2.29.2

