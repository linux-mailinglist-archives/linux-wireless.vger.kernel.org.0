Return-Path: <linux-wireless+bounces-30992-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5BCD3BF30
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 07:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 35127354532
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 06:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A72236D4FF;
	Tue, 20 Jan 2026 06:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNvsZae0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A115E33C1BD
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 06:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768890540; cv=none; b=jN4wr1gOvIrGvnyX3VJxdTMmzvg6GxydqtVbt5XgQeIOGY0tRhZSmYJzgDWQHCjOX1mwqYZanNG49x7c0Rg5n0bwwUu1Sr3qOGs0GZjsDiU95yj6A4gKvZJIpvLvciDIjcEeBD80+pU6/rmcvVQ3R2gFeJv365MA5UJ4DSQY1M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768890540; c=relaxed/simple;
	bh=cf6IGNMMMwXticxB+OfAHFQxcYExa32hB22vyjEMBAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jNXlLSHHFrGZ5vihDLrr4NgpXMGN2qFZ6Yr1VSI6EeeR29qH2Yhfm0QT2+skTaDEvVh98ZTxaKE+O7A2ClFtSz6UCLeyohNyws5dmpfrnySqinxb+aGxR/yyhRjT8f/qGKmVz/j34GgQd6wvUu3GXiegPHxhuscZTh5G/n1q4DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNvsZae0; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2ae29ddaed9so2898750eec.0
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 22:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768890537; x=1769495337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YznedogKosCYjQoxhmZaws4K9eCkq32zETWn/NeO/UE=;
        b=GNvsZae07r9PFfsyRE30OwIfMWfbjvQSnhWShXOOiYAMXHtcWPJ3m9OkA2sFadnGdw
         fiT9fuRxJGodb0NLjANKiFCutMsN/mqBAGq7Xh8iBCHuJiNlKiy5qCePoUKxdMk4sbEg
         QvNHHhTG6DdgbF537biavjYJBPb63Ye2ZArnxNEpj/lhdkg2Tr3TWGhEXpCND9IscMn2
         tRmFLapIJ0ITtfoy87D+wpGrHHO/UOGwsprUwcJ5R6/r5kkUCp6k7aGpemMM5TjWWrFB
         c2aVzTf46ljyhg5pyVwD84Pb9cVdZaZ5Y4MQcE/c5xMvbZTfa9bsSa6Cj5S6Orm+C4pT
         /tJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768890537; x=1769495337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YznedogKosCYjQoxhmZaws4K9eCkq32zETWn/NeO/UE=;
        b=vb4lvxYWAdbnfurLKmE51vym0qj/1b7fxtNU1rEwVwmPEBwRWF/6kTKjKDyl1iIEIv
         Aj9FSaOOa9Sbusc4rBVpBMVUqicOj5kgYsSJPqz2tE0jrmMQFDtwc9qQussDurhYFXrx
         2+rDfav+Hu+Zwcg/fJAt9EOlTHftYazvbBnptub479VZoHckRs+j/p0WCuT6W9aS/jji
         yP6b9AQiS3n0qrsoqTiVzQUndGC/H1q3g1RFXFITM/4zmfWwkgCsUQg3owCn8AZVayi8
         lDrS58ypZizufbDltkmu+x4f4kstcsrBXs8jUwxSwWK8g7k+UH3RcBy4TdDRhI/PUCMM
         Ktig==
X-Forwarded-Encrypted: i=1; AJvYcCWhdbemPpJMWiAo3yptreE0hldNXNU1yEz3MPSHUyWywqkpvz1jq7rWZ/47e3yCrht77X5fRiu67egb/PB86w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDZKW80+TsZtnIpllhY5prjY2GnpD5PkPtN1TgeQHqzd/omBVh
	tyEQYILvyAV7OWWxzMxa1T5Cu1c0JQL2qvjusS9QQKAO4PJeA2EpEoLe
X-Gm-Gg: AZuq6aKsDpGmxXQXpcOW55d52zDYomFzcZw6inEsqTYQjUiyjKrrQbjD07qehOM+Zai
	w7LNSlm9wW1VjWYtK6NAZ5rW4gl76pr1lIbqsxichE1V5bQeH1mlRcGwJ/7sezEAC0Ms4qDdl7f
	WUAQuUD778PD4n+wJFSOLGz8VK7Y6PG8xyg5E5Sz0Le2rhUavwQcPBDCzqRX/Zad1KaQelgtnCc
	FhsaGPSQrmOILWBpaqL3FFypOvjMZXKCFU7vH2D+lPBqXTah6amEcv6Zq8MLKbIutWs97sjoICZ
	Yw7Tw12x2kntJO92Nzn+TrwW6HF6dqwdb/n8FXj8lvBC32EhLBYx6zQlDu73sKdu+eJKJiYmqkP
	tWNYTxFB9s+/6hrFbnjkqsOtnL/cjWwfPMqn5vUatyZBIwJZcBgUptxZ+dBgQz/DMIV+ZEQoz/T
	OFEl9xgzwKU++bQmf1zXOED+OngGbhEt/GwdqknHdjOi2ugUOrJn2UslhG261F
X-Received: by 2002:a05:7300:7493:b0:2a4:701a:b9ba with SMTP id 5a478bee46e88-2b6b357e24dmr9383608eec.14.1768890536577;
        Mon, 19 Jan 2026 22:28:56 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:f31e:1cb:296a:cc2a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c91sm15706784eec.9.2026.01.19.22.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 22:28:56 -0800 (PST)
Sender: Zac Bowling <zbowling@gmail.com>
From: Zac <zac@zacbowling.com>
To: sean.wang@kernel.org
Cc: deren.wu@mediatek.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	lorenzo@kernel.org,
	nbd@nbd.name,
	ryder.lee@mediatek.com,
	sean.wang@mediatek.com,
	stable@vger.kernel.org,
	linux@frame.work,
	zbowling@gmail.com,
	Zac Bowling <zac@zacbowling.com>
Subject: [PATCH v5 00/11] wifi: mt76: mt7925/mt7921 stability fixes
Date: Mon, 19 Jan 2026 22:28:43 -0800
Message-ID: <20260120062854.126501-1-zac@zacbowling.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <CAGp9LzpuyXRDa=TxqY+Xd5ZhDVvNayWbpMGDD1T0g7apkn7P0A@mail.gmail.com>
References: <CAGp9LzpuyXRDa=TxqY+Xd5ZhDVvNayWbpMGDD1T0g7apkn7P0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zac Bowling <zac@zacbowling.com>

This series addresses stability issues in the mt7925 (WiFi 7) and mt7921
drivers, focusing on NULL pointer dereferences, mutex protection, MLO
(Multi-Link Operation) handling, and ROC (Remain-On-Channel) state machine
fixes.

Changes since v4:
- Reorganized 27 patches into 11 cleaner, logically-grouped patches for
  easier review. Patches are now ordered by subsystem dependency:
  mt76 core -> mt792x shared -> mt7921 -> mt7925

- Consolidated ROC-related fixes (previously patches 22-27) into a single
  comprehensive patch (11/11) that addresses the interconnected deadlock
  and race condition issues discovered through extended testing

- New issues fixed since v4:
  * ROC deadlock in sta removal path - cancel_work_sync() was waiting for
    roc_work which needed the mutex already held by sta_remove
  * ROC timer race during suspend - timer could fire after suspend started
    but before ROC was properly aborted
  * Async ROC abort race condition - double-free when async abort raced
    with normal ROC completion
  * Added ROC rate limiting with exponential backoff to mitigate MLO
    authentication failures caused by rapid ROC requests overwhelming
    the MT7925 firmware
  * Fixed spurious ieee80211_remain_on_channel_expired() callback when
    ROC wasn't actually active (found via code review)

- Added corresponding mt7921 fixes (patches 3-4) since the older driver
  shares similar code paths and exhibited the same deadlock patterns

- Firmware reload fix (patch 2) addresses crashes when the device needs
  recovery after a failed firmware load - the semaphore wasn't being
  released, causing subsequent loads to hang

Investigation and Testing:
  All issues were discovered through real-world testing on Framework 16
  laptops with the MT7925 (RZ616) WiFi module. Crash dumps, dmesg logs,
  and detailed analysis are available in the repository below.

  A DKMS version with extensive debug logging is available for community
  testing. This has been instrumental in tracking down the more subtle
  race conditions and deadlocks that only manifest under specific timing
  conditions.

  Repository: https://github.com/zbowling/mt7925
    - kernels/    - Pre-built patches for 6.17, 6.18, 6.19-rc, nbd168
    - dkms/       - DKMS module with extra debug logging
    - crashes/    - Crash investigation logs and analysis

Acknowledgments:
  Thank you to the community members who tested the DKMS version and
  provided crash reports, dmesg dumps, and helped track down the more
  elusive deadlocks. Your patience and detailed bug reports made these
  fixes possible.

Tested on MT7925 (RZ616) with kernels 6.17.13, 6.18.5, and 6.19-rc5.

Zac Bowling (11):
  wifi: mt76: fix list corruption in mt76_wcid_cleanup
  wifi: mt76: mt792x: fix NULL pointer and firmware reload issues
  wifi: mt76: mt7921: add mutex protection in critical paths
  wifi: mt76: mt7921: fix deadlock in sta removal and suspend ROC abort
  wifi: mt76: mt7925: add comprehensive NULL pointer protection for MLO
  wifi: mt76: mt7925: add mutex protection in critical paths
  wifi: mt76: mt7925: add MCU command error handling
  wifi: mt76: mt7925: add lockdep assertions for mutex verification
  wifi: mt76: mt7925: fix MLO roaming and ROC setup issues
  wifi: mt76: mt7925: fix BA session teardown during beacon loss
  wifi: mt76: mt7925: fix ROC deadlocks and race conditions

 drivers/net/wireless/mediatek/mt76/mac80211.c    |   8 +
 drivers/net/wireless/mediatek/mt76/mt76.h        |   1 +
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c  |   2 +
 drivers/net/wireless/mediatek/mt76/mt7921/main.c |  37 ++-
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c  |   2 -
 drivers/net/wireless/mediatek/mt76/mt7921/sdio.c |   2 -
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c  |   8 +
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 257 +++++++++++++--
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c  |  46 ++-
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c  |   4 +
 drivers/net/wireless/mediatek/mt76/mt792x.h      |   7 +
 drivers/net/wireless/mediatek/mt76/mt792x_core.c |  17 +-
 12 files changed, 340 insertions(+), 51 deletions(-)

--
2.52.0


