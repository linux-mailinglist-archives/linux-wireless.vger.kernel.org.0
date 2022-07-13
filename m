Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B076957336D
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbiGMJq4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235741AbiGMJpm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:42 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82A4F680D
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=pNIS6Qd57JpoL/PgMEksYPHHYztiAgCOQTRbG4eEmHs=;
        t=1657705530; x=1658915130; b=Or+ORj7GmX57+vLJHR+bLhKzLRhC/5vpUYx7IU6fp30ZLcH
        sYHt75dPRjSqD/Uywse1NhqmvjUf1FGnikNFsRDZA1f03+a7iTa+PfIj6WPJ0A4QBEPKyXYXX9iRY
        0ig07pP1XhTiTW+zQg93ZI0F/X6ACg1MIh7CWxBG7Bn6gtDHdqfoza3fe0FK5inW8kdaEz25OpnjZ
        cKVTJB7QBFiSjptmFCZxFtKnKX0Dn5sF4DtYK38qBGnUlKYb9JIJch2znsKCSpko7j283nhOfFp1r
        +kBsmH8714vR/QuXC/jqfdB9wKwo2FRLGec3xeF6IsbTnXk3Svwz2lND8Ds4uWQA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvx-00EgvB-0J;
        Wed, 13 Jul 2022 11:45:29 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 70/76] wifi: nl80211: allow link ID in set_wiphy with frequency
Date:   Wed, 13 Jul 2022 11:44:56 +0200
Message-Id: <20220713114426.114795c9b65c.I46594499a53c951bb8eb02f4dafbcaaaaa4a2349@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713094502.163926-1-johannes@sipsolutions.net>
References: <20220713094502.163926-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

This simplifies hostapd implementation, since it didn't
switch to NL80211_CMD_SET_CHANNEL.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 53d63effbca9..0bf1f7267b89 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3475,16 +3475,19 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	if (info->attrs[NL80211_ATTR_WIPHY_FREQ]) {
+		int link_id = nl80211_link_id_or_invalid(info->attrs);
+
 		if (wdev) {
 			wdev_lock(wdev);
 			result = __nl80211_set_channel(
 				rdev,
 				nl80211_can_set_dev_channel(wdev) ? netdev : NULL,
-				info, -1);
+				info, link_id);
 			wdev_unlock(wdev);
 		} else {
-			result = __nl80211_set_channel(rdev, netdev, info, -1);
+			result = __nl80211_set_channel(rdev, netdev, info, link_id);
 		}
+
 		if (result)
 			goto out;
 	}
-- 
2.36.1

