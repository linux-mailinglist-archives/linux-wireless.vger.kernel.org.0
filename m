Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1C1510763A
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2019 18:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfKVRJN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Nov 2019 12:09:13 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:41161 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfKVRJN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Nov 2019 12:09:13 -0500
Received: by mail-pj1-f65.google.com with SMTP id gc1so3285124pjb.8
        for <linux-wireless@vger.kernel.org>; Fri, 22 Nov 2019 09:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6+LL8qsLHJX2/gsW2qsgwafSTmgjosS9b/ig7Inn4hU=;
        b=FSB9ixAD74wEJscfeuQGF2SI89/+bdBgZ/bNswr7AjGjIE1qDolwxuck1XIs7wf8vJ
         ka0UApVgmwdjcxrPxnvm+x4l6fkhedHqYZJ6qZKQSfOJxjle97oL99guJXjmhY+4A0Sw
         vteWXcOLKt51duo8bLktBPp9SEka/J0bHJqjXFjNczlLYZI2d/yZ4SX88shYSHI31QhM
         HjEUqYY0+NiUd2pOhpxD/k1xDPa5X1B+tGJahV6rpbgjciVaz3KIwr1Q+XyTZ2X9TqPE
         bPuZG8qvGKJskVjzHT89HM7ur9/n/WostnkeG9Rxnn6RBt6f2TvnvnsRMO8eq8qzJ9IS
         SuLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6+LL8qsLHJX2/gsW2qsgwafSTmgjosS9b/ig7Inn4hU=;
        b=AOOH+2zw1KIHnRUGD70BfqExcmsNQmOxpa2jA+FTBvnmj4jWmMbVVP6Y9OFsXJpsJ6
         86DS5D0Zpu0KeVYqrmnP8fuzV/yhqWwdVo0kBY8unFSXuVBld+2WTyCbbuHY+y8oXoBr
         fbjg/xLQ5tF6MNnzv1RSFRmSAUuUpQPtST3wYhyIWtGCsEUht4yQ8Y8Md07dH4yAhAzU
         JVd7OeocXFpywnoS4Peb1FF1ks0CLClAtyv5j9yRkLrWnNZnCDipscfu6HG3DuUg2rdb
         1Vk2nuQr8Wd+tt6iDNcSMpJRbzbddqGLNzaS9dv4kjq6u2Wf9eM4lfvtFi4O34pVNJHT
         /Zsw==
X-Gm-Message-State: APjAAAUXvzk88tUBAqdkXJOokCB20JSW4/VGMhwDur4F5jkeXuejRzvn
        KiRMW6Ce+WxnHbC2OQB1M/T/R+SB
X-Google-Smtp-Source: APXvYqwSl2kAOwhVgFwviFUELZX+XBMxnyUJUe6o1+ngl6RmjTtx5dhIc81BJ21ib7LuNJOSEqYHyw==
X-Received: by 2002:a17:90a:1446:: with SMTP id j64mr20559449pja.142.1574442551843;
        Fri, 22 Nov 2019 09:09:11 -0800 (PST)
Received: from jprestwo-test.jf.intel.com ([134.134.139.76])
        by smtp.gmail.com with ESMTPSA id c2sm7834386pfn.55.2019.11.22.09.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 09:09:11 -0800 (PST)
From:   James Prestwood <prestwoj@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/2] mac80211_hwsim: enable parent TSF feature
Date:   Fri, 22 Nov 2019 09:06:11 -0800
Message-Id: <20191122170612.8123-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Support for this is already in nl80211, and some code paths in
mac80211_hwsim already set the rx_status to allow the parent TSF
value to be sent to user space.

Signed-off-by: James Prestwood <prestwoj@gmail.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 772e54f0696f..e9bc599481d4 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -2825,6 +2825,7 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 			       NL80211_FEATURE_DYNAMIC_SMPS |
 			       NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR;
 	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_VHT_IBSS);
+	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_BSS_PARENT_TSF);
 
 	hw->wiphy->interface_modes = param->iftypes;
 
-- 
2.17.1

