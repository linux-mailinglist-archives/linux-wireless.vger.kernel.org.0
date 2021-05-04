Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DED037270F
	for <lists+linux-wireless@lfdr.de>; Tue,  4 May 2021 10:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhEDIT6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 May 2021 04:19:58 -0400
Received: from mx4.wp.pl ([212.77.101.12]:21348 "EHLO mx4.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229848AbhEDIT5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 May 2021 04:19:57 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 May 2021 04:19:57 EDT
Received: (wp-smtpd smtp.wp.pl 6116 invoked from network); 4 May 2021 10:12:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1620115941; bh=KM8k3aF21vDfk36cHg5eft3SZzJ7dB3wKJ13fSZgBcA=;
          h=From:To:Cc:Subject;
          b=o8mEAU7A3onYouElQ58xA8TEauGcY04KjxtPJAtq6ipgdutfiCguaFuiKlXAYTYau
           mQLfMUfgu/p2WGXWQl5TYHeIxwh7cX/GFaNye3JmsqxC1J3nbHS+vIz+HHvgHQG9it
           eRvkG5p4q/LI53cnOvXb9DB2szNhI9LPkh+aSyyE=
Received: from 89-64-4-144.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.4.144])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <linux-wireless@vger.kernel.org>; 4 May 2021 10:12:21 +0200
From:   stf_xl@wp.pl
To:     linux-wireless@vger.kernel.org
Cc:     n0w1re <n0w1re@protonmail.ch>, ZeroBeat <ZeroBeat@gmx.de>
Subject: [PATCH] rt2x00: do not set timestamp for injected frames
Date:   Tue,  4 May 2021 10:12:20 +0200
Message-Id: <20210504081220.666939-1-stf_xl@wp.pl>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: 633a30985c8e0ddeee1c069b095cacbc
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [UYME]                               
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Stanislaw Gruszka <stf_xl@wp.pl>

We setup hardware to insert TSF timestamp for beacon and probe response
frames. This is undesired for injected frames, which might want to
set their own timestamp values, so disable this setting for injected
frames.

Tested-by: ZeroBeat <ZeroBeat@gmx.de>
Tested-by: n0w1re <n0w1re@protonmail.ch>
Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
---
 drivers/net/wireless/ralink/rt2x00/rt2x00queue.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00queue.c b/drivers/net/wireless/ralink/rt2x00/rt2x00queue.c
index d4d389e8f1b4..fb1d31b2d52a 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00queue.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00queue.c
@@ -446,8 +446,9 @@ static void rt2x00queue_create_tx_descriptor(struct rt2x00_dev *rt2x00dev,
 	 * Beacons and probe responses require the tsf timestamp
 	 * to be inserted into the frame.
 	 */
-	if (ieee80211_is_beacon(hdr->frame_control) ||
-	    ieee80211_is_probe_resp(hdr->frame_control))
+	if ((ieee80211_is_beacon(hdr->frame_control) ||
+	     ieee80211_is_probe_resp(hdr->frame_control)) &&
+	    !(tx_info->flags & IEEE80211_TX_CTL_INJECTED))
 		__set_bit(ENTRY_TXD_REQ_TIMESTAMP, &txdesc->flags);
 
 	if ((tx_info->flags & IEEE80211_TX_CTL_FIRST_FRAGMENT) &&
-- 
2.25.4

