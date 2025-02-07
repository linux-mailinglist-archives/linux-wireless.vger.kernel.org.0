Return-Path: <linux-wireless+bounces-18626-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A150FA2C25D
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 13:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85267188D05A
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 12:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206531F418E;
	Fri,  7 Feb 2025 12:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjnYD5xj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436F11F37D1;
	Fri,  7 Feb 2025 12:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738930532; cv=none; b=O1bh6FuBNPEkT9lOvWl/D4NDnTiEMVv0Kyg791nbhcEvkmdxwyrnaat2dXdqEXeeKPam8wAs6ib6R3G8aioz1OyMKYFTExsQ4Dqg6N3zBMqAtuowDfcTQVo9Lpejge6Cbv5+N3YOGgWnglYYZMmvhpPcuesOJERMnkKLRigigME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738930532; c=relaxed/simple;
	bh=LQz/+A9c7Ho+lyWQrdtZ+ix0f8k72Xj8v4u62NQ7h/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E1NRZfSRqjTqMwkEpnc8bEBePBCh8sOMRj8O9kD73qeIyVPX1DRRFYzJl9Soz2LkObK7qylKoZRYGofXzr8lOS6wd0Ih6neyx+kOkwKWhFCmbGwldVn/yGaV5KLsDNCmeM/ldF210LwdeDY9hKnPjL6ctxXOvBkXeSYKyyn/rOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LjnYD5xj; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-436202dd7f6so21888435e9.0;
        Fri, 07 Feb 2025 04:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738930528; x=1739535328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzpEi1hqY/grqIzyl8Qp9PHG4iGXdiSToBF1VycVE9Q=;
        b=LjnYD5xjJ6ZqgZpyLwq7d6VgewH0nvaiEEggElCfxT/TPI7lyJRMMeJ9EwWaQsA7Hx
         KaAjekKt5Xe0cKDKsRsLEzTTgIDnDEqY07Uk0pQ8X2s0W+t6vrQ7N1Oi3yu5HFVrA1nK
         sR/0BwnjCVV7ZMd9PhNDEPhNKOAe6OmhxYHf15S0hJBNnpYVY4+K5f4dF1NRsOHXbEik
         1f2qJbgKnPjdnXy/GEM+7R5Sy6uWDs0FYqCs7fHc3BzsFwYxDaG2B1LxVvnCsO8YXhlD
         fUg5E99m+GLIFXkEKFeRDy9PNJie14nr/PngLu9wN7oz4nXQv2bWv4NM4gfkRFUygNVD
         TaMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738930528; x=1739535328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tzpEi1hqY/grqIzyl8Qp9PHG4iGXdiSToBF1VycVE9Q=;
        b=ueIK2UghlQ3VW/nHKnOdrTiL2n7a7oGZ9gS/2Pk2OpPhat4HyzaWHX/VHopjKM5SG5
         Am7lnHUe3RVRz0G9zOegBNUkUxep6T/ZM/ePqgam4WVRfpL9Ojvypzi+rWvOuOQKRVcW
         lapkha/qgB5fHYCINLzwsAElzcPOsokuBwQt4FsDlPamXoOhNcNLAoLYCWwVuI5j9tvm
         htk/oKcroycrg4/uBP8NYJEpZLK/5tNlvxxE6XRxYMgH1frQh4NVQCaSXwp4tRf5RK63
         q8LIbpUzpXMeeisEyW3etqHSjsjXq/pwqz5rP/H4qvmQpmjMG3NdxDvPnJEjKsV1kKmr
         8wNg==
X-Forwarded-Encrypted: i=1; AJvYcCXD57EK7z+8ocYbpDboKRPjQr0nAg5SLGqxoYsysrnIRkpEOOU2Opdf+zfOZOIBj2xvL9fmVyBZgPXODRabRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YydSvKWaZVHRjDHp7N3FNDeUnbUX9k3UZg4SeHqamIETbRi77Ud
	/U8l2lIwDHO7TGdzwrnxYdozFxEzRFEKTcnLua/WEH0IDOWAM2pLupZPUw==
X-Gm-Gg: ASbGnctUQMXy3Qn9uxzuuE871k/9Sqerk6gW8G6mkEL3Br5XQ392Od/feBnK5hQdtUd
	1QUULsa91efWgNKhfPE15HYdlb7bF8/+sO/5yF+SM9OAXiO7y/TdLWB/AJV+3jPGoVuM0lv8wl+
	gIMMRGvD61fyh7Iv4HwsQKpmXOXht45pJFs2imodnF2t1CTePtfMhBpm3Yv0drO4ms96Zj2GTKk
	ovX8QBoZH1nWvW8PxUQXTvZzrJ2wcE4t1gJNLnwBkRELJbkaQGX2jXBOPTPtIWvaifeXDE37xDv
	FU5VCjYMY+ixs7cMylQVQuGKZtlXcS3jeA==
X-Google-Smtp-Source: AGHT+IFZZA2ZBkAxgmxF65fXvox/QXswvjjIr4+NMW7atso1RAmqpeYfLD74ONLj5PwVgqEuevzKYw==
X-Received: by 2002:a05:600c:4f47:b0:434:fff1:1ade with SMTP id 5b1f17b1804b1-43924991dfdmr26158585e9.13.1738930527710;
        Fri, 07 Feb 2025 04:15:27 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:ac43:c7d9:c802:8ec3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391dfc87d2sm51555035e9.26.2025.02.07.04.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 04:15:27 -0800 (PST)
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
Subject: [PATCH net-next v4 07/10] tools/net/ynl: add indexed-array scalar support to ynl-gen-c
Date: Fri,  7 Feb 2025 12:15:04 +0000
Message-ID: <20250207121507.94221-8-donald.hunter@gmail.com>
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

Extend ynl-gen-c.py with support for indexed-array that has a scalar
sub-type.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
Acked-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 62a6d8c93765..a1427c537030 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -688,7 +688,10 @@ class TypeArrayNest(Type):
             raise Exception(f"Sub-type {self.attr['sub-type']} not supported yet")
 
     def _attr_typol(self):
-        return f'.type = YNL_PT_NEST, .nest = &{self.nested_render_name}_nest, '
+        if self.attr['sub-type'] in scalars:
+            return f'.type = YNL_PT_U{c_upper(self.sub_type[1:])}, '
+        else:
+            return f'.type = YNL_PT_NEST, .nest = &{self.nested_render_name}_nest, '
 
     def _attr_get(self, ri, var):
         local_vars = ['const struct nlattr *attr2;']
@@ -890,7 +893,7 @@ class AttrSet(SpecAttrSet):
         elif elem['type'] == 'nest':
             t = TypeNest(self.family, self, elem, value)
         elif elem['type'] == 'indexed-array' and 'sub-type' in elem:
-            if elem["sub-type"] == 'nest':
+            if elem["sub-type"] in ['nest', 'u32']:
                 t = TypeArrayNest(self.family, self, elem, value)
             else:
                 raise Exception(f'new_attr: unsupported sub-type {elem["sub-type"]}')
@@ -1674,6 +1677,9 @@ def _multi_parse(ri, struct, init_lines, local_vars):
             if aspec["sub-type"] == 'nest':
                 local_vars.append(f'const struct nlattr *attr_{aspec.c_name};')
                 array_nests.add(arg)
+            elif aspec['sub-type'] in scalars:
+                local_vars.append(f'const struct nlattr *attr_{aspec.c_name};')
+                array_nests.add(arg)
             else:
                 raise Exception(f'Not supported sub-type {aspec["sub-type"]}')
         if 'multi-attr' in aspec:
@@ -1729,11 +1735,17 @@ def _multi_parse(ri, struct, init_lines, local_vars):
         ri.cw.p(f"dst->{aspec.c_name} = calloc(n_{aspec.c_name}, sizeof(*dst->{aspec.c_name}));")
         ri.cw.p(f"dst->n_{aspec.c_name} = n_{aspec.c_name};")
         ri.cw.p('i = 0;')
-        ri.cw.p(f"parg.rsp_policy = &{aspec.nested_render_name}_nest;")
+        if 'nested-attributes' in aspec:
+            ri.cw.p(f"parg.rsp_policy = &{aspec.nested_render_name}_nest;")
         ri.cw.block_start(line=f"ynl_attr_for_each_nested(attr, attr_{aspec.c_name})")
-        ri.cw.p(f"parg.data = &dst->{aspec.c_name}[i];")
-        ri.cw.p(f"if ({aspec.nested_render_name}_parse(&parg, attr, ynl_attr_type(attr)))")
-        ri.cw.p('return YNL_PARSE_CB_ERROR;')
+        if 'nested-attributes' in aspec:
+            ri.cw.p(f"parg.data = &dst->{aspec.c_name}[i];")
+            ri.cw.p(f"if ({aspec.nested_render_name}_parse(&parg, attr, ynl_attr_type(attr)))")
+            ri.cw.p('return YNL_PARSE_CB_ERROR;')
+        elif aspec.sub_type in scalars:
+            ri.cw.p(f"dst->{aspec.c_name}[i] = ynl_attr_get_{aspec.sub_type}(attr);")
+        else:
+            raise Exception(f"Nest parsing type not supported in {aspec['name']}")
         ri.cw.p('i++;')
         ri.cw.block_end()
         ri.cw.block_end()
-- 
2.48.1


