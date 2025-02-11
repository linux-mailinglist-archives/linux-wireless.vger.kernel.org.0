Return-Path: <linux-wireless+bounces-18759-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA54A30B01
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 13:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 471163A370F
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 12:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6451FCFC1;
	Tue, 11 Feb 2025 12:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXOf4ZT+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA491FA165;
	Tue, 11 Feb 2025 12:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739275304; cv=none; b=rCNguLuMK/8ceVV1Fv2mnTDx4FLBoQ5IPcFoQurBS95jWrmZofYwsq5ophGrAmVvo1JuLtBAqOZrBR0ETa0UJAxpvIG/YaGfV9w6QZQ4pU+TZTaLnhoC9LHdgVleZ2d8vg8zT9OFB1TRD3UiaQDGFbGMFNOMrdGwsX1MuJhqUKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739275304; c=relaxed/simple;
	bh=WSmza9m5lqfjaJbkYShhNi8pvsDhRW/0u6ShwBBGN1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AmAZ4s8LXBZYXs/jnTxfXVEXFFtgCNLI4nuORCG69e+0qe0lT236pano5aItzTNAqQrhhtjfg1Y5vP7NhmaUtUrBLShzaVvTKVaLSx/4SKOLknWVryhI8Sra7pzn0n4a3jwkrOA8dTaN1Lip+eYfhtna48okLcBdDSWbECsr0q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bXOf4ZT+; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38dd011ff8bso3109713f8f.0;
        Tue, 11 Feb 2025 04:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739275301; x=1739880101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukI9L+W3BVJpqtTUxee+mj8XRSqHm8hW8ALqrNrwT90=;
        b=bXOf4ZT+yotJHyzi+8yNfLEcZAzHy3FaozWmsTRIXpSSv4SVbu2ZkaTkMFE1SLlAk+
         7k8U8c8ZHtVVi+XBKTmpy+386/WRjEN7UvTMfe+P2OnBG14G1SLFB4Fwn8UOinO2QUuU
         YUOxwqS7nJnFnvR7EqS5rn0bwmpNewOsHJ5gRhtxCtzOprDbmEUkeopcRFXxGM/e0uvE
         lXP/bpgRhcT49nKo9kxSWKXUpFMMxYMlad4rahCGLADrX21OA+Qykzg0E5m84uUmghaN
         y/7r6HLDk6Roy7c31U/q16NSftnhSZWq56WBNW8Nsqp1w2BF5NjQfIapZYY6orlwrJWI
         8xzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739275301; x=1739880101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ukI9L+W3BVJpqtTUxee+mj8XRSqHm8hW8ALqrNrwT90=;
        b=HBA0O3YfY5oYan5n+57oEA/6nmMSXZ3QNkSsTptVeqDvTVUzSNd8jMuaorwx51p2WG
         F9uKIrhyGSibyrHH2BgVIMpGG15W2Xi5kKYTssSKi95tMvjfUDixxBs8y2QKJSFN/4hG
         pZ9hPAjx/2suRUIinUzp6cK7TroBqEEg/YVGTKZKDXwZZvePwxLbuCi68kRD6+3plJir
         ILg+ROGPbMAFhGw2an20fiVPI+BgfwBA2HZag7ZhcD1VjrxA13uvNzfEoc2ZysF/D7Ok
         eCYBTLJju3Awe52ZUk2OGec0NNIkNKiUHKaa192aP/Gq3UlzVQnx0efOxilhTcHC+/d+
         /+ZA==
X-Forwarded-Encrypted: i=1; AJvYcCU6MN4ANbswJFY7hJrYZoIuEe8YbPsDxoalPEsiTjHXUBcL5lUNtsOkZePBJPv1QfAOyN/6cGPwqY55ZczgGA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9cmHSo2QH+GyKs8Vipz0yiOl+/KGu4/TsNldWm6SfLGyNdwBt
	DBWklzL4mihRScL9GQ9iXd089yFQ6wUgTmgoGcVFgRfuKZpJyGVHl8LRtg==
X-Gm-Gg: ASbGncv3BXlbVrKegsVkCeeJDS2l6jmzxlt1AXwZpwJEP/A3qlavKB27jlBEi08FYyo
	PNpNysQZ5z+tHKvPNqbGyh20azX7WhGPIpkcmzvZrQ8uqTo2hSQZvMvkwPynux/HMf69Wdj9XY3
	TUnzG17JBW7GyZ2fmlexzgGO8payOrTr8UWuvrqQxSSRlFe86gw5xOyW5B6jgOGltxl4eO98vkA
	1+2uyBSdeKKDyVY9pJgnYCkYCAgVYBKou5fEoctYolK5kbQjAnl3TkVeEX81hC1B+3LORydha61
	vXlFgw5/CjVKRDdLYUkh4ZujZQZJ8irAbw==
X-Google-Smtp-Source: AGHT+IGat1/KySXHMoSlk+TobooD3C5IR62D68go2AuCGpWimmB0odeotXUOZUvr0qV4o1Y8gRgtyg==
X-Received: by 2002:a05:6000:2c3:b0:38d:dbbc:3b07 with SMTP id ffacd0b85a97d-38ddbbc3d28mr8109398f8f.2.1739275300557;
        Tue, 11 Feb 2025 04:01:40 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:ac07:4372:f96c:546e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dc933ff9fsm12466658f8f.96.2025.02.11.04.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 04:01:39 -0800 (PST)
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
Subject: [PATCH net-next v5 01/10] tools/net/ynl: remove extraneous plural from variable names
Date: Tue, 11 Feb 2025 12:01:18 +0000
Message-ID: <20250211120127.84858-2-donald.hunter@gmail.com>
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

_decode_array_attr() uses variable subattrs in every branch when only
one branch decodes more than a single attribute.

Change the variable name to subattr in the branches that only decode a
single attribute so that the intent is more obvious.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
Acked-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/lib/ynl.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index 08f8bf89cfc2..8b39d8b1eaa8 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -644,15 +644,15 @@ class YnlFamily(SpecFamily):
                 subattrs = self._decode(NlAttrs(item.raw), attr_spec['nested-attributes'])
                 decoded.append({ item.type: subattrs })
             elif attr_spec["sub-type"] == 'binary':
-                subattrs = item.as_bin()
+                subattr = item.as_bin()
                 if attr_spec.display_hint:
-                    subattrs = self._formatted_string(subattrs, attr_spec.display_hint)
-                decoded.append(subattrs)
+                    subattr = self._formatted_string(subattr, attr_spec.display_hint)
+                decoded.append(subattr)
             elif attr_spec["sub-type"] in NlAttr.type_formats:
-                subattrs = item.as_scalar(attr_spec['sub-type'], attr_spec.byte_order)
+                subattr = item.as_scalar(attr_spec['sub-type'], attr_spec.byte_order)
                 if attr_spec.display_hint:
-                    subattrs = self._formatted_string(subattrs, attr_spec.display_hint)
-                decoded.append(subattrs)
+                    subattr = self._formatted_string(subattr, attr_spec.display_hint)
+                decoded.append(subattr)
             else:
                 raise Exception(f'Unknown {attr_spec["sub-type"]} with name {attr_spec["name"]}')
         return decoded
-- 
2.48.1


