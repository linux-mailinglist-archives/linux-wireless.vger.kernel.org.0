Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB005D730E
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2019 12:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbfJOKVP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Oct 2019 06:21:15 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39169 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbfJOKVP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Oct 2019 06:21:15 -0400
Received: by mail-pg1-f195.google.com with SMTP id p12so2524409pgn.6
        for <linux-wireless@vger.kernel.org>; Tue, 15 Oct 2019 03:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZjSUyyFcE4OzpFsuD5QbPfEEJTeG0kXm3yEnzXaAd7g=;
        b=tOogVHkfeRdcF8NN8t2A3kIiU62I+r1F4VR1UkcTkugAUka3Cs04268T/43pgZ7D7S
         PQepFz1DsCHvu4q+AqW+6APMO13npmM5QAaMHIFdmpb4tZlNFWSJjHywwIQe7dtep+g9
         jZGzS6u3jpp8IxG4C2RQioL/fxKA7UqCQPrwiO87oXtZJe3r3N/3YiHjB7/ULauaBqI+
         s6oGLzElmnWljNA3WE67kbKWb+lyEtxOSN3YQCq/iLbT74sNcY5lMOajRVOEJ/wbngAc
         nFRLY8uq/99/8D9VZN2e4jgsJfro17aeGSaPTIJAgqLLLzhJgPNqZTsMasBz5hNiYlMI
         /IJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZjSUyyFcE4OzpFsuD5QbPfEEJTeG0kXm3yEnzXaAd7g=;
        b=mqyBnmzw9rvfJTGvU63fqip+NNkbCzmRK4uQ+NGKWLFNBb0un3sEYu9WxRi/UXpLyS
         mpSMkJxRvVfHGqG93QJZE0zQeyl3NwrO0QhINUJc3EU8JV0RUg7v+a6vd5IlSfnHSwDj
         YTRcLOHbOIO2UbMg12Dpf1YrRJup+7/fyQaJS+CEE0Q6ywpzT01ZAbR+v5s8dJxS2yWs
         8yjL2/ce021FiXl2lPCFsFmoALjVJBvuwIeB5BaAn/Yk5H8bDxC+mB1O5PSVsb4/3BmN
         VgohcR59Gkgemo+vr9YFTLlodgHgMfKqrGsherPrC+aSzPf7ePD3UBMsR8Cni8BtP8CT
         FPlQ==
X-Gm-Message-State: APjAAAV99VczlfavvGEk0zfJR7RABbAe6Cc9QxrprL+ZCo0L+KlAiqIV
        NXg5Of7v28hZNhBgqcVNgKIa3Q==
X-Google-Smtp-Source: APXvYqwSAxzEMOHC8QTx9yFJObxsJCQpENWGTP5uv8UvWH5ruPNpBvxi4RQ7TOGrHCws2VAlWYHJNA==
X-Received: by 2002:a63:1511:: with SMTP id v17mr37218393pgl.34.1571134874188;
        Tue, 15 Oct 2019 03:21:14 -0700 (PDT)
Received: from localhost.localdomain (59-127-47-126.HINET-IP.hinet.net. [59.127.47.126])
        by smtp.gmail.com with ESMTPSA id z21sm19704595pfa.119.2019.10.15.03.21.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Oct 2019 03:21:13 -0700 (PDT)
From:   Chris Chiu <chiu@endlessm.com>
To:     Jes.Sorensen@gmail.com, kvalo@codeaurora.org, davem@davemloft.net
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com
Subject: [PATCH] rtl8xxxu: fix RTL8723BU connection failure issue after warm reboot
Date:   Tue, 15 Oct 2019 18:21:09 +0800
Message-Id: <20191015102109.4701-1-chiu@endlessm.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The RTL8723BU has problems connecting to AP after each warm reboot.
Sometimes it returns no scan result, and in most cases, it fails
the authentication for unknown reason. However, it works totally
fine after cold reboot.

Compare the value of register SYS_CR and SYS_CLK_MAC_CLK_ENABLE
for cold reboot and warm reboot, the registers imply that the MAC
is already powered and thus some procedures are skipped during
driver initialization. Double checked the vendor driver, it reads
the SYS_CR and SYS_CLK_MAC_CLK_ENABLE also but doesn't skip any
during initialization based on them. This commit only tells the
RTL8723BU to do full initialization without checking MAC status.

https://phabricator.endlessm.com/T28000

Signed-off-by: Chris Chiu <chiu@endlessm.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h       | 1 +
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c | 1 +
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index 22e95b11bfbb..6598c8d786ea 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1425,6 +1425,7 @@ struct rtl8xxxu_fileops {
 	u8 has_s0s1:1;
 	u8 has_tx_report:1;
 	u8 gen2_thermal_meter:1;
+	u8 needs_full_init:1;
 	u32 adda_1t_init;
 	u32 adda_1t_path_on;
 	u32 adda_2t_path_on_a;
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
index 9ba661b3d767..a1c3787abe2e 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
@@ -1668,6 +1668,7 @@ struct rtl8xxxu_fileops rtl8723bu_fops = {
 	.has_s0s1 = 1,
 	.has_tx_report = 1,
 	.gen2_thermal_meter = 1,
+	.needs_full_init = 1,
 	.adda_1t_init = 0x01c00014,
 	.adda_1t_path_on = 0x01c00014,
 	.adda_2t_path_on_a = 0x01c00014,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index e4c1b08c8070..8420cb269b8d 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -3900,6 +3900,9 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
 	else
 		macpower = true;
 
+	if (fops->needs_full_init)
+		macpower = false;
+
 	ret = fops->power_on(priv);
 	if (ret < 0) {
 		dev_warn(dev, "%s: Failed power on\n", __func__);
-- 
2.23.0

