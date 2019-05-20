Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 976E723E60
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2019 19:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392872AbfETRYV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 May 2019 13:24:21 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41495 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392854AbfETRYV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 May 2019 13:24:21 -0400
Received: by mail-oi1-f194.google.com with SMTP id y10so10589103oia.8
        for <linux-wireless@vger.kernel.org>; Mon, 20 May 2019 10:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xSG8CSdxq4cqh0OQOfsnj60Zh1DmJH+TUVLoFaT97sI=;
        b=bU87gHKKC+MLdcVIkcdYjSAOk98oFWW0tVHRhSLpBgrXlppIoBHedJRz+jtAVOoibv
         0uidAEqQAq2cUXNFFT/GH5Nz79HUy76BMAP/sz78Z006yzRIB8gZ2nCr23JXPMDpKjCq
         9AStFqgdE94obo/GfFvd82vii0E4Zllhac6EvQqJYh6EqVtxTbpnWv9aHNrWue4qWzGU
         8m4+feBF5bUXtKCKTq0XKRK6IC4odOQKu+GHD2hGCiJ/wKtNZuEnhvpf9XS0ZB7Ul4v6
         KXQR4fcDAQ8aKDK5JJB+/ZDImh/B+cVMuexd9PRPbxHNz2RnEKRfxIcBhbHopIQgBw5f
         eMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=xSG8CSdxq4cqh0OQOfsnj60Zh1DmJH+TUVLoFaT97sI=;
        b=C3IM9lymJUJh5Hzlz2OK/wirnGdkIOYpPUTJ35sFgL8o+HlBUNp/7YJKT9PlqDhrb3
         0DbZzF0+mf64yhjnIheg2c7hFRyUNnBRcEEU6gelGj9T/ocjVo/lycuiaSkOYU24AwNU
         RZGbrxmz3gXh2NJOzgw6QIU3GU1r0zCl+uTx/dLm6uByZdNYco/XlXYOlwSAh79L7TJR
         OlzEjdxZoC9P9s/wwAN5lRAKDASTsClJSLnjjx9NwsrhNwZ1L3v4m+Xcgi3KruayR0cc
         bdDRiPnhe2aIE5nghgc8zv/SykOn6MO10by2f/RrVy7AkZ2wYLwUxAFDheRyDBXC5KYu
         f6Tw==
X-Gm-Message-State: APjAAAXF7OGwZJ48tIK6ZyONQSf8w/VoihgXRndB5jFzZx8o69uCyUXx
        z4YNx7TXbSDW6ungq7kHk0085ILm
X-Google-Smtp-Source: APXvYqy5r15BHspiRX5atLLrRLLqGed3BLVn8ZrAw+mFgGFB/0xyoxgEy1+4a6e5TqnhdB/ByPlylQ==
X-Received: by 2002:aca:d6d0:: with SMTP id n199mr171689oig.51.1558373060290;
        Mon, 20 May 2019 10:24:20 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id z190sm6556865oia.21.2019.05.20.10.24.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 10:24:19 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 0/4] rtlwifi: rtl8821ae: Convert bit manipulation macros to static inline routines
Date:   Mon, 20 May 2019 12:23:55 -0500
Message-Id: <20190520172359.9993-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This driver, as do the others in the rtlwifi family, uses a set of unique
macros to read and write the little-endian RX and TX descriptor registers.
These macros are converted to static inline routines in several steps:

1. Remove all macros that are defined, but never used.
2. Replace the unique macros with the appropriate le32p_replace_bits()
   and le32_get_gits() standard macros.
3. The names of the inline routines are converted from upper to lower case.
4. The calling routines are changed to convert the byte array of
   descriptors into an __le32 word array so that the __le32 casting
   in the inline routines can be eliminated. Some callback routines
   had to keep the byte arrays as they are dependent on definitions
   that are used by all rtlwifi drivers.

The above sequence results in multiple rewrites of some lines; however,
it made debugging the changes a lot easier.

My plan is to convert all drivers in rtlwifi. Once that is complete, most
of the remaining casts from u8 * to __le32 * will be eliminated.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>


Larry Finger (4):
  rtlwifi: rtl8821ae: Remove unused GET_XXX and SET_XXX descriptor
    macros
  rtlwifi: rtl8821ae: Replace local bit manipulation macros
  rtlwifi: rtl8821ae: Convert macros that set descriptor
  rtlwifi: rtl8821ae: Convert inline routines to little-endian words

 .../wireless/realtek/rtlwifi/rtl8821ae/dm.c   |   3 +-
 .../wireless/realtek/rtlwifi/rtl8821ae/trx.c  | 253 ++++---
 .../wireless/realtek/rtlwifi/rtl8821ae/trx.h  | 708 ++++++++++--------
 drivers/net/wireless/realtek/rtlwifi/wifi.h   |   1 +
 4 files changed, 509 insertions(+), 456 deletions(-)

-- 
2.21.0

