Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7350B733AD6
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jun 2023 22:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjFPU2x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Jun 2023 16:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjFPU2w (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Jun 2023 16:28:52 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C4F35B8
        for <linux-wireless@vger.kernel.org>; Fri, 16 Jun 2023 13:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=CfoxS913FyegojNdFD4GB2iCKhWvdrmeQUpbSYPRuYQ=; t=1686947331; x=1688156931; 
        b=f62Ioj1OWZAIWbkc3jVFtSeY9xtz7wyegMPigmjmG2uQCbkUT7/M27llEHJOZIizqWgmFS2v2nX
        khWUez5Fl/1SYZHqcbGv6bcumQuUmNebOe8Tgi6a4yKJl22POAQYamLke57PLo9b24cKwAl49FMht
        hMjlWhPmCKj8Ba2FvlvKR81fmdYtNjpjWe58LOfGwd2IDA1lB37YLYEGNa5zFkYjFdpsWjKrra2lx
        DMNgtbi4BS4tQMK4/fKe0WpJaSMwgEzrVl8IcN2XBOacGOmqDjuseMK7s1NdDnusAJSNo3ZkwSXTy
        Mc3mvT4LgGfwXQbWV53oep2cDMLTMDAut5fA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qAG3s-008bzE-0E;
        Fri, 16 Jun 2023 22:28:48 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 1/2] wifi: cfg80211: fix regulatory disconnect for non-MLO
Date:   Fri, 16 Jun 2023 22:28:44 +0200
Message-Id: <20230616222844.eb073d650c75.I72739923ef80919889ea9b50de9e4ba4baa836ae@changeid>
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

