Return-Path: <linux-wireless+bounces-20259-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6B1A5E4C6
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 20:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8C0B17C509
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 19:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1AC2594BE;
	Wed, 12 Mar 2025 19:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="XKBh4GFt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21B51DE3AF
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 19:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741809121; cv=none; b=caeXWXbxuefvsDTpOucvXZnSvGKWfqcfawoUVkbZPKBoeO4qMC10DQx5DdwEZYBJk5gC1tXg+5utBvkuc8rWlMxzsHF/gREYg57pW1floFJ6Eeucr6NgjamvleIAbEoCzutsE0B/TM08TUcZAWNsno/XsrKskQm8lpsaAW7fiz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741809121; c=relaxed/simple;
	bh=Q2k9GPayWeUHQsXcs/86RclA5d1uasfKBhsFAaw3N6I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Dpt+u8xV0wTwM+F+87b/EBmAnt9J6EAbkqdaMZcfsNAkE6QOy1oJ07GS4Fp4z4i19dSl15vNuEg4LYXTkgHuYGlxk8kJ9qJ2rs+RjXnTsdl7nWl4Cj+S4MsDU9vlF+I15uTiTmElFij8UyyhmioWsmIFi7Rb9mdG8zkkrbztmFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=XKBh4GFt; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-22548a28d0cso6477395ad.3
        for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 12:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1741809118; x=1742413918; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TUXQmTabTFlJQTznKZdaGRe9l01Y+yauh4zh2Ba8guo=;
        b=XKBh4GFtQCYph1TcPaoHMx/aS0kPOPGy2bz3gEQfe7/Am5jsZSqu2HIx3lm3sN8Qbt
         BYRTRqeMBEPJhg7bbdHL2mmOfojYsV05s56KcpqY3N/MvjMKvVs4DxzALnDYb3wPOZiF
         /hO3Bpn0YmPt0Svnob5N9iwjmB23DFfA8Sqf0AkOhvS6weuCK8DyRDm4PG/5cPs0loMu
         CExrPDjVbwwbtJ+jAF1FDm5aMzQQRpGvIKNv1jMji6zdVC7eqXQbDdCjBlKT9fgVWrng
         tIiNshqy5NTKtRLmcb9WpqyryGmzqhFBMmu1CYgdyUkiZmSP6K6YaPVUSPy49ewEfoln
         NYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741809118; x=1742413918;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TUXQmTabTFlJQTznKZdaGRe9l01Y+yauh4zh2Ba8guo=;
        b=nPDvJ4pqaTPqPYpoLOtAz1FWyeuAh2loXGDgiSZ4mFNeWudr0s/G0eMbA07is3ho91
         skkS5WjstohgTmB1gkWOynrRdeUKJvWp8mMGFJEGwzhNxoCP4WuyLA3SVcbA8xazhSeg
         Nys4Xpd3p9ikOT0FSI1cbnsB4NYnZPHTttOsRocuOC0vrKhj4ZLJPQ7DFkP9x46KdwvX
         lkGBscbqpOrllTL9Ef067DOLupx6bhofK8xMU7760IE5oMeXUnnG9Ts0tngwtk26g8TY
         NWHqJKRNLkH8Ij+SmUHtk4/xBQL4zeekz+pchD9yQU2hjpI38RWHaL+r9N4BqhIUWBue
         uBWw==
X-Forwarded-Encrypted: i=1; AJvYcCXcZWb+dUQlMdzseLoBetGmCATzupZV0+nWQuK2Dt97WNmV2uwelOVorrJtbVwWhQmaiND7LfU/G0k6/wHKeQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9+qCPiM6onivS5iiFcXKC4YfnKX43EJspghOcRldaf0LAYTT5
	pOxijN/si/BsZGcaceV94zbCZaLh3b6rsJkzkOpYsD8QSbgT6BQk3eyruc9t0xgwNYt1fKZXAXS
	WyKGEnkOEc0hsucy05E5nyf3d7Wju/XKejsQs3K9U8TE7BkHd
X-Gm-Gg: ASbGnctRzF6a04dXhT30m/MXuG7FDW+J81xT6Smwbhfpjv2sTquRJrCzmxXxVBWq74n
	uvylYC2x8rr0uq6KUTHJlwSyn4r7viqb86lIV6Mps2trZelZIFgNGYBL0Xst1Lff1bVR6BndT2C
	745cdFBLSK4NHM70KjK327kVWuV87YbMUU7pkdHhXqniAecpEyzRr3bnXYwl04RG2n+UbOsqYJS
	QtmQ9z1MjSmvNCojFgJbTz5YAACIcQKiWwK0rZVAiiJk8OyEKUMuwLQvA3lQ+091SifHF6C3zAh
	MwFi9G5BvbnUmbFtQeoQi3GlzBrBmyqSAYY=
X-Google-Smtp-Source: AGHT+IFzTFpDmJydmC2PtlCdpNTNUDU0mgSO+UfsIg00y4eEivOM8oFExNu431q+A3hE23lAesqPTs6l6uBP
X-Received: by 2002:a17:903:283:b0:224:194c:6942 with SMTP id d9443c01a7336-22428bded4amr373642295ad.34.1741809118152;
        Wed, 12 Mar 2025 12:51:58 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-736c8d701absm632789b3a.12.2025.03.12.12.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 12:51:58 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 3CF97340328;
	Wed, 12 Mar 2025 13:51:57 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 2C718E4044C; Wed, 12 Mar 2025 13:51:57 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Subject: [PATCH net-next v6 0/2] netconsole: allow selection of egress
 interface via MAC address
Date: Wed, 12 Mar 2025 13:51:45 -0600
Message-Id: <20250312-netconsole-v6-0-3437933e79b8@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANHl0WcC/23NTQ6CMBAF4KuYrq3plP6oK+9hXJQy1SZKSYtEY
 7i7IyuILF/evG8+rGCOWNhx82EZh1hiaimY7Yb5m2uvyGNDmUkhtZBC8RZ7n9qS7siVNyBQhr0
 Fz2jQZQzxNWFnRnd0++rZhZpbLH3K7+nLIKd+DRwkF1xj0FjrYIQ2p+6Z8Td1V9z59JiwoZoDe
 gFUBEAlXQUBLBwO64CaAWAXgCJAeLMHj8ESsg7oGSDFAtAEKIcuOAsN1uEfGMfxCzHJLj93AQA
 A
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
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, 
 Simon Horman <horms@verge.net.au>
X-Mailer: b4 0.14.2

This series adds support for selecting a netconsole egress interface by
specifying the MAC address (in place of the interface name) in the
boot/module parameter.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
Changes in v6:
- No changes, just rebase on net-next/main and repost for patchwork
  automation
- Link to v5: https://lore.kernel.org/r/20250220-netconsole-v5-0-4aeafa71debf@purestorage.com

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
base-commit: 0ea09cbf8350b70ad44d67a1dcb379008a356034
change-id: 20250204-netconsole-4c610e2f871c

Best regards,
-- 
Uday Shankar <ushankar@purestorage.com>


