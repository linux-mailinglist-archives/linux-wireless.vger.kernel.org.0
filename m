Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC6C1182677
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2020 02:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387552AbgCLBFk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Mar 2020 21:05:40 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43547 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387480AbgCLBFk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Mar 2020 21:05:40 -0400
Received: by mail-pg1-f193.google.com with SMTP id u12so2139453pgb.10
        for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2020 18:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x3Y2+WnFUdTxHbJoopB8+PdU3hv8GUzBx6h0RSMiGek=;
        b=DorqY27l3R7SVuX7lU1ejiVwRjHHlWron/msZcZ5QVyY+SoGaucc9UNzGAyKk7YMTA
         HWBN2xlqORD9kYiuJVv5WQ41dx0V12p2t4wsm4zmd0VZViguQ7Vk8f0GrurbjHbG9JBj
         11+wXaoHk8O9XEq9AWzmQhSks+cNhlOnksIzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x3Y2+WnFUdTxHbJoopB8+PdU3hv8GUzBx6h0RSMiGek=;
        b=J9aSmONWYrVxpZp0/RMJLOOFEqyDVB+ToeogtqnCRwIu1gdrNx/v7SCJqOqqwb1L2m
         qTRmANJKb+42bas3PleR6ladosGKTQyYuSXzpPtscRqD/qjqQ/9B+BJLCYfjIKCVNbx3
         11bwUAyYtXL4UsNZVP1ZvIrEW4GPgB2fAST1hLlm2fa7G8XdceHDIAxV/gPbM51HZEuh
         GOyqlHtUiOseng//41gDTA6najrBtMUTXtSXAFXpYuG+fjKJ1Px0voWsWj2w6+zRBttD
         31wLzIcMGgR+2s8p+6OSG/wrUkiiJFQUIxOcmix2V3IKOnV2u3NpDaK2zCtvk2zqEtWi
         ulTg==
X-Gm-Message-State: ANhLgQ0BNz7km7hgcC0SWinDcxi5l4Jzj+AKegaCwMsDrBhfuEkpUlxW
        CG2adZW1ahfQHGLdf9iUENJtXg==
X-Google-Smtp-Source: ADFU+vt0nlBalwl0wofaAwBlRVZM+WI8HpFSEH21Sbdusg0VkknGletYUMCBv5KSC5eNKR4YlNMUKA==
X-Received: by 2002:a62:7786:: with SMTP id s128mr5621760pfc.34.1583975139162;
        Wed, 11 Mar 2020 18:05:39 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id i16sm1854428pfa.198.2020.03.11.18.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 18:05:37 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, yenlinlai@google.com,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] iw: phy: dump wiphy index
Date:   Wed, 11 Mar 2020 18:05:15 -0700
Message-Id: <20200312010515.21095-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We support getting wiphy info by index (e.g., 'iw phy#0 info') but we
don't actually dump that info anywhere. Let's fix that.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 info.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/info.c b/info.c
index 04f4bd7414d6..97240f68371d 100644
--- a/info.c
+++ b/info.c
@@ -133,6 +133,9 @@ static int print_phy_handler(struct nl_msg *msg, void *arg)
 	if (print_name && tb_msg[NL80211_ATTR_WIPHY_NAME])
 		printf("Wiphy %s\n", nla_get_string(tb_msg[NL80211_ATTR_WIPHY_NAME]));
 
+	if (print_name && tb_msg[NL80211_ATTR_WIPHY])
+		printf("\twiphy index: %u\n", nla_get_u32(tb_msg[NL80211_ATTR_WIPHY]));
+
 	/* needed for split dump */
 	if (tb_msg[NL80211_ATTR_WIPHY_BANDS]) {
 		nla_for_each_nested(nl_band, tb_msg[NL80211_ATTR_WIPHY_BANDS], rem_band) {
-- 
2.25.1.481.gfbce0eb801-goog

