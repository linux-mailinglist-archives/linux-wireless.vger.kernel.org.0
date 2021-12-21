Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A53BF47BBC7
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Dec 2021 09:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235566AbhLUI0D (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Dec 2021 03:26:03 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40668 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234882AbhLUI0D (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Dec 2021 03:26:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3DAD6146E
        for <linux-wireless@vger.kernel.org>; Tue, 21 Dec 2021 08:26:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2530FC36AE7;
        Tue, 21 Dec 2021 08:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640075162;
        bh=6egSvCyH1nFoLh/gvwxfm/sG2DSmI8cZCdaRi7FhHsE=;
        h=From:To:Cc:Subject:Date:From;
        b=W3m9ExEDW/i+ppsxNTxXaqGy11ktkSEJtlDkzb6ozM4RyIrcRVrorhWkL3dFJ+3xI
         4TXO0lsRK8nQ6e8mq0Oh9GlPgpwGsmE2ymlep2PVQrWg7c27X0Z/d2fYE0fxCgncVF
         csz/Y4FYKzZrRCkPlnBUesJnoHwaGYlRLtshpr1UL+VpAOXG56SGQ1o1pKbe7glXp8
         KhmzUHIjdIukTjfvjl442t++rAtO2YWYFHcWkBrZCANH4iCGKaoWe0edGAv6VLzSYe
         ywtvFaiHpkeZnGiPB201PLxAjRXYANeWZPNbzcn+P851opRHCTBAaLfUuLe0G49LNx
         1/V9EcQDk1xFw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: make mt76_sar_capa static
Date:   Tue, 21 Dec 2021 09:25:57 +0100
Message-Id: <f45f95fc37718d6446bb66f6ca082657a3a474ac.1640075069.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix the following sparse warning:
drivers/net/wireless/mediatek/mt76/mac80211.c:183:32:
	warning: symbol 'mt76_sar_capa' was not declared. Should it be static?

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 8bb1c7ab5b50..148e126b9215 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -180,7 +180,7 @@ static const struct cfg80211_sar_freq_ranges mt76_sar_freq_ranges[] = {
 	{ .start_freq = 5725, .end_freq = 5950, },
 };
 
-const struct cfg80211_sar_capa mt76_sar_capa = {
+static const struct cfg80211_sar_capa mt76_sar_capa = {
 	.type = NL80211_SAR_TYPE_POWER,
 	.num_freq_ranges = ARRAY_SIZE(mt76_sar_freq_ranges),
 	.freq_ranges = &mt76_sar_freq_ranges[0],
-- 
2.33.1

