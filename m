Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14D5A7A909
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2019 14:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbfG3MyV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Jul 2019 08:54:21 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:60370 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfG3MyV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Jul 2019 08:54:21 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hsRdx-0005hu-7X; Tue, 30 Jul 2019 14:54:17 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.de>,
        Peter Lebbing <peter@digitalbrains.com>,
        Felix Fietkau <nbd@nbd.name>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] Revert "mac80211: set NETIF_F_LLTX when using intermediate tx queues"
Date:   Tue, 30 Jul 2019 14:54:11 +0200
Message-Id: <20190730125412.1446-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Revert this for now, it has been reported multiple times that it
completely breaks connectivity on various devices.

Cc: stable@vger.kernel.org
Fixes: 8dbb000ee73b ("mac80211: set NETIF_F_LLTX when using intermediate tx queues")
Reported-by: Jean Delvare <jdelvare@suse.de>
Reported-by: Peter Lebbing <peter@digitalbrains.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/iface.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 06aac0aaae64..8dc6580e1787 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1222,7 +1222,6 @@ static void ieee80211_if_setup(struct net_device *dev)
 static void ieee80211_if_setup_no_queue(struct net_device *dev)
 {
 	ieee80211_if_setup(dev);
-	dev->features |= NETIF_F_LLTX;
 	dev->priv_flags |= IFF_NO_QUEUE;
 }
 
-- 
2.20.1

