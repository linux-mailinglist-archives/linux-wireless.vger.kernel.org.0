Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E8345D7ED
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Nov 2021 11:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351608AbhKYKI5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Nov 2021 05:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354433AbhKYKGz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Nov 2021 05:06:55 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2815AC061748
        for <linux-wireless@vger.kernel.org>; Thu, 25 Nov 2021 02:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=XaTfUwzhUdQ8uogrQU5/KzzFKjMG0j3M1wCjbhrrvCU=; b=JZUcBNbRILY1kWJALtEcBBofBY
        eM2sEbpfSH+xS7Wj5hQhBWg9QxLeZfsZn7kJNBqUQttOMP2CLMHjdArvolDhYB9shL9LPiec2a9lf
        8jvskSoapRTJtTQUpmhwuO1Idov5sr4tB3pV8aDKpQIdkeJ5rtdwdazbpJGQJUGonfzY=;
Received: from p54ae9f3f.dip0.t-ipconnect.de ([84.174.159.63] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mqBaO-0000pU-K6
        for linux-wireless@vger.kernel.org; Thu, 25 Nov 2021 11:02:36 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/2] mt76: mt7615: improve wmm index allocation
Date:   Thu, 25 Nov 2021 11:02:33 +0100
Message-Id: <20211125100234.39095-1-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Typically all AP interfaces on a PHY will share the same WMM settings, while
sta/mesh interfaces will usually inherit the settings from a remote device.
In order minimize the likelihood of conflicting WMM settings, make all AP
interfaces share one slot, and all non-AP interfaces another one.

This also fixes running multiple AP interfaces on MT7613, which only has 3
WMM slots.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7615/main.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index a0e8db0b27f9..e519fd2879ec 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -208,11 +208,9 @@ static int mt7615_add_interface(struct ieee80211_hw *hw,
 	mvif->mt76.omac_idx = idx;
 
 	mvif->mt76.band_idx = ext_phy;
-	if (mt7615_ext_phy(dev))
-		mvif->mt76.wmm_idx = ext_phy * (MT7615_MAX_WMM_SETS / 2) +
-				mvif->mt76.idx % (MT7615_MAX_WMM_SETS / 2);
-	else
-		mvif->mt76.wmm_idx = mvif->mt76.idx % MT7615_MAX_WMM_SETS;
+	mvif->mt76.wmm_idx = vif->type != NL80211_IFTYPE_AP;
+	if (ext_phy)
+		mvif->mt76.wmm_idx += 2;
 
 	dev->mt76.vif_mask |= BIT(mvif->mt76.idx);
 	dev->omac_mask |= BIT_ULL(mvif->mt76.omac_idx);
-- 
2.30.1

