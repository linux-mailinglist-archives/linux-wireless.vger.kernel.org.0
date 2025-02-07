Return-Path: <linux-wireless+bounces-18625-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6322FA2C25C
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 13:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CE2E7A4095
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 12:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F801F37C3;
	Fri,  7 Feb 2025 12:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQ0IE+lC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EDC7FD;
	Fri,  7 Feb 2025 12:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738930530; cv=none; b=bHdlVNSGzb1wP/MU8ECHq9HhUtoYmxivgEGMSA+SuDOgm8vMQzqDC70hZpbWb3SuACuyhEU66DrR+e+SBUdmlXFZu7V9lwrtoUdheZyWJLE3r1gLfiB2Gdc+8lQs7JMkT/cCDZslxxxOcH1q/SC4PwpXIJ6pZVfoxBlqwSF9Tic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738930530; c=relaxed/simple;
	bh=mqg6oVlWZ9lRgDBEDIBhvqT0sf/xJPxaAUpGR6KqHlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hWh9kF2oKqjw4FJHKWzkodv9v/WaAojJYV39krvXH3mnO0yaNjgR+QOHTY6XQaosS/h/77S18vP/QW8x23J3DaixcGf2Cm9ZNOnd7/QgQ0aSoC8jnnIXPZZCMljfUD/cGl4gdUX6E2Wvp0vyB4I/tQQDRhYku2jiyQfqquX2z0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQ0IE+lC; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4368a293339so21625975e9.3;
        Fri, 07 Feb 2025 04:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738930526; x=1739535326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6J3x9ECyGCGYGUhtbd3ZOh/doI+iGAkp8K9XPCCmug4=;
        b=kQ0IE+lCKkhXFt30l48rD8U0lNHTa8inCzKZJ5KqeTTqFZNfmkt65VSJori+Z4i4HJ
         pvO+qG3bLVNIe1KWMAQc6IFXW808xcExRhpybik4A5NFdS0jOnst4CoI6m/EfiI3ZksM
         nSeytHa/x/qMFjIno58uF9+86sNSgETXP7NXtihYjgh9Jz3Y939WdPsWdflOqF8Yqp/Q
         +uwtrbw+jn/wLmDgd0WPe3zw0zhSlcjQkCNHDGEnz8ymv/Gn6+apy2XsUsSGTXUKtblQ
         ajsmfh77tMO0Ys0NX7OuZDoT+LCtDZ6jZIMiJoWOgLh1y5ld8lGUFSsmdax8PA9jGDbm
         W1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738930526; x=1739535326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6J3x9ECyGCGYGUhtbd3ZOh/doI+iGAkp8K9XPCCmug4=;
        b=uUNnPyUziUxFhsgjtuJk6JNoCGA/a+gRT6V2/Cen+4PHXf3FF3xkF75S4q9ZX7KStm
         4L7I+hunhbg4gduYzW+JUC3mIjDrq+qTdhzlRxH64jPKANINmAv6HcjZevCs9LaefAK/
         TdVVO5gdvRRepPaB6zE3RJH71r9DEwMKl1dcvhep+hz6V/deFNyANa5ICq8ItjXzgnFW
         EmD8fcrfqhz5xbTR3ZlTbFjaDLHW5WAg22T0LXEd/F1jPAhqzl2vxBb7Ku5E05kD4Ahm
         3FlF4VrIGOarsuW0p5zKhv3lpSH0OUACam2j27yLU8sDSw9MKIugsZsreK15zI5afT9Z
         gb7g==
X-Forwarded-Encrypted: i=1; AJvYcCVyVQfBK/+oJo5Bhf8EwgUVe4wv4aPS4G6F/xKsCr2Gf/v4C6NSmWO9r+q60EtqHSslWpElyc8bMmix0p1DeQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhTi3GooQ6EfX6moLXqL1KNzvhlW1vDhZpyCBshA+6+albziDG
	ReRFzxHHgbIUMcfK15ISPMnLCMkRnVcaQTcFiOC5Glu6+68/7Xtramfrrw==
X-Gm-Gg: ASbGncvrfGA4UjijYj7oDelN5XV3jwsYFns4jC6LMhGjDV/WluJsIozXq1Z9Q+YJZwh
	+2L7LMXOeXNwM6kTFGeovLWcadsjVsWWLEMgitD1wiumd/aoCA+O5Z2cHVWasga6BtZ0BqgCtl8
	aD3d/4Q6HzENyOqnxtWbTrmb9zo5IO50iseoVVBfyXAbjeOqeS0wEZl2b4a47+EJ7nF5dsIywzO
	TeBFDkUw/5vmtsB2YclcguZWqfB/xTgA/tAIvmQTNMP+mKOMzBQ72mcsBvaxewGlUDsz7+SlnTo
	/X18AVRVOCtHqiSg1Di2MDrdSjvbqKXJRw==
X-Google-Smtp-Source: AGHT+IFQOJnrpZr9ab+5B1imc5GU6/Mf7q/0n2DKhBVYmkW8KvS4WXnGg/qLj+BTtkVK+9lIJJriUQ==
X-Received: by 2002:a05:600c:4f47:b0:434:fff1:1ade with SMTP id 5b1f17b1804b1-43924991dfdmr26157965e9.13.1738930526385;
        Fri, 07 Feb 2025 04:15:26 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:ac43:c7d9:c802:8ec3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391dfc87d2sm51555035e9.26.2025.02.07.04.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 04:15:25 -0800 (PST)
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
Subject: [PATCH net-next v4 06/10] tools/net/ynl: sanitise enums with leading digits in ynl-gen-c
Date: Fri,  7 Feb 2025 12:15:03 +0000
Message-ID: <20250207121507.94221-7-donald.hunter@gmail.com>
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

Turn attribute names with leading digits into valid C names by
prepending an underscore, e.g. 5ghz -> _5ghz

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
Acked-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index d8fdee24ce25..62a6d8c93765 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -74,6 +74,8 @@ class Type(SpecAttr):
         self.c_name = c_lower(self.name)
         if self.c_name in _C_KW:
             self.c_name += '_'
+        if self.c_name[0].isdigit():
+            self.c_name = '_' + self.c_name
 
         # Added by resolve():
         self.enum_name = None
-- 
2.48.1


