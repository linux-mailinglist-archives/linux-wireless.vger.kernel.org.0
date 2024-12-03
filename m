Return-Path: <linux-wireless+bounces-15852-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DA59E1D8F
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 14:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36E9CB32456
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 13:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2C21EF085;
	Tue,  3 Dec 2024 13:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAiXjLvs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDB81DE2DE;
	Tue,  3 Dec 2024 13:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733231228; cv=none; b=LAakDlkzwBqxKCf8ylMVwll+TBib8tHalXdpuhu4FMXblLDBpchlmdlbCrKE1TRuztdQfD0PY747kA5j4ytsr6lGCMFU+0/hEloUP4EJEwvgbfgNYqRgiKgOXjONq/fCrumQy5i1zQN2DzjHL6m6AtB0I0lwAh2Z0BPdSciHSFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733231228; c=relaxed/simple;
	bh=b+OuBjzpMUI9l/xspfdZouAZ99vEyd/6lgzE8BFjaRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XhrxGxFqqmpT09hvzo2XTo4yKcB1AApH2zrci7T4Xw1VCDuZGVwT8meZnD+p+Dq40/aKvuc/ZRuEnwHaZlYRyUaIqPEJ5Uy5KsJMkFQSjYOffpYpLW81EZE7rKzue+PtnSF4xSASR9hHzSetW+Aj3i1ydkbzv4je2klyC0+kfY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAiXjLvs; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4349fb56260so48072385e9.3;
        Tue, 03 Dec 2024 05:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733231224; x=1733836024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4tHvBgBQosB9RUlL0Gs9gizwfoZ6RRymZBEVfFKRAQI=;
        b=mAiXjLvs9jvAa1T/xr43PiveUDkjeBvPqKSXHobd8fDKWWiQcIEiXIbqrl1FrmwUo+
         0VBlLzohXAF7xc2msm3Sk9wsBUvU4Qvd5qlJx09r1xNzNwALh16QknKy6hxf0GlHUC4j
         FeSy1ObfhFm2qon/1CPIfUKY+xud+Kthznq1AlJvjG9aBNA2nR5h+ncDNKRNCpFQTMRc
         VsNd9vhFHjsACts5MhtcKxpNWEmb7l5RhFVdCxpcHp9ry4pzsmcM+S75MitrsmaPZm3o
         WGsE8LZOSYfdpo4Z+JdTpIHxp9VPTrLTzsjXofFFz5iLm+fc/uMAKw/HM+PCnpwhNN9i
         JUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733231224; x=1733836024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4tHvBgBQosB9RUlL0Gs9gizwfoZ6RRymZBEVfFKRAQI=;
        b=TJkaDS8g25KHJXTGI7Y2jylL5I+pN/LHfCZcKjXgQoGva8PXFXUOQKaYzaj3dc6nFl
         S8UEw3ZJVjy9TqfRtVQ7V0+1DOrhAA34hmNZaQaRLtLgD1Xu4a57BSbRg3Gqb7A6cIsz
         R3e4sW8ZGF5kXnExAh7wA9AEee9W2k9lLkwgGp1Sm25CtDckNjDsD0x6mQfq9dA+f1Tz
         kz4HK+yV8iGCzhqDOymx8F2bV7vq7ZCwsFHORo6geHdjezNQC07X1Y0dQUFWhVKxbHZM
         BbIb4VC9zHJC1npazLVzypwl621Opg9+ev7KChaxGOZOycaGd6sdZDeDQc7Dnk+/mGNc
         b8VQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSf6GRID0af7yE05icLTu4S1hbLmDRqIN7Ymux2WT2cbPDnsF0kcfq+tJ4QopiQ27l517tCxH4wBOU4C53GA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFw+qbhK4i8OiKrK3L5janFZQPWA6brwIoUeqYnkXLjWn4gBHx
	866ORMleZuQYAe9YIOFhXlvqN2WqMF1Pe0vT+7a2Z0A+cqsb4oXkrDQ+Mw==
X-Gm-Gg: ASbGncs9qcNlF14bv9qMjuG32XNJv+K6KRD66Dbx1kNLQD0RfQ4JtMDll5XT1BshQNc
	7cX1JNe7DaF1RlGpYxGhcnFPtaW4TkaKygx7ZrjCOzeSVJPunj1bmDDkhuZ5Rfzo+J5YLbehvqe
	N1AO3jhox9MJ0feXBke4mESN9nm53GVTBL7NaWXmmNBhiSSO1+KaP+UgDjPSWbtlGDwSLToyeh6
	byZNVBB+HA8xH/RQd0b+AS1yLzCTbGS2Z4WIIkvG/311BcFMLjA5TbZ+YBJ73Wt6ZU=
X-Google-Smtp-Source: AGHT+IFzDNElEv5ciaPWgfVf4UwNWlq8eZFqOBaRXKey7CJyRqR8LmVw28W55DfK/uKjRK6WsWV4/A==
X-Received: by 2002:a05:600c:1d86:b0:434:9e17:18e4 with SMTP id 5b1f17b1804b1-434d0905301mr22480045e9.0.1733231223495;
        Tue, 03 Dec 2024 05:07:03 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:6140:2ef3:aaa:55ca])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7e4d42sm219142365e9.37.2024.12.03.05.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 05:07:03 -0800 (PST)
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
Subject: [PATCH net-next v1 1/7] tools/net/ynl: remove extraneous plural from variable names
Date: Tue,  3 Dec 2024 13:06:49 +0000
Message-ID: <20241203130655.45293-2-donald.hunter@gmail.com>
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

_decode_array_attr() uses variable subattrs in every branch when only
one branch decodes more than a single attribute.

Change the variable name to subattr in the branches that only decode a
single attribute so that the intent is more obvious.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
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


