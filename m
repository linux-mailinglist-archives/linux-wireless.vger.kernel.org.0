Return-Path: <linux-wireless+bounces-22021-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3E5A9B86D
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 21:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A3CB92787E
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 19:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8292918EA;
	Thu, 24 Apr 2025 19:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fh1IOEHD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B634F2918E2
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 19:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745523802; cv=none; b=WlRD5jaBi0SkgwtPsoty+ReWpe5zN9fhRyz+sGIhy4VlM4BnO3SKF15TLzlXUQMlfwxF46/VzA6HBgsQlOOYUUDKBfw9GwXgSt1gwBABQgvs+BAHGsHmTmAs1RjlvjICSXwFcfkVu2jzNYPhmOz3Pl7cikIvqMp+zy7kDux3BAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745523802; c=relaxed/simple;
	bh=vkd8l+2uE115IwCc/KwGXmw2c17V2nEb0eAxDlqMROQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B3WTIC/XnpCGKqFiFgPeFfvImWmJCIQ2QB3e51K12+A0Aqnp8ub85OTYZPwLrL8MCAtWIuvUTIkv0PkncRVVZtrYtRTwUzK0spYGtBbUEjQpVOnWR526JG7PpGfip6QIPpGYOwDP/U1qVrXdjrenenJLNACgSOv49l/ifBZJy+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fh1IOEHD; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-736c1138ae5so1426716b3a.3
        for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 12:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745523799; x=1746128599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfBR4TI6BpBz8qAAbyBqgBwhlsVjxxg/yHIslp5Eg5M=;
        b=fh1IOEHDoVonGjDS/DJ4JRV8wdlUQBNkN2AI7lcHXXrKFAgBIdCq91Iab2nhs/idh7
         b17Iwwk+g69t50UZnp0wX8EDW8pd8kVRkug8M7WwLRiJzf/rSEpGMU5uWvCsW5/flXpR
         j+NzatK4fEjjwfQuOKfanOmzuWz413qPtKB2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745523799; x=1746128599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kfBR4TI6BpBz8qAAbyBqgBwhlsVjxxg/yHIslp5Eg5M=;
        b=YW0Bz6uoA1at3R7Rd3X2i+VPRruKMWg96pbK0VzUcJxzXpwqR63VMOOM4CQe+GnS6t
         3uKLl4NvHWcdnKepJu4YEs+uqAAN+K4/G1P8255Gs4UF4sSgO9bKU25TwPc2iqYCjG4h
         PPCGjIsbTs7NLfMKecpxRcN4lQDyoE/ZEAZWw2gpp1c31EdJpYbGYOw8+dPq+dffrPPB
         t/s+JBDuJ6V2mpMjxJ5K3C714kGAdBuJrE1XWNqhoRYRkPkaKqYx7hhWVPX67a3CkKet
         6bDH3LJeAgOb6Ps92Wa1Hz56heyP2j+Mk/HXs8eNZlnPHf8zjMg4bNVs5pxf/DSvUHeg
         CBUw==
X-Gm-Message-State: AOJu0Ywk1Ep70IFJ5pajPTlGOUsuZCVtVmkq6ke8DT8ImfiBAEBIlupp
	BKhQVNYZXBIiFADqZZ18n/R8GytwuWl4bxAHdc9hAlicAkcSLeeITZEg1vDMog==
X-Gm-Gg: ASbGncsXwe+sP1n528yJ6tCgXph1t/tyCq9BujHFeNcJrg4kN0wqqsT23e3k9bSSiq+
	9G2HBPKAj0MnRwfedTivwH/9jtw0DxRoG7fEHbBjTZmM69C5s5aGt9EOB/ccT5XjVb+SoL+SZQn
	na3f6p8vx2x6ZKYdiLcbdnk1Q2e8iPMq5OVsTzkvxuqECggtcEpNKzze0A+jSDz/+f8avS59khQ
	Chu40eURF4XoWBKcgCYNluTuAj4rDRm6QynxAlvAWwrV4RP12CVonsggE+Wp4Xun+NP1XVOpujf
	Uho8BrQbbamNdQ2G84rAc+Wc91/2s4KpeVVDZ7Z+BXAEpwgVP8ZM/Y4CYQ+e0adhkrwF4rz6dVd
	xiBO7uS7YQzGrgaowQBXL
X-Google-Smtp-Source: AGHT+IHf1URmnj+ogEKZh3KWhFjfdeK5j/vlfYgwtH8PYl9kyKmsNnlj9JqWbIf2h0l6+CzxIjFpiw==
X-Received: by 2002:a05:6a00:3a16:b0:736:2a73:6756 with SMTP id d2e1a72fcca58-73e33106f0dmr1100522b3a.21.1745523798926;
        Thu, 24 Apr 2025 12:43:18 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a6aa52sm1863494b3a.94.2025.04.24.12.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 12:43:18 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	James Prestwood <prestwoj@gmail.com>
Subject: [PATCH wireless-next 1/4] wifi: brcmfmac: support per-vendor cfg80211 callbacks and firmware events
Date: Thu, 24 Apr 2025 21:42:36 +0200
Message-ID: <20250424194239.2825830-2-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250424194239.2825830-1-arend.vanspriel@broadcom.com>
References: <20250424194239.2825830-1-arend.vanspriel@broadcom.com>
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

Tested-by: James Prestwood <prestwoj@gmail.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c     |  2 ++
 .../broadcom/brcm80211/brcmfmac/common.c       |  1 +
 .../broadcom/brcm80211/brcmfmac/core.c         |  2 ++
 .../broadcom/brcm80211/brcmfmac/fweh.c         |  2 ++
 .../broadcom/brcm80211/brcmfmac/fwvid.h        | 18 ++++++++++++++++++
 5 files changed, 25 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 4b70845e1a26..b9381154d124 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -6760,6 +6760,8 @@ static void brcmf_register_event_handlers(struct brcmf_cfg80211_info *cfg)
 	brcmf_fweh_register(cfg->pub, BRCMF_E_PSK_SUP,
 			    brcmf_notify_connect_status);
 	brcmf_fweh_register(cfg->pub, BRCMF_E_RSSI, brcmf_notify_rssi);
+
+	brcmf_fwvid_register_event_handlers(cfg->pub);
 }

 static void brcmf_deinit_priv_mem(struct brcmf_cfg80211_info *cfg)
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
index f26e4679e4ff..75f101622db1 100644
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
index 3d63010ae079..04f41c09deca 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -1363,6 +1363,8 @@ int brcmf_attach(struct device *dev)
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
2.43.5


