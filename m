Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7CBB461A1F
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Nov 2021 15:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378842AbhK2Opf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Nov 2021 09:45:35 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:55322
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1379124AbhK2OnZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Nov 2021 09:43:25 -0500
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 905363F1B1
        for <linux-wireless@vger.kernel.org>; Mon, 29 Nov 2021 14:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638196803;
        bh=w6+BoYvnmAnd+GSm1CSG2oy2MCenL4FLdq4APeVFVSU=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=SSLBrO4hzgCknz6ZobYMdyV465cWrP+t1PQ0rWkP7d3I2eKnS/cvpV5Xeen3vztfj
         ZOCCADslzkI4U5vZddG1VdsUud/hYbCRgnUNhFRvoO4YW20M/NZxoctqTFDy2H/6mr
         t941Ig8jP+99IPNt8PU7WRicMM8bW9XxYzoD8mJPLs02RCFS61hTd1Ho25rYmU4A5j
         zm/FvGcr/wiV9dnCpGh6l1FDg7E5z6B7c1w8bjUITwEmhX7JM+UlghGtOR7Z86SE/u
         J8LbILLuEtqEWfUFT0VCLi2O15L5ma5YGqmzwUp0/X+L3upGgUiRPk/GYTyuKn5shP
         Po0FuiMmTLAAw==
Received: by mail-pg1-f198.google.com with SMTP id x30-20020a637c1e000000b00324ab629735so8575795pgc.17
        for <linux-wireless@vger.kernel.org>; Mon, 29 Nov 2021 06:40:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w6+BoYvnmAnd+GSm1CSG2oy2MCenL4FLdq4APeVFVSU=;
        b=n0m9l64sm0Q0RRwia3rB+qnOAAWvr/pE6Lw3YGU32z518uMYgHeMTafTBk+MC4Fd1Q
         P34706AN5QL/Zu6MRgOthc8Z50M5GDOIRAD2+zBuuTjWsEKD51TCCTdY8/EKyxkcQc5B
         Tyvmjc4yVIojO1WsLwvd5qyh5UySr53kSRhUzL584mrl0HYFi7fMy+Jqy6n8pC4zZCbS
         lf5BpPtKyjkVdShCRBYkD28RpgmEsJ84cH0SpB3ZbJhYTPlcQhvzjLZqsf35C8nx4oYq
         RHIYs+nm0GTSkJ8YnpnUysGZjyDH8ZgiDzx4NWmP8PxU4uthE05cONpR3rqf4p7UdLcG
         LNsg==
X-Gm-Message-State: AOAM5307bJt43EFqPRivw/e8+Ue9uBfGpjxOBKMvk3znE7CapNb5auNS
        7RNE3QIYm9P4+2zqEdV2OQtnALgVwjFZvAMNvhMz+3GUcGBONAgTrovHqQsFRMIPIDNAeNkjlPv
        E+gNVBfBPX8Xq/EuqtARDI2wbyyN9avQXYddOQ/28g9GM
X-Received: by 2002:a17:90b:4c89:: with SMTP id my9mr38888788pjb.229.1638196801871;
        Mon, 29 Nov 2021 06:40:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzu+OIHnSidQX9q38q/ISn/oYi/aZG1iV/zfzuNI9YibcOhqr2H6QmGitjdqa/6oOI6TNG41Q==
X-Received: by 2002:a17:90b:4c89:: with SMTP id my9mr38888748pjb.229.1638196801543;
        Mon, 29 Nov 2021 06:40:01 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e254-16ab-fe1c-26fe-b098-aa3d.emome-ip6.hinet.net. [2001:b400:e254:16ab:fe1c:26fe:b098:aa3d])
        by smtp.gmail.com with ESMTPSA id p188sm16862766pfg.102.2021.11.29.06.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 06:40:01 -0800 (PST)
From:   Chris Chiu <chris.chiu@canonical.com>
To:     Jes.Sorensen@gmail.com, kvalo@codeaurora.org, davem@davemloft.net,
        kuba@kernel.org
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chris Chiu <chris.chiu@canonical.com>
Subject: [PATCH] rtl8xxxu: Improve the A-MPDU retransmission rate with RTS/CTS protection
Date:   Mon, 29 Nov 2021 22:39:53 +0800
Message-Id: <20211129143953.369557-1-chris.chiu@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The A-MPDU retransmission rate is always high (> 20%) even in a very
clean environment. However, the vendor driver retransimission rate is
< 10% in the same test bed. The different is the vendor driver starts
the A-MPDU TXOP with initial RTS/CTS handshake which is observed in the
air capture and the TX descriptor. Since there's no related field in
TX descriptor to enable the L-SIG TXOP protection and the duration,
applying the RTS/CTS protection instead helps to lower the retransmission
rate from > 20% to ~12% in the same test setup.

Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
---
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

