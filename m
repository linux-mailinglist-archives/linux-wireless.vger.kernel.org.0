Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B939D9D8CA
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2019 00:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbfHZWDv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Aug 2019 18:03:51 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35099 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbfHZWDv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Aug 2019 18:03:51 -0400
Received: by mail-ot1-f67.google.com with SMTP id 100so5960169otn.2
        for <linux-wireless@vger.kernel.org>; Mon, 26 Aug 2019 15:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T0xz6rcUxyAdoL/mjFWr2brmUZM3SJQbaxYdb5VrHZI=;
        b=BFt15WFH2k8PelGM2usufNXLI4eHgCjBcMCJV34ynVx4DSt/KpOArDQUNGKOrw7Qop
         SX7BS2fubaVpsibTEOxoMEZO4+57TkFakp08tEmAbqCPFFB2CSuFfyzvyehr73nft1AU
         uYbll33j67/2s1SCDlkDxpQlDwOWSS2MjO5k6UQgtw/mWntlehoyp3wrhbxwj8IwSwoU
         FFySbPhisVOpT3ESTXmEX6gnALZON5D3IjWzHmPdJDdleE+53ZQx4G5mEJOTWxR3jnn3
         cBgPALRtxLEkqru7FRPgC1S+0JI2TRqYVPogGArqHf4/CQnMdcdi2zeL9+b81nIe7hI6
         AcsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=T0xz6rcUxyAdoL/mjFWr2brmUZM3SJQbaxYdb5VrHZI=;
        b=hdBmh1M4UE8eqsgFKDKpnCWjnqnvLj79iLsBEKwkP0NwOMOJ7lU3BJFjx9vdbvqolG
         AtC/UqSwLZ2OHy9epQMn/Jsfcftb1x8D0Z0EQ5rpuEUP0g51BqzxyysZnEGb3TwYO9Nx
         BKP8zYRZoIPWsNcotZiYlHiXmx+oJ889PBq7fk9HtVOz09TPOLZoQ0sz6PdAO28N9nos
         6bA1T6KyUKl+PDo2iN33L6VkToyQLVdDB/0UAd/CP/vkD1CneGbAXQDulYuIJ0bVRkr6
         MqR+ZRIZps5EfCkt1OUZG3/i0IAn8ECB96I+4OE99ATtbMN9kFiQCz5t5zW1nL5pgyKG
         1Sow==
X-Gm-Message-State: APjAAAV28VwEkmxqFAULfW2uPckAwKs+enhouxCFEbEQr2ytfFcjwn1P
        K/3d8B2YwidNBf+IzvhRT6o=
X-Google-Smtp-Source: APXvYqynw9aQIphSgSKwGJ+pJl0Y976XTPPx0m+C65QqNDSpo1kQeABvHHTm0tvrQQGLc6c28rin/A==
X-Received: by 2002:a9d:1288:: with SMTP id g8mr1865478otg.306.1566857030313;
        Mon, 26 Aug 2019 15:03:50 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id n19sm3709926oic.46.2019.08.26.15.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 15:03:49 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v2] rtlwifi: rtl_pci: Fix memory leak when hardware init fails
Date:   Mon, 26 Aug 2019 17:03:44 -0500
Message-Id: <20190826220344.7084-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If the call to hw_init() fails for any of the drivers, the driver will
leak memory that was allocated in BT coexistence setup. Technically, each
of the drivers should have done this free; however placing it in rtl_pci
fixes all the drivers with only a single patch.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
v2 - Fix typo in subject line
---
Kalle,

This bug has been present in the driver since it was added to the
kernel, there is no particular rush in applying it.

Larry
---
 drivers/net/wireless/realtek/rtlwifi/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
index 4055e0ab75ba..c275fc932adb 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -1793,6 +1793,8 @@ static int rtl_pci_start(struct ieee80211_hw *hw)
 	if (err) {
 		RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
 			 "Failed to config hardware!\n");
+		kfree(rtlpriv->btcoexist.btc_context);
+		kfree(rtlpriv->btcoexist.wifi_only_context);
 		return err;
 	}
 	rtlpriv->cfg->ops->set_hw_reg(hw, HW_VAR_RETRY_LIMIT,
-- 
2.22.1

