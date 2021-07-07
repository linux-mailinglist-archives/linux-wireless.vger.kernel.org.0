Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6241D3BF170
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jul 2021 23:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhGGVk4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Jul 2021 17:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbhGGVkz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Jul 2021 17:40:55 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CE6C061574
        for <linux-wireless@vger.kernel.org>; Wed,  7 Jul 2021 14:38:13 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id p1so8024144lfr.12
        for <linux-wireless@vger.kernel.org>; Wed, 07 Jul 2021 14:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mosenkovs.lv; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tThEhAiU+ngFM8ee2Fo6Eo+5obQkdO439uIgUWfGGPM=;
        b=R/WAOt5I2yUv/dCA+N/XdeoN2r/ZsHOAwzw2h88idjL/pwktzlZritE6jlnsnzYTnM
         ztmQV6cRLuv4lzzQzrDSQisT8GY29IGHEm+GSFoNYhuz17jNWGwgxe0KNUDMD9oi0y4w
         U4qQfbf4kE/ZsbZNvaQrlNEil4P/89J4eYfuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tThEhAiU+ngFM8ee2Fo6Eo+5obQkdO439uIgUWfGGPM=;
        b=R+PdxuWchplCpTrPewA61FQh6wukMjr+y24WvUi4iirv5EG0Q+/Kw3jVmoIbp8XaOu
         3gSRDoMqWiyulh5P0BnhgtzAgAEypfPQtNyMtAIhUNIgLs3s99+HtMUp5+O50PsCdMMS
         8EO0kUzHDbSL7Ypqp+dw2PbYqOsta7FgNjGzVi6XcWl/CRyRgcdNHXfQHSoU8uBxJaxi
         x2ONyQz7n5aRTSMVHEIt95dYs6cSfvYSKzp/Yksig0uVeo17wZlZN2wiPdQVxhKrl6z9
         aVdjThGAaB64rOUdKPb0WUgfcgwhZMUl7v2gvxJdBweisP/S3tCS1hrZVcO8+wIgYjFD
         37cQ==
X-Gm-Message-State: AOAM533pUFgNAYtQF+4zYanu3eqvkij59eloMjCp+eTMXX0DP3YL9Ce1
        LtrauPzTwy5zkNNjBemzqOVyhgthW/RlL4Aq
X-Google-Smtp-Source: ABdhPJzQchyqRDIcQY7U0TNkk8ayHBXkbpMVx2tYREBIhxUvBU8jciTm2V5ReMzz81plbeHzllcFfQ==
X-Received: by 2002:a05:6512:4017:: with SMTP id br23mr1161365lfb.113.1625693891891;
        Wed, 07 Jul 2021 14:38:11 -0700 (PDT)
Received: from ubuntu.ciemini.majas.lan (balticom-135-235.balticom.lv. [83.99.135.235])
        by smtp.gmail.com with ESMTPSA id s14sm7674lfr.309.2021.07.07.14.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 14:38:11 -0700 (PDT)
From:   Davis Mosenkovs <davis@mosenkovs.lv>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Davis Mosenkovs <davis@mosenkovs.lv>
Subject: [PATCH 4.4] mac80211: fix memory corruption in EAPOL handling
Date:   Thu,  8 Jul 2021 00:38:00 +0300
Message-Id: <20210707213800.1087974-1-davis@mosenkovs.lv>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Commit e3d4030498c3 ("mac80211: do not accept/forward invalid EAPOL
frames") uses skb_mac_header() before eth_type_trans() is called
leading to incorrect pointer, the pointer gets written to. This issue
has appeared during backporting to 4.4, 4.9 and 4.14.

Fixes: e3d4030498c3 ("mac80211: do not accept/forward invalid EAPOL frames")
Link: https://lore.kernel.org/r/CAHQn7pKcyC_jYmGyTcPCdk9xxATwW5QPNph=bsZV8d-HPwNsyA@mail.gmail.com
Signed-off-by: Davis Mosenkovs <davis@mosenkovs.lv>
---
 net/mac80211/rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index bde924968cd2..b5848bcc09eb 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2234,7 +2234,7 @@ ieee80211_deliver_skb(struct ieee80211_rx_data *rx)
 #endif
 
 	if (skb) {
-		struct ethhdr *ehdr = (void *)skb_mac_header(skb);
+		struct ethhdr *ehdr = (struct ethhdr *)skb->data;
 
 		/* deliver to local stack */
 		skb->protocol = eth_type_trans(skb, dev);
-- 
2.25.1

