Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34FE1A187D
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2019 13:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfH2LaD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Aug 2019 07:30:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48430 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfH2LaC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Aug 2019 07:30:02 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 53D5A58569;
        Thu, 29 Aug 2019 11:30:02 +0000 (UTC)
Received: from localhost (unknown [10.43.2.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C7BA75D9C9;
        Thu, 29 Aug 2019 11:30:01 +0000 (UTC)
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>, Daniel Golle <daniel@makrotopia.org>,
        =?UTF-8?q?Tomislav=20Po=C5=BEega?= <pozega.tomislav@gmail.com>,
        Mathias Kresin <dev@kresin.me>,
        Sergey Maranchuk <slav0nic0@gmail.com>
Subject: [PATCH 5.3] Revert "rt2800: enable TX_PIN_CFG_LNA_PE_ bits per band"
Date:   Thu, 29 Aug 2019 13:29:59 +0200
Message-Id: <1567078199-3645-1-git-send-email-sgruszka@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 29 Aug 2019 11:30:02 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This reverts commit 9ad3b55654455258a9463384edb40077439d879f.

As reported by Sergey:

"I got some problem after upgrade kernel to 5.2 version (debian testing
linux-image-5.2.0-2-amd64). 5Ghz client  stopped to see AP.
Some tests with 1metre distance between client-AP: 2.4Ghz  -22dBm, for
5Ghz - 53dBm !, for longer distance (8m + walls) 2.4 - 61dBm, 5Ghz not
visible."

It was identified that rx signal level degradation was caused by
9ad3b5565445 ("rt2800: enable TX_PIN_CFG_LNA_PE_ bits per band").
So revert this commit.

Cc: <stable@vger.kernel.org> # v5.1+
Reported-and-tested-by: Sergey Maranchuk <slav0nic0@gmail.com>
Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
---
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index c9b957ac5733..b2bfa83819b0 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -4237,24 +4237,18 @@ static void rt2800_config_channel(struct rt2x00_dev *rt2x00dev,
 	switch (rt2x00dev->default_ant.rx_chain_num) {
 	case 3:
 		/* Turn on tertiary LNAs */
-		rt2x00_set_field32(&tx_pin, TX_PIN_CFG_LNA_PE_A2_EN,
-				   rf->channel > 14);
-		rt2x00_set_field32(&tx_pin, TX_PIN_CFG_LNA_PE_G2_EN,
-				   rf->channel <= 14);
+		rt2x00_set_field32(&tx_pin, TX_PIN_CFG_LNA_PE_A2_EN, 1);
+		rt2x00_set_field32(&tx_pin, TX_PIN_CFG_LNA_PE_G2_EN, 1);
 		/* fall-through */
 	case 2:
 		/* Turn on secondary LNAs */
-		rt2x00_set_field32(&tx_pin, TX_PIN_CFG_LNA_PE_A1_EN,
-				   rf->channel > 14);
-		rt2x00_set_field32(&tx_pin, TX_PIN_CFG_LNA_PE_G1_EN,
-				   rf->channel <= 14);
+		rt2x00_set_field32(&tx_pin, TX_PIN_CFG_LNA_PE_A1_EN, 1);
+		rt2x00_set_field32(&tx_pin, TX_PIN_CFG_LNA_PE_G1_EN, 1);
 		/* fall-through */
 	case 1:
 		/* Turn on primary LNAs */
-		rt2x00_set_field32(&tx_pin, TX_PIN_CFG_LNA_PE_A0_EN,
-				   rf->channel > 14);
-		rt2x00_set_field32(&tx_pin, TX_PIN_CFG_LNA_PE_G0_EN,
-				   rf->channel <= 14);
+		rt2x00_set_field32(&tx_pin, TX_PIN_CFG_LNA_PE_A0_EN, 1);
+		rt2x00_set_field32(&tx_pin, TX_PIN_CFG_LNA_PE_G0_EN, 1);
 		break;
 	}
 
-- 
1.9.3

