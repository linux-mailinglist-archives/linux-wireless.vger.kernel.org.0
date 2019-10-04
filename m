Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A679CCC413
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2019 22:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731298AbfJDUQ7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Oct 2019 16:16:59 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38177 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbfJDUQ7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Oct 2019 16:16:59 -0400
Received: by mail-io1-f66.google.com with SMTP id u8so16270784iom.5;
        Fri, 04 Oct 2019 13:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hT/oExY7ats1AqepuNnxgrg+W5xUde0ZFah/AwhjxeA=;
        b=eKzyOkdwTVgDQ2K7yVdvbQpQ2Y5o9gQHjf1ZLs/0TtknuoSEf88gRE3B/VgSXRe2nM
         MaPWiP+DFmtmMOa4V+/fIXuzmU7h0LfbH92QwqYCh6xpzlPF6Y4etarqtYGFwcN8YIFh
         KTbhy9t0/3m87L4UKRDIPV+aiyoEDLA1YrY+pxytqsh/8wTp82JG4WTVt4pgwk2YsDFT
         TYQK7y3xY2D8O2nwUROYE+zlwF6oua9EA/ixXRVx4CRlh/lRFc124Qw5TlMD2GZdMIPJ
         3GHq32K5Z1F8XMQnUSU6+WxybmUN18B736DtQMDHjjnt70M8oCb/qgoMbH3Bx6xDBx4t
         mwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hT/oExY7ats1AqepuNnxgrg+W5xUde0ZFah/AwhjxeA=;
        b=OCKRhcqw7kz4tZ/5U2VB84zj0RK/HtQHQ0/BUR0GLJMYOM7HJ1WBdSXnPtJs7UfIX1
         +C4Eq7PaUUpYg+OTWL+BOB7HpPh2AWvmoN/pElS49IYwKCcF9gUb/yfz1ZPSZBZrILg5
         pLgkiiBqoKOaUgVMzBGUs53mAhE7h0RuUDK3i3lptARoQDhVnRCk3HW6uz9G1pjCG6+m
         nOC9rnGsphMQZ30AbdG6u8z1oVH+F63nWumldsiz4sNMs++qwDXS5a9ho2EjS9cZwCnL
         c3V0vn5HgDqWWVwakE75xEnYAmApdEOC+BtAw6/zMFPMGWoDI98gN1u2ej7Ig6VZ3sDY
         GmXA==
X-Gm-Message-State: APjAAAUvXc/AEaa09LdQbBGOHXwA82YLzxvRaRqZB1BY9YQoSNU4yJRa
        7zybbZ/DYfKfmszLK0NP4Vs=
X-Google-Smtp-Source: APXvYqzNrXPxTps0mq67LtrgFhdE+kz3sXZyk7jqXZoSLFBjfwzONVFvHnNSmdK/pmDZR02HMuSgCw==
X-Received: by 2002:a6b:6e02:: with SMTP id d2mr5637516ioh.8.1570220218662;
        Fri, 04 Oct 2019 13:16:58 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id o5sm2830180ilc.68.2019.10.04.13.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 13:16:58 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Ganapathi Bhat <gbhat@marvell.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mwifiex: pcie: Fix memory leak in mwifiex_pcie_init_evt_ring
Date:   Fri,  4 Oct 2019 15:16:48 -0500
Message-Id: <20191004201649.25087-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In mwifiex_pcie_init_evt_ring, a new skb is allocated which should be
released if mwifiex_map_pci_memory() fails. The release for skb and
card->evtbd_ring_vbase is added.

Fixes: 0732484b47b5 ("mwifiex: separate ring initialization and ring creation routines")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/net/wireless/marvell/mwifiex/pcie.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/pcie.c b/drivers/net/wireless/marvell/mwifiex/pcie.c
index eff06d59e9df..096334e941a1 100644
--- a/drivers/net/wireless/marvell/mwifiex/pcie.c
+++ b/drivers/net/wireless/marvell/mwifiex/pcie.c
@@ -687,8 +687,11 @@ static int mwifiex_pcie_init_evt_ring(struct mwifiex_adapter *adapter)
 		skb_put(skb, MAX_EVENT_SIZE);
 
 		if (mwifiex_map_pci_memory(adapter, skb, MAX_EVENT_SIZE,
-					   PCI_DMA_FROMDEVICE))
+					   PCI_DMA_FROMDEVICE)) {
+			kfree_skb(skb);
+			kfree(card->evtbd_ring_vbase);
 			return -1;
+		}
 
 		buf_pa = MWIFIEX_SKB_DMA_ADDR(skb);
 
-- 
2.17.1

