Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE05239DC6
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 05:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgHCDLb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Aug 2020 23:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbgHCDLX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Aug 2020 23:11:23 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A94C06174A
        for <linux-wireless@vger.kernel.org>; Sun,  2 Aug 2020 20:11:22 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a15so32764232wrh.10
        for <linux-wireless@vger.kernel.org>; Sun, 02 Aug 2020 20:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bjS/i84B6ZPWvX9FfR+k97So50sjazJcZS53gCPXCDQ=;
        b=TrwaFydTgwuNUGglRyHoaXlS2rlOPAyEUpd0gn/m4RgMYqZ8r0QgcMVug/fVoFM1dX
         TNQj0y4qsMCVhl3xuIk20SrLPK/i6RC3IfG0+/4VhsAJO0eEFs44klu7/VZo97flHz6/
         ymZDR+1By1n8Lrv6VO5c8aBfeCUDk+Qu4fY6u816UK4ynK4oXDZ6UBneovMhaDB5MFDQ
         rSAyl0V+PTb/j1i9hE0eX1akkaAL8QrPN/zYqfvS7bA+J9SbyqkS8xUMMOorbtTjGxw4
         Qbzw+iJc8sm0Jihqck6TGAfXUAmOndgPHWvn6uvecVCcaerD3ryPv11ttyf8WPBYa6w7
         iK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bjS/i84B6ZPWvX9FfR+k97So50sjazJcZS53gCPXCDQ=;
        b=jQDpncxs//hs2mKR3jcf0DDD4CcQG5geRL8L6wUMdEzp7bdOKuQHbTWQHjyIwMv7nK
         cPyhjXPmkZbi42ZmfbGzTl8mKhRRFYak+ffFJIfm2H5h3huw8iJZD77D81cyDL7HEfSv
         eFcpQ1O0Za00Ed8xbPQb5TXJo4b5ozHp/u3m1Z+eu1VUPCv/Ub3xIJnYKV9jx7kBB1Uh
         tsPXEfHuCo++VRZknZpnizt1GXrgj+A9HfijU00fQDnsp8VPQP4uQt5BQBDTkijh4dQk
         uyv7Z1kDxxef3rF6gVPnPaa3/aWbhLT5EVue0zZHIU9dNXa5clU2s9Q/d8z/yOmKTzw2
         hSWQ==
X-Gm-Message-State: AOAM532RERktX/DXRBO07KNJsKMMX75jImNvNBXwIZs99Vsbwv7xsmng
        irU2w8aAEnkCrXlQ5VCd8BkUaQ==
X-Google-Smtp-Source: ABdhPJwHzBw3eIHyTZ0a8oR8Y9U6FLhBp1yx7u+66SQHFJUP1gSTWjYTdz3ceRsOO0GqWqu8MWeoyw==
X-Received: by 2002:a5d:5446:: with SMTP id w6mr12836617wrv.127.1596424281602;
        Sun, 02 Aug 2020 20:11:21 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id q2sm21956857wro.8.2020.08.02.20.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 20:11:21 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, shawn.guo@linaro.org
Subject: [PATCH 33/36] wcn36xx: Set PHY into correct mode for 80MHz channel width
Date:   Mon,  3 Aug 2020 04:11:29 +0100
Message-Id: <20200803031132.1427063-34-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
References: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For the 80MHz channel we need to set the PHY mode to one of four PHY modes
that span the 80MHz range.

This patch latches the hw_value PHY field previously defined for 5GHz
channels directly to the parameter passed to the firmware.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 9a7e6f96f0b6..527da56a1386 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -1487,6 +1487,7 @@ int wcn36xx_smd_config_bss_v1(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 	struct wcn36xx_hal_config_bss_params_v1 *bss;
 	struct wcn36xx_hal_config_bss_params bss_v0;
 	struct wcn36xx_hal_config_sta_params_v1 *sta;
+	struct cfg80211_chan_def *chandef;
 	int ret;
 
 	msg_body = kzalloc(sizeof(*msg_body), GFP_KERNEL);
@@ -1529,7 +1530,13 @@ int wcn36xx_smd_config_bss_v1(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 	bss->dtim_period = bss_v0.dtim_period;
 	bss->tx_channel_width_set = bss_v0.tx_channel_width_set;
 	bss->oper_channel = bss_v0.oper_channel;
-	bss->ext_channel = bss_v0.ext_channel;
+
+	if (wcn->hw->conf.chandef.width == NL80211_CHAN_WIDTH_80) {
+		chandef = &wcn->hw->conf.chandef;
+		bss->ext_channel = HW_VALUE_PHY(chandef->chan->hw_value);
+	} else {
+		bss->ext_channel = bss_v0.ext_channel;
+	}
 
 	bss->reserved = bss_v0.reserved;
 
-- 
2.27.0

