Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 833F9A6038
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2019 06:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbfICE3w (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Sep 2019 00:29:52 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46024 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfICE3w (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Sep 2019 00:29:52 -0400
Received: by mail-lj1-f193.google.com with SMTP id l1so14554407lji.12
        for <linux-wireless@vger.kernel.org>; Mon, 02 Sep 2019 21:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qCmsP82DTk01w6Xx+SSAdpGpTOCXTc/9JdvifjcdZ1Q=;
        b=TyqjPEzTRaJkmoTpWNr0WBxF7PPvmZD+XCfcsWTiaBMvdhnbEBlRhp8EuoWbGOM/0d
         piov/Tl7c4ksILB2RB7oZk/0BJ+q0mnpmHaFE0ED2i808fepf1dKKebDY7192T9glnCB
         0Pk7aPD2feLD1m0uvPcU1i+T+DYhXE3K9ct+lcw9lVbKAPXZqJo2NbnY0t3cou77ippm
         lWOz5d8EoMenFwJSLv7qRWlob54gQKAwna/UffHW7toFY/AFQUgeI3h5Z1uAviRbW/JY
         5cCzAD4f7KOoXnDRz4YnKXrfMYaP1jc3+h3u+iAvcChMQfOyw52ZFqm+0DNx0mC0Bkp0
         64Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qCmsP82DTk01w6Xx+SSAdpGpTOCXTc/9JdvifjcdZ1Q=;
        b=A2FtbixYinB0C8UsdbE8tb4byJQ4yD5sTLoynXazyp3EvYGkyO4/5Zd/2UK0rAjj/L
         CkJgJR28G9RlEjm7hxDZMVSb65gpvQxyHP4h/Cfk3OaboL46Aio2+ufvDMXCvWJ7szky
         9rV0LeKAtYQLo7cXKog17qe5FAKPMFZFbGC1g793kdMUGveb+oT49ByIcq6zjFd919r3
         iZEP+CLBx4U9ZqXOrgmrszCA/JxYcv6kZEroqfnnE3HoiI0Xkl/s6ib1YzExQKTpxh9A
         EPJaVlxAN7HdailIS3q3DbddcRcmQE7YZgTkG575iad2EtiT6K6b9UWmjLNInIVE+7D+
         SaiA==
X-Gm-Message-State: APjAAAUYBFrz7YVpQh0w1YoY7PVZ7el/P9Xa6SmJVL0NcoA1SPiQO/da
        2DHfDPRmuS1BR0JLxBA4GCQ=
X-Google-Smtp-Source: APXvYqx6Hy6ZToqyhfxi3ILsirSd9XiH/1IasKG57bGpYK4saIqFLVKbqxymeBQznB7AM6J3cHTDEA==
X-Received: by 2002:a2e:974f:: with SMTP id f15mr1307378ljj.114.1567484989911;
        Mon, 02 Sep 2019 21:29:49 -0700 (PDT)
Received: from localhost.localdomain (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id d25sm2265125lfj.15.2019.09.02.21.29.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Sep 2019 21:29:49 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Winnie Chang <winnie.chang@cypress.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 1/3] brcmfmac: move "cfg80211_ops" pointer to another struct
Date:   Tue,  3 Sep 2019 06:29:26 +0200
Message-Id: <20190903042928.18621-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190903042928.18621-1-zajec5@gmail.com>
References: <20190903042928.18621-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

This moves "ops" pointer from "struct brcmf_cfg80211_info" to the
"struct brcmf_pub". This movement makes it possible to allocate wiphy
without attaching cfg80211 (brcmf_cfg80211_attach()). It's required for
later separation of wiphy allocation and driver initialization.

While at it fix also an unlikely memory leak in the brcmf_attach().

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c  | 1 -
 .../net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h  | 1 -
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c  | 9 ++++++---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h  | 1 +
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 581d0013f33e..c476f854f3ae 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -7210,7 +7210,6 @@ void brcmf_cfg80211_detach(struct brcmf_cfg80211_info *cfg)
 	brcmf_pno_detach(cfg);
 	brcmf_btcoex_detach(cfg);
 	wiphy_unregister(cfg->wiphy);
-	kfree(cfg->ops);
 	wl_deinit_priv(cfg);
 	brcmf_free_wiphy(cfg->wiphy);
 	kfree(cfg);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
index b7b50b07f776..14d5bbad1db1 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
@@ -292,7 +292,6 @@ struct brcmf_cfg80211_wowl {
  */
 struct brcmf_cfg80211_info {
 	struct wiphy *wiphy;
-	struct cfg80211_ops *ops;
 	struct brcmf_cfg80211_conf *conf;
 	struct brcmf_p2p_info p2p;
 	struct brcmf_btcoex_info *btcoex;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index 21e07d1ceeae..e8c488376ff9 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -1224,12 +1224,15 @@ int brcmf_attach(struct device *dev, struct brcmf_mp_device *settings)
 		return -ENOMEM;
 
 	wiphy = wiphy_new(ops, sizeof(*drvr));
-	if (!wiphy)
+	if (!wiphy) {
+		kfree(ops);
 		return -ENOMEM;
+	}
 
 	set_wiphy_dev(wiphy, dev);
 	drvr = wiphy_priv(wiphy);
 	drvr->wiphy = wiphy;
+	drvr->ops = ops;
 
 	for (i = 0; i < ARRAY_SIZE(drvr->if2bss); i++)
 		drvr->if2bss[i] = BRCMF_BSSIDX_INVALID;
@@ -1262,12 +1265,10 @@ int brcmf_attach(struct device *dev, struct brcmf_mp_device *settings)
 		goto fail;
 	}
 
-	drvr->config->ops = ops;
 	return 0;
 
 fail:
 	brcmf_detach(dev);
-	kfree(ops);
 
 	return ret;
 }
@@ -1353,6 +1354,8 @@ void brcmf_detach(struct device *dev)
 
 	bus_if->drvr = NULL;
 
+	kfree(drvr->ops);
+
 	wiphy_free(drvr->wiphy);
 }
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h
index 86517a3d74b1..6699637d3bf8 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h
@@ -97,6 +97,7 @@ struct brcmf_pub {
 	struct brcmf_bus *bus_if;
 	struct brcmf_proto *proto;
 	struct wiphy *wiphy;
+	struct cfg80211_ops *ops;
 	struct brcmf_cfg80211_info *config;
 
 	/* Internal brcmf items */
-- 
2.21.0

