Return-Path: <linux-wireless+bounces-36481-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLNnMugSB2rgrQIAu9opvQ
	(envelope-from <linux-wireless+bounces-36481-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 14:34:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAB854FA6D
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 14:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B444230FBCDD
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 12:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4E747D933;
	Fri, 15 May 2026 12:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blEoZXIX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A6047DF93
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 12:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778847147; cv=none; b=i3uzROOityj2o/dbjEiloeEXfbM1TsgFY0bX/HbYd81OvyV20BwEZwumS+mQ6ZvypXMgamudyrUUr6ncfetZaVc2hM7kdb20Bhy+p97OyAiJRJwNA6omD8ENxMi6iE5Gpz/DsuaeZPaqKNc2u4xL+i5xSUs6EFaPv38bGFkn1lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778847147; c=relaxed/simple;
	bh=uc5kYuZZA9RiIxZC9rriOznMCqyKaWn7EEznJQhHSjU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hyvvyb7XIgvTvUogTWy5d95gwL+UHp4/xfyGrHO57IzA3v8APHJwq3OZHEWfUukLNFlDSup/uyv7vCDk2AErY3HbmDPjuV6+D1j0my0aXhie56OE4luwhQ8cBue00yTsFGQTJT/8mEdefMLJaErCS7BprVVJQP27BAK75R75PCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=blEoZXIX; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5148cbdea08so59718771cf.2
        for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 05:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778847145; x=1779451945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PY0lSVyvkzmzc7fN9FKWi5wDFGTOHaJFrAdLdvHe3WY=;
        b=blEoZXIXaWenDIzkHYQwJtvR1sKbI8h4W33fTG9fHiE1L8zN/17ITG2k/alBpLSuF1
         uB1akGUQ2w8GcdbFpD1hFvVMDW5BBCKFmvQj2865KHfI6ETstK3RVvYNIN5MdwQXVhZG
         DSp4UtJ+nA8/gqDEM3mv1hCfKspQSEGx8tWQG1IKXlUE5enkLF6PU6BwmzPt9Bwh4uvR
         kfylEIDnIJRdZOcthtcv7iunfVrulOMtfPijO8eZnzX2tDpC+hBj/fCc21E+3eZPwyxi
         kH5sRB6G8I+myaTorhL+1alPNzJHoO8NnLd+MkhKT94MhfHSEaZIbX2XXtUxpz2SFm0q
         Jy0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778847145; x=1779451945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PY0lSVyvkzmzc7fN9FKWi5wDFGTOHaJFrAdLdvHe3WY=;
        b=QWflAQ/UKXBe4GlFs2s3ZIAndaW9P5D+VBPGrAN68zFf4QVPaoaxyZGtx5zmWaoHfY
         pfDqyERU1PTAO0KaN/HzOm3CBOTm2cyaZM/KUOzmvEvz7pUS5ElayExbNj3/1z2VatsF
         jhMFOr+fzEBcH5F72xAS+Gm0l2t/6BgKbLlYdSRwmXfBpfSVh48D209pqNmFrMVAGY2g
         nwopzKIk+c+4fhOpiKJfZEDpS2q+lJkmZL+H6Ww4pTrzdJau342Hopr5/Z7sXGcKjUkc
         fw6xsQC16bOQLnX6NXr7t46x7a5I6GbdA/Fj8MYd6BzAluyIbu+FG5Vk/8vFcogJGVah
         967Q==
X-Forwarded-Encrypted: i=1; AFNElJ+RENcIWGfm9a0swoySLCXexMImNf7u6rz6gFQmIeb3+Lfd3cIIbZduPYxk/gIaibl2BzTN7G55D/CGnBFsjA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi7LW0DMQAuGZQvfgB+P39BdwxPm7VWiOWU5rzHEsjBb/Sqehj
	wmF5E7VLy+5/cbh9tGuROzCSSKNEY+wgevicRN99xJYy/wyTIf2IU8kH
X-Gm-Gg: Acq92OGDsWSbwDWhUJKncHonzBiHI2x57Qihah37PEy5LfCdn+Iwrrnvd5Cy4gnGBit
	/IXrZMv+p/8mAJ3mwpx4e+45zbJEQ6X0ninBep3grLTf7y2NB01J9NAxOIdAoGBhNeM2Z+hU7d2
	ou41Ysf1sJpihCeSGAYIK+GVcdZgPqVQos08O3V31ImtJqKXYhwlpQvOrtca0abBKx+IMEyjosk
	++4QHg9KtB31ej/ncyTbt8x5vSYSWmBzZqC3e5RBml8oj8NdT6QvFvSARl7RzrWBQVVUYywgQw/
	Xf09ylkZ1PwRVk66Yi83xf8tSdUPWYmr+sILTeWSZ3vzxoOTUi4sTb9AO1be63NVfsas57p2INL
	/1amxTOm3AIe02AWOeAzYlllow0+UzbBFLmc1KJs2+0h2yABfml5dk8AHNT8C6kDa8aFE38Vf0Y
	SLHJaOcVWUpSZb4wBp/15UkyhPbcSQBwQEE4JtBig8y5sraEMuNpbaZQgT4D736rdHA6wh53Blc
	9EoOMIqiPC2jIpCOGyaMOCbrT0TLRtGQmrBeonxXNEsFF/E0xwMOA==
X-Received: by 2002:a05:622a:4108:b0:50e:5cc3:6f42 with SMTP id d75a77b69052e-5165a27a8acmr46595211cf.59.1778847144385;
        Fri, 15 May 2026 05:12:24 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456888f6sm45534491cf.3.2026.05.15.05.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 05:12:23 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 0/4] wifi: iwlwifi: harden netdetect resume-path parsing against firmware-controlled inputs (mvm + mld)
Date: Fri, 15 May 2026 08:10:56 -0400
Message-ID: <20260515121100.649334-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5FAB854FA6D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-36481-lists,linux-wireless=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Four defensive bound-check additions on the WoWLAN net-detect
resume path in iwlwifi, validating firmware-controlled response
lengths and bitmap-bit positions at the host/firmware trust
boundary. Two patches each in the mvm and mld op-modes; both
op-modes are live in current kernels (mvm drives 7000-series
through pre-BE200 hardware; mld drives Wi-Fi 7 / BE200+ when
CONFIG_IWLMLD is enabled).

The series is in the same shape as the recently fixed sibling
commit 744fabc338e8 ("wifi: iwlwifi: mvm: fix potential
out-of-bounds read in iwl_mvm_nd_match_info_handler()"), which
landed in stable on 2026-04-11. Well-behaved firmware should not
trigger any of these, but the host parser should not depend on
that.

Patches 1 + 3: length-tail guard on the firmware response.
iwl_mvm_netdetect_query_results() and
iwl_mld_netdetect_match_info_handler() validate only the fixed
header size of the response/notification, then memcpy the flex-
array tail unconditionally. A response of exactly query_len /
sizeof(*notif) bytes passes the guard and the memcpy reads
matches_len / NETDETECT_QUERY_BUF_LEN bytes of adjacent slab
content. KASAN reports the slab-out-of-bounds READ "0 bytes to
the right of the allocated 24-byte region" in the kmalloc-32
cache. Same fix shape as the sibling.

Patches 2 + 4: clamp the channel-iteration upper bound against
the netdetect channels-table length. iwl_mvm_query_set_freqs()
and iwl_mld_set_netdetect_info() iterate the per-match
matching_channels[] bitmap and index a channels[] pointer table
by bit position, without bounding the bit positions against
the table length. The pre-existing caller-side guards compare
popcount to table length, not bit position to table length. The
mvm path iterates over the full 0..55 bit range; the mld path
is accidentally bounded to 0..6 by a bits-vs-bytes confusion
(for_each_set_bit() takes bits, but the call passes sizeof(...)
which is 7 bytes). Both can index past the channels[] allocation
when the user's net-detect configuration has fewer channels than
the relevant bound. The wild-pointer dereference of
channels[j]->center_freq inside the resume work-queue then page-
faults the kernel; a KUnit harness exercising the mvm shape
panics with

  Kernel panic - not syncing: Segfault with no mm

and the mld shape panics identically when n_channels < 7. The
mld fix folds the bits-vs-bytes correction together with the
clamp because applying only the bits-correction without the
clamp would widen the OOB exposure from j < 7 to j < 56.

All four bugs require the firmware to produce inputs outside the
implied driver contract: a short response (patches 1, 3), or
matching_channels[] bits set at positions outside the channels-
table bound (patches 2, 4). Well-behaved firmware should not do
either. The patches add defensive validation at a trust boundary;
they are not a claim that current Intel firmware misbehaves.

Reproducer: self-contained KUnit suite that lifts all four buggy
code paths into standalone harnesses (no firmware or hardware
dependency, ~10s on UML). Patched-shape subtests pass cleanly
under the proposed fixes (test_patched_rejects_short,
test_patched_accepts_full, test_set_freqs_patched_clamps,
test_mld_match_info_patched_rejects_short,
test_mld_set_freqs_patched_clamps).

All four patches build clean under x86_64 allmodconfig with no
new warnings; checkpatch --strict reports 0/0/0 on each.

Michael Bommarito (4):
  wifi: iwlwifi: mvm: include matches_len in scan-offload-query length
    check
  wifi: iwlwifi: mvm: clamp set_freqs iteration to n_nd_channels
  wifi: iwlwifi: mld: include matches tail in match-info length check
  wifi: iwlwifi: mld: clamp netdetect channel iteration to n_channels

 drivers/net/wireless/intel/iwlwifi/mld/d3.c | 20 +++++++++++++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 10 +++++++---
 2 files changed, 22 insertions(+), 8 deletions(-)

--
2.53.0


