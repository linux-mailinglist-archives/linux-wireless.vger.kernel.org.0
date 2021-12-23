Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6355947E65C
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Dec 2021 17:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349036AbhLWQ3B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Dec 2021 11:29:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57796 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240046AbhLWQ3A (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Dec 2021 11:29:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640276939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uJOgwGjirTFzn7tlsminzBCCoKOlNNhzzWyCm3307/w=;
        b=edD64RghMPskuFlRlIv/3LnRyC96f5U4ZbFWILq8sG7yxXRG+8+F3uLCVZCHlWC7q4ImP7
        YXpeOLft81iETApWAX/LR46KeHEmWxDo3Vq9XC0BWe3gZsnlx0d0Cq6ID+VLhDRu+B4/S1
        TzBKlS6Jc6DEHWFP0kMewhejKDodaE8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-660-qSelDCP6OV6Hc6Oh_I5CxQ-1; Thu, 23 Dec 2021 11:28:58 -0500
X-MC-Unique: qSelDCP6OV6Hc6Oh_I5CxQ-1
Received: by mail-qv1-f70.google.com with SMTP id ib7-20020a0562141c8700b0040812bc4425so4973351qvb.16
        for <linux-wireless@vger.kernel.org>; Thu, 23 Dec 2021 08:28:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uJOgwGjirTFzn7tlsminzBCCoKOlNNhzzWyCm3307/w=;
        b=kjXdsRDrzey6PiXU+Us7rmc9OGOGd7i/f8nSh+J9aif+lXHVXCblSkIz1g5HhUXyNS
         UX3XN8aTDYVFb05NbN44wCe/sPrjbCM1IXh3D5pZJTPyvFLtQnRGECU2GMbsX5CM75Jd
         qARCoIt0eD4w1+yFZWsDA6tqYBrMigE6WT6x7ow4iRqrIMve5SnEbgNr0QuMjsuFm7RH
         Xl74xcWspe4nWJEKl+J206vAr4kA9RNhk7bBx//4WL9P5rKlJ09Gq82miUS7IJEcUBPI
         V3dIPalkTo9PhRQYFwtIWvtOYqX3nIgpK/OVjdVXNPUoDPPRb1JWMbFH21ij+3rqN7M2
         qFRg==
X-Gm-Message-State: AOAM531s2a3X9PpZ2rCUi7TS5pXyzUk0zV1mLZ3X+TlP5p1MjJsHDslA
        g5FAEWK1xMNfpeee/ieITq52SuqtymfcFoN/SLjwXOKA8DSdyL1iRWlZUY/FVQbzKaY09WmBS2x
        +me60zmSvjdF3VKKsHmSUgLkDgH0=
X-Received: by 2002:a37:a8cc:: with SMTP id r195mr1907019qke.480.1640276938440;
        Thu, 23 Dec 2021 08:28:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwzpz9zm2A3nxoNm6dr+ZZ7zHfR2tVjNN8kjrl0r7RnwHfLx6ohxoG8UtvwJHnYzNd5uok2bw==
X-Received: by 2002:a37:a8cc:: with SMTP id r195mr1906996qke.480.1640276938135;
        Thu, 23 Dec 2021 08:28:58 -0800 (PST)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id u11sm4743795qtw.29.2021.12.23.08.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 08:28:57 -0800 (PST)
From:   trix@redhat.com
To:     johannes@sipsolutions.net, davem@davemloft.net, kuba@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, linville@tuxdriver.com
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] mac80211: initialize variable have_higher_than_11mbit
Date:   Thu, 23 Dec 2021 08:28:48 -0800
Message-Id: <20211223162848.3243702-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this warnings

mlme.c:5332:7: warning: Branch condition evaluates to a
  garbage value
    have_higher_than_11mbit)
    ^~~~~~~~~~~~~~~~~~~~~~~

have_higher_than_11mbit is only set to true some of the time in
ieee80211_get_rates() but is checked all of the time.  So
have_higher_than_11mbit needs to be initialized to false.

Fixes: 5d6a1b069b7f ("mac80211: set basic rates earlier")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 net/mac80211/mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 51f55c4ee3c6e..766cbbc9c3a72 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5279,7 +5279,7 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 	 */
 	if (new_sta) {
 		u32 rates = 0, basic_rates = 0;
-		bool have_higher_than_11mbit;
+		bool have_higher_than_11mbit = false;
 		int min_rate = INT_MAX, min_rate_index = -1;
 		const struct cfg80211_bss_ies *ies;
 		int shift = ieee80211_vif_get_shift(&sdata->vif);
-- 
2.26.3

