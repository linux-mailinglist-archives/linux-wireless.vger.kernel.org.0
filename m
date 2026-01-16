Return-Path: <linux-wireless+bounces-30858-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A6BD297F2
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 02:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E28730341E0
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 01:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D923148B7;
	Fri, 16 Jan 2026 01:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFi41JCE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB0F25F99B
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768525527; cv=none; b=B/cyK/HiyW6bd3NuhmPoPK4iPo4qrYeApUNZG9WgauNsHciON8JBL5Q2WHKHWePpwzylUzf9LAA0KU2LHyPinBHyhL5y3Iv2ZfLftc0h+CcBfOsW7KX6OdNUlsUW/1wNPxrqWh33r/EZbePD+b1ZQYLLdkgpbAh2v9zmoEquZZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768525527; c=relaxed/simple;
	bh=2I+gSwcNT17uKARtf6tmJ6JUyn7v0fEHFQUfEK0DQvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LKF2xpnXtO4Fc1EmuKcrHpp1EJvCSpMwam0vd1WDNhRzhRUwaRB4ZSStjxgBh1QkQcS4Psb+vOKFpZC2K6Nbr7kCf6D8cLEW4a3N2rMP0xYcPtCgtEzyZGBgjTdyafK4yE5sW0lduYL4TZEEEdWVv3Abxd8d53pD7+C9GHWgbNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFi41JCE; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2b6b0500e06so913995eec.1
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 17:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768525523; x=1769130323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfMaFn/QyfxelRT8jKmLj/I9JzM5jNepmQsNTMuHcRU=;
        b=eFi41JCEr8yVwoqKhQbZbCoSpK2LphsXGr6VD+2HNjL/UI4D0CrLfIhUK5SmXPhpxr
         9QyZcm3wVrOZWbCdwd//uGaof3ove7RLNsSEHjT2CsUu+r8YZLAxBRspwLW3yPek+3K9
         aOvTsa7io89rrXtD1SuYywR25BhJv01ei+gl0MpyzGBgbwJAITYSogd4lQAYabSVJAyP
         ZxIlaQZfSp/W8cp/SbVw+kqxnVm6K5Q9y9FMWcTjFpOKIjBwXCA4sTrX1ijJgL4rahVN
         b4AmzPj7AFI17QY7HYp88OmHdGjSAcWHul1SCk+zvIj6zMaGGDKSTTteS7PA/5gF63yS
         Kddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768525523; x=1769130323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xfMaFn/QyfxelRT8jKmLj/I9JzM5jNepmQsNTMuHcRU=;
        b=bd8ufLcSVmW1pqxq2taZuxaPSoE9qUf6hnySKwxD7/5s7xRWn2DCKV7tbHiJ1mTV3q
         +IkBWk8s4CH1EIvWbwGEoMTWFIsu5eqUzY0HXTu/nx+b8ingkqr0VAFzYkNSInK+uqYb
         je03C2Z0LfdV2ln8vt5ITa2baN9ey+XgbowD6qtKvAa9oQRJ09jiqB4UlBkDkjvtQRlg
         JD2a2pTdDgCb1cPxzj+Addh2/945lPmXDbDDwVV6CyR9ghSstM1jvgiw0xLvLcpl/iH5
         NcNd+HrCDJFZD1V+311zBxRS1K/oZLM6zGrfU4Rhd0d0Rm5eYbmxjubvsb7x3BFShc1N
         liTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDChg5J88euzDcGkReiufrTPml+89umLD4ITXQIPDlbgXhrAi1byB1E5QNN8ehShI4qcVz5AQ41BdjG+ljzg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRu4sosVxGsMh5r4sisraRK6SP5wou9FrmUCCCZGGc1MQLkLLH
	VtOSKNKUcLXZtK2Z6NMz87NKg7/IFubxlE9Dy4ezgGVkEiXOuPg1dvkN
X-Gm-Gg: AY/fxX7jtGV8jMJPZqVidRFxinl+I/csFDjhocWUDX8Yd15Z41FMUmWB4/tXzI/Ze+x
	bseu47PTp5WVFkDhnSxDBrOkklAQo44JNwh21r/iexhMYR1EIIi2YMKG5kX1zDxRHJM4z8zc/a4
	PDp4vOH3wdqajx7cK9rWZ/oauNKeSDJ0o9fp0ubfDzs7ibaHLvZL5DXdJb8ifdiQpWu9UxxJn7P
	MPKZrvJA9qPoIFKAzsJI4+B8JWbKalYNzebUZneITr+LhwncZcS//wYyCnY77AmMCjZUD8kiBnh
	ydkHrhYnde+DHUxuTMlS4bNXjLroZB2towed1FKOsGoZJTLGscgm1OFthBZVpp+n3yv5eAsd5Lu
	wQ+Heq9UTcqdTVJLgf6/B6k0McgJPILbbMPFjv1uNXTa5dUIPzSo+bElo43saL1x/W2IYhAxyRQ
	MXVSG7AQB/T5SoX9Yh9ULUmKJn+D27NDH20UmzKLKl3fbEN1aIsAUXI7VssbZCP4uZL8D6QHhs
X-Received: by 2002:a05:7300:dc85:b0:2ac:816:f31e with SMTP id 5a478bee46e88-2b6b410af48mr1251750eec.29.1768525523160;
        Thu, 15 Jan 2026 17:05:23 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:f1d2:502c:a6ff:5556])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b367cbc9sm1019884eec.32.2026.01.15.17.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 17:05:22 -0800 (PST)
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
	linux@frame.work,
	ryder.lee@mediatek.com,
	sean.wang@mediatek.com,
	Zac <zac@zacbowling.com>
Subject: [PATCH v4 00/21] wifi: mt76: mt7925/mt7921: stability and MLO fixes
Date: Thu, 15 Jan 2026 17:04:58 -0800
Message-ID: <20260116010519.37001-1-zac@zacbowling.com>
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

This series addresses stability issues in the mt7925 (WiFi 7) and mt7921
drivers, focusing on NULL pointer dereferences, mutex protection, and
MLO (Multi-Link Operation) handling.

Changes since v3:
- Added mt7921 driver fixes (patches 18-19) to address mutex handling
  issues that also affected the older driver
- Fixed mutex deadlocks in mt7921 suspend paths - the mutex was being
  acquired inside functions that were already called with mutex held
- Added mt76 core fix for list corruption in mt76_wcid_cleanup (patch 20)
  that caused crashes during suspend/resume cycles
- Added fix for BA session teardown during beacon loss (patch 21) which
  was causing mac80211 WARN in __ieee80211_stop_tx_ba_session - reported
  by Sean Wang

The mt7921 mutex fixes (patches 18-19) correct improper mutex nesting
where mt7921_roc_abort_sync() and mt7921_set_runtime_pm() were acquiring
the mutex internally, but were called from paths that already held it
(e.g., mt7921_mac_sta_remove via mt76_sta_remove, suspend handlers).

The list corruption fix (patch 20) addresses a bug where mt76_wcid_cleanup()
wasn't removing wcid entries from sta_poll_list before mt76_reset_device()
reinitialized the master list, leaving stale pointers.

The BA session fix (patch 21) makes the ieee80211_stop_tx_ba_cb_irqsafe()
callback unconditional in IEEE80211_AMPDU_TX_STOP_CONT handling - the MCU
command may fail during beacon loss but mac80211 must still be notified
to complete the session teardown.

More notes in https://github.com/zbowling/mt7925

Tested on MT7925 (RZ616) with kernel 6.18.5.

Zac Bowling (21):
  wifi: mt76: mt7921: fix missing mutex protection in multiple paths
  wifi: mt76: mt7921: fix mutex deadlocks in multiple paths
  wifi: mt76: fix list corruption in mt76_wcid_cleanup
  wifi: mt76: mt7925: fix BA session teardown during beacon loss
  wifi: mt76: mt7925: fix NULL pointer dereference in vif iteration
  wifi: mt76: mt7925: fix missing mutex protection in reset and ROC
    abort
  wifi: mt76: mt7925: fix missing mutex protection in runtime PM and MLO
    PM
  wifi: mt76: mt7925: add NULL checks in MCU STA TLV functions
  wifi: mt76: mt7925: add NULL checks for link_conf and mlink in main.c
  wifi: mt76: mt7925: add error handling for AMPDU MCU commands
  wifi: mt76: mt7925: add error handling for BSS info MCU command in
    sta_add
  wifi: mt76: mt7925: add error handling for BSS info in key setup
  wifi: mt76: mt7925: add NULL checks in MLO link and chanctx functions
  wifi: mt76: mt792x: fix NULL pointer dereference in TX path
  wifi: mt76: mt7925: add lockdep assertions for mutex verification
  wifi: mt76: mt7925: fix key removal failure during MLO roaming
  wifi: mt76: mt7925: fix kernel warning in MLO ROC setup
  wifi: mt76: mt7925: add NULL checks for MLO link pointers in MCU
    functions
  wifi: mt76: mt792x: fix firmware reload failure after previous load
    crash
  wifi: mt76: mt7925: add mutex protection in resume path
  wifi: mt76: mt7925: add NULL checks in link station and TX queue setup

 drivers/net/wireless/mediatek/mt76/mac80211.c |  10 ++
 .../net/wireless/mediatek/mt76/mt7921/mac.c   |   2 +
 .../net/wireless/mediatek/mt76/mt7921/main.c  |   8 ++
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |   2 +
 .../net/wireless/mediatek/mt76/mt7921/sdio.c  |   2 +
 .../net/wireless/mediatek/mt76/mt7925/mac.c   |   8 ++
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 125 ++++++++++++++----
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   |  48 +++++--
 .../net/wireless/mediatek/mt76/mt7925/pci.c   |   4 +
 .../net/wireless/mediatek/mt76/mt792x_core.c  |  27 +++-
 10 files changed, 203 insertions(+), 33 deletions(-)

-- 
2.52.0


