Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E330B409B4B
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Sep 2021 19:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbhIMR4s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Sep 2021 13:56:48 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:29696 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230238AbhIMR4r (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Sep 2021 13:56:47 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1631555731; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=x4JYpC4AekhJRX+KOkQHy1gLl2sQLOisRGN89DCrN/I=; b=wGX4u3tAc+2f0uEb+Ip06mOecW+2Gxqei2oghPdo5QgdKYhG78GYb2W+DRh8mvF4NCayrZ7Y
 cO+Jr/ksXw4HZa4b6lu8qvPJLnxrulJXFrITdcFMv2eSjUoaKopcMNH/BVu48E6JKK+T2iX0
 rQAGhQlRwZNY/S/ZU7EuWpyX28Q=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 613f9091e0f78151d6c1bc16 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 13 Sep 2021 17:55:29
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C3B01C4360C; Mon, 13 Sep 2021 17:55:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-72-211-nat.elisa-mobile.fi [85.76.72.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D89E3C4338F;
        Mon, 13 Sep 2021 17:55:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org D89E3C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 1/3] ieee80211: Add new A-MPDU factor macro for HE 6 GHz peer caps
Date:   Mon, 13 Sep 2021 20:55:08 +0300
Message-Id: <20210913175510.193005-1-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>

Add IEEE80211_HE_6GHZ_MAX_AMPDU_FACTOR as per IEEE Std 802.11ax-2021,
9.4.2.263 to use for peer max A-MPDU factor in 6 GHz band.

Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 include/linux/ieee80211.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 694264503119..a1a7eda35cb5 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2084,6 +2084,7 @@ int ieee80211_get_vht_max_nss(struct ieee80211_vht_cap *cap,
 
 #define IEEE80211_HE_VHT_MAX_AMPDU_FACTOR	20
 #define IEEE80211_HE_HT_MAX_AMPDU_FACTOR	16
+#define IEEE80211_HE_6GHZ_MAX_AMPDU_FACTOR	13
 
 /* 802.11ax HE PHY capabilities */
 #define IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G		0x02
-- 
2.25.1

