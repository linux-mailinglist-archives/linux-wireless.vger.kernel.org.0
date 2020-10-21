Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8374294E3A
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Oct 2020 16:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442512AbgJUOGK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Oct 2020 10:06:10 -0400
Received: from dvalin.narfation.org ([213.160.73.56]:48850 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442486AbgJUOGK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Oct 2020 10:06:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1603289167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0IVOM5jhr+HBlD6Kb4Smea9Li8jHzw/ys+VyIk3sxng=;
        b=oHWuM0bbTblOC/VSSUaz18CmtM5kJBoyHGdj3SlMylyVfbRmy/pbuiMtQHnGByEB/hrIzx
        q8Ei5E+yk7oqptyf2Kk42eZve5k4XSnEI4LubH6ORiDRpo/r+JTsTGkActHH5Vdv+RL+Hr
        sB+unNBVZcgg8POsE/CpkhJIVMODOGY=
From:   Sven Eckelmann <sven@narfation.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, Sven Eckelmann <sven@narfation.org>
Subject: [PATCH] ath11k: Initialize complete alpha2 for regulatory change
Date:   Wed, 21 Oct 2020 16:05:55 +0200
Message-Id: <20201021140555.4114715-1-sven@narfation.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The function ath11k_wmi_send_init_country_cmd is taking 3 byte from alpha2
of the structure wmi_init_country_params. But the function
ath11k_reg_notifier is only initializing 2 bytes. The third byte is
therefore always an uninitialized value.

The command can happen to look like

  0c 00 87 02 01 00 00 00 00 00 00 00 43 41 f8 00

instead of

  0c 00 87 02 01 00 00 00 00 00 00 00 43 41 00 00

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 drivers/net/wireless/ath/ath11k/reg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath11k/reg.c b/drivers/net/wireless/ath/ath11k/reg.c
index f6a1f0352989..83f75f8855eb 100644
--- a/drivers/net/wireless/ath/ath11k/reg.c
+++ b/drivers/net/wireless/ath/ath11k/reg.c
@@ -80,6 +80,7 @@ ath11k_reg_notifier(struct wiphy *wiphy, struct regulatory_request *request)
 	 */
 	init_country_param.flags = ALPHA_IS_SET;
 	memcpy(&init_country_param.cc_info.alpha2, request->alpha2, 2);
+	init_country_param.cc_info.alpha2[2] = 0;
 
 	ret = ath11k_wmi_send_init_country_cmd(ar, init_country_param);
 	if (ret)
-- 
2.28.0

