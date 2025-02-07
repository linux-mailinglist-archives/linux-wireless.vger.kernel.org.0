Return-Path: <linux-wireless+bounces-18620-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 651EEA2C251
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 13:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E301716A8D9
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 12:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42351E04BA;
	Fri,  7 Feb 2025 12:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NelkyRY7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE2B1DC9B4;
	Fri,  7 Feb 2025 12:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738930523; cv=none; b=udCwdhLxxlQauOZ20fIVOeeL0sN001IhnQzK+6lqLe5KyFnC2Ty5Hy46i4H4nUH8EQXBrNI2zp7PXeTR2sa4unDAMSydppnSnZYEmkgSXqErgCxNOtT+YEgn80EyKvHs7/kZr/OWhBKq/0eEwnPDISjN6MWWcARVUxtQ+ZdEVMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738930523; c=relaxed/simple;
	bh=WSmza9m5lqfjaJbkYShhNi8pvsDhRW/0u6ShwBBGN1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9s27ckPVdUfB2Ct8R+7lzHo5az2ZxFZSMRk51vWcSYs/jxC0IFFGwH75403vBFfgmObesw82dBgDH6MW4bBlZ9v3AYq+/7RHvj+tiUcWbYS0TILiPUNg4pr8qLup/79mpMrROt87uFqgMMfTURbyB3Eewox0uzeFQfofOPiq2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NelkyRY7; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38da88e6db0so961924f8f.2;
        Fri, 07 Feb 2025 04:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738930520; x=1739535320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukI9L+W3BVJpqtTUxee+mj8XRSqHm8hW8ALqrNrwT90=;
        b=NelkyRY7OLkZgBxf+AUw9WMXeITUotRwzSfilCQe+akVzk1aKN5R8N1PTmxSyVsJ17
         scnwfNLwo/HtZGw/EyNK8do5hw/e/dxLF0o9zDm+H48uQzz3dq5zqZ7B751VkWuNFtfO
         KJfcjCjNcyEU2xTLB/3loY2iMrmMXwutrBghXmeH8ixaiiJfJzDw2YuwoYU/7EG7B2Z3
         mWz69acFqA1y648j2wP5rQZ2lEM1VB6OAeBJCFhUb+svmLqZiAhptXxP2fAl63h8JE0e
         ezyaenCSGBYDPtDpRA7Z8kf3fOpn8sbdvpNG6aJLhJs0e+zeeaeGpqaqxswZQ8Twxl1X
         H1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738930520; x=1739535320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ukI9L+W3BVJpqtTUxee+mj8XRSqHm8hW8ALqrNrwT90=;
        b=rHofOxC5xx9u9LGj3JVaSIcPuy6KIrPkw7xOh77zsRd/puGnKnQ6Yt+IOUTwfFiY/T
         Qtf5mP7aH46e7TDt6BNkGbqipPGMf9lhD6osxux2rJR3Scgk2AB++J5mXJaP8Cva7JX1
         sqhOxpmf30DRfGKR7m6YZWAvTrw53EK7aWY4rAB3PHNdQHdkaLTZKL5k639reYQFgof7
         8cQam3mhx/WLVJdlH2SZxKkKFXSGlog/C2JsGtZmYQUOBRuoFv78FWxQje73CMiWefsa
         Cog/ZnzdDsIgBrVY//CaPT+Di4JIj1vlI3hEqzCXG8t19vkuDL3fuwlGSfNT+8882Yv4
         I7gA==
X-Forwarded-Encrypted: i=1; AJvYcCWifuWFsosE1O3+zYO64akE67nFSAhmic3IE5J06hrCQaM3G4r/EmUpJYy7A2o8GA8i/y+Gs7DiznzqLT1NvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQrAbYG+QTKjHYzeLzEyiP7KODorKHBe/y8fZ3IhzsRHRhCD4S
	MoGIndA/K/jB2nG1xLBVriuGUxsA1EUAPPaSwyZy05LV949QkSjJdvntZA==
X-Gm-Gg: ASbGncskwnlFwP6vpKr3NKsaozRXubGY99/hNGJxmR2P8ZtjorpVNSqeyiP10ATT1Pg
	rflYxmmBjGAuc9mAOMvHNMgV/Vqxm2Figb8dVFBg720UD9hHzOOHpK/oaB13hyaY4MntyKRiIxJ
	TiKMW6ka+hSvMI0PJbbCCSbDfem0hfgmVH/0wWxdRuT2E1lB6j8HQG32KuE/HI3RtF1rWFvYGp5
	ew+ejmPT+uDL/1XD3HUruMhSgVZVVF1V4QAufRjggTGPRxue+K6KFx8gQ4+uKlaEWXUvbZV09hQ
	JKaOG7tUfjCvtcD5IdhWZU1P6ag6nK7GZA==
X-Google-Smtp-Source: AGHT+IE5bzxTXUzkblrWpaakpQwArAU9kIvC8pXsmccIfMbvzfZsR7+njlkdzXA8Nn/coHZz68pWcQ==
X-Received: by 2002:a05:6000:1447:b0:38d:b547:6650 with SMTP id ffacd0b85a97d-38dc8fe575emr2066949f8f.27.1738930519410;
        Fri, 07 Feb 2025 04:15:19 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:ac43:c7d9:c802:8ec3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391dfc87d2sm51555035e9.26.2025.02.07.04.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 04:15:18 -0800 (PST)
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
Subject: [PATCH net-next v4 01/10] tools/net/ynl: remove extraneous plural from variable names
Date: Fri,  7 Feb 2025 12:14:58 +0000
Message-ID: <20250207121507.94221-2-donald.hunter@gmail.com>
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

_decode_array_attr() uses variable subattrs in every branch when only
one branch decodes more than a single attribute.

Change the variable name to subattr in the branches that only decode a
single attribute so that the intent is more obvious.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
Acked-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/lib/ynl.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index 08f8bf89cfc2..8b39d8b1eaa8 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -644,15 +644,15 @@ class YnlFamily(SpecFamily):
                 subattrs = self._decode(NlAttrs(item.raw), attr_spec['nested-attributes'])
                 decoded.append({ item.type: subattrs })
             elif attr_spec["sub-type"] == 'binary':
-                subattrs = item.as_bin()
+                subattr = item.as_bin()
                 if attr_spec.display_hint:
-                    subattrs = self._formatted_string(subattrs, attr_spec.display_hint)
-                decoded.append(subattrs)
+                    subattr = self._formatted_string(subattr, attr_spec.display_hint)
+                decoded.append(subattr)
             elif attr_spec["sub-type"] in NlAttr.type_formats:
-                subattrs = item.as_scalar(attr_spec['sub-type'], attr_spec.byte_order)
+                subattr = item.as_scalar(attr_spec['sub-type'], attr_spec.byte_order)
                 if attr_spec.display_hint:
-                    subattrs = self._formatted_string(subattrs, attr_spec.display_hint)
-                decoded.append(subattrs)
+                    subattr = self._formatted_string(subattr, attr_spec.display_hint)
+                decoded.append(subattr)
             else:
                 raise Exception(f'Unknown {attr_spec["sub-type"]} with name {attr_spec["name"]}')
         return decoded
-- 
2.48.1


