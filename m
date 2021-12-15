Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D8E4754C4
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Dec 2021 09:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241002AbhLOI6d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Dec 2021 03:58:33 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:34394
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236352AbhLOI6d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Dec 2021 03:58:33 -0500
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 545CF3F1BA
        for <linux-wireless@vger.kernel.org>; Wed, 15 Dec 2021 08:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639558707;
        bh=3BfLpW6QaE5r1o/oxEhvTtY5Tkz0EqDoGB1r3qMbQpc=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=bHPo9XUCkUguaJYepEhAngL/bJSgTo757tLMndVO5XCS8tDBd5xtVSlrZj4S7cJT4
         yJRjARB9P2FZEceLvIfnbBqlc5KEpZaryNEuQD+3C4WaUwjn1Ug4a2+sHFc/W0r9Yp
         xdo/evotRYLZMnaNU1V4n2z2EgO6RhybmASARjB5obHaGIZFnysL+h+eQUF8ap1wey
         5cAOoXe1sNiCjWANodc+B+UkxhbmebMm4iSbcrxTc4wpCUryLdxcYft+th8vnP0F+F
         bMd+XKZ5seDJ3azUS/izk4RJTnz7CH3MTvORhsucbn56yAOsZAji93FUANZLiBEvEG
         IC90r9mhFctbw==
Received: by mail-pj1-f69.google.com with SMTP id p8-20020a17090a748800b001a6cceee8afso11788528pjk.4
        for <linux-wireless@vger.kernel.org>; Wed, 15 Dec 2021 00:58:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3BfLpW6QaE5r1o/oxEhvTtY5Tkz0EqDoGB1r3qMbQpc=;
        b=oBw0GBb1+q6kP1mtjmH1G6ukGVQjMIlaJcE+QQi/jZvTB6NgGrAdQc5C6cbY2wV3nZ
         mS2XmZUWikwnrub/coEIdDGcd0dKraq0WBySJZTMD5rNRZ0WrpAgB78EJiwyWjs53F9y
         4TU3KIkV4NErXvNW7sBWwSGxW14xxIR8ZvCv4ZwtZJXJYNlJRbbAJTpQzTNdS7y1nTn2
         3hqzTuXzAJYhHnUdR0P9A9ajg+3Bv6tlt1znbePjiM2fenhfJJnoDCI6vZ91MDHgpyMU
         Nzah802ZuzDSLFE6+tWnbkWqkLmpMZa6pnO6wsm9d2t3Yb4kQJwNSAMp+4uzHKWld4Zs
         QpRA==
X-Gm-Message-State: AOAM531pPwLH9QHdRkVhotXal+Sw8vukDTULVMlK94MWfBGj5MQV72rP
        g7lFmTTI81z/GJ9r930eCLdM2vXp4Prjo4ym/bWIOGyj0oMSfDR5TjXSRSkT0xVch5Mj8feO1TL
        UX+ST+E55RXa80L5vDhTmpNYlBUuxaYRoodK3aLYCviry
X-Received: by 2002:a17:90b:1d91:: with SMTP id pf17mr10697938pjb.230.1639558705740;
        Wed, 15 Dec 2021 00:58:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz5u/I/zPqWj2M27e7kAtp+TKxevV0E9EA8Zo4i+iC+27VJ83/+Rr/1w6QvRSDqHo7Q7JlNJg==
X-Received: by 2002:a17:90b:1d91:: with SMTP id pf17mr10697915pjb.230.1639558705415;
        Wed, 15 Dec 2021 00:58:25 -0800 (PST)
Received: from localhost.localdomain (122-116-80-115.hinet-ip.hinet.net. [122.116.80.115])
        by smtp.gmail.com with ESMTPSA id bt2sm1567260pjb.57.2021.12.15.00.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 00:58:25 -0800 (PST)
From:   Chris Chiu <chris.chiu@canonical.com>
To:     Jes.Sorensen@gmail.com, kvalo@codeaurora.org, davem@davemloft.net,
        kuba@kernel.org
Cc:     code@reto-schneider.ch, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Chiu <chris.chiu@canonical.com>
Subject: [PATCH v2] rtl8xxxu: Improve the A-MPDU retransmission rate with RTS/CTS protection
Date:   Wed, 15 Dec 2021 16:58:19 +0800
Message-Id: <20211215085819.729345-1-chris.chiu@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The A-MPDU TX retransmission rate is always high (> 20%) even in a very
clean environment. However, the vendor driver retransimission rate is
< 10% in the same test bed. The difference is the vendor driver starts
the A-MPDU TXOP with initial RTS/CTS handshake which is observed in the
air capture and the TX descriptor. Since the driver does not know how
many frames will be aggregated and the estimated duration, forcing the
RTS/CTS protection for A-MPDU helps to lower the retransmission rate
from > 20% to ~12% in the same test setup with the vendor driver.

Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
---

v2: revise the commit message to be more explicit.

 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index a42e2081b75f..06d59ffb7444 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4859,7 +4859,7 @@ rtl8xxxu_fill_txdesc_v1(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
 	 * rts_rate is zero if RTS/CTS or CTS to SELF are not enabled
 	 */
 	tx_desc->txdw4 |= cpu_to_le32(rts_rate << TXDESC32_RTS_RATE_SHIFT);
-	if (rate_flags & IEEE80211_TX_RC_USE_RTS_CTS) {
+	if (ampdu_enable || (rate_flags & IEEE80211_TX_RC_USE_RTS_CTS)) {
 		tx_desc->txdw4 |= cpu_to_le32(TXDESC32_RTS_CTS_ENABLE);
 		tx_desc->txdw4 |= cpu_to_le32(TXDESC32_HW_RTS_ENABLE);
 	} else if (rate_flags & IEEE80211_TX_RC_USE_CTS_PROTECT) {
@@ -4930,7 +4930,7 @@ rtl8xxxu_fill_txdesc_v2(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
 	/*
 	 * rts_rate is zero if RTS/CTS or CTS to SELF are not enabled
 	 */
-	if (rate_flags & IEEE80211_TX_RC_USE_RTS_CTS) {
+	if (ampdu_enable || (rate_flags & IEEE80211_TX_RC_USE_RTS_CTS)) {
 		tx_desc40->txdw3 |= cpu_to_le32(TXDESC40_RTS_CTS_ENABLE);
 		tx_desc40->txdw3 |= cpu_to_le32(TXDESC40_HW_RTS_ENABLE);
 	} else if (rate_flags & IEEE80211_TX_RC_USE_CTS_PROTECT) {
-- 
2.25.1

