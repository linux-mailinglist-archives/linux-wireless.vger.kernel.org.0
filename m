Return-Path: <linux-wireless+bounces-26342-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5FEB23879
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 21:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 005101891ED0
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 19:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACC82FFDC3;
	Tue, 12 Aug 2025 19:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jahd2Xxj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001AF2FF164;
	Tue, 12 Aug 2025 19:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755026634; cv=none; b=Tz1CgbVrsT/K8DCRrGhxS1YaZwWlapPYv3es3IMvRRRQ+EnKs0BXJWUuz3oGEWEgORhqC78P/H1b5ykfJkyDCCIM0wZUtEYn/dkpyyRTr5VLOu4q0zttqeq/yGBSSf3SQiFlNzNWsJzrMfCVhzTiDRU6LvPG3ckpKikfBRPqCLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755026634; c=relaxed/simple;
	bh=OI5em0cB6YVrcV7k3NjmuUsl8f5fbnNAx/SHDlNCnCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I2F5zy7tWiNIno9Eb79njYSGQ0QibLBoCyo6V7HnKBWWcqljn3d64QkEnmrh4BtItqOZ+xQ9uxe5LEzmEZ0aQrrkXNqa3ybpOX73czdRHtpTi0epTbBZitC71YqP6SeATrvd4spOCwSyhmoY6QxmOjQlhaNNNm4jnGS69mYPyw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jahd2Xxj; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-7077a1563b5so51134336d6.1;
        Tue, 12 Aug 2025 12:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755026632; x=1755631432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5M2KOaX4IcFtAJBgyHyjeAjKFrFkp7T2MoYZ1mRZaFg=;
        b=jahd2XxjuH/Ybexx6Ap1L+jvyhMRjaxh+xNZKyhILmltftL6/5L0nERljbhuwBModm
         ex/PrbGG4Bc9LsJ6igwF3J3Tj0cMgstwVW75+7UEup2svzySJ4Zkz8lKVily9qJO1sRp
         QlLwMq0VFen7BJ4jXWjeBBcbnKeS9qOfhieqdIPslCd6j7TtYmumeoY+gXERSmUWTy/K
         DrAd7OYSipoqnxu4Y/qJ6a7kxDZCjjRLlyyYhQn8EcKFIw/0RP5QKs2w4j4XuObqPAtz
         EQB0NkmVxo26x2/9TCPlOlopaekRHBk6jHB+QWgv7S4/clnO0Owklcw0TuSvKWy869XW
         5+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755026632; x=1755631432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5M2KOaX4IcFtAJBgyHyjeAjKFrFkp7T2MoYZ1mRZaFg=;
        b=o35ztTojm3Qxi35sswnEI0lCj70pGExayFlkPBKAcmllG0eMmArhou2u1v99f0hpYq
         ll0ejniQKlz+7MsnVBrj2g8IffYRknn5iqQG5AE8MWGpHEPcCPJS9kYGuYerpNQEvlAi
         Gz/lqWxaGJS7FOEQKq5ghBWIyxJr7dIoAUKxTg3EzvZ2fYjVptDS9HdodR9HX2sHUUrn
         S+Kaffe1CpQpi71dDZHe48L1sMAOXMvAIJI/gGaGKP8Gpr6tRCaZKzG4kNTjIznTx390
         btuABtyJxq2rBEb+SnxRRh+tIxNAVsVQjIA2J1FdQsbURvhy2oOAWtd2/vnYaELTRLlh
         U7Pw==
X-Forwarded-Encrypted: i=1; AJvYcCVEhnlqQccnIxwa3edj+SQwMxyfIbZGz5bMKjRtm/20YboenZokmuDADwr3rDJtMbmDByipGYZK4t8q9A==@vger.kernel.org, AJvYcCW8PiJXXmUHaM3bT3qq1DAw64hgk0XwcOsqX9rqPPQP5akmwa+FvJbHBsvXe1UbhFqm1j/XK9BchjHj@vger.kernel.org, AJvYcCW9mpmSswBe59x6PfNELJ6itiMtBnqY9b+HqpWHRFqhOYel/WLxz32unCpkibVDQbOO20q3wMaKS+pB4BjC@vger.kernel.org
X-Gm-Message-State: AOJu0YwvKatcGX2WU48pYn44i32kZoL89cXQqCBoDeA8/fE62MbsZLby
	UjtQrdArWcxT/JFnm/3fU1kWn7eHjJnGIWDYuFc49Jl4yfnRztLMha4YUHtKbw==
X-Gm-Gg: ASbGncvlMgb02+gU+BCU/f1b3iGyKMwt8QSVl32bXMOzHK3GU6jWjA4rGW02c/NJ/u3
	Y5X2GZXNMi9i6C/8Y+ASoHDGQbAL5bbAeMzPqbIUc2m3vzMzi72BOsunjZjwxFhkZXXIM+Hbv15
	TZMuXduFo4xJxJdv67CTN4a7JmVnfiDUf2GTK7i8Klr2DtI5zzE6F+pSSzzqCVS6A/QePwv/bVF
	y5fCkj7zzAE48UzLOQII4Nz0Sca0bxajW2Bygzid0lgHr6SrNsE0WXjwBT3F91FzsnR3tjN7NrO
	fk77tDLcrRzZe8GSficldV6yQf+NZe70vbWrctPTN1/yiN/6KkgGOfSlJlFQbSGGTvXOAmJgyEu
	nBDcL7Tik1ieeFQ==
X-Google-Smtp-Source: AGHT+IGE9R9Fy77FhAF9JRz4xxZkNUBo8c+err2ZhJ7AO4sVR8WEPnkuYStfe1uzVtW2ODEUYk/LiA==
X-Received: by 2002:a05:6214:2587:b0:707:63ef:35cc with SMTP id 6a1803df08f44-709e87ac8cfmr3445176d6.4.1755026631671;
        Tue, 12 Aug 2025 12:23:51 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:acc7::1f6])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7097e906c3csm101471076d6.65.2025.08.12.12.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 12:23:51 -0700 (PDT)
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
Subject: [PATCHv2 2/3] wifi: ath9k: ahb: add led pin OF support
Date: Tue, 12 Aug 2025 12:23:33 -0700
Message-ID: <20250812192334.11651-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812192334.11651-1-rosenp@gmail.com>
References: <20250812192334.11651-1-rosenp@gmail.com>
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

For setting an LED to active high, a negation of led-active-low is used,
as two drivers currently use that and no drivers use led-active-high or
something similar.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/ath/ath9k/init.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/wireless/ath/ath9k/init.c b/drivers/net/wireless/ath/ath9k/init.c
index c911b178dcc2..7826b113235d 100644
--- a/drivers/net/wireless/ath/ath9k/init.c
+++ b/drivers/net/wireless/ath/ath9k/init.c
@@ -662,6 +662,17 @@ static int ath9k_of_init(struct ath_softc *sc)
 	if (ret == -EPROBE_DEFER)
 		return ret;
 
+	np = of_get_child_by_name(np, "led");
+	if (np && of_device_is_available(np)) {
+		u32 led_pin;
+
+		if (!of_property_read_u32(np, "reg", &led_pin))
+			ah->led_pin = led_pin;
+
+		ah->config.led_active_high = !of_property_read_bool(np, "led-active-low");
+		of_node_put(np);
+	}
+
 	return 0;
 }
 
-- 
2.50.1


