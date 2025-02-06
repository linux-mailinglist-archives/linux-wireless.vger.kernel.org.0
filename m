Return-Path: <linux-wireless+bounces-18583-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9734AA2A446
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 10:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF035163F9A
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 09:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A408227564;
	Thu,  6 Feb 2025 09:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpiqV75Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED0722686D;
	Thu,  6 Feb 2025 09:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738834043; cv=none; b=M75ViujFUGjuXDvrXYC6/p8VhI8Xpb+6HC8b9EO+q3hi9LACpG36nzIw8Bd2TvEdZeyPAuzoKb9KZeCjM3upM3O6RZaNBA2f65iEu9W6VyDZ8AO6xYsr/xZTQipJpHL7Ps7NeqLbIUHrL9ydAb+FlScda6cedQ9lo6K6nc7sV24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738834043; c=relaxed/simple;
	bh=fuqRzmevS9IAnW4Wt7PbWYeJ5MrRmH47PylvWWHflJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l8azDr9tIYDVYGa4T73sm7IE35VJVqpQ+QLrWYXdQWtK/jFG4t4zkj5dt+mV60O9LK2/jx3HQ6m9IvCcWERtJzOZReH0lRK0S1cU7mJiriTnLXbDLWthD8Cbyc7qYOdqgwSRSwG7+3frk9jmauuFSlbn3HNip8yPuK/FlmVwjEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpiqV75Z; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-435f8f29f8aso4248325e9.2;
        Thu, 06 Feb 2025 01:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738834040; x=1739438840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZD1A+FuJcFmQYzWvA7e1aKpjVc6S9z2H4uwtlJoHi/I=;
        b=JpiqV75ZGAoMmMIgM04T5tVs8cnvRJZ1snbAUQYJdsI3E3oj61zipmiNPQ0ivwCQmu
         oRjlZlDr+w0wsZpMTgNtwJFQ1rCxDbhrEekTh28/+l5DcTC3sx0Ju3fkInam4kfiMjAC
         0Mgl1Zi4Yz8hb5V/obdB4yBPWj+UTL8Qqf/n8pL7EvV7peG8925O5EKnnitiKjeoZDpx
         q9B4qfIVixz1Leq177l2ZDNooTIDiWoYUpR9ZDGeyK/Bmojqi3tHVWgL3nZ50+Bcqg0a
         D2uUMksntgD60+xzQG7qsncuxCLvzEJOjTjIOgdjRk5RKcL9ZHQd01TYUU0MXnl67tBr
         0z+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738834040; x=1739438840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZD1A+FuJcFmQYzWvA7e1aKpjVc6S9z2H4uwtlJoHi/I=;
        b=whsuRvxp6PTZ8sd1Gsx9WvCXCODj7KpVNQCMD70SX/yxCAptNoCvFZ+vbpJ4CZzZfk
         VXdszYX2JybyH8J/ki32FkuWeMYfd/PtTz0krITKNYoLH2LXAIILXMiRaNW850QCA8P1
         x4H9XKHDyfKdCbF4aNjqyv8JAue4lIU9tu5xvc9A0mL+CZ6P1alB4pQyxOJf4qD22FKA
         6QHkSOvaOdV1nYAXbpOcNvegOVzFiqUFEkHVcDvT2oMzyT+sV4NrUE+ahJ3eBQ5gKBix
         BiBnfDHchVPaYYkEZy5nrtgdB44eM+zXIYtekYmIO4fPXMBa0dw+lnCqA0OXO4hthSXS
         pR9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXof3b+RE3HWQjdfLI5jbJUY+54jAyMAzBb7QK6zwZulvlWMNdbEQ6ajmI9E18btN6kfu8NWgfiYsLAQifIOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyotKcQwfw1uhHEncpTtLwhVEksRBmrXKv8VLw31OYxf95rI9GG
	BGILArPKnraUmaVQw3i4df3diIwwlUJQl2oWxSPhBdkUZLWVcio/EDlx3g==
X-Gm-Gg: ASbGncuZYaPAHnldCS6+VMmTPfnLmspn9kJj2EPQvmBHpE98fZYKRVOyIS80kMVJ9xm
	+DQToBBlMt7zuG2w5Dhk5RfK18O4MrkDr7znNEeKDu0+GX/LGM5mGzRUy6BCtKXll01SJvfALJf
	IILwpdH3Ex7lr426dj3MeX/qrlAJr9L7Y7CUU4U+bR/uE4aRo5vYJy4HE5QmdswiaUBFJxVwtsH
	ra30Mbcsit/Cv7peCqV1Oij3lDQbjMxt486GcV4k2779/dA1K6E3nIXvpqGWiuyCM3GPZB2Y+GQ
	BTfHIjHBwOIcOSFqu6SmFZAUDpQ18xaxxw==
X-Google-Smtp-Source: AGHT+IE2+vk6Rfl6Eu++lPJgFtF1FpwcfABD6MXwx6nAD6CU7x+IK4w9PgGkbatzHQXdJVujedD3Yw==
X-Received: by 2002:a05:600c:19d4:b0:434:fdbc:5cf7 with SMTP id 5b1f17b1804b1-4390d56ccb4mr47840195e9.27.1738834039682;
        Thu, 06 Feb 2025 01:27:19 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:c428:5404:970c:34c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391dca004esm12832585e9.13.2025.02.06.01.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 01:27:18 -0800 (PST)
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
Subject: [PATCH net-next v3 06/10] tools/net/ynl: sanitise enums with leading digits in ynl-gen-c
Date: Thu,  6 Feb 2025 09:26:54 +0000
Message-ID: <20250206092658.1383-7-donald.hunter@gmail.com>
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

Turn attribute names with leading digits into valid C names by
prepending an underscore, e.g. 5ghz -> _5ghz

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 803d49bf7c33..1316a4fe798a 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -45,6 +45,8 @@ class BaseNlLib:
 
 
 class Type(SpecAttr):
+    starts_with_digit = re.compile(r"^\d")
+
     def __init__(self, family, attr_set, attr, value):
         super().__init__(family, attr_set, attr, value)
 
@@ -74,6 +76,8 @@ class Type(SpecAttr):
         self.c_name = c_lower(self.name)
         if self.c_name in _C_KW:
             self.c_name += '_'
+        if self.starts_with_digit.match(self.c_name):
+            self.c_name = '_' + self.c_name
 
         # Added by resolve():
         self.enum_name = None
-- 
2.48.1


