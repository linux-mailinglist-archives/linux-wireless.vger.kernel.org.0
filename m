Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B877B34C2
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Sep 2023 16:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbjI2OVL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Sep 2023 10:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbjI2OVK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Sep 2023 10:21:10 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D69DB
        for <linux-wireless@vger.kernel.org>; Fri, 29 Sep 2023 07:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=pXPSJ3S5xWDpPTcIEhZangrDjNb33ai+JQO/af2LRFg=; t=1695997265; x=1697206865; 
        b=dxtoBOZFfXa8WeYItkqouPFK7a7rxsCPrOCpJsuVW2kRE4LkgQX19ksdVTrwbAl1a0BlRqEqKqK
        bRAKGBDmPge3X9SVq8zwReI6UMzkvAlhMVVc3yqNsu3JErIieY30MfarQudGon/d+/hD4szIXdd1F
        5HK4XpZWJPFFonAwxjBnRG2wOc1ucjqcrDHfYQQsSJbVIi6Gyus8weEKmfMSe7BI4XVQUmb1gxqzR
        oxewCdGZbK8EuJxbRhUr1dDIg8XapY1THRapsB7lhEsHaoxC5Md9cWHNG1Gkz39RF6bxOgc6uIn4U
        x4i73N1iEgyeKhSFR++4HdzN6DREMvzhTKqw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qmEMY-00Blph-2e;
        Fri, 29 Sep 2023 16:21:03 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Kalle Valo <kvalo@kernel.org>
Subject: [PATCH] wifi: mac80211: fix ieee80211_drop_unencrypted_mgmt return type/value
Date:   Fri, 29 Sep 2023 16:21:00 +0200
Message-ID: <20230929162059.205c236c9f3f.I9ed4c65ab6514aa9e3c8877ec79092a302b2089d@changeid>
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

Somehow, I managed to botch this and pretty much completely break
wifi. My original patch did contain these changes, but I seem to
have lost them before sending to the list. Fix it now.

Reported-by: Kalle Valo <kvalo@kernel.org>
Fixes: 6c02fab72429 ("wifi: mac80211: split ieee80211_drop_unencrypted_mgmt() return value")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/rx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index fb2d4a7436be..051db97a92b4 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2405,7 +2405,8 @@ static int ieee80211_drop_unencrypted(struct ieee80211_rx_data *rx, __le16 fc)
 	return 0;
 }
 
-static int ieee80211_drop_unencrypted_mgmt(struct ieee80211_rx_data *rx)
+static ieee80211_rx_result
+ieee80211_drop_unencrypted_mgmt(struct ieee80211_rx_data *rx)
 {
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(rx->skb);
 	struct ieee80211_mgmt *mgmt = (void *)rx->skb->data;
@@ -2473,7 +2474,7 @@ static int ieee80211_drop_unencrypted_mgmt(struct ieee80211_rx_data *rx)
 			return RX_DROP_U_UNPROT_UNICAST_PUB_ACTION;
 	}
 
-	return 0;
+	return RX_CONTINUE;
 }
 
 static ieee80211_rx_result
-- 
2.41.0

