Return-Path: <linux-wireless+bounces-18581-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1F5A2A444
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 10:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4081E1889005
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 09:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6014E226863;
	Thu,  6 Feb 2025 09:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bns3L9ih"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0A6226532;
	Thu,  6 Feb 2025 09:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738834041; cv=none; b=itTztw5ary+uLk48s7O4Bake5+Dh4OJI4yiCzO12XdrzTmAT9PCGQm2n3KYDf647mEZirMrWbN6+4R1pOCg2/GNwpzdPbxvYY+lVM/Y1rcix7ixeOQ0fQZhZzTivYv1vZL0gWSbbjsCDz0oWrLxBgNejsy/ONL/8ni9cWlUp3yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738834041; c=relaxed/simple;
	bh=lsdo6dOMRiEzgGmbLZEhh4vqI+MpuW1eJhzBvUC2vqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZBD5jE/TwtCP7+YoPcaQx/Y76guJ4RpGbKNkGciypEVdlap7sMErRDxkJ1RmCdPk969b5zbmzyYjVMDFYmS4G9wt83Fuhk/1Wp4euAzHA3gXzWejPy3WMFMgjDIlfq7s+iYzWWJzyd6UAjBoDYFKpas01dwSczT6qxgNe4Lwkhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bns3L9ih; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38db34a5c5fso275974f8f.2;
        Thu, 06 Feb 2025 01:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738834037; x=1739438837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jO41Ytx+7wXajgxryk6h+JVDmtp85gTH1SGrqcLWqHE=;
        b=Bns3L9ihj3JUcs5Nip9F8iGKpcJGGU4LvcASRkq87iDrz+GKwZIhMlab8x5JO064dR
         1CyCuCtEZ7KQIM/96Ef6XaEREHOePDKd1BfNG2cU16xjnoNYtjaWIy1Z05t9PkTED8xK
         OvJ/gA6F9UTKsUN9iT2aIUt3RcEtmb02NJRh3b8RPkhVI3B+WFQg6fZsDR/EHHeuxKra
         iOM7DpqX+VuKBPUC48YheoQjRaezOExTD2Cij8Dng4yv8nLzIoauzgySnaHnY5DLal4u
         fQlfmhU5xb/hwUXvYqVBdnmbw+PyzhajwaJLcRS23TbpHr+jonDJV7WxVZSzRBhUUl2Q
         rIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738834037; x=1739438837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jO41Ytx+7wXajgxryk6h+JVDmtp85gTH1SGrqcLWqHE=;
        b=c1YWvLGKgJaCSA4ArW3O5H3SxZIJdxeued8/qzIPN0Fb7kJMDtG5Gsk/KGnYAP5VRt
         62Ckjyd4fFt0exyMOJcbW3fphMWuFdfenyx1KyQLfsy/SNeOh5sP64379zqByJyXv3mX
         RB9RNMqt8jeDsCYHqkLM+gqg1CtxhvwpVRhBlOUC2VhMtrU96Kt1XCclj+hL6jGqRE8v
         xkE82tp7/YVYNmwQYwwO72ZvCc7bK/G8RY97HIAOOqtBd6hlO4yo0L895JvSNRyGDwk7
         O0ZEt06uNd9NoDQJYjgZDn/QpNhSOj/K9eIxHxh1QCr5twJnMPAPCs2hBkMXYxAHtRO2
         yAVA==
X-Forwarded-Encrypted: i=1; AJvYcCXr0vlrFJgevhbK9SQPXkuuCIKerm3STBPcJ5jWz+yLzS+WOiA4kBHWrjSp2essPOaxW1P8OW/D7uxvFUKMBA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwT7OwzkJS29U2Rce4TOCesTfUi+IAqLihmr6m/eWhEzggYQUfS
	jN8V5AMFIpxr3sFIJWRCqlhQeQjq7hsFvTS32Xibg/E5+HAoK+7RtZrXCg==
X-Gm-Gg: ASbGncu5ffazKznwOfMl4UYnFM1wNjml0oO+/KJUM7ukk7CdFbG583bcvvAG6B+J6uU
	WAttCJ4HsAOJO/FDRHDknVQadWpHqfkHbhUYOvwgtQ/HTc+sBz7MYxIaaXkqnHKT9l3HPAvXcq9
	lKlx8qJthpJYXCon1Mt7MF7LwdWqdk9Al+3IFna+pSUEMx4+7cGcJDpN7P5C95xzXsSXpPT20hE
	TMPfB1/yBFmvh0HbiLbQRZdBKei3+qnRj5T/Y2lk4YObaTtQKqp1uNY0MJTytr/+o1dKD5vkQYC
	OzOCfDDgxAU9wdhL6P4bUwt6B0hVq3hvHg==
X-Google-Smtp-Source: AGHT+IHydIJwt+sylTTqPETMqbxKYDc+dpukzF3o3fO3g4pWts87u/KXodwwYjFI2g2aZ5N7U5xcFg==
X-Received: by 2002:a5d:64e3:0:b0:38c:5d42:1516 with SMTP id ffacd0b85a97d-38db48cad35mr4640027f8f.34.1738834037310;
        Thu, 06 Feb 2025 01:27:17 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:c428:5404:970c:34c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391dca004esm12832585e9.13.2025.02.06.01.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 01:27:16 -0800 (PST)
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
Subject: [PATCH net-next v3 04/10] tools/net/ynl: accept IP string inputs
Date: Thu,  6 Feb 2025 09:26:52 +0000
Message-ID: <20250206092658.1383-5-donald.hunter@gmail.com>
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

The ynl tool uses display-hint to know when to format IP addresses in
printed output, but not to parse IP addresses from --json input. Add
support for parsing ipv4 and ipv6 strings.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
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


