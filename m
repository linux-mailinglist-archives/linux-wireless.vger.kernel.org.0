Return-Path: <linux-wireless+bounces-24834-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2E1AF9C0A
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 23:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71AA75A20EE
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 21:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094D82528E1;
	Fri,  4 Jul 2025 21:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eO4Jlgk2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77ADE24BBEC;
	Fri,  4 Jul 2025 21:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751665349; cv=none; b=YengETtUZ1qnYrgmNLE5PtG9tgXmisuxEkLkP+hdP8JU0veFzCefCFC9HVD6YYA9I2sUSdrBHyzE9P7Z45MA9zv0Ts41+R0TZ4Y96STDpFMNyt0PiX9pIGfXz/zS3bQovD/e0mCHznxPN7pG1Hh3i75OAqCnV180ShrYG4VJ/Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751665349; c=relaxed/simple;
	bh=Vd4h7MF2VmCquMerTACyIXwlZYR5XGWIGsVMABLkzlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mCvModXAYlZvYJUKECvKicNHV0l1dqO+lTWNdTlutDA4KqDgoP71uqHQIsW1jHgLG6PIA+J5GWZBrS7nxCASTr0YSe4h3ZcsUde7TeIzeXqcpSgUdTgmVbW+72XLB4WNlNrzLLa1Mp4BMWYc8BEJUtqHuFihgF+4DaPfEs0ohqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eO4Jlgk2; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b2c2c762a89so1010895a12.0;
        Fri, 04 Jul 2025 14:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751665348; x=1752270148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iH30V5YdrhtMVjGPmYxP+mNhtVuLYsALu35+7tcSoD0=;
        b=eO4Jlgk2TED5uUGBvdxebAql68wODEPW4xNp4Rx9K9CjWMenNaoBlJQuVrXYBBzDdE
         GT/tqG2nxSNr7rC0WfRTA3XS9zcLtoSFfkdFZOrQDQ4XVgYfDOD2QSsVfp5PCXw4OhDF
         aUa88/ZGx+90iFFRqsSrCrQIhrrpF5G7LGcot1vsnyDgYx+7D0ZJtXKLN+fMfQcYSfdR
         TcFIY5bzImrZlyLlzgzAW+JV4Ry76SlKnhGtS2ATU655cFmXILswVo0e5ZsYSXMpZ7Or
         NSs7hrjEGDFbidoL5wsI3Gbv8Dp2tV7EWSfYG43FQekMcOULDvYTuHJMaMCy1wz/v8+P
         p/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751665348; x=1752270148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iH30V5YdrhtMVjGPmYxP+mNhtVuLYsALu35+7tcSoD0=;
        b=sYxVYICKHCDFX0BEzukRdRjONF81+dFGUMXO5T7qTbR1xsvbGTref+ZWEQicf7/z0l
         Yb5bIozacTnJkRNrH1UiBGOX28sajk5B9zav0tWeJyV0tfwBaVqd8QSxqp2++lumG+8w
         Emkn+aCzV/G/B02AQlL/ay7YItalbdgdTPULcLEqlBc1pCHsVeXxXMWF11YKhMNSo6k6
         mvqrLGIZX6YH875x77IPBdDZiGFRn62NfIDjsoSM6iF4fEyQBKk0P6RMOjQMRyPe8LAh
         NLrDfgcXSSj0Y9w+t96pWhmvuiZuYsztAe8yq+AaVZ7ORbrktHL+L7WMT+jZdq/Squ9p
         WQzw==
X-Forwarded-Encrypted: i=1; AJvYcCUhs34Rou5n3335K+/i7N95Ihf5RQX9BDAoCAPCGucvgHR5MWAD8nVTPueoB6pFk9f+Keg3Hen824hGVupV@vger.kernel.org, AJvYcCVSM+wlbda6+T2OUzM1/8iLIopwqPViFGaQ+N/Ra71Ynn8Es/jamBIWPthGJj7XMFbTwXQpukSoYCUfUQ==@vger.kernel.org, AJvYcCXIQdQSLSzsSK3G7jgWAjFR3VG85XvXz9ctHzjIBgYDMf+1S3mM0wwun+U4LHuqFtQKKcOT1tbT+ArM@vger.kernel.org
X-Gm-Message-State: AOJu0Ywctcg3leLFmuJMnI2RYAScNgnDdJM3FlL2zD2xK70Gr5YSL39H
	DRtmUHyBi4zAW/gzHv6NKIhLAIedtOYTL+2p9MLKoV7t+hdYm3CFDyodccVOug==
X-Gm-Gg: ASbGnctmOXytYzjngWNf2XucWxMbz6A9R+Z693u8ySDBqkZI/Facav0xYtyLu9eLczK
	9f+oL9Oib6w462jBG6wtUZlX/da7SF8++AReRVV3ou+YfWFC0UV5Il6MH+Hrh7gf/JVXzK7u0bC
	e62qeN6d9dn+iTUL9qL/nGWn0qvcW9SBcIHChcVQmh6flvdeafhWoH7vUBE7O9bpfPgqnJ2rfJI
	/XABsglIwVbfDh+M5SDeOGNWJ7t0r8Dce987CvPOjrq/GQyJyJeSlTCaocTiT/7jjhV009/EPrt
	1OvaGnmDycP4pXyhKWdm7Tpzg2aZzT5HNOqlD+4Kl5IPeNb/
X-Google-Smtp-Source: AGHT+IEOTvxO4OpEHKgd9CJnOMkneyKHL8Kv3UbGYuqAYb9B3kbOAXQke52NJC0/COxLXa3RBis4ig==
X-Received: by 2002:a17:90b:2c8e:b0:312:e6f1:c05d with SMTP id 98e67ed59e1d1-31aba824c37mr467117a91.2.1751665347735;
        Fri, 04 Jul 2025 14:42:27 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c84597371sm27950315ad.207.2025.07.04.14.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 14:42:27 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	nbd@nbd.name,
	jeff.johnson@oss.qualcomm.com,
	Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	linux-mips@vger.kernel.org (open list:MIPS)
Subject: [PATCH 2/3] wifi: ath9k: ahb: add led pin OF support
Date: Fri,  4 Jul 2025 14:42:18 -0700
Message-ID: <20250704214219.18796-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250704214219.18796-1-rosenp@gmail.com>
References: <20250704214219.18796-1-rosenp@gmail.com>
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

It seems that it's preferred to use led-sources as the binding for this
instead of a vendor prefixed variant.

For setting an LED to active high, a negation of led-active-low is used,
as two drivers currently use that and no drivers use led-active-high or
something similar.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/ath/ath9k/init.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/wireless/ath/ath9k/init.c b/drivers/net/wireless/ath/ath9k/init.c
index 629f66a25307..4f967bc34460 100644
--- a/drivers/net/wireless/ath/ath9k/init.c
+++ b/drivers/net/wireless/ath/ath9k/init.c
@@ -650,6 +650,17 @@ static int ath9k_of_init(struct ath_softc *sc)
 	if (ret == -EPROBE_DEFER)
 		return ret;
 
+	np = of_get_child_by_name(np, "led");
+	if (np && of_device_is_available(np)) {
+		u32 led_pin;
+
+		if (!of_property_read_u32(np, "led-sources", &led_pin))
+			ah->led_pin = led_pin;
+
+		ah->config.led_active_high = !of_property_read_bool(np, "led-active-low");
+		of_node_put(np);
+	}
+
 	return 0;
 }
 
-- 
2.50.0


