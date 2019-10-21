Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2052DE587
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2019 09:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfJUHvA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Oct 2019 03:51:00 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38610 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfJUHvA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Oct 2019 03:51:00 -0400
Received: by mail-pg1-f196.google.com with SMTP id w3so7268970pgt.5
        for <linux-wireless@vger.kernel.org>; Mon, 21 Oct 2019 00:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ndycyjHMC51asjxp0WXWz+PwMCN/TtDGnMCscdEWaME=;
        b=XBkILNoGexU8Mv9dIB7BvVqljSSiyDzMOWGFmfOEV9/K23PGU8rWqMQpQl8XoF1nAm
         N+H2Xju3fKHa4qKnXQniviVw+N/VmedQHtncTTBNoMzxz+8HocHqQ0S49KSCk5uW5QwV
         Rm/Vcr4UyE8DP3CKaQ641C9Bk4ax2Qa+aqMAGB5E7hquJHVqLMwWNk1trllcE9ZzPWbj
         he/wQlaoWVxmESehw83+wMQv0YNZNumTP4vnniB6CPmRd9D53bArM7xhTSnxBczUJNnZ
         zqJlRdN1avM5cThq/qmkmiJO0iAqvE6N8fNaEMJyDOtSql+LfrgicA0YJ58jnVoYXuGo
         aNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ndycyjHMC51asjxp0WXWz+PwMCN/TtDGnMCscdEWaME=;
        b=CdKxyCpGmqM1vAf2vM33a2IZnk4AjDXdaKysb24Zyth15naau+c41cxG43fGS6t92n
         ZUGopDPlPq77x8EJPSGOHKADrnpdLxKNb7lclquLaBrlv9I4W5zhYRA6K2WcXKJ29fR6
         7J+Jt1YE+niYWbLwQTynVgBrf1pj7oZ6cIEWQ1irHcOxz5W73eM5Kag1c/2o+gOIdi7v
         rNtHZYG8KzsNlzH4SXH49lkdU/CEpOTmfTMpatQLso3sCiaMhK2vQKmPpI/omUOikEHC
         pf+2c22nK1JHWyCH/ZUefwlz50hCAC8/c1LM3rRt08eQ6DTylNoayG8QXfCNLAvVPDnK
         5e9w==
X-Gm-Message-State: APjAAAVBUPhOAxyLkW4IjBHuEq0e0MDg+nJAndyDb/2Dy3g7HKVms20W
        W7rlVoxosta9jMiH03mceQxldBVm
X-Google-Smtp-Source: APXvYqy5CP+aAUBuePxg3z2uvr/myAT+TYCK6BFrZ5nQNuJfoCg9yreM9ChnYLucoIjcaMP+EQPX7A==
X-Received: by 2002:a63:cb0f:: with SMTP id p15mr21930327pgg.81.1571644257991;
        Mon, 21 Oct 2019 00:50:57 -0700 (PDT)
Received: from gtx1600.flets-east.jp ([2409:11:53c0:1f00:1d24:bd56:d787:1e47])
        by smtp.gmail.com with ESMTPSA id b16sm19199206pfb.54.2019.10.21.00.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 00:50:57 -0700 (PDT)
From:   Masashi Honma <masashi.honma@gmail.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Masashi Honma <masashi.honma@gmail.com>
Subject: [PATCH] nl80211: Disallow setting of HT for channel 14
Date:   Mon, 21 Oct 2019 16:50:45 +0900
Message-Id: <20191021075045.2719-1-masashi.honma@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch disables setting of HT20 and more for channel 14 because
the channel is only for IEEE 802.11b.

The patch for net/wireless/util.c was unit-tested.

The patch for net/wireless/chan.c was tested with iw command.

Before this patch.
$ sudo iw dev <ifname> set channel 14 HT20
$

After this patch.
$ sudo iw dev <ifname> set channel 14 HT20
kernel reports: invalid channel definition
command failed: Invalid argument (-22)
$

Signed-off-by: Masashi Honma <masashi.honma@gmail.com>
---
 net/wireless/chan.c | 4 ++++
 net/wireless/util.c | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index e851cafd8e2f..1212deb41361 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -204,6 +204,10 @@ bool cfg80211_chandef_valid(const struct cfg80211_chan_def *chandef)
 		return false;
 	}
 
+	/* channel 14 is only for IEEE 802.11b */
+	if (chandef->center_freq1 == 2484 && chandef->width > NL80211_CHAN_WIDTH_20_NOHT)
+		return false;
+
 	if (cfg80211_chandef_is_edmg(chandef) &&
 	    !cfg80211_edmg_chandef_valid(chandef))
 		return false;
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 419eb12c1e93..063715df3950 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1559,7 +1559,8 @@ bool ieee80211_chandef_to_operating_class(struct cfg80211_chan_def *chandef,
 	}
 
 	if (freq == 2484) {
-		if (chandef->width > NL80211_CHAN_WIDTH_40)
+		/* channel 14 is only for IEEE 802.11b */
+		if (chandef->width > NL80211_CHAN_WIDTH_20_NOHT)
 			return false;
 
 		*op_class = 82; /* channel 14 */
-- 
2.17.1

