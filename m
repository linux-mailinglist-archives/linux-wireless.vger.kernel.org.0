Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B056B8F19
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Mar 2023 11:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjCNKAT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Mar 2023 06:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjCNKAM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Mar 2023 06:00:12 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12D32A6C6
        for <linux-wireless@vger.kernel.org>; Tue, 14 Mar 2023 03:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=fQ71MCosSQV5sl0EroSadaOUdZ8yNoZcNVt7RDex3J8=; b=os3X6sylGMFd01VRkj0xDi4XfO
        9V+LTKtLdOI1GFyxEB8/etWDyxxHfZHN6Z79Ske6QPlC0Zf0kMfbts2vBCXojnunWfKVxrXxOr/af
        q7LGpLUfuK1F0bSQtreV852uoduYs2Kj/eljwWqHfRk2M7e0T2W5wDaVeVSrZD6rWgtQ=;
Received: from p54ae9730.dip0.t-ipconnect.de ([84.174.151.48] helo=Maecks.lan)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1pc1Rn-001pV5-9j; Tue, 14 Mar 2023 10:59:59 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 2/7] wifi: mac80211: fix race in mesh sequence number assignment
Date:   Tue, 14 Mar 2023 10:59:51 +0100
Message-Id: <20230314095956.62085-2-nbd@nbd.name>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230314095956.62085-1-nbd@nbd.name>
References: <20230314095956.62085-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since the sequence number is shared across different tx queues, it needs
to be atomic in order to avoid accidental duplicate assignment

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/ieee80211_i.h | 2 +-
 net/mac80211/mesh.c        | 6 ++----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 3d4edc25a69e..a4e1fdab1d3d 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -696,7 +696,7 @@ struct ieee80211_if_mesh {
 	struct mesh_stats mshstats;
 	struct mesh_config mshcfg;
 	atomic_t estab_plinks;
-	u32 mesh_seqnum;
+	atomic_t mesh_seqnum;
 	bool accepting_plinks;
 	int num_gates;
 	struct beacon_data __rcu *beacon;
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 5a99b8f6e465..0608ed415831 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -752,10 +752,8 @@ unsigned int ieee80211_new_mesh_header(struct ieee80211_sub_if_data *sdata,
 
 	meshhdr->ttl = sdata->u.mesh.mshcfg.dot11MeshTTL;
 
-	/* FIXME: racy -- TX on multiple queues can be concurrent */
-	put_unaligned(cpu_to_le32(sdata->u.mesh.mesh_seqnum), &meshhdr->seqnum);
-	sdata->u.mesh.mesh_seqnum++;
-
+	put_unaligned_le32(atomic_inc_return(&sdata->u.mesh.mesh_seqnum),
+			   &meshhdr->seqnum);
 	if (addr4or5 && !addr6) {
 		meshhdr->flags |= MESH_FLAGS_AE_A4;
 		memcpy(meshhdr->eaddr1, addr4or5, ETH_ALEN);
-- 
2.39.0

