Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFBE74ED42
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jul 2023 13:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjGKLvC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jul 2023 07:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjGKLvA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jul 2023 07:51:00 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188AC136
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jul 2023 04:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=3T1XACr6q+PpH0Ao2khwE7SgmilmbhtpgNUHN2mndVA=; b=kGZ6H5FXo5de8QtorG/4r+Tz7E
        F7BIkb7UTd1MFwo/Jfv8FzTHJTubOj+77dDS8j0DxZAp9eY8OhBw641W7+7D9Ozhn0Cn/82v2hjFM
        +ddaOQ++Li0h3aAGeiDnVKegQ/a5mBGYx/ltvx6kJFydMmCfF/Q9CtK6f2PfERaaEmsY=;
Received: from p4ff134dd.dip0.t-ipconnect.de ([79.241.52.221] helo=Maecks.lan)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1qJBtR-00Gtyq-Vb; Tue, 11 Jul 2023 13:50:58 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, Nicolas Escande <nico.escande@gmail.com>
Subject: [PATCH wireless] wifi: cfg80211: fix receving mesh packets without RFC1042 header
Date:   Tue, 11 Jul 2023 13:50:52 +0200
Message-ID: <20230711115052.68430-1-nbd@nbd.name>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix ethernet header length field after stripping the mesh header

Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/CT5GNZSK28AI.2K6M69OXM9RW5@syracuse/
Fixes: 986e43b19ae9 ("wifi: mac80211: fix receiving A-MSDU frames on mesh interfaces")
Reported-by: Nicolas Escande <nico.escande@gmail.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/wireless/util.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index 89c9ad6c886e..1783ab9d57a3 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -580,6 +580,8 @@ int ieee80211_strip_8023_mesh_hdr(struct sk_buff *skb)
 		hdrlen += ETH_ALEN + 2;
 	else if (!pskb_may_pull(skb, hdrlen))
 		return -EINVAL;
+	else
+		payload.eth.h_proto = htons(skb->len - hdrlen);
 
 	mesh_addr = skb->data + sizeof(payload.eth) + ETH_ALEN;
 	switch (payload.flags & MESH_FLAGS_AE) {
-- 
2.41.0

