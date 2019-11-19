Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA00F102EF8
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2019 23:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfKSWSM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Nov 2019 17:18:12 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41209 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfKSWSL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Nov 2019 17:18:11 -0500
Received: by mail-pl1-f195.google.com with SMTP id d29so12699562plj.8
        for <linux-wireless@vger.kernel.org>; Tue, 19 Nov 2019 14:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LYg5FRyz7JIRf+v5o+g2YYr06+KYWpjemHmm7CPNku8=;
        b=Mberv/d0nJHD8mTHN89k85m8ysWRhXI3eiBM3u77lcOeFHhu1PXUEnIdGHjbXvms0S
         MVLj6V39zpYlOLr5YfnvTc1HCJxYmanhAO6hQ8oft/8IrKPfkhZf/Q5V12kJYQ4KeryU
         qIybtOhBYaKS32qf15TyaZRLxStWEqEo6mlZs0Dwmklm5Z0lIZdkQ7SeOCxbanjScUbY
         sJOYvmintz6LTnicmyGTbIEafLgOElWJMASRvmjeEyEj2OeexzYZg7/EukoWE5t9NC1q
         9QLtsYqKR6Wv2G8S6craTTssHWmrspI98Cw7RmXPvcjVCcIMojazb1wWuC8WUH135EJ4
         e0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LYg5FRyz7JIRf+v5o+g2YYr06+KYWpjemHmm7CPNku8=;
        b=CnB/PWtbEkYPvmVJczZtwk0uJpgYQwq0qVMHxK7KQRyzPUppfT9w11D8e143UCoawN
         m8xu23jHP6RiThcMmFtXXDd/DOLLZWpwEocjROe1ihsBKrsJbgUlphGRj1aBit1UAHzE
         X9wnFi1Uo5opJu4vdQi+SRhWUcIdDEmTGynCKSCbynQARr+QK72AQnmtfhugEKUjwbX7
         SYGAJQ0bYv52Dr2nU8rMGeZIo9Y4oHeXqfbIsNfxM+QyyDvxI5jT/S5CHpnd4XPSFWBp
         592ne8NJOH+zV6OGxhSMh6D4Ezd+Ukn9RZvaCfLmdu+qr6V37L3WNpAhAAhJOWWOQx6z
         gDnA==
X-Gm-Message-State: APjAAAUfbmZEmk6+BKT598CHuvr+zYtKWKDoj1KrqvVzXujfzXRm5Oz0
        R2/yXBcyq37TFtr2VTYAYboXklYh
X-Google-Smtp-Source: APXvYqwsPn/tgag3ODn37pBDvlq6YctTdb6tVCyJhuUb0FHaQp8ud7fwQB13qJw+pe7pjuy/bFURHA==
X-Received: by 2002:a17:902:be16:: with SMTP id r22mr18654537pls.2.1574201890697;
        Tue, 19 Nov 2019 14:18:10 -0800 (PST)
Received: from jprestwo-test.jf.intel.com ([134.134.139.76])
        by smtp.gmail.com with ESMTPSA id p16sm4712016pjp.31.2019.11.19.14.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 14:18:10 -0800 (PST)
From:   James Prestwood <prestwoj@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] mac80211: set start_time_tsf/tsf_bssid for sw scans
Date:   Tue, 19 Nov 2019 14:15:09 -0800
Message-Id: <20191119221509.11370-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

These values are already tracked so for the software scan path
we can set these into scan_info so NL80211 reports it in
TRIGGER_SCAN.

This patch also sets NL80211_EXT_FEATURE_SCAN_START_TIME in mac80211
if hw scanning is not available since driver support is not required.

Signed-off-by: James Prestwood <prestwoj@gmail.com>
---
 net/mac80211/main.c | 2 ++
 net/mac80211/scan.c | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 4c2702f128f3..ccbad5499e40 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -587,6 +587,8 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 				      NL80211_EXT_FEATURE_SCAN_RANDOM_SN);
 		wiphy_ext_feature_set(wiphy,
 				      NL80211_EXT_FEATURE_SCAN_MIN_PREQ_CONTENT);
+		wiphy_ext_feature_set(wiphy,
+				      NL80211_EXT_FEATURE_SCAN_START_TIME);
 	}
 
 	if (!ops->set_key)
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index adf94ba1ed77..2559ae76b97a 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -700,6 +700,12 @@ static int __ieee80211_start_scan(struct ieee80211_sub_if_data *sdata,
 	else
 		memcpy(local->scan_addr, sdata->vif.addr, ETH_ALEN);
 
+	if (!hw_scan && sdata->vif.bss_conf.assoc) {
+		req->info.scan_start_tsf = req->scan_start;
+		ether_addr_copy(local->scan_info.tsf_bssid,
+				sdata->vif.bss_conf.bssid);
+	}
+
 	if (hw_scan) {
 		__set_bit(SCAN_HW_SCANNING, &local->scanning);
 	} else if ((req->n_channels == 1) &&
-- 
2.17.1

