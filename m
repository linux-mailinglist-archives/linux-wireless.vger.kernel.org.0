Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3685E823C5
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2019 19:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbfHERPX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Aug 2019 13:15:23 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38556 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbfHERPW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Aug 2019 13:15:22 -0400
Received: by mail-pg1-f195.google.com with SMTP id z14so2841150pga.5
        for <linux-wireless@vger.kernel.org>; Mon, 05 Aug 2019 10:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=17BppcXqZfxbPGr9PRMTPoV/LLkPLLP+SKK7CO3M9eM=;
        b=CMvFpVuQrHcaD8wENeZs7xRQPCZW9zxoDeK0XmBywbFJS4h/1BZRVhVx1DnZeFcxN4
         Sj49NMeaQHcsgtWvP8uJ3WzN/jDeTbHvbxdCghM+J7HFtImo+guQKbo9PK5w7nSWwb4L
         wjcuVDRB/z/Er1Pc0kkrN7ZQQlOmGB/H2uljA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=17BppcXqZfxbPGr9PRMTPoV/LLkPLLP+SKK7CO3M9eM=;
        b=aSHs1Lj3JFf7a2bavHmIM9PJa+Dgs6Uyl+kdLkdP/Fk7qPDIaGYnCQv3/gPiUvYqK4
         VMBFReU9DOV1C/tuzGRzpG6Jaau7opxBpvAeoMVHJk/gGVL6oI8g8fcGH2xo4w/79Lsg
         ZLv6yS9TpVVgUSwYj6FxKfG7IHid02Gvb7BaKNRviZIEVO3QgKvSEfqxUa2H7Viftvc6
         P/RC2ZBpKICzojr0KAeEv6zRW3kFiM1mxz4JlkD379aFxqCz02rMTniMKO6TX81WeEFr
         Dz66P/zp0s42osycNgXAFT54iJjYlrevEDC0OlLXzn6iBocv4YNznC6NMa77RchAmAlM
         Hp2Q==
X-Gm-Message-State: APjAAAVOYXyWP8ybB82nf55Ol4TK/CeSgWj1WKGe2WUN+KPnrSd4+bsX
        zt7jPQXOTCDuGHgmnyu5Nqv6YQ==
X-Google-Smtp-Source: APXvYqzxv7M6IR4in1vhGB8Q4n4XPFhXuk+D/n/xjxagMGtxkbwhP5GVaL+d6zafns1iu9roD/5eJw==
X-Received: by 2002:a63:ed55:: with SMTP id m21mr15707852pgk.343.1565025322316;
        Mon, 05 Aug 2019 10:15:22 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id f20sm99610723pgg.56.2019.08.05.10.15.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 10:15:20 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Ganapathi Bhat <gbhat@marvell.com>,
        Xinming Hu <huxinming820@gmail.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Amitkumar Karwar <akarwar@marvell.com>
Subject: [PATCH] Revert "mwifiex: fix system hang problem after resume"
Date:   Mon,  5 Aug 2019 10:15:04 -0700
Message-Id: <20190805171504.48122-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This reverts commit 437322ea2a36d112e20aa7282c869bf924b3a836.

This above-mentioned "fix" does not actually do anything to prevent a
race condition. It simply papers over it so that the issue doesn't
appear.

If this is a real problem, it should be explained better than the above
commit does, and an alternative, non-racy solution should be found.

For further reason to revert this: there's no reason we can't try
resetting the card when it's *actually* stuck in host-sleep mode. So
instead, this is unnecessarily creating scenarios where we can't recover
Wifi (and in fact, I'm fielding reports of Chromebooks that can't
recover after the aforementioned commit).

Note that this was proposed in 2017 and Ack'ed then, but due to my
marking as RFC, it never went anywhere:

https://patchwork.kernel.org/patch/9657277/
[RFC] Revert "mwifiex: fix system hang problem after resume"

Cc: Amitkumar Karwar <akarwar@marvell.com>
Signed-off-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Acked-by: Amitkumar Karwar <amitkarwar@gmail.com>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/net/wireless/marvell/mwifiex/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/init.c b/drivers/net/wireless/marvell/mwifiex/init.c
index 6c0e52eb8794..1aa93e7e9835 100644
--- a/drivers/net/wireless/marvell/mwifiex/init.c
+++ b/drivers/net/wireless/marvell/mwifiex/init.c
@@ -59,7 +59,7 @@ static void wakeup_timer_fn(struct timer_list *t)
 	adapter->hw_status = MWIFIEX_HW_STATUS_RESET;
 	mwifiex_cancel_all_pending_cmd(adapter);
 
-	if (adapter->if_ops.card_reset && !adapter->hs_activated)
+	if (adapter->if_ops.card_reset)
 		adapter->if_ops.card_reset(adapter);
 }
 
-- 
2.22.0.770.g0f2c4a37fd-goog

