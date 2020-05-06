Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF1D61C6E4F
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2020 12:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgEFKYs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 May 2020 06:24:48 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:55321 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726354AbgEFKYs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 May 2020 06:24:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588760687; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=XndLN8jaaSAJEDCCR9V4qqYQ7R6KFmJOO4so8dJk5/4=; b=U2CZNUW6mR6jKbsaIENIrMuWJHibVO1OpHnthz4KEn8M0aFnARrBjfO+QNyMwXxKc61G8R7A
 W+Y1R56tOSo04M3oYm+V8t4bdLV2bPF36nOHtaenetdhNB1gLELSJnDYu01leAybvPwfntym
 Zz0TV9/Wtqs1UQZCWQI3fs9SIoM=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb2906f.7fd1ce5a2d18-smtp-out-n05;
 Wed, 06 May 2020 10:24:47 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 41EFFC432C2; Wed,  6 May 2020 10:24:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from pradeepc2-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pradeepc)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 98A24C433D2;
        Wed,  6 May 2020 10:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 98A24C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pradeepc@codeaurora.org
From:   Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Subject: [PATCH] ieee80211: Fix incorrect mask for default PE duration
Date:   Wed,  6 May 2020 03:24:30 -0700
Message-Id: <20200506102430.5153-1-pradeepc@codeaurora.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes bitmask for HE opration's default PE duration.

Fixes: daa5b83513a7 ("mac80211: update HE operation fields to D3.0")
Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
---
 include/linux/ieee80211.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 2a92f498be1b..f31d2c79f204 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2110,7 +2110,7 @@ ieee80211_he_ppe_size(u8 ppe_thres_hdr, const u8 *phy_cap_info)
 }
 
 /* HE Operation defines */
-#define IEEE80211_HE_OPERATION_DFLT_PE_DURATION_MASK		0x00000003
+#define IEEE80211_HE_OPERATION_DFLT_PE_DURATION_MASK		0x00000007
 #define IEEE80211_HE_OPERATION_TWT_REQUIRED			0x00000008
 #define IEEE80211_HE_OPERATION_RTS_THRESHOLD_MASK		0x00003ff0
 #define IEEE80211_HE_OPERATION_RTS_THRESHOLD_OFFSET		4
-- 
2.17.1
