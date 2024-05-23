Return-Path: <linux-wireless+bounces-8023-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F20028CD618
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 16:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32F50B2097C
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 14:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC36E1879;
	Thu, 23 May 2024 14:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQJ2bOyE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057CFAD24
	for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 14:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716475687; cv=none; b=Zgsm0g5a9imq0e7WnU1OsV7gYzZ095vX+gCdw6UCsXTCnD+gZyfq3TO0Y/tOdTic82rUMkfeSg3lqrEtkzbwNOClsI6sftBD5cPQjkOkEZH9gIjawLWjsbW613G8zSG55pIakvUveVVjGMQzTqREUPNY/JqcnHfJ19swM9+Qzdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716475687; c=relaxed/simple;
	bh=AT6G/weZ76jI27QDaWhlmyMopn1zi62DR6lg568VPHQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=HIMUsVWK8WM/oiTzodRAIzlLmTPNH5VGY9a+pXVBd+Z6HBLfEpXVqVOXfRH3xAh2v4puBa6Gb7nAHvLWGmHlI1B+ofSErKhIJYZsZH/f1CeklsmdLJnAZ4Q6tpK02RQFEM0QyjElJR9DUbDn6WiQdesh9GV8sCO/d3l/HRQxQ7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQJ2bOyE; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5755fafa5a7so6907583a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 07:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716475684; x=1717080484; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ad/QwmD+wcyju6+6cwn3ORVUZFRtKb90mCXM2nKe9y4=;
        b=VQJ2bOyEh0cI+y6cmnWQIdHMkIa8Ee04oStuoSKWg1bcOeYen2IxVfQo07yei+mKGI
         K4crQ1lUAUmkoTm/QVr9dzZAIG9WBYhH1zNZUt1VvmGnL3MvrzcQCOUf7pW/2pRTuPUr
         v6ZDWWtD1osSP0dI3U+GVIzPPrm6ro0ZjBJ0YnEUaLJgrhVm0Ud0f/UEdjhASi4upio0
         TwQMidCBRsOOxqGkF2hxxXkPn0cN5cCLriUl3w9ovojWCMWHGEibpIpAgd6mJRvoM//N
         bwkLk6IEPIN5t4cRI4tBDtp7C25Mxi1GcsdJJGDdyaJzUeVNfrcQHpHJOMjA7C5RhHmr
         YHYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716475684; x=1717080484;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ad/QwmD+wcyju6+6cwn3ORVUZFRtKb90mCXM2nKe9y4=;
        b=msLtkdYv31KavMjA79rTiRkZvacshUWHQlZd6iDbJr7YEeuvaC17GJQ66wQxPfR7R1
         UL/wn5aDd6RqAbwUtjp6Qimk6ML18q7VlC0lqF4RBwaEmQbBNQuXqP1moDL4arx+lE65
         ef2ekJgKXwDknaipv8/9MwBnuTRnl8Gq27SuiowKFiolUtovJPAUYfg+RsVemyNL4Fjv
         UR5IMix3Ddqvb8M8WDf4K2U7Bli89uxRxmwBWMEele/WLKeQPkUvRbNsHcYcXEOW/9R2
         pezGqc6esK9RTqqP1Gv7aDmzenwoFg2zoJUjusbmPk/0elSyL/Ye1VcXwdCw05/+Mod0
         7++g==
X-Gm-Message-State: AOJu0YwACuGbowzPP/i11rgntMnpNoeGHIsJKoJpmo29RmyO1L4X5cGr
	e0Rh+IdikheEyUcPU13j1NNrjnlw5j/a4cAX5HavHVl9RshgqIeA3/p17A==
X-Google-Smtp-Source: AGHT+IFk6otFtc/NQtKEqWmPqQKY9iQufgJ7PF39QKtYx907C3jY30WFcGm8AwJw0amNnEKtQFvsfg==
X-Received: by 2002:a17:906:aca:b0:a5b:53e2:519e with SMTP id a640c23a62f3a-a62280973a1mr282173366b.26.1716475684233;
        Thu, 23 May 2024 07:48:04 -0700 (PDT)
Received: from [192.168.0.50] ([81.196.40.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5c002103desm1203311666b.161.2024.05.23.07.48.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 07:48:03 -0700 (PDT)
Message-ID: <1b29994f-3d07-4297-875d-57c3a87a1ec6@gmail.com>
Date: Thu, 23 May 2024 17:48:02 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v7 10/12] wifi: rtlwifi: Constify
 rtl_hal_cfg.{ops,usb_interface_cfg} and rtl_priv.cfg
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

This allows the drivers to declare the structs rtl_hal_cfg, rtl_hal_ops,
and rtl_hal_usbint_cfg as const.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v7:
 - No change.

v6:
 - No change.

v5:
 - No change.

v4:
 - Patch is new in v4.
---
 drivers/net/wireless/realtek/rtlwifi/base.c         | 2 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c | 3 +--
 drivers/net/wireless/realtek/rtlwifi/usb.c          | 2 +-
 drivers/net/wireless/realtek/rtlwifi/usb.h          | 2 +-
 drivers/net/wireless/realtek/rtlwifi/wifi.h         | 6 +++---
 5 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/base.c b/drivers/net/wireless/realtek/rtlwifi/base.c
index 1a8d715b7c07..aab4605de9c4 100644
--- a/drivers/net/wireless/realtek/rtlwifi/base.c
+++ b/drivers/net/wireless/realtek/rtlwifi/base.c
@@ -2272,7 +2272,7 @@ static void rtl_c2h_content_parsing(struct ieee80211_hw *hw,
 				    struct sk_buff *skb)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_hal_ops *hal_ops = rtlpriv->cfg->ops;
+	const struct rtl_hal_ops *hal_ops = rtlpriv->cfg->ops;
 	const struct rtl_btc_ops *btc_ops = rtlpriv->btcoexist.btc_ops;
 	u8 cmd_id, cmd_len;
 	u8 *cmd_buf = NULL;
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c
index 48be7e346efc..c9b9e2bc90cc 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c
@@ -53,8 +53,6 @@ static int rtl92cu_init_sw_vars(struct ieee80211_hw *hw)
 	} else {
 		fw_name = "rtlwifi/rtl8192cufw_TMSC.bin";
 	}
-	/* provide name of alternative file */
-	rtlpriv->cfg->alt_fw_name = "rtlwifi/rtl8192cufw.bin";
 	pr_info("Loading firmware %s\n", fw_name);
 	rtlpriv->max_fw_size = 0x4000;
 	err = request_firmware_nowait(THIS_MODULE, 1,
@@ -160,6 +158,7 @@ static struct rtl_hal_usbint_cfg rtl92cu_interface_cfg = {
 
 static struct rtl_hal_cfg rtl92cu_hal_cfg = {
 	.name = "rtl92c_usb",
+	.alt_fw_name = "rtlwifi/rtl8192cufw.bin",
 	.ops = &rtl8192cu_hal_ops,
 	.mod_params = &rtl92cu_mod_params,
 	.usb_interface_cfg = &rtl92cu_interface_cfg,
diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c b/drivers/net/wireless/realtek/rtlwifi/usb.c
index 2ea72d9e3957..b6d300bec1e9 100644
--- a/drivers/net/wireless/realtek/rtlwifi/usb.c
+++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
@@ -937,7 +937,7 @@ static const struct rtl_intf_ops rtl_usb_ops = {
 
 int rtl_usb_probe(struct usb_interface *intf,
 		  const struct usb_device_id *id,
-		  struct rtl_hal_cfg *rtl_hal_cfg)
+		  const struct rtl_hal_cfg *rtl_hal_cfg)
 {
 	int err;
 	struct ieee80211_hw *hw = NULL;
diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.h b/drivers/net/wireless/realtek/rtlwifi/usb.h
index 12529afc0510..b66d6f9ae564 100644
--- a/drivers/net/wireless/realtek/rtlwifi/usb.h
+++ b/drivers/net/wireless/realtek/rtlwifi/usb.h
@@ -136,7 +136,7 @@ struct rtl_usb_priv {
 
 int rtl_usb_probe(struct usb_interface *intf,
 		  const struct usb_device_id *id,
-		  struct rtl_hal_cfg *rtl92cu_hal_cfg);
+		  const struct rtl_hal_cfg *rtl92cu_hal_cfg);
 void rtl_usb_disconnect(struct usb_interface *intf);
 int rtl_usb_suspend(struct usb_interface *pusb_intf, pm_message_t message);
 int rtl_usb_resume(struct usb_interface *pusb_intf);
diff --git a/drivers/net/wireless/realtek/rtlwifi/wifi.h b/drivers/net/wireless/realtek/rtlwifi/wifi.h
index 6a8212fd36af..ae6e351bc83c 100644
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
+++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -2356,9 +2356,9 @@ struct rtl_hal_cfg {
 	bool write_readback;
 	char *name;
 	char *alt_fw_name;
-	struct rtl_hal_ops *ops;
+	const struct rtl_hal_ops *ops;
 	struct rtl_mod_params *mod_params;
-	struct rtl_hal_usbint_cfg *usb_interface_cfg;
+	const struct rtl_hal_usbint_cfg *usb_interface_cfg;
 	enum rtl_spec_ver spec_ver;
 
 	/*this map used for some registers or vars
@@ -2707,7 +2707,7 @@ struct rtl_priv {
 	/* hal_cfg : for diff cards
 	 * intf_ops : for diff interrface usb/pcie
 	 */
-	struct rtl_hal_cfg *cfg;
+	const struct rtl_hal_cfg *cfg;
 	const struct rtl_intf_ops *intf_ops;
 
 	/* this var will be set by set_bit,
-- 
2.45.1


