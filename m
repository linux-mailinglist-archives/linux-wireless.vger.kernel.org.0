Return-Path: <linux-wireless+bounces-7337-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D10B8BFB58
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 12:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA8DC1F2384C
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 10:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368A37EF1E;
	Wed,  8 May 2024 10:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqnugLrs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6277A15D
	for <linux-wireless@vger.kernel.org>; Wed,  8 May 2024 10:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715165644; cv=none; b=SnmZU/zfKFM/B8oKJk6uRq6xG1Stes7aGoV1ZNPxqQJjo3aaecaqs9ornW10/isPIybejlHMzJgSxWAaAJ7L+yo2zwgH7Hee8W7imzU4j+jAcSNlgRbtlXsTk4KqklYyvLkPMUMiL5gL2Nh+eOnuFNx+BkZybFUTIW9rGqM6cNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715165644; c=relaxed/simple;
	bh=4/+tgVgOQb4plfmMVmaO7P0o+6CqUP/nivLwvWUVpX0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VyLd+7n58ZShCDwwr8BlmqqAEAuiN0w1YVfbegGuijZNKY85E4gUOTUns6iS9lynkUjNKJ8xjUK2tNl2KLVoEZ6Aj3GqqDUBrRVuCS/s3nU9AdqfIZf6f9ECRor5PHyZBl1JzvnobBPil8BDD3FBm7aeP0r1oYAUXztn578dsUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XqnugLrs; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a4702457ccbso1109518866b.3
        for <linux-wireless@vger.kernel.org>; Wed, 08 May 2024 03:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715165641; x=1715770441; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q8zJKY0+xBAA06bC/t4VFA1AYJ+XB0lxbZhPo4cr2Uw=;
        b=XqnugLrs1yZMWwWxiTQvVE3QVX0n7GHm9ArUZK1hZTqX4PKxS5w2IWHZbJ/bxFm3XP
         5bOr4aEF1RDlGQOQ4TtuIs6VYfph5X0xp43ij9CJV1tS4h4tMeLANYLf59/Wm2O03Yus
         RzpHYpueO1L++tevYA7gX1ssFynngFeU5YTFdeRmI5ko/d+OhGtSgT4dYzGvlxfBrzHQ
         H7RTr/4jLyHLSRuG+vtsAyJmB0QKZJVbheRl/xYLqRQsG8qVJbHd0GKra6L6d/yn978x
         Xrj3yiRlJqOs8T/z51OaUE9jRaHtcbxnFjDi6Wq+E2Va31Raifxy3P1SI7dQt0fpEcWL
         /O3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715165641; x=1715770441;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8zJKY0+xBAA06bC/t4VFA1AYJ+XB0lxbZhPo4cr2Uw=;
        b=G4g17TAUF+NuD6Dta9Q3V6lrluwBBED6ZPEEr95iXEuzZucPKNKyn1HY6z1vlFQutU
         5cmKQXN0P04w1kEAcWqFvLkDOnDooa/xyFmOXi2ur8MRvh463WHcXVFT09qNiNxA2HIl
         YHQWfpbeL5AtH8/9B/ZIu3ASbZxMHcgr11AVBFambTloBk+KKTOCmubV/QzfEFyvWapP
         vOXUEZtdbFOyXGb0+6R5ePrkX6jZciV1+a1a/WeGkBn1JL3hD/+c3/jbkkOHK4XAFlxY
         D4U4lIJVFVCXzMy+XTahLcItH7WJW7wk7zC/YzpY7GwWHeFgnVDnye4rd1H7mIkxEpnx
         MRYw==
X-Gm-Message-State: AOJu0YxTKYr3djyRTGKIyjL2SXx8EaNB6NwaAT9sT25o0ZZ2HthxcYSB
	dCwwQGeXQ3t0uHgeHwsqOpyyAK7u9YqeHHNN/sWMSJCNbTKFapRSN4IdrmuK
X-Google-Smtp-Source: AGHT+IGZdmBBzalELGvIakvvMxMvQQeMBjpkUr7WRWJPUGB6FWSbflgNbm+VzL0ZtA5HPojG4yiLIQ==
X-Received: by 2002:a50:c04e:0:b0:571:fc6b:966c with SMTP id 4fb4d7f45d1cf-5731d9ce54dmr1649679a12.13.1715165640898;
        Wed, 08 May 2024 03:54:00 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id c21-20020aa7df15000000b005727bdb1eafsm7370772edy.40.2024.05.08.03.54.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 03:54:00 -0700 (PDT)
Message-ID: <2eddf524-30bf-4c24-8687-9c27b6d0004e@gmail.com>
Date: Wed, 8 May 2024 13:53:59 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v5 09/11] wifi: rtlwifi: Constify
 rtl_hal_cfg.{ops,usb_interface_cfg} and rtl_priv.cfg
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
References: <254558da-ea8b-40ea-bd5a-83d13796744f@gmail.com>
Content-Language: en-US
In-Reply-To: <254558da-ea8b-40ea-bd5a-83d13796744f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This allows the drivers to declare the structs rtl_hal_cfg, rtl_hal_ops,
and rtl_hal_usbint_cfg as const.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
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


