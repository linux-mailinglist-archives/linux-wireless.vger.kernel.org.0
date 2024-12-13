Return-Path: <linux-wireless+bounces-16349-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 854119F045D
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 06:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7D6318839ED
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 05:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE64A18C928;
	Fri, 13 Dec 2024 05:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPCHLluk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B28718C910;
	Fri, 13 Dec 2024 05:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734068835; cv=none; b=Z5X8YbqtfFpp1nxvTAHaymbwI8Phy/X4aOKDPRWMEn26hPp1ahZ7XFALqxYGNm7jPHSBOxid8ZRmroloLbeaLCin3A8OdddanKODjrqzTb4AKJvzsmb6nfWALn3k/2OvL06YCUU5c/CN/sVpctwsPvLNF7JeFFSXUyGM7Kga2+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734068835; c=relaxed/simple;
	bh=QTcEM0pa4oOmr4wRV1zBU96zbdoeKwVEN5PXZd67iuA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oywq5fL20caYnc0I2SLfLJEaihjrvyhxXyFBMPO37S9RDKCnbwu6L+rkrIAKUQdlbzOWl//bnnCHlZ30UHNWod9UpsNtgUGqPSipXKoIhUKepOrlqvTmurMcL3yJX6AiCmcUjv7eZ5IRpa6RKYs1LR4CykSZvEIFcjy7Z/7xc8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPCHLluk; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21654fdd5daso12213995ad.1;
        Thu, 12 Dec 2024 21:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734068833; x=1734673633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gS7oaK0RsPIguog+zKCBYVnzq+DdL6weynD0punt/E0=;
        b=GPCHLlukaGNIxRhr1ziHpmmkeCVROHQrh73jrS8yVNstrKgaOU57JW35c7VpBcTjpt
         6vClchNvyQsFv6jWE4MldutN0Be/VjlyA++67sidXEyW6AjAOqKkA/A0nddbouCrFioV
         c8hopZN41NKyB1CsoZuChNAxk6AkYUemSYqzgEUaCZU54jV1Ye0bPvGX8LjhlZgeFXS9
         dLHsJkAee7YQDoP836Wm6vexTZGkcnfPLkG07ehRKznznqIDiQCpfl1W5d5p8sR4DUR2
         TXzQS+qKURaJNjLWk3qP4cZ6zM1nMxIYxSX/L4nAvUv/lK7tbQquAOjw9XtlCWEsTRI8
         aTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734068833; x=1734673633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gS7oaK0RsPIguog+zKCBYVnzq+DdL6weynD0punt/E0=;
        b=ci1MUuw7PdlFlOpWADCRC3kLQcw6eHhwVINNHyan9jLSgG5PjmEJVSuywA36paHRc1
         Ihze6Tp3XYn+hU+mi1kr9BP6HDmpGbmsBPXxnvdc2eIA8sP0WsOv21JsuCTI9O+iDwTe
         rR92oWCg+JYa9taW/bTZ8kOh85Y53nAQDE9Q1zq/hHI6Y03Re6x1GW5VfOREWOpgyMrv
         VImdiLikekZDJ+FWWZTFx2GOr1qPE9FRA0VUEOaEK7mn9IkElwarjOLvpGpnDgidOzLU
         7fagYcxxj8WxUNqzCXupf37f2ZtVtAPZ21dvjo8i1VO4uSPgzEsAZUK5HBDUcaf1kQQs
         3e6A==
X-Forwarded-Encrypted: i=1; AJvYcCUTsaxrSLmQWaC0ggwsX5xpdbNZCYRZ5rXK15frh1PBLjzdnNK0NmXsILIMukrz5c3sdsRhw7D461+2DzSp26MZ/ADvO6o=@vger.kernel.org, AJvYcCUVXiHJBeEtwRefNgSFxKMa1tKOz1Htul1gqkSsAYh0opxEt44fY9AIANLDN9Wk4e6vnPW0UMDFvaG8Xg8X3zU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVvPsTPeeNowm+glmgErP30Xfob8xShmAhdb89mbhMSFZJIrSt
	yQkpX6svIPolrXMI1Q3TyLah3gnz4T6qg07LAspFdi+5sclkX0b5
X-Gm-Gg: ASbGncuTWJXiSPkaSDA/jYHCoSv40hC2bJs1HVKuIul7LCW0A5QYSztuhsKS5XOwHAR
	s5bc0uRZsI4Rk7/ZTTW5P77IGK3rFSQHRjS9195I5lIBFU3btEwkizqLGD10fjRV97jHjW9+QZm
	rBMdGnw2fRx05+OvJN7E+aGa2C0vL+x+FtbHM6i6TR+XStwzGQ02SBG2g/UYQh9lhQDZYRN98bt
	Aqz5joY3AsXrIyyt4bexbdapHL0eE+3rseoyJ4iu6BB3rpD13hHw1seVRhHryhjaqjlcY9xBkV9
	LWrtvuE=
X-Google-Smtp-Source: AGHT+IG/u9vPHYJsr72JqaDrYLM72r0Mv+gF1sZwvgldiU0c1giVELNbwcEluD8XRP6pboK2QDHicw==
X-Received: by 2002:a17:902:f60c:b0:216:7c33:8994 with SMTP id d9443c01a7336-21892a7a811mr23989435ad.53.1734068833602;
        Thu, 12 Dec 2024 21:47:13 -0800 (PST)
Received: from localhost.localdomain ([180.159.118.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216483dd292sm82564985ad.226.2024.12.12.21.47.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 Dec 2024 21:47:13 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: torvalds@linux-foundation.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	x86@kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	ocfs2-devel@lists.linux.dev,
	Yafang Shao <laoar.shao@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 4/7] net: Replace get_task_comm() with %pTN
Date: Fri, 13 Dec 2024 13:46:07 +0800
Message-Id: <20241213054610.55843-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20241213054610.55843-1-laoar.shao@gmail.com>
References: <20241213054610.55843-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since task->comm is guaranteed to be NUL-terminated, we can print it
directly without the need to copy it into a separate buffer. This
simplifies the code and avoids unnecessary operations.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
---
 net/wireless/wext-core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/wireless/wext-core.c b/net/wireless/wext-core.c
index 3bb04b05c5ce..1f2a7ab546ba 100644
--- a/net/wireless/wext-core.c
+++ b/net/wireless/wext-core.c
@@ -640,10 +640,8 @@ EXPORT_SYMBOL(wireless_send_event);
 #ifdef CONFIG_CFG80211_WEXT
 static void wireless_warn_cfg80211_wext(void)
 {
-	char name[sizeof(current->comm)];
-
-	pr_warn_once("warning: `%s' uses wireless extensions which will stop working for Wi-Fi 7 hardware; use nl80211\n",
-		     get_task_comm(name, current));
+	pr_warn_once("warning: `%pTN' uses wireless extensions which will stop working for Wi-Fi 7 hardware; use nl80211\n",
+		     current);
 }
 #endif
 
-- 
2.43.5


