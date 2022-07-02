Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48975640DA
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Jul 2022 16:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbiGBOwd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 2 Jul 2022 10:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbiGBOwd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 2 Jul 2022 10:52:33 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC25BC0F
        for <linux-wireless@vger.kernel.org>; Sat,  2 Jul 2022 07:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=rSSLDM4nRDwUakIOMpX3jLkhNiYonjFcAMyTKgg+VW0=; b=M3Vpk6xP8xi3v7kKLN1aSjiGmD
        HqQcGTz/zAUhHsY/j1Z0j2/RGUGfe+QtxJrQhJb3+LA2Tv9NfAwrqYsQ/SIUe6oPUhpalnZC5D5TN
        S3U6GqHcvbIcqsUI6L13EwSXccGMY+qfEAXg+dd+RfbezoWNWmxBfnLlsLLN/XCIZYEo=;
Received: from [217.114.218.24] (helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1o7eU1-00013u-S9; Sat, 02 Jul 2022 16:52:29 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH] mac80211: fix queue selection for mesh/OCB interfaces
Date:   Sat,  2 Jul 2022 16:52:27 +0200
Message-Id: <20220702145227.39356-1-nbd@nbd.name>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When using iTXQ, the code assumes that there is only one vif queue for
broadcast packets, using the BE queue. Allowing non-BE queue marking
violates that assumption and txq->ac == skb_queue_mapping is no longer
guaranteed. This can cause issues with queue handling in the driver and
also causes issues with the recent ATF change, resulting in an AQL
underflow warning.

Cc: stable@vger.kernel.org
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/wme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/wme.c b/net/mac80211/wme.c
index fc36c8e9d1d2..ecc1de2e68a5 100644
--- a/net/mac80211/wme.c
+++ b/net/mac80211/wme.c
@@ -148,8 +148,8 @@ u16 __ieee80211_select_queue(struct ieee80211_sub_if_data *sdata,
 	bool qos;
 
 	/* all mesh/ocb stations are required to support WME */
-	if (sdata->vif.type == NL80211_IFTYPE_MESH_POINT ||
-	    sdata->vif.type == NL80211_IFTYPE_OCB)
+	if (sta && (sdata->vif.type == NL80211_IFTYPE_MESH_POINT ||
+		    sdata->vif.type == NL80211_IFTYPE_OCB))
 		qos = true;
 	else if (sta)
 		qos = sta->sta.wme;
-- 
2.36.1

