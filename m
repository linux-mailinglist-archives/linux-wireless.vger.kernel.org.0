Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE4784501FB
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Nov 2021 11:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237418AbhKOKI2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Nov 2021 05:08:28 -0500
Received: from dvalin.narfation.org ([213.160.73.56]:56288 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237563AbhKOKIU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Nov 2021 05:08:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1636970723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z1RAl74RSYfclV4BpJtdeHfE9dPo62tsTx2/FvVvZCw=;
        b=pi7+u6YyE36e8SuvOZoyskLEgnLCLvocI5zh3rr0TbML/7Rnc5OIB5e3x8vuzLYRuT+jPS
        GoSMYL1b3rXhOl6hbCHpAuKnvOCa0wwFvMnAvP4zwohaFfdFaA66xKtTXsg3PZnNxVM3hT
        3mAYJjedsaXdroelxlHwo9CBxljCFIg=
From:   Sven Eckelmann <sven@narfation.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Karthikeyan Kathirvel <kathirve@codeaurora.org>,
        Venkateswara Naralasetty <vnaralas@codeaurora.org>,
        Sven Eckelmann <sven@narfation.org>
Subject: [PATCH v2 2/2] ath11k: reset RSN/WPA present state for open BSS
Date:   Mon, 15 Nov 2021 11:04:41 +0100
Message-Id: <20211115100441.33771-2-sven@narfation.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211115100441.33771-1-sven@narfation.org>
References: <20211115100441.33771-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Karthikeyan Kathirvel <kathirve@codeaurora.org>

The ath11k driver is caching the information about RSN/WPA IE in the
configured beacon template. The cached information is used during
associations to figure out whether 4-way PKT/2-way GTK peer flags need to
be set or not.

But the code never cleared the state when no such IE was found. This can
for example happen when moving from an WPA/RSN to an open setup. The
(seemingly connected) peer was then not able to communicate over the
link because the firmware assumed a different (encryption enabled) state
for the peer.

Tested-on: IPQ6018 hw1.0 AHB WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1

Fixes: 01e34233c645 ("ath11k: fix wmi peer flags in peer assoc command")
Cc: Venkateswara Naralasetty <vnaralas@codeaurora.org>
Reported-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Karthikeyan Kathirvel <kathirve@codeaurora.org>
[sven@narfation.org: split into separate patches, clean up commit message]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2:
* add new patch to really fix the peer handling of the fw after PSK -> open
  switch

 drivers/net/wireless/ath/ath11k/mac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index cdee7545e876..9ed7eb09bdb7 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1137,11 +1137,15 @@ static int ath11k_mac_setup_bcn_tmpl(struct ath11k_vif *arvif)
 
 	if (cfg80211_find_ie(WLAN_EID_RSN, ies, (skb_tail_pointer(bcn) - ies)))
 		arvif->rsnie_present = true;
+	else
+		arvif->rsnie_present = false;
 
 	if (cfg80211_find_vendor_ie(WLAN_OUI_MICROSOFT,
 				    WLAN_OUI_TYPE_MICROSOFT_WPA,
 				    ies, (skb_tail_pointer(bcn) - ies)))
 		arvif->wpaie_present = true;
+	else
+		arvif->wpaie_present = false;
 
 	ret = ath11k_wmi_bcn_tmpl(ar, arvif->vdev_id, &offs, bcn);
 
-- 
2.30.2

