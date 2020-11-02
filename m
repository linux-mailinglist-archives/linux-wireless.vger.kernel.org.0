Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7694C2A2970
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Nov 2020 12:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbgKBLY1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Nov 2020 06:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbgKBLYY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Nov 2020 06:24:24 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1266FC061A47
        for <linux-wireless@vger.kernel.org>; Mon,  2 Nov 2020 03:24:23 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id c18so9018365wme.2
        for <linux-wireless@vger.kernel.org>; Mon, 02 Nov 2020 03:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A1fMIMjw6i89f8UX70P4Kw6NDXaWlqTcl97Lfk1WFz4=;
        b=uzU+59hH5565Hurqo3QSpw5jMldLf2h0/QVjPsls6qykE/ceDqX8W3w0QjvF+RNNxK
         ob6ZesURS0nG0LpVVGD+PwwYIhIHQrSUrIpP7lqfbSIo5noKVOS41mw6mSFPjdiP8fKO
         WSvbAPpu0pV97tymA9dcJBDRm4I0NbViB7JiTYZ6Q8IA+r2vOB66zBRdbnHzsu9QXQ4/
         x5Zwv0aLPwnsdrvXPv7kRMaRWinwnjWBTOuYWVX1uBCK4WYpR+maFieGrFymLLeQQEnr
         U120OvXsajcfXIoNbeUAGMe0qbTaJxVJ1L9AFDzjUY6q4SNmSyGkXmHhy8wXc5pKKT5U
         vGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A1fMIMjw6i89f8UX70P4Kw6NDXaWlqTcl97Lfk1WFz4=;
        b=NG4lYWlPobFdPO3XAkapV3qyWFNX7kmO0lj5gm+NvHEp1ySfFsiaZ7K4cAgYCrnt3D
         lczAd7xdlIzMhq1KozARY9lBcuG8q2IyhbR00DnhwtevEyatOxwNMYeDNusG0NEg2CPr
         SyS8+p+RT/aru5O8sbXOmES+pg64n0/rJ5E9QvO+ub0ujQjGPG6ZZjI/0fc14LQsEAZJ
         O58AkgSr4yfUL6LHREezCFWWs80pij32guoFdqPN2FvQ5/SA5tAGPRAk3otBfm372E+n
         tTx1ae/cUrikaw8Fcj2UFzpQNfo9q+UnEh36DVgmnO39DwzTLsjPqCk93S+j8a858Zfc
         ITEg==
X-Gm-Message-State: AOAM530GVEXst8O5mX2c427LKSyXpRhCDugbcx/JK+tBZ81Bn+K7e6Ex
        6jjkTFxdnwYYPJKnFqGB0cU8F/eewYWXEA==
X-Google-Smtp-Source: ABdhPJxOMcmp/5oX7Gq5iCjpMjclVgcK49IJ9lE6t5E9al45QFOH+Lc6yhmlA8ZPv4GomW4lGTZDIg==
X-Received: by 2002:a1c:790b:: with SMTP id l11mr16053038wme.53.1604316261773;
        Mon, 02 Nov 2020 03:24:21 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id m14sm21867354wro.43.2020.11.02.03.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:24:21 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 03/41] rtl8192cu: mac: Fix some missing/ill-documented function parameters
Date:   Mon,  2 Nov 2020 11:23:32 +0000
Message-Id: <20201102112410.1049272-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102112410.1049272-1-lee.jones@linaro.org>
References: <20201102112410.1049272-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/mac.c:124: warning: Function parameter or member 'hw' not described in 'rtl92c_llt_write'
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/mac.c:124: warning: Excess function parameter 'io' description in 'rtl92c_llt_write'
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/mac.c:155: warning: Function parameter or member 'hw' not described in 'rtl92c_init_llt_table'
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/mac.c:155: warning: Excess function parameter 'io' description in 'rtl92c_init_llt_table'

Cc: Ping-Ke Shih <pkshih@realtek.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Larry Finger <Larry.Finger@lwfinger.net>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/mac.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/mac.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/mac.c
index 2890a495a23ec..8d2c6d8d32d93 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/mac.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/mac.c
@@ -113,7 +113,7 @@ void rtl92c_read_chip_version(struct ieee80211_hw *hw)
 
 /**
  * writeLLT - LLT table write access
- * @io: io callback
+ * @hw: Pointer to the ieee80211_hw structure.
  * @address: LLT logical address.
  * @data: LLT data content
  *
@@ -145,11 +145,10 @@ bool rtl92c_llt_write(struct ieee80211_hw *hw, u32 address, u32 data)
 
 /**
  * rtl92c_init_LLT_table - Init LLT table
- * @io: io callback
- * @boundary:
+ * @hw: Pointer to the ieee80211_hw structure.
+ * @boundary: Page boundary.
  *
  * Realtek hardware access function.
- *
  */
 bool rtl92c_init_llt_table(struct ieee80211_hw *hw, u32 boundary)
 {
-- 
2.25.1

