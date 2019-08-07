Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1AF855EB
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2019 00:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387849AbfHGWj3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Aug 2019 18:39:29 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:49424 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727213AbfHGWj3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Aug 2019 18:39:29 -0400
Received: from mr6.cc.vt.edu (mr6.cc.ipv6.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x77MdRQ9010528
        for <linux-wireless@vger.kernel.org>; Wed, 7 Aug 2019 18:39:27 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x77MdMhb021171
        for <linux-wireless@vger.kernel.org>; Wed, 7 Aug 2019 18:39:27 -0400
Received: by mail-qt1-f199.google.com with SMTP id c19so17735738qtp.10
        for <linux-wireless@vger.kernel.org>; Wed, 07 Aug 2019 15:39:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=r0uwyFJeFvH4bAs10mxKtLGquaNY41+jLpUXPC0EZek=;
        b=AtYTTn28xTlTN5Cin4AFuxC/lqg5imTa9TLUVZfEuaIcPx0mFreZ1ECNvD+QSGZuKb
         gtWNfSZ2fZLl8nq9K8CwZXgoX72LxURLBzKDzFjTzaFI7FoJFWVwvpF4G49OnAXRYXBj
         +OV99mI2mxXxSU7PHLsQyqqKn+CfrsvHfcY5u7YWINmfFrR1koN7fUFDe2fZ8S8GPpdS
         lTYYF5/iX/2zAoBMRmXcmavgb9WIrx1JSbSVqJo3cutCKAuT4ILA3kgw36D7K8SCIas5
         59OblhNNtxui53CCnUdpM0B8309ei8aDhr9SisQ7YCZUJcNIp6OR8bHjkyz2dxKcrYAG
         S7mw==
X-Gm-Message-State: APjAAAVcFpugYo8GR3/bYLowdM3C02Tw7Sy/63SncC9Z9P5Ho4LDMeZ+
        FlQC/qla6rs5LYUrdPIkMQXe4zkO5A4rQAEQrRzgEuF7EAJ+ZItMar3h/s4o0zXMbupwEGetAeS
        WTEkHK+YLK1ElgJ3MhTzn8JF7I03WRMsRK6kPbg==
X-Received: by 2002:ac8:38a8:: with SMTP id f37mr10506215qtc.150.1565217562212;
        Wed, 07 Aug 2019 15:39:22 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyq2M4kYBk/DP7a4+BlSJvKHDCJm1Prg2gLCqkUE118sy7EEDEjeDyH6Ho3jOyIRsTfF2KH2g==
X-Received: by 2002:ac8:38a8:: with SMTP id f37mr10506192qtc.150.1565217561898;
        Wed, 07 Aug 2019 15:39:21 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::359])
        by smtp.gmail.com with ESMTPSA id w24sm54135617qtb.35.2019.08.07.15.39.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 15:39:20 -0700 (PDT)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>
cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Fix non-kerneldoc comment in realtek/rtlwifi/usb.c
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Wed, 07 Aug 2019 18:39:20 -0400
Message-ID: <5924.1565217560@turing-police>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix spurious warning message when building with W=1:

  CC [M]  drivers/net/wireless/realtek/rtlwifi/usb.o
drivers/net/wireless/realtek/rtlwifi/usb.c:243: warning: Cannot understand  * on line 243 - I thought it was a doc line
drivers/net/wireless/realtek/rtlwifi/usb.c:760: warning: Cannot understand  * on line 760 - I thought it was a doc line
drivers/net/wireless/realtek/rtlwifi/usb.c:790: warning: Cannot understand  * on line 790 - I thought it was a doc line

Change the comment so gcc doesn't think it's a kerneldoc comment block

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c b/drivers/net/wireless/realtek/rtlwifi/usb.c
index e24fda5e9087..9478cc0d4f8b 100644
--- a/drivers/net/wireless/realtek/rtlwifi/usb.c
+++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
@@ -239,7 +239,7 @@ static void _rtl_usb_io_handler_release(struct ieee80211_hw *hw)
 	mutex_destroy(&rtlpriv->io.bb_mutex);
 }
 
-/**
+/*
  *
  *	Default aggregation handler. Do nothing and just return the oldest skb.
  */
@@ -756,7 +756,7 @@ static int rtl_usb_start(struct ieee80211_hw *hw)
 	return err;
 }
 
-/**
+/*
  *
  *
  */
@@ -786,7 +786,7 @@ static void rtl_usb_cleanup(struct ieee80211_hw *hw)
 	usb_kill_anchored_urbs(&rtlusb->tx_submitted);
 }
 
-/**
+/*
  *
  * We may add some struct into struct rtl_usb later. Do deinit here.
  *

