Return-Path: <linux-wireless+bounces-21712-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5267A931FB
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 08:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAD7C8E10A2
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 06:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBB8268C43;
	Fri, 18 Apr 2025 06:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9Q+hy3f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D65C2676C9;
	Fri, 18 Apr 2025 06:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744957789; cv=none; b=e1NhBPdJdAMzvc04AfoGrjn01w6wbjrajAuxVvkWzGaqEnOvlB+qBwA1AWt+Nnu2Yy3AH8ykw9qQcpQv4OnjHh+CN9ze+i+zU95kE3nutBUNuv4C5E37+PkaFwg6xI6AweQmCutNAhMjJKpzj9q0SCg6EYoRh8nUkCazCVmC54s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744957789; c=relaxed/simple;
	bh=l3uICcf4YlI9AQIJ+j9ywpBOupoSEFmYOvYrcfvb494=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=junYHGjorL7I+0n4fYYJbhAA7+E/nRV0NkodNN6buaKd05joPt2PeUTwEXmUH8D4KcdYX8pg4G461DJIYBIQCX8nOrrC4DW8dfrbRXhykFoOu63D0EU+EBKFNlQ5aqp0FaOajYBQmRAGd1RundCQuQi1WOPOe/95nNTSVSiJ7Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9Q+hy3f; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-227b828de00so17182165ad.1;
        Thu, 17 Apr 2025 23:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744957786; x=1745562586; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i3lgEK+yHakx5+7OB0w9oKjp68pG7EX8aN/iZxjl35o=;
        b=Q9Q+hy3fTPgPvvwNQuYO0/9vNBEkQtf/gK+uJuXQdNc8QmIFIdzQc51l+7Sqo3FTx0
         P1WpJk6HO5wzgivnw+SCRWZl1rXSRcRL2bJnykhzkk5yMy8o4NKYnUxNSTIkK6zmmfNt
         hX0qPrKe4EZEJGInXC4o3wWe2s/Y9u8T6fSIa3QlJzKvgLwPur/un6qnsJuhmx5DuXUG
         PG6XgiGgPWWWPP7KAvngpQXOeiUg8UDQ5o/9Ng21WxBrvbXWAPUAPErmexsghfsR1DND
         +ZgXC625qG0qdlwJoLpdne6FMDBb7+SoN6/Pj9/m2tyTNngEyujJSNoyRys2RPrlSGAt
         Qw2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744957786; x=1745562586;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i3lgEK+yHakx5+7OB0w9oKjp68pG7EX8aN/iZxjl35o=;
        b=eEs2aXQ3iWtiVocYbSezd+tbcGMzx5kZqbF7EdH5vR6dg1VQ8L6BYR9jFspI3er7Gd
         uwx/yWrN7Nj5/S1oi1bV0l3mD68547JOhF6yx4LF4Z5lwqazfqzt07FAU9wb/9PmMeRd
         L21YaNstd6JmbdhvGY4VoQgzbLgLbihHzxg6jDPHWvklsNzVG2KX+gmW08B8uspuv2EU
         LTBNxA635MRuu9IXMcjpxOQ11Y+/IzWfomMpDWdTZOxUVJ09djaotz1iiHX/yrZoVxQB
         OtjGsm/oqaHy/i+Q58VOKzqClH1af0eVohD71CiAyRzjB/+74mWguuRKAxkAn+MBFAfg
         gqyQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7xc6gDYoN4p6lAhCOJnxBlFtyb3PBrlpsjX18qgoQK4qWIa8tzXtA4vSiWkXU6c/CehLyq4Nl2WaiQeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGb1qbHK5/ZvyJMZi7tw9mEgV0/SHBxfUMMOx0CVLH+BW1jbHg
	widsNNZZCV1hf6UxmIFCUSc1oGizwFOxlsrQ5hTMLDqQl5cp0CxwV2z46Q==
X-Gm-Gg: ASbGnctoIDecgtLzLpVPpOvCCz8CwoVBbHznrvcOmGEmhwP6rfBMc8d4ZHGEkTGi/u8
	gIhFGTltXz5OYmGzm7KXnBJR9Y4561ca1djfUJ42LkXYjp4JgcK/7fgQbS4VwyTxYcr/a0ROMZ+
	6qJm0csW2ZXbUyLHMLXt2IDORMqMusU81GTdVBGMd9msDBZSoi0HLcE2uytgTz/okIMnD8HTtkj
	YnZa5vRwxU7C+lsV+9fwjpG25HHkjzqhtQ1moyNvbvBvZ0bNQ6lahq2mPp1vevV57JQPWBVmpEP
	NG4LyzQ903ACjpU4ny1Evmd6myg41g+OGf9Ymyi6
X-Google-Smtp-Source: AGHT+IEkGg0fjfvzhxs42Zb6yyWZJhSzRS76aRvKDk/4IvwkXqHM3idm3/54AaBd/4AWoEWp7UAANw==
X-Received: by 2002:a17:903:22c9:b0:220:ff3f:6cc0 with SMTP id d9443c01a7336-22c536080bemr28824105ad.38.1744957786252;
        Thu, 17 Apr 2025 23:29:46 -0700 (PDT)
Received: from [192.168.1.26] ([181.91.133.137])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50fdb97esm10136155ad.219.2025.04.17.23.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 23:29:45 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Fri, 18 Apr 2025 03:29:37 -0300
Subject: [PATCH v2] wifi: iwlwifi: pcie: Fix match condition in
 iwl_pci_find_dev_info()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250418-probe-fix-v2-1-ec1ef2d8a534@gmail.com>
X-B4-Tracking: v=1; b=H4sIAFDxAWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDI1MDE0ML3YKi/KRU3bTMCt00IwuDZAvDZCNzYyMloPqColSgMNis6NjaWgB
 Nk98JWwAAAA==
X-Change-ID: 20250418-probe-fix-f280c81c2732
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>, 
 Johannes Berg <johannes.berg@intel.com>, 
 Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.2

Fix the following regression:

iwlwifi: No config found for PCI dev 2725/1674, rev=0x420, rfid=0x10d000
iwlwifi 0000:3b:00.0: probe with driver iwlwifi failed with error -22

Which happens due to an extra `!` when matching `dev_info` while
probing.

Fixes: 75a3313f52b7 ("wifi: iwlwifi: make no_160 more generic")
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
Hi all,

After testing Linux v6.15-rc1 I found that my wifi card was failing to
probe. This is a major regression which leaves me without wifi and is
still present in Linux v6.15-rc2.

Bisecting led to:

first bad commit: [75a3313f52b7] wifi: iwlwifi: make no_160 more generic

in which I found this this `!` typo.

I already sent a fix for this (v1), but it probably ended up in spam due
to a bad DKIM signature.

This patch is based on the for-next branch of the wireless/wireless.git
tree.
---
Changes since v1:
  - Heavily reword commit message to be more clear
  - Link: https://lore.kernel.org/r/20250329-wifi-fix-v1-1-d6360e78f091@gmail.com/
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 93446c37400814e2c27ddd2fe93136862fcf4eee..555323341e7d6d7b94e29b4b4530b056bf6433ec 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1449,7 +1449,7 @@ iwl_pci_find_dev_info(u16 device, u16 subsystem_device,
 		 * !bw_limit to have a match.
 		 */
 		if (dev_info->bw_limit != IWL_CFG_BW_ANY &&
-		    (dev_info->bw_limit == IWL_CFG_BW_NO_LIM) == !!bw_limit)
+		    (dev_info->bw_limit == IWL_CFG_BW_NO_LIM) == !bw_limit)
 			continue;
 
 		if (dev_info->cores != (u8)IWL_CFG_ANY &&

---
base-commit: 0937cb5f345c79d702b4d0d744e2a2529b551cb2
change-id: 20250418-probe-fix-f280c81c2732

Best regards,
-- 
 ~ Kurt


