Return-Path: <linux-wireless+bounces-23349-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9BCAC1D15
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 08:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CE261BA5F42
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 06:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E1725D91C;
	Fri, 23 May 2025 06:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fl4DkD2t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598211A76BB;
	Fri, 23 May 2025 06:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747981945; cv=none; b=DsVLurPp4oRP6rvIhk2WdI3eEwtVqkP5WROvG8Hx4vyP5U5AcX8HwEsxm+7YbiyuuAdEjqevVb6Z+0zg+hlyNlqWcF9Ximobb71fLu9biwdE1tLME0Td/fehvaTitgIES5bz4rMrwEGpeWMJUnfZZeDobGwjXZxb+k2TJGMRC90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747981945; c=relaxed/simple;
	bh=GHzj+vhP0IH7AazDd4aDDdmVsDEWratUTV7OerNI/8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EXOIK6fI0vjSysf73ekfzDeFo9FUl2hIUWK9g/X/gAgsB2NLEoLbD7jgQPVkj/Jy/6qZakYTBeiI35Vd8p6uZxjJ/lHClmwbHuaCNGZiqa/Gm3ly6xdzHiMCStK+igkdWMM37ftN9YqWdLqiuAvywM61dqbiIhEIzjcbH3U+XjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fl4DkD2t; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3fea67e64caso6416674b6e.2;
        Thu, 22 May 2025 23:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747981943; x=1748586743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQ+RqlSFyQLSDHWP9kEu2/DGiQBnqF1j/beqMyydt5w=;
        b=fl4DkD2tcpNyJBWoj9N32s337eLA/4QJedSieKirVWbZfwkBlc0qJkRWWAVS0hHmrt
         a57SK+5gShCHuqr1QqMRNJL4N0VXyFNM6SezaVcmaJkszhFEXuR3l/qkgI+wfeUpcgqv
         wNtfOGhqyhQp9vgJbRz0ZsuiNjQT3NEm4s5z4teKql7AqfpwiaLwEeWQULHnEf7XPS3e
         QzBl+6Nhg41S9zisJpsJO30xOzq+LNQX7Z3w+MSlj3FitCaxJUcc5UU3JidX1g6RDQx7
         OHAN4t19sNRxKFhRM7jGO4puQjxxzYuoXYNpsPymGHKZxdOUQwl1X3fsiB/Yg31pZ9/a
         e1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747981943; x=1748586743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQ+RqlSFyQLSDHWP9kEu2/DGiQBnqF1j/beqMyydt5w=;
        b=X0BzLF+AIfwEAHkrC9mEFhkhXG/CSUM5ttkWQVguVvuzuGA4V+/tFybTvxNenCIGYR
         BzjgNHEBVKPMdkPUb3beYDzh97awvL6SCeeNEH4InLOIqNQg1gplVjOjtj1FfbA9yCnx
         JuWPwIOtXR3g/RbDwhhHuBJIZkhu8KCu/FwgdW9UusLIWd8ZC2Eh4mwkVQgo4DtczThM
         0/ABOB69R+wCCdJlUN5/SPjjRJsWiuczhk6GdbOl+x18cWvqk7bXs4Kq4Z9mj8QxFdEO
         plr/HKo77Jup77lWrLgTz8te2X6oF8EDcx3MY7N5lbzhZ3qtSqG919tHyxHDQUS88HfE
         uRog==
X-Forwarded-Encrypted: i=1; AJvYcCUYKKUc9UdpKHhdEhzdeA/55wgFQ6j8V3ellxAUlxasmlaGu7lz7Kgi4OiO/ueMyyb8usJ6+VMr5K8+ewI0@vger.kernel.org, AJvYcCVe/xibO1moPl0qpJ3MlvHYF294GtmSKQOw0taaelD4T2o8D7NZy+wb4isGtaC2uQUqeOSujYCFVjLjqQ==@vger.kernel.org, AJvYcCXmXyMyEFs6RA2mDm2dDSyCbsVjica0zcVSTtlPzf8C8jUOma/iNsm+VxxO0tLp5TogNHyKACuXU/O/@vger.kernel.org
X-Gm-Message-State: AOJu0YyHjy/dYHsXj2Q9A5oAgAe6Vs0FoRVId3ubHo/YXmZ/gQJjfY5Z
	ewCZdbZXPurxbxvSinz91WWbES68LOES6Ky5NIgpy53IdI3xU1IaHphDkqG4bQ==
X-Gm-Gg: ASbGncugR1nvGvN1/BenTjrdKZHgQF5rZRpOMpAtKWysOMjZefjo4GNIahGnPXmUEbs
	jayF7bXwD/Y4Z1yMsMDl7UWQ9Yg2nTQIGV2VOahk1Xr3lvoOs1QSFSB5leFnztU4f8nkJ/I3BnX
	gOQU9fKMS+hXrdhhAsFLjO+ejW879D4jX560z5qyX422iRkqx6agb36HtP2bgysO0IcrWIohy68
	9qayD11KHJjA9vNcPbA1JMOpHfVYiDxeqF7XbWy9SDudWexyUlQQwBAlMd1yg6Un7VsD9K7jpbY
	RJPGlYENK8oKDyydoRd+mgPG7lo=
X-Google-Smtp-Source: AGHT+IGhnyWT9GvTWolu4b2fI6AfbQOl7Zyn8oBKkKaRYw2hxxcF6ho7p3hKkHjd6ugynOQBEUrCWA==
X-Received: by 2002:a05:6a00:b90:b0:740:9d7c:8f5c with SMTP id d2e1a72fcca58-745ed8f662cmr3137860b3a.18.1747981932622;
        Thu, 22 May 2025 23:32:12 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a97398f8sm12177783b3a.78.2025.05.22.23.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 23:32:12 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	nbd@ndb.name,
	Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	linux-mips@vger.kernel.org (open list:MIPS)
Subject: [PATCHv3 2/5] wifi: ath9k: ahb: reorder includes
Date: Thu, 22 May 2025 23:32:04 -0700
Message-ID: <20250523063207.10040-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250523063207.10040-1-rosenp@gmail.com>
References: <20250523063207.10040-1-rosenp@gmail.com>
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


