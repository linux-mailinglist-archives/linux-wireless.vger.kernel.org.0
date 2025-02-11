Return-Path: <linux-wireless+bounces-18746-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EA2A3055F
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 09:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0D4F3A73A8
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 08:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00B11EEA3B;
	Tue, 11 Feb 2025 08:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vampirebyte-ro.20230601.gappssmtp.com header.i=@vampirebyte-ro.20230601.gappssmtp.com header.b="xFWN3v2J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f100.google.com (mail-ed1-f100.google.com [209.85.208.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889661EE035
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 08:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739261619; cv=none; b=NWalRHaEzcPJ+xt8oO3xf9DS3FUIG5TgjGD4GtZO2iQdFS0SlfOzvdxlEMrFzFlXADS8JcAMsPcju2z72OHdK2DebyYuIfXSPcRwFROImDfrqt2szRn8YqIcOIhsxXc3wSJfuP1bkEku4zWIxSt3svkPOTu/xoUsmYy9j99D5lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739261619; c=relaxed/simple;
	bh=FbosR9OY03Wj/RO51IaGbKrWy3E8NVaj4n1WOTJj4FY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kzvoK/uzvJ0yOT+SE0q8CgDGuAApx42m/JzCRlGezNYwOM4IuW6gzF7urXDpNd0nITj8rtMoNt7a0tvyKw39msdwAhRhKz3ArIh1XgMT9oi5M4CGNRZN+kJX+HFYTG0byOEWkQMkwU3bCpIJz8wcacEepBlHWcrwu1jNMtabrYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vampirebyte.ro; spf=pass smtp.mailfrom=vampirebyte.ro; dkim=pass (2048-bit key) header.d=vampirebyte-ro.20230601.gappssmtp.com header.i=@vampirebyte-ro.20230601.gappssmtp.com header.b=xFWN3v2J; arc=none smtp.client-ip=209.85.208.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vampirebyte.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vampirebyte.ro
Received: by mail-ed1-f100.google.com with SMTP id 4fb4d7f45d1cf-5de727f7f05so3409372a12.1
        for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 00:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vampirebyte-ro.20230601.gappssmtp.com; s=20230601; t=1739261616; x=1739866416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gd71ZVZ9MOLqcUoODHaOKfA+mXpMYX5siSyTn6mJgxU=;
        b=xFWN3v2JgBGJtQQq866sriGeZSIbsYwKReZZmwIcKz/TCNAB654mAiBHOFQkkDpp9M
         WEGpouzDEjUonk7QkS5XAxWUbGFUUVrQYQVfcgiYJ/JmcbQX+JX/FKJOfo4C0lyrKRLx
         0MgPIfLdGSWSdpNEUCLK5kfr7dEYR5JmHkOo5ATHYENIr7Ribs5CIu36DR/S0CUvdBYG
         Tcj8QzLLg4kGj90qIyF+EuUgMlLgz5YGDZMT+6I68DueuHm4+LSW4Lu4aPXQ87TUJClP
         43bpzR3fzIpkWV8plmfpUTar2h8cVi0JXh+mi9be06c6hXhVxxuVerfIAVz17KXlv6TQ
         wv1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739261616; x=1739866416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gd71ZVZ9MOLqcUoODHaOKfA+mXpMYX5siSyTn6mJgxU=;
        b=hGmb04BxLKrLiukxE4ox500M2nWboo0A+mgi9SVhqwss7sKyPeA5/FyXycr5C1hrgz
         i2QTHjakrPV1SSEhjmCmauqPiIG0QZA+vfh73SD7B7XM4ohczBz8dvHGbWaat3eHnMss
         1f/G2FiFG9hrVkSpP5mKN7g0Omo8m+0u3+amFPaOq02IUgJX7+J8Zi1xZebGpRQnfFaX
         /NVwNHqf7IbYZui4j6m7kc43NBarP1SnPTMd5hUtOVbL+k86jGE21glMYwTkNa+i6SGv
         p0YYWMR9Pr3/1IC3DDfC+GXh8F4jKPHK0e7L0sZiA7mlMhVlb39LDPR44Im8vDZhi0aM
         8+Lw==
X-Gm-Message-State: AOJu0YzhtmwPq6l5c/DlznEOcGtv+Haw09vL8mD3ugKJXvIokiI78TTa
	RjC3QAJFcVJEOTe2UUGtvsfScOpDzG1eEiR5TfbqBRMlgRMiAQZeuUABbrp1+Ut0ROcJwr+xAYB
	GmmrjS3oY6Kiws+7MSqOyra58+nWE9xImj4pd7y6F
X-Gm-Gg: ASbGnct7PvHYZZ7itcbLhD03zFg0+NUeVHkKkhSoBZIliJ03Yy9dYW2pg9tsuNKFEXl
	5fuMYEToQ+0zqw/riBeRoCYSP7NSOlQ9KYKGLUxGQtRlRnghBrYCx+32Qu3Ho0ZirXmAxUl3Fdq
	hPiU7RY3VTZLlGeuuhR9UkMEmD4L+ZPydRFnKnCWgRAEYvfUU57THGu9w4bMgb0/mdIqc+671MD
	Z+LFYLwrjFpD55jdO3wOUQMTNDIH31SXOtjdBgtnjLU7ylIaTMHFVpobW5kijhpzGMG7kjjD4OY
	vND11ik4M0d5dLUBJaOKgQv/sYykHw==
X-Google-Smtp-Source: AGHT+IGhn8scG4iDuYEyYL6s+O5L/HPVc1XALe0+pbl0IMbCtKXfdGKcVYepr1GqB1SI6WvKanjs/AnkeVAd
X-Received: by 2002:a05:6402:240a:b0:5d3:bc1d:e56d with SMTP id 4fb4d7f45d1cf-5de4508fa74mr16517720a12.31.1739261615361;
        Tue, 11 Feb 2025 00:13:35 -0800 (PST)
Received: from orin60.vampirebyte.net ([82.77.132.211])
        by smtp-relay.gmail.com with ESMTPS id 4fb4d7f45d1cf-5de57041c05sm222537a12.12.2025.02.11.00.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 00:13:35 -0800 (PST)
X-Relaying-Domain: vampirebyte.ro
From: Razvan Grigore <razvan.grigore@vampirebyte.ro>
To: linux-wireless@vger.kernel.org,
	Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>
Cc: Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Razvan Grigore <razvan.grigore@vampirebyte.ro>
Subject: [PATCH v2 0/5] wifi: mt76: fix returned txpower for mt7921 and mt7925
Date: Tue, 11 Feb 2025 08:12:42 +0000
Message-Id: <20250211081247.5892-1-razvan.grigore@vampirebyte.ro>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When reading the txpower with `iw dev wlan1` the returned value is
always 3.00 dBm, no matter what reg domain is set or if one changes the
txpower manually.

This bug was discovered by me and confirmed by many people using this
chipset on openwrt: https://github.com/openwrt/mt76/issues/783

I tracked the code for this and it seems that for those 2 chipsets
particularly, the mt76_phy->txpower_cur is never set, in contrast to
other chipsets like mt7603, mt7615, mt76x0, mt7915, etc.

Added some debug logs in the mt76_get_txpower function and I got:

[   26.816227] mt7921u 2-1:1.3: mt76_get_txpower: phy->txpower_cur = 0
[   26.816234] mt7921u 2-1:1.3: mt76_get_txpower: n_chains = 2
[   26.816236] mt7921u 2-1:1.3: mt76_get_txpower: delta = 6
[   26.816237] mt7921u 2-1:1.3: mt76_get_txpower: *dbm = 3

So the driver is correctly calculating the TX power adjustment based on
the number of antennas. However, the base TX power (phy->txpower_cur)
is not being properly initialized or set to a meaningful value.
It's starting at 0, so the final result is just the antenna
gain compensation divided by 2.

While investigating this I found commit ff94604 that adds a separate
function for _get_power_bound so decided to reuse it for all 3 chipsets,
might be needed in the future as well.

Tested-on: Alfa Network AWUS036AXML
... and it also reacts to manual txpower changes now.

Thank you in advance for looking into this!
R

Changes in v2:
- Fix line wrapping for commits body
- Added a new patch to apply the same cleanup fix to MT7996

Razvan Grigore (5):
  wifi: mt76: add mt76_get_power_bound helper function
  wifi: mt76: mt7921: fix returned txpower
  wifi: mt76: mt7925: fix returned txpower
  wifi: mt76: mt7915: cleanup mt7915_get_power_bound
  wifi: mt76: mt7996: cleanup mt7996_get_power_bound

 drivers/net/wireless/mediatek/mt76/mac80211.c       | 11 +++++++++++
 drivers/net/wireless/mediatek/mt76/mt76.h           |  2 ++
 drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c |  8 ++++----
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c     |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h     | 12 ------------
 drivers/net/wireless/mediatek/mt76/mt7921/main.c    |  7 +++++++
 drivers/net/wireless/mediatek/mt76/mt7925/main.c    |  7 +++++++
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c     |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h     | 12 ------------
 9 files changed, 34 insertions(+), 31 deletions(-)

-- 
2.34.1


