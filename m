Return-Path: <linux-wireless+bounces-17180-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DD5A05095
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2025 03:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED22A7A187E
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2025 02:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4110215FD13;
	Wed,  8 Jan 2025 02:25:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D5A33062
	for <linux-wireless@vger.kernel.org>; Wed,  8 Jan 2025 02:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736303125; cv=none; b=g6EuU4V7FaBgZjCKTq5hSrH9rtc9OwHlHnzrn8yHJEIK/P5o/WZE5oCeLH1OZiqkDvLqFtZaF3toTquZjfVvk5Z1R0Y1mjEwLH9lOVqvqCrZHlNt1id7jQn9o/NgF4Fo2T/tC+yEls9OvhBrp4v3KT1UyKQg0N876gcNxwnO/TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736303125; c=relaxed/simple;
	bh=Mlu4f7UY84mpSAeX3roP6mRteL0VDztOjWLDfmscYiw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r+DEd4uAwipHS4SzE2FX1FAtYZ7FKy2nXvFeFwQ5Hv3F2Yy8H/bPqJgfYjClZeZFd7uswy4iV9sQAi3uCMRcxqBbN84cj/yi5qCbHiT3FjM7NRUYH66FEsq1vI0LjRO7Fu4o/bPCFm4cLSWc/eC7+boAw/US7I+rguTsCwmtYys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2a3d8857a2bso7470931fac.1
        for <linux-wireless@vger.kernel.org>; Tue, 07 Jan 2025 18:25:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736303123; x=1736907923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=or6qBsvvHcTCXq0k3fSdgM/Qe5pV/yxt5yjVz1LHWzA=;
        b=xQ9GoCAWSWtoBaoxfOTcmqqA1dPDy7kzZ6wdjoCSFHz8fxWfKyDm46gBGW7VimA2ON
         Qpq8QsFBPYnFEt3IDw0I4gZ5UWXafB+BI/4uL8D2/BXLKJ39xIcfDClO9f22Z+n1eW7C
         AphxMEQ/kHR+GeSSyQTmPa67rFEnjWGFEykUPZk8Jxab7BHlAnvmM4ADAlgtNHYLdoEt
         VGextchaIY/MkUdxPdJsmuRJUSrr5jRM6JSynS+pD9bz7u6B+E0SdpjfZfLRnH3cXVxy
         MhMhNrK90yysBIcsOiArDzqa+RsiL8J+U9tgLSFfxN31igPkQgnv5FsCHMyiUcVgawPR
         JpFw==
X-Forwarded-Encrypted: i=1; AJvYcCWD3kxYKjVAQw+QbcEr5auExNRmNP2jx8ZSsGPy0YI+rzX4FUnyj0AkQMLN2GCNIXD0m7orhN3GipgfPRCOgg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIslmmZxJurKND+QbEhHgDq9xZNzsskzMDQqb6gVph+8GPdMpr
	wZWInH4acRe8j1G/hsDT1WZgD2CXF4cp+DyI7rz35rHkR5wZsOd+
X-Gm-Gg: ASbGncvTSWoUX/bZzeGLqQvhMb/I8uh6qqpAB+92l3t3qPE+ZMMV3b6gqRPEyv2IvD1
	BD24Kk1nE5fORPCEJecR2FClr6VDam4EPkKoQV8fpLp44OUvzFFpoGm6hOtqvZM2tEgO3gMvxLJ
	NesGkgR4NsWyzaIup8lHPJ4gFowy7PMG3I+hJMKSrOuo51dw/QIgX6EPEoNSP5bWxRaQXY/UqWn
	8RL7NDFzXyj03/sYj42HNZBUmogQ/bwb9KdG7G12/U+MdnwwQ+MF58rSxoOv/09NlWip7jsUQ==
X-Google-Smtp-Source: AGHT+IFmVeZA7a04nKu5uP3hkyO3yyT9r9H8R4UMIdEmCc8mPaH6OfXpUfFd9SGnpKj4tZzw3EWF2w==
X-Received: by 2002:a05:6870:d0f:b0:29e:48d6:2e62 with SMTP id 586e51a60fabf-2aa0652ce6cmr643330fac.9.1736303122595;
        Tue, 07 Jan 2025 18:25:22 -0800 (PST)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2a7d77f6340sm13072862fac.48.2025.01.07.18.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 18:25:21 -0800 (PST)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 3/6] wifi: mt76: mt7925: fix the wrong simultaneous cap for MLO
Date: Tue,  7 Jan 2025 18:25:06 -0800
Message-Id: <20250108022509.217803-3-sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250108022509.217803-1-sean.wang@kernel.org>
References: <20250108022509.217803-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

The mt7925 chip is only support a single radio, so the maximum
number of simultaneous should be 0.

Fixes: 86c051f2c418 ("wifi: mt76: mt7925: enabling MLO when the firmware supports it")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 6c8a9ebfbe5b..35dede041248 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -256,7 +256,7 @@ int mt7925_init_mlo_caps(struct mt792x_phy *phy)
 
 	ext_capab[0].eml_capabilities = phy->eml_cap;
 	ext_capab[0].mld_capa_and_ops =
-		u16_encode_bits(1, IEEE80211_MLD_CAP_OP_MAX_SIMUL_LINKS);
+		u16_encode_bits(0, IEEE80211_MLD_CAP_OP_MAX_SIMUL_LINKS);
 
 	wiphy->flags |= WIPHY_FLAG_SUPPORTS_MLO;
 	wiphy->iftype_ext_capab = ext_capab;
-- 
2.25.1


