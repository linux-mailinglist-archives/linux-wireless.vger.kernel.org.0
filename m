Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268A74D7101
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Mar 2022 22:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbiCLVVL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Mar 2022 16:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbiCLVVL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Mar 2022 16:21:11 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDE752E47
        for <linux-wireless@vger.kernel.org>; Sat, 12 Mar 2022 13:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=/GwiHfwcyGH81S9rmdHExn6mKyes+xO6ZZ+LuDlzCw8=; t=1647120004; x=1648329604; 
        b=P8Jf/PMpMnTtli4wLlxr+LODVqA5I0RWG5eP1Ka6D713+t1JgHqj8NII+XsKh7hjgljz4PQlqU9
        2nXjF9j992TLNbH5AASrrNUvJXrjGF/8G4wd3qvCRxhTra1il8zhcJIJ52E2L8t24AKmH62yx6pQe
        3ujBO0xIrWa14w/O7IeaWtdklI9IOcauews8fVNWVlkn3jfG78K/Nx0zx58Df8CNpTmeBDzGrOGfb
        HINGB8RXRutLsFVHOMhXSFeGFPdpx+EbjZQINm8zWAsomvXjJ/WhUZLwbYrQR8BaNIUyTGEKZR+cv
        cCoJNabqpsa73LWwloNgjZLXeR0FoK1XET0Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nT99c-00CSjy-LF;
        Sat, 12 Mar 2022 22:20:00 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] mac80211: always have ieee80211_sta_restart()
Date:   Sat, 12 Mar 2022 22:19:58 +0100
Message-Id: <20220312221957.1fa96c72db51.I8ecaa5f9402fede0272161e0531ab930b97fba3e@changeid>
X-Mailer: git-send-email 2.35.1
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

From: Johannes Berg <johannes.berg@intel.com>

When CONFIG_PM isn't defined we don't have the function
ieee80211_sta_restart() compiled in, but we always need
it now for firmware restart. Move it out of the ifdef.

Fixes: 7d352ccf1e99 ("mac80211: Add support to trigger sta disconnect on hardware restart")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 29bfce6b3561..a6af3c85c749 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4913,6 +4913,7 @@ void ieee80211_mgd_quiesce(struct ieee80211_sub_if_data *sdata)
 
 	sdata_unlock(sdata);
 }
+#endif
 
 void ieee80211_sta_restart(struct ieee80211_sub_if_data *sdata)
 {
@@ -4948,7 +4949,6 @@ void ieee80211_sta_restart(struct ieee80211_sub_if_data *sdata)
 
 	sdata_unlock(sdata);
 }
-#endif
 
 /* interface setup */
 void ieee80211_sta_setup_sdata(struct ieee80211_sub_if_data *sdata)
-- 
2.35.1

