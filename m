Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD555AC629
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Sep 2022 21:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbiIDT3o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 4 Sep 2022 15:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234871AbiIDT3a (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 4 Sep 2022 15:29:30 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446AAE23
        for <linux-wireless@vger.kernel.org>; Sun,  4 Sep 2022 12:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=1+JiEv6OTXxhirxB8/QAHAVnTuonH3D+PvgI/T871pU=;
        t=1662319763; x=1663529363; b=eERwWggZfYPLNatD+HnuE8xVk10xzSb5yUFzom3P/s8DWyr
        mPAYnVG0AYvX1gmLoZXSsQ0GUU4mKXDEs/DhMF9tcYCao/xdOglgmgnp8M9DFIpArs+AVNco0BBgl
        dZJugIVtcYdr4hBEcWenTPCvYmWkqXskOA2dmDj1bZGkVQz6VJq4YgcQ7SFfPje9vpR7kBZAIc7Gh
        G9wj08OK63pLOZ2TZvEnCppu9juTnnogAyD/XgoLosa6NPARhuVLnjbDpyxff4+Bz4FaanKJ47rdx
        GXdkf+Xb3XzLjFsu+xOVSR2d0GuL6rDE4eUwloMLtQWzOA//6ogCMpqGtPJNH5iw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oUvJ2-007pTZ-0F;
        Sun, 04 Sep 2022 21:29:20 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Solomon Peachy <pizza@shaftnet.org>
Subject: [PATCH 11/12] wifi: cw1200: use get_unaligned_le64()
Date:   Sun,  4 Sep 2022 21:29:11 +0200
Message-Id: <20220904212910.a5c9ea122f0f.If786a66f8fd9d45659cd5a2532cf395e21334453@changeid>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220904212910.8169e8c9090c.I0357e80cc86be2d4ac6205d1f53568444dcf7c9b@changeid>
References: <20220904212910.8169e8c9090c.I0357e80cc86be2d4ac6205d1f53568444dcf7c9b@changeid>
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

Instead of the code here that copies into a variable
first and then flips endianness, which confuses sparse,
just directly use get_unaligned_le64().

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
Cc: Solomon Peachy <pizza@shaftnet.org>

---
 drivers/net/wireless/st/cw1200/txrx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/st/cw1200/txrx.c b/drivers/net/wireless/st/cw1200/txrx.c
index ab19e0403dc2..6894b919ff94 100644
--- a/drivers/net/wireless/st/cw1200/txrx.c
+++ b/drivers/net/wireless/st/cw1200/txrx.c
@@ -1142,8 +1142,7 @@ void cw1200_rx_cb(struct cw1200_common *priv,
 
 	/* Remove TSF from the end of frame */
 	if (arg->flags & WSM_RX_STATUS_TSF_INCLUDED) {
-		memcpy(&hdr->mactime, skb->data + skb->len - 8, 8);
-		hdr->mactime = le64_to_cpu(hdr->mactime);
+		hdr->mactime = get_unaligned_le64(skb->data + skb->len - 8);
 		if (skb->len >= 8)
 			skb_trim(skb, skb->len - 8);
 	} else {
-- 
2.37.2

