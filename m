Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D5C3F8B22
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Aug 2021 17:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242963AbhHZPgG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Aug 2021 11:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242959AbhHZPgF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Aug 2021 11:36:05 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60501C0613C1
        for <linux-wireless@vger.kernel.org>; Thu, 26 Aug 2021 08:35:18 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id b6so5704432wrh.10
        for <linux-wireless@vger.kernel.org>; Thu, 26 Aug 2021 08:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=TaK24+8gH53dYWBrBRg64lij3FSBe4N9yadD4P1UUuU=;
        b=nqxp7aNA2YFI86iFQqlTb8aAJarFLYJyjLq9tjqOgYQjle/y/kqUGpanPFyaG2V/ha
         rGWgMsvszI7GNJDYdYDaAv3VryGdwcWmErLTdZ778olOb9rlm54q2lu7mVJLq4ehXDrD
         DmlvDd5/ZA2t1xHZKHdjjMcnVGdy/DxI1L+PkpEzohBaUNFEXL60WhnFPulJ8bdcL2LI
         2hIry2CRH8VaOscmYwYnBV61UPPHkmKa8DZ+mjIt/9hQ3ODMmH/nBEbHmCLF/AQM5lfK
         +qNWCAdRiRCmcGDQj9LXYyJ9kIutkZE/becoZEc834dylfEO8pzrM1TKvqwg9dTC4Oqd
         MHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TaK24+8gH53dYWBrBRg64lij3FSBe4N9yadD4P1UUuU=;
        b=ety4S8QHC5+ak3aeBAGV8aEqqAgoSgdkU5Qii8FUPhX658TcLHjom/+R68DWvpSA4E
         JoIQ+kJhq+1xS/vQ9ZNJ3JdVdCWuGmE/F/3qQJEKcRAmr4nejr10UxyAfzKOWU29LeIH
         8ixymceatn9kVt6tg7dMkaR8L/i34zEoWJETXpnMAL46/Cqb5+hbn0wxSmS+Q4F/HBNa
         tiW21TTjMlblfuV6MdnTT2b+7B1Pcwj49oAbrMvmijHtUwW1WtfH516GZTOT9WB7lhMG
         JjBO3WruszFXAY++oxtqRFMrlFRx23xAYxGPAdkkWWfsppA+dUi2cE26vH1KD0APd7k2
         +vPQ==
X-Gm-Message-State: AOAM5306ER0IdEZBLbeSk7u+S8lGXlDrIXM5+E1Azx9oPtQysepc+UUm
        VN5WHaM93DrWKUD+utqvpPGe+w==
X-Google-Smtp-Source: ABdhPJwWtlpoyiq3Tf1o4x6ydu6b9X8evjT9i7XPAHO9VE5CQrgelXfYq0cINvAnpCy8MxPMTk5TVA==
X-Received: by 2002:a5d:4dc3:: with SMTP id f3mr4917851wru.302.1629992116860;
        Thu, 26 Aug 2021 08:35:16 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:82c:5f0:edf4:979b:2385:1df8])
        by smtp.gmail.com with ESMTPSA id a12sm7598553wmm.42.2021.08.26.08.35.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Aug 2021 08:35:16 -0700 (PDT)
From:   Loic Poulain <loic.poulain@linaro.org>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH] wcn36xx: Fix missing frame timestamp for beacon/probe-resp
Date:   Thu, 26 Aug 2021 17:46:08 +0200
Message-Id: <1629992768-23785-1-git-send-email-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When receiving a beacon or probe response, we should update the
boottime_ns field which is the timestamp the frame was received at.
(cf mac80211.h)

This fixes a scanning issue with Android since it relies on this
timestamp to determine when the AP has been seen for the last time
(via the nl80211 BSS_LAST_SEEN_BOOTTIME parameter).

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/txrx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/txrx.c b/drivers/net/wireless/ath/wcn36xx/txrx.c
index 1b83115..cab196b 100644
--- a/drivers/net/wireless/ath/wcn36xx/txrx.c
+++ b/drivers/net/wireless/ath/wcn36xx/txrx.c
@@ -287,6 +287,10 @@ int wcn36xx_rx_skb(struct wcn36xx *wcn, struct sk_buff *skb)
 		status.rate_idx = 0;
 	}
 
+	if (ieee80211_is_beacon(hdr->frame_control) ||
+	    ieee80211_is_probe_resp(hdr->frame_control))
+		status.boottime_ns = ktime_get_boottime_ns();
+
 	memcpy(IEEE80211_SKB_RXCB(skb), &status, sizeof(status));
 
 	if (ieee80211_is_beacon(hdr->frame_control)) {
-- 
2.7.4

