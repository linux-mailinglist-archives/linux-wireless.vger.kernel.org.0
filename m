Return-Path: <linux-wireless+bounces-18580-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B661A2A440
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 10:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7BF71888CD9
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 09:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEE6226187;
	Thu,  6 Feb 2025 09:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8ds3Pui"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E5522616A;
	Thu,  6 Feb 2025 09:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738834039; cv=none; b=qhCIITGbe+pvcV6CorVVaSYs+g5M1dvMjpr6pidPPN2s8LFwuItF0NBzdtaFLk4VJURsT/88Zu0+jvcsqdwzMiVZrqU2PdJeG7eYWPCpvx45qtttJvDxHQ0UoaaeKSsz8JSmvi/nleMfGGpeZbZBbetThIJVHiiFHcp/H/wFx/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738834039; c=relaxed/simple;
	bh=1sXRpKRdwQWU3PDhHFw9zXhzGGi7++rZDL+a2/5+euE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KHm0SdW9aQkM0uXrZLLd7/lHb7O/LN5mpxFcoOjgrd4+wl7b+Xckd0gMnbtYPrqZmwJAaRpOtKkgM8GncQ9gGrlxlL2Q5dlGUkM4XeQRRu+vOmiUDvx7CHUUzIS0IhFGmlyMpGNCWM8iDlFaSPfca5udaO2rIPi5zJR2v13dx1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8ds3Pui; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38be3bfb045so1097149f8f.0;
        Thu, 06 Feb 2025 01:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738834036; x=1739438836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRuritwii5Exw4qc/zxuGeTLgpqDh2QQL5NTFCoOB4M=;
        b=m8ds3PuiDCKcEgaCDGNjnRdNChC0bm/2X+fy+k+kNOCQNgq4tH3Gq6VbvQNbaR80iK
         xcIVF27+6K+A4nWrt4urfFeElIKWqSO8OvvPU3X9Wj0F70UhGIabvlbNTCCvsrThyloP
         fsxwqvEEWCf9xKd9hsXzu9yjMWnqeQIkXkGEK2w7GRKQ+rgoHdtxB9x3CNUb16upJi0v
         eK56KiDoOHQvuFOmmjHOEyXhtpPexHrxSLS9B2b3w73KhfCVGSWqxNiaIlyqZPWC/klM
         iUslFTiqZgTq4b/vPUU5Mi6SniXB1dNCBv/6IMunj/wQ7hA+OHcBw2IIJexhG3Lx3+Az
         DsOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738834036; x=1739438836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xRuritwii5Exw4qc/zxuGeTLgpqDh2QQL5NTFCoOB4M=;
        b=I2bvJZ/XNcvfn85xRCA6Q4c1xFuEKww+8IHNx8ROR947v4Q1RxrXILWVHz0XdOFas/
         foc9gDa6Tv2Xck4tnFRSdy1a+/FA26S1W2sQKOk5N73qlvpJ9YKYLSRc813FbpX9V6FH
         Ke85ZgBWkCeA1ZBoJBk0DrbNf8pk/2feitn08+TrNlxZRJFlAMFXWJ880yxk5kCsom/a
         WXS8fpP4BGRfNUljt7FPyCF9zu2Xm+OY9ncLRZSQk3RbMvrJtyhGprr/d7OqqC2AvKvD
         dpNKltxgpp91L71rWmT2+Wmc1v2inDB9TUyC5VEkWgZOqsMjhubbUjjqwYMkdw8+12DZ
         9JNw==
X-Forwarded-Encrypted: i=1; AJvYcCVxx2fFx/2N16EKFuapXF9LFrZzMZUlWQXadQfTbU42Ojq+yFByzI4p8xL4P7RVN0qVAN2FC78qPyURdGL6mw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDTg9cPrJJ3hrnyZVnkhM9TfdGM3M7gQXttxdeEKfzcmM1yg5d
	e03WfRuQ6QpbfWNdZ0VzIKu0TzfcSjBGQAWpEGNPHs3n9OLWwrpQkf3rVw==
X-Gm-Gg: ASbGncsjTb14NBy1rVkjXx45azilKP07fMdKZYRcJM717AXvbSdGFPa7H7YmdYmfRBt
	aOaPN9k8ET2pYQuVhIrDPvA8UsafXvzWaZ+xp6yi8cQVpUhVVPY0mF9lf03hzXjux5VX2V4RWLJ
	hId3hLN6DQRQgm6PSuW/nVSxsiJ4SCMZ44eg7MZS+BWCCBl45xlcH6W08bxg3agpJxg9bOfzM38
	Jvyo7kRZfee2OVXRjtRyGjKLfIAbwzFxeZMOi6qfNR6YqUZURozO84IVoLeNMO+Fxgl7W+iumtE
	CzPSUBXcxW6YrLCFvRVP2xiGEZNxtrC06w==
X-Google-Smtp-Source: AGHT+IEqkRquqipvlb3C01p0zAq874yy6Y6uF8yBPnALa/jMfkJM6yCw7Pfh+F9Q/nI1in4ypwpSMQ==
X-Received: by 2002:a05:6000:188b:b0:38d:b7dc:30b8 with SMTP id ffacd0b85a97d-38dbb2cf5b8mr1980603f8f.18.1738834035501;
        Thu, 06 Feb 2025 01:27:15 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:c428:5404:970c:34c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391dca004esm12832585e9.13.2025.02.06.01.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 01:27:14 -0800 (PST)
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
Subject: [PATCH net-next v3 03/10] tools/net/ynl: support rendering C array members to strings
Date: Thu,  6 Feb 2025 09:26:51 +0000
Message-ID: <20250206092658.1383-4-donald.hunter@gmail.com>
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

The nl80211 family encodes the list of supported ciphers as a C array of
u32 values. Add support for translating arrays of scalars into strings
for enum names and display hints.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
Acked-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/lib/ynl.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index b73e07f1f60c..62ce3340796f 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -627,6 +627,11 @@ class YnlFamily(SpecFamily):
             decoded = self._decode_struct(attr.raw, attr_spec.struct_name)
         elif attr_spec.sub_type:
             decoded = attr.as_c_array(attr_spec.sub_type)
+            if 'enum' in attr_spec:
+                decoded = [ self._decode_enum(x, attr_spec) for x in decoded ]
+            elif attr_spec.display_hint:
+                decoded = [ self._formatted_string(x, attr_spec.display_hint)
+                            for x in decoded ]
         else:
             decoded = attr.as_bin()
             if attr_spec.display_hint:
-- 
2.48.1


