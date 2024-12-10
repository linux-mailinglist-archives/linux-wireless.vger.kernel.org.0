Return-Path: <linux-wireless+bounces-16173-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A790F9EB5D7
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 17:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7EF42836F9
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 16:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214BA237A20;
	Tue, 10 Dec 2024 16:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbHxWSI0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5670923315C;
	Tue, 10 Dec 2024 16:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733847307; cv=none; b=KKtJ1VY8++ohbcb5NRmoCt+Ft2rxHaum/OAIO7Ob8Kv2fQJKu3Xpn8IID+yC2bnk+D+TH0Aws4smiTJlsNYVngO4oTmPk9RVDx8XWEJucpjvujKx256T5B1pB3E5ylrYqBVYI+jnzvsjeQcIiCQvvP/kO3eSUuNXJHeANpCS6DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733847307; c=relaxed/simple;
	bh=9NI8NiK7Pl8UWxcrZocddxLe+b2veW5kAMiWu8Q1SqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jUmVP3mCXnK7EBkh878YeL6G16+EZm20pHwEvRVSiJwUKe40LRiU1cGLcP84oUM3fe4mMB/bpHqHEZMnnNbxi7WUBc3Y37Cwro9pz9sFX0s386B/GV3Uv2Ovh6VzdHOyqpef2t4dYyGU2Qkjs78X/uvfqYgvhbw3pq6Srh2+8Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbHxWSI0; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4361a50e337so3337845e9.0;
        Tue, 10 Dec 2024 08:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733847303; x=1734452103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C79PbJdrYfJ7dR5W/njrDxtgWf/K1Zbk95Sw0l32mR8=;
        b=hbHxWSI0byiK8s3j5AV48T15S7U60THZ2QfvnXTwBV7GdgWcVuIPwFevoQOwuvzqgA
         0vutXxSGgKNj1cXE0KF6hWZmcRiqx6zgSUigfAYjLwoAucDXd9LR+GQd0gB+RraXxPkN
         uolPU55nGdapzQm0yS7iW/CXxUPWMlEr4XY6FRZ0WVeTYZeI/OGII+C8s7/cKdAd8Fpr
         zUYCn6RK24ExhB8XeSDop3XG7ckioqgWfVkj8Pd6hGLstoUWx1dEjrg7ZUrNoJpVRjG+
         AY0PxzvdNU2gXS6ieiCpuyj4V1QKPhvBavHDQl6b1cSZg+zPwsRF0xW8Vi5QQp5G5AN/
         UP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733847303; x=1734452103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C79PbJdrYfJ7dR5W/njrDxtgWf/K1Zbk95Sw0l32mR8=;
        b=m3/CkGNS9KB6JYZOyvuraIkaOu7bClEabrjp0fy13FYJCCPkMQ+RoLzpMLP2UgNZhi
         YCOYVCj97+EoeeJX2CTr77vb3ZckLa6WlsbddAun09k7PcjqTGah8g81EkgdepgL25aA
         TFMrVtwCQaZpnrdFgzjE3B91yb6Dulu+oa0z0nDPxDETqPmCkIcSQyX2Gv/moJTQCrtx
         sq4+Jumqf6wjevon+fcvPqFZy+pqgQaPwLrcHq4k7W9pk0yYVYVowZZyTQrcWKCYPNjP
         RW1B5EBE/bJ437S6/65IttfhQ5ys/PFU47fn+/7vZzMfL/abJLa+C5SEeiAqavrmpfhV
         E2bw==
X-Forwarded-Encrypted: i=1; AJvYcCUQWoFBz06E4g++MzXtojKvZBYjuMchS+U/uT7I5BtEl6AeYL9DIeY6NKwiTeGfatxFNJpyKo4+f0xr7GuCHw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yza68Tcp5HU4u/HJoTDoCkUDGnkBmC0gJkfX/5ytGtlBbJQ0egN
	O5KEJel+mwLO2y94UWaOFz/l4wHTPICprwRZm9uMZtE6B3IBg6vTzYQ7Aw==
X-Gm-Gg: ASbGncsWlN2jw++E+2AcBEF/qJsvtx5VIWq2LZl6+6bc/nHg0tY+fCrwKDUcR81eLFO
	lAk6mmnwFN5B4kN8qRGTyo41kRCbYNq68pIAC3R4Rag/wCKfIK4JQ0gNrYLmnUTq5rUewy2bkux
	EZ4s2YzkLKhNBlSCX7FLol0kmgDf0Db0hd6A8yaKftyej/wrl2w/M2pklPLiyH6M/dSRjvfYCx7
	5bSe5pmvenWP26V3eyxEUeAxEYEaaf6FYEHAudlKZoVq+P1fJD0k+xosoORGMo5CabYR6vX
X-Google-Smtp-Source: AGHT+IHxSTuvbOlEGWKttE1ufcA2mbxzxo6NwytiDcCpwZMc+0qHix3dkVLMpE2GWm8kmuobvYXz4Q==
X-Received: by 2002:a05:600c:2947:b0:435:9ed3:5688 with SMTP id 5b1f17b1804b1-4359ed35896mr25672705e9.18.1733847303280;
        Tue, 10 Dec 2024 08:15:03 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:75bb:8102:943a:2eb2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f30bceadsm102383045e9.41.2024.12.10.08.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 08:15:02 -0800 (PST)
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
Subject: [PATCH net-next v2 5/7] netlink: specs: support nested structs in genetlink legacy
Date: Tue, 10 Dec 2024 16:14:46 +0000
Message-ID: <20241210161448.76799-6-donald.hunter@gmail.com>
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

Nested structs are already supported in netlink-raw. Add the same
capability to the genetlink legacy schema.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
Acked-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/genetlink-legacy.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index 16380e12cabe..7520f63ec3d2 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -151,6 +151,9 @@ properties:
                   the right formatting mechanism when displaying values of this
                   type.
                 enum: [ hex, mac, fddi, ipv4, ipv6, uuid ]
+              struct:
+                description: Name of the nested struct type.
+                type: string
         # End genetlink-legacy
 
   attribute-sets:
-- 
2.47.1


