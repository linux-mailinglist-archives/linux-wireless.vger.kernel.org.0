Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA1D2A12D4
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Oct 2020 03:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbgJaCWY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Oct 2020 22:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgJaCWY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Oct 2020 22:22:24 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD44AC0613D5
        for <linux-wireless@vger.kernel.org>; Fri, 30 Oct 2020 19:22:23 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id i16so2967547wrv.1
        for <linux-wireless@vger.kernel.org>; Fri, 30 Oct 2020 19:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AtYobGQeIsOA41x9xn4O9D84Sqas95KTsM7EDwW2NZ8=;
        b=dAfcW65M3JWCQ89qzDq35zvSwoCEf7TBBXpiI1U+E0xvze7LbWUsAynF2RlanhZx9r
         FMYZ7Rv97zBH3OywmDwZUtBWvKh120hB+icIr3RdjNOCBiTnlAaaydlUR2BTyiUo4rLT
         w+n5Vq5JTC8yUdBaMRxYluz61eenZmO61Dp6eHe1zUDd0UJUhajE90oglYZ1gEXf7ODN
         TnaJU1IvVOyoOr1/zXQYZZMZR8VnGFzJIsZD3xoT6np7h0Iq566aauq60vhPlP1x4z4u
         voAHot+nQv3mHANXgRwXxL65iEgl0R/Rm8sCCQ4WEBcVAdz2gKX32vQnxtP8Z773Izcp
         bxoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AtYobGQeIsOA41x9xn4O9D84Sqas95KTsM7EDwW2NZ8=;
        b=JrERhnNrHROWO8MfCoplVcxeyVTixQFbCD5M+sf8jniu+MylDPYtKGdAp5hkjtUNM5
         6TzvOLmh2MCJsMZ/WUECOA50I1QJyl+AgRXd+s3jL9P6hZLjlaD8yTkoMswDoQNPNk7l
         CYnGmqI3P6kAgxdhjImOl/lAZt/uACuO0ib9G1VemxervGc2Bx/p9u4+RPWA5tyQyrFQ
         go1j6ko3ppWPxmUXr/BIst1x4FV4fqPY65lAwg8+qiDq7VROL6NP7JmaAscKj8/Ppo0f
         pNjthEaU4tPqWfn1C4KamvFZsKL1C90dZ8lhlszCT0CUBMcGQD6Q+Oa5OB7HICVeRZFU
         UP8g==
X-Gm-Message-State: AOAM530Ruryi9ifgRWsi7gS6s1MVkBtyp08SB/0/OdT/wjNayihmhBVA
        vgk0Lf1exWvmio5wfODWFQpdarZu/3USYQ==
X-Google-Smtp-Source: ABdhPJy12zo0S0DD5R7WceA9RVE9gTxaCV675hsNCwB0Rg5oQtpuj8pzUO5bRqmP5DW37NhImR2IHw==
X-Received: by 2002:adf:dc4b:: with SMTP id m11mr6377266wrj.47.1604110941550;
        Fri, 30 Oct 2020 19:22:21 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id g4sm6663817wmh.13.2020.10.30.19.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 19:22:21 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH 2/3] wcn36xx: Enable firmware link monitoring
Date:   Sat, 31 Oct 2020 02:23:10 +0000
Message-Id: <20201031022311.1677337-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031022311.1677337-1-bryan.odonoghue@linaro.org>
References: <20201031022311.1677337-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch switches on CONNECTION_MONITOR. Once done it is up to the
firmware to send keep alive and to monitor the link state.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index 706728fba72d..e924cc4acde0 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1246,6 +1246,7 @@ static int wcn36xx_init_ieee80211(struct wcn36xx *wcn)
 	ieee80211_hw_set(wcn->hw, HAS_RATE_CONTROL);
 	ieee80211_hw_set(wcn->hw, SINGLE_SCAN_ON_ALL_BANDS);
 	ieee80211_hw_set(wcn->hw, REPORTS_TX_ACK_STATUS);
+	ieee80211_hw_set(wcn->hw, CONNECTION_MONITOR);
 
 	wcn->hw->wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
 		BIT(NL80211_IFTYPE_AP) |
-- 
2.28.0

