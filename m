Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D90F420DB
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2019 11:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407201AbfFLJbd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jun 2019 05:31:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:42402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731492AbfFLJbd (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jun 2019 05:31:33 -0400
Received: from localhost.localdomain.com (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4ACE1207E0;
        Wed, 12 Jun 2019 09:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560331891;
        bh=Dd6PfEw1BJtzIEaTfBXhQUpB88l7lrGYX2e+WoB7ODI=;
        h=From:To:Cc:Subject:Date:From;
        b=Q5KVZSsrr/9yxfmwjrRxvlDVaPjjLAeKfT8mnCBR8AahRCwZu5DCyOs8PAhEDOTtS
         VkqfyeldnlXc/5NBTHgLAPK47OCelPFrMljcZrTeJYYAF8MsTTtqrSPwlFV9MaAq8t
         crkRImCb+aNpj+Hf0vhdb7D45gDyR9ErGJ0G9dAQ=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sgruszka@redhat.com
Subject: [PATCH] mt76: mt76x02u: fix sparse warnings: should it be static?
Date:   Wed, 12 Jun 2019 11:31:15 +0200
Message-Id: <c6348193727687b4b4dc7ba3397aef613ecfe289.1560331388.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix following sparse warnings in mt76x02_usb_core.c

drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c:29:6: warning:
symbol 'mt76x02u_tx_complete_skb' was not declared. Should it be static?
drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c:37:5: warning:
symbol 'mt76x02u_skb_dma_info' was not declared. Should it be static?
drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c:96:52: warning:
restricted __le16 degrades to integer
drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c:74:5: warning:
symbol 'mt76x02u_tx_prepare_skb' was not declared. Should it be static?
drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c:244:6: warning:
symbol 'mt76x02u_init_beacon_config' was not declared. Should it be
static?
drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c:262:6: warning:
symbol 'mt76x02u_exit_beacon_config' was not declared. Should it be
static?

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
index f3696afc1dde..1157d905b28c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
@@ -14,7 +14,7 @@
  * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
-#include "mt76x02.h"
+#include "mt76x02_usb.h"
 
 static void mt76x02u_remove_dma_hdr(struct sk_buff *skb)
 {
-- 
2.21.0

