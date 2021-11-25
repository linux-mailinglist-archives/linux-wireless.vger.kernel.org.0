Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71FF845D7EC
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Nov 2021 11:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354475AbhKYKIL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Nov 2021 05:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351905AbhKYKGK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Nov 2021 05:06:10 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B91C061574
        for <linux-wireless@vger.kernel.org>; Thu, 25 Nov 2021 02:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=GYcVxK0wbxEt3c1XBXxR68g6T6/KtdQtX2VbdcXchxg=; b=NUpoov/HATZoiv4bgODNZn+4FD
        Pd4piXrLLexGbuAv/uy8g/4P2mPqCL7dUvXwiyRhwSm/PZRVlkQA9Spon+gLktCnIpvPxmD9QCUXk
        RvxAV/Mx0UjjcRKOgfcl7BxdYWellvLHSGjtvZs8bwkB+ITl6m7ifMrbDThPOZQAJ9HI=;
Received: from p54ae9f3f.dip0.t-ipconnect.de ([84.174.159.63] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mqBaO-0000pU-Qj
        for linux-wireless@vger.kernel.org; Thu, 25 Nov 2021 11:02:36 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/2] mt76: mt7915: improve wmm index allocation
Date:   Thu, 25 Nov 2021 11:02:34 +0100
Message-Id: <20211125100234.39095-2-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20211125100234.39095-1-nbd@nbd.name>
References: <20211125100234.39095-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Typically all AP interfaces on a PHY will share the same WMM settings, while
sta/mesh interfaces will usually inherit the settings from a remote device.
In order minimize the likelihood of conflicting WMM settings, make all AP
interfaces share one slot, and all non-AP interfaces another one.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7915/main.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 057ab27b7083..8c1fa08b6286 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -218,11 +218,9 @@ static int mt7915_add_interface(struct ieee80211_hw *hw,
 	mvif->phy = phy;
 	mvif->band_idx = ext_phy;
 
-	if (dev->mt76.phy2)
-		mvif->wmm_idx = ext_phy * (MT7915_MAX_WMM_SETS / 2) +
-				mvif->idx % (MT7915_MAX_WMM_SETS / 2);
-	else
-		mvif->wmm_idx = mvif->idx % MT7915_MAX_WMM_SETS;
+	mvif->wmm_idx = vif->type != NL80211_IFTYPE_AP;
+	if (ext_phy)
+		mvif->wmm_idx += 2;
 
 	ret = mt7915_mcu_add_dev_info(phy, vif, true);
 	if (ret)
-- 
2.30.1

