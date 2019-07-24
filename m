Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A255733FB
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2019 18:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387464AbfGXQeZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Jul 2019 12:34:25 -0400
Received: from dvalin.narfation.org ([213.160.73.56]:39158 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387420AbfGXQeY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Jul 2019 12:34:24 -0400
Received: from sven-desktop.home.narfation.org (p200300C5970DABFC00000000000002FB.dip0.t-ipconnect.de [IPv6:2003:c5:970d:abfc::2fb])
        by dvalin.narfation.org (Postfix) with ESMTPSA id D32982030E;
        Wed, 24 Jul 2019 16:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1563986061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vz/5vCtiAvHspi/nhz3fkXP7PHD0sCJGMqDl7QlKZQs=;
        b=m6CGRJ6oY+HTKIU6UTZi19tQZE1iGESe3tVq3ToxwaCnH6axor/KNg4F61P/KzWaFNJJNB
        ZSpYTvq+yEiVOf2a+FaHdndIZPj8XVKckQq+B/F9hAuf3z0p86tLggrnnU8ad+dtThlOi+
        AX8CO8zL3FV0F84547dsmaadBRnKtwQ=
From:   Sven Eckelmann <sven@narfation.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, Sven Eckelmann <seckelmann@datto.com>
Subject: [PATCH v5 4/4] ath11k: Disable SU support in meshpoint mode
Date:   Wed, 24 Jul 2019 18:33:59 +0200
Message-Id: <20190724163359.3507-5-sven@narfation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190724163359.3507-1-sven@narfation.org>
References: <20190724163359.3507-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1563986061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vz/5vCtiAvHspi/nhz3fkXP7PHD0sCJGMqDl7QlKZQs=;
        b=owgORkZZPL/Nzt5oYfX6yoZ2m4RjR3Hg0vcFRBPwPuPGdOqYCmWEcYNrvqnS/TXudZg2FW
        cgd59ZQ+2Oq1xO/ztb6V9yY9A66blifhCMtNd2VJcc3OPZgxlbDrNgh9e8Px99cXJbjduk
        Xsr59+y+sNCbraPw7zoeKPGyCdIZg8U=
ARC-Seal: i=1; s=20121; d=narfation.org; t=1563986061; a=rsa-sha256;
        cv=none;
        b=XCmQeqUuWJco1yCfGQXgR9G0YdPmauJNW8oaKUl3zQxms9T2kgrDbVITolSSLJoXMw7G3v
        v3q7x0lRwwbUf69Rck9vF4uuHtQKQYshacVSaOSeAbMyWhhVDbPCvVL9HjoUCKaTDlcJbY
        ma9U1R5Qfzg0C6YaeHN8JHlH4vUvXlI=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sven smtp.mailfrom=sven@narfation.org
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sven Eckelmann <seckelmann@datto.com>

The firmware WLAN.HK.2.1.0.1-00629-QCAHKSWPL_SILICONZ-1 often stops sending
data on 5GHz when SU support is advertised. A simple throughput benchmark
will end up at only a couple hundred kilobytes per second (when finishing
at all).

Disabling SU related flags works around this problem and allowed a maximum
throughput of ~450 MBit/s in a simple test setup with an HK01 over air.

Signed-off-by: Sven Eckelmann <seckelmann@datto.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 4317608ff822..29964185b0a1 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -3290,16 +3290,24 @@ ath11k_mac_filter_he_cap_mesh(struct ieee80211_he_cap_elem *he_cap_elem)
 
 	m = IEEE80211_HE_PHY_CAP3_RX_HE_MU_PPDU_FROM_NON_AP_STA |
 	    IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_TX_MASK |
-	    IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_RX_MASK;
+	    IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_RX_MASK |
+	    IEEE80211_HE_PHY_CAP3_SU_BEAMFORMER;
 	he_cap_elem->phy_cap_info[3] &= ~m;
 
-	m = IEEE80211_HE_PHY_CAP4_MU_BEAMFORMER;
+	m = IEEE80211_HE_PHY_CAP4_SU_BEAMFORMEE |
+	    IEEE80211_HE_PHY_CAP4_MU_BEAMFORMER |
+	    IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_UNDER_80MHZ_MASK |
+	    IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_ABOVE_80MHZ_MASK;
 	he_cap_elem->phy_cap_info[4] &= ~m;
 
-	m = IEEE80211_HE_PHY_CAP5_NG16_MU_FEEDBACK;
+	m = IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_UNDER_80MHZ_MASK |
+	    IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_ABOVE_80MHZ_MASK |
+	    IEEE80211_HE_PHY_CAP5_NG16_SU_FEEDBACK |
+	    IEEE80211_HE_PHY_CAP5_NG16_MU_FEEDBACK;
 	he_cap_elem->phy_cap_info[5] &= ~m;
 
 	m = IEEE80211_HE_PHY_CAP6_CODEBOOK_SIZE_75_MU |
+	    IEEE80211_HE_PHY_CAP6_TRIG_SU_BEAMFORMER_FB |
 	    IEEE80211_HE_PHY_CAP6_TRIG_MU_BEAMFORMER_FB |
 	    IEEE80211_HE_PHY_CAP6_TRIG_CQI_FB |
 	    IEEE80211_HE_PHY_CAP6_PARTIAL_BANDWIDTH_DL_MUMIMO;
@@ -3307,6 +3315,7 @@ ath11k_mac_filter_he_cap_mesh(struct ieee80211_he_cap_elem *he_cap_elem)
 
 	m = IEEE80211_HE_PHY_CAP7_SRP_BASED_SR |
 	    IEEE80211_HE_PHY_CAP7_POWER_BOOST_FACTOR_AR |
+	    IEEE80211_HE_PHY_CAP7_HE_SU_MU_PPDU_4XLTF_AND_08_US_GI |
 	    IEEE80211_HE_PHY_CAP7_STBC_TX_ABOVE_80MHZ |
 	    IEEE80211_HE_PHY_CAP7_STBC_RX_ABOVE_80MHZ;
 	he_cap_elem->phy_cap_info[7] &= ~m;
-- 
2.20.1

