Return-Path: <linux-wireless+bounces-18584-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF4EA2A44B
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 10:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E1197A2F7B
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 09:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB36022757C;
	Thu,  6 Feb 2025 09:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfEqDSG/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54BF226532;
	Thu,  6 Feb 2025 09:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738834044; cv=none; b=bBItzI0Y+m+Os9I3sSoUUFckl3wya8/OpsLKevYNAkyWWGCihceSxQO+3k0YomiSC0nXyHsd9D1t2IEK9K8dHYhWRwG6EG4UzcYET1EtXqfOAoaVmfV72UCuda2L6fgSa/y829JxmkhQATC0GEvMADA7Wecv9xUGu9MGT13P3y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738834044; c=relaxed/simple;
	bh=uKcZT2zDhCk8R/AW5iSFkJK3WSSoEKelbgY7E8ifqI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fqURKhqo8s+6k7fUtx2yL1IXDPqpT4ojtWaDX+9xGSf9AdgN9vlsEYe/3V4sFoCFVHssn/YDsZhxN9Vif6ghapM0YJwt9Ae+78fKDoiok7LJxSgTsEI4Ha7E/l4dKMGs+Mgr/Bz0BLVX4KIK9bNf9Apa7dE2OTwaZwDvAMawaTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QfEqDSG/; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-436326dcb1cso4172455e9.0;
        Thu, 06 Feb 2025 01:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738834041; x=1739438841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gmsIRuDoMMbPVfyRmIRyVAKXjFuu0acHJd7odQj6dE=;
        b=QfEqDSG/sCY/V4D4IoQRu42jfPX3eE3obxXw7iX6VxY7zdGE8b0XTJSFK2v2kN/8AQ
         WLZp5gPam81+yvEi22+puCfpPSMfnLbFm5p7lk7c92hUZU3zOfzjaFDSNFtgA01d58wQ
         KEAIOYLqgb9wY4tGJXi4geBIJqQKzp4ESREkzFvrtyrt1J0xY5vRYZ7CbZm15aZDxedf
         ezeTujhkVNbC631mhhQg23OvO+8XgTRphdy2TNjk3fzKJazzaP/+ij3RwoxvY7xM9NuR
         O9WTo3C1nyqTPGduJxBEzvOUA2/EdrGvvowYEE5Iv568db3eE7HGDj57kEskucI+3/3O
         Riwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738834041; x=1739438841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4gmsIRuDoMMbPVfyRmIRyVAKXjFuu0acHJd7odQj6dE=;
        b=VyQzL9SHrLWb963vpxH4Z/pSArQBiVr5Zu+vsVFI534CcxMiKrwMEPWf6EVYKbu3z3
         SwFbNLBpXPELbPPmED6cocYNWcjQ7KyiE+fjOj8LXYFeVqlF2SVIZtglGsyVaBYcudAv
         Zku60fNzGsOHTQA+F8ULivUIQjQM75ymm2BcNoKs266H0zA2bPQp7VIWqdhnMwQVkq9p
         JbbfmxBYciB8pSs1t7yKqaXV5nUF4ubof5OE9lxgRyG2v8YooeFopphtYsVvEaJfn9eX
         rvJHX3Du4w9zRyefnhijh68HeXvheG2aFrzYzN1+eFvQIdMWNRL1jzGB2R3KjlpgBGG8
         tT9A==
X-Forwarded-Encrypted: i=1; AJvYcCVxsBv78vGYB6jOAvxeIFyQDS+ssU3rqVdjpPf6QmIv7sG9ixkECOfLUc/clQ3D4++G/mEa2+qZZp3Go2WviA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSpd+68XsOLN9OKFqDRC2KbmuMz3iWsARh45DmaplYBRXK3/F+
	29a5/AbR3wlSSvKXSq9JsvklectymW8wdHz+DqXeE+Hkhc61K75lLjA05Q==
X-Gm-Gg: ASbGnctsZYmNluCj5eKu5sjdbVgJQp5zsWtzrSt6oTIxM+JMEoGLhamWi4aGvn+6tvr
	/Y91jYqeSodsCyKoSAy9N8M6rW4+Z3yBGzMsRLg6MEc4jzVg/BZWHulU+QOEFoUfzuZY9nqxEbx
	1lHNkLmHDvb7gO+sBBXjbwa9g832runkfhBT3fBvpwvMpEkSe/jsIiDT+CLvLIHdkipLcJaH98w
	nn+47IrN3O3GlzpCKUM3OTCn7A0R+fYEKDUgoHEPofya4o6YGDOdcR3h2e+d+HbUEIFOt0YALzy
	YE3EPdlhO1uaaJVAnHl3jSSfipIybvxMYg==
X-Google-Smtp-Source: AGHT+IEeuJUvH4F+nP+wc7totD0y3bHzs4WHDZ+ek0QKSi/073i8Fgiwnsv3CNYyLYcAn658d233xw==
X-Received: by 2002:a05:600c:354a:b0:434:fbcd:1382 with SMTP id 5b1f17b1804b1-4390d435cf2mr61290065e9.11.1738834040699;
        Thu, 06 Feb 2025 01:27:20 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:c428:5404:970c:34c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391dca004esm12832585e9.13.2025.02.06.01.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 01:27:20 -0800 (PST)
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
Subject: [PATCH net-next v3 07/10] tools/net/ynl: add indexed-array scalar support to ynl-gen-c
Date: Thu,  6 Feb 2025 09:26:55 +0000
Message-ID: <20250206092658.1383-8-donald.hunter@gmail.com>
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

Extend ynl-gen-c.py with support for indexed-array that has a scalar
sub-type.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 1316a4fe798a..7e6454185310 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -687,7 +687,10 @@ class TypeArrayNest(Type):
             raise Exception(f"Sub-type {self.attr['sub-type']} not supported yet")
 
     def _attr_typol(self):
-        return f'.type = YNL_PT_NEST, .nest = &{self.nested_render_name}_nest, '
+        if self.attr['sub-type'] in scalars:
+            return f'.type = YNL_PT_U{c_upper(self.sub_type[1:])}, '
+        else:
+            return f'.type = YNL_PT_NEST, .nest = &{self.nested_render_name}_nest, '
 
     def _attr_get(self, ri, var):
         local_vars = ['const struct nlattr *attr2;']
@@ -889,7 +892,7 @@ class AttrSet(SpecAttrSet):
         elif elem['type'] == 'nest':
             t = TypeNest(self.family, self, elem, value)
         elif elem['type'] == 'indexed-array' and 'sub-type' in elem:
-            if elem["sub-type"] == 'nest':
+            if elem["sub-type"] in ['nest', 'u32']:
                 t = TypeArrayNest(self.family, self, elem, value)
             else:
                 raise Exception(f'new_attr: unsupported sub-type {elem["sub-type"]}')
@@ -1673,6 +1676,9 @@ def _multi_parse(ri, struct, init_lines, local_vars):
             if aspec["sub-type"] == 'nest':
                 local_vars.append(f'const struct nlattr *attr_{aspec.c_name};')
                 array_nests.add(arg)
+            elif aspec['sub-type'] in scalars:
+                local_vars.append(f'const struct nlattr *attr_{aspec.c_name};')
+                array_nests.add(arg)
             else:
                 raise Exception(f'Not supported sub-type {aspec["sub-type"]}')
         if 'multi-attr' in aspec:
@@ -1728,11 +1734,17 @@ def _multi_parse(ri, struct, init_lines, local_vars):
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


