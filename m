Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A928156AF9
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Feb 2020 16:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbgBIP23 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 9 Feb 2020 10:28:29 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34550 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727682AbgBIP23 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 9 Feb 2020 10:28:29 -0500
Received: by mail-wm1-f67.google.com with SMTP id s144so6634753wme.1
        for <linux-wireless@vger.kernel.org>; Sun, 09 Feb 2020 07:28:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fCWcqQrunjHI+5ZvOjzOZlCLgsAwORDxtjRMmMFFvTU=;
        b=HyDJPijbnlqygMIurWakFA866oVzQ4lKEhVEiXmFwCyWzU+LyPjngEqz7N3It6dwfT
         vPkmOAgboUlP5S4UGG16Wq6E5OUUef+g6ea+/PnfJD6y2lihpKHjMKcFoW+1+GMSlrJr
         9GNWPSdiB1AKaB4TMqXKKjyzN0blaGgwFoHboGSeERKAZJCsBJbE9PaMIuK2bHwYZTPl
         GUT1/GL4qfrtJxmsd8Zs/fEgDQsytJZGcvOW4rAcBr6j9XcDZ8cxEuVPll4Kcrx88RQc
         lZI0J0rarMcLjVwt1wN89elSdI75/WM9aiPEUnh3Hc+GdtyY3S5nLzcAs+6X/hXVY3gr
         aWqQ==
X-Gm-Message-State: APjAAAX5WcRbNm2kpL0smfR5KsxgOg/gnwvODPQ3rUMdN8iYMmopOSvg
        4mpp4FRR4/KJHhyaK3waOaADVQ9q
X-Google-Smtp-Source: APXvYqyDj53lBYZGNJ6Hgb+65R7FrEURauALULkx4LR7WAdZOmtp/ZYC3EL0vCM9J5QO9wFzrejquw==
X-Received: by 2002:a1c:545d:: with SMTP id p29mr10791703wmi.91.1581262106956;
        Sun, 09 Feb 2020 07:28:26 -0800 (PST)
Received: from localhost.localdomain ([87.71.82.22])
        by smtp.gmail.com with ESMTPSA id g128sm11454468wme.47.2020.02.09.07.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 07:28:26 -0800 (PST)
From:   Shay Bar <shay.bar@celeno.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, shay.bar@celeno.com,
        aviad.brikman@celeno.com
Subject: [PATCH] [PATCH] mac80211: fix wrong 160/80+80 Mhz setting
Date:   Sun,  9 Feb 2020 17:28:18 +0200
Message-Id: <20200209152818.4630-1-shay.bar@celeno.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Before this patch, STA's would set new width of 160/80+80 Mhz based on AP capability only.
This is wrong because STA may not support > 80Mhz BW.
Fix is to verify STA has 160/80+80 Mhz capability before increasing its width to > 80Mhz.

Signed-off-by: Aviad Brikman <aviad.brikman@celeno.com>
Signed-off-by: Shay Bar <shay.bar@celeno.com>
---
 net/mac80211/util.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 32a7a53833c0..950fa4741d98 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2987,10 +2987,22 @@ bool ieee80211_chandef_vht_oper(struct ieee80211_hw *hw,
 	int cf0, cf1;
 	int ccfs0, ccfs1, ccfs2;
 	int ccf0, ccf1;
+	u32 vht_cap;
+	bool support_80_80 = false;
+	bool support_160 = false;
 
 	if (!oper || !htop)
 		return false;
 
+	vht_cap = hw->wiphy->bands[chandef->chan->band]->vht_cap.cap;
+	support_160 = (vht_cap & (IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK |
+				  IEEE80211_VHT_CAP_EXT_NSS_BW_MASK));
+	support_80_80 = ((vht_cap &
+			 IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ) ||
+			(vht_cap & IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ &&
+			 vht_cap & IEEE80211_VHT_CAP_EXT_NSS_BW_MASK) ||
+			((vht_cap & IEEE80211_VHT_CAP_EXT_NSS_BW_MASK) >>
+				    IEEE80211_VHT_CAP_EXT_NSS_BW_SHIFT > 1));
 	ccfs0 = oper->center_freq_seg0_idx;
 	ccfs1 = oper->center_freq_seg1_idx;
 	ccfs2 = (le16_to_cpu(htop->operation_mode) &
@@ -3018,10 +3030,10 @@ bool ieee80211_chandef_vht_oper(struct ieee80211_hw *hw,
 			unsigned int diff;
 
 			diff = abs(ccf1 - ccf0);
-			if (diff == 8) {
+			if ((diff == 8) && support_160) {
 				new.width = NL80211_CHAN_WIDTH_160;
 				new.center_freq1 = cf1;
-			} else if (diff > 8) {
+			} else if ((diff > 8) && support_80_80) {
 				new.width = NL80211_CHAN_WIDTH_80P80;
 				new.center_freq2 = cf1;
 			}
-- 
2.17.1

