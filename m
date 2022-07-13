Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91FF573A33
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 17:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236952AbiGMPeo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 11:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236677AbiGMPel (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 11:34:41 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4DE31204
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 08:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=lxL7BGo8R2mpegwNTB2yu6uiciX2aGOMY3J4H9RR6rU=;
        t=1657726480; x=1658936080; b=Eu8e6s2VtAF1VTf/iFCUfyLZ+6xuqHqwIjmSaajxj0fmlmd
        amtp9GyAvBnNrrvckRilWOvzt0Eu91nk2LYkGLIf/ziseobHaXuCr2wtuI6NuY+DRbBeT4ZAjaWsi
        ZtFCTnDXE1bcM7cmGE+4/JzhthdiyrjTGEViU65HoPqjDJ3yOGeYK3IPbkZj0JRDX6CKnQ3r7mWVV
        BlbcrJAxPI7MsowtSGDh2uzzT/22hwYdx/HP7u6GahXibKqxo1pmYfwcGTCEg68jD3MbarvrTBOk9
        qidtIRUlkf5VTOOWDJ6wx9UKsfLJqbgJOIDMpqO9iOPwg5xq28gSpAYO9i1li6ug==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBeNq-00EnaA-9F;
        Wed, 13 Jul 2022 17:34:38 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 04/21] wifi: mac80211: prohibit DEAUTH_NEED_MGD_TX_PREP in MLO
Date:   Wed, 13 Jul 2022 17:34:16 +0200
Message-Id: <20220713173301.bc46fd46a805.I373154f39adf68cffe1940ec88bb00830d546a1f@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713153433.279227-1-johannes@sipsolutions.net>
References: <20220713153433.279227-1-johannes@sipsolutions.net>
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

For now, prohibit DEAUTH_NEED_MGD_TX_PREP since we can't
really transmit this on a specific link yet as we don't
know which links are active.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 26bb30606282..5b1c47ed0cc0 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1001,6 +1001,9 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 
 		if (WARN_ON(!ieee80211_hw_check(hw, AP_LINK_PS)))
 			return -EINVAL;
+
+		if (WARN_ON(ieee80211_hw_check(hw, DEAUTH_NEED_MGD_TX_PREP)))
+			return -EINVAL;
 	}
 
 #ifdef CONFIG_PM
-- 
2.36.1

