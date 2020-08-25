Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D07FC25147D
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Aug 2020 10:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgHYInf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Aug 2020 04:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbgHYIne (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Aug 2020 04:43:34 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B007C061574
        for <linux-wireless@vger.kernel.org>; Tue, 25 Aug 2020 01:43:33 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g75so1341108wme.4
        for <linux-wireless@vger.kernel.org>; Tue, 25 Aug 2020 01:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=eJIrPqYjE0dAhcP4ZkZrj1aYUysa9b1OXixWXQw7McY=;
        b=vc/EOs2XvrKCpyBoB+0CqxZSDDrqZOwL9j+1S1VdFeqsiDRB3vzpHZaViBORnZ0htc
         eyjxEUBaZBZzZvmys9xebuxUl6lt76GxgDrpnssWp5OQkpRD8zbdA4jIACSe66TWNW9+
         zepPS5hRMlZ3GsTUecYthvOP+5zchQqgB6Jt02u/0jssKrxGw5kr6kflMN42Eo/mRp1A
         HO5WrF5HZAXfStyveN6y5/2xzf4s13Oann37ZW7+O96e81MwDbwmWRGqr3y1j8Vsf/Nj
         NN1wsab9XTOHgVNiiC69qxQG65g9WhXROb1W+ZEXjIRKdSUbHDRQ9BscGPYzLbwc0oDz
         ba5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eJIrPqYjE0dAhcP4ZkZrj1aYUysa9b1OXixWXQw7McY=;
        b=LVS/d/aXEXZ/xrM9hDBqNBKyeIxLYZMcVagTyRBjPFKKeWQ7vdBhncXsexhSiv5Y8h
         GaxV8AgS/476+RieEzInvb1XTZftozPbFKu4nidOm7nThqfn+mYhpELUYKZXdz0I0wFh
         wjR/8yxoUkkSUvOP3yxieZ5lKIEgh2sA9JZTPeAkgDeZYFUjzBQ4RGVwkzqIaVpr2HUv
         5dFmr4fxbDiMs1Kqb5RAVhCA5/ECvNxxUg8HjefgJK9l5di5em8dyYavq/L9VgKA1Fyz
         cEM7X8d3+6dErbXa2xA/me7Xc+9BWTcbpRxhC6Y/eUBZMyTFYGkiWy2kOcmf9f3PBzj5
         STug==
X-Gm-Message-State: AOAM533jqX1+fQT2rjSpPy1UjAmFsh+Otbt39rOY8wqDnZz01WHykTNG
        eLrda02HmGztB7AcHm+R9W8VMA==
X-Google-Smtp-Source: ABdhPJztzhCA6GBIz1xdsS4VB/ocM3B3MekVavrtjyhJxwbLVXZBjyjUGG5qqogyVRidS2+Od0jLqQ==
X-Received: by 2002:a1c:ed15:: with SMTP id l21mr1012476wmh.56.1598345011082;
        Tue, 25 Aug 2020 01:43:31 -0700 (PDT)
Received: from localhost.localdomain ([88.122.66.28])
        by smtp.gmail.com with ESMTPSA id u13sm4349613wmm.20.2020.08.25.01.43.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Aug 2020 01:43:30 -0700 (PDT)
From:   Loic Poulain <loic.poulain@linaro.org>
To:     kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH] wcn36xx: Setup starting bitrate to MCS-5
Date:   Tue, 25 Aug 2020 10:49:01 +0200
Message-Id: <1598345341-4505-1-git-send-email-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

By default, after associated to an AP, the wcn36xx bitrate adjustment
algorithm starts sending data at 1Mbps, and increases the rate slowly
(1Mbps, 2Mbps, 6Mbps...) over the further TX packets.

Starting at 1Mbps usually causes the initial throughput to be really
low and the maximum possible bitrate to be reached after about hundreed
of TX packets.

That can be improved by setting a different initial bitrate for data
packets via the ENABLE_DYNAMIC_RA_START_RATE configuration value, this
value can be a legacy or MCS rate.

This patch sets the starting bitrate value to MCS-5, which seems to be
a good compromise given it can be quickly adjusted low or up if necessary.
(and based on what I observed in the wild with some mobile devices)

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/hal.h | 8 ++++++++
 drivers/net/wireless/ath/wcn36xx/smd.c | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/hal.h b/drivers/net/wireless/ath/wcn36xx/hal.h
index 6ba0fd5..88e1ed5 100644
--- a/drivers/net/wireless/ath/wcn36xx/hal.h
+++ b/drivers/net/wireless/ath/wcn36xx/hal.h
@@ -728,6 +728,14 @@ enum pe_stats_mask {
 #define WCN36XX_HAL_CFG_ENABLE_TDLS_OXYGEN_MODE		104
 #define WCN36XX_HAL_CFG_MAX_PARAMS			105
 
+/* Specify the starting bitrate, 11B and 11A/G rates can be specified in
+ * multiples of 0.5 So for 5.5 mbps => 11. for MCS 0 - 7 rates, Bit 7 should
+ * set to 1 and Bit 0-6 represent the MCS index. so for MCS2 => 130.
+ * Any invalid non-zero value or unsupported rate will set the start rate
+ * to 6 mbps.
+ */
+#define WCN36XX_HAL_CFG_ENABLE_DYNAMIC_RA_START_RATE	210
+
 /* Message definitons - All the messages below need to be packed */
 
 /* Definition for HAL API Version. */
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 9864c6f..83247d3 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -77,6 +77,7 @@ static struct wcn36xx_cfg_val wcn36xx_cfg_vals[] = {
 	WCN36XX_CFG_VAL(BTC_STATIC_LEN_LE_WLAN, 30000),
 	WCN36XX_CFG_VAL(MAX_ASSOC_LIMIT, 10),
 	WCN36XX_CFG_VAL(ENABLE_MCC_ADAPTIVE_SCHEDULER, 0),
+	WCN36XX_CFG_VAL(ENABLE_DYNAMIC_RA_START_RATE, 133), /* MCS 5 */
 };
 
 static int put_cfg_tlv_u32(struct wcn36xx *wcn, size_t *len, u32 id, u32 value)
-- 
2.7.4

