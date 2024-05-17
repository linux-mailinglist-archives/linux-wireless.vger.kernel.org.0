Return-Path: <linux-wireless+bounces-7811-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3158C8DA1
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 23:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84535280FFF
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 21:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367072208F;
	Fri, 17 May 2024 21:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzq7eC7t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7202F36
	for <linux-wireless@vger.kernel.org>; Fri, 17 May 2024 21:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715980766; cv=none; b=EWTVrso5QxcDswY0k3TOkF3qSOxR5Io5emR+7ibIARZi7ozRy0s/VwSLhnxssFJ+CFcFIIWZRlyvtHiJ+f7T9MwtetIg4L4uFaDd1mQuvbjkEhl+b/LLsjZo8/wFHMwt1UuHOdAp9j8r3pnaMwjc5xbMgGATbP7RDJapaKEjOF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715980766; c=relaxed/simple;
	bh=vmrdXOMUQxCzsHIH4P98ZvBBeOJj6hmS0M5MxukMl7I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=m7A1NLxTzOtCI99bi/Ab5UJ+DRqxqeKiACMUEID6evHF4FQGKQMmvpO0zum67p9KFiFaqQPzb5R/HCfoTY99pD/vNdLaUdHwci2BZCDQYD9JdVidogCOiwR4+I7miVK9YCCpTZA2fNuRzIix4wYpPgq0YgI56ZKI6W03C7KVwMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzq7eC7t; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56e1baf0380so5580149a12.3
        for <linux-wireless@vger.kernel.org>; Fri, 17 May 2024 14:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715980763; x=1716585563; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lPOj/kjQUY3OHXFc1NaHYpik5sSm+cCRpa6XExjSL3M=;
        b=mzq7eC7tjzixjlB0R3DyQ9XG2mKlgrKJWQMqfmiUs8CsOKtEzdpJ5dSyqZqI49Ma9T
         jBztHCSh+fH3jNtODpUKhZAsCZOzN4lZE0X+fvxuM+xPxjOVWjseU//rcLdWRwF+Uy2n
         ZsC7ZKW+696FWV6SpzxkJ95ehal5DvwjcBFf6j1Zkm8IbqC2hVZESIzWKDjMdYHLpyV+
         jJOCVPpIGy8WlKPEnCtpA3wRsFO6gdGtPjO3nWQXn5H23WMCkFioFA5HIl80f16fiiDI
         PlsLp4PLNPh9maD4mgLMlIMHtCh2jQFsBdKXekUYzEdn5Hqa4wlsfmbx6m96EmU3hX4o
         jKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715980763; x=1716585563;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lPOj/kjQUY3OHXFc1NaHYpik5sSm+cCRpa6XExjSL3M=;
        b=xLHDniWIGtTN9Lxtz/2Ok1zKq1agD6x7VxH0B8GUdG/VzWdR17TUTmLLQvAqu8EW9H
         Qaph4qEpg7x3diC2zqzS/FRCE4M9yJ844y9FqJxs3UnyS2nFESBZ7hNSa+gxoKHTdbrT
         R4DTo21XOOcayy5NO3Pdf6k4o/eERT1vxY1+Df1ndfxe0BYHS2II2vkHPOkkrfkpdidG
         gpz3vErHHzwjHJ7KS1oYAm7dTkxfiozidzPyYdv8R+lIHZ+j3LLNe6P3ORTqB0ouR5+A
         LWTPAb+UUmv9AvNmjl8My0W39kE9IGc/AkpZdXsyHH8paJDupFAyXuSBDHKxIUGqUFnG
         Cjcw==
X-Gm-Message-State: AOJu0Yysq4eAWQiqjL5+yvef2/TJ5EMSoDWD0//pdqri2R2PjtljVohK
	mB/QS7W3wYyjE8T6UC7YABMcle4EhMLnEriDm7OYxMDNdrTQT8cO9MHxVzIy
X-Google-Smtp-Source: AGHT+IEOijjjIJJqjqHVeJoM/avhFCJTbG2tj5K78XSat9LZvBz5+0y2N6Rlw3DfM8miLzOuJeSOsA==
X-Received: by 2002:a50:f60d:0:b0:572:9474:5959 with SMTP id 4fb4d7f45d1cf-5734d59062emr14591617a12.8.1715980762771;
        Fri, 17 May 2024 14:19:22 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733becfb6csm12791285a12.43.2024.05.17.14.19.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 14:19:22 -0700 (PDT)
Message-ID: <78d82242-4bf8-4f1a-a0db-d70c77d7c9e2@gmail.com>
Date: Sat, 18 May 2024 00:19:21 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v6 09/11] wifi: rtlwifi: Constify
 rtl_hal_cfg.{ops,usb_interface_cfg} and rtl_priv.cfg
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

This allows the drivers to declare the structs rtl_hal_cfg, rtl_hal_ops,
and rtl_hal_usbint_cfg as const.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
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
2.44.0


