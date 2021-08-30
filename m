Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A3A3FBA84
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Aug 2021 18:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237985AbhH3Q7R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Aug 2021 12:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237989AbhH3Q7R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Aug 2021 12:59:17 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE75C06175F
        for <linux-wireless@vger.kernel.org>; Mon, 30 Aug 2021 09:58:23 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id e26so3840186wmk.2
        for <linux-wireless@vger.kernel.org>; Mon, 30 Aug 2021 09:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=bv45KdT4Zm8l8jEqKG5eCu37McR/6YB/mBE0UhGjXlI=;
        b=Fpm8KZ30UhfR+FyeLGEv+OjD5Sa3ifrD2lU0n/5R+sGkMZlCv+VEYVmA7M6ApLw/SY
         cKnr6j4SkD3rJEmh6qA5XVbzevsPclsPm1X1nAor1w/Am0huQlkmzGBLudAjsdb/78He
         byXG9uDUJaGhivyVzjc+GXsEhZd11FE724sbKeHgdCrDMjuVbvA/S7aCXlcxBgI1JlUb
         bup3LgrEzVUKZoCLdjhT6XZsdLZZ/hEEizFnI73Ee+fODeEr5c+4wkInjqb40X+lY45q
         ap6gJPLEzBNGzqhy7wowkmbHehJOfu1DqzIXJfAim6a7hcnUG8nWknyMjaZtDVS/k+HY
         y0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bv45KdT4Zm8l8jEqKG5eCu37McR/6YB/mBE0UhGjXlI=;
        b=YdFoFE7n6SwPszF5HZmV3YmACC6HETHNUy7/U2paRE7ZrKs9AFFfcirH1tVaTpiN55
         51Qi3NCT1cVz71mt1/xNjoR6pRxKKIKFubfHVhK9++a+JMLTgrGovUdfIuHTGBN34GCT
         mu+fChFvKst8loCOBga6+n16AZHcnbKtWdwtHoQltxJQ5XLELRofutuW139zkzJdmkjg
         B02irKriPP/EVldV0J2gWf1i0fQ5/1DBhAkKL8tF3OPHsqyf5+ZeuEc19hQBi3Rm0Yj8
         XGvpuUag/KSctqeqETDl48hGJ5+i558rCk1xOEvyc9X8c63kKAN6gQI7nP/KFQrs0GwV
         d+iQ==
X-Gm-Message-State: AOAM531YUfXFbiyzuazwldYzDzwzj4mBpkDrxMqm1ss83SFsQZYQQ85R
        l/ALKypIoeH/XaHMntXeaKdghA==
X-Google-Smtp-Source: ABdhPJwOGImZ9sAtMUAlxXKrLn5YLDr9McehM+oesLu7xNEf2x5nMMhhY0satKodtzgTwC83ZOeZOw==
X-Received: by 2002:a1c:23d2:: with SMTP id j201mr22822039wmj.163.1630342701525;
        Mon, 30 Aug 2021 09:58:21 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:82c:5f0:8009:4e09:ca3:8f6])
        by smtp.gmail.com with ESMTPSA id r129sm72256wmr.7.2021.08.30.09.58.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Aug 2021 09:58:21 -0700 (PDT)
From:   Loic Poulain <loic.poulain@linaro.org>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, bryan.odonoghue@linaro.org,
        Loic Poulain <loic.poulain@linaro.org>, stable@vger.kernel.org
Subject: [PATCH] Revert "wcn36xx: Enable firmware link monitoring"
Date:   Mon, 30 Aug 2021 19:09:20 +0200
Message-Id: <1630343360-5942-1-git-send-email-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This reverts commit 8def9ec46a5fafc0abcf34489a9e8a787bca984d.

The firmware keep-alive does not cause any event in case of error
such as non acked. It's just a basic keep alive to prevent the AP
to kick-off the station due to inactivity. So let mac80211 submit
its own monitoring packet (probe/null) and disconnect on timeout.

Note: We want to keep firmware keep alive to prevent kick-off
when host is in suspend-to-mem (no mac80211 monitor packet).
Ideally fw keep alive should be enabled in suspend path and disabled
in resume path to prevent having both firmware and mac80211 submitting
periodic null packets.

This fixes non detected AP leaving issues in active mode (nothing
monitors beacon or connection).

Cc: stable@vger.kernel.org
Fixes: 8def9ec46a5f ("wcn36xx: Enable firmware link monitoring")
Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index 216bc34..128d25d 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1362,7 +1362,6 @@ static int wcn36xx_init_ieee80211(struct wcn36xx *wcn)
 	ieee80211_hw_set(wcn->hw, HAS_RATE_CONTROL);
 	ieee80211_hw_set(wcn->hw, SINGLE_SCAN_ON_ALL_BANDS);
 	ieee80211_hw_set(wcn->hw, REPORTS_TX_ACK_STATUS);
-	ieee80211_hw_set(wcn->hw, CONNECTION_MONITOR);
 
 	wcn->hw->wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
 		BIT(NL80211_IFTYPE_AP) |
-- 
2.7.4

