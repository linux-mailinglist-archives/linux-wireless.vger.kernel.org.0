Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D1B5396BE
	for <lists+linux-wireless@lfdr.de>; Tue, 31 May 2022 21:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241388AbiEaTIc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 May 2022 15:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbiEaTIb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 May 2022 15:08:31 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3D372E07
        for <linux-wireless@vger.kernel.org>; Tue, 31 May 2022 12:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=myfRFZ6iGedozI4C++x4z8+jqwntaT49/bPQRhS+KtM=; b=H/jT3oDJw8QdLyzkfJTJU0CKTc
        84bGf7k9MBAkDqO3Fze1dCqJ5JaR6qK0oWKoi2jqjJ8TPAu0XDcIS9Ubd0L7PE0FbGV/uA4ByhyJZ
        h8frsnUkfi3xCLzjcBqrOxjlWJty9aAEdxAfhi3keG5R0dacUTpxlzgyoJV9C5TgFi1o=;
Received: from p200300daa70ef20054e87cd6cce3e129.dip0.t-ipconnect.de ([2003:da:a70e:f200:54e8:7cd6:cce3:e129] helo=Maecks.lan)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1nw7EC-0002sD-Hq; Tue, 31 May 2022 21:08:28 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH] mac80211: do not wake queues on a vif that is being stopped
Date:   Tue, 31 May 2022 21:08:24 +0200
Message-Id: <20220531190824.60019-1-nbd@nbd.name>
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

When a vif is being removed and sdata->bss is cleared, __ieee80211_wake_txqs
can still be called on it, which crashes as soon as sdata->bss is being
dereferenced.
To fix this properly, check for SDATA_STATE_RUNNING before waking queues,
and take the fq lock when setting it (to ensure that __ieee80211_wake_txqs
observes the change when running on a different CPU

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/iface.c | 2 ++
 net/mac80211/util.c  | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 41531478437c..15a73b7fdd75 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -377,7 +377,9 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 	bool cancel_scan;
 	struct cfg80211_nan_func *func;
 
+	spin_lock_bh(&local->fq.lock);
 	clear_bit(SDATA_STATE_RUNNING, &sdata->state);
+	spin_unlock_bh(&local->fq.lock);
 
 	cancel_scan = rcu_access_pointer(local->scan_sdata) == sdata;
 	if (cancel_scan)
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 1e26b5235add..dad42d42aa84 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -301,6 +301,9 @@ static void __ieee80211_wake_txqs(struct ieee80211_sub_if_data *sdata, int ac)
 	local_bh_disable();
 	spin_lock(&fq->lock);
 
+	if (!test_bit(SDATA_STATE_RUNNING, &sdata->state))
+		goto out;
+
 	if (sdata->vif.type == NL80211_IFTYPE_AP)
 		ps = &sdata->bss->ps;
 
-- 
2.36.1

