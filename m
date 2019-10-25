Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAB1DE4AF3
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2019 14:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408201AbfJYMVT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Oct 2019 08:21:19 -0400
Received: from nbd.name ([46.4.11.11]:43310 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404706AbfJYMVS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Oct 2019 08:21:18 -0400
Received: from p5dcfbc27.dip0.t-ipconnect.de ([93.207.188.39] helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1iNyah-0000MS-C2; Fri, 25 Oct 2019 14:21:15 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>,
        Miles Hu <milehu@codeaurora.org>
Subject: [PATCH] mac80211: fix VHT BW reporting inside ieee80211_add_tx_radiotap_header
Date:   Fri, 25 Oct 2019 14:21:05 +0200
Message-Id: <20191025122105.14577-1-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The pointer offset was not incremented after setting the BW value when
reporting a VHT rate.
This fixes commit 3d07ffcaf320 ("mac80211: add struct ieee80211_tx_status
support to ieee80211_add_tx_radiotap_header")

Reported-by: Miles Hu <milehu@codeaurora.org>
Signed-off-by: John Crispin <john@phrozen.org>
---
 net/mac80211/status.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index f03aa8924d23..b036bf0269c2 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -406,6 +406,7 @@ ieee80211_add_tx_radiotap_header(struct ieee80211_local *local,
 			*pos = 0;
 			break;
 		}
+		pos++;
 
 		/* u8 mcs_nss[4] */
 		*pos = (status->rate->mcs << 4) | status->rate->nss;
-- 
2.20.1

