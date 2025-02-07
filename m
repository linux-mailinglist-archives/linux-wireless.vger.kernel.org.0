Return-Path: <linux-wireless+bounces-18619-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C19FA2C24F
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 13:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 306B0188C9C4
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 12:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341601DF740;
	Fri,  7 Feb 2025 12:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQgbgoXz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6934C1A8413;
	Fri,  7 Feb 2025 12:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738930523; cv=none; b=tMl/333lAJ0Us1xpfhsCzS9lPQFrsaw6qgDKB/gZ8DUE+LmLlpTRqJkRIXdLIdB0rSr+sOUlsUqJNWpceGQtPRH8jNjgFA3WSVV9PQWQxAfPtqmEE2pNyDgoeOSAjCWLYmrSqDBr5KiM+VFUp2Sw7pzgM2XXDEn4LSk7duSuHDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738930523; c=relaxed/simple;
	bh=3dM7ZVXm/AaaoCi6WnfD5D/IKlvwLjMOha/C0QH5HqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y2Jdlq1d9VEQmFnR/VtqYQS+sap8xy0SWEfXHxKaxu1NI2SNsmQPX1bJm0Nz7avBdUS0lXb8atpcCN8fV/F3VZOCl2n83Y8XeBDVweGA18T3EGpyhIuxJh4qezRTKEFP/csktlQSNJs7yrNeU4PR446WA94hYH6qoJoDFlQor3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQgbgoXz; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-436202dd730so13555405e9.2;
        Fri, 07 Feb 2025 04:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738930518; x=1739535318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0MITiMOb1RZl0MqyVlv5O3XOrpALqXOepMg6Lx0k8Pg=;
        b=hQgbgoXznud9zN4XvaKnUC7fKhEK5igSJozu9JP/uFDjb3ulfOq1vlPFM16zz8Vemz
         6Hq86BxJnWVgOo9fjAVsM5YRrRnSbBrHepCNc62uo2dhlyZYMW+4uNkeYvY0yECiWPMM
         7xh8j+/crzxzaIeRpzkeU/fh4O7RefnJVMXr1Y2JrkLBL1ZciYpqXUpP/ppQbeo+cFK8
         1kqGKTH8QBu12QJS3Yvq+wsFmxo+8PjJLgtAL6sI0saKmdm7g+TWWe840PdTtOQ/YqZl
         dKNH1z40qCVvGHB1+ZCjW35e8hoeJmm1kq5jQIYOeRAY7+D+7B+lwv/cKNL0hpmh+FF6
         UiBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738930518; x=1739535318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0MITiMOb1RZl0MqyVlv5O3XOrpALqXOepMg6Lx0k8Pg=;
        b=J864bdCHbEFacBW6fVMJXfjO2BvwdqmhLC8344BnBUNKjLe9oartZsfLPHLsgFQCMW
         bF4Nlk3ZxSYXwkbUbdydvQARUjBbMx+g7IVCO7qWFuddPMnfLJWoZAF+EWfgnWMXBx9L
         RQH4KLEUNXXiiVNVvQnFZ/OSqbTtZ2f8tt6UfpTLCoi6H26SMyYND0ULAVdXXH7LgZOe
         y6lUhevoTtu7rOC1pfRPpuUeN7KS5SmLDI/4Ns0tA/bLIsmuWuQfebHUZMRxN8MMVh1N
         17hsHzTV3vzSLUM971jn8TBochHDBtLW7Kyh3dM0v/aHQYlqyI2ED7wOyOc4AY5keKqH
         SU1A==
X-Forwarded-Encrypted: i=1; AJvYcCVaBwm7ax+jWHeSc1zJ0GLulBmhlxHB+/67qsmkmCGuVETZOgD219xDfg8QR3r017It8hZegUwpMDs0rgUtkw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxocaupb1sbi5ogBkNOvqAHMLdIPMSIrGc/rc+O6Vc3JAipT+hM
	LFRGUmFM4/3SPE2AbLtB3ZeWmDogo01hNuGsgGQlHd8BRk6L+dM851nQig==
X-Gm-Gg: ASbGncsvOCFQpWAiVuxR5EshDwDtGxsZtxgrBltIn2j1d6qRrx7FIPAanam96VVgAbp
	6gpX888V4+6Z+yI3evfo2ILe00f9H6cAbFKR7zzKaj5TFghO6ZroPvc4X53QdLpDDHMeVH3yzCa
	Sk763vxCTCfexSqGCNKN2LvF2ZfBo8frWEntqvf93uhTiqeBby/9KXlGAC0LwzOJ+NF4pPqyhhE
	cvUPOg0jlg58ziUWpiOHOCaL6z2d6LH17zqsNT8goWlfRhT6JSlU1I7/ZzvWKkMajJDYwb9IiE+
	++P61+BhAs2A9HfNUsMeVrkFPqbny0RQ3A==
X-Google-Smtp-Source: AGHT+IHaHfzbzXJnvha72lkVMDQ8Y2H0EuEsAci7MIAjVhS9rpXOcEM/LeHkMyqjJzxDzHp3vCZfZQ==
X-Received: by 2002:a05:600c:1f16:b0:434:f8e5:1bb with SMTP id 5b1f17b1804b1-4392498d9b8mr25764705e9.12.1738930518073;
        Fri, 07 Feb 2025 04:15:18 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:ac43:c7d9:c802:8ec3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391dfc87d2sm51555035e9.26.2025.02.07.04.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 04:15:17 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v4 00/10] netlink: specs: add a spec for nl80211 wiphy
Date: Fri,  7 Feb 2025 12:14:57 +0000
Message-ID: <20250207121507.94221-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a rudimentary YNL spec for nl80211 that includes get-wiphy and
get-interface, along with some required enhancements to YNL and the
netlink schemas.

Patch 1 is a minor cleanup to prepare for patch 2
Patches 2-4 are new features for YNL
Patches 5-7 are updates to ynl_gen_c
Patches 8-9 are schema updates for feature parity
Patch 10 is the new nl80211 spec

v3 -> v4
 - Simplify the leading digit check in p6, thanks Jakub
 - Fix a typo in the nl80211 spec, thanks Johannes

v2 -> v3
 - Updates to spec and codegen to clean up compiler
   errors in generated nl80211-user.[ch]

v1 -> v2
 - Add formatting hints support to patch 3, thanks Jakub
 - Raise exception for unhandled hints in patch 4, thanks Jakub
 - Update nl80211 spec w/ split-wiphy-dump in patch 7, thanks Johannes

Donald Hunter (10):
  tools/net/ynl: remove extraneous plural from variable names
  tools/net/ynl: support decoding indexed arrays as enums
  tools/net/ynl: support rendering C array members to strings
  tools/net/ynl: accept IP string inputs
  tools/net/ynl: add s8, s16 to valid scalars in ynl-gen-c
  tools/net/ynl: sanitise enums with leading digits in ynl-gen-c
  tools/net/ynl: add indexed-array scalar support to ynl-gen-c
  netlink: specs: support nested structs in genetlink legacy
  netlink: specs: add s8, s16 to genetlink schemas
  netlink: specs: wireless: add a spec for nl80211

 Documentation/netlink/genetlink-c.yaml      |    2 +-
 Documentation/netlink/genetlink-legacy.yaml |    5 +-
 Documentation/netlink/genetlink.yaml        |    2 +-
 Documentation/netlink/specs/nl80211.yaml    | 2000 +++++++++++++++++++
 tools/net/ynl/Makefile.deps                 |    1 +
 tools/net/ynl/pyynl/lib/ynl.py              |   46 +-
 tools/net/ynl/pyynl/ynl_gen_c.py            |   28 +-
 7 files changed, 2063 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/netlink/specs/nl80211.yaml

-- 
2.48.1


