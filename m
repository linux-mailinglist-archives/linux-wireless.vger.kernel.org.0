Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 603BA224BF
	for <lists+linux-wireless@lfdr.de>; Sat, 18 May 2019 22:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbfERUFw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 18 May 2019 16:05:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37649 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727926AbfERUFw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 18 May 2019 16:05:52 -0400
Received: by mail-wr1-f68.google.com with SMTP id e15so10425990wrs.4
        for <linux-wireless@vger.kernel.org>; Sat, 18 May 2019 13:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rlknW4hg015f9lTI6iodch+eUcNT6OThS+5moQqR50M=;
        b=juPB9tDr2IiFBHyKIK6bU3oC0zjIgSkIrTmXlYeeQgJS3ftd85KPKL29r0e813FUkn
         0Xt1ZWAthz7mKaYGgGzEmtQVCWPivr3xKAm+T64ER/KTcMb/glpF+byzBDIdcY3asSpw
         fNTouLAWKjLiGTX0OP3ZL5Qn2XR5+AOhp9b3V5rKNeWjoiAhwMlL5KDGlgKriVQtE/3t
         ji3ePhK5XXT8Znu444JzCSsTiO+Fr0yZzk2V0si/oHRtrgeP98tb650+MjoKU8DxiYBq
         E0LzH3bhvgaF4UvO03YUW3F2oxPEohw/0pcCFbDcHgtT/vniqVTRcEoJTQ/UcM5kGf4E
         m0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rlknW4hg015f9lTI6iodch+eUcNT6OThS+5moQqR50M=;
        b=lR8jnxqv/yfe8wlYdfGzmyVq4NayTVqP6jD9OuLBZyGlbbr7BRQVLKklZEXgHizDXr
         83anYWB1ERcYy1947kRT62nu81lESuUyxGiWQWLJbYtVQK4FcW1Hy2rPTFTsd6MMBcDG
         O2ZSzeQi3nndFAUCbs29uvoRqsCXsnnnUf8SPdFNDUGhd0+J4/1t/B92OEDTOIC754bo
         z+HrXDfquqVMLjd4l6n9oQsIeoDbomAoLtivWxRR8ZPN2uNR5Uy0lZu6y2f1YkO/vgEf
         pActV1kcTJKSxxUI2WjAFFAeHgJMTyfHoYczenFLC0o7tj1BHCtc9chjxBtgCEZb83Gq
         1CNA==
X-Gm-Message-State: APjAAAVL0uEPok7irmkDSBunieIbRxT4g0F/8bjW2G4j7ZQmmSFoNONM
        UvgyKdY3G3GI9KwLkW3DVfrjuDXu
X-Google-Smtp-Source: APXvYqw3Dk1glVvvXAMWFzskDFQsLMvX4OfSLfJLlwTfGL74dVfSJQyBnGZnF27/F8Wa1kkDOSyh+g==
X-Received: by 2002:adf:e30d:: with SMTP id b13mr24062418wrj.246.1558209949856;
        Sat, 18 May 2019 13:05:49 -0700 (PDT)
Received: from debian64.daheim (p4FD0962E.dip0.t-ipconnect.de. [79.208.150.46])
        by smtp.gmail.com with ESMTPSA id l8sm14581996wrw.56.2019.05.18.13.05.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 May 2019 13:05:49 -0700 (PDT)
Received: from chuck by debian64.daheim with local (Exim 4.92)
        (envelope-from <chunkeey@gmail.com>)
        id 1hS5aW-00020L-Ka; Sat, 18 May 2019 22:05:48 +0200
From:   Christian Lamparter <chunkeey@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     "David S . Miller" <davem@davemloft.net>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH] net: wireless: p54: fix crash during initialization
Date:   Sat, 18 May 2019 22:05:48 +0200
Message-Id: <20190518200548.7662-1-chunkeey@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch fixes a crash that got introduced when the
mentioned patch replaced  the direct list_head access
with skb_peek_tail(). When the device is starting up,
there are  no entries in  the queue, so previously to
"Use skb_peek_tail() instead..." the target_skb would
end up as the  tail and head pointer which then could
be used by __skb_queue_after to fill the empty queue.

With skb_peek_tail() in its place will instead just
return NULL which then causes a crash in the
__skb_queue_after().

| BUG: unable to handle kernel NULL pointer dereference at 000000
| #PF error: [normal kernel read fault]
| PGD 0 P4D 0
| Oops: 0000 [#1] SMP PTI
| CPU: 0 PID: 12 Comm: kworker/0:1 Tainted: GO   5.1.0-rc7-wt+ #218
| Hardware name: MSI MS-7816/Z87-G43 (MS-7816), BIOS V1.11 05/09/2015
| Workqueue: events request_firmware_work_func
| RIP: 0010:p54_tx_pending+0x10f/0x1b0 [p54common]
| Code: 78 06 80 78 28 00 74 6d <48> 8b 07 49 89 7c 24 08 49 89 04 24 4
| RSP: 0018:ffffa81c81927d90 EFLAGS: 00010086
| RAX: ffff9bbaaf131048 RBX: 0000000000020670 RCX: 0000000000020264
| RDX: ffff9bbaa976d660 RSI: 0000000000000202 RDI: 0000000000000000
| RBP: ffff9bbaa976d620 R08: 00000000000006c0 R09: ffff9bbaa976d660
| R10: 0000000000000000 R11: ffffe8480dbc5900 R12: ffff9bbb45e87700
| R13: ffff9bbaa976d648 R14: ffff9bbaa976d674 R15: ffff9bbaaf131048
| FS:  0000000000000000(0000) GS:ffff9bbb5ec00000(0000) knlGS:00000
| CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
| CR2: 0000000000000000 CR3: 00000003695fc003 CR4: 00000000001606f0
| Call Trace:
|  p54_download_eeprom+0xbe/0x120 [p54common]
|  p54_read_eeprom+0x7f/0xc0 [p54common]
|  p54u_load_firmware_cb+0xe0/0x160 [p54usb]
|  request_firmware_work_func+0x42/0x80
|  process_one_work+0x1f5/0x3f0
|  worker_thread+0x28/0x3c0

Cc: stable@vger.kernel.org
Fixes: e3554197fc8f ("p54: Use skb_peek_tail() instead of direct head pointer accesses.")
Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---
 drivers/net/wireless/intersil/p54/txrx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intersil/p54/txrx.c b/drivers/net/wireless/intersil/p54/txrx.c
index 790784568ad2..5bf1c19ecced 100644
--- a/drivers/net/wireless/intersil/p54/txrx.c
+++ b/drivers/net/wireless/intersil/p54/txrx.c
@@ -142,7 +142,10 @@ static int p54_assign_address(struct p54_common *priv, struct sk_buff *skb)
 	    unlikely(GET_HW_QUEUE(skb) == P54_QUEUE_BEACON))
 		priv->beacon_req_id = data->req_id;
 
-	__skb_queue_after(&priv->tx_queue, target_skb, skb);
+	if (target_skb)
+		__skb_queue_after(&priv->tx_queue, target_skb, skb);
+	else
+		__skb_queue_head(&priv->tx_queue, skb);
 	spin_unlock_irqrestore(&priv->tx_queue.lock, flags);
 	return 0;
 }
-- 
2.20.1

