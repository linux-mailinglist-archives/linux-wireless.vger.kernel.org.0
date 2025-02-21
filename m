Return-Path: <linux-wireless+bounces-19234-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D57A3E9FA
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 02:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C45713BCC02
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 01:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28AC13B787;
	Fri, 21 Feb 2025 01:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="S7NzPIqN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014EBA94A
	for <linux-wireless@vger.kernel.org>; Fri, 21 Feb 2025 01:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740101373; cv=none; b=gv+J1zzytzZO7ThmxICVo2L9c7wvqGbdmoW1rddT2pVexfQwnfgKDJxaCjH6S08f4jm1jkOWNmBBMr1TWOX59n32e/6X6CIfWmuYOWxWCJYN4bxRjx7eaxs1N91BCDIbtp8H/45orFVbcPWhR3fJKEpcwklmGP8DHb+Qdmbftdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740101373; c=relaxed/simple;
	bh=OxL4DZJqt64PUiQXYxlTRUZr/x1LfFZisrvwzPOc5DA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=U9UUiQcKDCNsAb4+h/lTCrLoj7K4JxN5X6ltpuDITSSeaWpH0mX0CjVUlcfYkUl+f5fO2p2sIFS7xsYO5ZAWSZmHncUyWcQvS4/HjoRfHAabo2O5QNRLubuK6TdzpljPz7dUOusUpkwTMUcD6fhdlpOm2Dl9Oh0LPRhAUO0ivc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=S7NzPIqN; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-220c2a87378so26342825ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 17:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1740101370; x=1740706170; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WpUJdoMAs8bzYIcG1jnoru7eUeYOX5eR6ASAPS5wK3I=;
        b=S7NzPIqNNYpFfenN8jLYCZpiN4jTAPcYTG2vvjHqHHDb29dEPdljEt/smx0YtcbJo+
         vd6xosEVzDHR0mAnzrJP0ZW//goBcZ676PprhbS7DcWCYE/sL7DpBhNAd7cm6ObHPMIv
         Dv+RujRiTM/Vp0JhLZpOZLH4FOfObZr2IJ4PfpjkwgdhAkkqfZ0xYgrT+YDoUPFnCqzC
         H55Usv8C9BEQ9iBOZMXadiwUXgdKVXULXg88O2kQKnZOH1mfw+oM2OGfpvE8sknkKRaM
         RthjMD2yeFZAFmbBGajLBriZxamKtwLUxBfFpqXuL8bG0JUGjp8Ez+jPStkHU4x+1L4b
         ttFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740101370; x=1740706170;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WpUJdoMAs8bzYIcG1jnoru7eUeYOX5eR6ASAPS5wK3I=;
        b=kfviRIT+w+v6PvjUziOBNvl6C5+uCCORz/F+XPPn69MDjsbqnAbzGsBlgyp8zxK2XY
         F4D0Ir9od2CoHuEuAYHMwmICTUDwzWifN4kxnVP4RuFH1o26X9JJQLPhlKdzERfAAewJ
         tSJ+/zZJPLe4PwV7WnTyg5c3I2uwEqgzShgQGuJsICFfU8pR8kkBLn3cEl3+0IeR8S3j
         fR/zRDWtLKZ2jbVjT0A/1Yb6GZeEVq1y+MbQgHj3sWNHXo8VHAoZfpRSoaNteYpCf0+j
         1I101PrRh6brZARibJWtzhIrK02R1CzkyA8CIPYVgq3n58CBMO51iupcQi0sokYovxkN
         sXLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoMyNB6J62fTLOV5kq4fQC3zgQODfJo3rN8Gol5binLjxw43CvlXNYEPOHfy7MSfZAz037s7BSABXUuawakQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEpPmQwsAorr8QU+NcJoC3EBjgZhDilsdnmb5QMEZTGA2rr7oY
	f8QOLVFu6uPjQbG1NbnCpwjzrB5HGrr1e3hF/qxUKzI93uNgSLGLsfcLmt7h8jw8R5D/Z+A2TMO
	6YFcZsJMtprBqerRN7OBRu6DA5JkkmQ03e5JbHdk/RKJhcsb+
X-Gm-Gg: ASbGnctTEDwXkWNF00ajzrOi8Pc9AzAZyyzgDWrmsAMymCi2xPSnF2YjfiBXfXHW53+
	Zpwuu8XJowqnnsjSZJorXCCqIfNS2DbEuUlbUswq6jWFmmtKxcWjRTQ+Um2TJsdfmR3mBC4/Ki/
	hO7b7yb+o+D2UDOKNSDA80sYCEbW4Xhv4qyBAbJJdvY6Tc6ly1cQO9c+99x2lgxM+474GnH92p5
	eFfusDKQDtn6HkS2Rp1e2jRhuQbjRXN1KzSitBhdQPoQGwYlVaPDwcEVdqhXklx88MCivcLyBWs
	dWDedESwWulVrWsLno15KJqQJjxTi4Zeoiw=
X-Google-Smtp-Source: AGHT+IHDRB0yDjEQFnLo/EI0eL8zlxPAZQ5lMijLpnpnvBm2FYJm4DfnbRgn46L0BNyHiwblb1kMWXysVRC5
X-Received: by 2002:a17:902:cf08:b0:216:2259:a4bd with SMTP id d9443c01a7336-221a11d9943mr14062845ad.52.1740101370325;
        Thu, 20 Feb 2025 17:29:30 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-220d53fa1f4sm7697295ad.94.2025.02.20.17.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 17:29:30 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 7DE1B340216;
	Thu, 20 Feb 2025 18:29:29 -0700 (MST)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 6FD29E42CBB; Thu, 20 Feb 2025 18:29:29 -0700 (MST)
From: Uday Shankar <ushankar@purestorage.com>
Subject: [PATCH net-next v5 0/2] netconsole: allow selection of egress
 interface via MAC address
Date: Thu, 20 Feb 2025 18:29:19 -0700
Message-Id: <20250220-netconsole-v5-0-4aeafa71debf@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO/Wt2cC/23NTQ6CMBAF4KuQrq3pDy3oynsYF1in0EQpabHBE
 O7u2BVEli9v3jcziRAcRHIuZhIgueh8j0EdCmK6pm+BugdmIphQTLCS9jAa30f/BFoazRkIW1f
 cEBwMAaybMnYleIe300hu2HQujj588pckcr8HJkEZVWAV3JXVTOnL8A7wmzYtHI1/ZSzJNaA2g
 ESAS9FIbnnFT6d9oFwBvNoAJQLM6JobsBUi/8CyLF9xmm4mNgEAAA==
X-Change-ID: 20250204-netconsole-4c610e2f871c
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Simon Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Berg <johannes@sipsolutions.net>, Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-wireless@vger.kernel.org, linux-doc@vger.kernel.org, 
 Uday Shankar <ushankar@purestorage.com>, 
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
X-Mailer: b4 0.14.2

This series adds support for selecting a netconsole egress interface by
specifying the MAC address (in place of the interface name) in the
boot/module parameter.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
Changes in v5:
- Drop Breno Leitao's patch to add (non-RCU) dev_getbyhwaddr from this
  set since it has landed on net-next (Jakub Kicinski)
- Link to v4: https://lore.kernel.org/r/20250217-netconsole-v4-0-0c681cef71f1@purestorage.com

Changes in v4:
- Incorporate Breno Leitao's patch to add (non-RCU) dev_getbyhwaddr and
  use it (Jakub Kicinski)
- Use MAC_ADDR_STR_LEN in ieee80211_sta_debugfs_add as well (Michal
  Swiatkowski)
- Link to v3: https://lore.kernel.org/r/20250205-netconsole-v3-0-132a31f17199@purestorage.com

Changes in v3:
- Rename MAC_ADDR_LEN to MAC_ADDR_STR_LEN (Johannes Berg)
- Link to v2: https://lore.kernel.org/r/20250204-netconsole-v2-0-5ef5eb5f6056@purestorage.com

---
Uday Shankar (2):
      net, treewide: define and use MAC_ADDR_STR_LEN
      netconsole: allow selection of egress interface via MAC address

 Documentation/networking/netconsole.rst |  6 +++-
 drivers/net/netconsole.c                |  2 +-
 drivers/nvmem/brcm_nvram.c              |  2 +-
 drivers/nvmem/layouts/u-boot-env.c      |  2 +-
 include/linux/if_ether.h                |  3 ++
 include/linux/netpoll.h                 |  6 ++++
 lib/net_utils.c                         |  4 +--
 net/core/netpoll.c                      | 51 +++++++++++++++++++++++++--------
 net/mac80211/debugfs_sta.c              |  7 +++--
 9 files changed, 61 insertions(+), 22 deletions(-)
---
base-commit: 1340461e5168f8a33b2b3e0ed04557742664bee1
change-id: 20250204-netconsole-4c610e2f871c

Best regards,
-- 
Uday Shankar <ushankar@purestorage.com>


