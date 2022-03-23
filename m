Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6DB4E4E63
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Mar 2022 09:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242808AbiCWIla (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Mar 2022 04:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbiCWIl3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Mar 2022 04:41:29 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568122FFF5
        for <linux-wireless@vger.kernel.org>; Wed, 23 Mar 2022 01:39:59 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id q5so842774ljb.11
        for <linux-wireless@vger.kernel.org>; Wed, 23 Mar 2022 01:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=btkrkL+Yu68nubevJGwP5i6FUk2mdmM5RvBYRXPVWug=;
        b=SBMue3CkWXyZA9Uw88pS2jeJP3IvnxcvlpDKsLRKfbAmIav7iO0E++mWiDajd0qmKq
         NDgblTHYA+5gRFXLvKN4hg6zHjJ8itf9f5eAxN67KMQ8UTHahJwapjdasIXTdQ/mVL14
         feLXRivIpgqP4Aw718JA+k2nPWW+GuMJN+T/9FVhC/yVFm9UZBJ1ISWATYn4Xcmdhqcy
         qEw8ZcbP9QF0WVX3uPNNj9eUIExDbSKbi8iYHyEi0NQYjrKVISa65XeQfhQAn+J89nhX
         PPm6ogh2tGqs0ZL8v7lnz7BoQ+KZ6GGTvT0jXp6J1lZmm3LDC984GWos8ssU1GRGeP9Q
         K6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=btkrkL+Yu68nubevJGwP5i6FUk2mdmM5RvBYRXPVWug=;
        b=Yk2izoxbDaXd0spPK4diWStg/jRZRPQvg8OYcSzQy7PI0t94QwtvBlOuZZxs6ki1gj
         AEdz+AjErrZ/twswSiB0vEcoL4DWwYb8nWU6Qw+gaQ2ROJ67WyCy7Ra7807sHp47Fv75
         ZQyhuJthXnKbEIzFGAzq6Ztp3JEsb/PuB/SBJ4IeUIAUn2krdYpioFLkNrxqrj/CGxiO
         BhsTW5beMEy3uk4JcUeSj93NaYOX8HhrWf7uXXC40KtIBC0hZTdhAbBcggyw83S2p9nN
         Cixj57L/T+y9XDjxRjq0s8T2nan3/34ayBTVO9m279TPC+SKHPyNBXEhqnvDkDvpheIO
         lPIQ==
X-Gm-Message-State: AOAM532eWSHLTFBwEWav159fS9FVYPDU0aPFbJ0U3ng0JL02krlVGXYm
        m2IUCuYeZ/9VsKUtEdabk/IiRg==
X-Google-Smtp-Source: ABdhPJyYl9PbFUIVd/Xa1kC6l5HiCulEtm/0hfSsG+yEPR8f4kikWADc2bXMWtEd9Ougr/cEv+keqA==
X-Received: by 2002:a2e:a488:0:b0:249:6096:a381 with SMTP id h8-20020a2ea488000000b002496096a381mr21104861lji.268.1648024797313;
        Wed, 23 Mar 2022 01:39:57 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-34.NA.cust.bahnhof.se. [155.4.129.34])
        by smtp.gmail.com with ESMTPSA id o17-20020ac24351000000b004437b082fc6sm2462420lfl.229.2022.03.23.01.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 01:39:56 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Cc:     Yann Gautier <yann.gautier@foss.st.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Adrian Ratiu <adrian.ratiu@collabora.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2] brcmfmac: Avoid keeping power to SDIO card unless WOWL is used
Date:   Wed, 23 Mar 2022 09:39:50 +0100
Message-Id: <20220323083950.414783-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Keeping the power to the SDIO card during system wide suspend, consumes
energy. Especially on battery driven embedded systems, this can be a
problem. Therefore, let's change the behaviour into allowing the SDIO card
to be powered off, unless WOWL is supported and enabled.

Note that, the downside from this change, is that during system resume the
SDIO card needs to be re-initialized and the FW must be re-programmed. Even
if this may take some time to complete, it should we worth it, rather than
draining the battery.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- As pointed out by Yann, the changes for the resume path was missing,
	so I have added that too.

Again, please note that, I have only compile-tested this patch, so I am relying
on help from Yann and others to run tests on real HW.

Kind regards
Ulf Hansson

---
 .../broadcom/brcm80211/brcmfmac/bcmsdh.c      | 39 +++++++++++--------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index ac02244a6fdf..9c598ea97499 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -1119,9 +1119,21 @@ void brcmf_sdio_wowl_config(struct device *dev, bool enabled)
 {
 	struct brcmf_bus *bus_if = dev_get_drvdata(dev);
 	struct brcmf_sdio_dev *sdiodev = bus_if->bus_priv.sdio;
+	mmc_pm_flag_t pm_caps = sdio_get_host_pm_caps(sdiodev->func1);
 
-	brcmf_dbg(SDIO, "Configuring WOWL, enabled=%d\n", enabled);
-	sdiodev->wowl_enabled = enabled;
+	/* Power must be preserved to be able to support WOWL. */
+	if (!(pm_caps & MMC_PM_KEEP_POWER))
+		goto notsup;
+
+	if (sdiodev->settings->bus.sdio.oob_irq_supported ||
+	    pm_caps & MMC_PM_WAKE_SDIO_IRQ) {
+		sdiodev->wowl_enabled = enabled;
+		brcmf_dbg(SDIO, "Configuring WOWL, enabled=%d\n", enabled);
+		return;
+	}
+
+notsup:
+	brcmf_dbg(SDIO, "WOWL not supported\n");
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -1130,7 +1142,7 @@ static int brcmf_ops_sdio_suspend(struct device *dev)
 	struct sdio_func *func;
 	struct brcmf_bus *bus_if;
 	struct brcmf_sdio_dev *sdiodev;
-	mmc_pm_flag_t pm_caps, sdio_flags;
+	mmc_pm_flag_t sdio_flags;
 	int ret = 0;
 
 	func = container_of(dev, struct sdio_func, dev);
@@ -1142,20 +1154,15 @@ static int brcmf_ops_sdio_suspend(struct device *dev)
 	bus_if = dev_get_drvdata(dev);
 	sdiodev = bus_if->bus_priv.sdio;
 
-	pm_caps = sdio_get_host_pm_caps(func);
-
-	if (pm_caps & MMC_PM_KEEP_POWER) {
-		/* preserve card power during suspend */
+	if (sdiodev->wowl_enabled) {
 		brcmf_sdiod_freezer_on(sdiodev);
 		brcmf_sdio_wd_timer(sdiodev->bus, 0);
 
 		sdio_flags = MMC_PM_KEEP_POWER;
-		if (sdiodev->wowl_enabled) {
-			if (sdiodev->settings->bus.sdio.oob_irq_supported)
-				enable_irq_wake(sdiodev->settings->bus.sdio.oob_irq_nr);
-			else
-				sdio_flags |= MMC_PM_WAKE_SDIO_IRQ;
-		}
+		if (sdiodev->settings->bus.sdio.oob_irq_supported)
+			enable_irq_wake(sdiodev->settings->bus.sdio.oob_irq_nr);
+		else
+			sdio_flags |= MMC_PM_WAKE_SDIO_IRQ;
 
 		if (sdio_set_host_pm_flags(sdiodev->func1, sdio_flags))
 			brcmf_err("Failed to set pm_flags %x\n", sdio_flags);
@@ -1176,21 +1183,19 @@ static int brcmf_ops_sdio_resume(struct device *dev)
 	struct brcmf_bus *bus_if = dev_get_drvdata(dev);
 	struct brcmf_sdio_dev *sdiodev = bus_if->bus_priv.sdio;
 	struct sdio_func *func = container_of(dev, struct sdio_func, dev);
-	mmc_pm_flag_t pm_caps = sdio_get_host_pm_caps(func);
 	int ret = 0;
 
 	brcmf_dbg(SDIO, "Enter: F%d\n", func->num);
 	if (func->num != 2)
 		return 0;
 
-	if (!(pm_caps & MMC_PM_KEEP_POWER)) {
+	if (!sdiodev->wowl_enabled) {
 		/* bus was powered off and device removed, probe again */
 		ret = brcmf_sdiod_probe(sdiodev);
 		if (ret)
 			brcmf_err("Failed to probe device on resume\n");
 	} else {
-		if (sdiodev->wowl_enabled &&
-		    sdiodev->settings->bus.sdio.oob_irq_supported)
+		if (sdiodev->settings->bus.sdio.oob_irq_supported)
 			disable_irq_wake(sdiodev->settings->bus.sdio.oob_irq_nr);
 
 		brcmf_sdiod_freezer_off(sdiodev);
-- 
2.25.1

