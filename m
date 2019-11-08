Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B953F57D2
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2019 21:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731195AbfKHTm0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Nov 2019 14:42:26 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:46156 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730685AbfKHTmZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Nov 2019 14:42:25 -0500
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 4396213C2B0;
        Fri,  8 Nov 2019 11:42:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 4396213C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1573242145;
        bh=CWOFwbroLrpeV7aUmHEyw2QuTFO/ZM9C25Nk3YNcBdI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U9t4Mnim31OuJPesUuIITcEkj8iTgVnBmak7n7yIahtF7XYRsF1GbE43OiItBKPWt
         L4Gj8CWQFKPANMPv6pe2uKzujDucZTCwDYH5XaOXsMUG8dSSQ9q5DOpPxOnCE31oA7
         Bta/+SZPFKOeN+HIJEoY9zBs/7VBDy/ff5WMM44o=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, Ben Greear <greearb@candelatech.com>
Subject: [PATCH 01/10] mac80211: Add comment about tx on monitor devs.
Date:   Fri,  8 Nov 2019 11:42:02 -0800
Message-Id: <20191108194210.23618-2-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108194210.23618-1-greearb@candelatech.com>
References: <20191108194210.23618-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

This tries to encapsulate email conversation with Johannes on
this topic for posterity's sake.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 net/mac80211/tx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 1fa422782905..05982538c3cf 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2277,6 +2277,12 @@ netdev_tx_t ieee80211_monitor_start_xmit(struct sk_buff *skb,
 	 * isn't always enough to find the interface to use; for proper
 	 * VLAN/WDS support we will need a different mechanism (which
 	 * likely isn't going to be monitor interfaces).
+	 *
+	 * I had a question about why we need to do this, and the answer
+	 * is that old hostap used this API and expects it to work like this,
+	 * and also monitor vdevs are not directly mapped into the driver
+	 * (and have no chantx in my case, at least), so you cannot directly
+	 * transmit on a monitor port anyway.
 	 */
 	sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 
-- 
2.20.1

