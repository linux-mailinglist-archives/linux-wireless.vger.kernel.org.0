Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251357CD86E
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Oct 2023 11:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjJRJnA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Oct 2023 05:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjJRJm7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Oct 2023 05:42:59 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA273B0
        for <linux-wireless@vger.kernel.org>; Wed, 18 Oct 2023 02:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=CTKKemjkj+thWVDfTgzeS328hE4ettyJkCnrDD/MSOc=; t=1697622177; x=1698831777; 
        b=ecYOq/37TA3kYqLss0h8p7F8gYsoyc/WV8Q9UsD5JzYKQ9Ew4JrfslW58hlVZzytW4jrrID8AKo
        mjrMdMk+5noxB198VTV30rdRMvrw58Hsb24kJhaGqppIJFXLd4rlWZt9zrfSnY58aG/17W3kvYfCw
        ZAdGTvdDW7kcHgshSjWjelgJAYnWw18nEP6NbVt3206n8+sdqPd1DrDtpqQ6T8pk3HQOpAfPZrUag
        ZbORDw8wi56ODykyYisNQLA70JqIY9ulYlpXqzZBZBOYA85eKOGaapYLRpzt88exJweEQzqXfAhMb
        LBsWhc3ezyJ9sOEGy63wml3i3cEIovdPMbIA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qt34n-0000000Bh1r-2DTU;
        Wed, 18 Oct 2023 11:42:53 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: cfg80211: fix assoc response warning on failed links
Date:   Wed, 18 Oct 2023 11:42:51 +0200
Message-ID: <20231018114250.a23a2830756f.I634c7fc97404483b529cf186e9dc2da12508c6ad@changeid>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The warning here shouldn't be done before we even set the
bss field (or should've used the input data). Move the
assignment before the warning to fix it.

We noticed this now because of Wen's bugfix, where the bug
fixed there had previously hidden this other bug.

Fixes: 53ad07e9823b ("wifi: cfg80211: support reporting failed links")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/mlme.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 3e2c398abddc..55a1d3633853 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -43,10 +43,11 @@ void cfg80211_rx_assoc_resp(struct net_device *dev,
 
 	for (link_id = 0; link_id < ARRAY_SIZE(data->links); link_id++) {
 		cr.links[link_id].status = data->links[link_id].status;
+		cr.links[link_id].bss = data->links[link_id].bss;
+
 		WARN_ON_ONCE(cr.links[link_id].status != WLAN_STATUS_SUCCESS &&
 			     (!cr.ap_mld_addr || !cr.links[link_id].bss));
 
-		cr.links[link_id].bss = data->links[link_id].bss;
 		if (!cr.links[link_id].bss)
 			continue;
 		cr.links[link_id].bssid = data->links[link_id].bss->bssid;
-- 
2.41.0

