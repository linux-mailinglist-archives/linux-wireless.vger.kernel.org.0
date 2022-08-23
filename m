Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF6D59E817
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Aug 2022 18:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245278AbiHWQyV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Aug 2022 12:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245232AbiHWQyA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Aug 2022 12:54:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F081C134203
        for <linux-wireless@vger.kernel.org>; Tue, 23 Aug 2022 06:22:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8650CB81CD9
        for <linux-wireless@vger.kernel.org>; Tue, 23 Aug 2022 13:22:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE503C433D6;
        Tue, 23 Aug 2022 13:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661260962;
        bh=110tXa43JY9cMrWguld+TcEYQospEjVMS9zQxW+jd70=;
        h=From:To:Cc:Subject:Date:From;
        b=o1G72ij2M7yPXEwaoxpdflIid45qwL5Ia09dQUOxccRPh8TR0o5m2fHeDz4D7oFUG
         0EJo9mL9sIHJA/SVg6yued5o568fIftHf2LxQPdaDeDr73YD3dHldP+yieNi2TGCCT
         IzjkW3GqOcSVGI/m5y4XIf9zpflosRyL0Sb+2RryTI/m4z32M9FPK77f3CoNOCCNLZ
         X4JagE3opBMkrmuGbZyW7bk5WdQb9F7YwNIdXz+hU82oVFgrXa79AGQT7K+xWdGKpZ
         feGrX9bz7HFsA5vlOXpPXiSwn/khU01dLh7HcnZ+bebWmtjwTRKtrQP2xGr6SCLgWi
         To6GFXEgJccKg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, lorenzo.bianconi@redhat.com
Subject: [PATCH wireless] wifi: mac80211: always free sta in __sta_info_alloc in case of error
Date:   Tue, 23 Aug 2022 15:22:23 +0200
Message-Id: <a3d079208684cddbc25289f7f7e0fed795b0cad4.1661260857.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Free sta pointer in __sta_info_alloc routine if sta_info_alloc_link()
fails.

Fixes: 246b39e4a1ba5 ("wifi: mac80211: refactor some sta_info link handling")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 net/mac80211/sta_info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index cb23da9aff1e..330dab41f2fe 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -494,7 +494,7 @@ __sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 	sta->sdata = sdata;
 
 	if (sta_info_alloc_link(local, &sta->deflink, gfp))
-		return NULL;
+		goto free;
 
 	if (link_id >= 0) {
 		sta_info_add_link(sta, link_id, &sta->deflink,
-- 
2.37.2

