Return-Path: <linux-wireless+bounces-18762-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F242A30B03
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 13:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4F70165B74
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 12:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D63204873;
	Tue, 11 Feb 2025 12:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1kcC7oz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BEF1FC7F5;
	Tue, 11 Feb 2025 12:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739275308; cv=none; b=FaQUGQfhffU4OFaNCTO4IKOxb/I/37UafS2R8MkiuqAfWkB5tlINANp/JRmn0mPCn3x55lwLjCUbxWh1c2zXDfd9bQcsZb72Gks+N3sDAaqfBa8VT32OwOquhXHhUmwwDNgIPrJ5KZdumts8Gedhjx0rJKJJyeHRHmaUs20PLYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739275308; c=relaxed/simple;
	bh=2jUrTZQQF/dY1/oZi8TPJgdOAi32V8LU2q9+yZHMlR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n5FlpElOmYyPfgQimJ+JdU8n+zxifjX55fQ4P83FemMq8XwB5FrE0zRWf0wJZ0YHfsOy2F7HBzhwUMGrX4lmqcpQilYAoqucebDytuj1aLzgWgMFnzRbM9dwzWrdwnxBC8kxjoMZzi4lsoCX6HWmzcHBDkewkr8MRfAi6luN34Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1kcC7oz; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43946b5920cso12637105e9.1;
        Tue, 11 Feb 2025 04:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739275304; x=1739880104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KsXxvXTWQvNiyd1ztqhpSPJmVs+xSGLNWTfPDCxQEr4=;
        b=k1kcC7ozXiBI1m7YBgLAv1yPB94pCwNnlq8WLz+rALN+5K0OZipEgAeelz6L33TEth
         +xF5uoKTjInEGYXBbtHvt5PNvLEhusGvBVzK/efEQQvt4w0kaI0OgpXdwmqVOiiESGKx
         2//4oZSvgDnAlpOab+KU02TwdrsJN8njcuiezuKeUYy+KHKI+/H4i3711jlvq4V0KVAy
         KvItCgQpk/83CguvcvV3rczp7J7cC+zJj36LpL2T2cEs6wqV4khyMIrt8rV3Rbl3X8o3
         tByjRzkd8owqPSPvQx6fOCdDjIowm6U+ImearHhsw+iTqeh0Xdze90HnDRM+fFwlm2iG
         ygNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739275304; x=1739880104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KsXxvXTWQvNiyd1ztqhpSPJmVs+xSGLNWTfPDCxQEr4=;
        b=o7LoloJ7S6Cl++hu0dlGvRSrfTVQc//6mNScakOKWHeP2VjampwUJnx/Kyq0OjLZSA
         dJnP3625cWuGF5basGfrtxv1W/u2EXhRC/n4Q/14Ncyhi+dxzIOvhX6dP/kTMT4SiZPZ
         yqm/D7VP1RvgGGofqtNuhaOmBGzLPho5s7htF4S1pMZLMATJFJaPyfhnPsd+iKVLScrf
         mYrraORq/QiOOuQI0+za2cSq5fpWCctMm+KmBPbwqZX480UbaXbwdPTp7TeXwPFayfYz
         spslI+P6FwKd3SyKD1+VS7a22JsrJUgNWUB1gyeg01xE3qnnBXJ2zt73wWD/z9i+UEt2
         CzmA==
X-Forwarded-Encrypted: i=1; AJvYcCXK897q8wd3LbHLFGJW4fwRle1lYPWf6xs2k//kK0AQNEEECcwdbLrzl9SoMtv7PCCIRq19Kab7eAxfMc6HRg==@vger.kernel.org
X-Gm-Message-State: AOJu0YznMpHMq8seoPbSkMuWCo+tPuMdlZuhsDH5Qmmm15i2ohWsu+6O
	flcT3pCoN0mVwn0K/IURjj/wtsLDRFYUAKvFqFlpkYLP8wIQSthh8WwgTg==
X-Gm-Gg: ASbGncvRMSShOoFpSFiEHlarz2J2xlmA3JcgFWP5OV/kQFUO3cH+OhzqEBnX+1pczdu
	fR49qQxMbDfktBjY1WHfYHl3nue6a3qfHgsfPjaYybXnZpbUTVMcNFCuif43IRnuLgD7HhohQU+
	eSrVECG7/qNgChRTZW3Pc+nu44hkAfGnU62mfJXccOvwrFJIQAf8LHitLRb6ax6I0gFQOgubL08
	i1Vng7wsHG8QTzXfG9Q636UsgqVNWEy0Ogrp7Ut4i1vHrCsbhs56cyR7FuQF4YC5WFjxokKzti+
	dVq0CPdbAeCSTWemIkHhN7W3paNkwv6duQ==
X-Google-Smtp-Source: AGHT+IFAVvqmkoySfCHtxyiM9FO/O/CnlCZxtZp8+dic/TRxQf0xsFe9RzZg1RxJFXpNO6c0Wke7dA==
X-Received: by 2002:a05:600c:3593:b0:439:54f2:70c4 with SMTP id 5b1f17b1804b1-43954f27235mr15647845e9.9.1739275304285;
        Tue, 11 Feb 2025 04:01:44 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:ac07:4372:f96c:546e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dc933ff9fsm12466658f8f.96.2025.02.11.04.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 04:01:43 -0800 (PST)
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
Subject: [PATCH net-next v5 04/10] tools/net/ynl: accept IP string inputs
Date: Tue, 11 Feb 2025 12:01:21 +0000
Message-ID: <20250211120127.84858-5-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250211120127.84858-1-donald.hunter@gmail.com>
References: <20250211120127.84858-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ynl tool uses display-hint to know when to format IP addresses in
printed output, but not to parse IP addresses from --json input. Add
support for parsing ipv4 and ipv6 strings.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
Acked-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/lib/ynl.py | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index 62ce3340796f..dcc2c6b298d6 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -536,9 +536,11 @@ class YnlFamily(SpecFamily):
         try:
             return int(value)
         except (ValueError, TypeError) as e:
-            if 'enum' not in attr_spec:
-                raise e
-        return self._encode_enum(attr_spec, value)
+            if 'enum' in attr_spec:
+                return self._encode_enum(attr_spec, value)
+            if attr_spec.display_hint:
+                return self._from_string(value, attr_spec)
+            raise e
 
     def _add_attr(self, space, name, value, search_attrs):
         try:
@@ -571,7 +573,10 @@ class YnlFamily(SpecFamily):
             if isinstance(value, bytes):
                 attr_payload = value
             elif isinstance(value, str):
-                attr_payload = bytes.fromhex(value)
+                if attr.display_hint:
+                    attr_payload = self._from_string(value, attr)
+                else:
+                    attr_payload = bytes.fromhex(value)
             elif isinstance(value, dict) and attr.struct_name:
                 attr_payload = self._encode_struct(attr.struct_name, value)
             else:
@@ -906,6 +911,18 @@ class YnlFamily(SpecFamily):
             formatted = raw
         return formatted
 
+    def _from_string(self, string, attr_spec):
+        if attr_spec.display_hint in ['ipv4', 'ipv6']:
+            ip = ipaddress.ip_address(string)
+            if attr_spec['type'] == 'binary':
+                raw = ip.packed
+            else:
+                raw = int(ip)
+        else:
+            raise Exception(f"Display hint '{attr_spec.display_hint}' not implemented"
+                            f" when parsing '{attr_spec['name']}'")
+        return raw
+
     def handle_ntf(self, decoded):
         msg = dict()
         if self.include_raw:
-- 
2.48.1


