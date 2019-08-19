Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48B2B94C77
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2019 20:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbfHSSTb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Aug 2019 14:19:31 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46377 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbfHSSTb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Aug 2019 14:19:31 -0400
Received: by mail-pg1-f193.google.com with SMTP id m3so1657761pgv.13
        for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2019 11:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SJlge8rq+r4uUPWO3pCVCCkIuVNuW0aYbGKMgKd/2xw=;
        b=OX9aulaDJeWrn/KfC+t0GIpZ5sYOrxoLMbFmQ5csC9q77hJG8Y5Y4uzZCsOPkacbHF
         eACYdXSIlwNxdmfRA7SNHnreUAzUDskEkLGE3nAfIj0guS6r61u0UfLItCSXKRbn/QfJ
         QBc2Uh3gQk6KGB5OH4yGEfjSie17cZROYkz/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SJlge8rq+r4uUPWO3pCVCCkIuVNuW0aYbGKMgKd/2xw=;
        b=jk+aAoyJWJCP8YdPCYGZnWKIpA9Da3loAwmfUQNfEIuOZty2QM095ckFrEKAarV8Tc
         pUq7IagVcLuZIjXumcuyLxn+2WUl5k4kiLyPBRcV96keIDVUNLXWUm+ag8P/KzW3DeLq
         puIXxKnmwQ7aIsmsXAM7FhBIAdn58HUACh5gm0B48m/vPRfHE+cwuPvmDyQS8/O13o8W
         SGeMkm8VxZqi+svURNgcfAcBYeMvj1Eow1/YhXlbUT/TfvpZYqFirVcSC4rohCtlx5K+
         x5ZKmFT72HqODocX0Yw2HUWpB0J/r3WG3+Hnzx0hwBphXRIedFSFl1PvXkgVr7v5i1WS
         PrcA==
X-Gm-Message-State: APjAAAURhTqTPE+xwecWeNCA1eYlUaZKqkD9p1ypTSlp37WWmnJGrcC5
        jORI9G61x0szqa/yIkNSjTZfVvg+BhI=
X-Google-Smtp-Source: APXvYqytE4xc/N9uZelcEE+Rlm8nsw99Haw09hYkjnFQv1ekLhzk+FenYSQ3b1GhI0wlrCYwI7tijw==
X-Received: by 2002:a17:90a:d58c:: with SMTP id v12mr21859356pju.7.1566238769923;
        Mon, 19 Aug 2019 11:19:29 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id 10sm26981889pfv.63.2019.08.19.11.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 11:19:28 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     <linux-wireless@vger.kernel.org>
Cc:     Yan-Hsuan Chuang <yhchuang@realtek.com>,
        Guenter Roeck <groeck@chromium.org>,
        kbuild test robot <lkp@intel.com>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 5.4] rtw88: drop unused rtw_coex_coex_dm_reset()
Date:   Mon, 19 Aug 2019 11:17:57 -0700
Message-Id: <20190819181757.204572-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Guenter Roeck <groeck@chromium.org>

0day reports:

sparse warnings:

drivers/net/wireless/realtek/rtw88/coex.c:2457:6: sparse:
	symbol 'rtw_coex_coex_dm_reset' was not declared. Should it be static?

rtw_coex_coex_dm_reset() is not called. Remove it.

Fixes: 4136214f7c46 ("rtw88: add BT co-existence support")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/net/wireless/realtek/rtw88/coex.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index 4577fceddc5e..9ee860db651a 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -2454,11 +2454,6 @@ void rtw_coex_wl_fwdbginfo_notify(struct rtw_dev *rtwdev, u8 *buf, u8 length)
 	rtw_coex_wl_ccklock_detect(rtwdev);
 }
 
-void rtw_coex_coex_dm_reset(struct rtw_dev *rtwdev)
-{
-	__rtw_coex_init_hw_config(rtwdev, false);
-}
-
 void rtw_coex_wl_status_change_notify(struct rtw_dev *rtwdev)
 {
 	struct rtw_coex *coex = &rtwdev->coex;
-- 
2.23.0.rc1.153.gdeed80330f-goog

