Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708041E32DE
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2020 00:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390102AbgEZWrj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 May 2020 18:47:39 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:12951 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389755AbgEZWrj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 May 2020 18:47:39 -0400
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 May 2020 18:47:38 EDT
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590533258; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=99bKULHbwzT+U6BJiAr5fPMJHTmE3qJacDDBNKNHriY=; b=TlRYDApz39Pzdot81qyk1kkCDp/eez5fpjbdK8tU/GBf/FijqtYisNQaV4L6hTgDaTZd7Gr+
 fdHrtkihPoPee6RzzsMjGopYpYmXRlvGEJivAWD5wktyLi+zvJe2u4W7+OYjXofGjghU6FwO
 R7SPCZg6suAOIWaiW64r7Juz308=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5ecd9b5ec28b2cdd982a2909 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 26 May 2020 22:42:38
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E6527C4339C; Tue, 26 May 2020 22:42:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from pradeepc2-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pradeepc)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EA57AC43391;
        Tue, 26 May 2020 22:42:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EA57AC43391
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pradeepc@codeaurora.org
From:   Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Subject: [PATCH v3 2/9] ath11k: add 6G frequency list supported by driver
Date:   Tue, 26 May 2020 15:42:10 -0700
Message-Id: <20200526224217.11119-3-pradeepc@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200526224217.11119-1-pradeepc@codeaurora.org>
References: <20200526224217.11119-1-pradeepc@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch adds support for 6GHz frequency listing.

Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
---
v3:
 - update channel list as defined in IEEE P802.11ax/D6.1

 drivers/net/wireless/ath/ath11k/mac.c | 71 +++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 36882562b976..37a7df359f67 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -33,6 +33,15 @@
 	.max_power              = 30, \
 }
 
+#define CHAN6G(_channel, _freq, _flags) { \
+	.band                   = NL80211_BAND_6GHZ, \
+	.hw_value               = (_channel), \
+	.center_freq            = (_freq), \
+	.flags                  = (_flags), \
+	.max_antenna_gain       = 0, \
+	.max_power              = 30, \
+}
+
 /* frame mode values are mapped as per enum ath11k_hw_txrx_mode */
 static unsigned int ath11k_frame_mode = ATH11K_HW_TXRX_NATIVE_WIFI;
 module_param_named(frame_mode, ath11k_frame_mode, uint, 0644);
@@ -86,6 +95,68 @@ static const struct ieee80211_channel ath11k_5ghz_channels[] = {
 	CHAN5G(173, 5865, 0),
 };
 
+static const struct ieee80211_channel ath11k_6ghz_channels[] = {
+	CHAN6G(1, 5955, 0),
+	CHAN6G(5, 5975, 0),
+	CHAN6G(9, 5995, 0),
+	CHAN6G(13, 6015, 0),
+	CHAN6G(17, 6035, 0),
+	CHAN6G(21, 6055, 0),
+	CHAN6G(25, 6075, 0),
+	CHAN6G(29, 6095, 0),
+	CHAN6G(33, 6115, 0),
+	CHAN6G(37, 6135, 0),
+	CHAN6G(41, 6155, 0),
+	CHAN6G(45, 6175, 0),
+	CHAN6G(49, 6195, 0),
+	CHAN6G(53, 6215, 0),
+	CHAN6G(57, 6235, 0),
+	CHAN6G(61, 6255, 0),
+	CHAN6G(65, 6275, 0),
+	CHAN6G(69, 6295, 0),
+	CHAN6G(73, 6315, 0),
+	CHAN6G(77, 6335, 0),
+	CHAN6G(81, 6355, 0),
+	CHAN6G(85, 6375, 0),
+	CHAN6G(89, 6395, 0),
+	CHAN6G(93, 6415, 0),
+	CHAN6G(97, 6435, 0),
+	CHAN6G(101, 6455, 0),
+	CHAN6G(105, 6475, 0),
+	CHAN6G(109, 6495, 0),
+	CHAN6G(113, 6515, 0),
+	CHAN6G(117, 6535, 0),
+	CHAN6G(121, 6555, 0),
+	CHAN6G(125, 6575, 0),
+	CHAN6G(129, 6595, 0),
+	CHAN6G(133, 6615, 0),
+	CHAN6G(137, 6635, 0),
+	CHAN6G(141, 6655, 0),
+	CHAN6G(145, 6675, 0),
+	CHAN6G(149, 6695, 0),
+	CHAN6G(153, 6715, 0),
+	CHAN6G(157, 6735, 0),
+	CHAN6G(161, 6755, 0),
+	CHAN6G(165, 6775, 0),
+	CHAN6G(169, 6795, 0),
+	CHAN6G(173, 6815, 0),
+	CHAN6G(177, 6835, 0),
+	CHAN6G(181, 6855, 0),
+	CHAN6G(185, 6875, 0),
+	CHAN6G(189, 6895, 0),
+	CHAN6G(193, 6915, 0),
+	CHAN6G(197, 6935, 0),
+	CHAN6G(201, 6955, 0),
+	CHAN6G(205, 6975, 0),
+	CHAN6G(209, 6995, 0),
+	CHAN6G(213, 7015, 0),
+	CHAN6G(217, 7035, 0),
+	CHAN6G(221, 7055, 0),
+	CHAN6G(225, 7075, 0),
+	CHAN6G(229, 7095, 0),
+	CHAN6G(233, 7115, 0),
+};
+
 static struct ieee80211_rate ath11k_legacy_rates[] = {
 	{ .bitrate = 10,
 	  .hw_value = ATH11K_HW_RATE_CCK_LP_1M },
-- 
2.17.1

