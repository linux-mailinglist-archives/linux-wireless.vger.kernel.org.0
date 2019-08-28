Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E90BB9F820
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2019 04:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbfH1CIY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Aug 2019 22:08:24 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41425 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfH1CIY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Aug 2019 22:08:24 -0400
Received: by mail-pg1-f195.google.com with SMTP id x15so498545pgg.8
        for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2019 19:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zF/rdCcsl+Dpf6pR2o3pkaHSiAFxtHTEr8wwdACI24s=;
        b=IA7BwRJCgc0gGOw5C7lZohfbL4xQenMqPwKog/a6322QW1ZCJo9+YA44hqHGeXCCET
         NzgcdXikIEmDh9azkSiFIxncYWnKwJsXdUBhCP5nDp2GciRXS2NQ65JtbqagrheD4lVf
         +Pb00xgDSgKWQYTcqwSA2yYT9narnQxKODABGmtA6gwCWCG+SvqcZk1ekpnyXQocS6vh
         L4PoCWF3BnZkp235hrtOyzso68sDkVNJz6ZDJG47SIGi//SqblL8+W5L0VdodxWNIeOu
         V0anGG8f/Doy0MOpkTorfiducAsLMgfQi1lDZvmLLVd/YWR2IdlSkGuUlYYSPRh3iRQj
         YnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zF/rdCcsl+Dpf6pR2o3pkaHSiAFxtHTEr8wwdACI24s=;
        b=ceinhwS780P1iDieuukVIn2k6b1mW5L9RUW5Cf1wgXUoym0eeHIjHVxJDyte535qY3
         CmHO4Q8viRG4ycIifiJTtKzn7mp0QMeWcG7RpgoAXfZb1XBaj3FXDJjBXyNqvfB23VVm
         Zb+siWZHFloiDp+3ZXmTCt24f0/gTWglkCVEa3ZfuE+YCjsiIvct8Srqi+lNeoam6Le7
         w3SlkLkHqr9G3GSN1Rt9Yf0hCymRFlkBbZvnVSLdOTveygH1WdYVD2huLvriEbKL8i6k
         SMCb8fXq8mXURblOh+3S7/gmLpaBK7zUi3JpGLnVo5jEH8uIhhxLrJXjoHC9eXTHpO+2
         MpOQ==
X-Gm-Message-State: APjAAAXQVDCD0oVuK0PpIHqp2Jm0L7G6KsvCQ6CgnO4uaNG9QmRxWN+8
        M58+vc7TzkG1sr6shISyFwdcfGBkfjM=
X-Google-Smtp-Source: APXvYqyECYmkfkZ/6i0IjVBxhjaFZfVQ8xU9tke4CVSodxqtntgjXHLzr6BDXwVULEb6EBySirWb5w==
X-Received: by 2002:a62:cec4:: with SMTP id y187mr1893773pfg.84.1566958103164;
        Tue, 27 Aug 2019 19:08:23 -0700 (PDT)
Received: from localhost ([67.218.142.97])
        by smtp.gmail.com with ESMTPSA id m34sm467149pje.5.2019.08.27.19.08.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Aug 2019 19:08:22 -0700 (PDT)
From:   huangwenabc@gmail.com
To:     linux-wireless@vger.kernel.org
Cc:     amitkarwar@gmail.com, nishants@marvell.com, gbhat@marvell.com,
        huxinming820@gmail.com, solar@openwall.com, greg@kroah.com,
        kvalo@codeaurora.org, sashal@kernel.org, mrehak@redhat.com
Subject: [PATCH] mwifiex: Fix three heap overflow at parsing element in cfg80211_ap_settings
Date:   Wed, 28 Aug 2019 10:07:51 +0800
Message-Id: <20190828020751.13625-1-huangwenabc@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Wen Huang <huangwenabc@gmail.com>

mwifiex_update_vs_ie(),mwifiex_set_uap_rates() and 
mwifiex_set_wmm_params() call memcpy() without checking
the destination size.Since the source is given from 
user-space, this may trigger a heap buffer overflow.

Fix them by putting the length check before performing memcpy().

This fix addresses CVE-2019-14814,CVE-2019-14815,CVE-2019-14816.

Signed-off-by: Wen Huang <huangwenabc@gmail.com>
---
 drivers/net/wireless/marvell/mwifiex/ie.c      | 3 +++
 drivers/net/wireless/marvell/mwifiex/uap_cmd.c | 9 ++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/ie.c b/drivers/net/wireless/marvell/mwifiex/ie.c
index 653d347a9..580387f9f 100644
--- a/drivers/net/wireless/marvell/mwifiex/ie.c
+++ b/drivers/net/wireless/marvell/mwifiex/ie.c
@@ -241,6 +241,9 @@ static int mwifiex_update_vs_ie(const u8 *ies, int ies_len,
 		}
 
 		vs_ie = (struct ieee_types_header *)vendor_ie;
+		if (le16_to_cpu(ie->ie_length) + vs_ie->len + 2 >
+			IEEE_MAX_IE_SIZE)
+			return -EINVAL;
 		memcpy(ie->ie_buffer + le16_to_cpu(ie->ie_length),
 		       vs_ie, vs_ie->len + 2);
 		le16_unaligned_add_cpu(&ie->ie_length, vs_ie->len + 2);
diff --git a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
index 18f7d9bf3..0939a8c8f 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
@@ -265,6 +265,8 @@ mwifiex_set_uap_rates(struct mwifiex_uap_bss_param *bss_cfg,
 
 	rate_ie = (void *)cfg80211_find_ie(WLAN_EID_SUPP_RATES, var_pos, len);
 	if (rate_ie) {
+		if (rate_ie->len > MWIFIEX_SUPPORTED_RATES)
+			return;
 		memcpy(bss_cfg->rates, rate_ie + 1, rate_ie->len);
 		rate_len = rate_ie->len;
 	}
@@ -272,8 +274,11 @@ mwifiex_set_uap_rates(struct mwifiex_uap_bss_param *bss_cfg,
 	rate_ie = (void *)cfg80211_find_ie(WLAN_EID_EXT_SUPP_RATES,
 					   params->beacon.tail,
 					   params->beacon.tail_len);
-	if (rate_ie)
+	if (rate_ie) {
+		if (rate_ie->len > MWIFIEX_SUPPORTED_RATES - rate_len)
+			return;
 		memcpy(bss_cfg->rates + rate_len, rate_ie + 1, rate_ie->len);
+	}
 
 	return;
 }
@@ -391,6 +396,8 @@ mwifiex_set_wmm_params(struct mwifiex_private *priv,
 					    params->beacon.tail_len);
 	if (vendor_ie) {
 		wmm_ie = vendor_ie;
+		if (*(wmm_ie + 1) > sizeof(struct mwifiex_types_wmm_info))
+			return;
 		memcpy(&bss_cfg->wmm_info, wmm_ie +
 		       sizeof(struct ieee_types_header), *(wmm_ie + 1));
 		priv->wmm_enabled = 1;
-- 
2.17.1

