Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5031F67F7
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2020 14:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgFKMk0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Jun 2020 08:40:26 -0400
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:45668 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbgFKMkZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Jun 2020 08:40:25 -0400
Received: from legolas.fritz.box (unknown [87.147.49.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 28AF558005E;
        Thu, 11 Jun 2020 14:40:24 +0200 (CEST)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     nbd@nbd.name, lorenzo.bianconi@redhat.com
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH] mt76: allow more channels, allowed in ETSI domain
Date:   Thu, 11 Jun 2020 14:40:22 +0200
Message-Id: <20200611124022.405658-1-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

While looking at the ETSI regulatory domain definitions
and a patch, which allows more channels for ath10k, I also
checked the channels allowed for mt76.

ETSI regulations would possibly allow to add channels 32, 68,
96, 144, 169 and 173. IEEE 802.11-2016 defines no operating class
for channels 32, 68 and 96. This leaves us channels 144, 169 and 173,
which are included in this patch.

I tested 169 and 173 with a mt76 based USB dongle (AVM AC 860) and they
worked fine. If I saw that right, these channels are also covered by
register definitions inside the driver.

Channel 144 should also work, but gets disabled by the kernel as of now.

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 907098101898..4c10c8164aee 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -58,12 +58,15 @@ static const struct ieee80211_channel mt76_channels_5ghz[] = {
 	CHAN5G(132, 5660),
 	CHAN5G(136, 5680),
 	CHAN5G(140, 5700),
+	CHAN5G(144, 5720),
 
 	CHAN5G(149, 5745),
 	CHAN5G(153, 5765),
 	CHAN5G(157, 5785),
 	CHAN5G(161, 5805),
 	CHAN5G(165, 5825),
+	CHAN5G(169, 5845),
+	CHAN5G(173, 5865),
 };
 
 static const struct ieee80211_tpt_blink mt76_tpt_blink[] = {
-- 
2.27.0

