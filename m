Return-Path: <linux-wireless+bounces-15855-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D792C9E1D11
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 14:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 017001645E3
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 13:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E481F1303;
	Tue,  3 Dec 2024 13:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KiFKfopM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3D71EF0A6;
	Tue,  3 Dec 2024 13:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733231230; cv=none; b=Fea18d8FJGoM5o1jl/uOMybQJnz/uVF8IP1sHZyuPexvnaOr6l/LjkYdVaQvwXmuqk+4rHwjP2FkexXjOOInbYjA28B26nhdgZjS2nU0uObtJ5E2am0FqpSG8f/t2Rs/9LToV1gfYvTKidAdWV+hUSqsp8+UUarMPrawGdp61Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733231230; c=relaxed/simple;
	bh=/th2kGAZt5cmo5dEZAACW8w5HCDVZo5w3KMydreyFps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ipiarlAbrsYuw7Mlc/YP89WlZkdELXXl0mysbk4fzJJR0Lpkot4FleI2fYE6LUy6uw2yhxg+5E/ck2v5B/VwKN8peSI5Trfof+BXHOsyPPs9YkBVx6qFOfr8HYkyMyYHNkYTiadF+0VrgCadWSNCPeZ147gQ0obfHNpHUt8XYts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KiFKfopM; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-434ab114753so46350275e9.0;
        Tue, 03 Dec 2024 05:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733231227; x=1733836027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hL/lnk713PNE2uSEhyWxLL0gcbzFSyduE70wmvc/Bc4=;
        b=KiFKfopMq0joGx9cqrUR4IU6TosuK6KOPsNbDUfitx74KxXS4eFgsTOfArQTtUSZB4
         WDLqD3CD08VkNS5uUd2wZXN//fnGDyD3XrxMHB5qc96ckloLcItZVd8DnX0KhQM/3iZ+
         RQ5M06+lWt92DCzVszCYtPwgf+v7mrNq5mBz2NdzCd/O5Wcwj+iVeHK9xUerE/9osqwa
         uUcm3Lat3GezZBPhwAeyPL/zcMOQHW+b0BFLIegva6kq2UDt0BWn5cHLomx6tDpVyap5
         kZyOrHQGv3rq4yCglx05erljoS0xPONXqzO584UYCOb6EVfbZ5EO7gxRojXy44rZhOJ8
         GQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733231227; x=1733836027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hL/lnk713PNE2uSEhyWxLL0gcbzFSyduE70wmvc/Bc4=;
        b=gTcm2I09BjexJQNY8kr2HyBqln6lghTe3sddMmnJsEYt6zNO92GXrZ0beSaa99zRqz
         Hwy6lL+5VBnte5t8G+B55IkfZbMOgxu7vJtHey9uhadA/k/SrVK/m37vFRcieUhwEKiB
         jpiu3wHmt2oU8qAUTOW21S/RU7u8UzZVVtIU1vYgInU5K721JNGRMYkuCw74Iz8BAHY/
         bqaWzwTLcHamnbNRLjrkMw74jjTD0rcV0BY+FvdrOmgrYtILxS172UMNca1Ddk35oXDX
         tQA98paiMxZZVR98SVcWVlD5IRBLTTxfrRVzpplOa4xNYxutECQRONHpc9O1tY4hEEuD
         X4Ww==
X-Forwarded-Encrypted: i=1; AJvYcCVVcCCOVMAlI/AQmlrWRWhB9u7/czgIZVqbODK/akaPuoSTvPsBlmuvgObaSSlw5UggjxvLMyQVoT/4SF3jUw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjOMs7JAcYUtHKn6hHR+fvCNRuGBELW6JpWEjTQZ0Blq6/+6tp
	+4RUKTT/bVHZbDHgTAu5ayITo84jE+flOzJ7ZehjaiT7CcW1IKxiRPqfHw==
X-Gm-Gg: ASbGncvIItBpafO2mn1h7jc2fXDEG5OX0hf6yp+pQAXnDDwIPRTbK+FqNWEOLkvtP+D
	fNHBYbwrqkNP+ae/Wk0KeePxQTRkPaCGds1Gii1alKS09hk2258gqSr21AcTOBcCQXyOGGfjthU
	t9MuNBzRVW75y9f4NO/d6WuGq7wdfEGtZiYS6mS3X+Euq07v136jcuWg6q3zYsKLAZufF85H2j9
	IkdRvchneJ/PrnyMVsOMAKc/nqwBCeb3fW5yJNHLX7UxI0u4RIkFbztFXmdh8NCdmM=
X-Google-Smtp-Source: AGHT+IHSV2OrTQH4kHHU3TFmmXH+WxpM/zxQRNKGfEXwvciRric06KDfd1lbJc2ZKaprl1yletyCag==
X-Received: by 2002:a05:600c:4e8a:b0:426:616e:db8d with SMTP id 5b1f17b1804b1-434d09c8d82mr21859375e9.15.1733231226705;
        Tue, 03 Dec 2024 05:07:06 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:6140:2ef3:aaa:55ca])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7e4d42sm219142365e9.37.2024.12.03.05.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 05:07:06 -0800 (PST)
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
Subject: [PATCH net-next v1 4/7] tools/net/ynl: accept IP string inputs
Date: Tue,  3 Dec 2024 13:06:52 +0000
Message-ID: <20241203130655.45293-5-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241203130655.45293-1-donald.hunter@gmail.com>
References: <20241203130655.45293-1-donald.hunter@gmail.com>
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
 tools/net/ynl/lib/ynl.py | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index f07a8404f71a..c861c1a7d933 100644
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
+                return self._from_string(value, attr_spec.display_hint, attr_spec['type'])
+            raise e
 
     def _add_attr(self, space, name, value, search_attrs):
         try:
@@ -571,7 +573,10 @@ class YnlFamily(SpecFamily):
             if isinstance(value, bytes):
                 attr_payload = value
             elif isinstance(value, str):
-                attr_payload = bytes.fromhex(value)
+                if attr.display_hint:
+                    attr_payload = self._from_string(value, attr.display_hint, attr['type'])
+                else:
+                    attr_payload = bytes.fromhex(value)
             elif isinstance(value, dict) and attr.struct_name:
                 attr_payload = self._encode_struct(attr.struct_name, value)
             else:
@@ -899,6 +904,17 @@ class YnlFamily(SpecFamily):
             formatted = raw
         return formatted
 
+    def _from_string(self, string, display_hint, type):
+        if display_hint in ['ipv4', 'ipv6']:
+            ip = ipaddress.ip_address(string)
+            if type == 'binary':
+                raw = ip.packed
+            else:
+                raw = int(ip)
+        else:
+            raw = string
+        return raw
+
     def handle_ntf(self, decoded):
         msg = dict()
         if self.include_raw:
-- 
2.47.1


