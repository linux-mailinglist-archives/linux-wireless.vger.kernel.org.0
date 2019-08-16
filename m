Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C343F90834
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2019 21:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfHPT1P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Aug 2019 15:27:15 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:32885 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727605AbfHPT1P (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Aug 2019 15:27:15 -0400
Received: by mail-oi1-f194.google.com with SMTP id q10so2069330oij.0
        for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2019 12:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3MGczJpJnhYpOa70SoGTinK2q8+c9qBiRlOOViZ2kQ4=;
        b=n8JXShHDgdiEvEqUov+OVLrPqMr2OSrPGUsvMPuI/Hp/MMhtUCU+nm0W9stJ5DHK3R
         54/61w1dLc8OtrOE5llf/B0Ogj+fnilOQ6+kRyiNxVTfd3hhSA3LyOh7K/AjzeO9VD3n
         jpntvSwi3QfN9bxCa9pFFOO2ZZV+3FTdymckFBKcWMo4x14VU+v3yY/0KiKCSy1yGFSi
         3kemrSMwk+uBYtuBDybV8CEl5oEOqyXrTbanCg+FPuobZUIv5V1bEAxVKVTBgcQfZDSy
         ffGun6UaBzfv9KNZeMslvsOrGop9NbmgShyTeSSGBlcITIHdvfXFWjrCNR0dVw7ciHY+
         1fIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3MGczJpJnhYpOa70SoGTinK2q8+c9qBiRlOOViZ2kQ4=;
        b=NC73cTGD+DKc52X0Q5NX1fcl5VnfdWNakv6UdmteSC/t9eT7MT74JzJhJ/20WUyfZH
         FNt7rXkWGyP6zjEnWZWJnZYw4X4xa7bYvPaqOpxC8r6hzziendV7cRpn/07yS9Yc4mlM
         QIEKzonBn9M9XI9W87xTrKIrfkjKZTz7bch3RRvqSnOiKQUDhbBvO0yg0f929cRJ3B1b
         xTsljvr8Q2rMS0i6oEe2eLJFn+fFnT2nfPUagLbefBqtLInC1xsWoIaglc8/30Ky6eZs
         Vi3c7Ilu9JP+kE84D5DWoJJlIwrObS0uP9ZJ3knCs1ztugSDnhIJSgUT9oIBsRfcs3fV
         Gziw==
X-Gm-Message-State: APjAAAVP3FJl1XigUTv+BwvmJtG6+TJbUIRJKazm/QMy1QlwDxXySlQy
        niqARfdolAhFKh69YZOMzuXVI3Da
X-Google-Smtp-Source: APXvYqzKC+zLnQVQjGaXXx/NcIrcmIDLRMV5uMIUr+1yl1NZ3hANjFsIHC3znu3RmGRiCFfGNk4ARQ==
X-Received: by 2002:aca:55d8:: with SMTP id j207mr6085381oib.38.1565983633830;
        Fri, 16 Aug 2019 12:27:13 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id b10sm2452246oti.61.2019.08.16.12.27.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2019 12:27:13 -0700 (PDT)
From:   Denis Kenzior <denkenz@gmail.com>
To:     linux-wireless@vger.kernel.org, johannes@sipsolutions.net
Cc:     Denis Kenzior <denkenz@gmail.com>
Subject: [RFCv2 4/4] nl80211: Send large new_wiphy events
Date:   Fri, 16 Aug 2019 14:27:03 -0500
Message-Id: <20190816192703.12445-4-denkenz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190816192703.12445-1-denkenz@gmail.com>
References: <20190816192703.12445-1-denkenz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Send large NEW_WIPHY events on a new multicast group so that clients
that can accept larger messages do not need to round-trip to the kernel
and perform extra filtered wiphy dumps.

A new multicast group is introduced and the large message is sent before
the legacy message.  This way clients that listen on both multicast
groups can ignore duplicate legacy messages if needed.

Signed-off-by: Denis Kenzior <denkenz@gmail.com>
---
 include/uapi/linux/nl80211.h |  1 +
 net/wireless/nl80211.c       | 28 +++++++++++++++++++++++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 822851d369ab..b9c1cf29cf09 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -50,6 +50,7 @@
 #define NL80211_MULTICAST_GROUP_MLME		"mlme"
 #define NL80211_MULTICAST_GROUP_VENDOR		"vendor"
 #define NL80211_MULTICAST_GROUP_NAN		"nan"
+#define NL80211_MULTICAST_GROUP_CONFIG2		"config2"
 #define NL80211_MULTICAST_GROUP_TESTMODE	"testmode"
 
 /**
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 24b67de99f3a..9ba9e1938d6b 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -46,6 +46,7 @@ enum nl80211_multicast_groups {
 	NL80211_MCGRP_MLME,
 	NL80211_MCGRP_VENDOR,
 	NL80211_MCGRP_NAN,
+	NL80211_MCGRP_CONFIG2,
 	NL80211_MCGRP_TESTMODE /* keep last - ifdef! */
 };
 
@@ -56,6 +57,7 @@ static const struct genl_multicast_group nl80211_mcgrps[] = {
 	[NL80211_MCGRP_MLME] = { .name = NL80211_MULTICAST_GROUP_MLME },
 	[NL80211_MCGRP_VENDOR] = { .name = NL80211_MULTICAST_GROUP_VENDOR },
 	[NL80211_MCGRP_NAN] = { .name = NL80211_MULTICAST_GROUP_NAN },
+	[NL80211_MCGRP_CONFIG2] = { .name = NL80211_MULTICAST_GROUP_CONFIG2 },
 #ifdef CONFIG_NL80211_TESTMODE
 	[NL80211_MCGRP_TESTMODE] = { .name = NL80211_MULTICAST_GROUP_TESTMODE }
 #endif
@@ -14730,12 +14732,34 @@ void nl80211_notify_wiphy(struct cfg80211_registered_device *rdev,
 			  enum nl80211_commands cmd)
 {
 	struct sk_buff *msg;
+	size_t alloc_size;
 	struct nl80211_dump_wiphy_state state = {};
 
 	WARN_ON(cmd != NL80211_CMD_NEW_WIPHY &&
 		cmd != NL80211_CMD_DEL_WIPHY);
 
-	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (cmd == NL80211_CMD_NEW_WIPHY) {
+		state.large_message = true;
+		alloc_size = 8192UL;
+	} else
+		alloc_size = NLMSG_DEFAULT_SIZE;
+
+	msg = nlmsg_new(alloc_size, GFP_KERNEL);
+	if (!msg)
+		goto legacy;
+
+	if (nl80211_send_wiphy(rdev, cmd, msg, 0, 0, 0, &state) < 0) {
+		nlmsg_free(msg);
+		goto legacy;
+	}
+
+	genlmsg_multicast_netns(&nl80211_fam, wiphy_net(&rdev->wiphy), msg, 0,
+				NL80211_MCGRP_CONFIG2, GFP_KERNEL);
+
+legacy:
+	state.large_message = false;
+	alloc_size = NLMSG_DEFAULT_SIZE;
+	msg = nlmsg_new(alloc_size, GFP_KERNEL);
 	if (!msg)
 		return;
 
@@ -14763,6 +14787,8 @@ void nl80211_notify_iface(struct cfg80211_registered_device *rdev,
 		return;
 	}
 
+	genlmsg_multicast_netns(&nl80211_fam, wiphy_net(&rdev->wiphy), msg, 0,
+				NL80211_MCGRP_CONFIG2, GFP_KERNEL);
 	genlmsg_multicast_netns(&nl80211_fam, wiphy_net(&rdev->wiphy), msg, 0,
 				NL80211_MCGRP_CONFIG, GFP_KERNEL);
 }
-- 
2.21.0

