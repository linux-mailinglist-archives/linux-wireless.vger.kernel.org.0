Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F5E573338
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbiGMJpj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235766AbiGMJpN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:13 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E9CEF9C9
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=xFn6oC0kdfPkHMKBQ2DcZJZ21nLL87M4kJuAwXNHwqs=;
        t=1657705513; x=1658915113; b=m5aMrXZYcYTtVaf+m3dIzP/jqogjKWHxp571D1e+woyetq0
        M71GvTMz06619AumTMPqHUPvBnDFXlrFi89RjsOaMdMzWc5ykieMnHVlaF8CpcdreMkq6tQMagmQT
        LDXDtQyCPxd+KnuVkNNEXqPjIn9k4p58pg49FJy6ZV4TPmWZbUJLcDs0v3bdYORGvXAlVUdQec4sZ
        HLeQgqVdKcRnzMs1kmVaK6xkhsVEMbxlHYQ12SSzdh5IihdnAdFokGWcrTv4ZApAAUquNVJ0iHsVj
        R59KCv09PilVI7NF4edPOs4kQ08K+G4PVvoKNVK3D8GY1LS0+0LdzqnfHC3O1cTg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvf-00EgvB-35;
        Wed, 13 Jul 2022 11:45:11 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 22/76] wifi: mac80211: fix key lookup
Date:   Wed, 13 Jul 2022 11:44:08 +0200
Message-Id: <20220713114425.ed2e3ae60fc6.I769221e274dd44729bfccc0f58cde71d9f25612a@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

With the split into keys[]/deflink.gtk[] arrays, WEP keys are
still installed into the keys[] array, but we didn't look them
up there. This meant they weren't deleted correctly.

Fix this by looking up the key there even if it's not pairwise
so we can be sure we don't have it.

Fixes: bfd8403adddd ("wifi: mac80211: reorg some iface data structs for MLD")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 058163b97c9a..a4e511766008 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -570,6 +570,10 @@ ieee80211_lookup_key(struct ieee80211_sub_if_data *sdata,
 	if (key)
 		return key;
 
+	/* or maybe it was a WEP key */
+	if (key_idx < NUM_DEFAULT_KEYS)
+		return rcu_dereference_check_key_mtx(local, sdata->keys[key_idx]);
+
 	return NULL;
 }
 
-- 
2.36.1

