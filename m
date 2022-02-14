Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B644B5628
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Feb 2022 17:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356364AbiBNQ3j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Feb 2022 11:29:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356348AbiBNQ3i (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Feb 2022 11:29:38 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AC960ABE
        for <linux-wireless@vger.kernel.org>; Mon, 14 Feb 2022 08:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=//ogqrnbTbG9qZuggmqzLjKcrKvsmNY+uCV+Rysxksw=; t=1644856170; x=1646065770; 
        b=bDw6v+nElLqKKkPC27dX1fE+A+Wqqi98eR/dh9A06o8Dw5eJi5500ZRrw+xkclOvQ+lNdZeFNLD
        A72kZFC3Gq9tWaH+YsGBKaK4/q15PXWTTzwEoTVqcxzZO+/mY0x7Vx9hyJyjwq7l9e4fV+dFB5Pe9
        5RMcTUqNlhyaBRAnnqgM1TGAMLgZsyn8Awog579dTORjz5/xa6eWJu0WPAo3WxQacLIibsUsMWE9r
        /RHhi4rszakfRigFkhxia1l9pIoPbvHoUzpkba4R89JH86IetX8h4W25CCgfM0KJR4bsCc/jjMxN+
        f2vG9fIZiDSmYY9i5xxjfGURfcflrIVaJvzA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nJeEB-0011jK-A6;
        Mon, 14 Feb 2022 17:29:27 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 1/3] ieee80211: add helper to check HE capability element size
Date:   Mon, 14 Feb 2022 17:29:21 +0100
Message-Id: <20220214172920.750bee9eaf37.Ie18359bd38143b7dc949078f10752413e6d36854@changeid>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This element has a very dynamic structure, create a small helper
function to validate its size. We're currently checking it in
mac80211 in a conversion function, but that's actually slightly
buggy.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/ieee80211.h | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index a2940a853783..dfc84680af82 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -9,7 +9,7 @@
  * Copyright (c) 2006, Michael Wu <flamingice@sourmilk.net>
  * Copyright (c) 2013 - 2014 Intel Mobile Communications GmbH
  * Copyright (c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright (c) 2018 - 2021 Intel Corporation
+ * Copyright (c) 2018 - 2022 Intel Corporation
  */
 
 #ifndef LINUX_IEEE80211_H
@@ -2338,6 +2338,29 @@ ieee80211_he_ppe_size(u8 ppe_thres_hdr, const u8 *phy_cap_info)
 	return n;
 }
 
+static inline bool ieee80211_he_capa_size_ok(const u8 *data, u8 len)
+{
+	const struct ieee80211_he_cap_elem *he_cap_ie_elem = (const void *)data;
+	u8 needed = sizeof(*he_cap_ie_elem);
+
+	if (len < needed)
+		return false;
+
+	needed += ieee80211_he_mcs_nss_size(he_cap_ie_elem);
+	if (len < needed)
+		return false;
+
+	if (he_cap_ie_elem->phy_cap_info[6] &
+			IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT) {
+		if (len < needed + 1)
+			return false;
+		needed += ieee80211_he_ppe_size(data[needed],
+						he_cap_ie_elem->phy_cap_info);
+	}
+
+	return len >= needed;
+}
+
 /* HE Operation defines */
 #define IEEE80211_HE_OPERATION_DFLT_PE_DURATION_MASK		0x00000007
 #define IEEE80211_HE_OPERATION_TWT_REQUIRED			0x00000008
-- 
2.34.1

