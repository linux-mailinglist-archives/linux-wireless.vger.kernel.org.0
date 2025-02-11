Return-Path: <linux-wireless+bounces-18765-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F48EA30B0F
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 13:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D25D43A3773
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 12:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D322F21D00B;
	Tue, 11 Feb 2025 12:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDJr9eAx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFD31FA14B;
	Tue, 11 Feb 2025 12:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739275311; cv=none; b=hKANBTpGevZf0QwmvCsZJLw6DrarvQy/xlmvTdBERdTex9hWzPAV/r9QaKZpiSL/2Yhl0Zi8v9jTRdmDuRWWxG/Lsbhsh3196vbmZ2f8MdQit483N+oo5GaKGGn4aMKq7i+8bGIduIgWV4i8JipfqFPG2VCK2Ea5Mq/E9BsuwNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739275311; c=relaxed/simple;
	bh=LQz/+A9c7Ho+lyWQrdtZ+ix0f8k72Xj8v4u62NQ7h/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c7ukE97uykRCJSyxknYy/6PgkjOAdRye5tWegGXnosAFmkrakSjPIumK5uCLqtvDTJstoUniPu5QFYpgPDWq5OS18AWPGArrHYRAdqsnP8d6ngU/fKLaMqpQpONJ4rt7n0Ke8Py5PAOVzh15vYGLokZ7YLnYkVepgpKK+wxGiow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDJr9eAx; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38dcae0d6dcso2346047f8f.1;
        Tue, 11 Feb 2025 04:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739275308; x=1739880108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzpEi1hqY/grqIzyl8Qp9PHG4iGXdiSToBF1VycVE9Q=;
        b=IDJr9eAxlMo+HcSifUGM3IDmSemLkJ93jpCmVzlKbwO1YCywegR47hzKL4YLmZ+H04
         vNJyWEAva7N6ZgZcNkPih7zCWuqnuOtD1xCB2LNb8O5lPeXfuCDf9uj+nn9cXxupCKfZ
         qXn5ZkvdzQJXW91iP3j9jvv+JsirEmp0jtZyrdrr5oGITq28YDmv8a7SQimr+44p+3Ij
         /vkmk9FivWcRlrBBJB1c8daNL9S9vgGwpTTNY21BcVF7nR9MWiWfG1bgNSeTUm1Tmo+O
         3gDak/svwwWiqXRMeBaNVYS9S5IuhPQ9ZjTmxyry4DRfWhNk56J6MKejTLbbh8zUUYhN
         OfUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739275308; x=1739880108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tzpEi1hqY/grqIzyl8Qp9PHG4iGXdiSToBF1VycVE9Q=;
        b=DCa0ZlbwmEhHPtlHx1bwTq5y003xy46OXX3dCZ4I5TvTMTfpdDpp47+kf2hWN58D8Z
         6KqgmFZBR5tQW/p3NhWRt2P44ivrE2F3847G1XKioMjbNjrjhjj8Fhj6xanUve7MC79I
         l0zeZG1O+XZaISxhbIbQf1dD7Qx0T3e9qczbIyW+0Vtn15Z6vRNPC+b1bMNWoNnah1t9
         8i2QmM8MYX41I3EDDkWDzmjHlt0WJFikaoMR0JcR1MFKJSOdhLaBamsTA/7CNPz4Gv4L
         OoRASb89MLwtdrSqclbZg22FdYPhrWmx09gc8coK1HNXISA4l7exePPMssrLyJthv5GN
         WJMA==
X-Forwarded-Encrypted: i=1; AJvYcCVdU3CNWIHw5ydirB3PmXN9uRl7ai6UsxobDSD4rg5V/LKy/j2TexT+1NE34QMw3FuLGQWBohaOruqnLQK3UQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZlbX1e45TIjuRJU2TFm8ifiiZxKZjSOdXyY0oxdsTknencRU6
	2/BCTD+sxuHS3y5NMn3aXmY0cxWYrFHcO7nm6utO4mzO3B7PiqTbCFn0VQ==
X-Gm-Gg: ASbGncv2KOABCtjHqOYZHNUWuMRoIW399pYbvbXSS1ZkVVU0V4BUZFJBWgtJr0dtolY
	EXRnTmheLbFoypiW0/Ikth+LUCWLMJYGpe3mN4hVosZ1aBz1RT9D7fDJ9Kwzb9Y1caFSsd4X2O1
	erq69v/Ve8Rh/6ia3JIousffgHYIQUQufrWjrhBdx9SJC615ZiKS6uw2yf2aMzoXInBNOg/6pQ+
	Ovi4yGxBgpSiZPn6Tb9QkRQrc4Nyxvt7tNfCuvcVsbFvBjGPRjC3OwPeqyKhsO/TMGyS2O3ouL0
	X2FUlbq5HqVF4mOPi5YhZhafN0EwglrbEA==
X-Google-Smtp-Source: AGHT+IFdbe/RWCZlGMsp83KMtKL6ldVm3MVZKs8DhYoQ6yB5uerkkz5DqDykDYCZSpmY+dbsiJYJnQ==
X-Received: by 2002:a05:6000:1865:b0:38d:bf57:f371 with SMTP id ffacd0b85a97d-38dc9373270mr15098116f8f.48.1739275307683;
        Tue, 11 Feb 2025 04:01:47 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:ac07:4372:f96c:546e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dc933ff9fsm12466658f8f.96.2025.02.11.04.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 04:01:47 -0800 (PST)
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
Subject: [PATCH net-next v5 07/10] tools/net/ynl: add indexed-array scalar support to ynl-gen-c
Date: Tue, 11 Feb 2025 12:01:24 +0000
Message-ID: <20250211120127.84858-8-donald.hunter@gmail.com>
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


