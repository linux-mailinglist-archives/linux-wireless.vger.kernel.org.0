Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA0DD153BA9
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2020 00:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbgBEXKN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Feb 2020 18:10:13 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45441 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbgBEXKN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Feb 2020 18:10:13 -0500
Received: by mail-pg1-f195.google.com with SMTP id b9so1686339pgk.12
        for <linux-wireless@vger.kernel.org>; Wed, 05 Feb 2020 15:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TqEp2SmmW+SNuykFM4pNlhOmQNUpi+heCzDD1HjUq+0=;
        b=cvyLqIHYOitniKPqISdLIoFsxc19rhBtTDoZxfnTDElOee4/H1cT6XLEM+6cBvwR0X
         2loEEyI5FLpTyfmEZTJi6bZiKfX7LHcoP5ZVVIVCEuJnrZZx18nZRS7GQ/GkGuofMECT
         o2rKo/9oe/RL2A+SRVad3uoqtQ7ovnXlTuL/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TqEp2SmmW+SNuykFM4pNlhOmQNUpi+heCzDD1HjUq+0=;
        b=DxU7CehLi4HsQucBcc1pbX70XOfUtu5rdR89/acdnWwvqCHRXwl94x9ELhkmrqjnVu
         fUzWGxhSNdLAwa4/1mBjwivbsabG7aDAWgP/J1WP+u2fYcOoTIEoDEzIa2TMfhfbVRJu
         nN9t3a26MeqZ/vgfnZJp4S72/QIvUBVj941K2sGI3OQgp+eUuzPE6Xm8tL42+Qx9cN9I
         edMsjV3q4xhdKRIJfOR2WkyJYekZcDKwPJzG2ADsr3ecQh76wiMxb8VUA4cnG3JA4SKX
         g+lz5vn0cFjvKN1+mKK+BrZqN4wmEq4AHAQaMwmH1AfvhwrtxNxtob7Ro5HNTsbpDqX0
         Bahg==
X-Gm-Message-State: APjAAAVbjtl5rIhXK2qClaWfqUaX9LGWtfFLORgKteK+ALigDx+kNCvy
        OtsuABqGUmQVbzvEq3j2N47oDGkb7O0=
X-Google-Smtp-Source: APXvYqxAwoRMA8rJ6Xm7bPNUHbQCQk8FSc7NObtwNUZzozvaKmlloHXjCD5bdrswqYkbgfhHS+Q5IA==
X-Received: by 2002:aa7:9d87:: with SMTP id f7mr418375pfq.138.1580944212559;
        Wed, 05 Feb 2020 15:10:12 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id t63sm567963pfb.70.2020.02.05.15.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 15:10:11 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Luca Coelho <luciano.coelho@intel.com>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 1/3] iw: update nl80211.h
Date:   Wed,  5 Feb 2020 15:09:59 -0800
Message-Id: <20200205231001.132595-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pulled from -next.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 nl80211.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/nl80211.h b/nl80211.h
index 5eab191607f8..809ef9165684 100644
--- a/nl80211.h
+++ b/nl80211.h
@@ -2400,6 +2400,8 @@ enum nl80211_commands {
  * @NL80211_ATTR_VLAN_ID: VLAN ID (1..4094) for the station and VLAN group key
  *	(u16).
  *
+ * @NL80211_ATTR_HE_BSS_COLOR: nested attribute for BSS Color Settings.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -2864,6 +2866,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_VLAN_ID,
 
+	NL80211_ATTR_HE_BSS_COLOR,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -6587,5 +6591,27 @@ enum nl80211_obss_pd_attributes {
 	NL80211_HE_OBSS_PD_ATTR_MAX = __NL80211_HE_OBSS_PD_ATTR_LAST - 1,
 };
 
+/**
+ * enum nl80211_bss_color_attributes - BSS Color attributes
+ * @__NL80211_HE_BSS_COLOR_ATTR_INVALID: Invalid
+ *
+ * @NL80211_HE_BSS_COLOR_ATTR_COLOR: the current BSS Color.
+ * @NL80211_HE_BSS_COLOR_ATTR_DISABLED: is BSS coloring disabled.
+ * @NL80211_HE_BSS_COLOR_ATTR_PARTIAL: the AID equation to be used..
+ *
+ * @__NL80211_HE_BSS_COLOR_ATTR_LAST: Internal
+ * @NL80211_HE_BSS_COLOR_ATTR_MAX: highest BSS Color attribute.
+ */
+enum nl80211_bss_color_attributes {
+	__NL80211_HE_BSS_COLOR_ATTR_INVALID,
+
+	NL80211_HE_BSS_COLOR_ATTR_COLOR,
+	NL80211_HE_BSS_COLOR_ATTR_DISABLED,
+	NL80211_HE_BSS_COLOR_ATTR_PARTIAL,
+
+	/* keep last */
+	__NL80211_HE_BSS_COLOR_ATTR_LAST,
+	NL80211_HE_BSS_COLOR_ATTR_MAX = __NL80211_HE_BSS_COLOR_ATTR_LAST - 1,
+};
 
 #endif /* __LINUX_NL80211_H */
-- 
2.25.0.341.g760bfbb309-goog

