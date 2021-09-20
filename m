Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 195A84115F3
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Sep 2021 15:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239404AbhITNlq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Sep 2021 09:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237112AbhITNlm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Sep 2021 09:41:42 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CD0C061760
        for <linux-wireless@vger.kernel.org>; Mon, 20 Sep 2021 06:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=SJ6iY7WE5v2qsztHZcYZQadX06jzzazieP/L4I+URYQ=; t=1632145215; x=1633354815; 
        b=Hpu8OStihOL9yo+C9cohBEC8HF0w8mBkbTx9JcLP8fEoWf+pD1cPZfJydNAkfGBbPnpuBXgV064
        bUKPYAsaoT+vyB245Ov7GiIfiV2OPT/dBTZs4xGE9eenGj6tgCPoyRxNxc1Emh7R0xLNDEJ+qFoml
        qJL571X25rtCoDkq5L+unrkCdC83+YYxr4rr4a1qzgW3Flzr7aAdR66HU7G935qmk1qfWyecUgW4d
        SACI2nKniPmrLupwmgAbwK0j6Rl3URuTAi+lfE2VSxoCahxSdapGhpPcKFyd1yEQejqF7zJ4BCrT1
        lzy3L4GhYpNnD0Y9HDuTWy3Ey9CqzXqdbKBA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95-RC2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mSJWn-009SO7-04;
        Mon, 20 Sep 2021 15:40:13 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 1/6] mac80211: mesh: fix potentially unaligned access
Date:   Mon, 20 Sep 2021 15:40:05 +0200
Message-Id: <20210920154009.3110ff75be0c.Ib6a2ff9e9cc9bc6fca50fce631ec1ce725cc926b@changeid>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The pointer here points directly into the frame, so the
access is potentially unaligned. Use get_unaligned_le16
to avoid that.

Fixes: 3f52b7e328c5 ("mac80211: mesh power save basics")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mesh_ps.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mesh_ps.c b/net/mac80211/mesh_ps.c
index 204830a55240..3fbd0b9ff913 100644
--- a/net/mac80211/mesh_ps.c
+++ b/net/mac80211/mesh_ps.c
@@ -2,6 +2,7 @@
 /*
  * Copyright 2012-2013, Marco Porsch <marco.porsch@s2005.tu-chemnitz.de>
  * Copyright 2012-2013, cozybit Inc.
+ * Copyright (C) 2021 Intel Corporation
  */
 
 #include "mesh.h"
@@ -588,7 +589,7 @@ void ieee80211_mps_frame_release(struct sta_info *sta,
 
 	/* only transmit to PS STA with announced, non-zero awake window */
 	if (test_sta_flag(sta, WLAN_STA_PS_STA) &&
-	    (!elems->awake_window || !le16_to_cpu(*elems->awake_window)))
+	    (!elems->awake_window || !get_unaligned_le16(elems->awake_window)))
 		return;
 
 	if (!test_sta_flag(sta, WLAN_STA_MPSP_OWNER))
-- 
2.31.1

