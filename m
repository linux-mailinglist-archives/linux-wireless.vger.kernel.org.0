Return-Path: <linux-wireless+bounces-18578-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 224D0A2A43C
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 10:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71D183A72CD
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 09:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626BF22618D;
	Thu,  6 Feb 2025 09:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFYvVPwB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869C8226186;
	Thu,  6 Feb 2025 09:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738834038; cv=none; b=murm/wMQl+nOQ3kGPdcE6HAwbD1ErgZyDIPifSfNxzAMA3sfD1ZJ5sroIIZMZaVoqbcUxemNJb4plV/Ug+zxwQ1mWg/L57kCvTcJPglhrK6npzyRZLpM6MsxHMPHJZo/GDSMdv6ichYbXVjhPPDKJgfifISE6D7hkdoR6+Z3goc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738834038; c=relaxed/simple;
	bh=WSmza9m5lqfjaJbkYShhNi8pvsDhRW/0u6ShwBBGN1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHpyXtE0Rd/j1oECMgrdyunYAmfg6eM3eipxRrC4r1xWLUAMeCgVZ9Tjyj/n0KZ8s/RiEYBpig+NDHd4pvYRvNPGoLBfbiDsICAhILRcF46W3NmFRQpbQZW5RJC0ZupCLgl7PyUDxvnTUi3L8yl8puZd3TAXtApnPbtVMuk+nts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFYvVPwB; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38db104d35eso468555f8f.1;
        Thu, 06 Feb 2025 01:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738834033; x=1739438833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukI9L+W3BVJpqtTUxee+mj8XRSqHm8hW8ALqrNrwT90=;
        b=UFYvVPwBqPP6HRNZLsrehCDlq+iud/Myh/+2h+1Z1to0vhZ/jVe/LkG3n1XyKhSPNN
         zrmgvWWfJblSwixanzVqBXA3kVACFh4LwB9Ol7ETUPfkwKpbr2m67wGzX8NNO7VTDAdZ
         3AeZlB6sKBj0QdRwQEMTVmt5ATTXIEJYPtA9OC4MCAH2c+aHI01oMQCRqY9da8goUKZG
         1erXDvQI3GTtEh4tOF50V6mALuSnSivztS9FRFFCQBB4xt1O7/YWrlU+DeTVLGhKxvhM
         r8ZmSMdgjYRJRPzzVzvRjPrGAkE+WKnaj2DD3SGt60un/l+BzqW0TJIwkEIFoCqE6NR2
         S1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738834033; x=1739438833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ukI9L+W3BVJpqtTUxee+mj8XRSqHm8hW8ALqrNrwT90=;
        b=iAy8Mu8Tti+i8+bFUtj91Emb42NNORx4VOTQfOlUMDLp8vMnbAKRKiOviF7WN2u/jQ
         gM00MLDOnTsdqICuiiVx2Z2HOfFG8qipaH6A8gKOvJ+CI+ZBBSRHVxHXjQKIj3GdIXZj
         pbnwhF+braG3J82R8WGi2HpwM5LzK+tj/EzKK7+W6Zw1pFVC2RyrtT0bgL0mjwSaHynZ
         Mwvok/p3a7By5ZYPiNxWYfGrf57CAOiMcTfj/h30C60M2PKBOAiwQhKsT3B1pkJdipoK
         klPL2T9bNsyK8n7CJDRa2rKml/q0JjQWp4ZLqli5/sm/D6Cg3wBN64YkV+v8913iKlee
         v0SQ==
X-Forwarded-Encrypted: i=1; AJvYcCWF5nHaLdsbmKa7oOX3/RO2By7qIql1UCEYQOUzkgccuvBnDEwGTYo9Gtpt2L+psvmfnUqQNBRbB9O2OWQa/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwoybFNme5e/mGhVGPBcgNUXYbjnNOyz1Jdl5SMYjFlYXW26GZ8
	zJ7wUna0L3uub/HkEJcItHtd1l9RaXMjVsyGTKpTmK6raF+g6915vFMpiQ==
X-Gm-Gg: ASbGncu/Wd/PfcGzjLJ7pIJqUqIqVSNrqd//a90Dk1lIV31hqW1amNorfw8RYzRuhj+
	nSMyRj722zBx3TyEIpGEaZx6ZDmBzOzO5xNqmzumxrQrzlfIZp9fQlNRPwcqHLZ548bHpPGmg8Z
	B4sfJf9YglOLpqjmrQJlWhD/Evsij90oE9w1gM4O0dR+QWAWl92C8B1UBV0nCrAPVk1agE2qoho
	3INpeVSrX8COU0xZCML43azEaZRgogikfLfzr2skgFOGTNnliG51rm2L5OoqnUHtq+Pv3FLMjzu
	k4a94vErsw+a8kkjmwWWc1QLgWZILhOCWA==
X-Google-Smtp-Source: AGHT+IEv6GjGSfAPde2d78YDZAwTialtRKpWibkjMz9Rgy8IL0j0X4oH/0W2KzIpwdMmftDpUmvLTg==
X-Received: by 2002:a05:6000:18a7:b0:38d:c037:9352 with SMTP id ffacd0b85a97d-38dc03795a0mr811743f8f.25.1738834033182;
        Thu, 06 Feb 2025 01:27:13 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:c428:5404:970c:34c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391dca004esm12832585e9.13.2025.02.06.01.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 01:27:12 -0800 (PST)
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
Subject: [PATCH net-next v3 01/10] tools/net/ynl: remove extraneous plural from variable names
Date: Thu,  6 Feb 2025 09:26:49 +0000
Message-ID: <20250206092658.1383-2-donald.hunter@gmail.com>
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


