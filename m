Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF61B1322F5
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2020 10:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbgAGJwF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Jan 2020 04:52:05 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:37901 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgAGJwF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Jan 2020 04:52:05 -0500
X-Originating-IP: 83.155.44.161
Received: from classic (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
        (Authenticated sender: hadess@hadess.net)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 2DBA02000F;
        Tue,  7 Jan 2020 09:52:02 +0000 (UTC)
Message-ID: <d96a7108ce72bd00c58a07fbed529ab4b1702466.camel@hadess.net>
Subject: [PATCH] rtl8188eu: Add rtw_led_enable module parameter
From:   Bastien Nocera <hadess@hadess.net>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 07 Jan 2020 10:52:02 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Make it possible to disable the LED, as it can be pretty annoying
depending on where it's located.

Signed-off-by: Bastien Nocera <hadess@hadess.net>

---
 drivers/staging/rtl8188eu/core/rtw_led.c      | 6 ++++++
 drivers/staging/rtl8188eu/include/drv_types.h | 2 ++
 drivers/staging/rtl8188eu/os_dep/os_intfs.c   | 5 +++++
 3 files changed, 13 insertions(+)

diff --git a/drivers/staging/rtl8188eu/core/rtw_led.c b/drivers/staging/rtl8188eu/core/rtw_led.c
index d1406cc99768..75a859accb7e 100644
--- a/drivers/staging/rtl8188eu/core/rtw_led.c
+++ b/drivers/staging/rtl8188eu/core/rtw_led.c
@@ -467,10 +467,16 @@ void blink_handler(struct LED_871x *pLed)
 
 void led_control_8188eu(struct adapter *padapter, enum LED_CTL_MODE LedAction)
 {
+	struct registry_priv *registry_par;
+
 	if (padapter->bSurpriseRemoved || padapter->bDriverStopped ||
 	    !padapter->hw_init_completed)
 		return;
 
+	registry_par = &padapter->registrypriv;
+	if (!registry_par->led_enable)
+		return;
+
 	if ((padapter->pwrctrlpriv.rf_pwrstate != rf_on &&
 	     padapter->pwrctrlpriv.rfoff_reason > RF_CHANGE_BY_PS) &&
 	    (LedAction == LED_CTL_TX || LedAction == LED_CTL_RX ||
diff --git a/drivers/staging/rtl8188eu/include/drv_types.h b/drivers/staging/rtl8188eu/include/drv_types.h
index 35c0946bc65d..4ca828141d3f 100644
--- a/drivers/staging/rtl8188eu/include/drv_types.h
+++ b/drivers/staging/rtl8188eu/include/drv_types.h
@@ -67,6 +67,8 @@ struct registry_priv {
 	u8	wmm_enable;
 	u8	uapsd_enable;
 
+	u8	led_enable;
+
 	struct wlan_bssid_ex    dev_network;
 
 	u8	ht_enable;
diff --git a/drivers/staging/rtl8188eu/os_dep/os_intfs.c b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
index 8907bf6bb7ff..ba55ae741215 100644
--- a/drivers/staging/rtl8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
@@ -47,6 +47,8 @@ static int rtw_acm_method;/*  0:By SW 1:By HW. */
 static int rtw_wmm_enable = 1;/*  default is set to enable the wmm. */
 static int rtw_uapsd_enable;
 
+static int rtw_led_enable = 1;
+
 static int rtw_ht_enable = 1;
 /* 0 :disable, bit(0): enable 2.4g, bit(1): enable 5g */
 static int rtw_cbw40_enable = 3;
@@ -98,6 +100,7 @@ module_param(rtw_channel, int, 0644);
 module_param(rtw_wmm_enable, int, 0644);
 module_param(rtw_vrtl_carrier_sense, int, 0644);
 module_param(rtw_vcs_type, int, 0644);
+module_param(rtw_led_enable, int, 0644);
 module_param(rtw_ht_enable, int, 0644);
 module_param(rtw_cbw40_enable, int, 0644);
 module_param(rtw_ampdu_enable, int, 0644);
@@ -162,6 +165,8 @@ static void loadparam(struct adapter *padapter, struct net_device *pnetdev)
 	registry_par->wmm_enable = (u8)rtw_wmm_enable;
 	registry_par->uapsd_enable = (u8)rtw_uapsd_enable;
 
+	registry_par->led_enable = (u8)rtw_led_enable;
+
 	registry_par->ht_enable = (u8)rtw_ht_enable;
 	registry_par->cbw40_enable = (u8)rtw_cbw40_enable;
 	registry_par->ampdu_enable = (u8)rtw_ampdu_enable;

