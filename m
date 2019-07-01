Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8B665BFE7
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2019 17:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbfGAPd1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Jul 2019 11:33:27 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:32954 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbfGAPd1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Jul 2019 11:33:27 -0400
Received: by mail-ot1-f68.google.com with SMTP id q20so13913410otl.0
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jul 2019 08:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f8FZT6knMgdV0MoZ1WEwvacL7fekKHkM6lBACxid55c=;
        b=s3GdXgS0SUpFnHgL45N3lyB23ewsJSbXJAOyTY/G+JFcvmti8lD6hQL5jVDWYMBwA2
         rkt4lwhiUp1PSnW6CUuvwb4qP/Ir8T1a5cTNdbJC4LEN+DnArtLcvns/AIZFWtzxLA7T
         8arOHLRsF7gMz7QsYFoHsewxl6t/vA0lTfY0SrOktPuVa9hYCAca2GNlOdxhynGk/S6x
         MQjHJK2Y4t8eOE667bOf+PuoWQF20kD/Qby9GAz/AiBG3U4odL/CJNEg2F8C19uXDKhb
         QRbiN420U0Qf7EeJNLfl3ggBjBavJHsGvQQm0ilygdbfiANWENyWgBGQOVKmX0s4mtnw
         ba0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f8FZT6knMgdV0MoZ1WEwvacL7fekKHkM6lBACxid55c=;
        b=pV2Hgukry80RLttY14XrD3s4goQvALJecXIdsWWvLXGxMLLGEeJ+LMdc2xyigoiaRA
         FPBWmAPgucqJoGDuihfw/ckadYnc/QvqFWbTjS7hROVPjHddCoKyhG9rnv49390lQAZj
         2OVaACsYOrqKsLJgQWGB+y+k4MABXjrDNmPSxSjtQiYt/vdxrCHbW+IdQapUDtHO6ZBs
         ALDZClrY9vcNW63wTlXCYFGzAKiNzZHgEqSq76Wty9hitgSVb8RiB1MDA3O31SyrUEJI
         3UhbH4BD0REpj4wGbuAmZKrUQCPkFvi2tR17wfEbjXYVbeWxdeY6EXAWa3Lz6qKDO1PX
         67Sg==
X-Gm-Message-State: APjAAAWTEJ41JipudE3Szowx7i9khWBxIfwtDSBY7ZuXXahnpgD5/6jq
        MFmLGpeNlJKmWSRjbQEu0W0ujoBZ
X-Google-Smtp-Source: APXvYqzgE5tR5KcfEutEvk3bXByUgYPUSNb1Dx441cjs5JUMK8C1Bgs1k6tLbjGqFGjws2mbh8iKdQ==
X-Received: by 2002:a9d:4d0b:: with SMTP id n11mr9154055otf.229.1561995206729;
        Mon, 01 Jul 2019 08:33:26 -0700 (PDT)
Received: from new-host-2.home (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id y4sm4136786otj.56.2019.07.01.08.33.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 08:33:26 -0700 (PDT)
From:   Denis Kenzior <denkenz@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v3 3/3] nl80211: Include wiphy address setup in NEW_WIPHY
Date:   Mon,  1 Jul 2019 10:33:17 -0500
Message-Id: <20190701153317.27170-3-denkenz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190701153317.27170-1-denkenz@gmail.com>
References: <20190701153317.27170-1-denkenz@gmail.com>
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

 Changes in v3:
  - None

 Changes in v2:
  - Move from case 0 to 9
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index ebf5eab1f9b2..fb09c2301ed8 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2166,6 +2166,31 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
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

