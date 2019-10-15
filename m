Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B167FD72FB
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2019 12:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbfJOKQZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Oct 2019 06:16:25 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41012 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730201AbfJOKQU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Oct 2019 06:16:20 -0400
Received: by mail-pg1-f195.google.com with SMTP id t3so11843018pga.8
        for <linux-wireless@vger.kernel.org>; Tue, 15 Oct 2019 03:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YyF2qg/Mhc4XEhGEeCU7TNWSjed5NzKyuCiBwgDTeok=;
        b=HyO5Tt59GXKnrGY+7LLGuEkSKL44f7b0LahkEZrWPyGOEgwfP9XhkgKA6vLMD1WZqX
         9NLdthg8oZNElo8bSkoMfzoO8e2rwSsxlVaxeBbj4tonHGiTfZG8UJfuUcYe4xQTc/3O
         b48BI9elpB7LeoPX4mxI15ORrtisztT+hKwLIjW1NrAeadOP6rgghtu5WaQdP7lkCq6B
         R+wdrxm4EJhh8GB3uhfhq4aDpFQ2mopfT4bkGwYQUbca15LR/SO0wpMVlvpvvzLBhWqp
         jmApCL4kHkTCR8OURej7ubIG4YgD/xC5V/ODAZk/Ry72wlzcG/31+qQeejNWadxY5RkX
         fV4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YyF2qg/Mhc4XEhGEeCU7TNWSjed5NzKyuCiBwgDTeok=;
        b=A54jnSMnQmiZfINSHpOf3kjY+ZRY9L6SGymfEnBbm8qVLmbCSM5R+Aajph7AcI/1bp
         vlnrDEnVeQSApOg2uOM151xiw0VCzF/DGsLcQG1rncx8dHky2LhKtzhVeo6KESli46v5
         JBDaczBg71gGDOlTaeFx2fjEehGg3+LIrK4Nh81PxkuBcw6fORzfLH2wvN6ltOn0XEmP
         nFiXsppZMhtZbfkY8RysR1DS1XJdrq0xpRfqBVZ7j2c3pvgf0QaUNoFMEpyTIE7h7LVd
         4AFNB4JVzX25Jqm6kISqlNpsVeYSfM+ABkY6xBlW60SJwQ7uvQxtyeR+soet1Ztb4oMR
         9rVA==
X-Gm-Message-State: APjAAAU4eA6JrWPyINoAy5EpL5QkGc2ALdEijTNdKXMzQCXwUJhWvVoj
        8SDWHMAxu35q+bNsIWQsMNLbxR2sEbr0Vw==
X-Google-Smtp-Source: APXvYqy0xGbbo5vxBCjyi2D1txW1Xhaykdn/3hUyo1fQuxdB/nRiboXKJ4vr/m3wedCmwKaVbLlPxA==
X-Received: by 2002:a17:90a:ac12:: with SMTP id o18mr25640079pjq.93.1571134579228;
        Tue, 15 Oct 2019 03:16:19 -0700 (PDT)
Received: from localhost.localdomain (59-127-47-126.HINET-IP.hinet.net. [59.127.47.126])
        by smtp.gmail.com with ESMTPSA id f15sm19639288pfd.141.2019.10.15.03.16.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Oct 2019 03:16:18 -0700 (PDT)
From:   Chris Chiu <chiu@endlessm.com>
To:     Jes.Sorensen@gmail.com, kvalo@codeaurora.org, davem@davemloft.net
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com
Subject: [PATCH] rtl8xxxu: fix connection failure issue after warm reboot
Date:   Tue, 15 Oct 2019 18:16:08 +0800
Message-Id: <20191015101608.4566-1-chiu@endlessm.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h       | 1 +
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c | 1 +
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index 22e95b11bfbb..fd2ad7d07335 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1425,6 +1425,7 @@ struct rtl8xxxu_fileops {
 	u8 has_s0s1:1;
 	u8 has_tx_report:1;
 	u8 gen2_thermal_meter:1;
+        u8 needs_full_init:1;
 	u32 adda_1t_init;
 	u32 adda_1t_path_on;
 	u32 adda_2t_path_on_a;
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
index 9ba661b3d767..fef1a91489a5 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
@@ -1668,6 +1668,7 @@ struct rtl8xxxu_fileops rtl8723bu_fops = {
 	.has_s0s1 = 1,
 	.has_tx_report = 1,
 	.gen2_thermal_meter = 1,
+        .needs_full_init = 1,
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

