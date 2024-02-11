Return-Path: <linux-wireless+bounces-3426-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57517850B6E
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Feb 2024 21:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C59D1F21921
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Feb 2024 20:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A6D5EE74;
	Sun, 11 Feb 2024 20:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="OCC0SkVi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D295E22B
	for <linux-wireless@vger.kernel.org>; Sun, 11 Feb 2024 20:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707682773; cv=none; b=hdCPyEBBMXt7HgkvWZdWogDMIrHTH1DuL5c5F3V2GsbDYu0UaFZ+mNV7YkThOIxajglKZTMkMkkuCq1Zb6ddM/hSbSX3n+Zf10j+HFck7JhY4QClM+q3xjq0o39VG6a+lT9nquw+Z+94eJ2BpAOdzJ7s7iQ5KI2UaNBLrMBx2aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707682773; c=relaxed/simple;
	bh=nbDFD/TqWUYFdF7uxY/c2JRJpkeHNhciS5fxFdKpRgo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=THIkbJDRSaOsmcGKHaa/p9ji7Fda1w9+wkIu8kty8Hngr7dIziuAi+O3v6x/bprjMnztrvYMYc2rK5UN1QIcNSQaOmEYcFKXlAkejN1EwQQ+aZYNlqaMyXtKkLq24PeTsAm584htRYKzVYVsDqaC87kBsHWGcXNltZYS2mTqUPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=OCC0SkVi; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5116588189aso4568024e87.1
        for <linux-wireless@vger.kernel.org>; Sun, 11 Feb 2024 12:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707682767; x=1708287567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7FMeMe+UFSzOu4x02i7+Ei2gevYK/Z24NmaoVH1ZdN4=;
        b=OCC0SkVigvA6aBCxQwilkr2BPTgpL9p4baJABc7t6wVoRZ3kYQBkq1iLJO+thTJ8rt
         qQIBSgaQYAhSatQhUcBGmJQdy02OPpRObf2vwddjAURZlnyQiZ02tSrycNMa9yqKQWYu
         4FURW2qNaEplDEbIPzbanA3hL5wkwCSeQbYdoP4bMMKqE5EpVJw63+gBav3z4l4KtRzT
         vzZUlk4GVXm9GWGmtgule8st0dHC4oVOSXJsHhxj65280MQATCgAtujaUUpK4E9prynH
         U2OhqDPdlgTdzYH+M8XdnrN/0SaP6tXLA3UqopWHld1CEqN9PtU+HMbiFxJikQ3F66YJ
         f1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707682767; x=1708287567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7FMeMe+UFSzOu4x02i7+Ei2gevYK/Z24NmaoVH1ZdN4=;
        b=nALpIytb1LSxlVLZRv5gxRiP8E+rG1yErRP3hFc62krX5Fm0gfu2F3V3+nbjI+SDGw
         2vjUysoFhESiQogz20Z1USs4SaBp0cFkcpkeKy6GxBlZ8up0nIIe7bOspHGvo778dSie
         athyzJoL9SmoaEbF7OvbO+xbMHkpRXmJkD3Ovl9RuNXWds1bUmJ/AfWJ85xi1Wb8Pjc4
         /b71bSKPE8eLsTmS0mNS5yVRm3yEstmRmY9dj5+jZ/t5WfIEJYQ1Ku93DDBxzezSk2hV
         0OuOENFiTeVHl1FHpKWsP3fds1CE20vDx9HgK7uVDaY7lcd9hcPdTM73S7ylAjgB9fre
         29Rw==
X-Forwarded-Encrypted: i=1; AJvYcCUK0SXCZen2fZvWff4GR0kycm1ewldGYfYnuCyCh6evwXkGF5RPVKnLs0sRKVIrUn8U4DbAO7+nHhzOvdFx7IkWi/lpHH2oQO2MXl9AErk=
X-Gm-Message-State: AOJu0YwItfUCZ2+3FkyssTbJ6hGCqjyJFKbm7ig264+WN9CldkS5jixD
	x/bWVN0pp0yDhVe3n9XVNP8iDMzyBYGShG86d4kLCYR0YihviyKKzObbL9mUerE=
X-Google-Smtp-Source: AGHT+IHQQmg792AOqBaYpSyBlLcWoqqjQ7Q0vAoOPfmaWNxycd0p70GpLDpxxJuD6SOMGV77gIbPFg==
X-Received: by 2002:ac2:5990:0:b0:511:7681:1853 with SMTP id w16-20020ac25990000000b0051176811853mr3113052lfn.16.1707682767663;
        Sun, 11 Feb 2024 12:19:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWb5XZKpwgH9xx+A38BFP1sYW0fOK2x4MP8ZDj8dl80CVM9iCH5qFj4jBWu2j+WCHYe6CdZZ7EdAg0bspn0xWdzI7mavvJBS21jXsQf443GIO5L2nJ3fI6sdzW1ihXsIrkm5HQaY6po7MtuVai0Uq4zfxN+m/uQ9wEcVARBXWbNcR5zK2DIZ/kS7IdMx0ra0Vyh7cB9l4TPiQ==
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id vk3-20020a170907cbc300b00a3bff1d4465sm2720318ejc.165.2024.02.11.12.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 12:19:27 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: miriam.rachel.korenblit@intel.com,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ayala.barazani@intel.com
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] iwlwifi/uefi: remove CONFIG_ACPI check
Date: Sun, 11 Feb 2024 21:19:19 +0100
Message-Id: <20240211201919.3751551-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes a build failure on ARCH=arm when CONFIG_EFI is set but
CONFIG_ACPI is not, because uefi.h declares iwl_uefi_get_sgom_table()
and iwl_uefi_get_uats_table() as dummy inline function, but uefi.c
contains the real (non-inline) implementation:

 drivers/net/wireless/intel/iwlwifi/fw/uefi.c:359:6: error: redefinition of 'iwl_uefi_get_sgom_table'
   359 | void iwl_uefi_get_sgom_table(struct iwl_trans *trans,
       |      ^~~~~~~~~~~~~~~~~~~~~~~
 In file included from drivers/net/wireless/intel/iwlwifi/fw/uefi.c:11:
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h:294:6: note: previous definition of 'iwl_uefi_get_sgom_table' with type 'void(struct iwl_trans *, struct iwl_fw_runtime *)'
   294 | void iwl_uefi_get_sgom_table(struct iwl_trans *trans, struct iwl_fw_runtime *fwrt)
       |      ^~~~~~~~~~~~~~~~~~~~~~~
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c:392:5: error: redefinition of 'iwl_uefi_get_uats_table'
   392 | int iwl_uefi_get_uats_table(struct iwl_trans *trans,
       |     ^~~~~~~~~~~~~~~~~~~~~~~
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h:299:5: note: previous definition of 'iwl_uefi_get_uats_table' with type 'int(struct iwl_trans *, struct iwl_fw_runtime *)'
   299 | int iwl_uefi_get_uats_table(struct iwl_trans *trans,
       |     ^~~~~~~~~~~~~~~~~~~~~~~

I don't know how the driver works, and I do not know why the
CONFIG_ACPI check was added in the first place by commit c593d2fae592a
("iwlwifi: support SAR GEO Offset Mapping override via BIOS"), but
since it did not add the same #ifdef to uefi.c, my first guess is that
this piece of code shall be used even if ACPI is disabled.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
index 39053290bd59..8617fe8b65cd 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
@@ -285,7 +285,7 @@ static inline int iwl_uefi_get_dsm(struct iwl_fw_runtime *fwrt,
 }
 #endif /* CONFIG_EFI */
 
-#if defined(CONFIG_EFI) && defined(CONFIG_ACPI)
+#if defined(CONFIG_EFI)
 void iwl_uefi_get_sgom_table(struct iwl_trans *trans, struct iwl_fw_runtime *fwrt);
 int iwl_uefi_get_uats_table(struct iwl_trans *trans,
 			    struct iwl_fw_runtime *fwrt);
-- 
2.39.2


