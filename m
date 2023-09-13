Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4FE79DF4E
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Sep 2023 07:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238296AbjIMFBm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Sep 2023 01:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjIMFBm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Sep 2023 01:01:42 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B7B172A
        for <linux-wireless@vger.kernel.org>; Tue, 12 Sep 2023 22:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
        Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=wmlOjen8EZ0H1IYGCOWIJbnUC4v123gnVqub7GsIlqs=; b=d22cujY+6aaFp8LCiLyJW5IgDY
        M5j/GS9iK2cXmTma8xiKQbRr5t6GXy1AJvCiXRT7lGgTY7tVZ4W8fWNzb9awtSM6UU9c7eTkyeBaQ
        /Ls2zuhbj62MnsKJISMXWl41Unk52BnhzH4HfRYxXBHjs8Sigw6EbggveEfcT8W89hWc=;
Received: from p4ff13705.dip0.t-ipconnect.de ([79.241.55.5] helo=localhost.localdomain)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1qgI0M-001FPU-RD; Wed, 13 Sep 2023 07:01:34 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, pagadala.yesu.anjaneyulu@intel.com,
        =?UTF-8?q?Thomas=20H=C3=BChn?= <thomas.huehn@hs-nordhausen.de>
Subject: [PATCH wireless] wifi: mac80211: fix mesh id corruption on 32 bit systems
Date:   Wed, 13 Sep 2023 07:01:34 +0200
Message-ID: <20230913050134.53536-1-nbd@nbd.name>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since the changed field size was increased to u64, mesh_bss_info_changed
pulls invalid bits from the first 3 bytes of the mesh id, clears them, and
passes them on to ieee80211_link_info_change_notify, because
ifmsh->mbss_changed was not updated to match its size.
Fix this by turning into ifmsh->mbss_changed into an unsigned long array with
64 bit size.

Fixes: 15ddba5f4311 ("wifi: mac80211: consistently use u64 for BSS changes")
Reported-by: Thomas Hühn <thomas.huehn@hs-nordhausen.de>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/ieee80211_i.h | 2 +-
 net/mac80211/mesh.c        | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index b8465d205076..3c5dbf95685d 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -682,7 +682,7 @@ struct ieee80211_if_mesh {
 	struct timer_list mesh_path_root_timer;
 
 	unsigned long wrkq_flags;
-	unsigned long mbss_changed;
+	unsigned long mbss_changed[64 / BITS_PER_LONG];
 
 	bool userspace_handles_dfs;
 
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 0d0fbae51b61..092a1dc7314d 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -1175,7 +1175,7 @@ void ieee80211_mbss_info_change_notify(struct ieee80211_sub_if_data *sdata,
 
 	/* if we race with running work, worst case this work becomes a noop */
 	for_each_set_bit(bit, &bits, sizeof(changed) * BITS_PER_BYTE)
-		set_bit(bit, &ifmsh->mbss_changed);
+		set_bit(bit, ifmsh->mbss_changed);
 	set_bit(MESH_WORK_MBSS_CHANGED, &ifmsh->wrkq_flags);
 	wiphy_work_queue(sdata->local->hw.wiphy, &sdata->work);
 }
@@ -1257,7 +1257,7 @@ void ieee80211_stop_mesh(struct ieee80211_sub_if_data *sdata)
 
 	/* clear any mesh work (for next join) we may have accrued */
 	ifmsh->wrkq_flags = 0;
-	ifmsh->mbss_changed = 0;
+	memset(ifmsh->mbss_changed, 0, sizeof(ifmsh->mbss_changed));
 
 	local->fif_other_bss--;
 	atomic_dec(&local->iff_allmultis);
@@ -1722,9 +1722,9 @@ static void mesh_bss_info_changed(struct ieee80211_sub_if_data *sdata)
 	u32 bit;
 	u64 changed = 0;
 
-	for_each_set_bit(bit, &ifmsh->mbss_changed,
+	for_each_set_bit(bit, ifmsh->mbss_changed,
 			 sizeof(changed) * BITS_PER_BYTE) {
-		clear_bit(bit, &ifmsh->mbss_changed);
+		clear_bit(bit, ifmsh->mbss_changed);
 		changed |= BIT(bit);
 	}
 
-- 
2.41.0

