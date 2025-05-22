Return-Path: <linux-wireless+bounces-23322-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99849AC1395
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 20:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A314CA23456
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 18:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3694B1DF987;
	Thu, 22 May 2025 18:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBC84nGw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF8A1DE8B3;
	Thu, 22 May 2025 18:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747939524; cv=none; b=BYAVbtrR9fBvKjfS0SJnGLCgFvwqrt13YY1h00Sz3G0IvPn1SqqWmAerDXWcwbVJLqIM131p/yDUJIqJ7RHE2fB85f1N18HCtoGBQz2z47a+5lCfcMYGrH4Romlr802XuyIbtl2X48i6fl0alBe8X9D4TohJmT6ZDwRIv9FJLKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747939524; c=relaxed/simple;
	bh=GHzj+vhP0IH7AazDd4aDDdmVsDEWratUTV7OerNI/8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lVZaB7tEgUU1ojEUrs+NI10b8v2UWNM5KYZ5pHh7ZQgyKgFMa0bugjr4B+GR36ytJTMy5cWBoczvomsFO84C96pBc3EC/3kxXbF7zvu4owEWz9zcvNtS81S1AFnmKWzbodhO0uZpuWBpi6MA9sUOOUGkrRVkkcqV84IbZzkoBHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBC84nGw; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7370a2d1981so6345336b3a.2;
        Thu, 22 May 2025 11:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747939521; x=1748544321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQ+RqlSFyQLSDHWP9kEu2/DGiQBnqF1j/beqMyydt5w=;
        b=nBC84nGwwk8wkceg3QDP5PAn3/Zj+3BK+nHodbbFhSR60n+rJIxG7trtXQpNTVkwdQ
         Yx/JXM9T23+hcrznq7gWVkt5MUUg4kSTJsT2jzJeaeXidfUkmSd2jvx27Lkr4xg4oEjG
         mmTj3uCtGTU/7bHCLwTDv8x/9X2/Zr6Rj9ypE59WSvNB/QntGF37m6DLSixLsjkdX/Om
         2XomhOS/2bUyMuU9+eX1tPmuzyY98nOirIKvEbePNasZ2hwg0Y9G0KGSvGm0M9+B4Lpp
         73WwyqzK3febk7uV7Taw0vJFK4uGOTDCk/C8EHCIdXItJ6ApHR1q/oRx6St5DGnNhV0V
         iu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747939521; x=1748544321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQ+RqlSFyQLSDHWP9kEu2/DGiQBnqF1j/beqMyydt5w=;
        b=hNHZHMQPvHYydI4cHGv7eVH7m8w6Ru5zK34NLY7pywIWIJno9t7gJsaAfVh0B3K9wF
         tuLkTkDw/kQ4BeQobs5jassVBzHnijL/r777OfFD6JdB2uhtXxhKB5zHMdrx3+/VBId9
         J1DpJIX4rmPc9svgx1yT2Wo9cNvUptynFBlu0Boe2rhWhc4TLYgPvVFJ8PJZzZpi3jt/
         r3yxIKrq3Oo6+FjwT2rVbemy5m9F9+B5W84+stoIxnLT6tLft1ekXAP1yhoFhvQ1ah85
         AR6dI934Pb15dLrEwhTpqu71e1RmH8LjkuSM6vtBav8bHWsnL6AzeqDUKXfdxcfnkcdu
         bl/w==
X-Forwarded-Encrypted: i=1; AJvYcCWU40WV0ucreFc7ynHtEzOG0M8TPalTMz/JD3Zs4LWGY0AEfo051+2Xoj1OyPCVq2w8YExFezsG3/sT@vger.kernel.org, AJvYcCWvRYOXcVG68zkoPQzorQykbYW7uGml7LyKsVQ0We2ymEPywbF/tlSxNlYmrBDpHgkzjtDJBfL63lw3iA==@vger.kernel.org, AJvYcCXwDWsuzXGmMt1Eul+lDT/RO04S93SZe1UmWnUS6cE6z3UbpwpRa/0oKM2S72Q4Flqc3sQHQwudBNSvM68G@vger.kernel.org
X-Gm-Message-State: AOJu0YwRg6b/4jNRF9tIudOzTAAbn5/2V+j7otgdRVIjkqZwe+XK1HRB
	vm1Sa2qkdNJvQAUX37Ykd8nbWf5M5tYuMmFW7rxwIA8nuqOr8wfu4K9aG+awWQ==
X-Gm-Gg: ASbGnculRNtY/hA7knZp/f/AF2LLpUPNQzrHJvrJp53mOy7gkJQ26MSQA+tGJGTAMZg
	blPQyuvSIEG8uM/SaOH2B47EARkG3tDp1p/gSCn5BFosXWp+Xm8KmphCIDrZMGyVDu1718r8DDR
	igztZnJn8ZlJL3KTZBLdyPA6BGgi9i4/rDuzyl+GBHlYACzV+wx/omniNYtsarr+2B2pWVYozky
	kS/XCrjGc7Uy7Vp1TH2ES89R3XfKMaCWAEdaWxPITeCsE4o2VBrwg61IAibC2AFRMUbKgUF2whD
	bihPzh9O9ggOC0iDWY09bTUHG5U=
X-Google-Smtp-Source: AGHT+IFa81NdOeK77JwCSKZuNJse+tfYbbLCdqfdf2Wn/Fnuu9YaiowO4qBpBtUTK9rN+4Pio7xChw==
X-Received: by 2002:a05:6a00:e0e:b0:736:9f20:a175 with SMTP id d2e1a72fcca58-742acc8d8f4mr35635536b3a.2.1747939521408;
        Thu, 22 May 2025 11:45:21 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eaf6fd3bsm11502424a12.23.2025.05.22.11.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 11:45:20 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	linux-mips@vger.kernel.org (open list:MIPS)
Subject: [PATCHv2 2/5] wifi: ath9k: ahb: reorder includes
Date: Thu, 22 May 2025 11:45:13 -0700
Message-ID: <20250522184516.13176-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250522184516.13176-1-rosenp@gmail.com>
References: <20250522184516.13176-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Alphabetic includes are easier to look at and to make further changes to
them.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/ath/ath9k/ahb.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ahb.c b/drivers/net/wireless/ath/ath9k/ahb.c
index d2a97e74f451..1ffec827ed87 100644
--- a/drivers/net/wireless/ath/ath9k/ahb.c
+++ b/drivers/net/wireless/ath/ath9k/ahb.c
@@ -16,10 +16,11 @@
  * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
 #include <linux/nl80211.h>
 #include <linux/platform_device.h>
-#include <linux/module.h>
-#include <linux/mod_devicetable.h>
+
 #include "ath9k.h"
 
 static const struct platform_device_id ath9k_platform_id_table[] = {
-- 
2.49.0


