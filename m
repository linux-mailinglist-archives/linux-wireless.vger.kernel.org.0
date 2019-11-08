Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8D45F480E
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2019 12:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391319AbfKHLqT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Nov 2019 06:46:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:33996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391315AbfKHLqT (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Nov 2019 06:46:19 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D68B4222CF;
        Fri,  8 Nov 2019 11:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213578;
        bh=Kx5WbgmCL5mfO8gSfx6FdAr1u5gtEdfOWa2t00s3loc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q7pWi4Y9DSTwYtKVqX9c6ZUEsNjrDDQwQ+sdPR49XnQrOWi99g9v/+mjGCxRR0qgV
         VChFq2oHPd7XIdPAcJYAAAjhHeRPmlSzfUYjIY5LcEmRLczGlW04l1gFTKXmLTsWlZ
         LbicP1A/Rot/S2N+OPCAt3axhkWnQcFXecyjlikw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Erik Stromdahl <erik.stromdahl@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 24/64] ath10k: wmi: disable softirq's while calling ieee80211_rx
Date:   Fri,  8 Nov 2019 06:45:05 -0500
Message-Id: <20191108114545.15351-24-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108114545.15351-1-sashal@kernel.org>
References: <20191108114545.15351-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Erik Stromdahl <erik.stromdahl@gmail.com>

[ Upstream commit 37f62c0d5822f631b786b29a1b1069ab714d1a28 ]

This is done in order not to trig the below warning in
ieee80211_rx_napi:

WARN_ON_ONCE(softirq_count() == 0);

ieee80211_rx_napi requires that softirq's are disabled during
execution.

The High latency bus drivers (SDIO and USB) sometimes call the wmi
ep_rx_complete callback from non softirq context, resulting in a trigger
of the above warning.

Calling ieee80211_rx_ni with softirq's already disabled (e.g., from
softirq context) should be safe as the local_bh_disable and
local_bh_enable functions (called from ieee80211_rx_ni) are fully
reentrant.

Signed-off-by: Erik Stromdahl <erik.stromdahl@gmail.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath10k/wmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index bbfe7be214e12..c208fed048554 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -2384,7 +2384,8 @@ int ath10k_wmi_event_mgmt_rx(struct ath10k *ar, struct sk_buff *skb)
 		   status->freq, status->band, status->signal,
 		   status->rate_idx);
 
-	ieee80211_rx(ar->hw, skb);
+	ieee80211_rx_ni(ar->hw, skb);
+
 	return 0;
 }
 
-- 
2.20.1

