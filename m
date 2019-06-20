Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 790D64DD34
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2019 00:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfFTWH6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Jun 2019 18:07:58 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44240 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfFTWH5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Jun 2019 18:07:57 -0400
Received: by mail-io1-f67.google.com with SMTP id s7so744936iob.11
        for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2019 15:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pTzrIKlmMz0JAf7xTm4NDSAUGunPnC3ZOeRthyVaNQ4=;
        b=paK8AO4jT5U2wXKktiTahw2Ok5nSVYpw7K8Pp/ey9he45SxA7uTVxjrAKiHG9awYGZ
         voEP3Hov8YJ4UztdKpW4/5P4zveizSW6xrx9ZcGKFRe/gbQ//pm+KjC+I/PJ2imOaS/q
         /HnHRZFPIkR67yhT6ZfwEjx6in/E3G+65wSOLc4DvgVlNQiIIilh+sxGvtqpLMxqt9v1
         1Jb8flVK74PjsWFHnWIts4a5/NuPvW+D4+cU2bScOHhyiv5Qr8IHm29HdLXd8/xyYch1
         Sm7tUedPmOl1BIfscm+mBGKemw9VX3ns+Sg7RjUxCcwu5ea3OMt0m3TBaULcgx2sf860
         Bmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pTzrIKlmMz0JAf7xTm4NDSAUGunPnC3ZOeRthyVaNQ4=;
        b=uQeeu/+TRvU60RAXWNdUSA/1XBmrsg6jLDtycxd5ovvQ5d0Qjiv03xzQozEIwixIwL
         v7VfyM9goLo3Cls5ZTNSoRj9cM6frO65UGc5z+BlJUFEzykb9EkcFXeaMrBeJTF4tLOM
         QZUQZ6nlIzT/ZwRdVmfOko59Zn7BxakeOdMQsTq1B9wxQdDv+e+QeG3E/RMpyx7zKMLR
         m0AOLpzmPJTDrYsmTNFT+11f0LmEHRD9CRMc+3xE0IFmVUfk4ooRV9vCHF72/tE2/Gnq
         ioL0DeTRl9xc6rWMM7R1WucU7CbmYzuTKj1IICo06JRoSQxAJ+QHW9MFUfXL8xatVRsI
         Z24A==
X-Gm-Message-State: APjAAAVY8xL1RqZEw8nSD1pTlJcXfvZLcWHGybxbogiaMkp+463oA8gi
        HYg7BR8TCadxHpkuupa8Crw=
X-Google-Smtp-Source: APXvYqye1qAsiJvyYvC+piSMk23WjeNyMIJ5tz2CHhF/6VDW5B7dLb+9H2uC0Q4wt2iS9pbiQJkGQw==
X-Received: by 2002:a02:7b27:: with SMTP id q39mr18858171jac.0.1561068476231;
        Thu, 20 Jun 2019 15:07:56 -0700 (PDT)
Received: from new-host-2.home.home ([2605:a601:808:1001:37ba:4f0a:192f:f945])
        by smtp.gmail.com with ESMTPSA id e84sm1691921iof.39.2019.06.20.15.07.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 15:07:55 -0700 (PDT)
From:   Denis Kenzior <denkenz@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 3/3] nl80211: Include wiphy address setup in NEW_WIPHY
Date:   Thu, 20 Jun 2019 17:07:49 -0500
Message-Id: <20190620220749.10071-3-denkenz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190620220749.10071-1-denkenz@gmail.com>
References: <20190620220749.10071-1-denkenz@gmail.com>
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

 Changes in v2:
  - Move from case 0 to 9

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 26bab9560c0f..f4b3e6f1dfbf 100644
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

