Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC1D1D7EF2
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2020 18:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbgERQoq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 May 2020 12:44:46 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:47080 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728295AbgERQop (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 May 2020 12:44:45 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589820285; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=ycCKIDoG3IvItA+Cb/UrekRqkKVo+BwTizM7veJ2H14=; b=FRYCXBpr0CWtupkcPHJnsNQixEejDVaHmhzPzNNDiCT/zujaJWpeB+WnTKrjRh9CWAAQeBEt
 QvMwRYPB8pFOPk9s4IwpZ7K6xHaEVPIWSqn/ScwNRZ/sJYKHko3ml7eYHelFil3FbkLDoHO9
 qMWbwDWCk51sGCy6mI7eOf724qY=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ec2bb72.7fbb84e3f730-smtp-out-n04;
 Mon, 18 May 2020 16:44:34 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8EC6BC44792; Mon, 18 May 2020 16:44:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from pradeepc2-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pradeepc)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BE466C44799;
        Mon, 18 May 2020 16:44:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BE466C44799
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pradeepc@codeaurora.org
From:   Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Subject: [PATCH 2/9] ath11k: add 6G frequency list supported by driver
Date:   Mon, 18 May 2020 09:44:17 -0700
Message-Id: <20200518164424.29497-3-pradeepc@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200518164424.29497-1-pradeepc@codeaurora.org>
References: <20200518164424.29497-1-pradeepc@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch adds support for 6GHz frequency listing.

Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 71 +++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 36882562b976..f699e882949b 100644
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
+	CHAN6G(1, 5945, 0),
+	CHAN6G(5, 5965, 0),
+	CHAN6G(9, 5985, 0),
+	CHAN6G(13, 6005, 0),
+	CHAN6G(17, 6025, 0),
+	CHAN6G(21, 6045, 0),
+	CHAN6G(25, 6065, 0),
+	CHAN6G(29, 6085, 0),
+	CHAN6G(33, 6105, 0),
+	CHAN6G(37, 6125, 0),
+	CHAN6G(41, 6145, 0),
+	CHAN6G(45, 6165, 0),
+	CHAN6G(49, 6185, 0),
+	CHAN6G(53, 6205, 0),
+	CHAN6G(57, 6225, 0),
+	CHAN6G(61, 6245, 0),
+	CHAN6G(65, 6265, 0),
+	CHAN6G(69, 6285, 0),
+	CHAN6G(73, 6305, 0),
+	CHAN6G(77, 6325, 0),
+	CHAN6G(81, 6345, 0),
+	CHAN6G(85, 6365, 0),
+	CHAN6G(89, 6385, 0),
+	CHAN6G(93, 6405, 0),
+	CHAN6G(97, 6425, 0),
+	CHAN6G(101, 6445, 0),
+	CHAN6G(105, 6465, 0),
+	CHAN6G(109, 6485, 0),
+	CHAN6G(113, 6505, 0),
+	CHAN6G(117, 6525, 0),
+	CHAN6G(121, 6545, 0),
+	CHAN6G(125, 6565, 0),
+	CHAN6G(129, 6585, 0),
+	CHAN6G(133, 6605, 0),
+	CHAN6G(137, 6625, 0),
+	CHAN6G(141, 6645, 0),
+	CHAN6G(145, 6665, 0),
+	CHAN6G(149, 6685, 0),
+	CHAN6G(153, 6705, 0),
+	CHAN6G(157, 6725, 0),
+	CHAN6G(161, 6745, 0),
+	CHAN6G(165, 6765, 0),
+	CHAN6G(169, 6785, 0),
+	CHAN6G(173, 6805, 0),
+	CHAN6G(177, 6825, 0),
+	CHAN6G(181, 6845, 0),
+	CHAN6G(185, 6865, 0),
+	CHAN6G(189, 6885, 0),
+	CHAN6G(193, 6905, 0),
+	CHAN6G(197, 6925, 0),
+	CHAN6G(201, 6945, 0),
+	CHAN6G(205, 6965, 0),
+	CHAN6G(209, 6985, 0),
+	CHAN6G(213, 7005, 0),
+	CHAN6G(217, 7025, 0),
+	CHAN6G(221, 7045, 0),
+	CHAN6G(225, 7065, 0),
+	CHAN6G(229, 7085, 0),
+	CHAN6G(233, 7105, 0),
+};
+
 static struct ieee80211_rate ath11k_legacy_rates[] = {
 	{ .bitrate = 10,
 	  .hw_value = ATH11K_HW_RATE_CCK_LP_1M },
-- 
2.17.1
