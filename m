Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA06C68BE1
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jul 2019 15:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730987AbfGONr1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Jul 2019 09:47:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:56228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730965AbfGONrZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Jul 2019 09:47:25 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E69D22086C;
        Mon, 15 Jul 2019 13:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563198444;
        bh=1G7KjC91RtjcBKsDM3By3WOUgi19PQ09IvvPLlwt2kk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RpsH7RTPH8FbiqVpJV9nlAjSIntdnlLJm7/m5atxTtNFsdsFWYPXv9FL3ko0ianpc
         aMPGgoWXoexOHlFZGdFER4cWtUZYELzzB1V7hBk2u5d9GTNn3P+xqWgQJeiI2z8z3C
         FpAsfW/zUadH8qPZysCOEerX537zgilBA+cx+hSs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Surabhi Vishnoi <svishnoi@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 009/249] ath10k: Fix the wrong value of enums for wmi tlv stats id
Date:   Mon, 15 Jul 2019 09:42:54 -0400
Message-Id: <20190715134655.4076-9-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715134655.4076-1-sashal@kernel.org>
References: <20190715134655.4076-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Surabhi Vishnoi <svishnoi@codeaurora.org>

[ Upstream commit 9280f4fc06f44d0b4dc9e831f72d97b3d7cd35d3 ]

The enum value for WMI_TLV_STAT_PDEV, WMI_TLV_STAT_VDEV
and WMI_TLV_STAT_PEER is wrong, due to which the vdev stats
are not received from firmware in wmi_update_stats event.

Fix the enum values for above stats to receive all stats
from firmware in WMI_TLV_UPDATE_STATS_EVENTID.

Tested HW: WCN3990
Tested FW: WLAN.HL.3.1-00784-QCAHLSWMTPLZ-1

Fixes: f40a307eb92c ("ath10k: Fill rx duration for each peer in fw_stats for WCN3990)
Signed-off-by: Surabhi Vishnoi <svishnoi@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath10k/wmi.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/wmi.h b/drivers/net/wireless/ath/ath10k/wmi.h
index e1c40bb69932..12f57f9adbba 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.h
+++ b/drivers/net/wireless/ath/ath10k/wmi.h
@@ -4535,9 +4535,10 @@ enum wmi_10_4_stats_id {
 };
 
 enum wmi_tlv_stats_id {
-	WMI_TLV_STAT_PDEV	= BIT(0),
-	WMI_TLV_STAT_VDEV	= BIT(1),
-	WMI_TLV_STAT_PEER	= BIT(2),
+	WMI_TLV_STAT_PEER	= BIT(0),
+	WMI_TLV_STAT_AP		= BIT(1),
+	WMI_TLV_STAT_PDEV	= BIT(2),
+	WMI_TLV_STAT_VDEV	= BIT(3),
 	WMI_TLV_STAT_PEER_EXTD  = BIT(10),
 };
 
-- 
2.20.1

