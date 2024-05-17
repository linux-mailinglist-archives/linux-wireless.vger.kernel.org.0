Return-Path: <linux-wireless+bounces-7812-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 498858C8DA3
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 23:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B75C81F22543
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 21:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2936D38F9A;
	Fri, 17 May 2024 21:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Du4LP+p6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53871DFE1
	for <linux-wireless@vger.kernel.org>; Fri, 17 May 2024 21:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715980790; cv=none; b=AIwZrToAH1Xqgfb37/u/M3oJf0L+AqSxLu1jGMZJH01nKQl+frLcrIjjxBXXmk9H+psVuJgTARW4NUMTMmZumS9evwgJxSO6OatUvYws/2/G5aKMzcHAuztiePJZJZgBNpHMEAlo5jndea4MuaL9uDl3jgpb0+/OuqmdFgKqcqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715980790; c=relaxed/simple;
	bh=EcrQI96MNtlUiySF/OWBsShAbeMAs/vvc39FXA6KZp4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ds9y8IjkhNaxuVxf102BwwjGR6JI1A3E9NBPUL38QO+fkxTxQ06RDx2JiVo3fuce87VFChkSjeUk+yDVLvdDIbJ/8fVWx5vC7YqPYbIB9+LYAOi2CvRYR92rjWPvD2MBM8hqYDFZ+CzgSjLLBxBUvbIjdYmuxxbdsZikwaOehks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Du4LP+p6; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5206a5854adso1363975e87.0
        for <linux-wireless@vger.kernel.org>; Fri, 17 May 2024 14:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715980786; x=1716585586; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q7lQP90U0xQnPvoGDMxUHcK/fYP9t740x5A4L9fJ0/I=;
        b=Du4LP+p6IgWvLEM7jc/fwxvimWyrHAWVv/cHE0Zv2Wvw8B06vCzj8eOlGpOZ+pIyiD
         SKMUptbP1IVR4utr9ULsjIs7POyAvgdRzELiVI8KW7YYU90fPkt46EU+g7/ftWrosctG
         qRykzVTnd8aJmcXmsVKM3v/vcMON3/iO6Br2xYw10kNQcc2YWj60OUH6reOUJq8bvKRR
         EtdM5aG2riapYm0AKYTNR8/5q/zxpNKRtR5JSdN7AfssIr742MrplkyFuGru7+A3nULr
         8PyXCBX3BAUmbKNp/TeN0Tg4l58dam1s4kujxAv+oKot3Pdu4F7PnjQ3X2so6zR1gGuC
         pDaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715980786; x=1716585586;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7lQP90U0xQnPvoGDMxUHcK/fYP9t740x5A4L9fJ0/I=;
        b=jjLPAO+sSAk6YXRZOA+9eJrf8mo8Nk94qqbiY2+++6F9WVf03rA5gK0El3zTF/yTNj
         ouKM7n4dXrHwI9bZwkLNwDRF3TtWv4I3j9bbMqYTDuHUQcnQv4gZ+6aE/tX/qmUZUQsA
         4q1dB5EEugMnyVQb3CcioAfjRUgkZAMr6rnLL55BXG9cztYx1FKMx5UMUPliyNJu0zT5
         7fOddMP3u11VBzyBR+HSCaaafIrz4hNqlE2EL9KK+AcTwDn/veqVw4+yhrLNO6QLWPUj
         b6UVcAPTqOlwruCrvSPTXYRZNXbB0KbTKhcqdNf052A4yaLVsdwr8jybc77/WeBnkEH2
         qI4w==
X-Gm-Message-State: AOJu0YwcHYutIZg9eLDj99iYAIzylrNcRBxlgCmYnOuSTKJ6VzdiWU29
	8mg0/ZOck7f6rT30qOcblyg5YtKV+hBv7lvpUBbVdRqmHSiC1d0VsvEvlNwW
X-Google-Smtp-Source: AGHT+IHm2KnX5D3nkUGXQM93xzrRrYB2ju8TdgLmnvJVJMWPRG8/tRL2x4wAmxPSNiSzyqfPyYPXUQ==
X-Received: by 2002:a05:6512:3992:b0:523:4e50:a980 with SMTP id 2adb3069b0e04-5234e50aad1mr12814874e87.60.1715980785772;
        Fri, 17 May 2024 14:19:45 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5cec3d9b5csm235491666b.16.2024.05.17.14.19.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 14:19:45 -0700 (PDT)
Message-ID: <c92faab2-0972-4af1-97e1-d13b3b11251c@gmail.com>
Date: Sat, 18 May 2024 00:19:44 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v6 10/11] wifi: rtlwifi: Add rtl8192du/sw.c
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
References: <0c22c048-c372-4596-b2c6-612c6ec7ab77@gmail.com>
Content-Language: en-US
In-Reply-To: <0c22c048-c372-4596-b2c6-612c6ec7ab77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This contains the new module's entry point.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
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
index 000000000000..1a184621c056
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
+	.read_eeprom_info = rtl92de_read_eeprom_info,
+	.hw_init = rtl92du_hw_init,
+	.hw_disable = rtl92du_card_disable,
+	.enable_interrupt = rtl92du_enable_interrupt,
+	.disable_interrupt = rtl92du_disable_interrupt,
+	.set_network_type = rtl92du_set_network_type,
+	.set_chk_bssid = rtl92du_set_check_bssid,
+	.set_qos = rtl92de_set_qos,
+	.set_bcn_reg = rtl92du_set_beacon_related_registers,
+	.set_bcn_intv = rtl92du_set_beacon_interval,
+	.update_interrupt_mask = rtl92du_update_interrupt_mask,
+	.get_hw_reg = rtl92du_get_hw_reg,
+	.set_hw_reg = rtl92du_set_hw_reg,
+	.update_rate_tbl = rtl92de_update_hal_rate_tbl,
+	.fill_tx_desc = rtl92du_tx_fill_desc,
+	.query_rx_desc = rtl92de_rx_query_desc,
+	.set_channel_access = rtl92de_update_channel_access_setting,
+	.radio_onoff_checking = rtl92de_gpio_radio_on_off_checking,
+	.set_bw_mode = rtl92du_phy_set_bw_mode,
+	.switch_channel = rtl92du_phy_sw_chnl,
+	.dm_watchdog = rtl92du_dm_watchdog,
+	.scan_operation_backup = rtl_phy_scan_operation_backup,
+	.set_rf_power_state = rtl92du_phy_set_rf_power_state,
+	.led_control = rtl92du_led_control,
+	.set_desc = rtl92de_set_desc,
+	.get_desc = rtl92de_get_desc,
+	.enable_hw_sec = rtl92de_enable_hw_security_config,
+	.set_key = rtl92de_set_key,
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
2.44.0


