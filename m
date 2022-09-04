Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C70E5AC624
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Sep 2022 21:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234933AbiIDT3j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 4 Sep 2022 15:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234798AbiIDT32 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 4 Sep 2022 15:29:28 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CFEE47
        for <linux-wireless@vger.kernel.org>; Sun,  4 Sep 2022 12:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Vgsv8HQMTzYZeqKn9+OV7mnf0XXRWj0X2rUbLf9lWWg=;
        t=1662319762; x=1663529362; b=eLRy5Ct1rol4HPGK0a2hHpRy++GDWGkhbkP2T62VG81BnUt
        clOPmVlDWICVa5VOBDF91nZDiQj1xO/N0mt8OiGbwKnYSz+bnalJzea9VEzOd/swD/FD1Z/JReY57
        O5HrvI/8jSTkWjkjjgEeadBlOaItzHv+6xprCII26woMR6adEwFDwFNZCwMP84F8HV1UG0QAwCMmm
        CbmaHhHILhITI+F4CRo/VhxB8FTsq5NX4GuEkdU7+axtReFp5DXoXG6jIMifOIJMnpj2ycRP0N5xh
        coBT4wqiDfYQ8UPLODdH+eWVBNE9mPdk59TqcRNc3STWCPXxfxxt/GMX9Chu8ADw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oUvJ0-007pTZ-0d;
        Sun, 04 Sep 2022 21:29:18 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 05/12] wifi: wl18xx: add some missing endian conversions
Date:   Sun,  4 Sep 2022 21:29:05 +0200
Message-Id: <20220904212910.2b5cb713cf4b.Ibabba2deb7bb22863d3a134e7a3333422d7eff17@changeid>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220904212910.8169e8c9090c.I0357e80cc86be2d4ac6205d1f53568444dcf7c9b@changeid>
References: <20220904212910.8169e8c9090c.I0357e80cc86be2d4ac6205d1f53568444dcf7c9b@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This caused sparse warnings, and clearly is needed per
how other firmware interfaces behave.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/ti/wl18xx/event.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ti/wl18xx/event.c b/drivers/net/wireless/ti/wl18xx/event.c
index 13d78ada4bb6..34d95f458e1a 100644
--- a/drivers/net/wireless/ti/wl18xx/event.c
+++ b/drivers/net/wireless/ti/wl18xx/event.c
@@ -131,10 +131,10 @@ int wl18xx_process_mailbox_events(struct wl1271 *wl)
 
 	if (vector & TIME_SYNC_EVENT_ID)
 		wlcore_event_time_sync(wl,
-			mbox->time_sync_tsf_high_msb,
-			mbox->time_sync_tsf_high_lsb,
-			mbox->time_sync_tsf_low_msb,
-			mbox->time_sync_tsf_low_lsb);
+			le16_to_cpu(mbox->time_sync_tsf_high_msb),
+			le16_to_cpu(mbox->time_sync_tsf_high_lsb),
+			le16_to_cpu(mbox->time_sync_tsf_low_msb),
+			le16_to_cpu(mbox->time_sync_tsf_low_lsb));
 
 	if (vector & RADAR_DETECTED_EVENT_ID) {
 		wl1271_info("radar event: channel %d type %s",
-- 
2.37.2

