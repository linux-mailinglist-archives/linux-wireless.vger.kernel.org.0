Return-Path: <linux-wireless+bounces-31299-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDEwOugXe2lCBQIAu9opvQ
	(envelope-from <linux-wireless+bounces-31299-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 09:18:48 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51760AD674
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 09:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0ECCA3007E1B
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 08:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F3B1ADFE4;
	Thu, 29 Jan 2026 08:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LoGZz5eG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7B6371067
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 08:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769674726; cv=none; b=IAfwPWcLdNcI1yNkeWtnX6UXaOs/RpfRkMw42D4h/Pj3lPgIt1IFqdbmbriMscd/e0X9JRYUqXC++Wbx0IsAd10rur2IuX/4TO1x8xmhC4SSdetckL/aUg7N2N9ipnpOEU84Ey6a2Yc1enL3mS2xDySskcN+DyEcH+kOzQ8SvdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769674726; c=relaxed/simple;
	bh=SrxRYTsF/7Y7G7yTFu9IzO6YhGNp0uvTCU5/QZLE6dU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KbtjFV+5fY12I5Dz0MvuTkITXSwskezA/Yz+WRlQjBuqVKUuu0cnJMY73mr/8mIPQQ8xw3/FZXiJrmT8cleYZcQ8cBBOQouFtQoQOb1kzyH/ctVeXknaLItjrUjUkFGzjmAnTZtMyTi3A66iC2jilGG+No9PyrvTooyqNlqfrc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LoGZz5eG; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-124a1b4dd40so1785877c88.0
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 00:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769674724; x=1770279524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFOoxK8g/IJtQ/mNGnUc7nA5v9dS9d5PcciCzXU4s+U=;
        b=LoGZz5eGzETYMgYthPNIY/ImYpDgWlHAGlu/q3AnJKokHWpMWZ4xutVIFUYc2GFO68
         SDzJkuXJgObHitNr6aHGwHVK2wQ8BPpnQqZDcgdCncbMfqPN+whO4YBr80vHgkUFFVMA
         y1NLinqKHd0XqvHTYwO1Y6UKsofn29/xgDsyRwup2/rGrWVK5YERlkLCU9evmryTzT7R
         OIR4dwVcQ5fK2MmSGIqpdW6ca0tQKSnE6kRRqXFZVi6d1YaNnehI9MNlbzaun+O81cOL
         +mPRvFP7lKlyimKVG1GRlRgKsFSLpnwqC/HVyjSoFb0PhDEHuPYRQLeQS0Z/OQCs581u
         2RGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769674724; x=1770279524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HFOoxK8g/IJtQ/mNGnUc7nA5v9dS9d5PcciCzXU4s+U=;
        b=MOfJvrQyOM6JelGNNyzdivOiFnWpG9jl/DF7FKpwtXszTcGrDTdM4APc8jXVPF+lvP
         U9aoTZ5XGQ3hvthXeaWKYud2OiGIoJRlUq9HikoThvZP8mQGrf0cxXC+/dKeEuMMXEHG
         lR4X6lZrWXManyevUGedDSVyjP6XYwQkLRzjltIluJ4p/LyM/eijOrtkqkahMeA2OviL
         vU8yqcQpSsQIm3oRU44eOU5Xgebdk+4fW4WhvmxzlF4rZjAcxYPitCAKlxBR88xlRzxl
         G5mBFA4k516KTxeDvxBf2BCQooX7pdtvnly3koKC2zgRLVS6CERSk5l4unWpXGlak3q+
         JCsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUc/1kEsjcnqXyZ81anaRHhcuLpOxg5hINgR2UPb259V/dVYE6our1XsVTZatHXFimWcavC9OBmV/gHqBzARA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxiMGPMKDDJ6tQ91cNDG+baPg0oZJZpeO1W49Vqcrms8oNxK7E7
	PaL2Admizgj4A+cgkkjCDIl0uxZgQiiKDjl2xBmYxY4DfZJCJeUAns1N
X-Gm-Gg: AZuq6aIwVvYL4himgawxWptfpq41vgdaxyafwjxGmcUhHGnLnQyaDzbIscLfCIjgeRQ
	dn5Bn+uYpiC4f1AltZH2uA3VpOY5fkwGvgIB+svYR5euiGTVHQ2q4w8i7wU15DcyxKJtV/jGdTe
	1yhCaruR9f/w9X5BMuqAw8bPmf1pRIsKEbspfwaUyISlrnEMqoVj2Wzdzs01E98pwV/VD8NJegI
	aODqEjLD3gv9eufvgpU+E6ifZZ/rO0j6EmfnXzEnrH7gJ0hF4PnAYpyIm0fwLkhhIBmGG0GsNzj
	KXaS4UuY7n2/fSECWdQAv9s+D9Krs8/psZmAGxZgiA3c9Zd37J+Za5p6cr+2ifdAYkVblTsV5fq
	txwtxI4wSExuDvuuPp8IZnqU3eRQRWILEnWwKacu06EaEqAN0OrDk2ojV+sxeHH1qkz2P8vECje
	mchzMS8AzdAjAPEBfFFhOLl5gsS/dg7gunip/szSlv++8FX+6bBA7p+fVIHQoRr6Bw7cgj2lg=
X-Received: by 2002:a05:7022:249f:b0:11e:3e9:3e9a with SMTP id a92af1059eb24-124a00ddce1mr4207421c88.50.1769674723913;
        Thu, 29 Jan 2026 00:18:43 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:f31e:1cb:296a:cc2a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9efb4casm5483508c88.16.2026.01.29.00.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 00:18:43 -0800 (PST)
Sender: Zac Bowling <zbowling@gmail.com>
From: Zac <zac@zacbowling.com>
To: nbd@nbd.name
Cc: deren.wu@mediatek.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux@frame.work,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	sean.wang@kernel.org,
	sean.wang@mediatek.com,
	zac@zacbowling.com,
	zbowling@gmail.com
Subject: [PATCH v7 0/6] wifi: mt76: mt7925: MLO stability fixes
Date: Thu, 29 Jan 2026 00:18:33 -0800
Message-ID: <20260129081839.179709-1-zac@zacbowling.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <c9b81e89-cd29-44f2-b4e8-0179b2049c21@nbd.name>
References: <c9b81e89-cd29-44f2-b4e8-0179b2049c21@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31299-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[mediatek.com,kernel.org,vger.kernel.org,lists.infradead.org,frame.work,zacbowling.com,gmail.com];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[zacbowling.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[zac@zacbowling.com,linux-wireless@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 51760AD674
X-Rspamd-Action: no action

From: Zac Bowling <zac@zacbowling.com>

This patch series addresses several stability issues in the mt7925 driver,
particularly around Multi-Link Operation (MLO) scenarios. These fixes address
kernel panics, deadlocks, and race conditions reported by users on systems
like Framework laptops with MT7925 WiFi adapters.

Changes since v6:
- Consolidated from 12 patches to 6 focused patches
- Removed patches that have been merged or superseded upstream
- Improved error handling in AMPDU actions
- Added lockdep assertions for better debugging

The series addresses:
1. Double wcid initialization race condition during station add
2. NULL pointer dereferences during MLO state transitions
3. Missing mutex protection in critical paths
4. MCU command error handling in AMPDU BA session management
5. Lockdep assertions for mutex verification
6. MLO ROC setup error handling

Tested on:
- Framework Laptop 16 with MT7925 (AMD variant)
- Kernel 6.18.x and nbd168/wireless mt76 branch
- Various MLO and non-MLO AP configurations

Zac Bowling (6):
  wifi: mt76: mt7925: fix double wcid initialization race condition
  wifi: mt76: mt7925: add NULL pointer protection for MLO operations
  wifi: mt76: mt7925: add mutex protection in critical paths
  wifi: mt76: mt7925: add MCU command error handling in ampdu_action
  wifi: mt76: mt7925: add lockdep assertions for mutex verification
  wifi: mt76: mt7925: fix MLO ROC setup error handling

 drivers/net/wireless/mediatek/mt76/mt7925/mac.c  |  3 ++
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 65 +++++++++++++++++++-----
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c  | 24 +++++++--
 3 files changed, 75 insertions(+), 17 deletions(-)

--
2.52.0

