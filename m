Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5AF084687
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2019 10:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbfHGIAC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Aug 2019 04:00:02 -0400
Received: from nbd.name ([46.4.11.11]:33946 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728212AbfHGIAC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Aug 2019 04:00:02 -0400
Received: from pd95fd65c.dip0.t-ipconnect.de ([217.95.214.92] helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1hvGrY-00038j-Fr; Wed, 07 Aug 2019 10:00:00 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>
Subject: [PATCH 4/4] mac80211: add missing length field increment when generating Radiotap header
Date:   Wed,  7 Aug 2019 09:59:49 +0200
Message-Id: <20190807075949.32414-4-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807075949.32414-1-john@phrozen.org>
References: <20190807075949.32414-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The code generating the Tx Radiotap header when using tx_status_ext was
missing a field increment after setting the VHT bandwidth.

fixes commit 3d07ffcaf320 ("mac80211: add struct ieee80211_tx_status
support to ieee80211_add_tx_radiotap_header")

Signed-off-by: John Crispin <john@phrozen.org>
---
 net/mac80211/status.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index 471fcdc0f381..40886734fdc5 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -413,6 +413,7 @@ ieee80211_add_tx_radiotap_header(struct ieee80211_local *local,
 			*pos = 0;
 			break;
 		}
+		pos++;
 
 		/* u8 mcs_nss[4] */
 		*pos = (status->rate->mcs << 4) | status->rate->nss;
-- 
2.20.1

