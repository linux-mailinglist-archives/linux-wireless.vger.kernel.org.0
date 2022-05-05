Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDF851CAE0
	for <lists+linux-wireless@lfdr.de>; Thu,  5 May 2022 23:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385507AbiEEVIN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 May 2022 17:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385526AbiEEVIL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 May 2022 17:08:11 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FF45EBE6
        for <linux-wireless@vger.kernel.org>; Thu,  5 May 2022 14:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=C6FKzYw34+qmdFVZgK8cLQ42vN/M7AsO3TJsm5Y6uoA=; t=1651784670; x=1652994270; 
        b=bLNzRBJJBZ1gh6feVGRLc1BhAj/wSmnipUIxzUxDeNscfdbGMwXvZqBtvrSou5WdQ/beh8RGt8C
        tYwLSCQvIeAn+uic2Bf4w3e/UM1WwxeAlk+xH4h6WAdYfA07X+rIaQkv5Y/Ye+2JBq6za/oszhugW
        e2p+PMlUTtXLtANkdhSE6yJZPVYrQC5VP3Hf0mzoCp4UGYz9cogRnpRZLD8JlXGnV9irpNq+7wzg0
        VL31Nhiyd/0qG9lg/XnAonf+tap/Vzlq9s7bObk85oJ1mboDUF5yr0R6kumpr55E6LZFOA0rYs2t3
        fkPOueOytXT6IWzpIHO5yNq04EKS4j3uG/nA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nmie8-0032Mz-U4;
        Thu, 05 May 2022 23:04:25 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/2] mac80211_hwsim: fix RCU protected chanctx access
Date:   Thu,  5 May 2022 23:04:21 +0200
Message-Id: <20220505230421.fb8055c081a2.Ic6da3307c77a909bd61a0ea25dc2a4b08fe1b03f@changeid>
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

We need to RCU protect the chanctx_conf access, so
do that.

Fixes: 585625c955b1 ("mac80211_hwsim: check TX and STA bandwidth")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index afdf48550588..4689db129aec 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -2202,11 +2202,14 @@ mac80211_hwsim_sta_rc_update(struct ieee80211_hw *hw,
 	if (!data->use_chanctx) {
 		confbw = data->bw;
 	} else {
-		struct ieee80211_chanctx_conf *chanctx_conf =
-			rcu_dereference(vif->chanctx_conf);
+		struct ieee80211_chanctx_conf *chanctx_conf;
+
+		rcu_read_lock();
+		chanctx_conf = rcu_dereference(vif->chanctx_conf);
 
 		if (!WARN_ON(!chanctx_conf))
 			confbw = chanctx_conf->def.width;
+		rcu_read_unlock();
 	}
 
 	WARN(bw > hwsim_get_chanwidth(confbw),
-- 
2.35.1

