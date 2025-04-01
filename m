Return-Path: <linux-wireless+bounces-21028-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BC1A77D43
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 16:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BF7E3AD8EB
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 14:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBF02046BB;
	Tue,  1 Apr 2025 14:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/Yf4QPH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32F31C8639;
	Tue,  1 Apr 2025 14:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743516578; cv=none; b=OiJ8HTKD0X3YcwjyS3dbGWIBBEeU6zj9wsWa0e+rdwcNw1mRH9uBtkZhy90NMWDRs7L/PmqTTpIO8xvoDexRNYWrN8J/7lmLRODuUZb7pnwGCIPUtkq+2ZCaRmPQjbL3ocvp7v3o8z3pAKZvVgeNBxoj4iGFOb+M4DFJJgI1+QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743516578; c=relaxed/simple;
	bh=My+IhUJPDIGC/U42rriDITzfwFXpKC6Yxi6GLAVN7H0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sGz0MMmjNaCpRcHu3Z4MRIB/yOrNXLHSda5DtRSHCr/SYvfUqDx3EgI+O49Kos4lWFatbOUCJFByWfJJhq46ApIdclVXWq3xpE32t2uasvv2tVFJY9ib0ytUsJyCV0XcBFpinpsiaxg7j+B+D6BMuV3rQ15fOTnXZoSoAtVnpDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/Yf4QPH; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-224100e9a5cso102441785ad.2;
        Tue, 01 Apr 2025 07:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743516576; x=1744121376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a9GlRWIrROmsrWYyZDpS+4LIE3y91EaJxNh6RKPsNwg=;
        b=d/Yf4QPHWlJ86Zk2w8izZcA9byb4441Eb2ZEBbdpU6dMldMq0yugVa+0pSiNDCl5kw
         bQQkdDduYy/oHh7fLkZF2Lkt5Vczq1A9LW4L980IpjloD/xnL6p/NbTtRE6O5XMTEm/7
         6/4VzGZG839qwuKISnkqbdKOOUvDMSluE0lsSA1Oq+brGQKsGq67AaOLANR2gNkvaPGk
         kGGqA77566fsRJy9x6Uzf3fycRQHA5LC/X4hyQiOK5/yGtQUQZDoOdJOaaSKukCkiGo3
         W5VU2MxuKUn8PjimnGz+UKVjW8pgmBGsQJ+xB3VC/LY/Y+LNQ0OGh6IGVg8ugLxS9cZX
         ev9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743516576; x=1744121376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a9GlRWIrROmsrWYyZDpS+4LIE3y91EaJxNh6RKPsNwg=;
        b=FlccOTuXMTupWJ8ndxB+IBxWi9mvqUon8rujJKXgixpDHtKzUqZYSXZYOi+N6eLkKJ
         m6SL1XOjIk3yCaMnFVbOdLquONaSwRryJ4kkSRildTJwTJwaQx3TcnM2vuuIdzRv5i/3
         rEYpmntcUE80/a1DQtJZ/oE2smx6URkyoEJFXHc0OUSFoxgwsFS/yD1VmXXDqCgQMXbF
         Q/IRakNHHWLYD5MnR7Iea0aeZREuv6N93L49xz6WyVjM7IM/0/GcItyE+Q4FGkh6VoKH
         3AY1TIhp1QJqQj0TTwUEGUC1EGwLL03SkL7rj6kJeVNksmTmsbAXFBciO/t1cAFxOyf2
         G1WQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaa1eW2/x808XI3OThsmh/YxynjaOUYpIzNTYregCuKv5uQTW+hH7VLekeTuaFjUmjrGs7qO6NVBzNVuI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5J55w9aYb52BWaqJtU7W+cGJEBsi1kRWdxg5I75mV3BKc8fnR
	pQS4QCdqpCzVKjoQt6MAhdmBTneNVU7NS9oRt1KiFNAiQV49/jxTk9uDkfEdBv7hVA==
X-Gm-Gg: ASbGnctUfMM3VZiywaFMkqOBEzcxPPILWEangC3PsWbANYo+iCBeswlqLyPU0sPGi7x
	40wjT47jNSPK1kQtnsCoQJC/OIfS2H3ar5fjMnTbiBqkCAmLtWyWNxIAtRDOpLEtA5eD1gwJvxp
	9IVaK11S0t0zGGeihil9iUlJFiaOOFqXT4rTifV7lxFNbiNVN0WQFXDe8Enh+7qfkEuOc4IkL+C
	lIFtpin4dQ0CgAiSWkzVzusj7FubPw4l3s1YdkcX/JMpPh2WJWdoR24vH2Mvpft3sUhs3gzI1zE
	Qywu+zeX0yc9fSnqWxm22D14PN2qzw46CEDzScVWK0VWVfA4BgGGTXPKPzPFCbUVU9NxKb8=
X-Google-Smtp-Source: AGHT+IFgauv64PUqSz27wL93wQDQRU2fSOWY7nWrgsuD8SQDOPwlyH8YGEfCl2nmEhWzzN5QGC28OQ==
X-Received: by 2002:a05:6a20:3953:b0:1f6:6539:e026 with SMTP id adf61e73a8af0-2009f5fe141mr19082242637.15.1743516575790;
        Tue, 01 Apr 2025 07:09:35 -0700 (PDT)
Received: from henry.localdomain ([111.202.148.167])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af93b6d82f2sm8082168a12.40.2025.04.01.07.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 07:09:35 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: arend.vanspriel@broadcom.com
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH v1] wifi: brcmfmac: acpi: Add NULL check in brcmf_acpi_probe()
Date: Tue,  1 Apr 2025 22:09:24 +0800
Message-Id: <20250401140924.29168-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_kasprintf() returns NULL when memory allocation fails. Currently,
brcmf_acpi_probe() does not check for this case, which results in a NULL
pointer dereference.

Add NULL check after devm_kasprintf() to prevent this issue.

Fixes: 0f485805d008 ("wifi: brcmfmac: acpi: Add support for fetching Apple ACPI properties")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/acpi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/acpi.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/acpi.c
index c4a54861bfb4..4885d5d0a0af 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/acpi.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/acpi.c
@@ -25,6 +25,8 @@ void brcmf_acpi_probe(struct device *dev, enum brcmf_bus_type bus_type,
 		settings->board_type = devm_kasprintf(dev, GFP_KERNEL,
 						      "apple,%s",
 						      o->string.pointer);
+		if (!settings->board_type)
+			return -ENOMEM;
 	} else {
 		brcmf_dbg(INFO, "No ACPI module-instance\n");
 		return;
-- 
2.34.1


