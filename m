Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52B0C157873
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2020 14:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730692AbgBJNHz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Feb 2020 08:07:55 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40905 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729406AbgBJNHz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Feb 2020 08:07:55 -0500
Received: by mail-wm1-f65.google.com with SMTP id t14so202947wmi.5
        for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2020 05:07:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iIBeftxXtx+X6uYg4/4ODPsk3DXx8AQwwhZfIfKz87s=;
        b=fY7FC0OvFHWPe8qSyhNggxlOBk2GZRWSDEFksQ0UkZrYbb43XbDrxNnm4YM6A/+y1v
         Ffq5jI9FUYno32W5I2RwukRyNQQ+P1fgOr3I9pwAtV9Mhh4IPCh+hvkHeHAyU7IgMTV3
         RbuzYeQ0t3HMq/SQ9aPPV8IW7z3FA+/eaKm+Qew/vLeVGH6+k8qAmeDT3W6BrfonsjcT
         BziiWXN1I5sWe0WA3uymIPqtlJh8+9ZbYp9cvq64tROtdnDsWe0sNb4FwnHEm/WGRWN9
         5OeDojV3ePInwiC2Y5eXzpUhsdmP0VUbrmMeY5RAqfhF9T4gqWOmvumMMKWKZ79WTKYf
         JwvQ==
X-Gm-Message-State: APjAAAW4VTFPezFo290tWWEhr4Aa3ltZNpdW//QyUW22ShXfY+EMCV97
        2j9PcosgGpIsaqwTqhzMmKO4sMGO
X-Google-Smtp-Source: APXvYqw5GdGR+ghnvAFuyf34MFW+dQZqDUB9FKQVf46exxlMw85YktTqOZFtZS49CJQ9mGNa8qLu4Q==
X-Received: by 2002:a05:600c:22d3:: with SMTP id 19mr15836516wmg.92.1581340073238;
        Mon, 10 Feb 2020 05:07:53 -0800 (PST)
Received: from localhost.localdomain ([87.71.82.22])
        by smtp.gmail.com with ESMTPSA id d204sm517989wmd.30.2020.02.10.05.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 05:07:52 -0800 (PST)
From:   Shay Bar <shay.bar@celeno.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, shay.bar@celeno.com,
        aviad.brikman@celeno.com
Subject: [PATCH] [PATCH] mac80211: fix wrong 160/80+80 Mhz setting
Date:   Mon, 10 Feb 2020 15:07:28 +0200
Message-Id: <20200210130728.23674-1-shay.bar@celeno.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200209152818.4630-1-shay.bar@celeno.com>
References: <20200209152818.4630-1-shay.bar@celeno.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Before this patch, STA's would set new width of 160/80+80 Mhz based on AP capability only.
This is wrong because STA may not support > 80Mhz BW.
Fix is to verify STA has 160/80+80 Mhz capability before increasing its width to > 80Mhz.

The "support_80_80" and "support_160" setting is based on:
"Table 9-272 — Setting of the Supported Channel Width Set subfield and Extended NSS BW
Support subfield at a STA transmitting the VHT Capabilities Information field"
From "Draft P802.11REVmd_D3.0.pdf"

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

