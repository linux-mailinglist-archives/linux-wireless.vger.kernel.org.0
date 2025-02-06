Return-Path: <linux-wireless+bounces-18571-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B07A2A005
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 06:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FB531657B0
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 05:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DA8222595;
	Thu,  6 Feb 2025 05:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="L1RYws3h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f99.google.com (mail-ej1-f99.google.com [209.85.218.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02A2222584
	for <linux-wireless@vger.kernel.org>; Thu,  6 Feb 2025 05:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738819296; cv=none; b=PUNfCMwF+v/iunPHO/mCpyqWDgEsxJA/RlOYyKOcl7ZwlwwMWN+/nCMlTegMUI6QE7Stl77AAekDEXILuGsskGOjygJPrxlKh514yhWIh+Sqmm5rquAMHeHSmdSmS/ec+8igXZ0xcZW/bgUSWxJSuFtFER8J8Ol895LB1ZS2Cak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738819296; c=relaxed/simple;
	bh=tD0jPSjeireGMUVJpEk191Ij0UrSQYkMyCej9+UGqCM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Y58PeOqwMA0Oy+0B1H1MHPm1R0QpJJ/OIEc2wiZ7pzMNoeUmzX0Jw8oeGuEKFZfIRV9UY0Xm9QvJ8//trYm3yupg7myIi6ALKHrb6ggvHuki38tBLeeIDdyJaCis7N7dqqlEviOiJgrKEcdBNYKkABNMwDYQCxUcdjKW0iAyi78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=L1RYws3h; arc=none smtp.client-ip=209.85.218.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ej1-f99.google.com with SMTP id a640c23a62f3a-ab68a4ab074so89238166b.0
        for <linux-wireless@vger.kernel.org>; Wed, 05 Feb 2025 21:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1738819293; x=1739424093; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4i5yioVGSNjOB6nllSMZrYXzyChtuKnMnYZxXLntPc8=;
        b=L1RYws3hRPx51SRfPn2cH8Tzfprkeuk7fBBr5oCfKg30XRgSQJBHT94hSUZ9wYyPhj
         5c+flXqZJQaIbcmdyMlMEHt/UOueb4czqOW2WOkfcbQuDiQj02yGuBDyj4T4l44E/E4m
         iumIU1H00YboPDELRolwlGfd3NucctDhdjqer+ugbQx6wQHKonJCejenG5JWuYwwv3/p
         P60QU4V9WT90TzWMFwfgyGIm3aw97fHFuv+eQgns8p0dbSE7Nk8CsjhHs6PzwyQAS26U
         L3Zzrh1i73zTCgsV3N4Nu+ZBNA8Zs2PmZX8bUh382n8YI2RSrw5Tfa7sCFKvr4eSboDm
         IsbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738819293; x=1739424093;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4i5yioVGSNjOB6nllSMZrYXzyChtuKnMnYZxXLntPc8=;
        b=HqJCmtfY3f4eyY0mWMQbDNv/aGaY8JBtVc2Fl6s3gk8wIk4KCCyC+XQU8sGGu9UQI+
         J44m7eeL0zjd769n3anwQVV1Bvg5Ii5fCyVzxyduWCeOlR513e5peoHPCAzZCwtLhqOc
         aTNIptX+yJtyKg/FL08qZ4ta3UyjD7mn27Sx5piX+GTPvGX5L8snOWRMYdNKPbCENgOZ
         3kU5CM8Oi+zcMm6Q3ZIKTB8VTvGahWF4oZwu0oS86OQIRuIck3Fk5hcXh6Ko/IkeJ/dB
         ThKMGWAHOpc4xextBKcRJr/fgiK8WP/XyodAPhakKGLV9kSvksB3g2JwLcRtrSqrcGxJ
         nzHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfWSahHmhCUTScee2EH/hesTOoVb7b1kuB2iRcVZfXrA4JBzQDynlSVbcD1wMJXx6yW8RMbBHfNrnsl1LE/A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5/d/EN/x/Qj1xzYueIDMt3S/x7Ybp167Mpw88zgSMKug3/50/
	BYTH1KNttxeM6ILS7fjEe5hmUI/BK5RFoC5ywiSm6sM5UMkHu35ULF7wQk3j7FGlbkgcpodWdAr
	7pkODHMbM7sceJJU/yok35EjCuwAE9oCmXBot9YsC/2X/IktV
X-Gm-Gg: ASbGncspvkFrQIU8WeZCW01JuYKmUlY2wS6RxQbYcbStO4S3J6vXRSJk3OnixvztRov
	uD6Jl+5aLYDux0p+6eDVTFLjdLtNu10QxGtm+kjGJrl9dpqHv6uf3ztF/R12dWRAIdjSM9UEhsn
	Vpil53ziIw4uXmHmxgeocgZM3UFf5pjuMCxxbmmLKNG+KUzY9dECjJfNIFTNALghQlHGyo4enU1
	EodL014Us0L05r7be6+qDCJw6M1AzRccwPjG2SxCEvDJ3PSs1cC5W7jPe4C3Ai+8BbCZBzeihf4
	EnZQz+l3TE3KmcgXFCwaWSXg
X-Google-Smtp-Source: AGHT+IFOIG/YV363yDXzTKiSu5f4bXzuXXAiuDbR1hZzAdQ19I1MKpWy4urmJ0wIV6IAB/oXbPlTS9cEifIH
X-Received: by 2002:a05:6402:234e:b0:5dc:7374:261d with SMTP id 4fb4d7f45d1cf-5dcdb6f9f81mr13341977a12.7.1738819292518;
        Wed, 05 Feb 2025 21:21:32 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id a640c23a62f3a-ab7732e281dsm1194966b.130.2025.02.05.21.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 21:21:32 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 3D3793401E5;
	Wed,  5 Feb 2025 22:21:31 -0700 (MST)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 30E27E55F4E; Wed,  5 Feb 2025 22:21:31 -0700 (MST)
From: Uday Shankar <ushankar@purestorage.com>
Subject: [PATCH v3 0/2] netconsole: allow selection of egress interface via
 MAC address
Date: Wed, 05 Feb 2025 22:21:29 -0700
Message-Id: <20250205-netconsole-v3-0-132a31f17199@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANlGpGcC/22MQQ6CMBAAv0L2bM2y0mo88Q/DAesWNtGWtNhoC
 H+3cPY4k8wskDgKJ7hWC0TOkiT4AqdDBXbs/cBKHoWBkDQSNsrzbINP4cmqsaZGJnc51xZKMEV
 28tlnt67wKGkO8bu/M2327yaTQqXZab5rZ1CbdnpH3tJ+4KMNL+jWdf0B5YeS/aoAAAA=
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
 Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

This series adds support for selecting a netconsole egress interface by
specifying the MAC address (in place of the interface name) in the
boot/module parameter.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
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
 net/mac80211/debugfs_sta.c              |  5 ++--
 9 files changed, 60 insertions(+), 21 deletions(-)
---
base-commit: 3924fa995cdf3752f2f89f8de72834c4638c5ebf
change-id: 20250204-netconsole-4c610e2f871c

Best regards,
-- 
Uday Shankar <ushankar@purestorage.com>


