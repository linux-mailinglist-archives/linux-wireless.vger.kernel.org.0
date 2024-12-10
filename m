Return-Path: <linux-wireless+bounces-16174-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9A29EB5D8
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 17:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8958283B04
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 16:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E3623496C;
	Tue, 10 Dec 2024 16:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOgPoLaJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC293234982;
	Tue, 10 Dec 2024 16:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733847308; cv=none; b=RdSXADmAaqUBmp6lOser0JEePfURc6PtuxHv4AJfGk7VIaLJ1n6P5qOrp1DyRMLWQyhUZs2qf4CEUDtGDc8CrE4ipD2vtVLrSoCJMAdkd/KeI0BGsBtzEwVHo8TIU2jLt/gkK3Ilj4v/aB8ENn1/DuLs+MRu4vliPJNA1a7w44M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733847308; c=relaxed/simple;
	bh=INjc3lTxaTUv0xreNgPhd2hYLMGopGNiP17h3MeQ6GA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tBIo7/xGeJwJhVw9TCzfEYBvyYrIWthGyXMDB4q5BblgCrbQmQZ0JI563iPYjhKjszNSt3ePSpjd+QZQZyg80hh6dBJtuykg4EX6luTaND1TbLXj0tbBhs9DTfr1Udth8by+jcB6D2TSCn832LPVL0lERnSmlmmjav3FJG0xaY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOgPoLaJ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-434a736518eso64293825e9.1;
        Tue, 10 Dec 2024 08:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733847305; x=1734452105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+fKNnTxR7JlpdmFjGqdREB0oT6hlKwkDIMPk35TRKA=;
        b=JOgPoLaJCG+W8YX2I766gw6jQefNSpYWDIjdR8428wPvYKxJ0+ja6jBE5/waX5cZzC
         oAKIYnsRtZ+o70ng64kkIwhBb4N88C2NazJSu7eymC0N41CVzz9Cux9o2imiE8R5Jtow
         YS73hFFihaiGFo+kUREWrSn5j2Sfo+zaMThDXa88x6BkCZBaQvlxFbEYbkyTqof/8ISc
         V0eWR9Hpw3JqJ7TOb6QA8+ULI+YFo9w8eSSgv7oGo3SxukjlInZ45yKRvD079nPESymu
         1Ef1zdJ3lhCx1q4Vr6OUBVIWNTHy/OPeYLftbpO80eil7lVHJ4If69gR4v8o3CBdv8ww
         Ddsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733847305; x=1734452105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q+fKNnTxR7JlpdmFjGqdREB0oT6hlKwkDIMPk35TRKA=;
        b=iIUuNgCJYJ4R2UK2UqPM7TwAdoSxtdwBoap2b/NjcVTHnBg+XRuE3SycqVHHH1waJP
         QjK8xXQBsscjwextCEX+DY3BNhWUdXoCYuRoBp9FOqcAveHVKGrkTLNxTCnAp2ffCqzL
         gxYi8sOlIKAFvftqDgd7nH34LJ2y+2X8cbhhGqMR7CXzvPYuzvl/XDYy10Iop2Dd0gdi
         6JiitghmgFEIc+ioomQjj7z5Y0Bp5W7YU20i89R/6M4WM3TrM+piTN5251SF6M2755Sn
         aKImzvc7X9JJxJo6NMG1jJ6cVMSa95Sy52NSmOIPjmTPXkvE/nzbKfQVPlZea6PhF3xU
         TGMg==
X-Forwarded-Encrypted: i=1; AJvYcCUrwqtbgsJuMXUVxhcgb8L3g63OxHEOg9+sZ126GuW6TM9R8KDe4wzy9l2iCafMgwUgvujcO/fIK0ZWs5r1cQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzM+lbKRViqoDVz2PHWcIepgfSzmnCUv7/BvKR/SIewusDN7lMw
	dI371wSergJJ17vfVOmAoyim94ZAKuSDxN8sJIqjj2e4DsXefLRA6w9R4Q==
X-Gm-Gg: ASbGncu9YycyV4v1/Bz/dqvXxbnxQpKHPHRWjhIvVXcYvjeRZmUnBg66H3GWlrh57mS
	dPZC0S7iLYrd/C03BHpvSzyOqW7D+MuYSk2IzSByRuDxXqJj+TlQ/Xh/qadU2pim8Tj7ZcI7G5J
	fN9Wl24Ms4vlJySCU0M6jYNOZ0EHeDx+KmxNwtFdz1h8HmEW1QNGYTKJInK0nXAVUoPn/R0RQTM
	x2Xfxd7S859BPx9eqn7Y/U12PPwDF6FsbRIJIzEdlXTWlnNdHGblYeR/wDQZ5pqSgXMPJN/
X-Google-Smtp-Source: AGHT+IH5Rp/5Gazb1vICk8qkAqqI1T/UcFMLoV5iYK8V0f4SZz46M1FL/UYomfFbMxwdoqbo255kuQ==
X-Received: by 2002:a05:600c:241:b0:436:18d0:aa6e with SMTP id 5b1f17b1804b1-43618d0ab9fmr22529025e9.5.1733847304380;
        Tue, 10 Dec 2024 08:15:04 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:75bb:8102:943a:2eb2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f30bceadsm102383045e9.41.2024.12.10.08.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 08:15:03 -0800 (PST)
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
Subject: [PATCH net-next v2 6/7] netlink: specs: add s8, s16 to genetlink schemas
Date: Tue, 10 Dec 2024 16:14:47 +0000
Message-ID: <20241210161448.76799-7-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241210161448.76799-1-donald.hunter@gmail.com>
References: <20241210161448.76799-1-donald.hunter@gmail.com>
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
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/genetlink-c.yaml      | 2 +-
 Documentation/netlink/genetlink-legacy.yaml | 2 +-
 Documentation/netlink/genetlink.yaml        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/netlink/genetlink-c.yaml b/Documentation/netlink/genetlink-c.yaml
index 9660ffb1ed6a..1cfc8073a120 100644
--- a/Documentation/netlink/genetlink-c.yaml
+++ b/Documentation/netlink/genetlink-c.yaml
@@ -160,7 +160,7 @@ properties:
                 type: string
               type: &attr-type
                 enum: [ unused, pad, flag, binary,
-                        uint, sint, u8, u16, u32, u64, s32, s64,
+                        uint, sint, u8, u16, u32, u64, s8, s16, s32, s64,
                         string, nest, indexed-array, nest-type-value ]
               doc:
                 description: Documentation of the attribute.
diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index 7520f63ec3d2..f98ed12a09c0 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -206,7 +206,7 @@ properties:
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


