Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62B2D11E08B
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2019 10:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbfLMJ0p (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Dec 2019 04:26:45 -0500
Received: from nbd.name ([46.4.11.11]:32788 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbfLMJ0p (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Dec 2019 04:26:45 -0500
Received: from pd95fd344.dip0.t-ipconnect.de ([217.95.211.68] helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1ifhDe-0001pp-VG; Fri, 13 Dec 2019 10:26:43 +0100
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Sven Eckelmann <seckelmann@datto.com>,
        John Crispin <john@phrozen.org>
Subject: [PATCH] mac80211: he_support was not set when bringing up a HE mesh interface
Date:   Fri, 13 Dec 2019 10:26:36 +0100
Message-Id: <20191213092636.17736-1-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>

The he_support flag inside bss_conf was not set when a HE mesh interface
gets created. This causes the drivers to not set the HW up correctly.

Fixes: 60ad72da55ac ("mac80211: implement HE support for mesh")

Cc: Sven Eckelmann <seckelmann@datto.com>
Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
---
 net/mac80211/mesh.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index d09b3c789314..98d70f4ef6a4 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -551,6 +551,8 @@ int mesh_add_he_cap_ie(struct ieee80211_sub_if_data *sdata,
 	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_10)
 		return 0;
 
+	sdata->vif.bss_conf.he_support = 1;
+
 	if (skb_tailroom(skb) < ie_len)
 		return -ENOMEM;
 
-- 
2.20.1

