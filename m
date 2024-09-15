Return-Path: <linux-wireless+bounces-12870-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB599796F3
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Sep 2024 16:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94C031C20BC3
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Sep 2024 14:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D92C1C461B;
	Sun, 15 Sep 2024 14:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Nnjo04ES"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA0A1C68AE
	for <linux-wireless@vger.kernel.org>; Sun, 15 Sep 2024 14:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726408877; cv=none; b=d4tbQ+GQFGfLTEXFBkicV4i4P8BuKNxx0a1avQTb2ev7713unvv5SzGAQY2VcosrsWB0J+cGtP0gwsP5lOmH+EJVcw6grZWp9UvqdCU8TUt8zpxRYgUYXcjWPRLyMtkgH/u0soUR4ZtDag6ZIaXVKoNJO5A9Wn69wuxLdtlsn78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726408877; c=relaxed/simple;
	bh=uml4cHpK+TwnhqE+ohbsC0AOKVfC+X6BSRenIOKNoH4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ltlqLfmkCbbU2UgcJq/rYhHjziDg/29OCSn5CPwa3SYjudNsEWsttQpp24aR18Hgo864W+HI9mtZmiDX3HBMI3u18EVwUdV2h/zvSfJAYj1nI+9zeyxUeQ1PXwC8oT77b48YJEmhSK7R7QagO+MSnRJPq3R8INtg6Uqu0nXzKl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Nnjo04ES; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-718e3c98b5aso2430074b3a.0
        for <linux-wireless@vger.kernel.org>; Sun, 15 Sep 2024 07:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726408875; x=1727013675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGqo/vTlCHBqJgwS1IGoE7Tm+c5bmlo3zOENGIdDJO4=;
        b=Nnjo04ESMOt3J5idzCL/rhliPy6/h91Ww3DQsDkOO2lJx5h9tmNBhIz7QIUYpH4LlT
         p0DdL5BrQtzHITRsuU7Mw3konDJenua0dAgtJPo8/o7I4rzzfIXfsIFlyXBOImDyrlwI
         TtpdsH9oUCCCOSZkL17cSqANxAKzBfURGeH0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726408875; x=1727013675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lGqo/vTlCHBqJgwS1IGoE7Tm+c5bmlo3zOENGIdDJO4=;
        b=fxr6eyzndGN1Y9MkH+6GEQAcLhANQ1egrhzzF/zxNufdfaBf+Anqyk/jYkUKt66zSH
         bJs5miuVJE+ktbV4USeC7LMNT5HzcAQSK08St2ICEEQRmArp5HI1KrGLNvWWoo61XslV
         lsI4nXIX3fdCPyK/JTlj4PqmzXFEo8IJ88ykY3ZeQ7Qp87uXro7jbEFVEsfSoAodSsII
         Kax6+UqiI4yF37GH08DqkcZwJFZ3Rsjrx6WyhZX9wpnT/fiCw7nEvf7rPuTefX3dZ0mv
         bNvgoLbWK6XZuzh5S3MjiTuiLB5zYeaqUiyLQCpbCDJKgIcZ0bT+vPTxorKx5mVVTp5i
         lASg==
X-Gm-Message-State: AOJu0YwATgSnA7ytshkbMTQ769sCiHTFbN/8fK2z4OfuDCg4RFg9YEJD
	Eu1LB80PaZo93VlJ85PQesLmWcGmg/gAfkoyUTyq1iy1S35iFVVGTZHXWu7c0vxytR4s8fFy22r
	YKQ==
X-Google-Smtp-Source: AGHT+IEeGFR2t0Pe7Hg4eDIEWcCQAKVHqWlWjX8XtaDyO7yeUir5L6NwAr6Q3J4lDCXnZMt3875giw==
X-Received: by 2002:a05:6a20:c916:b0:1d0:2531:ddb2 with SMTP id adf61e73a8af0-1d02531de2fmr15453413637.9.1726408874333;
        Sun, 15 Sep 2024 07:01:14 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944ab50d6sm2233511b3a.75.2024.09.15.07.01.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Sep 2024 07:01:13 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [RFT 1/3] wifi: brcmfmac: support per-vendor cfg80211 callbacks and firmware events
Date: Sun, 15 Sep 2024 16:00:47 +0200
Message-Id: <20240915140049.181380-2-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20240915140049.181380-1-arend.vanspriel@broadcom.com>
References: <20240915140049.181380-1-arend.vanspriel@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding two vendor operations that can be used to provide per-vendor
cfg80211 callbacks and per-vendor handlers for firmware events. These
two are often related to handling interactions from user-space through
nl80211. Exporting brcmf_fweh_register() for registering the per-vendor
event handler callbacks. Some other exports for get event name string
and allowing use of brcmf_dbg() in per-vendor module.

Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c     |  2 ++
 .../broadcom/brcm80211/brcmfmac/common.c       |  1 +
 .../broadcom/brcm80211/brcmfmac/core.c         |  2 ++
 .../broadcom/brcm80211/brcmfmac/fweh.c         |  2 ++
 .../broadcom/brcm80211/brcmfmac/fwvid.h        | 18 ++++++++++++++++++
 5 files changed, 25 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 349aa3439502..92e310f7f2ce 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -6752,6 +6752,8 @@ static void brcmf_register_event_handlers(struct brcmf_cfg80211_info *cfg)
 	brcmf_fweh_register(cfg->pub, BRCMF_E_PSK_SUP,
 			    brcmf_notify_connect_status);
 	brcmf_fweh_register(cfg->pub, BRCMF_E_RSSI, brcmf_notify_rssi);
+
+	brcmf_fwvid_register_event_handlers(cfg->pub);
 }
 
 static void brcmf_deinit_priv_mem(struct brcmf_cfg80211_info *cfg)
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
index b24faae35873..078fb404a0ed 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
@@ -491,6 +491,7 @@ void __brcmf_dbg(u32 level, const char *func, const char *fmt, ...)
 	trace_brcmf_dbg(level, func, &vaf);
 	va_end(args);
 }
+BRCMF_EXPORT_SYMBOL_GPL(__brcmf_dbg);
 #endif
 
 static void brcmf_mp_attach(void)
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index df53dd1d7e74..b876c20e3af2 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -1359,6 +1359,8 @@ int brcmf_attach(struct device *dev)
 	brcmf_fweh_register(drvr, BRCMF_E_PSM_WATCHDOG,
 			    brcmf_psm_watchdog_notify);
 
+	brcmf_fwvid_get_cfg80211_ops(drvr);
+
 	ret = brcmf_bus_started(drvr, drvr->ops);
 	if (ret != 0) {
 		bphy_err(drvr, "dongle is not responding: err=%d\n", ret);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
index f0b6a7607f16..4f76e812a860 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
@@ -75,6 +75,7 @@ const char *brcmf_fweh_event_name(enum brcmf_fweh_event_code code)
 	return "nodebug";
 }
 #endif
+BRCMF_EXPORT_SYMBOL_GPL(brcmf_fweh_event_name);
 
 /**
  * brcmf_fweh_queue_event() - create and queue event.
@@ -405,6 +406,7 @@ int brcmf_fweh_register(struct brcmf_pub *drvr, enum brcmf_fweh_event_code code,
 		  brcmf_fweh_event_name(code));
 	return 0;
 }
+BRCMF_EXPORT_SYMBOL_GPL(brcmf_fweh_register);
 
 /**
  * brcmf_fweh_unregister() - remove handler for given code.
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h
index e6ac9fc341bc..7fe78d41f291 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h
@@ -15,6 +15,8 @@ struct brcmf_fwvid_ops {
 	void (*feat_attach)(struct brcmf_if *ifp);
 	int (*set_sae_password)(struct brcmf_if *ifp, struct cfg80211_crypto_settings *crypto);
 	int (*alloc_fweh_info)(struct brcmf_pub *drvr);
+	void (*get_cfg80211_ops)(struct brcmf_pub *drvr);
+	void (*register_event_handlers)(struct brcmf_pub *drvr);
 };
 
 /* exported functions */
@@ -56,4 +58,20 @@ static inline int brcmf_fwvid_alloc_fweh_info(struct brcmf_pub *drvr)
 	return drvr->vops->alloc_fweh_info(drvr);
 }
 
+static inline void brcmf_fwvid_get_cfg80211_ops(struct brcmf_pub *drvr)
+{
+	if (!drvr->vops || !drvr->vops->get_cfg80211_ops)
+		return;
+
+	drvr->vops->get_cfg80211_ops(drvr);
+}
+
+static inline void brcmf_fwvid_register_event_handlers(struct brcmf_pub *drvr)
+{
+	if (!drvr->vops || !drvr->vops->register_event_handlers)
+		return;
+
+	drvr->vops->register_event_handlers(drvr);
+}
+
 #endif /* FWVID_H_ */
-- 
2.32.0


