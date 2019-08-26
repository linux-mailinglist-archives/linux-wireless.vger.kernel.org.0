Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDAFE9D772
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2019 22:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387811AbfHZUfE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Aug 2019 16:35:04 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33068 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729078AbfHZUfE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Aug 2019 16:35:04 -0400
Received: by mail-oi1-f193.google.com with SMTP id l2so13204892oil.0
        for <linux-wireless@vger.kernel.org>; Mon, 26 Aug 2019 13:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qoYiEk1waDT7qbi157hrIkf5SSOuTsP9qZITTpaF0gA=;
        b=CPraZmS3mTdnX8wAOqm0ScwBDWON9b/lfR2mNJSmx7+cyhoYwThnUTryxIqSpJBNdW
         VrXF6GVY2u3QppNi1ZgmWlwHvmArZIY3Bp/jsC0v20afCB1faZxsVqvsVXq+22IO4mz8
         hbSWtTBBdJcI2+iYH5HZYTuRYEaOVQHOa10QTWY6aR2tBXKubI3XILPAh7I5kKUw+fF0
         Hkb/Yj13v4z+4bEQ4rZgK1uVQcga2/sw+Zx9cD3bghzlmNSjgDv0XEomVXwotgB+/4xP
         JOkcgNr1odJBv9DbdMH579qRFSJJSURmuBcx7eIQXaMLt8um8e0SQfBZJQpgRujSFrqY
         QgYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=qoYiEk1waDT7qbi157hrIkf5SSOuTsP9qZITTpaF0gA=;
        b=kbDkRv2HhW/2TcL0YthP9ZsKk//u3F5+XtVAmEewSDJ4KStxutkG6JJSme8UxIKo3G
         YdBOv9+ojnhOGiSKbl/MVHyW/meTCjmeJ99nRydYYZQ9ldJTxAAbuIdB1yVhZD2TJuMp
         kdAYzvE08m9PxN8xtVAaHZQYFVulNX37Ck7/+Mj8uu+T5aWZxAz7zy9P49Ja8ZybQjF4
         s/gKGiJleFbYkhOHZgTLhj4bSLIF2FgkXx5pDciHTFbOPtMArHaClwNY5ZII2QuYGFTK
         r0sJ9CYuxBFXy0wF3/3hxBocDJwTGgCDKo/f8rO/riRIs51FE74uxaImMM8otDdbE24u
         r38w==
X-Gm-Message-State: APjAAAW9WNLHVAPi3TcSYhWsPLDDR2kQBRNVg3/3DZ1CPoTaFCw6oFxD
        GOIEr99PTjfv5CZfh1sjArOF30z/
X-Google-Smtp-Source: APXvYqyIM5uMNfctUi5Xdak8RwH289qGfYB4aLR2SBQQFVMSYllt3pSW7fwfFe7Ha9+NfTUu6SpSlQ==
X-Received: by 2002:aca:fc8e:: with SMTP id a136mr14017114oii.104.1566851703545;
        Mon, 26 Aug 2019 13:35:03 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id m205sm3145485oia.57.2019.08.26.13.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 13:35:02 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH] rtlwifi: rtl_pci: Fix memory leak then hardware init fails
Date:   Mon, 26 Aug 2019 15:34:58 -0500
Message-Id: <20190826203458.8056-1-Larry.Finger@lwfinger.net>
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
Kalle,

This bug has been present in the driver since it was added to the
kernel, there is no particular rush in applying it.

Larry

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

