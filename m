Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AAD733ABE
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jun 2023 22:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbjFPUVj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Jun 2023 16:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbjFPUVi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Jun 2023 16:21:38 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937713A89
        for <linux-wireless@vger.kernel.org>; Fri, 16 Jun 2023 13:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=CfoxS913FyegojNdFD4GB2iCKhWvdrmeQUpbSYPRuYQ=; t=1686946895; x=1688156495; 
        b=cMc96272f00WpYJaDCaMiXbgd+gSD5N/DdKgzaIYIvU5t0YBIM2iRvIVv8lpvYrPQIz5poAx+YD
        lLZWHtZbG/2SOer7GX5VWfuIoBwqZjypz79y0KRfn7vRn1wOPjFV8GPY0DvHwcn/1U1QBXE0yPbrp
        tKuQ9tzTR0z2nhRqibpoXpab+QsaeIpwFy6m1eD3Y0GPkEujvyqVdhTOLe88ntfmKQvI7bpY8/YtC
        vMzfxIRZpCFyIhUZiWt32R1Iyc0Mp5DZrMvhsaCEL1APk1NkP51hItW8q9NItBGX+wBdTIX5UUpsl
        dM//wy3klY3S8IQ4JQTEiAiFOHQaPxCTjacg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qAFwo-008bm6-2Q;
        Fri, 16 Jun 2023 22:21:30 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/2] wifi: cfg80211: fix regulatory disconnect for non-MLO
Date:   Fri, 16 Jun 2023 22:21:26 +0200
Message-Id: <20230616222122.eb073d650c75.I72739923ef80919889ea9b50de9e4ba4baa836ae@changeid>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The multi-link loop here broke disconnect when multi-link
operation (MLO) isn't active for a given interface, since
in that case valid_links is 0 (indicating no links, i.e.
no MLO.)

Fix this by taking that into account properly and skipping
the link only if there are valid_links in the first place.

Fixes: 7b0a0e3c3a88 ("wifi: cfg80211: do some rework towards MLO link APIs")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/reg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 26f11e4746c0..f5ea1f373ab7 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -2352,7 +2352,7 @@ static bool reg_wdev_chan_valid(struct wiphy *wiphy, struct wireless_dev *wdev)
 
 		if (!wdev->valid_links && link > 0)
 			break;
-		if (!(wdev->valid_links & BIT(link)))
+		if (wdev->valid_links && !(wdev->valid_links & BIT(link)))
 			continue;
 		switch (iftype) {
 		case NL80211_IFTYPE_AP:
-- 
2.40.1

