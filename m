Return-Path: <linux-wireless+bounces-26666-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C8AB37655
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 02:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73F87204A8C
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 00:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512F61DE2C9;
	Wed, 27 Aug 2025 00:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/7z0vIF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4F21D7995;
	Wed, 27 Aug 2025 00:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756256232; cv=none; b=EvddletREJloyit4lOdI0HCRsaw44dstBA4ZEI2A+oivW3wtrYT+tqsHcUW3Se9qSusYTjbiCRKz38//TKCRIm46R72bhbriU7YVMrItZsMsEq5accHRScmE9Z4kaBctcTNSNQmJ4BEzZ3q5Bll4QR4XChC/eabqvOSJZGlE2JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756256232; c=relaxed/simple;
	bh=l4jUTg6p7HBlcYpJhzJqH9tmNAYtnzPZ44a8SZWk/PI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=euwpRcf3I+O0clcispbmHELePlgJcB8Plkjl6QXS0BAFG75NZO1q0V6lZBvSqRoK59KJUzVis4R1EDATuXv+BPj/tOsU7wc2mYW8wyRusNFT1k7uIrMcf5/QkwNGtMu2zXUwOebFhS0LXZIqhzRpdbEgaNBJzVQ6miMbwdp1kYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/7z0vIF; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-770522b34d1so371353b3a.1;
        Tue, 26 Aug 2025 17:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756256230; x=1756861030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uig5QGYbBAPt36WlJrR3rx9Jswl0P7cFjJcvLjeekMk=;
        b=E/7z0vIFdWPGGs/qXwzw6KQEAEDGQfwUjw8EpJjT0fRrUtXcULKKxpylUETD114vD1
         D2tILaDKmbuGV4ZCfqy2s6oHHC1QZRopZsGWcMAAjWnVo++bkSDpDMzeCH2LmX+7Ch/Q
         UkJ0GsFDf4MdfRNmjARBX+w96EesWEYjcnwvYVqZ4cEwFqlwfi6BF94/WAycsRg34ztB
         t5a0tAdx8Tfu91AAz4P9f/wIyNqBbeWj0BwdLmwk4MfZv7no5kHNkTNN2DB9xZjl8Pdb
         jm1/cVpodcMVlZ4Pk05RmIh6kJ71ZtYU3+KHX40N166f7znYSz5e18TlrzyGWhokTfgz
         rD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756256230; x=1756861030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uig5QGYbBAPt36WlJrR3rx9Jswl0P7cFjJcvLjeekMk=;
        b=jZHcBdCfSkJd6jjP4Tq177pL18v7HTKLJ7vqBIscrcUnUClnr0crrm2gPplxWcKDvk
         XnBUD1F+m14jeAdgNOd1xuSNWQfcXiePetJxswKjWXimK3yAT34du/ZzL1gqDW3ao0jm
         1e7b2NCZkGS+RnmgzmhBQeRt1qi1htZ7efg7fUASlbprk2k+Mb1o/KN5n5zU6MblzRhB
         VMTJUnC7c6L9RG6FFbzubs/JNGDPWgChE4X8FENP7k4eLCEkic+IbdGpHE6u8GZBEjpK
         MJ4v0nM+eVVlYzBXFCc+RwpHQBzBQwPTPceQB+nZ11bB0++0LsEcHahtKxhEvAigwOoV
         YjRw==
X-Forwarded-Encrypted: i=1; AJvYcCVPHlDLQUa6v9+5dUVkQnpXWY12DMcOw96K6eDtmmC6+ZXiURmjZJaoA2g3wZZdzkUT9oHSyBeCQjJu@vger.kernel.org, AJvYcCWfWybD/o8z3bCBb8uppXUCXEZT+21n7GsM/CCEgjRRhkqzsJYjJPqbfaCxsdSP/0NNga2m10v8fTp1ciSD@vger.kernel.org, AJvYcCXSFB5v66+M3Z0k1Y6EERcTqm9h+k8/CGfDaUTwbFaL3tllTooTT/ey32M7pkbIEp0WOHxrYHMLL17SSw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzrEihpiRKYW7kAUGAvDu7U16RbpHBKdAPuCNKhyAWynCEgUL+g
	/FcSYkRGKDeG+M0T2tgjlAVUd1UX/rZWSrMB3zoZNlQlAjXJGBKExGJO/7iOTA==
X-Gm-Gg: ASbGncudaSX61nfhR4bZtZ9DNRL21J2WsOhPnbhfwv/r3GSSMhpJskkx5toLl+wW9cQ
	4nePBQPL13x3W6jE6y+lG2lfYriisx22p5YUMC1tMGg6oGza23ej+LMiUjCw9pAM/xTGzeWoVUu
	xvy0lMC9YAWBY2ivChR70cy8pNOTspw+UMW5rFwMIAA0Eqh/OoqJWYjUA04SX59ibRDXGD7Kj7D
	UaE8sSiocegRMbpvOVF/LtvqDkfa0votzgqmf3OWjP76JJYLIBSdy9A+UZZ5b2h8e2Y7iqnXs+e
	hFcwoFdq6THd0WsYIwCFx9ndHSwo+y4AFKSOWqPGbKScptnXVMsoNAhFTc1b87V9LNUJg7Bq6NL
	ajZpzNvYz3T5AIdLVAaUan0wldgU2j6Zcz6ONmuSMG8wax4nqsWlTOMJIG5/Xns5Z1Q==
X-Google-Smtp-Source: AGHT+IEfhku8InrNBI82wuo6rWD5je0/uHfbrxMpVx3ppR37JPI3MK6npdjBPX4jleIPQmyOYuV23g==
X-Received: by 2002:a05:6a20:3d20:b0:240:7ed:4018 with SMTP id adf61e73a8af0-2438fad29b8mr4913916637.15.1756256229869;
        Tue, 26 Aug 2025 17:57:09 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:acc7::1f6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77057368ca0sm8382515b3a.58.2025.08.26.17.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 17:57:09 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	linux-mips@vger.kernel.org (open list:MIPS)
Subject: [PATCHv4 2/3] wifi: ath9k: ahb: add led pin OF support
Date: Tue, 26 Aug 2025 17:56:57 -0700
Message-ID: <20250827005658.3464-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250827005658.3464-1-rosenp@gmail.com>
References: <20250827005658.3464-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The old and removed platform code had support for assigning a value for
the LED pin for when the default is not correct. Effectively a fix for a
non working LED.

Added led-active-high to set the LED to active high.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/ath/ath9k/init.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/wireless/ath/ath9k/init.c b/drivers/net/wireless/ath/ath9k/init.c
index c911b178dcc2..28dc6c0e27aa 100644
--- a/drivers/net/wireless/ath/ath9k/init.c
+++ b/drivers/net/wireless/ath/ath9k/init.c
@@ -662,6 +662,17 @@ static int ath9k_of_init(struct ath_softc *sc)
 	if (ret == -EPROBE_DEFER)
 		return ret;
 
+	np = of_get_child_by_name(np, "led");
+	if (np) {
+		u32 led_pin;
+
+		if (!of_property_read_u32(np, "reg", &led_pin))
+			ah->led_pin = led_pin;
+
+		ah->config.led_active_high = of_property_read_bool(np, "led-active-high");
+		of_node_put(np);
+	}
+
 	return 0;
 }
 
-- 
2.50.1


