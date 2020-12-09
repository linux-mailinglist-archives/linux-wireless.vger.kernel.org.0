Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6C02D435B
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 14:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732471AbgLINgK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 08:36:10 -0500
Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net ([209.97.182.222]:50263
        "HELO zg8tmja5ljk3lje4mi4ymjia.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1732470AbgLINgK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 08:36:10 -0500
X-Greylist: delayed 472 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Dec 2020 08:36:09 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
        Date:Message-Id; bh=I9hf/j6DzrCw0kw32sJ1v3wPlXxgUy8KgpgZEitj+Qo=;
        b=OfVH2OGtxSUole7WDR1tF2JdPjCwzALg6m1QPUOS0AERIk+CT8nkeRFMI/XGhP
        aaoLFVUbkTJqSM5uoCQxKcASOMlxghcrFnoZdcLg1VODZs1f8jmq9gumjY/zKFQG
        OgugqOAfjORxKbK65XYbc+mnXiwxX5pxkZU6KjdmGJWes=
Received: from ubuntu.localdomain (unknown [166.111.83.82])
        by web5 (Coremail) with SMTP id zAQGZQB360KS0NBfxdgHAA--.26163S4;
        Wed, 09 Dec 2020 21:26:42 +0800 (CST)
From:   tangzhenhao <tzh18@mails.tsinghua.edu.cn>
To:     linux-wireless@vger.kernel.org
Cc:     amitkarwar@gmail.com, tangzhenhao <tzh18@mails.tsinghua.edu.cn>
Subject: [PATCH] drivers/net: fix a null-ptr-deref bug in drivers/net/wireless/marvell/mwifiex/uap_txrx.c
Date:   Wed,  9 Dec 2020 05:26:40 -0800
Message-Id: <20201209132640.36031-1-tzh18@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: zAQGZQB360KS0NBfxdgHAA--.26163S4
X-Coremail-Antispam: 1UD129KBjvdXoWrur4ruw1rWF18Cw43Zr4rGrg_yoWDCrcEk3
        4xXw4SqrWUGwnrKw1jyr4xA3sYyrZ8XFyfWan7trWxWFWUZrZ8Jr95ZrZ3Gry3CwsFvwnx
        JrsrJ3yUAw4rXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbskFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
        rcIFxwCY02Avz4vE14v_Xr4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
        1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
        14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
        IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2
        z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73Uj
        IFyTuYvjfUnsqWUUUUU
X-CM-SenderInfo: pw2kimo6pdxz3vow2x5qjk3toohg3hdfq/1tbiAgEFEV7nE6ep1wABsl
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

At line 257 in drivers/net/wireless/marvell/mwifiex/uap_txrx.c, the ret-val of skb_copy should be checked to avoid null-ptr-deref bug.

Signed-off-by: tangzhenhao <tzh18@mails.tsinghua.edu.cn>
---
 drivers/net/wireless/marvell/mwifiex/uap_txrx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
index 9bbdb8dfce62..d89311851594 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
@@ -255,6 +255,11 @@ int mwifiex_handle_uap_rx_forward(struct mwifiex_private *priv,
 
 	if (is_multicast_ether_addr(ra)) {
 		skb_uap = skb_copy(skb, GFP_ATOMIC);
+		if (!likely(skb_uap)) {
+			mwifiex_dbg(adapter, ERROR, "failed to allocate skb_uap");
+			dev_kfree_skb_any(skb);
+			return 0;
+		}
 		mwifiex_uap_queue_bridged_pkt(priv, skb_uap);
 	} else {
 		if (mwifiex_get_sta_entry(priv, ra)) {
-- 
2.17.1

