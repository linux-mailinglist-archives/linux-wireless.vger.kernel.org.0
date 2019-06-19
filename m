Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFC714C3C0
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2019 00:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730089AbfFSWgj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Jun 2019 18:36:39 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46295 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfFSWgi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Jun 2019 18:36:38 -0400
Received: by mail-io1-f68.google.com with SMTP id i10so2155656iol.13
        for <linux-wireless@vger.kernel.org>; Wed, 19 Jun 2019 15:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QURT5SwuveJ6XJjyoUTtNUT5nKXxo/BA0vNI7NeFVBY=;
        b=iOyNl1DkoGZ/Pyw7siCkLnlQ4qXazjEwCadT1dE1bjtYvPQ+Zi+VKEqAQGiwJZg59k
         0NMy36GFhRjoPpdw5y5rqT/pww6fLlGHEbgbi35NzmNNvOMH9XosaYbRXMLxbvQd4YZJ
         e+8WbV7TX6xvfQbkncPVsRp2wsoYwpmYjDfnDSL4+y9/k87/AN5MNYQd/OKqE5wwuF28
         PcDJyWHa84BqyClEJFV6rwaX63zobLOS4ezPfCEAkzBty+PPmPJRWHW0ThrtBz2UvM3h
         hvJMXw4tilKZA4Do7swyjlvZsOlMjYgbEsOFGUAjV3p1V1mVWehL0tE6T0qVKFLHo2kk
         HnbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QURT5SwuveJ6XJjyoUTtNUT5nKXxo/BA0vNI7NeFVBY=;
        b=OirSMAwKpagNCqDUAJmRwCICmDdyD0XsZhOosorT+8foHGR2WnWAzTQWDVFiubK4+5
         Cq3uGydx81iqf6hy6ANSKNRFGTzRVBC6N/ldiDyfV8U47WQUjbAujuDm3QeVyEa6HfbU
         CwLtgnNIdxmcJz0V9sKJm0ZM5zAALRVlSmitiM1TFRxJ7cpqPLHI4N94axfd9PJs5VWX
         VTo4f4b+7odqd7BCjh0aCiBDxgHheUbrTb7OiRn2UJvLH9zzRwaPn0CFT8mC0PHnXrHQ
         Ts77d9AuJDODta/k0gyZI5o9FAxPtsjACptP7FB+umVbkJDe5UCjeANffKfCsTsJugEi
         MxXQ==
X-Gm-Message-State: APjAAAU8eFGiwfZQICC1+M36i+XFR2yQZ6wRlmpYNU51678RQbOld3s6
        toGq0K8+75ARZAZR4aJ/u8c=
X-Google-Smtp-Source: APXvYqz0sCr05+TQy2VLoU5M+QTOaf/TAU7oaZ00P5BosDaiZy6tJTzv8mBqqAZRaEl2EDa0xiOQ3w==
X-Received: by 2002:a6b:6505:: with SMTP id z5mr6681897iob.295.1560983797696;
        Wed, 19 Jun 2019 15:36:37 -0700 (PDT)
Received: from new-host-2.home.home ([2605:a601:808:1001:37ba:4f0a:192f:f945])
        by smtp.gmail.com with ESMTPSA id y20sm15928646ion.77.2019.06.19.15.36.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 15:36:37 -0700 (PDT)
From:   Denis Kenzior <denkenz@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 3/3] nl80211: Include wiphy address setup in NEW_WIPHY
Date:   Wed, 19 Jun 2019 17:36:06 -0500
Message-Id: <20190619223606.4575-3-denkenz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190619223606.4575-1-denkenz@gmail.com>
References: <20190619223606.4575-1-denkenz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Include wiphy address setup in wiphy dumps and new wiphy events.  The
wiphy permanent address is exposed as ATTR_MAC.  If addr_mask is setup,
then it is included as ATTR_MAC_MASK attribute.  If multiple addresses
are available, then their are exposed in a nested ATTR_MAC_ADDRS array.

This information is already exposed via sysfs, but it makes sense to
include it in the wiphy dump as well.

Signed-off-by: Denis Kenzior <denkenz@gmail.com>
---
 net/wireless/nl80211.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 26bab9560c0f..65f3d47d9b63 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1852,6 +1852,31 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 
 	switch (state->split_start) {
 	case 0:
+		if (nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN,
+			    rdev->wiphy.perm_addr))
+			goto nla_put_failure;
+
+		if (!is_zero_ether_addr(rdev->wiphy.addr_mask) &&
+		    nla_put(msg, NL80211_ATTR_MAC_MASK, ETH_ALEN,
+			    rdev->wiphy.addr_mask))
+			goto nla_put_failure;
+
+		if (rdev->wiphy.n_addresses > 1) {
+			void *attr;
+
+			attr = nla_nest_start_noflag(msg,
+						     NL80211_ATTR_MAC_ADDRS);
+			if (!attr)
+				goto nla_put_failure;
+
+			for (i = 0; i < rdev->wiphy.n_addresses; i++)
+				if (nla_put(msg, i + 1, ETH_ALEN,
+					    rdev->wiphy.addresses[i].addr))
+					goto nla_put_failure;
+
+			nla_nest_end(msg, attr);
+		}
+
 		if (nla_put_u8(msg, NL80211_ATTR_WIPHY_RETRY_SHORT,
 			       rdev->wiphy.retry_short) ||
 		    nla_put_u8(msg, NL80211_ATTR_WIPHY_RETRY_LONG,
-- 
2.21.0

