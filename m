Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976D278D2C8
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Aug 2023 06:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbjH3EeZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Aug 2023 00:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234966AbjH3EeP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Aug 2023 00:34:15 -0400
Received: from forward101c.mail.yandex.net (forward101c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2AD1A3
        for <linux-wireless@vger.kernel.org>; Tue, 29 Aug 2023 21:34:12 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:150a:0:640:1aa5:0])
        by forward101c.mail.yandex.net (Yandex) with ESMTP id 75CB960026;
        Wed, 30 Aug 2023 07:34:09 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 8YI2M8JWr4Y0-6DClHvKL;
        Wed, 30 Aug 2023 07:34:09 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1693370049;
        bh=MYKTsZ9o0vJn8lO4Qhc4/nKkaDY9j9sT1iaFi1IdmUE=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=HwSH8/Y/05AmQxugvN5ySFVnptI/dRVi4/hA3LNwATZmgxALyWz6dJSRvH9u9/drQ
         iDazLICKtyzPrQdM8KOymsJsVgqiM2CFvOu86XXVuMiQtfOm5KV8pLb6hGvp0ca6Fx
         yULzow2/bUTBHOajRkx39ynFuoQCRK+46IcUdMqs=
Authentication-Results: mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 1/2] wifi: cfg80211: avoid extra calls to strlen() in ieee80211_bss()
Date:   Wed, 30 Aug 2023 07:33:17 +0300
Message-ID: <20230830043346.28303-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since 'sprintf()' returns the number of characters emitted, an
extra calls to 'strlen()' in 'ieee80211_bss()' may be dropped.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 net/wireless/scan.c | 42 ++++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 0cf1ce7b6934..4f4990ca7ba7 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -3422,59 +3422,58 @@ ieee80211_bss(struct wiphy *wiphy, struct iw_request_info *info,
 			cfg = (u8 *)ie + 2;
 			memset(&iwe, 0, sizeof(iwe));
 			iwe.cmd = IWEVCUSTOM;
-			sprintf(buf, "Mesh Network Path Selection Protocol ID: "
-				"0x%02X", cfg[0]);
-			iwe.u.data.length = strlen(buf);
+			iwe.u.data.length = sprintf(buf, "Mesh Network Path "
+						    "Selection Protocol ID: "
+						    "0x%02X", cfg[0]);
 			current_ev = iwe_stream_add_point_check(info,
 								current_ev,
 								end_buf,
 								&iwe, buf);
 			if (IS_ERR(current_ev))
 				goto unlock;
-			sprintf(buf, "Path Selection Metric ID: 0x%02X",
-				cfg[1]);
-			iwe.u.data.length = strlen(buf);
+			iwe.u.data.length = sprintf(buf, "Path Selection "
+						    "Metric ID: 0x%02X",
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
+			iwe.u.data.length = sprintf(buf, "Congestion Control "
+						    "Mode ID: 0x%02X", cfg[2]);
 			current_ev = iwe_stream_add_point_check(info,
 								current_ev,
 								end_buf,
 								&iwe, buf);
 			if (IS_ERR(current_ev))
 				goto unlock;
-			sprintf(buf, "Synchronization ID: 0x%02X", cfg[3]);
-			iwe.u.data.length = strlen(buf);
+			iwe.u.data.length = sprintf(buf, "Synchronization ID: "
+						    "0x%02X", cfg[3]);
 			current_ev = iwe_stream_add_point_check(info,
 								current_ev,
 								end_buf,
 								&iwe, buf);
 			if (IS_ERR(current_ev))
 				goto unlock;
-			sprintf(buf, "Authentication ID: 0x%02X", cfg[4]);
-			iwe.u.data.length = strlen(buf);
+			iwe.u.data.length = sprintf(buf, "Authentication ID: "
+						    "0x%02X", cfg[4]);
 			current_ev = iwe_stream_add_point_check(info,
 								current_ev,
 								end_buf,
 								&iwe, buf);
 			if (IS_ERR(current_ev))
 				goto unlock;
-			sprintf(buf, "Formation Info: 0x%02X", cfg[5]);
-			iwe.u.data.length = strlen(buf);
+			iwe.u.data.length = sprintf(buf, "Formation Info: "
+						    "0x%02X", cfg[5]);
 			current_ev = iwe_stream_add_point_check(info,
 								current_ev,
 								end_buf,
 								&iwe, buf);
 			if (IS_ERR(current_ev))
 				goto unlock;
-			sprintf(buf, "Capabilities: 0x%02X", cfg[6]);
-			iwe.u.data.length = strlen(buf);
+			iwe.u.data.length = sprintf(buf, "Capabilities: "
+						    "0x%02X", cfg[6]);
 			current_ev = iwe_stream_add_point_check(info,
 								current_ev,
 								end_buf,
@@ -3530,17 +3529,16 @@ ieee80211_bss(struct wiphy *wiphy, struct iw_request_info *info,
 
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

