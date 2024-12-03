Return-Path: <linux-wireless+bounces-15854-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B58E9E1D0F
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 14:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20EC3283186
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 13:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C831F12EF;
	Tue,  3 Dec 2024 13:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnJTXHgE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705871EF088;
	Tue,  3 Dec 2024 13:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733231230; cv=none; b=Mh2Wv0lV+h91gsJhMTrc6i1DYvffKvWQBlbSmm6r8HU9hL4s6eRSSbUar4OIX6Zc/WpFOqJtyMYvJm97rqgeQcis4Mqtstt551WHOU982egxFW1dhoIfeFKN3oi5Vi5ntnos6TK0/UnbUD0YnFPHG+2XKAxLcV16DmamY1xBsfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733231230; c=relaxed/simple;
	bh=Zbvud21fvPTfsWLg0fKDiceEnRnQedaZmCmnDlvhCrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JjvzQlc/nfKLL7AwWrFmdSgQo8lYhv3KyadiPdAZbTf0rT0HzW/Wd8pUQGM2SiwLFshG1Eyb/CVPe6CpDjmaMNQ7Zb+6c7aynvAenBU8/bEZ1wIGMd26eGKrPap+ex4zhk2lV65f/N2wDwEgavrSEnn9tEUJdIsp5fVarU4Rxq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnJTXHgE; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53de880c77eso6495077e87.1;
        Tue, 03 Dec 2024 05:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733231226; x=1733836026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buXVk8Hv0kt/O2Pm0xs8UjTJcv25AHmCbOmE4In2eHw=;
        b=nnJTXHgEBkcPpL/NveQyG9A2lFFoUNLIFxWfTG5TGu4oWst8bORT7DLDKDdJnJjhVn
         emHWYjhUZX6dPaZIsF2YH/CzOFqA1AgSe7qUOZInzxKvUWcN5fo0j5M9KNtMrPXNi4jc
         Af2KYQeUK7JYSVjy4fRBq6Uld/XKgz9wIH9eZfxAQYvx3bxk48rfX9kiwRAdd3X/mqir
         MPQ3xtQ03G8u48Ai5/bWP6GSeohNNsB3YC0V+WCX+pEH7/o4nhTpXwHpuM9S+kiAclCL
         QIE3rlAVe9mUB1yicMI1ajye+mACMbUMC1IoqehgFYmXKNq1mxw8PuuL7UXGzQHtb0AC
         lf7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733231226; x=1733836026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=buXVk8Hv0kt/O2Pm0xs8UjTJcv25AHmCbOmE4In2eHw=;
        b=MW/KR2HiLjso/VHiC9NnRtt6avW+hQeRpy+WQpqVBU+Cah/8HHMznCyoGcurUdxSSa
         d445XZ5CI7SjnrMcKVyO7gtxe6kIZshcJZ3JsrUJgV0mIK+DZxy8FgdcJos5Kzx+9dpd
         v/W7NIXwovMuKvd5Wy+Yvo4E87ySQ9Rk/SAD+xsH6P+iix6KzKneZbx4zIoZyN0LvT3s
         Wy6GMw92G6K+rbwmOufqsfrbMcFKZ+A/OKMeRAR1VtgyrI66z8YRhQkXZ3BH6k8eWXsd
         YDbaiJAam0CH2EcClN0dVIdQtu+aPgUjGvXtr9bZ01vqblH6GbmP4T1XTFfzBYSlkZDj
         6moA==
X-Forwarded-Encrypted: i=1; AJvYcCXEx13yv+lWH1LrrCHQdOISzTAD4PQmE085pY6yszCLQWpWu2HxjD0r8dw7toPYFV0ofAJtB68gDWEzT/pB/g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1hgLWWF1KOFSHqKlZB7VpnctI6yumifGiaRqXYTys9OTOC8Ej
	DYFEjheUB3F7fKLfvgMrvrq8+vJsCJTugFWeZcVCbqdW6Ki+r5Ee5DyIVA==
X-Gm-Gg: ASbGncsEQ6chnWP0ImgNj9o9Hs5PtGg9/YjIukqVAYxFlPt5+3I+QxT/4aUQHNmk2ZT
	TS4jsO6abcUqx4mxNbWruj7GJh7grW4u7GHyDkSBMmzC2FNAf/r3uhWIjJbJ72VKzKEvdDUglpr
	NMyOXqPs+Rq/DSPgmaV/6RKC7jr5NJSrFbI0zK2nhCwKW+TZq+slSKgRwgp7NkxGNyhx70paur5
	qG+mwYQwnLKYF3N8b81b/3Ru+3X5TAeHp4EFYFhtDDOgLrPesMxa9yuet2LXHHLfgA=
X-Google-Smtp-Source: AGHT+IGukEgpLiClvbipukCEB+/pOxRsxzkUlGv3sUB/RCeIp9AAjngYO2qZNgD+rM2ofsjn5bR14w==
X-Received: by 2002:a05:6512:128b:b0:539:8a9a:4e63 with SMTP id 2adb3069b0e04-53e12a21812mr1352431e87.42.1733231225687;
        Tue, 03 Dec 2024 05:07:05 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:6140:2ef3:aaa:55ca])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7e4d42sm219142365e9.37.2024.12.03.05.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 05:07:05 -0800 (PST)
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
Subject: [PATCH net-next v1 3/7] tools/net/ynl: support decoding C arrays as enums
Date: Tue,  3 Dec 2024 13:06:51 +0000
Message-ID: <20241203130655.45293-4-donald.hunter@gmail.com>
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

The nl80211 family encodes the list of supported ciphers as a C array of
u32 values. Add support for translating arrays of scalars into enum
names.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/lib/ynl.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 0d39a83574d5..f07a8404f71a 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -627,6 +627,8 @@ class YnlFamily(SpecFamily):
             decoded = self._decode_struct(attr.raw, attr_spec.struct_name)
         elif attr_spec.sub_type:
             decoded = attr.as_c_array(attr_spec.sub_type)
+            if 'enum' in attr_spec:
+                decoded = [ self._decode_enum(x, attr_spec) for x in decoded]
         else:
             decoded = attr.as_bin()
             if attr_spec.display_hint:
-- 
2.47.1


