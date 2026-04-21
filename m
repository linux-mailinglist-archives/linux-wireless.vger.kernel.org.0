Return-Path: <linux-wireless+bounces-35150-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKDABRKD52mR9gEAu9opvQ
	(envelope-from <linux-wireless+bounces-35150-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 16:00:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C87E43BAE9
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 16:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6165C306B192
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 13:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C843D9020;
	Tue, 21 Apr 2026 13:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkm7+f1E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F943D903B
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 13:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779384; cv=none; b=fSEOWm2M/4xDVJ+Pp0oyDqIxRpoPoAKVlwdL7hVr/983dqeYwP/q1qDpJ2Mst9mrT4D4+az6vqSCVtC88+w1clI/KnR9c0O5fMWlvizgeyNmHLFUVjumGSzHVz/U+x3TS7X+eDcSBL1miEKTpPQZj9qLsiXpzl4cELk/osD9w3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779384; c=relaxed/simple;
	bh=B7NZMyBwZc3gRKHf7YEeWdAsfqKrf2D7+zj60JNOwJU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q7g8+sbaDb6ZLy4sOylo8uT3CixfbyDJDQfGZyw0JUtId6ziSc0pbIJcyi4G7nGbIt43ENuwykJpXTqa8sCGIAM1LY2gfEGdjFwaGva2y1Hx8cU3F+0tkoMxhSIexKN7W2pVurNvKOMW3Id1kDLoTujuvTXmtZaT3vytPebwpxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkm7+f1E; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488d2079582so49735405e9.2
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 06:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776779381; x=1777384181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RqsYeIAsymY8PBSWtIO8Hx9ZTuCbYSbBMj/ZNznlX1A=;
        b=dkm7+f1EXXcZrQTEHjciDVbz4XIxH9++EpQSljJ6UE75nQVJ+ESE5Od/EGRSYMW5Nq
         aMQLH5Hs37DW8WYSa33PrZIP6RzuD+yqB/zAhGWOplxILjiO+/E9ma7vt9jt0JZjc6tT
         V2qludbFsYm0qmqAvyupNUqvNI1oGs5Ne9Zkf1TnId6rsqZcwssYdBvOhHtQrucf0SDZ
         sOFzHhvep8x8bEABUG/3NjO+jliE5MFpPJHohzCxSJJvVCZepupzDgn2tBDAOyCuUi50
         Si4kRHsFduRil7BqrPnyaaHSgE4fTJD/+nr5KeYryeXyLfUAOTgfhyMyDkPpl5l3eKwX
         75XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779381; x=1777384181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RqsYeIAsymY8PBSWtIO8Hx9ZTuCbYSbBMj/ZNznlX1A=;
        b=ag+shLWmoWqu1/Q6pAbBE4QZAFWU289uUfD5sLG8dYedRpbTIEr7OGnf+1al/r+/xk
         /rLO21Oi+Kn+W12VELdIDEoMFIPkyGakkUL26Ik57+Xd7vlDJN+YAiGqKwB2aYNxcy6V
         /uPQu1ClgxJqqUkWEARvq7845mADb38QlPQB9DruMXJcexhulLb4T5GaYfqCix8sG+Wu
         fNBCrH127LvqnFyq2W7X47uDwful4wWTj0dPB0ZKrPbbGjxmNNKnJl+CX2yU4rdCbK81
         mzKZnoe9QwLpPMfKgWSJQYLAh5WfzXwj4YX2IZyQ3ZZ9p1+kG/7xNBaWNDFG4tgXFa7F
         vIUg==
X-Forwarded-Encrypted: i=1; AFNElJ/tpmLLbtsaYCBdxe2xQf5WQrjzRN6/GmWfUG8JB8ZtOQ+8awvvTtCBZb1THyCWTNTxCMVlY7pzptnx3gZ+8g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGn2BJvzsmWFvsIEsDo6ZFFMtoxio5ZqcAJeOaLfhjxm30X7GL
	vN9AyFTJzFJ/mAAG4LbHZNEGk3Yl95q+MvSAgx3lpvXSIjZge3STremGnpI5
X-Gm-Gg: AeBDievPiupHE5brSnSgAWTST0S43ppIvB51N0Q6uuTnLeVDhnIM3IkQgkPcGkI0jM1
	J7D8byG3/C18NYgUNy72xyZtu/FL46UCcPlVEcueOqQOX7xOYNegfU16FU0ILIUf0YwBKuG77t6
	B6ODvX8pnvhT07mhdrE93DN7/9x4DSNvqazYUkU/Sdl+7axeyxXc0RligH5S/4L+R0TfFM+nTYG
	/LwboRJ9zM2/xfq0R8xn245KJQ0UWt5OhGF2TDKG3SHP4mMyoM9KFvKmG++NtPr0Eiogblti49M
	4SoQwGPaZPkHSYiNzcm0ewm9faEO54+Odm+rP349C9J0uUgrYAtBTcBh8yWZwnEm6GcI40YGMGY
	dSQWr5baqRaOFw0EN5wtg4vsyk0xeeSzqeUlnoGaOtqWzURrTo5LlT8G9NwcruKLFmiavpEp24r
	rGi0IxFyfbydk3PA==
X-Received: by 2002:a05:600c:3596:b0:48a:563c:c8c5 with SMTP id 5b1f17b1804b1-48a563cd1b2mr39226805e9.8.1776779380658;
        Tue, 21 Apr 2026 06:49:40 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb78becdsm176331185e9.5.2026.04.21.06.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:49:40 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Brian Norris <briannorris@chromium.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3 0/6] wifi: mwifiex: firmware trust boundary hardening
Date: Tue, 21 Apr 2026 13:49:32 +0000
Message-ID: <20260421134938.331334-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-35150-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Queue-Id: 7C87E43BAE9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

This series adds missing bounds checks for firmware-controlled fields
in the Marvell mwifiex driver.

Patches cover: WMM queue_index, ADDBA TID, station list count, scan
response TLV lengths, multichannel intf_num, and IBSS peer TLV length.

Changes in v3:
  - Regenerated from wireless-next with proper git format-patch.

Changes in v2:
  - No code changes from v1.

Tristan Madani (6):
  wifi: mwifiex: fix OOB write from firmware queue_index in WMM status
    response
  wifi: mwifiex: fix OOB write from firmware TID in ADDBA response
    handler
  wifi: mwifiex: fix OOB read from firmware sta_count in station list
    response
  wifi: mwifiex: fix OOB read in scan response from mismatched TLV data
    sizes
  wifi: mwifiex: fix OOB read from firmware intf_num in multichannel
    event
  wifi: mwifiex: fix OOB read from inflated TLV length in IBSS peer
    event

 drivers/net/wireless/marvell/mwifiex/11n.c         |  5 +++++
 drivers/net/wireless/marvell/mwifiex/scan.c        |  9 ++++++---
 drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c | 10 +++++++++-
 drivers/net/wireless/marvell/mwifiex/sta_event.c   | 12 ++++++++++++
 drivers/net/wireless/marvell/mwifiex/wmm.c         |  5 +++++
 5 files changed, 37 insertions(+), 4 deletions(-)

-- 
2.47.3


