Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910FD79C473
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Sep 2023 05:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjILD43 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Sep 2023 23:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237703AbjILD4Z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Sep 2023 23:56:25 -0400
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAA01BB
        for <linux-wireless@vger.kernel.org>; Mon, 11 Sep 2023 20:56:20 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-23.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-23.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:3a91:0:640:b9f:0])
        by forward103b.mail.yandex.net (Yandex) with ESMTP id 3466A60060;
        Tue, 12 Sep 2023 06:56:17 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-23.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id GuUv4EnDReA0-vacpplch;
        Tue, 12 Sep 2023 06:56:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1694490976; bh=HQHpdCNxOgavGCACxBEm1fIIDbU9uZjMRsmpfRLKIi0=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=vjZCROnjR6LX4GU+SHIiiqtIevD11Tuq2l53ySdBNIwQJNdz2SanpeN9aSN3OqpVh
         kP5i4qGV5FFUnr3Yact8mFAPtuMDm3bYxKHUOn4FNerAUMxt6030GUX1hIvd+3fMlr
         xcdSQRlB4pLUIaWFsbZktJk1Gn7F3QvnRs/vZlI8=
Authentication-Results: mail-nwsmtp-smtp-production-main-23.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] [v2] wifi: wext: avoid extra calls to strlen() in ieee80211_bss()
Date:   Tue, 12 Sep 2023 06:55:16 +0300
Message-ID: <20230912035522.15947-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <3fe90164dc6fe7471523de1d3a234c88c0e43e46.camel@sipsolutions.net>
References: <3fe90164dc6fe7471523de1d3a234c88c0e43e46.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since 'sprintf()' returns the number of characters emitted, an
extra calls to 'strlen()' in 'ieee80211_bss()' may be dropped.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: fix subject and reformat strings to avoid breaks (Johannes Berg)
---
 net/wireless/scan.c | 47 ++++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 19516073c6d5..ae4d000009fe 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -3422,59 +3422,63 @@ ieee80211_bss(struct wiphy *wiphy, struct iw_request_info *info,
 			cfg = (u8 *)ie + 2;
 			memset(&iwe, 0, sizeof(iwe));
 			iwe.cmd = IWEVCUSTOM;
-			sprintf(buf, "Mesh Network Path Selection Protocol ID: "
-				"0x%02X", cfg[0]);
-			iwe.u.data.length = strlen(buf);
+			iwe.u.data.length = sprintf(buf,
+						    "Mesh Network Path Selection Protocol ID: 0x%02X",
+						    cfg[0]);
 			current_ev = iwe_stream_add_point_check(info,
 								current_ev,
 								end_buf,
 								&iwe, buf);
 			if (IS_ERR(current_ev))
 				goto unlock;
-			sprintf(buf, "Path Selection Metric ID: 0x%02X",
-				cfg[1]);
-			iwe.u.data.length = strlen(buf);
+			iwe.u.data.length = sprintf(buf,
+						    "Path Selection Metric ID: 0x%02X",
+						    cfg[1]);
 			current_ev = iwe_stream_add_point_check(info,
 								current_ev,
 								end_buf,
 								&iwe, buf);
 			if (IS_ERR(current_ev))
 				goto unlock;
-			sprintf(buf, "Congestion Control Mode ID: 0x%02X",
-				cfg[2]);
-			iwe.u.data.length = strlen(buf);
+			iwe.u.data.length = sprintf(buf,
+						    "Congestion Control Mode ID: 0x%02X",
+						    cfg[2]);
 			current_ev = iwe_stream_add_point_check(info,
 								current_ev,
 								end_buf,
 								&iwe, buf);
 			if (IS_ERR(current_ev))
 				goto unlock;
-			sprintf(buf, "Synchronization ID: 0x%02X", cfg[3]);
-			iwe.u.data.length = strlen(buf);
+			iwe.u.data.length = sprintf(buf,
+						    "Synchronization ID: 0x%02X",
+						    cfg[3]);
 			current_ev = iwe_stream_add_point_check(info,
 								current_ev,
 								end_buf,
 								&iwe, buf);
 			if (IS_ERR(current_ev))
 				goto unlock;
-			sprintf(buf, "Authentication ID: 0x%02X", cfg[4]);
-			iwe.u.data.length = strlen(buf);
+			iwe.u.data.length = sprintf(buf,
+						    "Authentication ID: 0x%02X",
+						    cfg[4]);
 			current_ev = iwe_stream_add_point_check(info,
 								current_ev,
 								end_buf,
 								&iwe, buf);
 			if (IS_ERR(current_ev))
 				goto unlock;
-			sprintf(buf, "Formation Info: 0x%02X", cfg[5]);
-			iwe.u.data.length = strlen(buf);
+			iwe.u.data.length = sprintf(buf,
+						    "Formation Info: 0x%02X",
+						    cfg[5]);
 			current_ev = iwe_stream_add_point_check(info,
 								current_ev,
 								end_buf,
 								&iwe, buf);
 			if (IS_ERR(current_ev))
 				goto unlock;
-			sprintf(buf, "Capabilities: 0x%02X", cfg[6]);
-			iwe.u.data.length = strlen(buf);
+			iwe.u.data.length = sprintf(buf,
+						    "Capabilities: 0x%02X",
+						    cfg[6]);
 			current_ev = iwe_stream_add_point_check(info,
 								current_ev,
 								end_buf,
@@ -3530,17 +3534,16 @@ ieee80211_bss(struct wiphy *wiphy, struct iw_request_info *info,
 
 	memset(&iwe, 0, sizeof(iwe));
 	iwe.cmd = IWEVCUSTOM;
-	sprintf(buf, "tsf=%016llx", (unsigned long long)(ies->tsf));
-	iwe.u.data.length = strlen(buf);
+	iwe.u.data.length = sprintf(buf, "tsf=%016llx",
+				    (unsigned long long)(ies->tsf));
 	current_ev = iwe_stream_add_point_check(info, current_ev, end_buf,
 						&iwe, buf);
 	if (IS_ERR(current_ev))
 		goto unlock;
 	memset(&iwe, 0, sizeof(iwe));
 	iwe.cmd = IWEVCUSTOM;
-	sprintf(buf, " Last beacon: %ums ago",
-		elapsed_jiffies_msecs(bss->ts));
-	iwe.u.data.length = strlen(buf);
+	iwe.u.data.length = sprintf(buf, " Last beacon: %ums ago",
+				    elapsed_jiffies_msecs(bss->ts));
 	current_ev = iwe_stream_add_point_check(info, current_ev,
 						end_buf, &iwe, buf);
 	if (IS_ERR(current_ev))
-- 
2.41.0

