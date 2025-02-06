Return-Path: <linux-wireless+bounces-18586-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E0BA2A44C
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 10:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D95B8160129
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 09:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4611C227B93;
	Thu,  6 Feb 2025 09:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDoAVcam"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A6E22758C;
	Thu,  6 Feb 2025 09:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738834047; cv=none; b=Qkc7w1RZ6QMNBztL6HMDrZF4jj6CuYCWv3T5RtbwMPXdkZKPSDMIRr0qcLj8RMgNZWlWmP1FBXNJcqMRFxrc4HjIFCVMk6mj32JrdPKzPiqcqpNXISZ9t4mOOKRMhCDufUygCXAGHnb0chKeKx6ZZj6xNhb6PfZOvvW5wubnU4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738834047; c=relaxed/simple;
	bh=QmsEzKzzJGYOq874VAOHSiVw74tkMZ15y3+V3jZrZho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V+AT0LyfJ5JWajrefgoNsLsYqKC1iJCYtpRbr70d1p3CwqIwcHd9/RsKeYGYUgRbnTUsF8YYNcZVfAvZKHYmFTGLC83JqKi9HRu5VS3HF9aaAR+hIKI79ORJVOQ7RjhMNga0dRzk8Amli+hZ8huF2Mrz9oNnSDN2sOujmnPM2dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDoAVcam; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-436202dd7f6so7427345e9.0;
        Thu, 06 Feb 2025 01:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738834043; x=1739438843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4agwNFdanzCPIa9NngSa+bE/mcZ7MdAmDzxhW61I1Yg=;
        b=eDoAVcamLNijWfqAGrL8nJ9KwZPOAZ1VycqbKI5UHlbhNfcK3AMVKcj9NqZi97YORw
         6F/2pWEfxHnc6M4Lt++lp5O6Q4sZm1ZogK+HrH0572v7P4KOaQlS2EBpa7dEzVkI2lCg
         PHyF+diJuNBC/ZnrZYNX50bRqcsMN0Ty7pwH3W7Qj/KMSJxrZ13ll9GFUkC6oSzIvtXK
         wc6+GqDLi4vVq+bMnL7ucesfBvu97i81HPASIjnfkXFSKvUf6kZ+lU3CpqXov54P6/v/
         4F6o4tg1KuM3OSueiYoRgf2VGpuM9VIqQr+l4KfB3oC9zSOcj98bjTdfLRuam9q2eXI4
         IQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738834043; x=1739438843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4agwNFdanzCPIa9NngSa+bE/mcZ7MdAmDzxhW61I1Yg=;
        b=Wm1Sd5vniuiXqQVTLr0SinuOf7vHzKom3w43R/5rRcGHdd9s3rjrWQ4GHagwuCMtfN
         2xz/wPXxtqaKg+i2/5lY/cgp3xbPNJvjuSKpgT3sc15EUTkoqGUMeXg8xW7MbnwokDDs
         +9jeFe0fwOrvyOxxrD2CoKmdnZ7yd//lAAKERMz29gE23Dq6KxZK0p+ACSdO9sCh6O79
         BdQ2pYUMpBL/L9BDkpS+IpilMRQLzV8HWJzRCkXY1xDHKYyH6ueKJBpk9/0r1DswPamc
         6Pityk8yjsCRvaUfynkzp+wJW6/hFn3SV9KHwbaKrpErpegNiwIUFRIE5UY6LsWmhkbX
         Rknw==
X-Forwarded-Encrypted: i=1; AJvYcCVP4NzQrRk5rz0LTRilfm7FgQCKf4cOMt7rxXLC+Npzl5YLjRyWPP/4CRGUXKDVX08PT73a7KWVdM3TDWrjsg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw09EVnUSf+HBLbixnk41jh6Lnl2bA2qXig0g6aoQ1iASxVCIIS
	7J69w3iNpONeEieeWDe1/B/Vj0vIbLubqWMUzseSKTN3U0o0dWkdGUUDfw==
X-Gm-Gg: ASbGnctHy6f621rtn2uxIcOY+1ToSUZRKOTCl7R6adwcOtULz7MA9qEz6KTLWyupPmk
	2YLBTc8fDwxItOreT8AWUBr2J3LTxuwAWlS7dM0gmfW8qX4FvZbt1fF2pQejaIh9tbhV6dFq95p
	2aRTrNO7Mz7JUZAgfX3Lzd7mcfqpXXWY2zkWwON7cVD8ciTddupkJDAraG716hebtjt73wDXHmX
	/e9zrim26G2c6aUZCoXZsdq1Cv4qZ+doHz0U6w5OdLA1y4xhabpKCxXi1s57lm0nCF3Jii9UdLg
	rn21TmhvqlAXmAvgOSPEbSiCgSIix6TSpQ==
X-Google-Smtp-Source: AGHT+IERC9nP8+4HMx93VvS/7xBayoNuPNvFUZda3ucW7t1Sxz5E9YrIEfzCWRyLHcbpmQuTU4Wxyw==
X-Received: by 2002:a05:600c:1d0f:b0:436:fa4f:a1cf with SMTP id 5b1f17b1804b1-4390d574df3mr49021995e9.29.1738834043170;
        Thu, 06 Feb 2025 01:27:23 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:c428:5404:970c:34c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391dca004esm12832585e9.13.2025.02.06.01.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 01:27:22 -0800 (PST)
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
Subject: [PATCH net-next v3 09/10] netlink: specs: add s8, s16 to genetlink schemas
Date: Thu,  6 Feb 2025 09:26:57 +0000
Message-ID: <20250206092658.1383-10-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250206092658.1383-1-donald.hunter@gmail.com>
References: <20250206092658.1383-1-donald.hunter@gmail.com>
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
2.48.1


