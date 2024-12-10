Return-Path: <linux-wireless+bounces-16169-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A4E9EB5CD
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 17:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22791164DCC
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 16:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8BF22FE1A;
	Tue, 10 Dec 2024 16:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jj5ZFaHY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7F81AAA0E;
	Tue, 10 Dec 2024 16:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733847302; cv=none; b=A29hFAIbgIU03dPechdfX+TdxMFNKhw3JiZHpHR0XVjmSwbNAK/G04garNtQlO2UBH+wdwKWKpOatWlWntawSv5jAC93/chtZpYE8LMc1f+TWtg9rHywkH2JCDw9/6y4mHRuZctM48THnP0RctJu+oC7K/yMCAuz221KmG3/K6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733847302; c=relaxed/simple;
	bh=B4eDaIl47FAQp3+iBlZOG7U4kOJNew7d8XOSbl8degg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g5cQMWQFWtsSqq1gn8jQrLue3tyHlElgOS6RpfmPC8jDBpYOAGfzRktbjJzW4eL450+MLThzoQb1+4MbZnROft9UaPw9phxTFxMZ0I8YXwCQFN0kYVh8SJhleNt7w+bPc6tZnD+t2t3jiuvI0GPMffHFDrvYet5yzyd6TGUixDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jj5ZFaHY; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4361a50e337so3337075e9.0;
        Tue, 10 Dec 2024 08:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733847298; x=1734452098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UfyKOgt9XE/lehI6wB+uzFWPDlGZk7iREHj4msL9Ld8=;
        b=jj5ZFaHYDCNBMZNXIOfSahSMfmcSdPo79dBYdN1QqLpD7qaB9Q4MPAh7fJtfrqqfZY
         0P4qJr+bXl06Ihe5bdaEagWpV/JowSSSchI18tVsccSul3vdJMaGO7Di3DX92sJfbNwQ
         e1kyc8SstIyek0IbYFksLPI5iK6+ZWnRVwqmF0wXFwkZJEGa4uTkCU6T6V8f5JFmkOF/
         5nZuBtMT5dHUCerX8zNq+fKZ1xT0ahvrqzbXFuaeQWBwUKuCd0to+7a26uZVq0KRM02i
         /duDGf8oKfkHHJhuSMcO7Eiaa/6kFW3g+tDmujnqPfmesde+qE5T/YxprcTug1XPwudK
         stJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733847298; x=1734452098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UfyKOgt9XE/lehI6wB+uzFWPDlGZk7iREHj4msL9Ld8=;
        b=vHYNOSIPLor7kY0spF5KKuAmH0Pnp1YJi5tNsxg2jf69qU5pRY9DAvsQfLotznL5NA
         j9G0UBwNiEKrlpgSjgvyzFwUQF6pODTMlN2yzkEs+M7nBp5H1gZ4NxaLPLYJf/j3Ha6o
         oL9hNZykKL0zn7Trt6bYT3mYauKixTPkUtaIJrYWBOCg0zm6nop2Osej+wRXiTm/aWPU
         /NC1zGIknU2ISJFgr2w9eh0mBEXxhR3Id6uTIKu3+oyLgSXpIe7FwWUg42p4cJRGFbKr
         8sXDZ2lD/n3TwePT1ELzueo8Clr/9aa9y95SpVoOV9iZ9R7dQ6pZ3W1ARPsahMiKlfZj
         o6cQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJx7jrFaNtHz9dEpepKuQq6yxHlfu+oOnInjIgZJPkM1ZKHfILdogQ1i0cUzySFeVjsfyOOyozoSD2w9aIwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzExjFZByPh289zklRWXdf0AjxPUZKsrRIHG8u1T9E+ee4LrjUJ
	grQMwmnEdvk8u0hXO+0XeWKyMWL/+EKWLdsxQf2SD5o6kZWVNFvUUomp1g==
X-Gm-Gg: ASbGnct48o9x+4hZVVCX5tnNZTemDAzGJclqrGcMVy9GxzoN0W9ZLeM7ofpkPI8aWoz
	nNMW7wZfz9nhAeUA8tqIJHlbz5IzSq0b8ORIYEgJtW3RRxB5qNl6YMg43NctHlm+gIK3ekpt54S
	afeNUr7doYvSqm5MK0PQA4tBFhXxqUchfUnD+gBU3kdfgJWF9/lnrOz+IIhuNUyG/3Hw0KmWhY2
	JlTMLSGDk/S3kMKlKwZ45KGkuc+ILRPCtNKhZx+VL29KCk68dExiLauAXO/zDtrs+C/Ln5O
X-Google-Smtp-Source: AGHT+IG3QJESz/b68Kb2pqLydDF/12Q+/FhXD4BaT8iyyfmaCymhVEcl+lcGJjKHGQcuS7cmSRpYig==
X-Received: by 2002:a05:600c:1d24:b0:434:f219:6b28 with SMTP id 5b1f17b1804b1-434fffd056fmr45145785e9.24.1733847298219;
        Tue, 10 Dec 2024 08:14:58 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:75bb:8102:943a:2eb2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f30bceadsm102383045e9.41.2024.12.10.08.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 08:14:57 -0800 (PST)
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
Subject: [PATCH net-next v2 1/7] tools/net/ynl: remove extraneous plural from variable names
Date: Tue, 10 Dec 2024 16:14:42 +0000
Message-ID: <20241210161448.76799-2-donald.hunter@gmail.com>
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

_decode_array_attr() uses variable subattrs in every branch when only
one branch decodes more than a single attribute.

Change the variable name to subattr in the branches that only decode a
single attribute so that the intent is more obvious.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
Acked-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/lib/ynl.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 01ec01a90e76..dbc7a0a6ae68 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
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
2.47.1


