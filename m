Return-Path: <linux-wireless+bounces-18622-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4369A2C254
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 13:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 642213A7C48
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 12:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED781E98FC;
	Fri,  7 Feb 2025 12:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEO4uEuq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5048D1E1A23;
	Fri,  7 Feb 2025 12:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738930526; cv=none; b=QccZaY+KYoNSabq2aPWSp3xjrCzUyoYP9FvLbTkYlJ+dLnpdOLAxGvl806J0xgJdDaPzZba5TqN9/y+PepCBrV6y2RHqzsngWlD2pW/u9luPs6A7wmj0rKUQN1Y8JZxFwH0SO4Wcj2/HOJbll+YNLGShEHrHnQ5aMd0m+P4MabY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738930526; c=relaxed/simple;
	bh=1sXRpKRdwQWU3PDhHFw9zXhzGGi7++rZDL+a2/5+euE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bSfaWZLBMqTZR6wIfBYAXlXfdZANZJJDEkuPYLzZ/DNz/PnG+IQ5u4h3gG+0hKU3cmE3cc1kWeSuYWbz+DBS9UeDEar/IRwtnyAPblFy6vbqjsFnoJj5/cRHF8KPcyKTB0d+6SPjaNLkR0+Z7FZr8iuWj/ImzDknpV52J/PhzmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEO4uEuq; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43675b1155bso21646135e9.2;
        Fri, 07 Feb 2025 04:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738930522; x=1739535322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRuritwii5Exw4qc/zxuGeTLgpqDh2QQL5NTFCoOB4M=;
        b=WEO4uEuqnohA2oCarRF6NYDoxLtFmZnzbisva2ffQ31HFMgvfDuwX06N3/xgWQrvkA
         yFYAJXB6y1VBRue9D7qn6bUDJx1k/OoctqguSH++BSx4ME4ufDm5nERDSqI4OfuZXppJ
         Xh7JT2srQRmV9Twv2y+3cb5pIpjdzUHb5tHHsYnjeubJ2XDywq0BUmMXngRJaZX8iTKC
         US8QCYbFF3ii+i/spmOFWLQsnkIqovX+SahTHQBMakAE3o/kATxH/MdCmECf42Sqm8gu
         Mq2S+4yKAJiE1Y+oUwOt6G3Fsm+WHek8lSqKwA283nWDrwi31NlD16UqiXCi2OFe3hY6
         pwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738930522; x=1739535322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xRuritwii5Exw4qc/zxuGeTLgpqDh2QQL5NTFCoOB4M=;
        b=xO38oywGsJd9wcBOY4VoCvEQmp3Y4sn4PUVLEqpPvLWVbhu1IjH0h+XFPLV7XJM1oW
         CGauKEIAaO3X776m4KRDI9NBH/FM5XLU6b9l8EETswi4G4r4IJlQfVyuTxjIFbip811C
         FZaSyuL49YAgGyGjQ2olk+42WGrSft5/Dd/jmoa/t3zqpb/lEeHBOnkIVncjwQy7cQZ6
         tWZ+IDgMEXG9ANFreQKljLhDwj9NkUH/VMYXQbRqvGCGPCgcy1j/HjhWywXKVmk0MGnk
         V8ohq+sUn9VN/Qk4QybmjVn2KTW5moCjz7QJZGIdZX4Hz03+EA71qJBDgkG6QDbeTEmI
         RXxA==
X-Forwarded-Encrypted: i=1; AJvYcCWclXGrEy4AFbPjrlz99bIgm3AKnHNzxPAXLMPlLbEGBjHYCB6P/78qaejYCNsjTUXIuSJBlL80qW4M5REnVw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlQRwJxmueMKs0laM2e3JHQLKxcdDH4eHWNEFRrP/7NSJg8kGk
	5snOh0Zxpp4hYQD8l66/iRztRfvXio091rNOOMOyQ4jDOasVmY+5r6n2Zw==
X-Gm-Gg: ASbGncsftidbfSVE9g/otAXFgctNKxA4TP5B2mzE0TBEsh3IH2ABWKYBlUNvqnE5Vku
	P13B6M8dLY29wd1UQsoenZAhn8HGV/unv+LuWvQqzBCMQzJe+tbZyRkjFSSD/XSvLiazHBE3Pln
	g6ILDqbXBp5u3bmuH1+Is0bi31UygwqC0KHuR3AQyonJFzmI0iHEBUfI6EIE72m8/MMx5yfSkbX
	5eru4/ESHj2vQf6JkI41NR2bdk0dROUjvBYLjgCB0wjelRZH1pvgS5tH89Lvy650MPokxXB/jVj
	28xudUIXcdNaDxvPlhs+qdEmU7VhWWm8rw==
X-Google-Smtp-Source: AGHT+IHz9GSo007ugyZFbRRbbLa904lr5Ue+7CKUyZhE/OKFd+ni7Ct183hgV4AsUgQ5SjDP5cLjgw==
X-Received: by 2002:a05:600c:5114:b0:434:fd15:3adc with SMTP id 5b1f17b1804b1-439249bd4a8mr20891015e9.25.1738930522156;
        Fri, 07 Feb 2025 04:15:22 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:ac43:c7d9:c802:8ec3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391dfc87d2sm51555035e9.26.2025.02.07.04.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 04:15:21 -0800 (PST)
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
Subject: [PATCH net-next v4 03/10] tools/net/ynl: support rendering C array members to strings
Date: Fri,  7 Feb 2025 12:15:00 +0000
Message-ID: <20250207121507.94221-4-donald.hunter@gmail.com>
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


