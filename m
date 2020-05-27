Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B731E4B29
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2020 18:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731059AbgE0Q5m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 May 2020 12:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728596AbgE0Q5m (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 May 2020 12:57:42 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3008FC08C5C2
        for <linux-wireless@vger.kernel.org>; Wed, 27 May 2020 09:57:42 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id q9so1735266pjm.2
        for <linux-wireless@vger.kernel.org>; Wed, 27 May 2020 09:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DWPRa3kcV7dHK3sr3IH2Glel3aMfKYoMnIduKqYeTNo=;
        b=DOPnF2Ut7cEJ7K2Xb6Y2Hq4IuCooIbhfWPKf+5i+gas4rdLOhy10q+Pogvx8rAtXOk
         alWAH5LdFykoexEfG0SZYyJkILeAkNuJAB/duRacHeHIzoFLkckdsksSNgbCYHwnPB/m
         v5y7siWrfi4mcTKLakMGlDHY5NQjySa22V3Jg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DWPRa3kcV7dHK3sr3IH2Glel3aMfKYoMnIduKqYeTNo=;
        b=FMWL2LA2EVbEO8t3BBxoefzmDJSnGmFrPgJ7mPC+2mqv8QMJvvIQCHLw2hwzUzWNTf
         WjGrBSunwqQo7QMwFW42lZZnptvTEw2X0iNyRaprGFy8QqQ2hFZPd3IUstJ/77sLXkZI
         Zw7aA98JWkiramGQjtFPgOTMA4FTqCO/WrdRAgJmEiOTvMizFtbUpjLRP0e29Z4/uxAp
         XJ8ghbArjVfRqckG72Y9MW/+/f8/zTIXdNhXJbZp3EQqr+B3iNnxCNrEpVXJkLX9Um9/
         eEDRnYrPUWkZj/BJ4vOeaZZY4eor8RvvIFOCSR6uSc9MPd2GUKKvuOvDoz0Fhe6UCJXW
         qWBA==
X-Gm-Message-State: AOAM532n4kvIcOSByCMBghV3g9gOYzkRFwOpp5oFX98hi+6lc1iQPeEm
        acK2q2qkaYYNl/cqTvnQdMXwRA==
X-Google-Smtp-Source: ABdhPJzZCdWzARlTkkKCwUXMyf44S8pb9ACQrw4RiO+5MwqURsgvVmvJ0u5JwwN7oRQazLF1sJlpsA==
X-Received: by 2002:a17:90a:4e07:: with SMTP id n7mr6410317pjh.34.1590598661609;
        Wed, 27 May 2020 09:57:41 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id x12sm2601829pfo.72.2020.05.27.09.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 09:57:40 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        stable@vger.kernel.org, Wen Gong <wgong@codeaurora.org>
Subject: [PATCH] Revert "ath: add support for special 0x0 regulatory domain"
Date:   Wed, 27 May 2020 09:57:18 -0700
Message-Id: <20200527165718.129307-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This reverts commit 2dc016599cfa9672a147528ca26d70c3654a5423.

Users are reporting regressions in regulatory domain detection and
channel availability.

The problem this was trying to resolve was fixed in firmware anyway:

    QCA6174 hw3.0: sdio-4.4.1: add firmware.bin_WLAN.RMH.4.4.1-00042
    https://github.com/kvalo/ath10k-firmware/commit/4d382787f0efa77dba40394e0bc604f8eff82552

Link: https://bbs.archlinux.org/viewtopic.php?id=254535
Link: http://lists.infradead.org/pipermail/ath10k/2020-April/014871.html
Link: http://lists.infradead.org/pipermail/ath10k/2020-May/015152.html
Fixes: 2dc016599cfa ("ath: add support for special 0x0 regulatory domain")
Cc: <stable@vger.kernel.org>
Cc: Wen Gong <wgong@codeaurora.org>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/net/wireless/ath/regd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/regd.c b/drivers/net/wireless/ath/regd.c
index bee9110b91f3..20f4f8ea9f89 100644
--- a/drivers/net/wireless/ath/regd.c
+++ b/drivers/net/wireless/ath/regd.c
@@ -666,14 +666,14 @@ ath_regd_init_wiphy(struct ath_regulatory *reg,
 
 /*
  * Some users have reported their EEPROM programmed with
- * 0x8000 or 0x0 set, this is not a supported regulatory
- * domain but since we have more than one user with it we
- * need a solution for them. We default to 0x64, which is
- * the default Atheros world regulatory domain.
+ * 0x8000 set, this is not a supported regulatory domain
+ * but since we have more than one user with it we need
+ * a solution for them. We default to 0x64, which is the
+ * default Atheros world regulatory domain.
  */
 static void ath_regd_sanitize(struct ath_regulatory *reg)
 {
-	if (reg->current_rd != COUNTRY_ERD_FLAG && reg->current_rd != 0)
+	if (reg->current_rd != COUNTRY_ERD_FLAG)
 		return;
 	printk(KERN_DEBUG "ath: EEPROM regdomain sanitized\n");
 	reg->current_rd = 0x64;
-- 
2.27.0.rc0.183.gde8f92d652-goog

