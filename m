Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10EA7E1851
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2019 12:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391104AbfJWKyW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Oct 2019 06:54:22 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41809 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390491AbfJWKyU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Oct 2019 06:54:20 -0400
Received: by mail-pf1-f193.google.com with SMTP id q7so12689577pfh.8
        for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2019 03:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hd+GeGNy0Z1vTVXDGiFusVZRyBmc3vmXQ8fhFYfc7fA=;
        b=tmFRNZIKMjDMXXKEICvv7mTspe0FDfqvqZoumY9t/1rA17e4oNOY/I2wgnwQzLxnQJ
         apn5i0vev41KH+x/Q9urvc8pkzhZA0Jzo5WvPiEL1lTfuxso+ymm8Mcx8Sx5cUJ0gKpJ
         nh7vWBZF25gjpodwz0iYmRpCQIi3qJjW4UeOQbKlaxNcyB5QT+/FIXKnVLP9q0d8+9zM
         7btqDwTH1iNUni2NL8BRicQPyrFXlr8PkvJ8QhSFb/kpV2VcNb5nz9ucXz4e9sjk1juQ
         lJEe9RMObCcNGd5wZnb9oYbL7sXis9kmf9lZi2Tx1XVc3ZhkqnPXpt0cNNep4hUQ7nVy
         go7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hd+GeGNy0Z1vTVXDGiFusVZRyBmc3vmXQ8fhFYfc7fA=;
        b=b/iNqBv5ev+KnczPVHpAsLi+yOarzzCcKBiwO6yKtAjAfcrKNwazGe8gisgdX25qzE
         jHiRmL8GJJlMlo5g4saL8rcdHO4YtBENRLyFRlTKlVJ28DplL90WVvwgV88wJyxCRycb
         OyWQqDp9MGbnlIMbGgDzIEO7mOTzffZf5AHjUN7gC/nNXhrKGyWvukKtApE0ZDTqq7L7
         HrkBXRwU0YEUXdKXsjejUBPiBC/SdlYVuYQ90Lso4ifTkigwEUCRf4V2dH8AhKgsHdoN
         MzYnMvW74kOtX9eEq7kd5/q/T9rvkFGl3cNTp7YQUI7TOIVg6pbd0WO/p41E2ANI310r
         uw0g==
X-Gm-Message-State: APjAAAWfCCLXGg0iL++aXkhXWPC14ju34Z1cHZwL3mshYsEFH//Njshn
        gYHDS22R/JS5xSvbSyvlFgCFAA==
X-Google-Smtp-Source: APXvYqwiRnoRJ9xGk2Dz0oIYEpIv0ONeU2+JcIrkdTuPyyTF/PWbCFu+7hqOwJHVH90dDbf1AWKMaA==
X-Received: by 2002:a17:90a:3608:: with SMTP id s8mr10830077pjb.44.1571828058013;
        Wed, 23 Oct 2019 03:54:18 -0700 (PDT)
Received: from localhost.localdomain (59-127-47-126.HINET-IP.hinet.net. [59.127.47.126])
        by smtp.gmail.com with ESMTPSA id s202sm23774021pfs.24.2019.10.23.03.54.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Oct 2019 03:54:17 -0700 (PDT)
From:   Chris Chiu <chiu@endlessm.com>
To:     Jes.Sorensen@gmail.com, kvalo@codeaurora.org, davem@davemloft.net
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com
Subject: [PATCH] rtl8xxxu: fix warnings for symbol not declared.
Date:   Wed, 23 Oct 2019 18:54:07 +0800
Message-Id: <20191023105407.92131-1-chiu@endlessm.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix the following sparse warnings.
sparse: symbol 'rtl8723bu_set_coex_with_type' was not declared.
Should it be static?
sparse: symbol 'rtl8723bu_update_bt_link_info' was not declared.
Should it be static?
sparse: symbol 'rtl8723bu_handle_bt_inquiry' was not declared.
Should it be static?
sparse: symbol 'rtl8723bu_handle_bt_info' was not declared.
Should it be static?

Signed-off-by: Chris Chiu <chiu@endlessm.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index f982f91b8bb6..eac91690772b 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -5194,6 +5194,7 @@ static void rtl8xxxu_rx_urb_work(struct work_struct *work)
  * cases which Realtek doesn't provide detail for these settings. Keep
  * this aligned with vendor driver for easier maintenance.
  */
+static
 void rtl8723bu_set_coex_with_type(struct rtl8xxxu_priv *priv, u8 type)
 {
 	switch (type) {
@@ -5245,6 +5246,7 @@ void rtl8723bu_set_coex_with_type(struct rtl8xxxu_priv *priv, u8 type)
 	}
 }
 
+static
 void rtl8723bu_update_bt_link_info(struct rtl8xxxu_priv *priv, u8 bt_info)
 {
 	struct rtl8xxxu_btcoex *btcoex = &priv->bt_coex;
@@ -5311,6 +5313,7 @@ void rtl8723bu_update_bt_link_info(struct rtl8xxxu_priv *priv, u8 bt_info)
 		btcoex->bt_busy = false;
 }
 
+static
 void rtl8723bu_handle_bt_inquiry(struct rtl8xxxu_priv *priv)
 {
 	struct ieee80211_vif *vif;
@@ -5336,6 +5339,7 @@ void rtl8723bu_handle_bt_inquiry(struct rtl8xxxu_priv *priv)
 	}
 }
 
+static
 void rtl8723bu_handle_bt_info(struct rtl8xxxu_priv *priv)
 {
 	struct ieee80211_vif *vif;
-- 
2.20.1

