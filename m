Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48186857CD
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2019 03:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389713AbfHHBwH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Aug 2019 21:52:07 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:49588 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389560AbfHHBwH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Aug 2019 21:52:07 -0400
Received: from mr6.cc.vt.edu (mr6.cc.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x781q5oR015324
        for <linux-wireless@vger.kernel.org>; Wed, 7 Aug 2019 21:52:05 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x781q01e022413
        for <linux-wireless@vger.kernel.org>; Wed, 7 Aug 2019 21:52:05 -0400
Received: by mail-qk1-f199.google.com with SMTP id t124so81188899qkh.3
        for <linux-wireless@vger.kernel.org>; Wed, 07 Aug 2019 18:52:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=IVOB0NY2JGj/kstTGc6wLued6V3alD1RmAyhwYH10so=;
        b=bQsxed8OEEcFlHryy2YQItAo0HPsuQGDN5+z4PMtU9NvkJMXMUYBPkPoNyS1v0Prpg
         C8HKJyVzYxxVX9wP84e9+vSbFBZlbwGFUcndDS+T+KSoP3P8qlsoEuddBxrwq0kgtYXR
         l0XES0IBAlriKBrZuWECxVL3jZMHSHpEbNHLeFwLNOves7Gj757MAy2xg0nAHTCQEzne
         50mY83Mj4xdWos1ys7j0GGTy/8GHvcNURYP7CIyKBXX0KKjggbFPc2nAP7zjFvv/QNiy
         jRPtCOlP1dKXvijGrO1pFEbUOxsoIkAhxddRatAnuDSQ8ijX/sBtolAbHtshk52AVuC6
         5c7w==
X-Gm-Message-State: APjAAAXt4Zyk2rUVOtGAFe7MhM0xGptdVgh5EG/+5VqZ1Drejt4XFJG7
        szt/1bFqJoswbYlTdNnTig6oXP3tKHViHfk0O5sgdM2MHJlkVbELMUYofD/K0zY3LzSzmuyxzyq
        Ug1BOhhMh/13cMYlx67dblwIDaz1tehYn0qTUBw==
X-Received: by 2002:ac8:45d2:: with SMTP id e18mr10979186qto.258.1565229120429;
        Wed, 07 Aug 2019 18:52:00 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwsFTfPXmDA5/PiMsVC9GvHUAyCGr/895p2INC7GFhiSvFjcwVR2PUfzyinAlZa29Z3TikFcw==
X-Received: by 2002:ac8:45d2:: with SMTP id e18mr10979177qto.258.1565229120197;
        Wed, 07 Aug 2019 18:52:00 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::359])
        by smtp.gmail.com with ESMTPSA id q29sm2965320qtf.74.2019.08.07.18.51.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 18:51:59 -0700 (PDT)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] Fix non-kerneldoc comment in realtek/rtlwifi/usb.c
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Wed, 07 Aug 2019 21:51:58 -0400
Message-ID: <34195.1565229118@turing-police>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix spurious warning message when building with W=1:

  CC [M]  drivers/net/wireless/realtek/rtlwifi/usb.o
drivers/net/wireless/realtek/rtlwifi/usb.c:243: warning: Cannot understand  * on line 243 - I thought it was a doc line
drivers/net/wireless/realtek/rtlwifi/usb.c:760: warning: Cannot understand  * on line 760 - I thought it was a doc line
drivers/net/wireless/realtek/rtlwifi/usb.c:790: warning: Cannot understand  * on line 790 - I thought it was a doc line

Clean up the comment format.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

---
Changes since v1:  Larry Finger pointed out the patch wasn't checkpatch-clean.

diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c b/drivers/net/wireless/realtek/rtlwifi/usb.c
index 34d68dbf4b4c..4b59f3b46b28 100644
--- a/drivers/net/wireless/realtek/rtlwifi/usb.c
+++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
@@ -239,10 +239,7 @@ static void _rtl_usb_io_handler_release(struct ieee80211_hw *hw)
 	mutex_destroy(&rtlpriv->io.bb_mutex);
 }
 
-/**
- *
- *	Default aggregation handler. Do nothing and just return the oldest skb.
- */
+/*	Default aggregation handler. Do nothing and just return the oldest skb.  */
 static struct sk_buff *_none_usb_tx_aggregate_hdl(struct ieee80211_hw *hw,
 						  struct sk_buff_head *list)
 {
@@ -756,11 +753,6 @@ static int rtl_usb_start(struct ieee80211_hw *hw)
 	return err;
 }
 
-/**
- *
- *
- */
-
 /*=======================  tx =========================================*/
 static void rtl_usb_cleanup(struct ieee80211_hw *hw)
 {
@@ -786,11 +778,7 @@ static void rtl_usb_cleanup(struct ieee80211_hw *hw)
 	usb_kill_anchored_urbs(&rtlusb->tx_submitted);
 }
 
-/**
- *
- * We may add some struct into struct rtl_usb later. Do deinit here.
- *
- */
+/* We may add some struct into struct rtl_usb later. Do deinit here.  */
 static void rtl_usb_deinit(struct ieee80211_hw *hw)
 {
 	rtl_usb_cleanup(hw);

