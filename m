Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAF383B5E0A
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Jun 2021 14:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbhF1Mf3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Jun 2021 08:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbhF1Mf2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Jun 2021 08:35:28 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D146C061574
        for <linux-wireless@vger.kernel.org>; Mon, 28 Jun 2021 05:33:01 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id bu12so29800945ejb.0
        for <linux-wireless@vger.kernel.org>; Mon, 28 Jun 2021 05:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qNRIoc5DV43PIBU2aWhdMhZdZje5YItIZIE7chBQGTk=;
        b=QF3+dwFZw6auko8c6k4+mP2GTyiOae7hMsUtpP3KO+7fX4Vsl+34jPCaTIiWe64W/h
         Hig19dcLELQjSFAZpB8c0jaBd1LWZ3bwuEaI+k/N4RSZpjU8W7rDevtnkxmyMQ1T6Cfw
         gemqr8JMv8jPeRuLRSUDG960CCxgky7OoNETjSDHQIr4UhKvYqfWlBm0yrVtkfV11MCF
         XzozampItHVQimUHVJZs3fustg3I+yUhDq2FWetb3M3bqRBK/y/RUZZ41VBwVWjhOHYI
         t9APRiNoyG0UPYIb7qI2cgJ8L/68AsDI0OngvVXHrOI8qAOWmDemPbpIxqQeCUrxy1Ai
         ry9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qNRIoc5DV43PIBU2aWhdMhZdZje5YItIZIE7chBQGTk=;
        b=acS4LEnF8NCqxoQiPxvNtsHLmxzOsRt8ZlASKY3n3hdwkDBGQZyP4pOk+iC/dGLLR4
         bd1pgJvvKirIw+JN5u1oX+VXAGIaGEQnxnuYo49pp7G8/eofk8yCjO+Q6gvW1xeS+vcn
         XZp+NFnHYd1jrA3jr+a5Z4E8RionxoSOdiEm+sgcIGg/E4907S5vIZu3QmmV3dIcYjjq
         +nWrn5ljSc75JxGEj4GfAQ7D65T6TM9t4BP/NBPC8gx1zgTa8uPGPWvnPfKQZxelXKlV
         ArXQJgeXPprP1IXgwgB/QJy7zLnWwmVbA/yGiZ3SuU0enibvas8fkFrXfB4Dlziu8sqR
         hxiw==
X-Gm-Message-State: AOAM530qqJE+L5GVgUdqd1e+TmpeACXIpL0wzofED7/lIZKhwLn8x/Ks
        TTqLHscElgmB4Hv2NqgXvCEJa5HdNDb5BCLbwJg=
X-Google-Smtp-Source: ABdhPJwCKXfvOoPe1/42r8UTs/ibxiO7bKyO3HqBWYUek46VflKKy9kJmpytiRygN18kZNffloBs6g==
X-Received: by 2002:a17:906:c2d9:: with SMTP id ch25mr24300815ejb.127.1624883580107;
        Mon, 28 Jun 2021 05:33:00 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id j22sm7139665ejt.11.2021.06.28.05.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 05:32:59 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH] mac80211: Fix monitor MTU limit so that A-MSDUs get through
Date:   Mon, 28 Jun 2021 14:32:46 +0200
Message-Id: <20210628123246.2070558-1-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The maximum MTU was set to 2304, which is the maximum MSDU size. While
this is valid for normal WLAN interfaces, it is too low for monitor
interfaces. A monitor interface may receive and inject MPDU frames, and
the maximum MPDU frame size is larger than 2304. The MPDU may also
contain an A-MSDU frame, in which case the size may be much larger than
the MTU limit. Since the maximum size of an A-MSDU depends on the PHY
mode of the transmitting STA, it is not possible to set an exact MTU
limit for a monitor interface. Now the maximum MTU for a monitor
interface is unrestricted.

Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
---
 net/mac80211/iface.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 1e5e9fc45523..cd96cd337aa8 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -2001,9 +2001,16 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
 
 		netdev_set_default_ethtool_ops(ndev, &ieee80211_ethtool_ops);
 
-		/* MTU range: 256 - 2304 */
+		/* MTU range is normally 256 - 2304, where the upper limit is
+		 * the maximum MSDU size. Monitor interfaces send and receive
+		 * MPDU and A-MSDU frames which may be much larger so we do
+		 * not impose an upper limit in that case.
+		 */
 		ndev->min_mtu = 256;
-		ndev->max_mtu = local->hw.max_mtu;
+		if (type == NL80211_IFTYPE_MONITOR)
+			ndev->max_mtu = 0;
+		else
+			ndev->max_mtu = local->hw.max_mtu;
 
 		ret = cfg80211_register_netdevice(ndev);
 		if (ret) {
-- 
2.25.1

