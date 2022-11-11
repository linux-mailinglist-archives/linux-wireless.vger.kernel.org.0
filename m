Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8122D625E7C
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Nov 2022 16:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbiKKPhd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Nov 2022 10:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiKKPhb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Nov 2022 10:37:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F9163BA0
        for <linux-wireless@vger.kernel.org>; Fri, 11 Nov 2022 07:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668180998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=vx+A+dp5QY1/5RtAM81bzSfXWLGWlLhTUYKU5agUg1w=;
        b=ZcPxE4rT1fEmRwLX/SHhJL/VfhQCnhBZZQCZFv6YnOMPTvw6NXbeASumSHMibUsKwYT6e/
        Fnjkssaw8KQV92O1WPEUiBk2qP4hPmvAaCx1XEkA0+v3Zgys6p5mzBz5uMdX72qfU8vJu/
        H8QX9jAHMzoBJ1J/hjgSfNAW9W0dDWA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-t0FqZ9woOCi06TZU6a0YBA-1; Fri, 11 Nov 2022 10:36:35 -0500
X-MC-Unique: t0FqZ9woOCi06TZU6a0YBA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C79ED185A7A3;
        Fri, 11 Nov 2022 15:36:34 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.119])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E36E463A78;
        Fri, 11 Nov 2022 15:36:32 +0000 (UTC)
From:   =?UTF-8?q?=C3=8D=C3=B1igo=20Huguet?= <ihuguet@redhat.com>
To:     johannes@sipsolutions.net
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-wireless@vger.kernel.org,
        =?UTF-8?q?=C3=8D=C3=B1igo=20Huguet?= <ihuguet@redhat.com>
Subject: [PATCH wireless] mac80211: fix maybe-unused warning
Date:   Fri, 11 Nov 2022 16:36:22 +0100
Message-Id: <20221111153622.29016-1-ihuguet@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In ieee80211_lookup_key, the variable named `local` is unused if
compiled without lockdep, getting this warning:

net/mac80211/cfg.c: In function ‘ieee80211_lookup_key’:
net/mac80211/cfg.c:542:26: error: unused variable ‘local’ [-Werror=unused-variable]
  struct ieee80211_local *local = sdata->local;
                          ^~~~~

Fix it with __maybe_unused.

Fixes: 8cbf0c2ab6df ("wifi: mac80211: refactor some key code")
Signed-off-by: Íñigo Huguet <ihuguet@redhat.com>
---
 net/mac80211/cfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 687b4c878d4a..8c8ef87997a8 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -576,7 +576,7 @@ static struct ieee80211_key *
 ieee80211_lookup_key(struct ieee80211_sub_if_data *sdata, int link_id,
 		     u8 key_idx, bool pairwise, const u8 *mac_addr)
 {
-	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_local *local __maybe_unused = sdata->local;
 	struct ieee80211_link_data *link = &sdata->deflink;
 	struct ieee80211_key *key;
 
-- 
2.34.1

