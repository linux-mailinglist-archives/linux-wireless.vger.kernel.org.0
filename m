Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67CEC233EDA
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jul 2020 07:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730173AbgGaF4l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Jul 2020 01:56:41 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:56444 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726972AbgGaF4k (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Jul 2020 01:56:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 228034E7D77;
        Fri, 31 Jul 2020 05:56:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id X9p6TloNSJrd; Fri, 31 Jul 2020 05:56:37 +0000 (UTC)
Received: from tractor.ibsgaard.io (c-73-202-5-52.hsd1.ca.comcast.net [73.202.5.52])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id F40974E7AC3;
        Fri, 31 Jul 2020 05:56:36 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        ath10k <ath10k@lists.infradead.org>, sfr@canb.auug.org.au,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH mac80211-next] ath10k: fix unhandled switch value warning
Date:   Thu, 30 Jul 2020 22:56:36 -0700
Message-Id: <20200731055636.795173-1-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Cited commit introduced the following warnings:

drivers/net/wireless/ath/ath10k/mac.c: In function 'chan_to_phymode':
drivers/net/wireless/ath/ath10k/mac.c:558:3: warning: enumeration value 'NL80211_CHAN_WIDTH_1' not handled in switch [-Wswitch]
  558 |   switch (chandef->width) {
      |   ^~~~~~
drivers/net/wireless/ath/ath10k/mac.c:558:3: warning: enumeration value 'NL80211_CHAN_WIDTH_2' not handled in switch [-Wswitch]
drivers/net/wireless/ath/ath10k/mac.c:558:3: warning: enumeration value 'NL80211_CHAN_WIDTH_4' not handled in switch [-Wswitch]
drivers/net/wireless/ath/ath10k/mac.c:558:3: warning: enumeration value 'NL80211_CHAN_WIDTH_8' not handled in switch [-Wswitch]
drivers/net/wireless/ath/ath10k/mac.c:558:3: warning: enumeration value 'NL80211_CHAN_WIDTH_16' not handled in switch [-Wswitch]
drivers/net/wireless/ath/ath10k/mac.c:581:3: warning: enumeration value 'NL80211_CHAN_WIDTH_1' not handled in switch [-Wswitch]
  581 |   switch (chandef->width) {
      |   ^~~~~~
drivers/net/wireless/ath/ath10k/mac.c:581:3: warning: enumeration value 'NL80211_CHAN_WIDTH_2' not handled in switch [-Wswitch]
drivers/net/wireless/ath/ath10k/mac.c:581:3: warning: enumeration value 'NL80211_CHAN_WIDTH_4' not handled in switch [-Wswitch]
drivers/net/wireless/ath/ath10k/mac.c:581:3: warning: enumeration value 'NL80211_CHAN_WIDTH_8' not handled in switch [-Wswitch]
drivers/net/wireless/ath/ath10k/mac.c:581:3: warning: enumeration value 'NL80211_CHAN_WIDTH_16' not handled in switch [-Wswitch]

Fix them by making the existing invalid channel width
cases the default, as the introduced channel widths
currently don't make sense in 2 or 5GHz either.

Fixes: e5cb3d34a66d ("nl80211: S1G band and channel definitions")
Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
---
 drivers/net/wireless/ath/ath10k/mac.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 919d15584d4a..3c0c33a9f30c 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -568,11 +568,7 @@ chan_to_phymode(const struct cfg80211_chan_def *chandef)
 		case NL80211_CHAN_WIDTH_40:
 			phymode = MODE_11NG_HT40;
 			break;
-		case NL80211_CHAN_WIDTH_5:
-		case NL80211_CHAN_WIDTH_10:
-		case NL80211_CHAN_WIDTH_80:
-		case NL80211_CHAN_WIDTH_80P80:
-		case NL80211_CHAN_WIDTH_160:
+		default:
 			phymode = MODE_UNKNOWN;
 			break;
 		}
@@ -597,8 +593,7 @@ chan_to_phymode(const struct cfg80211_chan_def *chandef)
 		case NL80211_CHAN_WIDTH_80P80:
 			phymode = MODE_11AC_VHT80_80;
 			break;
-		case NL80211_CHAN_WIDTH_5:
-		case NL80211_CHAN_WIDTH_10:
+		default:
 			phymode = MODE_UNKNOWN;
 			break;
 		}
-- 
2.27.0

