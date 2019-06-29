Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08C145ADA1
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jun 2019 00:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfF2WSr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 29 Jun 2019 18:18:47 -0400
Received: from 8.mo4.mail-out.ovh.net ([188.165.33.112]:58330 "EHLO
        8.mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbfF2WSq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 29 Jun 2019 18:18:46 -0400
Received: from player157.ha.ovh.net (unknown [10.109.146.175])
        by mo4.mail-out.ovh.net (Postfix) with ESMTP id 93D9D1F92DC
        for <linux-wireless@vger.kernel.org>; Sat, 29 Jun 2019 21:50:38 +0200 (CEST)
Received: from awhome.eu (p579AA414.dip0.t-ipconnect.de [87.154.164.20])
        (Authenticated sender: postmaster@awhome.eu)
        by player157.ha.ovh.net (Postfix) with ESMTPSA id 3D8017539FA6;
        Sat, 29 Jun 2019 19:50:37 +0000 (UTC)
From:   Alexander Wetzel <alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1561837836;
        bh=mT0vpkafSPtm0BZNNzGt353XGzdRLYh8ynihsR4R3R4=;
        h=From:To:Cc:Subject:Date;
        b=E7PQj7FPygvJ6sZ62ZjjNbHnvh0O5R9julm8pQTyGvSZVBBLlZSMALQBg3s5T1CAz
         tYim7u2YyxdZLuVSZHedRmC7gyqcZnX6dh/LvAIHaRD1Acq+v/C63Vmxm/gwQCbtds
         NkFTlQ8+ujX2eFTNB2oolk3gY19KC4+zgP831ms8=
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Alexander Wetzel <alexander@wetzel-home.de>
Subject: [PATCH 1/4] mac80211_hwsim: Extended Key ID API update
Date:   Sat, 29 Jun 2019 21:50:12 +0200
Message-Id: <20190629195015.19680-1-alexander@wetzel-home.de>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 13911056303217056967
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrvddvgddugeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenuc
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Prepare hwsim Extended Key ID support for a mac80211 API change.

The mac80211 flag IEEE80211_HW_EXT_KEY_ID_NATIVE is being replaced by
NL80211_EXT_FEATURE_EXT_KEY_ID which only must be set by drivers when
they support HW crypto.

This reverts commit cfe7007a9b4cea9c4a0f7d4192c776c62f31869e.

Signed-off-by: Alexander Wetzel <alexander@wetzel-home.de>
---
 drivers/net/wireless/mac80211_hwsim.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index d396a33bbc9c..26cbb5b5d7cd 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -2805,12 +2805,6 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 	ieee80211_hw_set(hw, SIGNAL_DBM);
 	ieee80211_hw_set(hw, SUPPORTS_PS);
 	ieee80211_hw_set(hw, TDLS_WIDER_BW);
-
-	/* We only have SW crypto and only implement the A-MPDU API
-	 * (but don't really build A-MPDUs) so can have extended key
-	 * support
-	 */
-	ieee80211_hw_set(hw, EXT_KEY_ID_NATIVE);
 	if (rctbl)
 		ieee80211_hw_set(hw, SUPPORTS_RC_TABLE);
 	ieee80211_hw_set(hw, SUPPORTS_MULTI_BSSID);
-- 
2.22.0

