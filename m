Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D01B3A2A47
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jun 2021 13:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhFJLg1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Jun 2021 07:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbhFJLg0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Jun 2021 07:36:26 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D45EC061574
        for <linux-wireless@vger.kernel.org>; Thu, 10 Jun 2021 04:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=+k6HY5+6UDNAZaIYq/+Mdtg00QEYet1EeDea4Upv58k=; b=t6J1gkRLGq8B/0gmD+W3cX0xG6
        7wrGYLeL7arzOdUyb6OV/WMPeB29g9NqAoNjYq3O1F92zVpKBJRtcWzm/6kntOFsheLhAx78lDltC
        HowK4SO+ErED2FarWrQQe7dna3tzWqKjHg+Ql3rJ+8aDroDTakIs1VbG7SuYwzmF7oag=;
Received: from p54ae9ff2.dip0.t-ipconnect.de ([84.174.159.242] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lrIxA-00006w-NM
        for linux-wireless@vger.kernel.org; Thu, 10 Jun 2021 13:34:28 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7915: drop the use of repeater entries for station interfaces
Date:   Thu, 10 Jun 2021 13:34:26 +0200
Message-Id: <20210610113426.74767-1-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There are firmware or hardware issues, which are currently causing tx hangs
when attempting to use these interfaces

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7915/main.c   | 6 ------
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h | 2 +-
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 2485f65766e7..c25f8da590dd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -139,12 +139,6 @@ static int get_omac_idx(enum nl80211_iftype type, u64 mask)
 		if (type != NL80211_IFTYPE_STATION)
 			break;
 
-		/* next, try to find a free repeater entry for the sta */
-		i = get_free_idx(mask >> REPEATER_BSSID_START, 0,
-				 REPEATER_BSSID_MAX - REPEATER_BSSID_START);
-		if (i)
-			return i + 32 - 1;
-
 		i = get_free_idx(mask, EXT_BSSID_1, EXT_BSSID_MAX);
 		if (i)
 			return i - 1;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index a4b32e0d64e9..b0cdd53098ef 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -9,7 +9,7 @@
 #include "../mt76.h"
 #include "regs.h"
 
-#define MT7915_MAX_INTERFACES		32
+#define MT7915_MAX_INTERFACES		19
 #define MT7915_MAX_WMM_SETS		4
 #define MT7915_WTBL_SIZE		288
 #define MT7915_WTBL_RESERVED		(MT7915_WTBL_SIZE - 1)
-- 
2.30.1

