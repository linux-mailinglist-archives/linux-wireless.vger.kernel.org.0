Return-Path: <linux-wireless+bounces-25099-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9419EAFECEE
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 17:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D13745A5235
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 14:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FA72E0B64;
	Wed,  9 Jul 2025 14:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnUNzVlf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F372D320E;
	Wed,  9 Jul 2025 14:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752072950; cv=none; b=Rm0KtUQ0W8gzDIy6LUr0x08eOEEIdhU9nCKMKW2I5g6c3VRLoA8nbc8MLgPTxXo/MXt2G+N/2AneqwOX3vX/a4wBK+6MC23kjLSnmv655xUl5bLsM56IQiFMeuq8lIKG6Urjyx1TA5mGEmoJuwsk+c8dBN+pN3K2JmTEoXz6NzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752072950; c=relaxed/simple;
	bh=lATAXEwcc6G/Pcf8CLWTOlnj043r6N8Oil0yN3RaDeY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OjHEboU+sH7NxuQGeqfDp3rqtqBExbL2jzyRWafQ5MV6Z3YdkbUrXTu+hZ8d+yXocvg2FAoUmQPpb4gjyMH2I+7gA334+QUzkgd1u0OCIOesD8u6iHIKm+FeduzVQ/JAMMQsuvvclscgofkG7lFWJCyopTAex4Iohs+Er88Dd2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gnUNzVlf; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-234d3261631so46578225ad.1;
        Wed, 09 Jul 2025 07:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752072949; x=1752677749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rYBWS+8dYRZolFFfJVTsJDzUHqNW8EbfvHKt/uobe2w=;
        b=gnUNzVlffpNc3iIXMu48EPWt9PjWOAN5NQRceIXDL7mqAw2AgD0y2dNvI3HX9z2/c/
         mwAMCaloxxQGR2jxCuIdNe568pt2G14mNV2K5qJuqduEvmQzOFRDC39Y1u80NSQ6nTLW
         TusJ+YmW9UiSCd5zhxk+lq2OPQ2/36Z7XJqeEEx6f9nRvEe8iKGbbKDDSnckSDd2ua26
         K9Yq/hmBjx6xz+RWar/ZPreeQsY6maExzj/IQaz3YZbmKKhrMwa89Qa8VIc4RXRoADvo
         mUsOJWvTauAcc2Tjg+TCUwOqRBD1iAm8g51TKV5lV2yyK+DkIBJEw0V+N6qulcov32Km
         cWaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752072949; x=1752677749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rYBWS+8dYRZolFFfJVTsJDzUHqNW8EbfvHKt/uobe2w=;
        b=S7MBeitC0XgqHXFMf3rzLlALQ+99CeNOT89HnV8Pjd9c5DZ9iDBpFOPB8432cLXrf+
         b9VHNqVxu5Lfj7ykQqrMXfg6Qk+QDflSI/sYL6LYHajSncw8+Nw8E0yM78NviELTaUhE
         /LGSJL/H64SwfD6kiEl57Wx/yb2L9enMhUaDG5ND6TJDzEPQ7eFKpkmlemVcZh1oz8UB
         Wj2sZ/0YE0FDMsaUz3NGs8GIJh2Tpvi2qBXbeTrqd9JBhFyAIwgGqpy0HI6bEY0MN7CU
         R1KsfXMegudLkcqqm0MEFEqj7f4XAMUjQ4WWhvyz9x6Sp3STq4qEODCjBvhl2wv9xXEP
         AU4g==
X-Forwarded-Encrypted: i=1; AJvYcCU3zyJoB1TfOykFvJxdI76TFmn/ruSQh03SEAQ/OTzf3QZDo6lNGzZGgL6P51WJF/1TyoqlLv+KKdeN/93X6lw=@vger.kernel.org, AJvYcCUXfPq3ub6ez0B6xpB7DRyUpJJL0Uq3Swd2mmk+cWXa7331Oa1/DJ8kJO1IDwcPOXdk9/Vw5vOe+g3D1BE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbwgG9GHEccttRmFinjpZP+uWSuwxkLCfuucJhnQNSZ9jDyhy1
	tgkARfSHekE5BJtR0Sa9C0gnrxHwjtq+KgBT4dxAQr2iY7GrGg1VaEK4NANBmw==
X-Gm-Gg: ASbGncvctY12F6rqaXxKyBiasCV/oGzLtz9QevQk1+ZhwzFj59iwJ92jWKCTmVX4175
	8pqxnbvej55pULSPZoKGvulh9G+EDJ2YTIv6B8/iEUMptuoGP5pNs2WOxnboxfEi8JlZfqV40M2
	ZKkRwk0VjwhpgNexcLnmnMwGpOs1iRW+bJFIql+WBgJ81N5KjFPs/FD/cGeiKcRAtyQGDyiXZMr
	gh0dNNLnnoIXyvsUbmHEz+2426Xa9DLWlaZAYckrD9S0WQ/QrYXm3Zg2gw/yb/dILU0TCRN3t9/
	NwDolzJ+jFe9kX5uqpAf4JKh6hTX78fhS2spO3Wj0D6fY8wr1ttnuAD4RMQyeRukwnNsM6N1wFW
	+tw==
X-Google-Smtp-Source: AGHT+IFPaUkBhW+7RcmFLLxMld4EFtuUsmWLGviLtfem1SfGzG5MQLw/zhlVTkW8+jGL3KbSDC8E6w==
X-Received: by 2002:a17:903:17c6:b0:234:ef42:5d75 with SMTP id d9443c01a7336-23de245f590mr2955225ad.20.1752072948825;
        Wed, 09 Jul 2025 07:55:48 -0700 (PDT)
Received: from localhost.localdomain ([49.37.221.186])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23c84593e0asm138530505ad.193.2025.07.09.07.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 07:55:48 -0700 (PDT)
From: Abdun Nihaal <abdun.nihaal@gmail.com>
To: nbd@nbd.name
Cc: Abdun Nihaal <abdun.nihaal@gmail.com>,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	kvalo@kernel.org,
	toke@toke.dk,
	jeff.johnson@oss.qualcomm.com,
	jirislaby@kernel.org,
	u.kleine-koenig@baylibre.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] wifi: mt76: fix potential memory leak in mt76_wmac_probe()
Date: Wed,  9 Jul 2025 20:25:30 +0530
Message-ID: <20250709145532.41246-1-abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In mt76_wmac_probe(), when the mt76_alloc_device() call succeeds, memory
is allocated for both struct ieee80211_hw and a workqueue. However, on
the error path, the workqueue is not freed. Fix that by calling
mt76_free_device() on the error path.

Fixes: c8846e101502 ("mt76: add driver for MT7603E and MT7628/7688")
Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
This patch is compile tested only. Not tested on real hardware.

 drivers/net/wireless/mediatek/mt76/mt7603/soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/soc.c b/drivers/net/wireless/mediatek/mt76/mt7603/soc.c
index 08590aa68356..1dd372372048 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/soc.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/soc.c
@@ -48,7 +48,7 @@ mt76_wmac_probe(struct platform_device *pdev)
 
 	return 0;
 error:
-	ieee80211_free_hw(mt76_hw(dev));
+	mt76_free_device(mdev);
 	return ret;
 }
 
-- 
2.43.0


