Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6615384686
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2019 10:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbfHGIAC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Aug 2019 04:00:02 -0400
Received: from nbd.name ([46.4.11.11]:33940 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728202AbfHGIAB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Aug 2019 04:00:01 -0400
Received: from pd95fd65c.dip0.t-ipconnect.de ([217.95.214.92] helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1hvGrX-00038j-Tb; Wed, 07 Aug 2019 10:00:00 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>
Subject: [PATCH 3/4] mac80211: 80Mhz was not reported properly when using tx_status_ext
Date:   Wed,  7 Aug 2019 09:59:48 +0200
Message-Id: <20190807075949.32414-3-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807075949.32414-1-john@phrozen.org>
References: <20190807075949.32414-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When reporting 80MHz, we need to set 4 and not 2 inside the corresponding
field inside the Tx Radiotap header.

fixes commit 3d07ffcaf320 ("mac80211: add struct ieee80211_tx_status
support to ieee80211_add_tx_radiotap_header")

Signed-off-by: John Crispin <john@phrozen.org>
---
 net/mac80211/status.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index eaea07db83e7..471fcdc0f381 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -404,7 +404,7 @@ ieee80211_add_tx_radiotap_header(struct ieee80211_local *local,
 			*pos = 11;
 			break;
 		case RATE_INFO_BW_80:
-			*pos = 2;
+			*pos = 4;
 			break;
 		case RATE_INFO_BW_40:
 			*pos = 1;
-- 
2.20.1

