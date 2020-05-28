Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A0B1E6FB7
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 00:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437442AbgE1WzE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 18:55:04 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:19287 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2437437AbgE1WzA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 18:55:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590706499; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=pZOLNWoNcy+/84cJLc8UhFoFWbM0I48OqYFmbQRm4eM=; b=WneN6Nxd2wmlcVjs/9xRWgljl/6pE9XIraDThFNz9ymN0ubRWzQZ2+fpbAe90SO8lFt5W8R6
 8N83UcFm8llj+xfD7lMJToXken9LbC4mi4uny7ZqUqa5ZzX+LQ1gLnXNUoHr9upbg6GqLa1f
 3MHF6MBDz4J5SU5byKkikNMgf5A=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5ed0413cbf0e32d254c4b6bf (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 28 May 2020 22:54:52
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8B9D9C43391; Thu, 28 May 2020 22:54:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from msinada-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: msinada)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D0973C433C6;
        Thu, 28 May 2020 22:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D0973C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=msinada@codeaurora.org
From:   Muna Sinada <msinada@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Muna Sinada <msinada@codeaurora.org>
Subject: [PATCH] ath11k: reset trigger frame MAC padding duration
Date:   Thu, 28 May 2020 15:54:43 -0700
Message-Id: <1590706483-27609-1-git-send-email-msinada@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The value was 3 and it's reserved value. Corrected to maintain fw
defaults.

Signed-off-by: Muna Sinada <msinada@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 2a0cba47fc09..38310a217c58 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -3764,7 +3764,7 @@ static int ath11k_mac_copy_he_cap(struct ath11k *ar,
 		memcpy(he_cap_elem->phy_cap_info, band_cap->he_cap_phy_info,
 		       sizeof(he_cap_elem->phy_cap_info));
 
-		he_cap_elem->mac_cap_info[1] |=
+		he_cap_elem->mac_cap_info[1] &=
 			IEEE80211_HE_MAC_CAP1_TF_MAC_PAD_DUR_MASK;
 		he_cap_elem->phy_cap_info[4] &=
 			~IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_UNDER_80MHZ_MASK;
-- 
2.7.4

