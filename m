Return-Path: <linux-wireless+bounces-22054-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE8AA9C283
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 10:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC6567B6D00
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 08:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1224F1EB1B9;
	Fri, 25 Apr 2025 08:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WXDqpD1D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B67C21D5B7
	for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 08:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745571332; cv=none; b=HVA3Jra1X/gvD8mSc4o09oNG89nXS5Fpr6gyLh/GDjtuJDBBJDIJ9LO3h6H6IYcXu+JBA48hXcv/ipJqnl6NlH8tgFPeBATy3DhA1pkj5mw85Xe4QKlVcqORhOoLtbiEj70jzIyc0em9SDgUUkFtJ8NdSPxtJHer7VR+3GQql+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745571332; c=relaxed/simple;
	bh=nkJItunQqSMRy+HiXddLcHeIpGaMRva1eaoplfq2myU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BfnFbKBaf5WTv7KH3BGmY8Ym0FXUGFGTr2UG4U47FSEwEVaN++87yiwhiIFeTlYAWaUmoE/KriZnm2//2+yd7u2Fqzp0iNXr6shrprC9c7LJVD5LmONpaCX9cyPBXBRv3GrsqUaqF7N6kFORPBeV0u5nBXURpuz+3wi5uFP0iVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WXDqpD1D; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-224019ad9edso28576595ad.1
        for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 01:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745571329; x=1746176129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfBR4TI6BpBz8qAAbyBqgBwhlsVjxxg/yHIslp5Eg5M=;
        b=WXDqpD1Ddoydd50obKfvI5qEtOPiTh0buH2/t5Vk6uukQBGDB0lYuV28SUsO4hkPMv
         JUEE67YnDmitPRiqBPn7cs99wDjf6OU08dfUzUD1Wk+3NCVljG98sEXMupkR+vKC7Yf4
         mqUowPjUpMsvoIx9D0RkIN7Y8YiFKHs35LlZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745571329; x=1746176129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kfBR4TI6BpBz8qAAbyBqgBwhlsVjxxg/yHIslp5Eg5M=;
        b=cMoaAFkkoc4xq3HPzh83NSqyR73/FWmFOuamZAL4aQDyR5qhVwu5pa/mzNordQpU6Y
         N2UBUcIkhzOxhwjge7Z6sQoDVqjVGj4/wygrlPLWKUtUYF4BdWTdRsySzMD5mX2lFe8q
         0mTD05vcJvB2OJKZkY7Ojxazlzuw6VW2EJZp5y1Oh91CajM6y8Fux3eS8GKvwwFIc6ha
         2M4CKhFn6+LN3Vx4fVteAoJsjHzeuQqHW1QvK4FeHsH5xybM11VEXULGb0cKiOqg2+cB
         QjTtmo8yvlcy4BbiQ0q1tP+gRPUxmDzksETmV1+bKqstphoFlUCPZlmgNv65OWOZgnQH
         myvQ==
X-Gm-Message-State: AOJu0YwNKbVa3un6VWkQwhJRWd4uGh6pdxrBoo+KZM+iAi1eWGKFpq0n
	b1ZUd1KWDYIIsYE+Ax8uldCk5455gPFXyq/jhmErDJZGE3UNmx40E8MPj02UFw==
X-Gm-Gg: ASbGncsv8fjyTuH/fZDpJIOYwi+mFBacEmEb/B1NuqyZbWWRYazmVCnwSiqEXOBLXav
	JE6FgkV0LQbVM/JMNhXZclMQxKm2wzPrq9RbFUeCPd2EG1LV5+i6IFqKytfvQW4zNmrMoRlKhov
	WrsWQeBAixR05kW5lgkeTxsnoOFgyXXRX+Yb1E1xwdRH4ksCk4KMnd9ra1nebU1TjD1fP4mmrWI
	IH1cZDYdfwI0qVvGwxbZX5bHJuUC96dy5jOIo8V6IhNotMs78CWNJJkOygfmDQnhL2D2lqCb3So
	jncCCLwvWnfOh4z9HuwjULj1VN6afO8rj4PZN5TJub+CG/9Om/8Hf8unhpf8Lo47Q+kYTIzVL6Q
	7u/MTcXLeTLmAnwFcQP4x
X-Google-Smtp-Source: AGHT+IFh27RuF6vdvrAtFWO6WSPyyAlGfUA11OCzAC9TKvBtpevYkEHcV/6xvlrKX4ja5kt7DCzMgQ==
X-Received: by 2002:a17:903:40c5:b0:224:ff0:4360 with SMTP id d9443c01a7336-22dbf633bddmr26427335ad.53.1745571329478;
        Fri, 25 Apr 2025 01:55:29 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5221943sm26988875ad.249.2025.04.25.01.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 01:55:28 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	James Prestwood <prestwoj@gmail.com>
Subject: [PATCH wireless-next v3 1/4] wifi: brcmfmac: support per-vendor cfg80211 callbacks and firmware events
Date: Fri, 25 Apr 2025 10:55:16 +0200
Message-ID: <20250425085519.492267-2-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250425085519.492267-1-arend.vanspriel@broadcom.com>
References: <20250425085519.492267-1-arend.vanspriel@broadcom.com>
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


