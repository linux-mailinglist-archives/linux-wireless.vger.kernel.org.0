Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5D29D408
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2019 18:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbfHZQcE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Aug 2019 12:32:04 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38931 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbfHZQcE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Aug 2019 12:32:04 -0400
Received: by mail-ot1-f65.google.com with SMTP id b1so15774954otp.6
        for <linux-wireless@vger.kernel.org>; Mon, 26 Aug 2019 09:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lVvBE222+nYpRcvfueLpMWe86nPeItQUIqj14j7uIkk=;
        b=aZAz5E9FYjQzCBgogI8vHGA1aiacCbIVLSusduufvPOeX8yENyyFgukYi7kCKiXco/
         0+l2BQBl5jd1s/ET8LxSj+rj44LnrIMYqJFUWdKFRcdw/IrFeBD687MDLImfdEBjbOqT
         KbmqcksQNyGZvI2cdzOj6+dAJqwmIgknwX9UuUmXWDibggz3tcaaV5I671zeYoKnEYpt
         ycwfpH5wQtgC4I7k17VBqdP2k8gahcc1/ZGaZIhWwg5asYlEhHHs/77VPIoDvxP9uJUR
         n3tF6qorYbpUw9zuyMYHip4yy+7V2dZG35evJWUJlTWIps0Gu+9ICHe8h7I3XObYciNf
         zHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lVvBE222+nYpRcvfueLpMWe86nPeItQUIqj14j7uIkk=;
        b=g+Xgbkkn/XtWez+PN9XqVIvknbyuwo+FTdUH4XlN5lZUeCMgTqkUsTbCt6dolUiHf/
         pf1+u/mQVsqATtre+lm/os5WKXVFFbWkjYuRE7Cwc6RSoWx2KiNmNLPHTddsCZj4wnd1
         /ZJlDHfKu4gEfu3/l07NcB05mAGg46StuzlRRqVZ8iWV5JwC9O48GYxEsQ4xl4bHalRQ
         iP4StHN4Ju7iEdVP8qeR+sJmgI2HKI64hCnlap1TWgzDQlHridM1WQxxJPG+3oALIGgu
         8F22gdBmb1OKDALC3TdKZrdYS6o3sw70OIQ2umpYYMYS4Ax8vUBB9omgY/FNZ8nfCqMm
         YLog==
X-Gm-Message-State: APjAAAWuKBUn1UwElFHEspzptilYNLQ9qqH1xeZfB0v1o+jA0tDhiuve
        8783oH1hgXQrx09clDmS1OTys2qw
X-Google-Smtp-Source: APXvYqwhcUzCyMcGoQg7UH6hAWmbDTqFm5U27KVp/AAghKA3/oeSkPN6A9sN0woy6Psirmk0D0cVtA==
X-Received: by 2002:a9d:6290:: with SMTP id x16mr16633013otk.292.1566837123004;
        Mon, 26 Aug 2019 09:32:03 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id t18sm4151278otk.73.2019.08.26.09.32.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2019 09:32:00 -0700 (PDT)
From:   Denis Kenzior <denkenz@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 1/2] nl80211: Add NL80211_EXT_FEATURE_LIVE_IFTYPE_CHANGE
Date:   Mon, 26 Aug 2019 11:26:36 -0500
Message-Id: <20190826162637.7535-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There is some ambiguity in how various drivers support
NL80211_CMD_SET_INTERFACE on devices where the underlying netdev is UP.
mac80211 for example supports this if the underlying driver provides a
change_interface operation.  However, most devices do not.  For FullMac
devices, the situation is even less clear.

This patch introduces a new feature flag that lets userspace know
whether it can expect a mode change (via SET_INTERFACE) to work while
the device is still UP or it should bring down the device first.

This commit also updates the documentation for SET_INTERFACE with hints
as to how it should be used.

Signed-off-by: Denis Kenzior <denkenz@gmail.com>
---
 include/uapi/linux/nl80211.h | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index bf7c4222f512..a9ca2fe67f52 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -275,6 +275,29 @@
  *	single %NL80211_ATTR_IFINDEX is supported.
  * @NL80211_CMD_SET_INTERFACE: Set type of a virtual interface, requires
  *	%NL80211_ATTR_IFINDEX and %NL80211_ATTR_IFTYPE.
+ *
+ *	Note that it is driver-dependent whether a SET_INTERFACE will be
+ *	allowed if the underlying netdev is currently UP.  Userspace
+ *	can obtain a hint as to whether this is allowed by looking at
+ *	the %NL80211_EXT_FEATURE_LIVE_IFTYPE_CHANGE, but certain restrictions
+ *	will still apply.
+ *
+ *	Prior to Kernel 5.4, userspace applications should implement the
+ *	following behavior:
+ *		1. (Optionally) Attempt SET_INTERFACE on a wireless device
+ *		   with the underlying netdev in the UP state.  If -EBUSY
+ *		   is returned proceed to 2.  Note that a SET_INTERFACE
+ *		   which results in -EBUSY might still result in other
+ *		   side-effects, such as Deauthentication, exiting AP mode,
+ *		   etc.
+ *		2. Bring the netdev DOWN via RTNL
+ *		3. Attempt SET_INTERFACE on the underlying netdev in the DOWN
+ *		   state.  If successful, proceed to 4.
+ *		4. Bring the netdev UP via RTNL
+ *
+ *	Note that bringing down the device might trigger a firmware reset /
+ *	power cycling and/or other effects that are driver dependent.
+ *
  * @NL80211_CMD_NEW_INTERFACE: Newly created virtual interface or response
  *	to %NL80211_CMD_GET_INTERFACE. Has %NL80211_ATTR_IFINDEX,
  *	%NL80211_ATTR_WIPHY and %NL80211_ATTR_IFTYPE attributes. Can also
@@ -5481,6 +5504,18 @@ enum nl80211_feature_flags {
  * @NL80211_EXT_FEATURE_SAE_OFFLOAD: Device wants to do SAE authentication in
  *	station mode (SAE password is passed as part of the connect command).
  *
+ * @NL80211_EXT_FEATURE_LIVE_IFTYPE_CHANGE: This device supports switching
+ * 	the IFTYPE of an interface without having to bring the device DOWN
+ * 	first via RTNL.  Exact semantics of this feature is driver
+ * 	implementation dependent.  For mac80211, the following restrictions
+ * 	apply:
+ * 		- Only devices currently in IFTYPE AP, P2P_GO, P2P_CLIENT,
+ * 		  STATION, ADHOC and OCB can be switched.
+ * 		- The target IFTYPE must be one of: AP, P2P_GO, P2P_CLIENT,
+ * 		  STATION, ADHOC or OCB.
+ * 	Other drivers are expected to follow similar restrictions.
+ * 	This flag was introduced in Kernel v5.4
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -5526,6 +5561,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_EXT_KEY_ID,
 	NL80211_EXT_FEATURE_STA_TX_PWR,
 	NL80211_EXT_FEATURE_SAE_OFFLOAD,
+	NL80211_EXT_FEATURE_LIVE_IFTYPE_CHANGE,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
-- 
2.19.2

