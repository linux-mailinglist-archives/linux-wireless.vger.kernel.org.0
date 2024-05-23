Return-Path: <linux-wireless+bounces-8024-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F186B8CD61B
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 16:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26F011C20C7C
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 14:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF1C1879;
	Thu, 23 May 2024 14:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fg5Rec6J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233B4A943
	for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 14:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716475717; cv=none; b=rFzdn0saUOlwqcK8lu63xz45ht9nL3Cdq+FxLL9Xj6UB4QOcYIUog6uM4kdxW8l9rawT5O3Bt4X+JcN83Bf113fQAIT+Tcc/Pse7okaC3kBh4Q3BeS1GHCeAJTE4u0l1KKn86WzTYBzrW1LgXffN0zVKN2Qve9F1UX0cS+ffmEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716475717; c=relaxed/simple;
	bh=z1EU5onxY+4VRR4wGBk8a55nph9mSXrgGuOf1VbEUPM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Dbq2YwMnbXbU4MQZmXJ+6956geHjQVDOaxm9XXQUqoZlXZkPsq7M8mcMlgn/R1CQ1Uzv05hR07uTx0vrXBO8H/DSKIqrc3PjlAnmTDLwwv/yyutObnoTshJ85JsVFmQxlrDKo5GJBaVSCVBhWSxZXrC33iaGJKSXB2roF+pqNHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fg5Rec6J; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56e1bbdb362so9607053a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 07:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716475713; x=1717080513; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DRjYSUxATe8PYnj530YngRG7+vfA5eScKEvC8gxiiAg=;
        b=fg5Rec6JCmGHnDQXIYC8ZolrTaSTsHhps2OOdCk3b1cS00Ugr3wPRiS6Q2vICRL690
         ox2iImciibmF/dcozy8WuvVRapBBrKOqckrFHGHPLpRuifF4de9R7H7oEX1H7BXxGZh4
         FM3aCIVbDZON+0HJyczl30dxGY2l8+1HnpHpXUaJ+7t8ivryUcHU2YG3G95I1/XSV1cx
         D1SBJUX6IcMgNmvt3jgwCNZAodeJ9I5L5mx44MF4uQyqTMRuJYViBieYYHW7yyDc3wIU
         si9Rwj9909g5KbWCUUKNnKogdxZrz0nE2ld1ck2vTW3EmY8nynA+X46xCXlCja8qqPdn
         RZ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716475713; x=1717080513;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DRjYSUxATe8PYnj530YngRG7+vfA5eScKEvC8gxiiAg=;
        b=uAK9X0Y2imqIQrUPrLcVs1eNSC9oUzbwxW1ptOY2ScotrJKaF3vT/MoOfCEetJlnXm
         N2HRggcvkecR1vz12xX/XqgiTARPCTVqD/07Qqu+/X3WlIsPdOgq2sDankouhEOoWSYM
         GVt6Yarb1TGMHMQfDYAlFw9qLWEd/R9iYq2akNHMYsqd/XU2adOKn3lqp2N60tcKQBQ9
         3m7A7fxFOfdWnLNJtN1pYJR1uYzszhpAvrti8QnECXh+inwg4AsNtbyySUEKYXNZFN0S
         ki+Sfi23BrYWkNzO2dkc2XnzAG0d4xVCIJfzBY5PsN61kT40TTSdC69IfM6f/FkzYoJB
         OavA==
X-Gm-Message-State: AOJu0YxUjxOjHdhIeIN+CtpucW2d9Yk+OTV/ii2STV16KSLHIumP0QUZ
	9RBLV9RkAyDBo3Py73AbZZsPIb/JzIyJOecpNM60srUEZtcZG6X5YFCIKA==
X-Google-Smtp-Source: AGHT+IGT/Kq3ecx4JjxRuBo29AOGWlBAK5YHzRlhHDFpXWnbwXhCcOnR2yNEufjCKqhCqkSO9yaGWQ==
X-Received: by 2002:a50:cbcc:0:b0:578:4b09:162f with SMTP id 4fb4d7f45d1cf-5784b09179dmr1083347a12.2.1716475713502;
        Thu, 23 May 2024 07:48:33 -0700 (PDT)
Received: from [192.168.0.50] ([81.196.40.5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733bed000esm20069284a12.54.2024.05.23.07.48.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 07:48:33 -0700 (PDT)
Message-ID: <1fdc83ac-4a6f-4645-8837-6e38683b6c84@gmail.com>
Date: Thu, 23 May 2024 17:48:32 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v7 11/12] wifi: rtlwifi: Add rtl8192du/sw.c
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
References: <8805826b-60b9-4026-9509-7d92c3a43577@gmail.com>
Content-Language: en-US
In-Reply-To: <8805826b-60b9-4026-9509-7d92c3a43577@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This contains the new module's entry point.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v7:
 - No change.

v6:
 - Update copyright year.
 - Remove some unused includes.
 - Make all functions use the prefix "rtl92du".
 - Return standard error numbers instead of 1.
 - Don't warn about the ips parameter being 0. It is 0 by default.
 - Update the commit message to reflect the absence of sw.h, removed in
   v4.

v5:
 - Call it 802.11n instead of 802.11an in the module description.

v4:
 - Delete unnecessary out of memory message.
 - Constify rtl8192du_hal_ops, rtl92du_interface_cfg, rtl92du_hal_cfg.
   (rtl92du_mod_params can't be const because module_param_named()
   doesn't accept it.)
 - Move MODULE_* to the bottom of sw.c.
 - Delete sw.h and the global mutexes. The mutexes were moved to
   struct rtl_priv. sw.h is unnecessary now.
 - Add functions to initialise and free the formerly global variables:
	curveindex_2g
	curveindex_5g
	mutex_for_hw_init
	mutex_for_power_on_off

v3:
 - Add USB ID 2001:330c found by Zenm Chen.

v2:
 - Patch is new in v2, split from patch 3/3 in v1.
---
 .../wireless/realtek/rtlwifi/rtl8192du/sw.c   | 395 ++++++++++++++++++
 1 file changed, 395 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/sw.c

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/sw.c
new file mode 100644
index 000000000000..d069a81ac617
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/sw.c
@@ -0,0 +1,395 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2024  Realtek Corporation.*/
+
+#include "../wifi.h"
+#include "../core.h"
+#include "../usb.h"
+#include "../base.h"
+#include "../rtl8192d/reg.h"
+#include "../rtl8192d/def.h"
+#include "../rtl8192d/fw_common.h"
+#include "../rtl8192d/hw_common.h"
+#include "../rtl8192d/phy_common.h"
+#include "../rtl8192d/trx_common.h"
+#include "phy.h"
+#include "dm.h"
+#include "hw.h"
+#include "trx.h"
+#include "led.h"
+
+#include <linux/module.h>
+
+static struct usb_interface *rtl92du_get_other_intf(struct ieee80211_hw *hw)
+{
+	struct usb_interface *intf;
+	struct usb_device *udev;
+	u8 other_interfaceindex;
+
+	/* See SET_IEEE80211_DEV(hw, &intf->dev); in usb.c */
+	intf = container_of_const(wiphy_dev(hw->wiphy), struct usb_interface, dev);
+
+	if (intf->altsetting[0].desc.bInterfaceNumber == 0)
+		other_interfaceindex = 1;
+	else
+		other_interfaceindex = 0;
+
+	udev = interface_to_usbdev(intf);
+
+	return usb_ifnum_to_if(udev, other_interfaceindex);
+}
+
+static int rtl92du_init_shared_data(struct ieee80211_hw *hw)
+{
+	struct usb_interface *other_intf = rtl92du_get_other_intf(hw);
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_priv *other_rtlpriv = NULL;
+	struct ieee80211_hw *other_hw = NULL;
+
+	if (other_intf)
+		other_hw = usb_get_intfdata(other_intf);
+
+	if (other_hw) {
+		/* The other interface was already probed. */
+		other_rtlpriv = rtl_priv(other_hw);
+		rtlpriv->curveindex_2g = other_rtlpriv->curveindex_2g;
+		rtlpriv->curveindex_5g = other_rtlpriv->curveindex_5g;
+		rtlpriv->mutex_for_power_on_off = other_rtlpriv->mutex_for_power_on_off;
+		rtlpriv->mutex_for_hw_init = other_rtlpriv->mutex_for_hw_init;
+
+		if (!rtlpriv->curveindex_2g || !rtlpriv->curveindex_5g ||
+		    !rtlpriv->mutex_for_power_on_off || !rtlpriv->mutex_for_hw_init)
+			return -ENOMEM;
+
+		return 0;
+	}
+
+	/* The other interface doesn't exist or was not probed yet. */
+	rtlpriv->curveindex_2g = kcalloc(TARGET_CHNL_NUM_2G,
+					 sizeof(*rtlpriv->curveindex_2g),
+					 GFP_KERNEL);
+	rtlpriv->curveindex_5g = kcalloc(TARGET_CHNL_NUM_5G,
+					 sizeof(*rtlpriv->curveindex_5g),
+					 GFP_KERNEL);
+	rtlpriv->mutex_for_power_on_off =
+		kzalloc(sizeof(*rtlpriv->mutex_for_power_on_off), GFP_KERNEL);
+	rtlpriv->mutex_for_hw_init =
+		kzalloc(sizeof(*rtlpriv->mutex_for_hw_init), GFP_KERNEL);
+
+	if (!rtlpriv->curveindex_2g || !rtlpriv->curveindex_5g ||
+	    !rtlpriv->mutex_for_power_on_off || !rtlpriv->mutex_for_hw_init) {
+		kfree(rtlpriv->curveindex_2g);
+		kfree(rtlpriv->curveindex_5g);
+		kfree(rtlpriv->mutex_for_power_on_off);
+		kfree(rtlpriv->mutex_for_hw_init);
+		rtlpriv->curveindex_2g = NULL;
+		rtlpriv->curveindex_5g = NULL;
+		rtlpriv->mutex_for_power_on_off = NULL;
+		rtlpriv->mutex_for_hw_init = NULL;
+		return -ENOMEM;
+	}
+
+	mutex_init(rtlpriv->mutex_for_power_on_off);
+	mutex_init(rtlpriv->mutex_for_hw_init);
+
+	return 0;
+}
+
+static void rtl92du_deinit_shared_data(struct ieee80211_hw *hw)
+{
+	struct usb_interface *other_intf = rtl92du_get_other_intf(hw);
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+
+	if (!other_intf || !usb_get_intfdata(other_intf)) {
+		/* The other interface doesn't exist or was already disconnected. */
+		kfree(rtlpriv->curveindex_2g);
+		kfree(rtlpriv->curveindex_5g);
+		if (rtlpriv->mutex_for_power_on_off)
+			mutex_destroy(rtlpriv->mutex_for_power_on_off);
+		if (rtlpriv->mutex_for_hw_init)
+			mutex_destroy(rtlpriv->mutex_for_hw_init);
+		kfree(rtlpriv->mutex_for_power_on_off);
+		kfree(rtlpriv->mutex_for_hw_init);
+	}
+}
+
+static int rtl92du_init_sw_vars(struct ieee80211_hw *hw)
+{
+	const char *fw_name = "rtlwifi/rtl8192dufw.bin";
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	int err;
+
+	err = rtl92du_init_shared_data(hw);
+	if (err)
+		return err;
+
+	rtlpriv->dm.dm_initialgain_enable = true;
+	rtlpriv->dm.dm_flag = 0;
+	rtlpriv->dm.disable_framebursting = false;
+	rtlpriv->dm.thermalvalue = 0;
+	rtlpriv->dm.useramask = true;
+
+	/* dual mac */
+	if (rtlpriv->rtlhal.current_bandtype == BAND_ON_5G)
+		rtlpriv->phy.current_channel = 36;
+	else
+		rtlpriv->phy.current_channel = 1;
+
+	if (rtlpriv->rtlhal.macphymode != SINGLEMAC_SINGLEPHY)
+		rtlpriv->rtlhal.disable_amsdu_8k = true;
+
+	/* for LPS & IPS */
+	rtlpriv->psc.inactiveps = rtlpriv->cfg->mod_params->inactiveps;
+	rtlpriv->psc.swctrl_lps = rtlpriv->cfg->mod_params->swctrl_lps;
+	rtlpriv->psc.fwctrl_lps = rtlpriv->cfg->mod_params->fwctrl_lps;
+
+	/* for early mode */
+	rtlpriv->rtlhal.earlymode_enable = false;
+
+	/* for firmware buf */
+	rtlpriv->rtlhal.pfirmware = kmalloc(0x8000, GFP_KERNEL);
+	if (!rtlpriv->rtlhal.pfirmware)
+		return -ENOMEM;
+
+	rtlpriv->max_fw_size = 0x8000;
+	pr_info("Driver for Realtek RTL8192DU WLAN interface\n");
+	pr_info("Loading firmware file %s\n", fw_name);
+
+	/* request fw */
+	err = request_firmware_nowait(THIS_MODULE, 1, fw_name,
+				      rtlpriv->io.dev, GFP_KERNEL, hw,
+				      rtl_fw_cb);
+	if (err) {
+		pr_err("Failed to request firmware!\n");
+		kfree(rtlpriv->rtlhal.pfirmware);
+		rtlpriv->rtlhal.pfirmware = NULL;
+		return err;
+	}
+
+	return 0;
+}
+
+static void rtl92du_deinit_sw_vars(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+
+	kfree(rtlpriv->rtlhal.pfirmware);
+	rtlpriv->rtlhal.pfirmware = NULL;
+
+	rtl92du_deinit_shared_data(hw);
+}
+
+static const struct rtl_hal_ops rtl8192du_hal_ops = {
+	.init_sw_vars = rtl92du_init_sw_vars,
+	.deinit_sw_vars = rtl92du_deinit_sw_vars,
+	.read_chip_version = rtl92du_read_chip_version,
+	.read_eeprom_info = rtl92d_read_eeprom_info,
+	.hw_init = rtl92du_hw_init,
+	.hw_disable = rtl92du_card_disable,
+	.enable_interrupt = rtl92du_enable_interrupt,
+	.disable_interrupt = rtl92du_disable_interrupt,
+	.set_network_type = rtl92du_set_network_type,
+	.set_chk_bssid = rtl92du_set_check_bssid,
+	.set_qos = rtl92d_set_qos,
+	.set_bcn_reg = rtl92du_set_beacon_related_registers,
+	.set_bcn_intv = rtl92du_set_beacon_interval,
+	.update_interrupt_mask = rtl92du_update_interrupt_mask,
+	.get_hw_reg = rtl92du_get_hw_reg,
+	.set_hw_reg = rtl92du_set_hw_reg,
+	.update_rate_tbl = rtl92d_update_hal_rate_tbl,
+	.fill_tx_desc = rtl92du_tx_fill_desc,
+	.query_rx_desc = rtl92d_rx_query_desc,
+	.set_channel_access = rtl92d_update_channel_access_setting,
+	.radio_onoff_checking = rtl92d_gpio_radio_on_off_checking,
+	.set_bw_mode = rtl92du_phy_set_bw_mode,
+	.switch_channel = rtl92du_phy_sw_chnl,
+	.dm_watchdog = rtl92du_dm_watchdog,
+	.scan_operation_backup = rtl_phy_scan_operation_backup,
+	.set_rf_power_state = rtl92du_phy_set_rf_power_state,
+	.led_control = rtl92du_led_control,
+	.set_desc = rtl92d_set_desc,
+	.get_desc = rtl92d_get_desc,
+	.enable_hw_sec = rtl92d_enable_hw_security_config,
+	.set_key = rtl92d_set_key,
+	.get_bbreg = rtl92du_phy_query_bb_reg,
+	.set_bbreg = rtl92du_phy_set_bb_reg,
+	.get_rfreg = rtl92d_phy_query_rf_reg,
+	.set_rfreg = rtl92d_phy_set_rf_reg,
+	.linked_set_reg = rtl92du_linked_set_reg,
+	.fill_h2c_cmd = rtl92d_fill_h2c_cmd,
+	.get_btc_status = rtl_btc_status_false,
+	.phy_iq_calibrate = rtl92du_phy_iq_calibrate,
+	.phy_lc_calibrate = rtl92du_phy_lc_calibrate,
+};
+
+static struct rtl_mod_params rtl92du_mod_params = {
+	.sw_crypto = false,
+	.inactiveps = false,
+	.swctrl_lps = false,
+	.debug_level = 0,
+	.debug_mask = 0,
+};
+
+static const struct rtl_hal_usbint_cfg rtl92du_interface_cfg = {
+	/* rx */
+	.rx_urb_num = 8,
+	.rx_max_size = 15360,
+	.usb_rx_hdl = NULL,
+	.usb_rx_segregate_hdl = NULL,
+	/* tx */
+	.usb_tx_cleanup = rtl92du_tx_cleanup,
+	.usb_tx_post_hdl = rtl92du_tx_post_hdl,
+	.usb_tx_aggregate_hdl = rtl92du_tx_aggregate_hdl,
+	.usb_endpoint_mapping = rtl92du_endpoint_mapping,
+	.usb_mq_to_hwq = rtl92du_mq_to_hwq,
+};
+
+static const struct rtl_hal_cfg rtl92du_hal_cfg = {
+	.name = "rtl8192du",
+	.ops = &rtl8192du_hal_ops,
+	.mod_params = &rtl92du_mod_params,
+	.usb_interface_cfg = &rtl92du_interface_cfg,
+
+	.maps[SYS_ISO_CTRL] = REG_SYS_ISO_CTRL,
+	.maps[SYS_FUNC_EN] = REG_SYS_FUNC_EN,
+	.maps[SYS_CLK] = REG_SYS_CLKR,
+	.maps[MAC_RCR_AM] = RCR_AM,
+	.maps[MAC_RCR_AB] = RCR_AB,
+	.maps[MAC_RCR_ACRC32] = RCR_ACRC32,
+	.maps[MAC_RCR_ACF] = RCR_ACF,
+	.maps[MAC_RCR_AAP] = RCR_AAP,
+
+	.maps[EFUSE_TEST] = REG_EFUSE_TEST,
+	.maps[EFUSE_ACCESS] = REG_EFUSE_ACCESS,
+	.maps[EFUSE_CTRL] = REG_EFUSE_CTRL,
+	.maps[EFUSE_CLK] = 0,	/* just for 92se */
+	.maps[EFUSE_CLK_CTRL] = REG_EFUSE_CTRL,
+	.maps[EFUSE_PWC_EV12V] = PWC_EV12V,
+	.maps[EFUSE_FEN_ELDR] = FEN_ELDR,
+	.maps[EFUSE_LOADER_CLK_EN] = 0,
+	.maps[EFUSE_ANA8M] = 0,	/* just for 92se */
+	.maps[EFUSE_HWSET_MAX_SIZE] = HWSET_MAX_SIZE,
+	.maps[EFUSE_MAX_SECTION_MAP] = EFUSE_MAX_SECTION,
+	.maps[EFUSE_REAL_CONTENT_SIZE] = EFUSE_REAL_CONTENT_LEN,
+
+	.maps[RWCAM] = REG_CAMCMD,
+	.maps[WCAMI] = REG_CAMWRITE,
+	.maps[RCAMO] = REG_CAMREAD,
+	.maps[CAMDBG] = REG_CAMDBG,
+	.maps[SECR] = REG_SECCFG,
+	.maps[SEC_CAM_NONE] = CAM_NONE,
+	.maps[SEC_CAM_WEP40] = CAM_WEP40,
+	.maps[SEC_CAM_TKIP] = CAM_TKIP,
+	.maps[SEC_CAM_AES] = CAM_AES,
+	.maps[SEC_CAM_WEP104] = CAM_WEP104,
+
+	.maps[RTL_IMR_BCNDMAINT6] = IMR_BCNDMAINT6,
+	.maps[RTL_IMR_BCNDMAINT5] = IMR_BCNDMAINT5,
+	.maps[RTL_IMR_BCNDMAINT4] = IMR_BCNDMAINT4,
+	.maps[RTL_IMR_BCNDMAINT3] = IMR_BCNDMAINT3,
+	.maps[RTL_IMR_BCNDMAINT2] = IMR_BCNDMAINT2,
+	.maps[RTL_IMR_BCNDMAINT1] = IMR_BCNDMAINT1,
+	.maps[RTL_IMR_BCNDOK8] = IMR_BCNDOK8,
+	.maps[RTL_IMR_BCNDOK7] = IMR_BCNDOK7,
+	.maps[RTL_IMR_BCNDOK6] = IMR_BCNDOK6,
+	.maps[RTL_IMR_BCNDOK5] = IMR_BCNDOK5,
+	.maps[RTL_IMR_BCNDOK4] = IMR_BCNDOK4,
+	.maps[RTL_IMR_BCNDOK3] = IMR_BCNDOK3,
+	.maps[RTL_IMR_BCNDOK2] = IMR_BCNDOK2,
+	.maps[RTL_IMR_BCNDOK1] = IMR_BCNDOK1,
+	.maps[RTL_IMR_TIMEOUT2] = IMR_TIMEOUT2,
+	.maps[RTL_IMR_TIMEOUT1] = IMR_TIMEOUT1,
+
+	.maps[RTL_IMR_TXFOVW] = IMR_TXFOVW,
+	.maps[RTL_IMR_PSTIMEOUT] = IMR_PSTIMEOUT,
+	.maps[RTL_IMR_BCNINT] = IMR_BCNINT,
+	.maps[RTL_IMR_RXFOVW] = IMR_RXFOVW,
+	.maps[RTL_IMR_RDU] = IMR_RDU,
+	.maps[RTL_IMR_ATIMEND] = IMR_ATIMEND,
+	.maps[RTL_IMR_BDOK] = IMR_BDOK,
+	.maps[RTL_IMR_MGNTDOK] = IMR_MGNTDOK,
+	.maps[RTL_IMR_TBDER] = IMR_TBDER,
+	.maps[RTL_IMR_HIGHDOK] = IMR_HIGHDOK,
+	.maps[RTL_IMR_TBDOK] = IMR_TBDOK,
+	.maps[RTL_IMR_BKDOK] = IMR_BKDOK,
+	.maps[RTL_IMR_BEDOK] = IMR_BEDOK,
+	.maps[RTL_IMR_VIDOK] = IMR_VIDOK,
+	.maps[RTL_IMR_VODOK] = IMR_VODOK,
+	.maps[RTL_IMR_ROK] = IMR_ROK,
+	.maps[RTL_IBSS_INT_MASKS] = (IMR_BCNINT | IMR_TBDOK | IMR_TBDER),
+
+	.maps[RTL_RC_CCK_RATE1M] = DESC_RATE1M,
+	.maps[RTL_RC_CCK_RATE2M] = DESC_RATE2M,
+	.maps[RTL_RC_CCK_RATE5_5M] = DESC_RATE5_5M,
+	.maps[RTL_RC_CCK_RATE11M] = DESC_RATE11M,
+	.maps[RTL_RC_OFDM_RATE6M] = DESC_RATE6M,
+	.maps[RTL_RC_OFDM_RATE9M] = DESC_RATE9M,
+	.maps[RTL_RC_OFDM_RATE12M] = DESC_RATE12M,
+	.maps[RTL_RC_OFDM_RATE18M] = DESC_RATE18M,
+	.maps[RTL_RC_OFDM_RATE24M] = DESC_RATE24M,
+	.maps[RTL_RC_OFDM_RATE36M] = DESC_RATE36M,
+	.maps[RTL_RC_OFDM_RATE48M] = DESC_RATE48M,
+	.maps[RTL_RC_OFDM_RATE54M] = DESC_RATE54M,
+
+	.maps[RTL_RC_HT_RATEMCS7] = DESC_RATEMCS7,
+	.maps[RTL_RC_HT_RATEMCS15] = DESC_RATEMCS15,
+};
+
+module_param_named(swenc, rtl92du_mod_params.sw_crypto, bool, 0444);
+module_param_named(debug_level, rtl92du_mod_params.debug_level, int, 0644);
+module_param_named(ips, rtl92du_mod_params.inactiveps, bool, 0444);
+module_param_named(swlps, rtl92du_mod_params.swctrl_lps, bool, 0444);
+module_param_named(debug_mask, rtl92du_mod_params.debug_mask, ullong, 0644);
+MODULE_PARM_DESC(swenc, "Set to 1 for software crypto (default 0)\n");
+MODULE_PARM_DESC(ips, "Set to 0 to not use link power save (default 0)\n");
+MODULE_PARM_DESC(swlps, "Set to 1 to use SW control power save (default 0)\n");
+MODULE_PARM_DESC(debug_level, "Set debug level (0-5) (default 0)");
+MODULE_PARM_DESC(debug_mask, "Set debug mask (default 0)");
+
+#define USB_VENDOR_ID_REALTEK		0x0bda
+
+static const struct usb_device_id rtl8192d_usb_ids[] = {
+	{RTL_USB_DEVICE(USB_VENDOR_ID_REALTEK, 0x8193, rtl92du_hal_cfg)},
+	{RTL_USB_DEVICE(USB_VENDOR_ID_REALTEK, 0x8194, rtl92du_hal_cfg)},
+	{RTL_USB_DEVICE(USB_VENDOR_ID_REALTEK, 0x8111, rtl92du_hal_cfg)},
+	{RTL_USB_DEVICE(USB_VENDOR_ID_REALTEK, 0x0193, rtl92du_hal_cfg)},
+	{RTL_USB_DEVICE(USB_VENDOR_ID_REALTEK, 0x8171, rtl92du_hal_cfg)},
+	{RTL_USB_DEVICE(USB_VENDOR_ID_REALTEK, 0xe194, rtl92du_hal_cfg)},
+	{RTL_USB_DEVICE(0x2019, 0xab2c, rtl92du_hal_cfg)},
+	{RTL_USB_DEVICE(0x2019, 0xab2d, rtl92du_hal_cfg)},
+	{RTL_USB_DEVICE(0x2019, 0x4903, rtl92du_hal_cfg)},
+	{RTL_USB_DEVICE(0x2019, 0x4904, rtl92du_hal_cfg)},
+	{RTL_USB_DEVICE(0x07b8, 0x8193, rtl92du_hal_cfg)},
+	{RTL_USB_DEVICE(0x20f4, 0x664b, rtl92du_hal_cfg)},
+	{RTL_USB_DEVICE(0x04dd, 0x954f, rtl92du_hal_cfg)},
+	{RTL_USB_DEVICE(0x04dd, 0x96a6, rtl92du_hal_cfg)},
+	{RTL_USB_DEVICE(0x050d, 0x110a, rtl92du_hal_cfg)},
+	{RTL_USB_DEVICE(0x050d, 0x1105, rtl92du_hal_cfg)},
+	{RTL_USB_DEVICE(0x050d, 0x120a, rtl92du_hal_cfg)},
+	{RTL_USB_DEVICE(0x1668, 0x8102, rtl92du_hal_cfg)},
+	{RTL_USB_DEVICE(0x0930, 0x0a0a, rtl92du_hal_cfg)},
+	{RTL_USB_DEVICE(0x2001, 0x330c, rtl92du_hal_cfg)},
+	{}
+};
+
+MODULE_DEVICE_TABLE(usb, rtl8192d_usb_ids);
+
+static int rtl8192du_probe(struct usb_interface *intf,
+			   const struct usb_device_id *id)
+{
+	return rtl_usb_probe(intf, id, &rtl92du_hal_cfg);
+}
+
+static struct usb_driver rtl8192du_driver = {
+	.name = "rtl8192du",
+	.probe = rtl8192du_probe,
+	.disconnect = rtl_usb_disconnect,
+	.id_table = rtl8192d_usb_ids,
+	.disable_hub_initiated_lpm = 1,
+};
+
+module_usb_driver(rtl8192du_driver);
+
+MODULE_AUTHOR("Bitterblue Smith	<rtl8821cerfe2@gmail.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Realtek 8192DU 802.11n Dual Mac USB wireless");
+MODULE_FIRMWARE("rtlwifi/rtl8192dufw.bin");
-- 
2.45.1


