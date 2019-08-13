Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5856A8B076
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2019 09:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfHMHHU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Aug 2019 03:07:20 -0400
Received: from nbd.name ([46.4.11.11]:60658 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbfHMHHU (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Aug 2019 03:07:20 -0400
Received: from pd95fd499.dip0.t-ipconnect.de ([217.95.212.153] helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1hxQtp-0002qG-Ew; Tue, 13 Aug 2019 09:07:17 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] mac80211: fix possible NULL pointerderef in obss pd code
Date:   Tue, 13 Aug 2019 09:07:12 +0200
Message-Id: <20190813070712.25509-1-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

he_spr_ie_elem is dereferenced before the NULL check. fix this by moving
the assignment after the check.

fixes commit 697f6c507c74 ("mac80211: propagate HE operation info into
bss_conf")

This was reported by the static code checker.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: John Crispin <john@phrozen.org>
---
 net/mac80211/he.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/he.c b/net/mac80211/he.c
index a02abfc424aa..736da0035135 100644
--- a/net/mac80211/he.c
+++ b/net/mac80211/he.c
@@ -72,12 +72,13 @@ ieee80211_he_spr_ie_to_bss_conf(struct ieee80211_vif *vif,
 {
 	struct ieee80211_he_obss_pd *he_obss_pd =
 					&vif->bss_conf.he_obss_pd;
-	const u8 *data = he_spr_ie_elem->optional;
+	const u8 *data;
 
 	memset(he_obss_pd, 0, sizeof(*he_obss_pd));
 
 	if (!he_spr_ie_elem)
 		return;
+	data = he_spr_ie_elem->optional;
 
 	if (he_spr_ie_elem->he_sr_control &
 	    IEEE80211_HE_SPR_NON_SRG_OFFSET_PRESENT)
-- 
2.20.1

