Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7305A6E3F
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Aug 2022 22:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbiH3UPc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Aug 2022 16:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbiH3UPR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Aug 2022 16:15:17 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6971286F3
        for <linux-wireless@vger.kernel.org>; Tue, 30 Aug 2022 13:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=4LFY4ioMkY3dYD
        XeDSSXk/8F+iRs2Svtr3dX2Fp34ks=; b=MkZ1Rw4IxB5xvLqkBs6Lxg8V0u/Pwn
        Mldk0Ip7V7tGgKb69zq7J3w4hxnUMb22dOYhpKRz8DqTJOkjKTXlYAvSH1G+X1hh
        ZAjPxvdQYh4h8LtEa0wjJ8ic1dN9rboXv62JKqXiAcQfUr1LDpAppQnwNpbyLnxl
        RSK+73AmBjdaA=
Received: (qmail 422781 invoked from network); 30 Aug 2022 22:15:02 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 30 Aug 2022 22:15:02 +0200
X-UD-Smtp-Session: l3s3148p1@XAYJCXvnYu0gAwDtxxrgAFH1RcxMblwv
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Lamparter <chunkeey@googlemail.com>,
        Simon Kelley <simon@thekelleys.org.uk>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Stanislav Yakovlev <stas.yakovlev@gmail.com>,
        Stanislaw Gruszka <stf_xl@wp.pl>, Jouni Malinen <j@w1.fi>,
        Ajay Singh <ajay.kathat@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Igor Mitsyanko <imitsyanko@quantenna.com>,
        Sergey Matyukevich <geomatsi@gmail.com>,
        Herton Ronaldo Krzesinski <herton@canonical.com>,
        Hin-Tak Leung <htl10@users.sourceforge.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        b43-dev@lists.infradead.org, brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, libertas-dev@lists.infradead.org
Subject: [PATCH v2 2/3] net: wireless: move from strlcpy with unused retval to strscpy
Date:   Tue, 30 Aug 2022 22:14:53 +0200
Message-Id: <20220830201457.7984-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220830201457.7984-1-wsa+renesas@sang-engineering.com>
References: <20220830201457.7984-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Follow the advice of the below link and prefer 'strscpy' in this
subsystem. Conversion is 1:1 because the return value is not used.
Generated by a coccinelle script.

Link: https://lore.kernel.org/r/CAHk-=wgfRnXz0W3D37d01q3JFkr_i_uTL=V6A6G1oUZcprmknw@mail.gmail.com/
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Changes since v1:
* split into smaller patches

 drivers/net/wireless/ath/ath6kl/init.c                    | 2 +-
 drivers/net/wireless/ath/carl9170/fw.c                    | 2 +-
 drivers/net/wireless/ath/wil6210/main.c                   | 2 +-
 drivers/net/wireless/ath/wil6210/netdev.c                 | 2 +-
 drivers/net/wireless/ath/wil6210/wmi.c                    | 2 +-
 drivers/net/wireless/atmel/atmel.c                        | 2 +-
 drivers/net/wireless/broadcom/b43/leds.c                  | 2 +-
 drivers/net/wireless/broadcom/b43legacy/leds.c            | 2 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c | 8 ++++----
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c   | 8 ++++----
 .../net/wireless/broadcom/brcm80211/brcmfmac/firmware.c   | 2 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c   | 2 +-
 drivers/net/wireless/intel/ipw2x00/ipw2100.c              | 6 +++---
 drivers/net/wireless/intel/ipw2x00/ipw2200.c              | 6 +++---
 drivers/net/wireless/intel/iwlegacy/3945-mac.c            | 2 +-
 drivers/net/wireless/intersil/hostap/hostap_ioctl.c       | 2 +-
 drivers/net/wireless/marvell/libertas/ethtool.c           | 4 ++--
 drivers/net/wireless/microchip/wilc1000/mon.c             | 2 +-
 drivers/net/wireless/quantenna/qtnfmac/cfg80211.c         | 2 +-
 drivers/net/wireless/quantenna/qtnfmac/commands.c         | 2 +-
 drivers/net/wireless/realtek/rtl818x/rtl8187/leds.c       | 2 +-
 drivers/net/wireless/wl3501_cs.c                          | 8 ++++----
 22 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/init.c b/drivers/net/wireless/ath/ath6kl/init.c
index 9b5c7d8f2b95..201e45554070 100644
--- a/drivers/net/wireless/ath/ath6kl/init.c
+++ b/drivers/net/wireless/ath/ath6kl/init.c
@@ -1014,7 +1014,7 @@ static int ath6kl_fetch_fw_apin(struct ath6kl *ar, const char *name)
 
 		switch (ie_id) {
 		case ATH6KL_FW_IE_FW_VERSION:
-			strlcpy(ar->wiphy->fw_version, data,
+			strscpy(ar->wiphy->fw_version, data,
 				min(sizeof(ar->wiphy->fw_version), ie_len+1));
 
 			ath6kl_dbg(ATH6KL_DBG_BOOT,
diff --git a/drivers/net/wireless/ath/carl9170/fw.c b/drivers/net/wireless/ath/carl9170/fw.c
index 1ab09e1c9ec5..4c1aecd1163c 100644
--- a/drivers/net/wireless/ath/carl9170/fw.c
+++ b/drivers/net/wireless/ath/carl9170/fw.c
@@ -105,7 +105,7 @@ static void carl9170_fw_info(struct ar9170 *ar)
 			 CARL9170FW_GET_MONTH(fw_date),
 			 CARL9170FW_GET_DAY(fw_date));
 
-		strlcpy(ar->hw->wiphy->fw_version, motd_desc->release,
+		strscpy(ar->hw->wiphy->fw_version, motd_desc->release,
 			sizeof(ar->hw->wiphy->fw_version));
 	}
 }
diff --git a/drivers/net/wireless/ath/wil6210/main.c b/drivers/net/wireless/ath/wil6210/main.c
index 7da87c9f363f..94e61dbe94f8 100644
--- a/drivers/net/wireless/ath/wil6210/main.c
+++ b/drivers/net/wireless/ath/wil6210/main.c
@@ -1305,7 +1305,7 @@ void wil_get_board_file(struct wil6210_priv *wil, char *buf, size_t len)
 			board_file = WIL_BOARD_FILE_NAME;
 	}
 
-	strlcpy(buf, board_file, len);
+	strscpy(buf, board_file, len);
 }
 
 static int wil_get_bl_info(struct wil6210_priv *wil)
diff --git a/drivers/net/wireless/ath/wil6210/netdev.c b/drivers/net/wireless/ath/wil6210/netdev.c
index 87a88f26233e..e76b38ad1d44 100644
--- a/drivers/net/wireless/ath/wil6210/netdev.c
+++ b/drivers/net/wireless/ath/wil6210/netdev.c
@@ -445,7 +445,7 @@ int wil_if_add(struct wil6210_priv *wil)
 
 	wil_dbg_misc(wil, "entered");
 
-	strlcpy(wiphy->fw_version, wil->fw_version, sizeof(wiphy->fw_version));
+	strscpy(wiphy->fw_version, wil->fw_version, sizeof(wiphy->fw_version));
 
 	rc = wiphy_register(wiphy);
 	if (rc < 0) {
diff --git a/drivers/net/wireless/ath/wil6210/wmi.c b/drivers/net/wireless/ath/wil6210/wmi.c
index ea7bd403e706..6a5976a2944c 100644
--- a/drivers/net/wireless/ath/wil6210/wmi.c
+++ b/drivers/net/wireless/ath/wil6210/wmi.c
@@ -780,7 +780,7 @@ static void wmi_evt_ready(struct wil6210_vif *vif, int id, void *d, int len)
 		return; /* FW load will fail after timeout */
 	}
 	/* ignore MAC address, we already have it from the boot loader */
-	strlcpy(wiphy->fw_version, wil->fw_version, sizeof(wiphy->fw_version));
+	strscpy(wiphy->fw_version, wil->fw_version, sizeof(wiphy->fw_version));
 
 	if (len > offsetof(struct wmi_ready_event, rfc_read_calib_result)) {
 		wil_dbg_wmi(wil, "rfc calibration result %d\n",
diff --git a/drivers/net/wireless/atmel/atmel.c b/drivers/net/wireless/atmel/atmel.c
index 0361c8eb2008..45d079b93384 100644
--- a/drivers/net/wireless/atmel/atmel.c
+++ b/drivers/net/wireless/atmel/atmel.c
@@ -1518,7 +1518,7 @@ struct net_device *init_atmel_card(unsigned short irq, unsigned long port,
 	priv->firmware = NULL;
 	priv->firmware_type = fw_type;
 	if (firmware) /* module parameter */
-		strlcpy(priv->firmware_id, firmware, sizeof(priv->firmware_id));
+		strscpy(priv->firmware_id, firmware, sizeof(priv->firmware_id));
 	priv->bus_type = card_present ? BUS_TYPE_PCCARD : BUS_TYPE_PCI;
 	priv->station_state = STATION_STATE_DOWN;
 	priv->do_rx_crc = 0;
diff --git a/drivers/net/wireless/broadcom/b43/leds.c b/drivers/net/wireless/broadcom/b43/leds.c
index 982a772a9d87..bfe1be345844 100644
--- a/drivers/net/wireless/broadcom/b43/leds.c
+++ b/drivers/net/wireless/broadcom/b43/leds.c
@@ -118,7 +118,7 @@ static int b43_register_led(struct b43_wldev *dev, struct b43_led *led,
 	led->wl = dev->wl;
 	led->index = led_index;
 	led->activelow = activelow;
-	strlcpy(led->name, name, sizeof(led->name));
+	strscpy(led->name, name, sizeof(led->name));
 	atomic_set(&led->state, 0);
 
 	led->led_dev.name = led->name;
diff --git a/drivers/net/wireless/broadcom/b43legacy/leds.c b/drivers/net/wireless/broadcom/b43legacy/leds.c
index 38b5be3a84e2..79e6fd205bfb 100644
--- a/drivers/net/wireless/broadcom/b43legacy/leds.c
+++ b/drivers/net/wireless/broadcom/b43legacy/leds.c
@@ -88,7 +88,7 @@ static int b43legacy_register_led(struct b43legacy_wldev *dev,
 	led->dev = dev;
 	led->index = led_index;
 	led->activelow = activelow;
-	strlcpy(led->name, name, sizeof(led->name));
+	strscpy(led->name, name, sizeof(led->name));
 
 	led->led_dev.name = led->name;
 	led->led_dev.default_trigger = default_trigger;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
index 7485e784be2a..372deeb69477 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
@@ -261,7 +261,7 @@ int brcmf_c_preinit_dcmds(struct brcmf_if *ifp)
 				     &revinfo, sizeof(revinfo));
 	if (err < 0) {
 		bphy_err(drvr, "retrieving revision info failed, %d\n", err);
-		strlcpy(ri->chipname, "UNKNOWN", sizeof(ri->chipname));
+		strscpy(ri->chipname, "UNKNOWN", sizeof(ri->chipname));
 	} else {
 		ri->vendorid = le32_to_cpu(revinfo.vendorid);
 		ri->deviceid = le32_to_cpu(revinfo.deviceid);
@@ -314,7 +314,7 @@ int brcmf_c_preinit_dcmds(struct brcmf_if *ifp)
 
 	/* locate firmware version number for ethtool */
 	ptr = strrchr(buf, ' ') + 1;
-	strlcpy(ifp->drvr->fwver, ptr, sizeof(ifp->drvr->fwver));
+	strscpy(ifp->drvr->fwver, ptr, sizeof(ifp->drvr->fwver));
 
 	/* Query for 'clmver' to get CLM version info from firmware */
 	memset(buf, 0, sizeof(buf));
@@ -424,11 +424,11 @@ static void brcmf_mp_attach(void)
 	 * if not set then if available use the platform data version. To make
 	 * sure it gets initialized at all, always copy the module param version
 	 */
-	strlcpy(brcmf_mp_global.firmware_path, brcmf_firmware_path,
+	strscpy(brcmf_mp_global.firmware_path, brcmf_firmware_path,
 		BRCMF_FW_ALTPATH_LEN);
 	if ((brcmfmac_pdata) && (brcmfmac_pdata->fw_alternative_path) &&
 	    (brcmf_mp_global.firmware_path[0] == '\0')) {
-		strlcpy(brcmf_mp_global.firmware_path,
+		strscpy(brcmf_mp_global.firmware_path,
 			brcmfmac_pdata->fw_alternative_path,
 			BRCMF_FW_ALTPATH_LEN);
 	}
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index bd164a0821f9..5516f7dc10c1 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -561,10 +561,10 @@ static void brcmf_ethtool_get_drvinfo(struct net_device *ndev,
 
 	if (drvr->revinfo.result == 0)
 		brcmu_dotrev_str(drvr->revinfo.driverrev, drev);
-	strlcpy(info->driver, KBUILD_MODNAME, sizeof(info->driver));
-	strlcpy(info->version, drev, sizeof(info->version));
-	strlcpy(info->fw_version, drvr->fwver, sizeof(info->fw_version));
-	strlcpy(info->bus_info, dev_name(drvr->bus_if->dev),
+	strscpy(info->driver, KBUILD_MODNAME, sizeof(info->driver));
+	strscpy(info->version, drev, sizeof(info->version));
+	strscpy(info->fw_version, drvr->fwver, sizeof(info->fw_version));
+	strscpy(info->bus_info, dev_name(drvr->bus_if->dev),
 		sizeof(info->bus_info));
 }
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
index b8379e4034a4..15e99d8865bd 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
@@ -769,7 +769,7 @@ brcmf_fw_alloc_request(u32 chip, u32 chiprev,
 		fwnames[j].path[0] = '\0';
 		/* check if firmware path is provided by module parameter */
 		if (brcmf_mp_global.firmware_path[0] != '\0') {
-			strlcpy(fwnames[j].path, mp_path,
+			strscpy(fwnames[j].path, mp_path,
 				BRCMF_FW_NAME_LEN);
 
 			if (end != '/') {
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
index d58525ebe618..a3d5030f6fe0 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
@@ -688,7 +688,7 @@ static void brcmf_fws_macdesc_set_name(struct brcmf_fws_info *fws,
 				       struct brcmf_fws_mac_descriptor *desc)
 {
 	if (desc == &fws->desc.other)
-		strlcpy(desc->name, "MAC-OTHER", sizeof(desc->name));
+		strscpy(desc->name, "MAC-OTHER", sizeof(desc->name));
 	else if (desc->mac_handle)
 		scnprintf(desc->name, sizeof(desc->name), "MAC-%d:%d",
 			  desc->mac_handle, desc->interface_id);
diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2100.c b/drivers/net/wireless/intel/ipw2x00/ipw2100.c
index 5234511dac78..ac36c899134e 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2100.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2100.c
@@ -5907,8 +5907,8 @@ static void ipw_ethtool_get_drvinfo(struct net_device *dev,
 	struct ipw2100_priv *priv = libipw_priv(dev);
 	char fw_ver[64], ucode_ver[64];
 
-	strlcpy(info->driver, DRV_NAME, sizeof(info->driver));
-	strlcpy(info->version, DRV_VERSION, sizeof(info->version));
+	strscpy(info->driver, DRV_NAME, sizeof(info->driver));
+	strscpy(info->version, DRV_VERSION, sizeof(info->version));
 
 	ipw2100_get_fwversion(priv, fw_ver, sizeof(fw_ver));
 	ipw2100_get_ucodeversion(priv, ucode_ver, sizeof(ucode_ver));
@@ -5916,7 +5916,7 @@ static void ipw_ethtool_get_drvinfo(struct net_device *dev,
 	snprintf(info->fw_version, sizeof(info->fw_version), "%s:%d:%s",
 		 fw_ver, priv->eeprom_version, ucode_ver);
 
-	strlcpy(info->bus_info, pci_name(priv->pci_dev),
+	strscpy(info->bus_info, pci_name(priv->pci_dev),
 		sizeof(info->bus_info));
 }
 
diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2200.c b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
index 029dacebe751..5b483de18c81 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2200.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
@@ -10424,8 +10424,8 @@ static void ipw_ethtool_get_drvinfo(struct net_device *dev,
 	char date[32];
 	u32 len;
 
-	strlcpy(info->driver, DRV_NAME, sizeof(info->driver));
-	strlcpy(info->version, DRV_VERSION, sizeof(info->version));
+	strscpy(info->driver, DRV_NAME, sizeof(info->driver));
+	strscpy(info->version, DRV_VERSION, sizeof(info->version));
 
 	len = sizeof(vers);
 	ipw_get_ordinal(p, IPW_ORD_STAT_FW_VERSION, vers, &len);
@@ -10434,7 +10434,7 @@ static void ipw_ethtool_get_drvinfo(struct net_device *dev,
 
 	snprintf(info->fw_version, sizeof(info->fw_version), "%s (%s)",
 		 vers, date);
-	strlcpy(info->bus_info, pci_name(p->pci_dev),
+	strscpy(info->bus_info, pci_name(p->pci_dev),
 		sizeof(info->bus_info));
 }
 
diff --git a/drivers/net/wireless/intel/iwlegacy/3945-mac.c b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
index 846138d6e33d..7352d5b2095f 100644
--- a/drivers/net/wireless/intel/iwlegacy/3945-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
@@ -3254,7 +3254,7 @@ il3945_store_measurement(struct device *d, struct device_attribute *attr,
 
 	if (count) {
 		char *p = buffer;
-		strlcpy(buffer, buf, sizeof(buffer));
+		strscpy(buffer, buf, sizeof(buffer));
 		channel = simple_strtoul(p, NULL, 0);
 		if (channel)
 			params.channel = channel;
diff --git a/drivers/net/wireless/intersil/hostap/hostap_ioctl.c b/drivers/net/wireless/intersil/hostap/hostap_ioctl.c
index 0a376f112db9..4e0a0c881697 100644
--- a/drivers/net/wireless/intersil/hostap/hostap_ioctl.c
+++ b/drivers/net/wireless/intersil/hostap/hostap_ioctl.c
@@ -3848,7 +3848,7 @@ static void prism2_get_drvinfo(struct net_device *dev,
 	iface = netdev_priv(dev);
 	local = iface->local;
 
-	strlcpy(info->driver, "hostap", sizeof(info->driver));
+	strscpy(info->driver, "hostap", sizeof(info->driver));
 	snprintf(info->fw_version, sizeof(info->fw_version),
 		 "%d.%d.%d", (local->sta_fw_ver >> 16) & 0xff,
 		 (local->sta_fw_ver >> 8) & 0xff,
diff --git a/drivers/net/wireless/marvell/libertas/ethtool.c b/drivers/net/wireless/marvell/libertas/ethtool.c
index d8e4f29b690d..9f53308a9935 100644
--- a/drivers/net/wireless/marvell/libertas/ethtool.c
+++ b/drivers/net/wireless/marvell/libertas/ethtool.c
@@ -20,8 +20,8 @@ static void lbs_ethtool_get_drvinfo(struct net_device *dev,
 		priv->fwrelease >> 16 & 0xff,
 		priv->fwrelease >>  8 & 0xff,
 		priv->fwrelease       & 0xff);
-	strlcpy(info->driver, "libertas", sizeof(info->driver));
-	strlcpy(info->version, lbs_driver_version, sizeof(info->version));
+	strscpy(info->driver, "libertas", sizeof(info->driver));
+	strscpy(info->version, lbs_driver_version, sizeof(info->version));
 }
 
 /*
diff --git a/drivers/net/wireless/microchip/wilc1000/mon.c b/drivers/net/wireless/microchip/wilc1000/mon.c
index b5a1b65c087c..03b7229a0ff5 100644
--- a/drivers/net/wireless/microchip/wilc1000/mon.c
+++ b/drivers/net/wireless/microchip/wilc1000/mon.c
@@ -229,7 +229,7 @@ struct net_device *wilc_wfi_init_mon_interface(struct wilc *wl,
 		return NULL;
 
 	wl->monitor_dev->type = ARPHRD_IEEE80211_RADIOTAP;
-	strlcpy(wl->monitor_dev->name, name, IFNAMSIZ);
+	strscpy(wl->monitor_dev->name, name, IFNAMSIZ);
 	wl->monitor_dev->netdev_ops = &wilc_wfi_netdev_ops;
 	wl->monitor_dev->needs_free_netdev = true;
 
diff --git a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
index 1593e810b3ca..b71ed42188fc 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
@@ -1223,7 +1223,7 @@ int qtnf_wiphy_register(struct qtnf_hw_info *hw_info, struct qtnf_wmac *mac)
 			mac->macinfo.extended_capabilities_len;
 	}
 
-	strlcpy(wiphy->fw_version, hw_info->fw_version,
+	strscpy(wiphy->fw_version, hw_info->fw_version,
 		sizeof(wiphy->fw_version));
 	wiphy->hw_version = hw_info->hw_version;
 
diff --git a/drivers/net/wireless/quantenna/qtnfmac/commands.c b/drivers/net/wireless/quantenna/qtnfmac/commands.c
index 0fad53693292..b1b73478d89b 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/commands.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/commands.c
@@ -967,7 +967,7 @@ qtnf_cmd_resp_proc_hw_info(struct qtnf_bus *bus,
 		hwinfo->total_rx_chain, hwinfo->total_tx_chain,
 		hwinfo->fw_ver);
 
-	strlcpy(hwinfo->fw_version, bld_label, sizeof(hwinfo->fw_version));
+	strscpy(hwinfo->fw_version, bld_label, sizeof(hwinfo->fw_version));
 	hwinfo->hw_version = hw_ver;
 
 	return 0;
diff --git a/drivers/net/wireless/realtek/rtl818x/rtl8187/leds.c b/drivers/net/wireless/realtek/rtl818x/rtl8187/leds.c
index 49421d10e22b..f7d95c9624a0 100644
--- a/drivers/net/wireless/realtek/rtl818x/rtl8187/leds.c
+++ b/drivers/net/wireless/realtek/rtl818x/rtl8187/leds.c
@@ -143,7 +143,7 @@ static int rtl8187_register_led(struct ieee80211_hw *dev,
 	led->dev = dev;
 	led->ledpin = ledpin;
 	led->is_radio = is_radio;
-	strlcpy(led->name, name, sizeof(led->name));
+	strscpy(led->name, name, sizeof(led->name));
 
 	led->led_dev.name = led->name;
 	led->led_dev.default_trigger = default_trigger;
diff --git a/drivers/net/wireless/wl3501_cs.c b/drivers/net/wireless/wl3501_cs.c
index dad38fc04243..1b532e00a56f 100644
--- a/drivers/net/wireless/wl3501_cs.c
+++ b/drivers/net/wireless/wl3501_cs.c
@@ -1441,7 +1441,7 @@ static void wl3501_detach(struct pcmcia_device *link)
 static int wl3501_get_name(struct net_device *dev, struct iw_request_info *info,
 			   union iwreq_data *wrqu, char *extra)
 {
-	strlcpy(wrqu->name, "IEEE 802.11-DS", sizeof(wrqu->name));
+	strscpy(wrqu->name, "IEEE 802.11-DS", sizeof(wrqu->name));
 	return 0;
 }
 
@@ -1652,7 +1652,7 @@ static int wl3501_set_nick(struct net_device *dev, struct iw_request_info *info,
 
 	if (wrqu->data.length > sizeof(this->nick))
 		return -E2BIG;
-	strlcpy(this->nick, extra, wrqu->data.length);
+	strscpy(this->nick, extra, wrqu->data.length);
 	return 0;
 }
 
@@ -1661,7 +1661,7 @@ static int wl3501_get_nick(struct net_device *dev, struct iw_request_info *info,
 {
 	struct wl3501_card *this = netdev_priv(dev);
 
-	strlcpy(extra, this->nick, 32);
+	strscpy(extra, this->nick, 32);
 	wrqu->data.length = strlen(extra);
 	return 0;
 }
@@ -1965,7 +1965,7 @@ static int wl3501_config(struct pcmcia_device *link)
 	this->firmware_date[0]	= '\0';
 	this->rssi		= 255;
 	this->chan		= iw_default_channel(this->reg_domain);
-	strlcpy(this->nick, "Planet WL3501", sizeof(this->nick));
+	strscpy(this->nick, "Planet WL3501", sizeof(this->nick));
 	spin_lock_init(&this->lock);
 	init_waitqueue_head(&this->wait);
 	netif_start_queue(dev);
-- 
2.35.1

