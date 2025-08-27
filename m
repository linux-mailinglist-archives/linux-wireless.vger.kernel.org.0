Return-Path: <linux-wireless+bounces-26665-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 008B2B37651
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 02:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4C055E5475
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 00:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7922F1E832A;
	Wed, 27 Aug 2025 00:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6tl88tU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CB31D7E42;
	Wed, 27 Aug 2025 00:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756256225; cv=none; b=P5mUCYCOfz+Q3YhWQFQCknqABPAAik3ogCqWgwdiLNNIa2Xzsu91nYBSVJiQaOwGEIPkH0JiWe2mhRNHAnvC0otfACyg1FNjMuoBt1hBNMCMbPKzH0S8o2CxLwOKETGqeVA70vEcDFNY5TfDVjb7EDljxWSy2XGF+qcQdSyuLxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756256225; c=relaxed/simple;
	bh=fUbTTbgDKo3K1yqi2GG9Mxx9Vh9yM7A/cXQIM9BKCzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YUYxK/giaoZbAxkgePSHSJVIDyV0QtEMRR1oBRP3QCsD7a/l6uQdzOprDApY8wss6bLM1NHJydG43KgfJLRFRpQpzEoJeCZ8OnDNJv9WndA6us5KU9JPwif3Gjy5zEBgyRuJISI04XAAanULF++ca5DAgNU/fZimvN4bs/PrVck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6tl88tU; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76e2e88c6a6so5560575b3a.1;
        Tue, 26 Aug 2025 17:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756256223; x=1756861023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CdakSql3qU5efOEl9+kZloTxQ/ZWsyJO1tVUdW1CxEk=;
        b=e6tl88tUWAfJDyFEjdYma9w8HXaWwc2VF7jvDJFPL/Lb9SXctQKO8DqVWM715YEdap
         j3MLMKjZESoPexfUDwYltXWgyWBS72xuzQk2pSgFOujMJrewyuvpjvcJoi10KeYUYgLn
         X3jbJf+BcQJi/sYXuq5GS+yvH4ROZf/rbGC53y8iy0eRnB/lVc0JhOudNB0jDKs5AcuO
         ga8txc1n9IIDJALNmoYVY2gTND0RGkZf/jeDWswxPur//bidVzutPl9hXzLErqU049Xq
         bBEt9tixSWN/ch0GDvpfc8LZlFbtyhUiVLZFoQOI9f9ANGokddpYg+4rqEIwq22k3nkm
         xK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756256223; x=1756861023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CdakSql3qU5efOEl9+kZloTxQ/ZWsyJO1tVUdW1CxEk=;
        b=aWiDFIoKos9XGYa7u3c27AWXMaKQdp9GKuJVXre/JBdseABqXvmgP27tJ1E7CJ+Rwe
         c6UARW6rGyRui88xNwPSN+GgfPw8h2SMEk2x96gJiALn44NHMqyBWGb1w7NEaUReXqLv
         bRpl1nuKdksWuteBgzu76lcuuJ2lSgmgofp2flFq+OzZyX4wQvxAyr7bXJBUcnobKqJB
         lyxkkYRy5yZx1aMfBj5L91I3xl2Gojq9QvbQRs5nju/CAY12y0proHP6TPjhEu3xMOd/
         MGK7WzGnY4KjfG05d8jz8R/MHBu+typSFYje7FY9MLhYgonNhR43e46vu/05v3aQTuhu
         h49Q==
X-Forwarded-Encrypted: i=1; AJvYcCVPJCUZV5xEe4R0vlrNMve4LcZA5tjAl/6XapNqRQhdc5Ad2oHoelwC7190e4x8c6RXGCkFzTR1wNQHwm+G@vger.kernel.org, AJvYcCVkuc6JFfJ+2ZtSO/Pt9NdAezwmrprkUszIHgDxKIZsFPGv3SxaVtitneAqvFzkL+LsFuJWLOiBEQd+@vger.kernel.org, AJvYcCWJaebs9pOFeKY9NC3HwHp2DryfXC19/fvWYMMMSmb7//VxvPSKdIakorbGL/PHPAEz0+8O569FvKev7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHmQeOjmqNebQEX2mv8o/4syRMKcwsxt5EEjupjQYiHXMoyjaC
	fGALCKIBgQotBN+dybND/6SeVSvX/DZDNi6jGXOHUV/gG+H5kfBkkiHGN63Sew==
X-Gm-Gg: ASbGncv6SmVnKmj9kW8RQPa4rLmhD7Q/9z2tfAGEmGvOnsbtKvTh9gU3Vi50v5aaxWP
	bmhjuiEg1arX6D9Lf3kLGTlTMYVmVFeiYyvzYFxlw40cLYRpTwNgdXTNx0g/P+S0s2MRudaYB/O
	0+NQPXLaLiaDE1fCTliEEjdk93icDhnt+hJt681ER3L1Q7Umu32RkHrUxq8Tm6pvLujwz9FQsAO
	ruiVABKhv5+Ggqd+h/6N1dt4fvRs9flgsv+YfpeWHhqsl6HOC0+odSxPHkgj1N1C7mRbZ71pLPL
	VuHu2+gUTDvYtCupIOwTMCCpGXHOz+KdHL7DYc2A+UW16JnjwXWXx0qX6AN36FMf2KSNPQNa0JW
	AP+y4g/vmytFpNgsdoSZV4KrcCDKa/852v1qvk8QVpIyArLvaNvtOC2e+DUMz0zm37w==
X-Google-Smtp-Source: AGHT+IE9iRIApvQNMNdVNlNiGyduLYfGXxEyCxaVyvRJmZ86g/aEAUJYInpRx0pmTsYLL7pmvxTPEA==
X-Received: by 2002:a05:6a00:1149:b0:76b:f6ef:9729 with SMTP id d2e1a72fcca58-7702fc1c608mr21796038b3a.21.1756256222867;
        Tue, 26 Aug 2025 17:57:02 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:acc7::1f6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77057368ca0sm8382515b3a.58.2025.08.26.17.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 17:57:02 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	linux-mips@vger.kernel.org (open list:MIPS)
Subject: [PATCHv4 1/3] dt-bindings: net: wireless: ath9k: add led bindings
Date: Tue, 26 Aug 2025 17:56:56 -0700
Message-ID: <20250827005658.3464-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250827005658.3464-1-rosenp@gmail.com>
References: <20250827005658.3464-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ath9k driver has various pin GPIO numbers for different chipsets
which are not always correct for every device.

Add bindings to specify the correct number and if it should be
active-high.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 .../bindings/net/wireless/qca,ath9k.yaml        | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
index d16ca8e0a25d..9318024831ad 100644
--- a/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
@@ -50,6 +50,19 @@ properties:
 
   ieee80211-freq-limit: true
 
+  led:
+    type: object
+    $ref: /schemas/leds/common.yaml#
+    additionalProperties: false
+    properties:
+      reg:
+        maxItems: 1
+
+      led-active-high:
+        description:
+          LED is enabled without ground signal.
+        type: boolean
+
   qca,no-eeprom:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
@@ -102,5 +115,9 @@ examples:
         compatible = "qca,ar9130-wifi";
         reg = <0x180c0000 0x230000>;
         interrupts = <2>;
+        led {
+          reg = <0>;
+          led-active-high;
+        };
       };
     };
-- 
2.50.1


