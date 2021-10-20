Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E02434C0B
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Oct 2021 15:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhJTN3h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Oct 2021 09:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhJTN3g (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Oct 2021 09:29:36 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E609FC06161C
        for <linux-wireless@vger.kernel.org>; Wed, 20 Oct 2021 06:27:21 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id g2so19025882wme.4
        for <linux-wireless@vger.kernel.org>; Wed, 20 Oct 2021 06:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ICSjjYrq5VBgD8+gohBOnArWicPN7yL8vl3yOhj3VxQ=;
        b=yQZTdnRNPauSNqDkM/wcTsfPzIEKLiSbgpgHlePGgunYPfEocceAv7OBg8sEnEqbME
         LMmolEWqs84RY04lOC510iFtmypW7SBOmWTtTYDJPcHo14E39MbJt+f6Idjx2NcNVeyG
         nPQSFHzyv0f2mqG6xRj9u/9Pp8yeQT0Iu0Qw2tgimZwJ2JeUe/TutLJ0i+ztEAkOthLw
         3OYkq53MkCJyxaZ/++LV+f6saqj4McR7FZg3RYiXAlrqElZcpxE4Q0isPeqwy3kTUJGc
         qIqomhwali+T/zpCpOpx5xgKVAjbE1fTsMIvZ34a7mHLvQIzlYXjQBmUsOBsX/fpoXne
         yAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ICSjjYrq5VBgD8+gohBOnArWicPN7yL8vl3yOhj3VxQ=;
        b=nxBIYI0bpWNJydZPDAYJkQu9fqKxyfm0befw4MheqFh0n5AbHbW3MwsZT8c1WxKzCo
         4o3MLa79KPlqH8d4gBM/0s2WvY7zhPLOzlNhqpzqPoEWJKKLlnrisIhWWQykeVSeC26O
         5VDUgC3WFaLHQfL02Qel5TAoXCxezvhli4IuuFT3gGGm84zSZx++rcJetpaT2tSEMfKv
         HTWqL1v5U54EOBDQYowC6ezLKVmnJ3FuhQyzloTnluzJXB9wABWL0HlD1H3E+JPJvnVF
         nrNqGe4zLFtRh59LQ2Gv3jS0MMd7+TIf+JOFRLVSRtmALgyXh9TecLhUefHnWXuKaOKv
         YuuA==
X-Gm-Message-State: AOAM532tt+lxZJbGg6e5Xizp6GPCJJGzLtXmTaiM4gNJa7B6PGnEl8IR
        DqmXiOgNbnOkQhpXQJkk7gWTIw==
X-Google-Smtp-Source: ABdhPJw3xyULxICaUOPMhLQVJsH/O39qsna5P1f69B0vVbjnmxuIZ8t47pJzBtJ2/dHgFytlfdqdzQ==
X-Received: by 2002:adf:97d0:: with SMTP id t16mr50663575wrb.124.1634736440394;
        Wed, 20 Oct 2021 06:27:20 -0700 (PDT)
Received: from localhost.localdomain ([88.160.176.23])
        by smtp.gmail.com with ESMTPSA id j206sm5052170wmj.23.2021.10.20.06.27.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Oct 2021 06:27:19 -0700 (PDT)
From:   Loic Poulain <loic.poulain@linaro.org>
To:     kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, Loic Poulain <loic.poulain@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH] wcn36xx: Fix HT40 capability for 2Ghz band
Date:   Wed, 20 Oct 2021 15:38:53 +0200
Message-Id: <1634737133-22336-1-git-send-email-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

All wcn36xx controllers are supposed to support HT40 (and SGI40),
This doubles the maximum bitrate/throughput with compatible APs.

Tested with wcn3620 & wcn3680B.

Cc: stable@vger.kernel.org
Fixes: 8e84c2582169 ("wcn36xx: mac80211 driver for Qualcomm WCN3660/WCN3680 hardware")
Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index d4f44c8..4f139d9 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -137,7 +137,9 @@ static struct ieee80211_supported_band wcn_band_2ghz = {
 		.cap =	IEEE80211_HT_CAP_GRN_FLD |
 			IEEE80211_HT_CAP_SGI_20 |
 			IEEE80211_HT_CAP_DSSSCCK40 |
-			IEEE80211_HT_CAP_LSIG_TXOP_PROT,
+			IEEE80211_HT_CAP_LSIG_TXOP_PROT |
+			IEEE80211_HT_CAP_SGI_40 |
+			IEEE80211_HT_CAP_SUP_WIDTH_20_40,
 		.ht_supported = true,
 		.ampdu_factor = IEEE80211_HT_MAX_AMPDU_64K,
 		.ampdu_density = IEEE80211_HT_MPDU_DENSITY_16,
-- 
2.7.4

