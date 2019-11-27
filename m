Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A446D10A90C
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2019 04:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbfK0DTZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Nov 2019 22:19:25 -0500
Received: from a27-18.smtp-out.us-west-2.amazonses.com ([54.240.27.18]:51308
        "EHLO a27-18.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726295AbfK0DTZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Nov 2019 22:19:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574824764;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
        bh=92Cgq7YPc/LoYHy38dUZaTP5T9x4xucq6/3tGdweYc0=;
        b=IQyTtuHcynwv/LnSDdn75Lqos0OxzOWli5UCVT+sabWgh5jNQ33y5GTeNC3Wt9o1
        s+71jOQLNmUXxLi9YCJHZFy0aetSC4ULvFiI2C3MJ6sQD4umvSbn5Kqg2OZu3GG2lLE
        ZPctysUM6sTcVspmcuEHe2z6qdxuyYkEAO8FWIz0=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574824764;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
        bh=92Cgq7YPc/LoYHy38dUZaTP5T9x4xucq6/3tGdweYc0=;
        b=F8yNM8/DznDpfA+NebnypKRkqkynPpYxdX5rmp3ODAxfKgdocj+UQ5qzs2Yf/5Op
        C1IUbPRxFWbTW3ELrWUfmF10JZrbkKD3kEYH+mkEE+u/CIUoz6LQr9pecLjJFEcUMVE
        yU6loWh++++7RtynUMNy2e/FFxmHrXhC3pnjVWRc=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8F3FFC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] ath10k: set WMI_PEER_AUTHORIZE after a firmware crash
Date:   Wed, 27 Nov 2019 03:19:24 +0000
Message-ID: <0101016eaadee57a-54500c6d-4751-423f-8bab-5acd8fad2175-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2019.11.27-54.240.27.18
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

After the firmware crashes ath10k recovers via ieee80211_reconfig(),
which eventually leads to firmware configuration and including the
encryption keys. However, because there is no new auth/assoc and
4-way-handshake, and firmware set the authorize flag after
4-way-handshake, so the authorize flag in firmware is not set in
firmware without 4-way-handshake. This will lead to a failure of data
transmission after recovery done when using encrypted connections like
WPA-PSK. Set authorize flag after installing keys to firmware will fix
the issue.

This was noticed by testing firmware crashing using simulate_fw_crash
debugfs file.

Tested with QCA6174 SDIO with firmware WLAN.RMH.4.4.1-00007-QCARMSWP-1.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/mac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index ae84f8e4e7dd..0829582c0d50 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -6329,6 +6329,9 @@ static int ath10k_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	if (sta && sta->tdls)
 		ath10k_wmi_peer_set_param(ar, arvif->vdev_id, sta->addr,
 					  ar->wmi.peer_param->authorize, 1);
+	else if (sta && cmd == SET_KEY && (key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
+		ath10k_wmi_peer_set_param(ar, arvif->vdev_id, peer_addr,
+					  ar->wmi.peer_param->authorize, 1);
 
 exit:
 	mutex_unlock(&ar->conf_mutex);
-- 
2.23.0

