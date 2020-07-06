Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519552156C4
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2020 13:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbgGFLwj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Jul 2020 07:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729017AbgGFLwd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Jul 2020 07:52:33 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73560C08C5E0
        for <linux-wireless@vger.kernel.org>; Mon,  6 Jul 2020 04:52:33 -0700 (PDT)
Received: from [134.101.131.141] (helo=localhost.localdomain)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1jsPfj-000600-5T; Mon, 06 Jul 2020 13:52:31 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH V2 09/10] ath11k: set beacon tx mode
Date:   Mon,  6 Jul 2020 13:52:18 +0200
Message-Id: <20200706115219.663650-9-john@phrozen.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200706115219.663650-1-john@phrozen.org>
References: <20200706115219.663650-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The beacon mode needs to be set to bursting when we have multiple bssid
enabled.

Signed-off-by: John Crispin <john@phrozen.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 65a77f6c27e1..a07773fd5971 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1791,6 +1791,9 @@ static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_BEACON) {
 		param_id = WMI_PDEV_PARAM_BEACON_TX_MODE;
 		param_value = WMI_BEACON_STAGGERED_MODE;
+		if (ieee80211_get_multi_bssid_mode(arvif->vif) !=
+		    NL80211_MULTIPLE_BSSID_LEGACY)
+			param_value = WMI_BEACON_BURST_MODE;
 		ret = ath11k_wmi_pdev_set_param(ar, param_id,
 						param_value, ar->pdev->pdev_id);
 		if (ret)
-- 
2.25.1

