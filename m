Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48BD86D2356
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Mar 2023 16:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbjCaO7i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Mar 2023 10:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbjCaO7a (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Mar 2023 10:59:30 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B04A20D82
        for <linux-wireless@vger.kernel.org>; Fri, 31 Mar 2023 07:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=2apJjDGGQshS0PK+sPmXRjtVsddrM/J1c0R75bC9naE=; t=1680274762; x=1681484362; 
        b=mAJaOFF6DiRD+uVTaJqPoaD1Dnf+T4fMIz3RXOeLWuC8wxnTVVQJyzKIb1PU8vT2VFN6UykLDxj
        xhPfAq6TyePFDG+H/C28kmzXRYUYi0fnZlMpofqnPUelo9Bqvyhpjlkg0zME9tXIAO8m+AHJvuvJg
        9xpANUAlX8ssQvaFTbZeRZkE/0AHY0yNsL7bIv1MiD5A5tyP4pC0p+wli3ZBEDGkG6pMuB/D9DHpJ
        nPrFjqKZds6HvEkCxOsc7XFnTA3J/6aaTr9b3BZUltdg+S6Idgc2AhSe5b8l8S9a7RaGnwd19zJLN
        mKOEe9nqzcZEvIOQ/FTT/vKtaXIYzQBECogw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1piGDn-002ID5-34;
        Fri, 31 Mar 2023 16:59:20 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/2] wifi: mac80211: flush queues on STA removal
Date:   Fri, 31 Mar 2023 16:59:16 +0200
Message-Id: <20230331165915.2480c0c04b69.Ia95b7dbddeba0cfe619ccebfe3acafedd372c70f@changeid>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When we remove a station, we first make it unreachable,
then we (must) remove its keys, and then remove the
station itself. Depending on the hardware design, if
we have hardware crypto at all, frames still sitting
on hardware queues may then be transmitted without a
valid key, possibly unencrypted or with a fixed key.

Fix this by flushing the queues when removing stations
so this cannot happen.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/sta_info.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 941bda9141fa..ce7c3b997269 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -1294,6 +1294,14 @@ static void __sta_info_destroy_part2(struct sta_info *sta)
 		WARN_ON_ONCE(ret);
 	}
 
+	/* Flush queues before removing keys, as that might remove them
+	 * from hardware, and then depending on the offload method, any
+	 * frames sitting on hardware queues might be sent out without
+	 * any encryption at all.
+	 */
+	if (local->ops->set_key)
+		ieee80211_flush_queues(local, sta->sdata, false);
+
 	/* now keys can no longer be reached */
 	ieee80211_free_sta_keys(local, sta);
 
-- 
2.39.2

