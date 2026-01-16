Return-Path: <linux-wireless+bounces-30875-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BB4D2980D
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 02:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 947C8301D1DF
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 01:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE75B325739;
	Fri, 16 Jan 2026 01:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+q6Zo8E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A01321F48
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768525553; cv=none; b=eGxMT0aPrxcyKbEclWRn2yRup+bK8sRYD955aGCXu4PK3IixuRfSxPTrht4st+/jcdHx8IBlhMg/4NB9zkHJDyj+izS84vwXmslIX8fmKx85JF4XT5MMiCk4U6euhPZI778Bv2qTo5TkSJNLprr1bImCZT0CPj0pK6ioDyHznJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768525553; c=relaxed/simple;
	bh=75lhl3OVFrElnB+W1iwlHJCQNfPL/id3yEAWpSq3TRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r0Fvor1aZn7172b+C4+OcoCDDJz+PYyONmKtSAomN87yPcSARBV/hsFecuZ0lGTjjzUtJjo6v7uvMJW9SrV94bgRil+c389HgPMi1p6OcWXaIFvD4ii+XC67kCu+FRxJvGnkSUGdtbG5BU4Xo4Zu0vFaD56j2JytuB4aVUXrP6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+q6Zo8E; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-121bf277922so2035109c88.0
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 17:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768525547; x=1769130347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUlCSJ4sVDZpvZSnTCZZWPWUvx5qo1tAq80JkqdgelI=;
        b=K+q6Zo8EQt0Ieb5xVV5x0wq12M796dIYSTnoFy4saNahufvUK0C6g9PGhbzixMqd0U
         A8J1qwyVykF3/n3mRyYgN07P0Y4v2AKRvFKyxWTO+t0vTNf2qRjmsQXEyC5GZP70fimL
         y0GoOa26NAqn8OqZsyoRexrtHjJhvF5/UGWm/2Jd1U153nKNEJPw7Wii+eB/AcaA0Itp
         Ohd2i8a9Q+UkaiefZzT7Clb+JRi5mHh8oaKp9LxDSFu8J1MvZ6FbFMRyvjNvdFiPtT3z
         7UlGeERjGdPmDQi9Iw8IERpz+yQbQI7M5wJtTRF2ToUNRpkPlJedQKz75eNUTd6vAg3W
         rQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768525547; x=1769130347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IUlCSJ4sVDZpvZSnTCZZWPWUvx5qo1tAq80JkqdgelI=;
        b=OhyvL4HVNEMURt1h9eQB8YsM5DoLreHofrL5SxkVyVtKVjxOZIWGto1xMrIGIgIu0T
         zWDEDrVYaRzf5EWFqjJJnu7XW86SIsAA80s/O1p33FajPhaulknZiMwfmK6kS723Zguk
         BV90p048FYayvNdUTEijfmdIcVLewUQPu2tmhMXoUbOFZY8iMlGjxNDfRAPtYtySK4GR
         XIcs3ZMZMs6OMbOzv7AoqDM0gXfGV9FY4InPYRSjl+6cUvAmzzL3HLNy0LgJlEWkdDrv
         9DzKDGihFemPIjTuKjg2oqD0grv9q6RaJeZn9S6ktGlq4nlcj4bly+hplW5pnwK2/h6V
         XIhw==
X-Forwarded-Encrypted: i=1; AJvYcCUuccc2ivziNjEfzSdDOqFCPe6VkNxaOD6cupeZu9n6beyDgNJd/fgbOZMGFx2zBMe9ahfCbLb6BVGbIKf6jQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoc525P+ERFTF9UKFGgfQEflXzWvafTg1/OFHCopUstZPGOomW
	8nelCN16SEPxU0ObhzatKBtMfe2aKCzzK88Gj5zWhLfuMPfiRDnkhtp0xsgbPgwo
X-Gm-Gg: AY/fxX7BsO6ZC3gU3QAcUpNi1pMTd6JNCHVndlhiUPbqfdNNR/DpanC4mlUVzfbIIM2
	UYvU602UC4PeTKnkuSbUB3gnE3eKotkuebq+Fs0x6iFDit7DfflaogkZfWTh4viMZCB1m5YKk6F
	45pR6Xw4zXJu2A10G2bVQzore6Rm5sjvXSyG7YyEwxA64m5ALonqA8Lloa6J5THTTTdF/rNSIU/
	axrsytVuIfFVJjCrNsxF0L6Q/E6KIl76IG23PCftPxzPuPhIA3qsDWyjOkK/kPV8pq1e3EpiBp0
	rAW8IU3YCM8B46TdFnFVY70wMB8BJLh2WHHIMshUvtDKVn4q2zbXfGUXnCAQkDbcfPEJF/UlP4S
	n/3sLMlGYZ+tIlKwHHx75TSKg/CsdovGWTN1IiTxfphPL7Zpajg9BreVyI4phLevJ8ejSyH9VSZ
	1zWdvHePOSRBohiL60qjjJeK3lzuoau+LONZJwWKw9s9HY4gxSKRU1MAJVhQ0UwA==
X-Received: by 2002:a05:7022:2491:b0:11b:38b6:a95a with SMTP id a92af1059eb24-1244b31e681mr1231822c88.11.1768525547022;
        Thu, 15 Jan 2026 17:05:47 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:f1d2:502c:a6ff:5556])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b367cbc9sm1019884eec.32.2026.01.15.17.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 17:05:46 -0800 (PST)
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
	Zac Bowling <zbowling@gmail.com>,
	Zac Bowling <zac@zacbowling.com>
Subject: [PATCH v4 16/21] wifi: mt76: mt7925: add mutex protection in resume path
Date: Thu, 15 Jan 2026 17:05:14 -0800
Message-ID: <20260116010519.37001-17-zac@zacbowling.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116010519.37001-1-zac@zacbowling.com>
References: <CAGp9LzpuyXRDa=TxqY+Xd5ZhDVvNayWbpMGDD1T0g7apkn7P0A@mail.gmail.com>
 <20260116010519.37001-1-zac@zacbowling.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zac Bowling <zbowling@gmail.com>

Add mutex protection around mt7925_mcu_set_deep_sleep() and
mt7925_mcu_regd_update() calls in the resume path to prevent
potential race conditions during resume operations.

These MCU operations require serialization, and the resume
path was the only call site missing mutex protection. Without
this, concurrent access during resume could corrupt firmware
state or cause race conditions with other MCU commands.

Found by static analysis (sparse/coccinelle) pattern matching
for unprotected MCU function calls.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index e9d62c6aee..3a9e32a175 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -584,10 +584,12 @@ static int _mt7925_pci_resume(struct device *device, bool restore)
 	}
 
 	/* restore previous ds setting */
+	mt792x_mutex_acquire(dev);
 	if (!pm->ds_enable)
 		mt7925_mcu_set_deep_sleep(dev, false);
 
 	mt7925_mcu_regd_update(dev, mdev->alpha2, dev->country_ie_env);
+	mt792x_mutex_release(dev);
 failed:
 	pm->suspended = false;
 
-- 
2.52.0


