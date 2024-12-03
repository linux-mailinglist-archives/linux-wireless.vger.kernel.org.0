Return-Path: <linux-wireless+bounces-15857-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAADA9E1D16
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 14:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ABD8283830
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 13:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A931F427B;
	Tue,  3 Dec 2024 13:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8O3LikZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9201F1319;
	Tue,  3 Dec 2024 13:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733231233; cv=none; b=bEplvRVLfJgEOndeeGKxWYfEEagDg58LDc6bpc+Ke8YgzoB2hog0KUYiV61XvJGVjLPebJ3iFntfaAOt8hPxUEww/X7naXGBCrnNHyYTHBYKaU0UHXXwvrFIayO1VVOqBictjh40dE7vUww7MkPEGqf67lJLCrwQ50vOOYzv8Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733231233; c=relaxed/simple;
	bh=gYFiLhOxPkA0x0nKHe+w5/cQnq26kaDaguojzF3mZ5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tR/rsZp3A+6YLDCuwgPXe6xbNUC8eFhx1+v3eZXrpzHBRbQx2GKzn9Cy+EqPCjeKDXf09pFMRn+8m9DR+ehLADINGADU2MTyP0JvzDAHashWLaEb/B3WKXDWobSmAHhRxvXorM25VHG24JblAFuSZiUL8JKkbdr6h9hc9ApSDKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8O3LikZ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385d6e36de7so4724258f8f.0;
        Tue, 03 Dec 2024 05:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733231229; x=1733836029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/bpKZShdoezXsC+X6a595d2PApM2wBX2FBj3mwqdO28=;
        b=T8O3LikZN/Ef4iBlZ19PlFWkpR+vYpsy0l8yI17ksyDi9lz2ZtR14iQa/aDNE29NlN
         GBFHxcHO3AYr+e5f/JIg5yh7Xm2uc/U7ZCB9f2ktW3cZe0rjojPqRQVULKMioaRXEEuK
         EfXt5jU5UtxS/wi76f20HDwv3Mc1JRIlZua18Htbn+pmbimKZy56WCAzs8UtXG89xb3O
         V3Auwp5s8qPQInAks3EoLLww/9uOTcR/hVjn0NPYbeLNANvzDyhKS/nOYdY7s9n5sBoC
         2uSdux7U85rqYol3YW6S9aR319mmP2P1VjG1haLG7Jb9Jwhqi1pFvexHWifvFPyEntyT
         cYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733231229; x=1733836029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/bpKZShdoezXsC+X6a595d2PApM2wBX2FBj3mwqdO28=;
        b=evBzlCEm7SahaqEGqUskcGDe0uM7rjSVV37khy+W4ShgoF7q/jc8VQB28qjxyf/BRq
         qC0s6+/BGSKN4eCnpcoTFknDCesxNBpovb6Glr5GFsaib/BmaaCUy3ElgLtvl/OfllwI
         9VZQoACcscaQQt7g2tDO19czh6ZcPe+YuWW/JYamRR9pfTy7yBZPdPyEDZ/q69uzOktr
         gTO6j44K/wujNOMYqzwLpj/FzpcS5K8xpqL7uL0aL+rlaRvaa6oydWlyZPGywwpwUNue
         eneaOQsDTC4BQMkP267tV4BeTjfbrlVjtpo54N0Ann/4IPOC9PO8+opa7rubhHvb0Pqh
         281w==
X-Forwarded-Encrypted: i=1; AJvYcCW8fgssEv+FWKp2/iyxiK8LAz1okFjQQ7cdhCsr6UzHEWex/e5p8ONvO0uShDKFnVMLrgezuLghCMALSrOLhA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyzACvRMkHOGmhGpZ2d/sXJuzZxXF1+zgKXPJPxphxoj2ivCJow
	I+oYP+w6RDvlnLJCk8LKP64TYFdDgmOzN1Au87wXk7lkxk7w3zkrDLWzlw==
X-Gm-Gg: ASbGncsmTADqPA6YuLmnxRBx1kZ5UtJzd82m+bM4MhPoQjyHUoWGK/lOayOdAEj8dGu
	eiTpI4HxAvq/fvk/KKHlsEwPlPymiVo1IfLl2qvtV0HPbSZUuRYnmyREUjFb391Guiz2ndn70Zo
	fUi8vy4zTJjFOCdNLDxkAZt7/CY1lqOWPkxp24d2ixNmDzw6IVYlO+8izRUJWxuQj4lBQBzV2Zl
	Bdy64o/5X+sgnHptfqI4Fp3CSEV7FiSWxNAWiYMd5RbLahlhqNqKYwMDM13YQVprZU=
X-Google-Smtp-Source: AGHT+IGT2e1WnoGquvUF3C/VGLlQC+U87oREyJDHons73U2Xm2WclvKtjBLv9DcY46Zm39J28Qpzsg==
X-Received: by 2002:a05:6000:2c6:b0:385:ebaf:3824 with SMTP id ffacd0b85a97d-385fd3f2d22mr2508811f8f.27.1733231228926;
        Tue, 03 Dec 2024 05:07:08 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:6140:2ef3:aaa:55ca])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7e4d42sm219142365e9.37.2024.12.03.05.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 05:07:08 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1 6/7] netlink: specs: add s8, s16 to genetlink schemas
Date: Tue,  3 Dec 2024 13:06:54 +0000
Message-ID: <20241203130655.45293-7-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241203130655.45293-1-donald.hunter@gmail.com>
References: <20241203130655.45293-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add s8 and s16 types to the genetlink schemas to align scalar types
across all schemas.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/genetlink-c.yaml      | 2 +-
 Documentation/netlink/genetlink-legacy.yaml | 2 +-
 Documentation/netlink/genetlink.yaml        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/netlink/genetlink-c.yaml b/Documentation/netlink/genetlink-c.yaml
index 4f803eaac6d8..473c50b73522 100644
--- a/Documentation/netlink/genetlink-c.yaml
+++ b/Documentation/netlink/genetlink-c.yaml
@@ -157,7 +157,7 @@ properties:
                 type: string
               type: &attr-type
                 enum: [ unused, pad, flag, binary,
-                        uint, sint, u8, u16, u32, u64, s32, s64,
+                        uint, sint, u8, u16, u32, u64, s8, s16, s32, s64,
                         string, nest, indexed-array, nest-type-value ]
               doc:
                 description: Documentation of the attribute.
diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index f8be52e7793b..68462c6d7cca 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -203,7 +203,7 @@ properties:
               type: &attr-type
                 description: The netlink attribute type
                 enum: [ unused, pad, flag, binary, bitfield32,
-                        uint, sint, u8, u16, u32, u64, s32, s64,
+                        uint, sint, u8, u16, u32, u64, s8, s16, s32, s64,
                         string, nest, indexed-array, nest-type-value ]
               doc:
                 description: Documentation of the attribute.
diff --git a/Documentation/netlink/genetlink.yaml b/Documentation/netlink/genetlink.yaml
index b036227b46f1..11c1592d49be 100644
--- a/Documentation/netlink/genetlink.yaml
+++ b/Documentation/netlink/genetlink.yaml
@@ -123,7 +123,7 @@ properties:
                 type: string
               type: &attr-type
                 enum: [ unused, pad, flag, binary,
-                        uint, sint, u8, u16, u32, u64, s32, s64,
+                        uint, sint, u8, u16, u32, u64, s8, s16, s32, s64,
                         string, nest, indexed-array, nest-type-value ]
               doc:
                 description: Documentation of the attribute.
-- 
2.47.1


