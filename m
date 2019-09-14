Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18F87B290C
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Sep 2019 02:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390808AbfINAIX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Sep 2019 20:08:23 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38748 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390793AbfINAIX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Sep 2019 20:08:23 -0400
Received: by mail-io1-f67.google.com with SMTP id k5so41134655iol.5;
        Fri, 13 Sep 2019 17:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jwG/Aiknb+UcZynbTQk90VqogFgsnd/QMY7azs6Zupc=;
        b=H4ki8bM3b9Bmty2ruf5ZSCj1ONr4jsOiep+vLMdBWcjq1+6e8umPfwLlGHYesuoz/Q
         VF5OFoRIgllqVfRh1O0ob/rthiQm73toq+PTtrX9iKlZ8u3smXrOHJ2yH7252RrvcFpT
         O3TQVuU3UKw0Am3Efn13+5jVOA3Oh/oH5UC9uNsla1kvJ3F/R6nBoiOSwOMnclPvgRSn
         vay6xtYVjr5LkBAO60l/e/agltxV8p/eNiUH2xLAV7FcQ7951+WbMmnXr40trn8HDEj4
         6yl80zQa8B2dbLThm6nFvE462hhCUY3BrldbuGcsFiHG7iW0/cIshuHIso8SieQZdhM+
         gIzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jwG/Aiknb+UcZynbTQk90VqogFgsnd/QMY7azs6Zupc=;
        b=sTBiyouiK4UyXL4mE50HQlhIkI9Ns2+bLnk+9IC/vhspdjwj+xTPQI2DtQxLD94ruR
         EUXt194VEVxAqhmZQJy2MmYkPLsTxt31pXvm59EGf0bFyboMEVIx/BOWcqjS1+pOKH4I
         PisI3obo+CTL2hsat1wiEc2pMg+ZsZKzwlboyXVB0sL/FjH0xkEqAF1YC39sbegiiU6P
         PX/iDiNXMRckuIc/hvl5JA+8DFBj6onQYoXyPjRG7Ry122UQPLyu9SCSc2nGtgiv/EqM
         0YAhTTXDm0FyknKt7MoTbOuMcDqzz/io6uTl6/oMPotLSrKVAe+8u0V/hl9WS8VvitOm
         U3xw==
X-Gm-Message-State: APjAAAUnAd+MBw2rCpslu6F+1lT07zH7ui3l7LUI6IDQAbTwKXToMRDT
        yPjM/YAgsdE/f2RMGo4WmJhx7rwf6+4=
X-Google-Smtp-Source: APXvYqw7AMJKs0y62zgNzfsmBOSndsvr5y6XtYV+6wx/T/jGH6LPa1JJmCjPhOygc0/qx3csQoLVXA==
X-Received: by 2002:a6b:5b07:: with SMTP id v7mr3108833ioh.76.1568419702221;
        Fri, 13 Sep 2019 17:08:22 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id t9sm3973230iop.86.2019.09.13.17.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 17:08:21 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Siva Rebbagondla <siva8118@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rsi: release skb if rsi_prepare_beacon fails
Date:   Fri, 13 Sep 2019 19:08:11 -0500
Message-Id: <20190914000812.10188-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In rsi_send_beacon, if rsi_prepare_beacon fails the allocated skb should
be released.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/net/wireless/rsi/rsi_91x_mgmt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/rsi/rsi_91x_mgmt.c b/drivers/net/wireless/rsi/rsi_91x_mgmt.c
index 6c7f26ef6476..9cc8a335d519 100644
--- a/drivers/net/wireless/rsi/rsi_91x_mgmt.c
+++ b/drivers/net/wireless/rsi/rsi_91x_mgmt.c
@@ -1756,6 +1756,7 @@ static int rsi_send_beacon(struct rsi_common *common)
 		skb_pull(skb, (64 - dword_align_bytes));
 	if (rsi_prepare_beacon(common, skb)) {
 		rsi_dbg(ERR_ZONE, "Failed to prepare beacon\n");
+		dev_kfree_skb(skb);
 		return -EINVAL;
 	}
 	skb_queue_tail(&common->tx_queue[MGMT_BEACON_Q], skb);
-- 
2.17.1

