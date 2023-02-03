Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE5568927C
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Feb 2023 09:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbjBCIig (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Feb 2023 03:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbjBCIie (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Feb 2023 03:38:34 -0500
Received: from smtp161.vfemail.net (smtp161.vfemail.net [146.59.185.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92C679236
        for <linux-wireless@vger.kernel.org>; Fri,  3 Feb 2023 00:38:31 -0800 (PST)
Received: (qmail 21247 invoked from network); 3 Feb 2023 08:38:30 +0000
Received: from localhost (HELO nl101-3.vfemail.net) ()
  by smtpout.vfemail.net with ESMTPS (ECDHE-RSA-AES256-GCM-SHA384 encrypted); 3 Feb 2023 08:38:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=openmail.cc; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=2018; bh=sKeY59QN/akZNkbUpqrT33k7Q
        8PHn/p9w1ND4ntYpHI=; b=fiY7rbHVviErOElR0cuVRmdximttvMvtx0+npKHJT
        x/zW7ESufeaLKysmY9XB8cEMrZ8IEetLXWzTkplipL21W+cmqXPfghiyWurvq/0k
        XZuNS4BAl/N+VqnaziEQkMRYERdyydTZPHSQHv5WJhvSCCTChjJINFMKJKmxBMv9
        g8=
Received: (qmail 36023 invoked from network); 3 Feb 2023 08:38:29 -0000
Received: by simscan 1.4.0 ppid: 35085, pid: 35935, t: 1.4564s
         scanners:none
Received: from unknown (HELO bmwxMDEudmZlbWFpbC5uZXQ=) (ZXF1dUBvcGVubWFpbC5jYw==@MTkyLjE2OC4xLjE5Mg==)
  by nl101.vfemail.net with ESMTPA; 3 Feb 2023 08:38:28 -0000
From:   equu@openmail.cc
To:     lpieralisi@kernel.org, toke@toke.dk, kvalo@kernel.org
Cc:     linux-pci@vger.kernel.org, robh@kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        equu@openmail.cc
Subject: [PATCH v4 2/3] wifi: ath9k: stop loading incompatible DT cal data
Date:   Fri,  3 Feb 2023 16:37:30 +0800
Message-Id: <20230203083731.349695-3-equu@openmail.cc>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230203083731.349695-1-equu@openmail.cc>
References: <ab8ff515-19ec-fe3f-0237-c30275e9744d@openmail.cc>
 <20230203083731.349695-1-equu@openmail.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Edward Chow <equu@openmail.cc>

As reported in https://github.com/openwrt/openwrt/pull/11345 , ath9k
would load calibration data from a device tree node declared
incompatible.

Now, ath9k will first check whether the device tree node is compatible
with it, using the functionality introduced with the first patch of
this series, ("PCI: of: Match pci devices or drivers against OF DT
nodes") and only proceed loading calibration data from compatible node.

Signed-off-by: Edward Chow <equu@openmail.cc>
---
 drivers/net/wireless/ath/ath9k/ath9k.h |  1 +
 drivers/net/wireless/ath/ath9k/init.c  | 26 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath9k/pci.c   |  2 +-
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/ath9k.h b/drivers/net/wireless/ath/ath9k/ath9k.h
index 2cc23605c9fc..4f6f0383a5f8 100644
--- a/drivers/net/wireless/ath/ath9k/ath9k.h
+++ b/drivers/net/wireless/ath/ath9k/ath9k.h
@@ -35,6 +35,7 @@ struct ath_node;
 struct ath_vif;
 
 extern struct ieee80211_ops ath9k_ops;
+extern struct pci_driver ath_pci_driver;
 extern int ath9k_modparam_nohwcrypt;
 extern int ath9k_led_blink;
 extern bool is_ath9k_unloaded;
diff --git a/drivers/net/wireless/ath/ath9k/init.c b/drivers/net/wireless/ath/ath9k/init.c
index 4f00400c7ffb..6c0296b4d366 100644
--- a/drivers/net/wireless/ath/ath9k/init.c
+++ b/drivers/net/wireless/ath/ath9k/init.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_net.h>
+#include <linux/of_pci.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/relay.h>
 #include <linux/dmi.h>
@@ -577,6 +578,31 @@ static int ath9k_nvmem_request_eeprom(struct ath_softc *sc)
 	size_t len;
 	int err;
 
+	/* devm_nvmem_cell_get() will get a cell first from the OF
+	 * DT node representing the given device with nvmem-cell-name
+	 * "calibration", and from the global lookup table as a fallback,
+	 * and an ath9k device could be either a pci one or a platform one.
+	 *
+	 * If the OF DT node is not compatible with the real device, the
+	 * calibration data got from the node should not be applied.
+	 *
+	 * dev_is_pci(sc->dev) && ( no OF node || caldata not from node
+	 * || not compatible ) -> do not use caldata .
+	 *
+	 * !dev_is_pci(sc->dev) -> always use caldata .
+	 */
+	if (dev_is_pci(sc->dev) &&
+	    (!sc->dev->of_node ||
+	     !of_property_match_string(sc->dev->of_node,
+				       "nvmem-cell-names",
+				       "calibration") ||
+	     !of_pci_node_match_driver(sc->dev->of_node,
+				       &ath_pci_driver)))
+		/* follow the "just return 0;" convention as
+		 * noted below.
+		 */
+		return 0;
+
 	cell = devm_nvmem_cell_get(sc->dev, "calibration");
 	if (IS_ERR(cell)) {
 		err = PTR_ERR(cell);
diff --git a/drivers/net/wireless/ath/ath9k/pci.c b/drivers/net/wireless/ath/ath9k/pci.c
index a074e23013c5..fcb19761e60d 100644
--- a/drivers/net/wireless/ath/ath9k/pci.c
+++ b/drivers/net/wireless/ath/ath9k/pci.c
@@ -1074,7 +1074,7 @@ static SIMPLE_DEV_PM_OPS(ath9k_pm_ops, ath_pci_suspend, ath_pci_resume);
 
 MODULE_DEVICE_TABLE(pci, ath_pci_id_table);
 
-static struct pci_driver ath_pci_driver = {
+struct pci_driver ath_pci_driver = {
 	.name       = "ath9k",
 	.id_table   = ath_pci_id_table,
 	.probe      = ath_pci_probe,
-- 
2.39.1

