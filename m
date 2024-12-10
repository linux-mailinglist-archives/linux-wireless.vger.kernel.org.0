Return-Path: <linux-wireless+bounces-16171-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C480C9EB5D0
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 17:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 630B9282085
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 16:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938512343B0;
	Tue, 10 Dec 2024 16:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMt93E6B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C600C231C8A;
	Tue, 10 Dec 2024 16:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733847304; cv=none; b=NFYg3C1aVGGWJ7LFwUN/19b7wuJLcdgJpn+RWb4VBfLlZoHDNsrMnvCcj4Ai+9IBctC+f8cObBejVJOfDDvcba0F0s+ExOX5R8pEsMCFzavqa0xKoou2Hl2zdK1z81QuARKzGZp5Qk/891FPiFoJpOon56ByxQifD3scPA4iUHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733847304; c=relaxed/simple;
	bh=R+gI1dVon4DOKCOQXPYqAP++OPWqHLgaKnNN13U/JKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RC08ab3ozKBjTVZUsK63RNsZAaLzEpC3U4+pJ+wVI5BMm9up1wMI5VDAy5ZZgJijVze1ksOtAD7PNSJO0MFlUkr+BNicq8+mW9eALDXWdbuSxqRtRGYXddf867BBMGIA3mfEUtboFoqumW2cYP9dtYe1znl2OaeSjIv68EL5mXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMt93E6B; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434f80457a4so13733045e9.0;
        Tue, 10 Dec 2024 08:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733847301; x=1734452101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwPeUXZL4LXTE5jOtux/7BrFO6qrNVnZqff4fvw1AyE=;
        b=lMt93E6BhlgC+NEKN6ASVRTU9qy6WSOe47zC1i41QRmhk2AubVoB2UZIriJSBzseZU
         Cw0rycqbZLpBeLz20pLtmB5Z62tiYyAgsw0NFPQfwFfpNQfm/P+55XeqF38t4KiaE74b
         ys3XA2Vc/8zWsCFZylwZ3cdkH7y8UQMPAOBsACo95YUXnQ3KzrvG1zqcluwKhspj5x4/
         72KqXi9ba6xkcrmAyU9GJU1CsmPAcJJrrrKG4Dphl3ng6dS27zg/dbbkZ81YjJfwS6fu
         B4AIi3FC8/utYzE6bb2sfXHinePOXxUQpMFGBi7tolTiEj6KH9Mqv76rWLS8yDlmyuw7
         Mdpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733847301; x=1734452101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uwPeUXZL4LXTE5jOtux/7BrFO6qrNVnZqff4fvw1AyE=;
        b=fvrK57nEHdbNe6N+k06jhc/5rxUf76fXRx3xgc/wyvDAakELJ4UrKHtqHLzFhZTMRd
         rG/JXyR6c0FnnXebUa4Suwg4ORC3eVof+De/YqA3sLJb7h4SmbScn9LTfaTHgQsAhGpW
         1fkxsOiWIP+hR9iJtHrEi3g0vwa1opYp3fILyTIvT7BLUbz4AmUjCJlfzvvoHFp/0j2q
         6UUeyCpsCOaGtKm5WqgJBm4h5yrM26abV/5LJRf6zaEKlTEhhRMlnBH9C0p+xZFq4oBR
         h4FHH0f4LPBXuo+E7ghwfcbuC99+SCB2NOhfYU6m5HDI/Yx8PBz1iE3jUR1RkklY/OuX
         PIYw==
X-Forwarded-Encrypted: i=1; AJvYcCUDjm45vq5b1xHFLOFGW3RboQEAfImB3bG2vpQsvBN6VfZUR8VR/4hYyV4TKc1ugNBKw5zda1RNV0KwXXAe8w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSCxHUlR9oKIVc0/NG6+doDzAnoVH+UwejFGOdRaxmlQ6dRBVM
	B6+cWu0RdJZQih1lyn+hlyH5Cl9o8f8LXrB/ZDc+KRU/E4LWvifU382rcg==
X-Gm-Gg: ASbGncs/6Ft82bqp7c5yjzlWV12xfhr3lgxr/I87cOQelLacq/EOtaSfpfzhMgpbLbW
	jt4DQS5bRCdXDzLY+uH5jNbo6YXPgCVtz5718viC7hrsVOEgMdxT9DXdTRmoeOhk7W9md/yZPyc
	hORalmuozYPR56WFeIJOuTZo5e4rkz0hgbmP6Oc7JXs91wVjFcjjmoPCk+aU3UL/lM7LaSYHvfF
	EFqSzoIs26T+EZzkbOrSCQQUXaWCdhpJ8j12Yi3TFwJ6crOudVPydEcgrTMH8EQzXGRDDbc
X-Google-Smtp-Source: AGHT+IEAVitG53IVlwQw+27U8bGL86kla+ZA3V2FZF8+BgxeSrD1N+XvL1mxBYpqn7sgedCNCS0Erw==
X-Received: by 2002:a05:600c:19d0:b0:434:ff08:202e with SMTP id 5b1f17b1804b1-4350219d6ebmr30021285e9.8.1733847300797;
        Tue, 10 Dec 2024 08:15:00 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:75bb:8102:943a:2eb2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f30bceadsm102383045e9.41.2024.12.10.08.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 08:15:00 -0800 (PST)
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
Subject: [PATCH net-next v2 3/7] tools/net/ynl: support rendering C array members to strings
Date: Tue, 10 Dec 2024 16:14:44 +0000
Message-ID: <20241210161448.76799-4-donald.hunter@gmail.com>
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

The nl80211 family encodes the list of supported ciphers as a C array of
u32 values. Add support for translating arrays of scalars into strings
for enum names and display hints.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
Acked-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/lib/ynl.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 0d39a83574d5..08ad2d8a874e 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -627,6 +627,10 @@ class YnlFamily(SpecFamily):
             decoded = self._decode_struct(attr.raw, attr_spec.struct_name)
         elif attr_spec.sub_type:
             decoded = attr.as_c_array(attr_spec.sub_type)
+            if 'enum' in attr_spec:
+                decoded = [ self._decode_enum(x, attr_spec) for x in decoded ]
+            elif attr_spec.display_hint:
+                decoded = self._formatted_string(decoded, attr_spec.display_hint)
         else:
             decoded = attr.as_bin()
             if attr_spec.display_hint:
-- 
2.47.1


