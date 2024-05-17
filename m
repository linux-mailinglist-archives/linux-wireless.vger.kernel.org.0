Return-Path: <linux-wireless+bounces-7780-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A56968C84DE
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 12:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C3871F22B42
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 10:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C8B79E4;
	Fri, 17 May 2024 10:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="APErmqrt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E8D3C463
	for <linux-wireless@vger.kernel.org>; Fri, 17 May 2024 10:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715941825; cv=none; b=H3rgPUPM0JBBijwNoY+Qb03tpImbiE9zDCskbWuhbUCDrtse7G13nKx6WntC70vJiFVVUREyzjHGH1DjT3tQHr4pqusBlE+v9TevEohLNEo2ie2NgUifoYzAbStCzAxCBdjMrKbl555FJVmWvB6+l/i+r2QGgnBgtz9P1OjoN1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715941825; c=relaxed/simple;
	bh=oAI1ijvpICcuf3OoUxBj4dMmMQM+EPJnB8UWOilvd64=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=krEJVTxreKMwu8muqeATilx/o2RlRXSFuWEqCDU/vZHVRMyPANcwKjFR4izCYhR53Nj2q41VHtG0AoMkt8hK7xXyAFGEbAlqZNXdO6cJSCfzgKFvW6WNoPjluzNCOy6britTigj/2rjJKa7DHfcL7jF5tg6dw0Vn2XvnLezD4Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hifiphile.com; spf=none smtp.mailfrom=hifiphile.com; dkim=pass (2048-bit key) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b=APErmqrt; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=hifiphile.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e3e18c24c1so19722841fa.1
        for <linux-wireless@vger.kernel.org>; Fri, 17 May 2024 03:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1715941821; x=1716546621; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UBRIuLBToc24VMF+MuWCiYmiRqOpJ/ElqTpxC0jMPZQ=;
        b=APErmqrtL+gtFeQljPMgxAKHP5So8DiC5cm3x0vTId0M0OzKuPj54ZlTObthnt/T4+
         O1+9BeJk8GzVHjpC2Fr+rP9ulcflru2Pd4gLLj1cBp1olj62efXIdCePaoDDYXIHaYMS
         olY3l/7Vm/vebmes/04laglcCsAviSA7ONlXxR1JAznNDajdPx3yjRjyt8cfUoi0UEHW
         G3mKrT8g87sB9ClHteBbsx0i3x58kfJK16eiBxp2TF4Go5IsFMBw6wZ4n7j8k5wPQpCy
         kr+Mq4GH3GlXP7xhDjv5/4NZDZeOT9aOEs5mfM4Fu/6wO2J0NC/P3rzjYtUeZovzISYk
         hs9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715941821; x=1716546621;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UBRIuLBToc24VMF+MuWCiYmiRqOpJ/ElqTpxC0jMPZQ=;
        b=S28zdVtKrf8PtR3O8fDVvKnfRp8UDfQvNywTeGP0Tz/xeeUCihWkvoJJSzaTw3ntRV
         4jslWRDrWvIX/pnK0uc0wnVLEVR2zUVmj1wakys2ojglyANVDI7ojM/kMyLJQnbqsgWd
         728ATDDNyC1ffiY8ZVNM/0xHE3RwwTHYj2qVFGHTDCP8BIXtiQVyy+OdzvlD6VdhgStM
         mjR4sv1jKrobEdvelm3hWCseci2ppsm1iV5+Eux6w1o07SjY8sfj5+rOJqrP7Al+7ZgO
         9bXsXPdt3IxXL8GkHUGsPVRTSlmcPPaFNlwxwRREysThH7l4F1DppIp7CUlLX43GTT62
         j5hQ==
X-Gm-Message-State: AOJu0Yz8x8fiQm9OF2jZ5x/4OglF0YB4mavHPUTycBbf3rNrM9/tigQh
	d57v0UKedGzQmNxg7o1Vk7gkIYRi4MuEfLNPY/GiiwuKVb48CEHuHyJVHXzrLA2JfQ01oQRH2K5
	HnkMyAkpsth0Htxtw1jPaAtABdssUGk43PHX6yYcuX4Z7QTB6sqdKmw==
X-Google-Smtp-Source: AGHT+IHj2fKPUSAVZwq4O4fIMuyPhRH/gWFDpEiKulGYopt90NWTNdCd8j4MMxhzghHUxcrdIDfh48rHXs+1gE5XbXc=
X-Received: by 2002:a05:651c:510:b0:2e2:115b:effd with SMTP id
 38308e7fff4ca-2e5203a47aamr165526631fa.47.1715941821099; Fri, 17 May 2024
 03:30:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: admin LI <admin@hifiphile.com>
Date: Fri, 17 May 2024 12:30:09 +0200
Message-ID: <CA+GyqeZ976F6Zbcr5oo2_f_ECiy4tqb0vTjtSNtPexO07N-H4A@mail.gmail.com>
Subject: iw: alignment issue in print_he_capability() on arm926
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello, I'm using iw 5.16 with Yocto kirkstone 4.0.13, kernel 6.1.55 on
SAM9G25 cpu.

When I execute `iw wlan0 scan` kernel report many Alignment traps, looks like:
Alignment trap: iw (6376) PC=0x00461ff8 Instr=0xe1f720b2
Address=0x0048e771 FSR 0x001
Alignment trap: iw (6376) PC=0x00461ff8 Instr=0xe1f720b2
Address=0x0048e773 FSR 0x001
Alignment trap: iw (6376) PC=0x004631c8 Instr=0xe1d420b0
Address=0x0048e771 FSR 0x001
Alignment trap: iw (6376) PC=0x00463190 Instr=0xe1d420b0
Address=0x0048e771 FSR 0x001

Upon investigation, they came from LDRH instructions inside __print_he_capa().

There are 2 callers, print_he_info() haven't issue as variables are
aligned in stack,  but in print_he_capability() u16 variables are
directly casted from u8 without alignment check.

I tried a tentative fix which works but it's not clean enough to be
submitted as a patch:

---
 util.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/util.c b/util.c
index 8a2ba10..941c6bf 100644
--- a/util.c
+++ b/util.c
@@ -4,6 +4,7 @@
 #include <stdbool.h>
 #include "iw.h"
 #include "nl80211.h"
+#include <malloc.h>

 void mac_addr_n2a(char *mac_addr, const unsigned char *arg)
 {
@@ -1657,20 +1658,23 @@ void print_eht_info(struct nlattr *nl_iftype, int band)

 void print_he_capability(const uint8_t *ie, int len)
 {
- const void *mac_cap, *phy_cap, *mcs_set;
+ const __u16 mac_cap[3], phy_cap[6] = {0}, *mcs_set;
  int mcs_len;
  int i = 0;

- mac_cap = &ie[i];
+ memcpy(mac_cap, &ie[i], 6);
  i += 6;

- phy_cap = &ie[i];
+ memcpy(phy_cap, &ie[i], 11);
  i += 11;

- mcs_set = &ie[i];
  mcs_len = len - i;
+ mcs_set = memalign(2, mcs_len);
+ memcpy(mcs_set, &ie[i], mcs_len);

  __print_he_capa(mac_cap, phy_cap - 1, mcs_set, mcs_len, NULL, 0, false);
+
+    free(mcs_set);
 }

 void iw_hexdump(const char *prefix, const __u8 *buf, size_t size)
-- 

Thanks,
Zixun LI

