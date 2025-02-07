Return-Path: <linux-wireless+bounces-18628-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 064D2A2C260
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 13:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87C5816AF7C
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 12:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F3E1F63F3;
	Fri,  7 Feb 2025 12:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFLabzSo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86861E0E0F;
	Fri,  7 Feb 2025 12:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738930534; cv=none; b=co2Tylqd4ajNYEKdjEk65zof9E/BiQoYpK+Wn3d6+uNCp6gBVygZmfwxFkICt9q+dqpST3Aqg2wpgrmwKO3ZK+PnomiwqIan/1WHwSH0ciDKnMHyJgdRTYus4hfV8vOxDz8gFbQkdOdLX8ZNalfaT80CeH0zDyG5JV13jILZzoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738930534; c=relaxed/simple;
	bh=hngH+nkRM+69V8gMEYAXSayqQbNSU/kvsOcQdYK01ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eBa3X3kGTdSnqNw0Whz80CTE0A4volwK9BjeS0Ge10Ljn746FEO2yrwOtw7rm15QIDUY95R9mJa6x1KuV2XHQslHv1EXT2AcVqGtFnEIGO0XsqoOYCZPrS/1yZaV+dGhtsbi1FYqetYqP1FVLw1B2lAyLawK5ldNuFG6PgrsF/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFLabzSo; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43618283d48so14184125e9.1;
        Fri, 07 Feb 2025 04:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738930531; x=1739535331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpSnMf/WKCpk42PUpTTHzELsWuR5f0+/8dWnGZMy7ow=;
        b=JFLabzSo0/KviY6geByaOCgWIxz2xlved+ZjgOfS3YHLyGkqHuXz2liwlmHIXI1ySR
         Ag25hZlErIMVaRbp3NDHSdPR42BilqIqw+kx2x5R+SIL+DafSDKXNTU7taPor19pydRo
         Mx++YuQkAuX00S4x903Gu88OZBZXDevOcQCIaqHbYOJB9H3ayDD3XH27sRhoTujMqGV9
         nM8oEJ4kDavVWgSgPmaCFMZlWiTvUQPZ8RPvzg53yE8GbRtR00aQ4ISEJZ37uwky9ZsZ
         v2447SbPHyU1pXUusVf25FZWckRcyk2r51aj0YlvIflL4Vo6GhfPt5nnlF23RdSuZal4
         p7kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738930531; x=1739535331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tpSnMf/WKCpk42PUpTTHzELsWuR5f0+/8dWnGZMy7ow=;
        b=JiTubB4SpI9kqk4HGcTaqQQOxICK5/28AE2dtNSfn1WwsSC6844ahiJcuV1qI0fIge
         xP4qrTb97QOhFMdwwLfALfRYfgWM9eg/WBy1u1Ts/sxHISOlRX3LWqg7BIkp1DsMpT8X
         9ns1LpsQK8SpU2zdl0/tErIsRiRlmYS3obXKHAS3MPheG4J+MW2KQq+Kwls9UVZzAGMg
         pXqRK00r1vJqKrbdTOdwYmcbKURApxW3lLIR3e2pzJuw4qfwk+djSX6y8rUzKydaIRA4
         Kfwg88LD7PL98TORdr0jLec7nON+LHvGD8TPjerx7Kx9DsokjyCSCS4Rou6f7MDo0le5
         utlw==
X-Forwarded-Encrypted: i=1; AJvYcCX7f5qy1knbIKzkKxys0Gtuw5LtIwdi0AFDk46pvOIlZeq8oIhN91bV8xPCuJgZ6kpQzl7kb9EyGGwANCy1EQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTSuivcEtG7U+ZST/EpigKCri1Gf2E8oiL7g4VQ8mfm+imkOYi
	PcQ49mF4C43PaaKCkegn3FUux2c7TugCsgL3bwuYsq03HFsFpLXt+Sk0sQ==
X-Gm-Gg: ASbGncud+rX0D9+7eWar5Td7GBbJwWaM5N9OXycshUpYV+LZ2TSclAE9V9o9fJx4uUy
	xdKdcG6bSG2lgkDQl2PmEehHetUQWruRIW4JQSj/Sl64eE25EFj7ac0UgRwXmy8nIZyn4R0n/FL
	BqSyNqgPuJaGYH6RVMzMZHq9c8BPAVE4j0DTrbS1CZ74olsQMNq0VfZlO2Q0DIs/HM556PePAvr
	punuzpAG6q+yIyBdWnTFWS7eNu4xlH8IGA+AETio4Y31wdcxURTqFzeNyOfDAis6vF4ar9xgMex
	Q7BqCCqpxf+t8I3hJI17Tcb8kxyar7X95g==
X-Google-Smtp-Source: AGHT+IENGZLfk9FVV7tJZN4PHgSMrIpGttPp3vESEeWtShkguEhGhozneomPuzeoHyvgJ+KnzbvOrw==
X-Received: by 2002:a05:600c:3549:b0:435:194:3cdf with SMTP id 5b1f17b1804b1-439249b2a9fmr24129935e9.19.1738930530648;
        Fri, 07 Feb 2025 04:15:30 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:ac43:c7d9:c802:8ec3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391dfc87d2sm51555035e9.26.2025.02.07.04.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 04:15:29 -0800 (PST)
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
Subject: [PATCH net-next v4 09/10] netlink: specs: add s8, s16 to genetlink schemas
Date: Fri,  7 Feb 2025 12:15:06 +0000
Message-ID: <20250207121507.94221-10-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207121507.94221-1-donald.hunter@gmail.com>
References: <20250207121507.94221-1-donald.hunter@gmail.com>
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
index 44f2226160ca..96fa1f1522ed 100644
--- a/Documentation/netlink/genetlink-c.yaml
+++ b/Documentation/netlink/genetlink-c.yaml
@@ -161,7 +161,7 @@ properties:
                 type: string
               type: &attr-type
                 enum: [ unused, pad, flag, binary,
-                        uint, sint, u8, u16, u32, u64, s32, s64,
+                        uint, sint, u8, u16, u32, u64, s8, s16, s32, s64,
                         string, nest, indexed-array, nest-type-value ]
               doc:
                 description: Documentation of the attribute.
diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index c02ed8089746..a8c5b521937d 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -207,7 +207,7 @@ properties:
               type: &attr-type
                 description: The netlink attribute type
                 enum: [ unused, pad, flag, binary, bitfield32,
-                        uint, sint, u8, u16, u32, u64, s32, s64,
+                        uint, sint, u8, u16, u32, u64, s8, s16, s32, s64,
                         string, nest, indexed-array, nest-type-value ]
               doc:
                 description: Documentation of the attribute.
diff --git a/Documentation/netlink/genetlink.yaml b/Documentation/netlink/genetlink.yaml
index e43e50dba2e4..40efbbad76ab 100644
--- a/Documentation/netlink/genetlink.yaml
+++ b/Documentation/netlink/genetlink.yaml
@@ -124,7 +124,7 @@ properties:
                 type: string
               type: &attr-type
                 enum: [ unused, pad, flag, binary,
-                        uint, sint, u8, u16, u32, u64, s32, s64,
+                        uint, sint, u8, u16, u32, u64, s8, s16, s32, s64,
                         string, nest, indexed-array, nest-type-value ]
               doc:
                 description: Documentation of the attribute.
-- 
2.48.1


