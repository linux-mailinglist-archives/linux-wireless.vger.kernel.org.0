Return-Path: <linux-wireless+bounces-28268-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E734C09C31
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 18:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A921A568B39
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 16:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BD3321F48;
	Sat, 25 Oct 2025 16:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAyPZs15"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700BB32142B
	for <linux-wireless@vger.kernel.org>; Sat, 25 Oct 2025 16:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409748; cv=none; b=p9QtL+wVeg7IJVNzJeCh0+dnbex7TBwsu5Q83QUMwK3OUF1pZ0lWYsvuWruFhpbbGgJ9PrMBZ/wF8NoB5loCyAHiIKQxu1rQq2kYCEQVbTowUzAgxHn+imxxbjpZQZIMrou7IuCa2x7GIH3YNomlBu3ppmjCp0hkJRNquqvmWEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409748; c=relaxed/simple;
	bh=142ZarbauOc/OnyndUEIR7x0gLhU0Vf39KWkHIFGmYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZqwQEW8xw+hyNtzZezZ4NniCcT62Wpd0q8uyN5FqyVKvWBTLLLpr2MPRBaZO1fomI2MFU5rxdJibPkPlEr8RZIdGS2knh3OzceGCYwZuKFpJiWp8VBgo4dD0mTwsQogK6YdR48WdvpDSXJd2q7v+dUMjwXIiSshB+RES/JyB/3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dAyPZs15; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-87c217f4aaaso37614346d6.0
        for <linux-wireless@vger.kernel.org>; Sat, 25 Oct 2025 09:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761409745; x=1762014545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EVD9Zxv6Y0ifC9xZiOG7Ki+TEfCe0ib+yy9r9fDGLQc=;
        b=dAyPZs15q4VutsdWz/C6jbNfCmaVmvughf723RdKM16dn8vRKk0Sy6i9IMDOOu9n2M
         ulbbC4hCEQTFI6lVAejlPE6+mGwHCQSCHtoktKxGyoSNjMS8mJ7JFe7fZJZ5350ZDbN6
         OymL0S4qkidMTtmoojhI07mDa2Hn07aDHxYcT2aVWuQV4Q31wuq/a0QOgLVD0skGIXeV
         o2AsjLycCKcNO+WSIqDEtxC864eY8TVzRiRXZ1qIy8MhhD/VE6Z2l+ahRRugIk3Bj52e
         2E9TsZnxRHV+rIF7f9vrz54cS2oF/mvG+wEW7dLjpxQvWBnyIBZtNHrBWjydX7uUUN1G
         gUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761409745; x=1762014545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EVD9Zxv6Y0ifC9xZiOG7Ki+TEfCe0ib+yy9r9fDGLQc=;
        b=ca2LlGb9kFS/nB8wWJ/PpedKAK1tlD02yjrAngSGi//SzuU4A8D6pzG50SjohFtelM
         TLhMQ5NVspeMLwvZDRcyJibzz5bTsKKkPO1E52WVSLv6FqxbgFKD5qR6R1zNZAdaOF4o
         1SglxUnWoO7B3csRT0UyJ/MarD+cJdATos/IIBXi7qtNkfPf7FYEnquu9b/LTqi/E4ox
         bNowIUAR83aPweQXZWgShxR20jzOtMWY/3O403wGM3zGu8iDDVCT37tmM3jNBZK9eEEZ
         dlYAe9NEG107T0K+tlrRYGF8/4l52cKvvn2Q0eoU9LLVv0KPxsNR63suAz3z0JDIQZqE
         F92A==
X-Forwarded-Encrypted: i=1; AJvYcCU90IFWYVcwKDc8L1p+32SdZcgAT/4U5apecY67B7kUwIjC7vRBExXyph307qVbQEszf0+FAUa10OO57C5MCw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKopxm6cOvLqCoQjcZyt2lB9W8qZCxuAfDwoshJ9SaWijWOyaI
	8yDf0ltACQHDHonviiyHMaKlltySMx5CTlQqaIKR1Uuj7MBoq5Nj7RUk
X-Gm-Gg: ASbGncsr9lu6kFMqvnIYPMxapJs4WmpZUnCrpNXfMtt6K1UbHhGtzNC/+RgiDrZPRkk
	JsUGYtpQNyGPhVMRBhpydo6KhXcZy7tJRmzWn7G64IrsrPTRGVuIP0HDbXbuzXaZsBMDPFzNUeE
	Xh373tbpX+ejH1F54nUyLIvN7NS3mg4xGEsG9qv84hgni+o11JoMfD0VgztMTbzgOH8ly3ND+rq
	U68U6zNIDRtMoh++el8q8MM4FPD4nmqA1Vgxm3OdCebYFNRop2IWlUbWuPqW2XPuSGth6qznB8+
	SLLUeSgkMg6UXGB7xulK9yvUGuVN9Yftjki/xc2GLAqFO8vDdmGH/mTBMhuARgsspgpto1xFmI7
	+4ePKTBV+wTLrggE4OenuRjqOMl8vwEmvH9qydkju7RIzZ18dmWhMryL8wPXHeNkWNHbmb51ssk
	LpWdcaIwg=
X-Google-Smtp-Source: AGHT+IGDln+XKp5LwgnfkE2q9ztXbMdtXgqcPHZRtmmRDeFAZFQKeTU/cmkG7iWpntvS8l1BZEDptQ==
X-Received: by 2002:a05:6214:2a8d:b0:7f7:777e:39c5 with SMTP id 6a1803df08f44-87c2056890amr536634466d6.25.1761409745396;
        Sat, 25 Oct 2025 09:29:05 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc4944a84sm16223506d6.36.2025.10.25.09.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:29:04 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	"Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 02/21] iwlwifi: drop unused BITS()
Date: Sat, 25 Oct 2025 12:28:38 -0400
Message-ID: <20251025162858.305236-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251025162858.305236-1-yury.norov@gmail.com>
References: <20251025162858.305236-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BITS() is unused in iwlwifi. Drop it.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/coex.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/coex.h b/drivers/net/wireless/intel/iwlwifi/fw/api/coex.h
index ddc84430d895..b0d68b4c504b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/coex.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/coex.h
@@ -11,8 +11,6 @@
 #include <linux/types.h>
 #include <linux/bitops.h>
 
-#define BITS(nb) (BIT(nb) - 1)
-
 enum iwl_bt_coex_lut_type {
 	BT_COEX_TIGHT_LUT = 0,
 	BT_COEX_LOOSE_LUT,
-- 
2.43.0


