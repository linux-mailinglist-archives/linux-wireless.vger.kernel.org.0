Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED047D0ECD
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2019 14:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730901AbfJIMcd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Oct 2019 08:32:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58620 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727029AbfJIMcd (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Oct 2019 08:32:33 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C4BE27F74F;
        Wed,  9 Oct 2019 12:32:32 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-117-32.ams2.redhat.com [10.36.117.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 75EB51048128;
        Wed,  9 Oct 2019 12:32:31 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Bastien Nocera <hadess@hadess.net>,
        Denis Efremov <efremov@linux.com>,
        linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH 3/5] staging: rtl8723bs: Remove phy_Config*WithParaFile() configuration leftovers
Date:   Wed,  9 Oct 2019 14:32:21 +0200
Message-Id: <20191009123223.163241-3-hdegoede@redhat.com>
In-Reply-To: <20191009123223.163241-1-hdegoede@redhat.com>
References: <20191009123223.163241-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.71]); Wed, 09 Oct 2019 12:32:32 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Now that the phy_Config*WithParaFile() functions have been removed nothing
is using these module-parameters and defines anymore.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/staging/rtl8723bs/include/drv_types.h |  4 ----
 .../staging/rtl8723bs/include/rtl8723b_hal.h  | 15 --------------
 drivers/staging/rtl8723bs/os_dep/os_intfs.c   | 20 -------------------
 3 files changed, 39 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/staging/rtl8723bs/include/drv_types.h
index 8d7fce1e39b7..6ec9087f2eb1 100644
--- a/drivers/staging/rtl8723bs/include/drv_types.h
+++ b/drivers/staging/rtl8723bs/include/drv_types.h
@@ -197,9 +197,6 @@ struct registry_priv
 	u8 RFE_Type;
 	u8  check_fw_ps;
 
-	u8 load_phy_file;
-	u8 RegDecryptCustomFile;
-
 #ifdef CONFIG_MULTI_VIR_IFACES
 	u8 ext_iface_num;/* primary/secondary iface is excluded */
 #endif
@@ -693,7 +690,6 @@ void rtw_indicate_wx_disassoc_event(struct adapter *padapter);
 void indicate_wx_scan_complete_event(struct adapter *padapter);
 int rtw_change_ifname(struct adapter *padapter, const char *ifname);
 
-extern char *rtw_phy_file_path;
 extern char *rtw_initmac;
 extern int rtw_mc2u_disable;
 extern int rtw_ht_enable;
diff --git a/drivers/staging/rtl8723bs/include/rtl8723b_hal.h b/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
index 8f00ced1c697..f36516fa84c7 100644
--- a/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
+++ b/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
@@ -20,21 +20,6 @@
 #include "hal_phy_reg_8723b.h"
 #include "hal_phy_cfg.h"
 
-/*  */
-/* RTL8723B From file */
-/*  */
-#define RTL8723B_FW_IMG      "rtl8723b/FW_NIC.bin"
-#define RTL8723B_FW_WW_IMG   "rtl8723b/FW_WoWLAN.bin"
-#define RTL8723B_PHY_REG     "rtl8723b/PHY_REG.txt"
-#define RTL8723B_PHY_RADIO_A "rtl8723b/RadioA.txt"
-#define RTL8723B_PHY_RADIO_B "rtl8723b/RadioB.txt"
-#define RTL8723B_TXPWR_TRACK "rtl8723b/TxPowerTrack.txt"
-#define RTL8723B_AGC_TAB     "rtl8723b/AGC_TAB.txt"
-#define RTL8723B_PHY_MACREG  "rtl8723b/MAC_REG.txt"
-#define RTL8723B_PHY_REG_PG  "rtl8723b/PHY_REG_PG.txt"
-#define RTL8723B_PHY_REG_MP  "rtl8723b/PHY_REG_MP.txt"
-#define RTL8723B_TXPWR_LMT   "rtl8723b/TXPWR_LMT.txt"
-
 /*  */
 /* RTL8723B From header */
 /*  */
diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index 5044f7373b8b..cb4c86728d26 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -201,24 +201,6 @@ MODULE_PARM_DESC(rtw_tx_pwr_lmt_enable, "0:Disable, 1:Enable, 2: Depend on efuse
 module_param(rtw_tx_pwr_by_rate, int, 0644);
 MODULE_PARM_DESC(rtw_tx_pwr_by_rate, "0:Disable, 1:Enable, 2: Depend on efuse");
 
-char *rtw_phy_file_path = "";
-module_param(rtw_phy_file_path, charp, 0644);
-MODULE_PARM_DESC(rtw_phy_file_path, "The path of phy parameter");
-/*  PHY FILE Bit Map */
-/*  BIT0 - MAC,				0: non-support, 1: support */
-/*  BIT1 - BB,					0: non-support, 1: support */
-/*  BIT2 - BB_PG,				0: non-support, 1: support */
-/*  BIT3 - BB_MP,				0: non-support, 1: support */
-/*  BIT4 - RF,					0: non-support, 1: support */
-/*  BIT5 - RF_TXPWR_TRACK,	0: non-support, 1: support */
-/*  BIT6 - RF_TXPWR_LMT,		0: non-support, 1: support */
-static int rtw_load_phy_file = (BIT2 | BIT6);
-module_param(rtw_load_phy_file, int, 0644);
-MODULE_PARM_DESC(rtw_load_phy_file, "PHY File Bit Map");
-static int rtw_decrypt_phy_file;
-module_param(rtw_decrypt_phy_file, int, 0644);
-MODULE_PARM_DESC(rtw_decrypt_phy_file, "Enable Decrypt PHY File");
-
 int _netdev_open(struct net_device *pnetdev);
 int netdev_open (struct net_device *pnetdev);
 static int netdev_close (struct net_device *pnetdev);
@@ -321,8 +303,6 @@ static void loadparam(struct adapter *padapter, _nic_hdl pnetdev)
 	registry_par->bEn_RFE = 1;
 	registry_par->RFE_Type = 64;
 
-	registry_par->load_phy_file = (u8)rtw_load_phy_file;
-	registry_par->RegDecryptCustomFile = (u8)rtw_decrypt_phy_file;
 	registry_par->qos_opt_enable = (u8)rtw_qos_opt_enable;
 
 	registry_par->hiq_filter = (u8)rtw_hiq_filter;
-- 
2.23.0

