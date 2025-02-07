Return-Path: <linux-wireless+bounces-18623-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D73EA2C256
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 13:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF1F216ADCF
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 12:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFB51EDA33;
	Fri,  7 Feb 2025 12:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6fwobfO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD2E1E5B97;
	Fri,  7 Feb 2025 12:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738930527; cv=none; b=AtWjsr0awf6pohL+M7UwsM8+Fje3O5lv+4LnNH0hSLdywQh+zR3XaScWN3IVI1IQRChIgNnlyYBdnf8QIFTAM5wGqaRRVHlbug2Lk3O9mF8HabpY5aq5OqQMoS6oPVs40NJSHVDIumVoQ8HbuV6hHN4F2ZrbCIx+4gaDD3norW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738930527; c=relaxed/simple;
	bh=2jUrTZQQF/dY1/oZi8TPJgdOAi32V8LU2q9+yZHMlR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sq3eSR1sI3rR8idmBowDGNNiTNNU5N9nqsyn5dzKv+DREUGENE4M26AYhzXT0fp0MDrS1I0VC5ijU+iYSpNVa2mazERuA+uSFFh+E5QRIS0yVcpehwWvvsrhNfoOQnmu5NZKAaV9G7ooP0ubVPH/86QjdUCxOFXSdwDU8XF63nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6fwobfO; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-436202dd7f6so21887625e9.0;
        Fri, 07 Feb 2025 04:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738930523; x=1739535323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KsXxvXTWQvNiyd1ztqhpSPJmVs+xSGLNWTfPDCxQEr4=;
        b=P6fwobfORxDlRaMnz115UFyK2ug4aZQucDAZxTOu6JUaUx5AEut1+ZLGS03kBVqUzE
         bIZRtBiiYyCNYIFG+oXufu/wrr4scZioKpuGKxNKl0z2LBhAb2pvIS/a0Oyz5Mh42yel
         SCfjOKnGU2mQXHXqSRDiURLCg8XFC13HlB9Rk3+cxSVGyV7Gy1QWbWxPfCkU2LSyH/eO
         HyXN4kGfEQP1JxoyAg/C2zbPQ6jv1bRttQdRZJ7aD0JFNG/6zREWsLyz3+dAXMio+qNa
         KO1d5vGmItW2kt3Pu3Gs6sZE16d70ylsOhk8ETZvrBRyXnuucbcX+iHW/JFdCb/c4pNw
         Neug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738930523; x=1739535323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KsXxvXTWQvNiyd1ztqhpSPJmVs+xSGLNWTfPDCxQEr4=;
        b=m5EL28a4RRfzHChW0fu8Ht5XhNSAOx5TYTNhipsHoN+yrb+djwRUIwIimK200WjZhG
         y3RHleuh7wdzbUiYS3rXK4ho8JnXT0lIgnxPxGLUeYO4HG4lamBNxYYqkQXCQngT+JXa
         mK1zAYxNORRL7R9z+c1SRHAqVY+nsXTd+IQzmYUc3oR7pLHpdWQjFF3NuyNKFaa/21GI
         y515We1ld6GtTSI2MtWP4sDUSYlgnCAllMuxbp84dcjd63Jh4NvXyW9nnfir4+meesT+
         Cr8jPccvXVw+GLhQEaD2yacr3+b4yUNug+ovXKBDq7wNsgiOwd17tg/zBKFKyfhbLS+2
         ADIw==
X-Forwarded-Encrypted: i=1; AJvYcCXYOLneP7n+XIcD9RAhEzCPBgO6wwx2MTmNDPVRm5Ozy1QVr9YzVKKkLcNLkgJ4Luv06bV1VLcYwih2LCm7pg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxybJfoCVNy4ds6U1hEmMyWu70prqRsISxbiVAgs5XNZ6dWWFqt
	ME9a1ZelSLvQn60arEoNS6XssGx2ktFUxN3Dg6fgcw+CZyctR/dNTgOMYQ==
X-Gm-Gg: ASbGncszq8gy0yS9YgSi6ygF7HebABAjHxVG+DCbtjYBMEVoAx0Ru3AKQ9R3fk+96t1
	VKJB3WWDBcw3abY262hg0RBdxDB2eiaDBNxgKnxLV4wJmLuJYKiUlqAS1mLZTS5uDqCtTE9XkhJ
	uqSzb8eolzAymt6O0cUGgHxWXOEdkcWzwXXODbn0IYUbU3CyWcm1g24N0dIFkXRhaR2ZhqZY+/m
	KoBHYTfjcadP7+PxatiLsbh3kzoyS6ZHqxpwN3YwPLJJ3S81RLn3/qZiPKdTaaHybQ8A5NSGEND
	1yfxgHzF3OVkBw1Lj8Itdm1HkD3qSQs+mg==
X-Google-Smtp-Source: AGHT+IG6mculr8rc+Lfz50mpKc4EjL+JIZ+I1v7VJoHWHLSd+hWY8C08km8WfNSrTSno3lDc0FC1mw==
X-Received: by 2002:a05:600c:4f82:b0:434:f9e1:5cf8 with SMTP id 5b1f17b1804b1-439249d1962mr26582325e9.31.1738930523299;
        Fri, 07 Feb 2025 04:15:23 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:ac43:c7d9:c802:8ec3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391dfc87d2sm51555035e9.26.2025.02.07.04.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 04:15:22 -0800 (PST)
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
Subject: [PATCH net-next v4 04/10] tools/net/ynl: accept IP string inputs
Date: Fri,  7 Feb 2025 12:15:01 +0000
Message-ID: <20250207121507.94221-5-donald.hunter@gmail.com>
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


