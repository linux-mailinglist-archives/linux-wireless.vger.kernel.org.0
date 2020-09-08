Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90120261A41
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 20:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731558AbgIHSeV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 14:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731409AbgIHSdS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 14:33:18 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B030CC0617BE
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 11:24:34 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id w5so209131wrp.8
        for <linux-wireless@vger.kernel.org>; Tue, 08 Sep 2020 11:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IRlqLg9pl8OW4kRzEvgaiZLGm2xa7Kg6ZD9o++l3c7g=;
        b=l8+7oeDru28u2/5tvVbKvdcQgatZk1l5v2+keKRJMkc3yev3c9OtYmO+gq4gF3L6RP
         zcy//DAVaJJ7Zo+Z0YyuS9u7Ds9xAMNQPbQdXHMkPYuiOnO0Jxm9CVkYdS0lU4qBNdYP
         4wHhB63oHnZfQWitn4s5KA7yPZe3hIs4BG3iY0xHu5H7tsfrZli0qiMcS3DG3UQbW25o
         d5a9Mpw7r6Lg2k3ipiOoOq2nDovJmYGWpHLngoaAhVPFOIZNiVSa+b6/MppfyZZZYplm
         F9kXe3uSxR1rCFHhoJjS4iAaz+y5W8dP1RnST4lh6yxixDDbxYOPLZNRsTqm6J+mzlOd
         5Kuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IRlqLg9pl8OW4kRzEvgaiZLGm2xa7Kg6ZD9o++l3c7g=;
        b=XUl1oX23Psg9DMqRCeYSbfpf+934Kxw3yr91n775CgXqh8YwQIwypoXFEkxI8tqBMi
         BEljsuT6Lu96cQ7XnVhZOqqgN9rAF36k3ZMXMQ8muYHlIKcd30duPguCKcthAl5ymCTj
         /0pxjZDcurTbZWOVLb6XSixK3WkBb3t8kN9kmuZPIEjZ8nydaCLod4NBtn39HTdSsq68
         +XL5m59FEkjBsVuI+tbCVMNTsXt9TSnyyllRNteD3qxWZ3xDqzfxt6O7JZcKrOXktGUe
         mY+I2zw5RhgNUyQCEZ1qBjxjgUNHWaQccV4pq4jYAwNQSVr8xDXzU7Ml38V6tx1ChOGB
         8MEA==
X-Gm-Message-State: AOAM530rnivnaXDVxu4L3DfbSbw2X0z+v4VpWnAcZuN4jtynUjvmyi/L
        gALuOTe7L4a+M1088BfPJu2MHHwwDDIfbg==
X-Google-Smtp-Source: ABdhPJzfUEwaMBYFy74pHISh9NGqprMivrTNbRxLwAq2hDVoRA9JiaDtX4nkYspwQNPaPL80oUe3Qg==
X-Received: by 2002:adf:ed12:: with SMTP id a18mr989961wro.178.1599589473429;
        Tue, 08 Sep 2020 11:24:33 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id f14sm352447wrv.72.2020.09.08.11.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 11:24:32 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v3 5/5] wcn36xx: Set PHY into correct mode for 80MHz channel width
Date:   Tue,  8 Sep 2020 19:25:14 +0100
Message-Id: <20200908182514.2870410-6-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200908182514.2870410-1-bryan.odonoghue@linaro.org>
References: <20200908182514.2870410-1-bryan.odonoghue@linaro.org>
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
index 1496566ecb31..04822edaf631 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -1485,6 +1485,7 @@ static int wcn36xx_smd_config_bss_v1(struct wcn36xx *wcn,
 	struct wcn36xx_hal_config_bss_params_v1 *bss;
 	struct wcn36xx_hal_config_bss_params bss_v0;
 	struct wcn36xx_hal_config_sta_params_v1 *sta;
+	struct cfg80211_chan_def *chandef;
 	int ret;
 
 	msg_body = kzalloc(sizeof(*msg_body), GFP_KERNEL);
@@ -1524,7 +1525,13 @@ static int wcn36xx_smd_config_bss_v1(struct wcn36xx *wcn,
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

