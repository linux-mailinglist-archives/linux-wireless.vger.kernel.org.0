Return-Path: <linux-wireless+bounces-23386-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9322AAC3706
	for <lists+linux-wireless@lfdr.de>; Sun, 25 May 2025 23:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F6EF1730C7
	for <lists+linux-wireless@lfdr.de>; Sun, 25 May 2025 21:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084D31C6FE7;
	Sun, 25 May 2025 21:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dm2hJ6zm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B131B87EB;
	Sun, 25 May 2025 21:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748209383; cv=none; b=dBR4BTnM0vMpba12vqv2567pJ4mbKrjOKJ1m3tdFNQa90+HHpSaa3HffUf8HUNtDcHt4Wofzeph7bZYF9ZYdduW6+wXiApVyJeDO3N4qXnwk233LHJp+TnVBVWLqEhvACRJiKpqjf4hzbGr1GLeBzSfdRWAVGd0L18YbiJO0thw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748209383; c=relaxed/simple;
	bh=GHzj+vhP0IH7AazDd4aDDdmVsDEWratUTV7OerNI/8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kbpVnd1C67bJvjgS648YSPDuCE/QA+J8M/b3WHo5xkoobZBXNnrkSvco9cyg+wdGMzbF5JFaGK416FK1xdYFuU4mqisC7IDDqoACnBXylmDkWwF9FuxHBz3eoeAYu2kZ3iY7miH5cVWOrA6d282+KgqYDW0k8mJpNAmqfhUo/Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dm2hJ6zm; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23278ce78efso8495545ad.2;
        Sun, 25 May 2025 14:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748209381; x=1748814181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQ+RqlSFyQLSDHWP9kEu2/DGiQBnqF1j/beqMyydt5w=;
        b=Dm2hJ6zmlscoviMrAJeS+RtpeNWYaQPfFlS+7jy3U8RBIstcjEQgX+GriC9ZpM+4M6
         uOcn1qq7Plmy00MzZxckqGgmPvu9VzFuZkYeyfemQa1lljeUpQzI4YSPeO57FGBRYhHG
         0m2xYEE9lOxg8B2QMUgBkLOVxIcttM8PVv4MzHA1BHxxCIortJUL5ky/Vy3bd1pNydYH
         o4uEocmMfUBUk69ceneujO6xstYoII+j+8K6384lEskkwn91j6uIppusLXl5Rc8I+/fq
         u7718+rnkgibKK0RsUSozrBFpOgmO6VFQIsMELRAcXBjD2wFT5N/aJ2Z97CrjIUNN2B5
         0NLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748209381; x=1748814181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQ+RqlSFyQLSDHWP9kEu2/DGiQBnqF1j/beqMyydt5w=;
        b=NTya/OAUslkjeLtMHNCljCK1tQYECFk5HV/6bZThUihY/TU1msweormfLPBVXuze2i
         AWB488MJ0Wg87jdWFLYl/5ygPPVULoH2S9vJpiu2E0zmzJ7OO0k7NXXiIVZfbZYzjMET
         00Rl4YrsBLcpcB90Kp6ZWlrmVkQwPpfCokrHzPO4B2DybWIovXIwICN0b4qhiCy/7BVn
         iUfFNOkIKwhH9RwsR1ISlUWFzJpDg5V4WnuCAD1i6npC6rW6C55cG9OjR4aYh6FUYBe5
         pFoQX0PWsACfnV9qd32obEvxQxomJPNhUzr6vQ3iib4aXvs+EtEIgHCs8Jo9B7J+Kcq8
         I6Ow==
X-Forwarded-Encrypted: i=1; AJvYcCUG1wdF104kNZCDsprduh3yIJ+krvOKgbbaDCOeORnZW9nL0ty/DdN5HxL0rAdpg03cET41gYUPwFmj@vger.kernel.org, AJvYcCVa/Ebyi4oY/cTJPGupDnEd3BBRAYxFwWIcr0kBkCkXfGY7DLqE8PFTqE17cJr9YVox7YFB1auN02B9gQ==@vger.kernel.org, AJvYcCW6BSDu7vLYViIKXGPfb3j6pxCHl69gVxLL8kp3aojy8nWra7O5azcScozURHeQQ984uR+IvH54CQzOaY5U@vger.kernel.org
X-Gm-Message-State: AOJu0YztrjBg1wFkSuuhHSO1yWBvY1VkUsVzFOteu8k3OGYvRQNHtihq
	GK+G44O9NzHXCoRs2KwYlwxXGqovIYixlBH0lfhaOpKcySTlPZ2Yxm/d9MzNrA==
X-Gm-Gg: ASbGncslwRQQ9/OgK1leWpdcZWuylGjq1dWltD9R5E/RLapiV3k99b0kiJBlAg2IhcT
	L8M5RpxES6w/u7FxPiL8CzkhRgCPMRPkHs9IRFgvR+HgTVIBhce8TtqR5hSMOfXOKKahYN+KUrD
	QpOfT6XzrzV5Zf5RO2XeO4/k74DVRB6gyXyYFoqKH7VmaToDTLzvMrwLq2l/eoLWcXMSBcfORBe
	RcgAQKx+WirGN3/RrAtMEyp1euagA/iCEz2cJgI27hMw6urkVpzMJtH3NqU8wHWPpjQOo1A6z/N
	VI8Ny3dT0tG9Smw6CbRB2QdMBvA85GtjxVd49Q==
X-Google-Smtp-Source: AGHT+IHF0qg7XRO6cKHYVHl2gLnkwXP4O7TTQlPqXAyq6VAe/C1fzUPEpxgOfK5wJAMscghx9ZZ/OQ==
X-Received: by 2002:a17:902:f611:b0:231:d7f9:dc6d with SMTP id d9443c01a7336-23414e9b517mr104887055ad.0.1748209381477;
        Sun, 25 May 2025 14:43:01 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2340934d91asm35083115ad.166.2025.05.25.14.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 14:43:01 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	nbd@nbd.name,
	Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	linux-mips@vger.kernel.org (open list:MIPS)
Subject: [PATCHv4 2/5] wifi: ath9k: ahb: reorder includes
Date: Sun, 25 May 2025 14:42:53 -0700
Message-ID: <20250525214256.8637-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250525214256.8637-1-rosenp@gmail.com>
References: <20250525214256.8637-1-rosenp@gmail.com>
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


