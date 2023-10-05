Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6450F7BABD0
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Oct 2023 23:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjJEVJ2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Oct 2023 17:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjJEVJ1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Oct 2023 17:09:27 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A3D93
        for <linux-wireless@vger.kernel.org>; Thu,  5 Oct 2023 14:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=Et+DtWoZDGH2ck47M8vvYe9LJ5uRBEyN69zj4y/seGs=; t=1696540166; x=1697749766; 
        b=A43nj0ZoQe3So8TF4QB1Gv/wvCx5chjHLF2vBCQQt0HnOLwJ2hkdjBzd/f4UQa1W4igQyKxMIOr
        LvEmzAQDzGE86gteIvsTYfyCUTlHv3+vJxZcMpAycg3Jy7qBi3VQ9kn1QoBFyEtUJj7IEYG948zGv
        GDz4bBC4NkKIeG5Xbz3lVdrIBEydwF2ZTEGqH0Nyvsc2BqY8WgA0anKUvXc9m8L47tvODW7b5xHHk
        CrDbNZs1OiRWCwBsgZ8jAIc5+ZXveN8Ayaz44rcSB2ucOizZnKqclFCepjAppCfqlT2LEwMJW44bL
        jr3YjsbaHH9jYaN5BoFglwaoQCpYKGlLLGIA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC0)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qoVaz-00000006nhZ-26Uj;
        Thu, 05 Oct 2023 23:09:21 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless] wifi: mac80211: fix error path key leak
Date:   Thu,  5 Oct 2023 23:09:18 +0200
Message-ID: <20231005210917.13977-2-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

In the previous key leak fix for the other error
paths, I meant to unify all of them to the same
place, but used the wrong label, which I noticed
when doing the merge into wireless-next. Fix it.

Fixes: d097ae01ebd4 ("wifi: mac80211: fix potential key leak")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/key.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index 0665ff5e456e..a2db0585dce0 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -912,7 +912,7 @@ int ieee80211_key_link(struct ieee80211_key *key,
 	 */
 	if (ieee80211_key_identical(sdata, old_key, key)) {
 		ret = -EALREADY;
-		goto unlock;
+		goto out;
 	}
 
 	key->local = sdata->local;
@@ -940,7 +940,6 @@ int ieee80211_key_link(struct ieee80211_key *key,
 
  out:
 	ieee80211_key_free_unused(key);
- unlock:
 	mutex_unlock(&sdata->local->key_mtx);
 
 	return ret;
-- 
2.41.0

