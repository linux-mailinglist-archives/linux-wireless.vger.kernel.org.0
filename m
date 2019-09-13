Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E871B265E
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2019 22:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730230AbfIMUBK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Sep 2019 16:01:10 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42067 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729118AbfIMUBJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Sep 2019 16:01:09 -0400
Received: by mail-pg1-f193.google.com with SMTP id z12so4231741pgp.9
        for <linux-wireless@vger.kernel.org>; Fri, 13 Sep 2019 13:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4Eicm0Blj7n+hlvjAcRMvx9cHlUFI00V7wivoLqTqgA=;
        b=RYQJzH5I8wIGmsXJ/nZYSJ2aCPSEZ7Z401ifdEvnR/AdIO7X/KDI5qQnsEjDMqKWs+
         l5leqbRQbT81kPuLHBAav7A9zIgJ629Ms5chlYx+/Rh2KzDFLfYUs3lQ+LH3lqqfrGyE
         OTBn7NrV3iFOWkaTLRvWqgiO9ypGp7AdytpQ9SKWSACnl2aoNWAWor63tAgKTeVyv4kM
         Ny5mzydc6Y1IjbJdtOwFWifWBUjRKBGKuDUTb9YaUbkq8en4OkK1/T6H3R6CTb9eblsN
         x0ftNlLKxBd8uiu6VHmrN3JgswqiV7khz/Fgvz1clshcnvPYS3Fv823ml9OgkSV1DP+I
         yl5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4Eicm0Blj7n+hlvjAcRMvx9cHlUFI00V7wivoLqTqgA=;
        b=XaIKtd1svufA942ckcYKnUDs0MAqcZee3wrT5FTvGUbO5sBXBIXbLYWHjLosi6fZNe
         6MJVb0lnYAfIUv+2vbxH6IiKWgRIi+jXUB4mVMMQngr1dM/j/ZNJNu4ojkdXF2azSc3i
         qi898sAss/IuBcP1maiXWV6LO0lCiIbHWDaz5C8j9MP697jwELGmoAe5x9iUpZFKrG5T
         d7tOaXL/dIdGz0sENTXG/cL1g69I1Sw/oRXSmPyxQX67aoX13eZQyVNqYx9YAn0njuGQ
         LYC7/TAVA1hSRBQXBP73ipMGd+/yLFznZdDDEJUvfG1rOKmwg5c3j0eplcTVJQLsEIRE
         6L+g==
X-Gm-Message-State: APjAAAVXUfE9+frVYXjYrORkLPVmxBrkkNUlfuZddrnUiPQO7iCQrnJR
        28alLY+Mc/g6lAkLd24sZIeih5tWdSY=
X-Google-Smtp-Source: APXvYqwMm2+aDUPXQYtwmjEXAof/KwHwRbUfyNZgdglgQDusx07xHVpGB630iR0k0768zp6c9fCLlA==
X-Received: by 2002:a63:e14d:: with SMTP id h13mr9641803pgk.431.1568404868499;
        Fri, 13 Sep 2019 13:01:08 -0700 (PDT)
Received: from jprestwo-test.jf.intel.com ([134.134.139.76])
        by smtp.gmail.com with ESMTPSA id 143sm24819392pgc.6.2019.09.13.13.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 13:01:07 -0700 (PDT)
From:   James Prestwood <prestwoj@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] nl80211: Add LIVE_ADDR_CHANGE feature
Date:   Fri, 13 Sep 2019 12:59:07 -0700
Message-Id: <20190913195908.7871-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add a new feature bit signifying that the wireless hardware supports
changing the mac address while the underlying net_device is UP.  Note
that this is slightly different from IFF_LIVE_ADDR_CHANGE as additional
restrictions might be imposed by the hardware.  Typical restrictions
are:
	- No connection is active on this interface, e.g. carrier is off
	- No scan is in progress
	- No offchannel operation is in progress

Signed-off-by: James Prestwood <prestwoj@gmail.com>
---
 include/uapi/linux/nl80211.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index bf7c4222f512..0ceb945a08fb 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -5481,6 +5481,14 @@ enum nl80211_feature_flags {
  * @NL80211_EXT_FEATURE_SAE_OFFLOAD: Device wants to do SAE authentication in
  *	station mode (SAE password is passed as part of the connect command).
  *
+ * @NL80211_EXT_FEATURE_LIVE_ADDR_CHANGE: Device can perform a MAC address
+ *	change without having to bring the underlying network device down
+ *	first.  For example, in station mode this can be used to vary the
+ *	origin MAC address prior to a connection to a new AP for privacy
+ *	or other reasons.  Note that certain driver specific restrictions
+ *	might apply, e.g. no scans in progress, no offchannel operations
+ *	in progress, and no active connections.
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -5526,6 +5534,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_EXT_KEY_ID,
 	NL80211_EXT_FEATURE_STA_TX_PWR,
 	NL80211_EXT_FEATURE_SAE_OFFLOAD,
+	NL80211_EXT_FEATURE_LIVE_ADDRESS_CHANGE,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
-- 
2.17.1

