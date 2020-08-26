Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A52252A75
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Aug 2020 11:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbgHZJjO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Aug 2020 05:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728284AbgHZJe3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Aug 2020 05:34:29 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C57C061383
        for <linux-wireless@vger.kernel.org>; Wed, 26 Aug 2020 02:34:19 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k20so1065888wmi.5
        for <linux-wireless@vger.kernel.org>; Wed, 26 Aug 2020 02:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lOqkWcILbsAeyAfZ0GfzIi50eF5PW2PXQFze4naQS2g=;
        b=QHJKMOnZ4tO+oPpdZO1XclI2udxtKXtC1n+sqUbOkrkLwibykUsRORT51V6Hkmmgh/
         t2XgThhanyCXXUkHdhqimUKMlX98ujIdPf048s1aR3v7hgOP3/8q7x/nJ8HBBGos6wf8
         lSorCwKC8Zxsxlntp2BNMFDaeK0yCVuJD9uU7Uo7WOoeNbsJRrDgCyd5OmboxWIMY+b+
         ULLaynAuXVhaNpZirlsqEfKY/DHuk8Qzqjwm4x84UNsBiHXJPjegYxVr+KnAjZFTTFW3
         Zk8AF2IVK+2d7F/ED6AGsvg9yf18ULdammO9EEvq9dfHEq7n6Vt5AIRLCwep9X2DZRiD
         E6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lOqkWcILbsAeyAfZ0GfzIi50eF5PW2PXQFze4naQS2g=;
        b=SICqwvlPSrYDhpc3ZzcOPtmZ9w0SXPaa/VNQYdlt+beQKM6T4I4JTifCsfQh88AcI+
         S5s3Ujxhxt/ypPewIsXLg2HcAPYjvgcGWAu5re9/n7paLznrHAnfWv5QUNC+eeaQYHAy
         r/tmfDiNfB+U5GO+673nPKjqfqm0rYmFWkNmbp6o71n3Rif1WlC0jfIeP0hmlEcHaRSI
         R+urIDUo45Fw+6XJkxnHtyhCjRSeWbEbH1VGGXFaUZAKOHOeaby3g7vMeVBjJzA6CQwj
         aER4kvsoh4DbbgExKUMdDiUCI++R1kRUpntRikYhpCyeQ3QDHuUBqtoJFb8aaPxilQKp
         fGMQ==
X-Gm-Message-State: AOAM533qjHoNNsMRwaL8j/xX+cfFj4vt11hFwMFuGr2h8RUFO7P7nRFA
        f7TM0NVKkIXf1+gv/id+6PT+Ag==
X-Google-Smtp-Source: ABdhPJwqg8QiNz57jChEdqZYRe6J78RNXFsyTh7fDBKnWvE8IIP9LARAxLgVs6l6Y3kheEFiyzHjtA==
X-Received: by 2002:a1c:cc05:: with SMTP id h5mr5870886wmb.129.1598434457697;
        Wed, 26 Aug 2020 02:34:17 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id u3sm3978759wml.44.2020.08.26.02.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 02:34:17 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Daniel Drake <dsd@gentoo.org>,
        Ulrich Kunitz <kune@deine-taler.de>,
        Michael Wu <flamingice@sourmilk.net>,
        "Luis R. Rodriguez" <mcgrof@winlab.rutgers.edu>
Subject: [PATCH 10/30] wireless: zydas: zd1211rw: zd_mac: Add missing or incorrect function documentation
Date:   Wed, 26 Aug 2020 10:33:41 +0100
Message-Id: <20200826093401.1458456-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200826093401.1458456-1-lee.jones@linaro.org>
References: <20200826093401.1458456-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/zydas/zd1211rw/zd_mac.c:433: warning: Function parameter or member 'hw' not described in 'zd_mac_tx_status'
 drivers/net/wireless/zydas/zd1211rw/zd_mac.c:433: warning: Function parameter or member 'skb' not described in 'zd_mac_tx_status'
 drivers/net/wireless/zydas/zd1211rw/zd_mac.c:433: warning: Function parameter or member 'tx_status' not described in 'zd_mac_tx_status'
 drivers/net/wireless/zydas/zd1211rw/zd_mac.c:433: warning: Excess function parameter 'flags' description in 'zd_mac_tx_status'
 drivers/net/wireless/zydas/zd1211rw/zd_mac.c:487: warning: Function parameter or member 'urb' not described in 'zd_mac_tx_failed'
 drivers/net/wireless/zydas/zd1211rw/zd_mac.c:487: warning: Excess function parameter 'dev' description in 'zd_mac_tx_failed'
 drivers/net/wireless/zydas/zd1211rw/zd_mac.c:927: warning: Function parameter or member 'hw' not described in 'zd_op_tx'
 drivers/net/wireless/zydas/zd1211rw/zd_mac.c:927: warning: Excess function parameter 'dev' description in 'zd_op_tx'
 drivers/net/wireless/zydas/zd1211rw/zd_mac.c:963: warning: Function parameter or member 'hw' not described in 'filter_ack'
 drivers/net/wireless/zydas/zd1211rw/zd_mac.c:963: warning: Excess function parameter 'dev' description in 'filter_ack'

Cc: Daniel Drake <dsd@gentoo.org>
Cc: Ulrich Kunitz <kune@deine-taler.de>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Michael Wu <flamingice@sourmilk.net>
Cc: "Luis R. Rodriguez" <mcgrof@winlab.rutgers.edu>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/zydas/zd1211rw/zd_mac.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/zydas/zd1211rw/zd_mac.c b/drivers/net/wireless/zydas/zd1211rw/zd_mac.c
index a9999d10ae81f..3ef8533205f91 100644
--- a/drivers/net/wireless/zydas/zd1211rw/zd_mac.c
+++ b/drivers/net/wireless/zydas/zd1211rw/zd_mac.c
@@ -416,11 +416,10 @@ int zd_restore_settings(struct zd_mac *mac)
 
 /**
  * zd_mac_tx_status - reports tx status of a packet if required
- * @hw - a &struct ieee80211_hw pointer
- * @skb - a sk-buffer
- * @flags: extra flags to set in the TX status info
+ * @hw: a &struct ieee80211_hw pointer
+ * @skb: a sk-buffer
  * @ackssi: ACK signal strength
- * @success - True for successful transmission of the frame
+ * @tx_status: success and/or retry
  *
  * This information calls ieee80211_tx_status_irqsafe() if required by the
  * control information. It copies the control information into the status
@@ -477,7 +476,7 @@ static void zd_mac_tx_status(struct ieee80211_hw *hw, struct sk_buff *skb,
 
 /**
  * zd_mac_tx_failed - callback for failed frames
- * @dev: the mac80211 wireless device
+ * @urb: pointer to the urb structure
  *
  * This function is called if a frame couldn't be successfully
  * transferred. The first frame from the tx queue, will be selected and
@@ -913,9 +912,9 @@ static int fill_ctrlset(struct zd_mac *mac,
 /**
  * zd_op_tx - transmits a network frame to the device
  *
- * @dev: mac80211 hardware device
- * @skb: socket buffer
+ * @hw: a &struct ieee80211_hw pointer
  * @control: the control structure
+ * @skb: socket buffer
  *
  * This function transmit an IEEE 802.11 network frame to the device. The
  * control block of the skbuff will be initialized. If necessary the incoming
@@ -946,7 +945,7 @@ static void zd_op_tx(struct ieee80211_hw *hw,
 
 /**
  * filter_ack - filters incoming packets for acknowledgements
- * @dev: the mac80211 device
+ * @hw: a &struct ieee80211_hw pointer
  * @rx_hdr: received header
  * @stats: the status for the received packet
  *
-- 
2.25.1

