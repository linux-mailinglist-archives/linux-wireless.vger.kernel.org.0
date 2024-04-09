Return-Path: <linux-wireless+bounces-6050-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CFA89E40B
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 22:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78EFC1C2095F
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 20:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC3E15749A;
	Tue,  9 Apr 2024 20:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUoTe7au"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018E4156F4E
	for <linux-wireless@vger.kernel.org>; Tue,  9 Apr 2024 20:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712692833; cv=none; b=m0ymNaOTz2VaSaGVudiOxVgq62p9KbGOXY4BDB2RgOIyhnXXDObcMqavBG5oudbCvyr4AlOBX20BfSO49s8496ujUs3vt1lOq6ze82Fvn+/HfUq6yGF2RRnV7Xc/a/RH0KtOS/teSFBMnv5bVFf29YHLas0UrJC9kADaSRz0I80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712692833; c=relaxed/simple;
	bh=ckIN8v4ZAbu2Vg+OR/MibCb6qLG4vc78rZYXeuiM5iI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=TxMvNpK/fxhWzP8qWG+XbPHNJKzFEM1R43tedZaBisKkSZ2cBPsdjAk43vnYjVk9sJ1XB4+cs1yI9qWJDmSb3UunW/klFauGvZ3m4+c1qUCZpCCeXCuq/lJfJpiL8T9W1xjKE6KUNHgNOvrfpZLGGOE5nZbyB5NZogjs2Ux5sPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUoTe7au; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a51b5633c9cso464306366b.2
        for <linux-wireless@vger.kernel.org>; Tue, 09 Apr 2024 13:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712692830; x=1713297630; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NMRcYNIEwyxWtyHgeO3kYStklWcUg3PWsjHdlNUH4yQ=;
        b=IUoTe7auS23LzYCve3vTxv2B8RejCLN730//nhQXmG6U7rBihVSCMN8NSYIWlbXVxf
         KzojkCOjWX3Vnt9Xpw8UNIIil4KVDpjqrIYhAuG8g0NVkl7/UgBZnuE0gQixat4JNk8Z
         bmgqWQE/XyrSqFW5EDY4xXYzD5X3/nqsB5gh7/WIJirmok8wYyJobUkizVhlsyxKvIJ1
         G7F9+2E+JsPD02ckfvc5Z1pfResA7hInA1W8CAlkMFanjJJ7v7AO7ivHy5z94w4pi2fP
         5yOc1YxvqYYJO4R6XS4Ai8IX067Aym5pCxuLY1RLtsjP8u0vAINsdTX13weOFpnsGTsH
         r93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712692830; x=1713297630;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NMRcYNIEwyxWtyHgeO3kYStklWcUg3PWsjHdlNUH4yQ=;
        b=F0AfVB/vJ1Wf/Z/bYG1UK9nrBYE1NEVkytyoWX85A7ea5JBfo92cZv/VAYizkUdmuy
         II+6P1iJSTFBqd8PuPyDKQ79tQsiVkYdI/oZVkp/3aFi+NoTxHxpdLe8uIyGFMmV6JG4
         0OPtnowv3Wz/nYnx/YMmtiI2Z/AAYXT34q43T5qgAOqr96rnXPGVxUjQkGem7FfKgZSR
         7AI2k+/zFXSm8HqI7m9hWQiXK7l1TyUQ/0/GoIXJoj56ulE8VePL6UNwqzOmWRjgcebV
         bSlgKr04/QqsvcI+W+qju5osa5snisiS/ioEQ5TGuq172ayuHkXRA2vvFoUvAf3rMVNc
         kiyQ==
X-Gm-Message-State: AOJu0YxC0eji5WLpUcYgvBK/06rwaFijgntu35fcmevU+4Wz3kvFoCsV
	x6/3P/1w7L1v33QcPSLD47J2WAJMucIcqZXuyHTEM5xvw5MmbQr+AR4rgUoDZqs=
X-Google-Smtp-Source: AGHT+IF2zJrmjN+FvBX/iYtxfiuZK3FgYPmcaKp9QAwJAcDICxAmWSqcqP3gVV84KFgxaz3Uo3CDMw==
X-Received: by 2002:a17:906:1513:b0:a51:9d99:78ae with SMTP id b19-20020a170906151300b00a519d9978aemr255189ejd.67.1712692830196;
        Tue, 09 Apr 2024 13:00:30 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id e11-20020a170906844b00b00a4e23486a5dsm5984216ejy.20.2024.04.09.13.00.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 13:00:29 -0700 (PDT)
Message-ID: <ebc2edcc-278c-47be-83c1-bbdce22bf4e0@gmail.com>
Date: Tue, 9 Apr 2024 23:00:28 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 12/14] wifi: rtlwifi: Constify
 rtl_hal_cfg.{ops,usb_interface_cfg} and rtl_priv.cfg
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
References: <91d932b3-5c72-4416-920e-f2bf4fc9b039@gmail.com>
Content-Language: en-US
In-Reply-To: <91d932b3-5c72-4416-920e-f2bf4fc9b039@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This allows the drivers to declare the structs rtl_hal_cfg, rtl_hal_ops,
and rtl_hal_usbint_cfg as const.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
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
index 2e88359ba917..940df771a764 100644
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
+++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -2383,9 +2383,9 @@ struct rtl_hal_cfg {
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
@@ -2734,7 +2734,7 @@ struct rtl_priv {
 	/* hal_cfg : for diff cards
 	 * intf_ops : for diff interrface usb/pcie
 	 */
-	struct rtl_hal_cfg *cfg;
+	const struct rtl_hal_cfg *cfg;
 	const struct rtl_intf_ops *intf_ops;
 
 	/* this var will be set by set_bit,
-- 
2.44.0



