Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516C664C9AA
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Dec 2022 14:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238497AbiLNNEJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Dec 2022 08:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238527AbiLNNDt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Dec 2022 08:03:49 -0500
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05E510AC
        for <linux-wireless@vger.kernel.org>; Wed, 14 Dec 2022 05:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=hpFig4QzPVSBGCL7cNrhsjEXVr6cBitAelA8V5yJ/ao=; b=GaVfra8ZEHg6Q4P88qH7gAxFyy
        GZmo6EYevGUv5zSJVNYwAuPUFSmOFxwrEV/dZuzOoP/KKIVRu/cnFjy+0PsOnWwGX8sRtmzGlpNSq
        tMrA4+uLizN3tPIrB0iRmoysqi6qDuvCbAGdMMFlF7J3GjqIbSuF0pOeRS73Xv1a0WT8=;
Received: from p5b206216.dip0.t-ipconnect.de ([91.32.98.22] helo=Maecks.lan)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1p5RQ6-008ie9-EA; Wed, 14 Dec 2022 14:03:34 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH] wifi: mac80211: fix MLO + AP_VLAN check
Date:   Wed, 14 Dec 2022 14:03:26 +0100
Message-Id: <20221214130326.37756-1-nbd@nbd.name>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Instead of preventing adding AP_VLAN to MLO enabled APs, this check was
preventing adding more than one 4-addr AP_VLAN regardless of the MLO status.
Fix this by adding missing extra checks.

Fixes: ae960ee90bb1 ("wifi: mac80211: prevent VLANs on MLDs")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/iface.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index d49a5906a943..e20c3fe9a0b1 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -364,7 +364,9 @@ static int ieee80211_check_concurrent_iface(struct ieee80211_sub_if_data *sdata,
 
 			/* No support for VLAN with MLO yet */
 			if (iftype == NL80211_IFTYPE_AP_VLAN &&
-			    nsdata->wdev.use_4addr)
+			    sdata->wdev.use_4addr &&
+			    nsdata->vif.type == NL80211_IFTYPE_AP &&
+			    nsdata->vif.valid_links)
 				return -EOPNOTSUPP;
 
 			/*
-- 
2.38.1

