Return-Path: <linux-wireless+bounces-26017-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A1FB11F4D
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Jul 2025 15:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 976681C84BC2
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Jul 2025 13:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330AD2ED16A;
	Fri, 25 Jul 2025 13:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="hxShd0ts"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D42246780
	for <linux-wireless@vger.kernel.org>; Fri, 25 Jul 2025 13:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753449761; cv=none; b=p2avpCqZ9nqJZAhf4kXrsELnTyLoDfnei9ePaSeFF+emTMlvLnVQSuROVNtfTMVDfZnDEVtHsYU7HHTfojT81CLSf2rigbsjT4bbcS9niOX8msPvgXK33s93R1eQFkfencuIr/Jx4oa3aR54fhGnSEI+/4fI7x9604bty9JL/H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753449761; c=relaxed/simple;
	bh=HkGHjuYZdKi992dyK532b4Be1seh1G1ptTt3OrQGbHA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CVoFtxnrMZBqYZiWkyQxvhAodXcR6DuQZ+oxSCbPwHBxwoiKgeK5dhhoczOZP1uSdDOauFVM4F4yGz/68LpYEK3vIfw5nd/m3KuX3sJIHTp/bBUguknG+i7NaCiwKr8k7sc3dPOOK+MiHApNcpeuDOjUgJjogHyINCgFdpLMaZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=hxShd0ts; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2352400344aso18351545ad.2
        for <linux-wireless@vger.kernel.org>; Fri, 25 Jul 2025 06:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1753449758; x=1754054558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CV5Th9DyOMNkjWKK511qR1uw7mWlKHouvYG6lDdAtNE=;
        b=hxShd0tsfJ9T7o0ISoE+G/xXKwIoV6IHmnWXYc50vcZtuT6Rt8R9cswXav3jboIJ3c
         21kgrEtKxXLD3LsAaJ0aQddebZ+9dBYxioTdX7hpiusVXi2bXcb3W4ar6hXmgwUOO2BH
         cX5qXLBSkgj31CcwHuXtjybllOoGL6slcFxIXGAqd9TtbvdH257oIY8myaf47Tl7vgJd
         +uvA4bIeo/KJbAme5bLEsIqn5ahF2bSw/QV+lpuVXZSgChh0ce7rQM6WjGuf8I4WS2cS
         9bPIu1BsBBDDDwT97eA7k3fxzhcOy5DoZo3SRkahYMLs/IZ5+0honWK6TNkXDRIP0MYi
         kiPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753449758; x=1754054558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CV5Th9DyOMNkjWKK511qR1uw7mWlKHouvYG6lDdAtNE=;
        b=jC78KFRpjiP7weIja7gHvEvJgnr/fw2Orq540/jZqIcVqFID7gNEI5kOo6joirsWYE
         RTDb9LkHwddDpxP4VX/UB7Fh/ltPEJB3pNkMOuXzGkHcYSzRnewfrOG/OxfB4CtDr9j+
         gUw1WXRIgAEhnnfMbFQJD+p77v1hNZ5sx2lMXHQ7VuGVp8wdFC/7JfnIhsBPmFEmMHl6
         A2I2gYlOCyrSf30mkLePZwfI2HcTC+FArafhcs+Hstz7wQ4KgjItS+d5X+aDsosuRVU3
         NH2CkMmdhWHi2NEVXdYsyLmlM5SftYYNF/ndILXESHKLDE+9seGVcU3WG3oycEQIfGfq
         /bTg==
X-Gm-Message-State: AOJu0YwNf3pzGj9P3eipK1TTffxyWbExF2k1VBUYMkiC6RD8IHYMm19Y
	9aO80+AzYv38AxBNW8Ek4UrCAcPMlz7n8hfc/h/5xi9ZIA49dAD53udoiKMf/BSYMy4=
X-Gm-Gg: ASbGncuEFZOxWt22m4HmL6cDhxF8Qr4wgITlQUYbInpAtCyusV5Ol83k99jA7bMi23b
	5/pN8EIn4JbwX5u3ZD+FwsuNB1U6uYxmp1T+l/CPmqiIIJaMatirV0MYuUbAZGLOJ6s+QreiePO
	Y7J+M8EUmzWeIjodmac7oO9Lx+f33yZxL3AOIikaVkFnmsbHzsilLVst5sQQNLKOcACFN2MbQQt
	SztUj6Hcz//yI7iQun/8+3jqbxrKmkFiASK98dCH2XwalGQa3+gS+qvZYu6Vi3j/HTJBapGGOy/
	bO21r3ks9oR+b/w0ujUGti+mad1KrSACNWCgvZ79+eFiqajQZNUyzkFrrffl5DcLFEfvFF37pjB
	5uumy+nIiVY0U79CugXSKlkPoDWXIbIrJKkUMCtCq0gynrPRJwA==
X-Google-Smtp-Source: AGHT+IHCJuB7ijO4X/wuK0pjXTo5m+F9OE3+8/TN2lJcnSjVcPUAa6mtpBKY/HE4hRNHbm/go7HoRA==
X-Received: by 2002:a17:903:19e4:b0:231:e331:b7df with SMTP id d9443c01a7336-23fb3125d4amr38418665ad.29.1753449758176;
        Fri, 25 Jul 2025 06:22:38 -0700 (PDT)
Received: from mma-H9MHD44.lan ([101.180.88.40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48bd625sm37117665ad.122.2025.07.25.06.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 06:22:37 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [wireless-next v2 0/3] wifi: S1G TIM encoding/decoding support
Date: Fri, 25 Jul 2025 23:22:18 +1000
Message-ID: <20250725132221.258217-1-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An S1G PPDU formats the TIM differently compared to non-S1G PPDUs,
meaning in order for an S1G STA and AP to correctly coordinate
power save, the TIM PVB shall be encoded as per IEEE80211-2024
9.4.2.5.1 Figure 9-213.

v1: https://patchwork.kernel.org/project/linux-wireless/cover/20250722071642.875875-1-lachlan.hodges@morsemicro.com/

Implementation Limitations
--------------------------

The primary focus of this patchset is to enable mac80211 to encode and
decode S1G TIM elements for the purposes of supporting power save. Due
to TIM element length limits and no support for page slicing, this 
implementation limits the maximum number of associated stations to 
1600, rather than the 8192 allowed by the standard.

Encoding
--------

This patchset extends support for mac80211 to encode the TIM using
block bitmap mode without support for inversion. This is typically
the default choice for hardware vendors, and helps to constrain the
scope of this initial patchset. 

Decoding
--------

In v1, we only added support for block bitmap decoding. However, to 
ensure interoperability, this patchset includes support for decoding
all non optional modes - block bitmap, single AID and OLB. As ADE is
optional, it is out of scope for this patchset. 

Unit Tests
----------

Given the complexity of encoding and decoding, unit tests for the S1G 
TIM formats have been added. These tests come directly from the examples
in IEEE80211-2024 Annex L and cover block bitmap, single AID and OLB
and their inverts.

Changes Since v1
----------------

(1) Move the macros that define the max S1G AID and block count to
    ieee80211_i.h from ieee80211.h as they are _not_ standard supported,
    but rather an implementation detail for current mac80211 support.
(2) Perform validation of the AID on both the AP and STA side. In v1 it was
    just done in the client. I'm thinking this maybe could be done on just the 
    AP side, but Im going to leave it as for now.
(3) Added a comment to nl80211.h on the NL80211_ATTR_PEER_AID attribute as API
    documentation noting that S1G AID is limited to 1600 for this
    implementation.
(4) Cleaned up the encoding path, based on feedback. Removed some
    unnecessary validation, used struct element, made the caller responsible
    for setting the TIM length, and adjusted some comments.
(5) Added kunit tests for S1G tim decoding. These are the same test cases
    seen in IEEE80211-2024 Annex L.
(6) Added support for other decoding paths. See below.

New Decoding Path
-----------------

The decoding path now supports all non-optional encoding types. This includes
block bitmap, OLB and single AID and their inverse. ADE encoding is optional
as per the standard and is not tested by WFA, so we have opted not to
implement it.

Before explaining the implementation, it's important to note that the standard
makes no guarantee about the ordering of encoded blocks. Hence, as interpreted
by our resident standards contributors, we must parse all encoded blocks until 
we find one with the target AID or exhaust all encoded blocks included in the 
TIM. 

First, we intoduce some helper structs to store the parse state and also reduce
the parameter count we pass through. The struct s1g_tim_aid allows easy access
to the various offsets calculated from the AID. The struct s1g_tim_enc_block
contains actual state, and is populated by ieee80211_s1g_find_target_block. 
This function is responsible for enumerating all encoded blocks until we find
one that describes our AIDs block or ENOENT if there is no entry. It will 
quickly decode the encoded block, check if it describes the block that our 
target AID resides in, and if it does it populates the struct s1g_tim_enc_block. 

Once we are at the encoded block that describes our AIDs target block, we
decode it based on the encoding type and check if our AIDs bit is set. This
also includes dealing with if the encoded block is inverted.

While I feel our implementation is fairly good (heh) there are still some
quirks I'm not sure are the ideal. Firstly, ieee80211_s1g_find_target_block
currently returns various error codes but the caller handles them in the same
way. Should we also include handling of a malformed TIM?

Lachlan Hodges (3):
  wifi: mac80211: support block bitmap S1G TIM encoding
  wifi: mac80211: support parsing S1G TIM PVB
  wifi: mac80211: kunit: add kunit tests for S1G PVB decoding

 drivers/net/wireless/ath/carl9170/rx.c        |   2 +-
 drivers/net/wireless/intersil/p54/txrx.c      |   2 +-
 .../net/wireless/ralink/rt2x00/rt2x00dev.c    |   2 +-
 drivers/net/wireless/realtek/rtlwifi/ps.c     |   2 +-
 include/linux/ieee80211.h                     | 265 ++++++++++++-
 include/uapi/linux/nl80211.h                  |   3 +-
 net/mac80211/cfg.c                            |  10 +-
 net/mac80211/ieee80211_i.h                    |   8 +
 net/mac80211/mesh_ps.c                        |   2 +-
 net/mac80211/mlme.c                           |  22 +-
 net/mac80211/tests/Makefile                   |   2 +-
 net/mac80211/tests/s1g_tim.c                  | 357 ++++++++++++++++++
 net/mac80211/tx.c                             | 166 ++++++--
 13 files changed, 777 insertions(+), 66 deletions(-)
 create mode 100644 net/mac80211/tests/s1g_tim.c

-- 
2.43.0


