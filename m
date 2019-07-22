Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B63A6FEC1
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jul 2019 13:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbfGVLdX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jul 2019 07:33:23 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46383 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728823AbfGVLdW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jul 2019 07:33:22 -0400
Received: by mail-lj1-f196.google.com with SMTP id v24so37301657ljg.13
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jul 2019 04:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N1UMEskMWgDwWIPBIZqRQp7UCGQ+/1yqMEhKr6tJRDg=;
        b=mE9W9C2H7td8C2H+77Nv03z9hAIlOip1PrjPuhJcAlHrKeMr8hrV/PlNI8/uWSzwa9
         BwrXTTlXKR90M6OOMmdbpeq+6XiJLT3f449VT6a+8MlssSJ5zGmKfJGk2MzYbWcFPxdv
         Fl8WfriDQSEl7yzw2AXFrE86SSk2k+7CNVCX6gHsYc/awoooKCGtnZahMX2K0Me9eBMp
         0u85C15WIFsWFZEgtYaIwTS6bYtXVkcW++eI1YBPDXL3Q7/ldOZKblZiSTK7vnnEZnCL
         vPoAQUJI1sOt821ZP0Qrrh+QUANMnaTaTfRzZcml17b4BOkPhsr9PDdSiiVHwatm2VHh
         xwig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N1UMEskMWgDwWIPBIZqRQp7UCGQ+/1yqMEhKr6tJRDg=;
        b=UGTO8TE2olYuWWxtThbH9UpNl1PffteYhuZDCMFe6jjSXg4cHHfaxwk/4I9Kviya1x
         GrfOgm1807uYpJz5K49qWeSRChZebJiiQm/QOgJMGhminVYZ4yALeOByqml5L/Q4k1zF
         bYrRre4739kaT/uF+3i1smS92kNsRp8anSUkTX6radyEIIsddre3SGSRwYoFY7ep9h3c
         dyE3FVyeKruttgoA6C2XV76lbSd6vNxpQgYNi8IWtJ9v4ViLOtASymyEFCP+1RJD+9TS
         aJAaBgFuxYfVcTVjJhgi1LCxJbjtYCSaoijb2v9SgioswZ1+n162Z1+C4nobLJZI60R4
         G9Mw==
X-Gm-Message-State: APjAAAXRntDfnVbRLcw/PfEFLLi9iQZphL9kbIY4Xn2iNvLOfoHP1Psf
        4kPteJED5z7oSrhfsoS1q08=
X-Google-Smtp-Source: APXvYqzi7UmCSfCefMkMGvLeR3TXEWK3O+Hgw49SSbfEXwWheveF2ZuhyKUxXq1FETKk9cHF+DgGyg==
X-Received: by 2002:a2e:8602:: with SMTP id a2mr34340627lji.206.1563795200855;
        Mon, 22 Jul 2019 04:33:20 -0700 (PDT)
Received: from localhost.localdomain (109-252-54-73.nat.spd-mgts.ru. [109.252.54.73])
        by smtp.gmail.com with ESMTPSA id u18sm5940336lfe.65.2019.07.22.04.33.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 04:33:19 -0700 (PDT)
From:   Denis Kenzior <denkenz@gmail.com>
To:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Cc:     Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v4 3/3] nl80211: Include wiphy address setup in NEW_WIPHY
Date:   Mon, 22 Jul 2019 06:33:12 -0500
Message-Id: <20190722113312.14031-3-denkenz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190722113312.14031-1-denkenz@gmail.com>
References: <20190722113312.14031-1-denkenz@gmail.com>
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

 Changes in v4:
  -  None

 Changes in v3:
  -  None

 Changes in v2:
  -  Move from case 0 to 9
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index a075d86a52f6..3fc4a9006155 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2172,6 +2172,31 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 			    rdev->wiphy.vht_capa_mod_mask))
 			goto nla_put_failure;
 
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
 		state->split_start++;
 		break;
 	case 10:
-- 
2.21.0

