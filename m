Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F77F720C1F
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Jun 2023 00:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236675AbjFBW6o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Jun 2023 18:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236467AbjFBW6m (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Jun 2023 18:58:42 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACEFE40
        for <linux-wireless@vger.kernel.org>; Fri,  2 Jun 2023 15:58:38 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5659cfd627dso39272727b3.2
        for <linux-wireless@vger.kernel.org>; Fri, 02 Jun 2023 15:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685746718; x=1688338718;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QhTMWm7QFFgSbHkbOWfdA14D72uDfJV2WhL1oS/z9is=;
        b=U6R666rMvV8N6MzZyn9MSIAtaLChZI1h4enUtXtJXD7fbyeh0YrdlY0B+sTtLoBW9J
         CcrQ6Y1wNgUJbWcZF/JxLqD2/VVFd41MZuL32OLv3BUIXq4gDb1TJd6xRAM+GORPiK50
         FEslMaspC4mVAddlLd4eM4ZNqN86sS24JxmpxpxdkxRIxW9sACv8NIKOeUcfh8sgCrmu
         7DpiksAETyZ/Tc3p1GLTYoeQhCC5CQgyCpvgZ0Ii6rLeI4mN1x/QoCJBmTl+u+p2KIFR
         ObPgeMWnusR+khFo3RQlyoM3Ucs12gcqTX3/E1yuFOPDsPhladPB8lTtQecAY+cDyjoU
         Kn7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685746718; x=1688338718;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QhTMWm7QFFgSbHkbOWfdA14D72uDfJV2WhL1oS/z9is=;
        b=FH6HI0jv9uvQsR+XmpZe9zXfbbSURj3hBo9ckDXcolr00H12FOYMBt/XnG97gGkNbh
         p1f8lzfMn/kKUZEjh5io0KDi6ndeU8XP+6lBjHHW7O8PK9uHuDIZlP9SCMEs/rc+EHf5
         maL1IRwgIBYPlZUlfvtU3JWzQyKKd7G2B2B+3K+IUj1MFWAbVeOVALvecpvHZtcHI567
         Dh3O7KTnjr7vO8p4X+vvQj1VWbe44miV1A4uzZv6DRRAYTGgP7bqx380v95yo8G3xpl3
         41yKNk98DRIFlXRZv7lzow9YEcjU0lvdRjmfIJwa9zzTOyRyvLp6nc6KjNnq4dfffQlp
         gbhA==
X-Gm-Message-State: AC+VfDzBKfBZnZ4hJfuC928kuCIQGxqjtvDjZtrpXTI8W6DUIO1NCdue
        bnZMtjvyvfZQJlZrb6w+2jyU9p6VWps=
X-Google-Smtp-Source: ACHHUZ72BOotxTxKf6sfqxFc/lQgBW7K5+6B5Q9hnluS511cfw4gOc5IqrIBSkJ9jmMhfIkDWKWhYkxZQ1Q=
X-Received: from kglund1.bld.corp.google.com ([2620:15c:183:200:a5cd:5418:e5f2:aca5])
 (user=kglund job=sendgmr) by 2002:a81:a805:0:b0:54f:b56a:cd0f with SMTP id
 f5-20020a81a805000000b0054fb56acd0fmr724030ywh.3.1685746718170; Fri, 02 Jun
 2023 15:58:38 -0700 (PDT)
Date:   Fri,  2 Jun 2023 16:57:51 -0600
In-Reply-To: <20230602225751.164525-1-kglund@google.com>
Mime-Version: 1.0
References: <20230602225751.164525-1-kglund@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230602225751.164525-2-kglund@google.com>
Subject: [PATCH 2/2] wifi: mwifiex: Stop rejecting connection attempts while connected
From:   Kevin Lund <kglund@google.com>
To:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Cc:     Kevin Lund <kglund@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently, the Marvell WiFi driver rejects any connection attmept while
we are currently connected. This is poor logic, since there are several
legitimate use-cases for initiating a connection attempt while
connected, including re-association and BSS Transitioning. This logic
means that it's impossible for userspace to request the driver to
connect to a different BSS on the same ESS without explicitly requesting
a disconnect first.

Remove the check from the driver so that we can complete BSS transitions
on the first attempt.

Testing on Chrome OS has shown that this change resolves some issues
with failed BSS transitions.

Signed-off-by: Kevin Lund <kglund@google.com>
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index bcd564dc3554a..84d650c9dceb0 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -2414,12 +2414,6 @@ mwifiex_cfg80211_connect(struct wiphy *wiphy, struct net_device *dev,
 		return -EINVAL;
 	}
 
-	if (priv->wdev.connected) {
-		mwifiex_dbg(adapter, ERROR,
-			    "%s: already connected\n", dev->name);
-		return -EALREADY;
-	}
-
 	if (priv->scan_block)
 		priv->scan_block = false;
 
-- 
2.39.2

