Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC9CD24CF14
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Aug 2020 09:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbgHUHVj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Aug 2020 03:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbgHUHRg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Aug 2020 03:17:36 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A5FC061364
        for <linux-wireless@vger.kernel.org>; Fri, 21 Aug 2020 00:17:10 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 9so814483wmj.5
        for <linux-wireless@vger.kernel.org>; Fri, 21 Aug 2020 00:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R1IXIaJwBVwWNcurZZnrk/N/PocscpFlNi1T2hgjOyE=;
        b=lFDRLu/zcyf4hbmckt7lqVi6V3P0yLBvPW+LRjvyXB3Ko0P2bH6UYA5+veGuOE/tgN
         lIyuTYTUuTwIEvFv+qtX/eTLAioT4CNre54eXgrh13hckcWrJSjVJeBtK6OdMLtCbhgc
         Hq+S3wgc0FAN94y6W+z8bFEFdAhtc70B+3+lOSD3JyWJ0jjq6jTTbLJzRPDkhqxEvHiC
         6JWbPGefBcniOGWMCcZN0Xwg0M8jRBRFqakFrmQe1RS14P72SqqOP8N5mfCWIbzztYAf
         gLEPk2DpnbH8caK1gNSC7Hj4Ex9XjLxZRGVaI7AUf1u5mrWq/lBx1kkVhAVkG+ERS2ON
         DyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R1IXIaJwBVwWNcurZZnrk/N/PocscpFlNi1T2hgjOyE=;
        b=oryhDW1Q4j9TUDS8jlgqkQgzzIwia//fK3gp6ozwnS+UIzuvkXExI2uUiVH16HLdmu
         fQEBpHoK/sk3V/sD2Fpt9q4tvuISh4Z0x9yOq8VbkD93xCNcCY6/reoOMgA4eVkzxXJ/
         MupAkir4YCHzDXa1cvZMqKvJDbLBPD/WK+wlh1r6/cwCJKVko9BNs5DsTOxMjMe4UQuh
         FhaTLBs0RpC4mmiKfixKOncRsRdPghpj4xaxc6ON4wJTEoPIfscpxjH9plZFO5pNlgDF
         Ca5nOGTQ6yI18Jf2VDcttRbXOAqRmeyWmBTRiWCgKOjp0EqSaczNOQuIOxtEXT1zntRO
         V+4w==
X-Gm-Message-State: AOAM531WW5Lsy46Gf426seMAStWFolsoH73fTFbd8VOwPIGN5xB1BNwe
        wVcqxGp4dpk2hQ50HWdLsEu7RA==
X-Google-Smtp-Source: ABdhPJzc1nH9oB//UN5dXOr4zo/2EzEx9absn1q4olNZEN+A+7zl3CEgptWmTPAbHiwqfGU7ghvzjw==
X-Received: by 2002:a7b:c219:: with SMTP id x25mr2293147wmi.101.1597994228439;
        Fri, 21 Aug 2020 00:17:08 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id y24sm2667957wmi.17.2020.08.21.00.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 00:17:07 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        brcm80211-dev-list.pdl@broadcom.com, brcm80211-dev-list@cypress.com
Subject: [PATCH 16/32] wireless: brcm80211: btcoex: Update 'brcmf_btcoex_state' and demote others
Date:   Fri, 21 Aug 2020 08:16:28 +0100
Message-Id: <20200821071644.109970-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821071644.109970-1-lee.jones@linaro.org>
References: <20200821071644.109970-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The function headers are either very weakly documented or not at all.

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c:94: warning: Function parameter or member 'reg50' not described in 'brcmf_btcoex_info'
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c:94: warning: Function parameter or member 'saved_regs_part2' not described in 'brcmf_btcoex_info'
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c:233: warning: Function parameter or member 'btci' not described in 'btcmf_btcoex_save_part1'
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c:253: warning: Function parameter or member 'btci' not described in 'brcmf_btcoex_restore_part1'
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c:273: warning: Function parameter or member 't' not described in 'brcmf_btcoex_timerfunc'
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c:453: warning: Function parameter or member 'vif' not described in 'brcmf_btcoex_set_mode'
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c:453: warning: Function parameter or member 'duration' not described in 'brcmf_btcoex_set_mode'
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c:453: warning: Excess function parameter 'cfg' description in 'brcmf_btcoex_set_mode'

Cc: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Franky Lin <franky.lin@broadcom.com>
Cc: Hante Meuleman <hante.meuleman@broadcom.com>
Cc: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Cc: Wright Feng <wright.feng@cypress.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: brcm80211-dev-list.pdl@broadcom.com
Cc: brcm80211-dev-list@cypress.com
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../wireless/broadcom/brcm80211/brcmfmac/btcoex.c    | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c
index ec2bec0999d1b..f9f18ff451ea7 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c
@@ -65,11 +65,12 @@ enum brcmf_btcoex_state {
  * @reg68: saved value of btc_params 68
  * @saved_regs_part1: flag indicating regs 66,41,68
  *	have been saved
+ * @reg50: saved value of btc_params 50
  * @reg51: saved value of btc_params 51
  * @reg64: saved value of btc_params 64
  * @reg65: saved value of btc_params 65
  * @reg71: saved value of btc_params 71
- * @saved_regs_part1: flag indicating regs 50,51,64,65,71
+ * @saved_regs_part2: flag indicating regs 50,51,64,65,71
  *	have been saved
  */
 struct brcmf_btcoex_info {
@@ -226,7 +227,7 @@ static bool brcmf_btcoex_is_sco_active(struct brcmf_if *ifp)
 	return res;
 }
 
-/**
+/*
  * btcmf_btcoex_save_part1() - save first step parameters.
  */
 static void btcmf_btcoex_save_part1(struct brcmf_btcoex_info *btci)
@@ -246,7 +247,7 @@ static void btcmf_btcoex_save_part1(struct brcmf_btcoex_info *btci)
 	}
 }
 
-/**
+/*
  * brcmf_btcoex_restore_part1() - restore first step parameters.
  */
 static void brcmf_btcoex_restore_part1(struct brcmf_btcoex_info *btci)
@@ -266,7 +267,7 @@ static void brcmf_btcoex_restore_part1(struct brcmf_btcoex_info *btci)
 	}
 }
 
-/**
+/*
  * brcmf_btcoex_timerfunc() - BT coex timer callback
  */
 static void brcmf_btcoex_timerfunc(struct timer_list *t)
@@ -441,9 +442,8 @@ static void brcmf_btcoex_dhcp_end(struct brcmf_btcoex_info *btci)
 	}
 }
 
-/**
+/*
  * brcmf_btcoex_set_mode - set BT coex mode
- * @cfg: driver private cfg80211 data
  * @mode: Wifi-Bluetooth coexistence mode
  *
  * return: 0 on success
-- 
2.25.1

