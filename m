Return-Path: <linux-wireless+bounces-16172-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B19C79EB5D2
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 17:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69A9C281D55
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 16:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B462343DB;
	Tue, 10 Dec 2024 16:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J12+VUPT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B4F233D9C;
	Tue, 10 Dec 2024 16:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733847305; cv=none; b=H3Elg49WqOYKT/ZYbvbx7fgsS58sWs2zhomD1QUF2DLkpdWdl0HZ0hgqRt0Qt9B6nGFAIiODmU29IWQLBnbICJCuOf+bG3u37sNnzcORLeryOtGIfAau6GJFlfhGAgMfftx7Ury5ORCOhpJ5a72fdDe/ca1Nmo5RlGbBGVO8jcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733847305; c=relaxed/simple;
	bh=pPkDNIzYMqAPAZxjZ0L3vUGN0fX5rZxstXxWP0KZjr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tOoteooKWNKdp5OWAe7dRQDYFRnKaOk+sDj84g1G2wjrXWgNNL3SiKejjl3ot5be/r3bPJPoJFXvsfepsr1otSL4/uAie6yldSH3d6oBv5r6cOcSru22sB0Zk7RYKoOK0ii2dlqJSJwyIjZSbevI2sNdCHElB+bvdU9UaDOJM9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J12+VUPT; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-435005192d1so14064175e9.3;
        Tue, 10 Dec 2024 08:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733847302; x=1734452102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D7MEDGrn8ylg9WFEXDbicDG/hdkSOgHq3gb7E6Fqe/8=;
        b=J12+VUPT+/PWpflMBUr5p184u9rfAt/7u1f+2Y23wB/W09TBTi7RuUEMSEP0J4YHkl
         /9AGfa5EU5q+1eaMAFal0bKTiZzbRnmSzAHwL7R7+XLLkZU0ap5fXO1fElghSgJsphbg
         FbVxmjfolQDJ0bS7v1lGKxrig6HGgrfdPp17PE2J29JJ6EYeP8IQYRTc5DQNV869RBqN
         Fbamk+PAAUtsm2m5AXB9PxwB0BVRdfy+W97aXeJ0B4NrkVA8bpWuhuj2YJGCj0+pMKJc
         /FDKQk7LlOZxFgWRjMfzmCyj3FwM6lra4xhGlrzsONU33zMpKiJGcn2IPzDHHYAQorRI
         o0QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733847302; x=1734452102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D7MEDGrn8ylg9WFEXDbicDG/hdkSOgHq3gb7E6Fqe/8=;
        b=RM+pDrksumG7oKz0bC5ijkXgw1WNSu+3VOWG1oKKs/LwiTWWFjofIEJmeP+zTofYHJ
         Dw3dxj72xLg+NbnW04LIkf9MeAFIFNBaUMiVWPp0URdm2rJ0m0F5sLfivw5OZ2q5JqTv
         i8LdaV0Q/OfCgdNc3CZVjYuNH1xRHkvwoK3jnpLDajSShJ7FDQQxlJp59W3jfqyRRtAM
         IVZSuBPtNG3OYS1Y2GzwrpF0jzQzQ2V+HpPEQc/zCU13eo0+KNT3doZqLQFFIS33dSEf
         iJ8mu9+tM1maCnHR/dlfJQgDsjamkodtHgGPzFOv8GW4GSvlSbzbRA1r9epc7YxePrlj
         jIFA==
X-Forwarded-Encrypted: i=1; AJvYcCV/kpsBQxdnpWMQITpyHaX2CjsB6otUdWWyC9PVYLwa0XecdZnYnEXBvz9QgM3wNtUCuri0D6zcfPDP252F7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/y7A8ewW8a3GhuctH9jK+OJRdrwYamOyT8Eu8Hu5L592ia0DM
	NxhNnuz+mCC7Nu6kDDBOQvufrW69/1CwoNu7ZSK9J5ukp9cvWnV9xBHwVg==
X-Gm-Gg: ASbGncu5rKT2/b1+gKuRanf+kNit52q7IU5BAdNxnvniOJ/mqf1h+PYXO6r4wdRy8lH
	ZGZN9U0E5haoa9qycz10wtV7dhDRMb2yiOliV9McRo2A3qRoZkq2ksD2Sc6I97vGAuIUvwhRrYC
	XLRpHTsO4VeLTRrgzwldo7tfHncw7rNsJgax0pwwXaPTFqro6/oB0bhYU266j38SdkDvc1tGhai
	p5yPbHe/ATNgKyRWOXIiWF7yoPNL3B7qIe4uoodFosxRck9z8STJ9vVnNAMa0vEbLizSy5+
X-Google-Smtp-Source: AGHT+IGSRzL2HVe4MCRAeSRNWXAWzTLTtAo/iR/UUaY2zntKwm4zhxMnpV3OYWQzZvfmGnMNpx5whA==
X-Received: by 2002:a05:600c:4750:b0:435:192:63fb with SMTP id 5b1f17b1804b1-435019266f3mr43359805e9.3.1733847301962;
        Tue, 10 Dec 2024 08:15:01 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:75bb:8102:943a:2eb2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f30bceadsm102383045e9.41.2024.12.10.08.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 08:15:01 -0800 (PST)
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
Subject: [PATCH net-next v2 4/7] tools/net/ynl: accept IP string inputs
Date: Tue, 10 Dec 2024 16:14:45 +0000
Message-ID: <20241210161448.76799-5-donald.hunter@gmail.com>
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

The ynl tool uses display-hint to know when to format IP addresses in
printed output, but not to parse IP addresses from --json input. Add
support for parsing ipv4 and ipv6 strings.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/lib/ynl.py | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 08ad2d8a874e..c9ed356d7ed2 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
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
@@ -901,6 +906,18 @@ class YnlFamily(SpecFamily):
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
2.47.1


