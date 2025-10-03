Return-Path: <linux-wireless+bounces-27800-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB69BB6AF0
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Oct 2025 14:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 190AE4E8ACA
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Oct 2025 12:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4069E2EE276;
	Fri,  3 Oct 2025 12:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPVp+u52"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7FDEEA8
	for <linux-wireless@vger.kernel.org>; Fri,  3 Oct 2025 12:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759495878; cv=none; b=CKe4/n7/FmVD5Yy6RBTthgkq9i1p+ul5aA1WEEctCZhHRZRJ1LdpcTIZOToPZHIZsm+mqSe4SW6dK0nRvPl5wybnUeos9PJ+oTeHFiTmTrVi/UBV26vj5sibEh0HtZBWjQbu2HaTGlvqOExhflNm4fVWkF51hjUQF6Lpm4qsjV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759495878; c=relaxed/simple;
	bh=4106OzuLrCHbM187f2nPxnTy8mZf5HbUyjgFSYFBlDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X7fdZfWk1xV3VA3A/XCwGnNoyI9dTCbaLy1ipPOfzVCe+crp4MlV81WsK/mx2qbezhRqwOiLqU4OALoPioaMeaB5/wYvU1KiSMsqY2N8dmAKy/iq8c0Dn68k+Q7KVlsApnPujIxJJKIx9fGB5Yq7sZrQ452phDIyd/K5RMhvXq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPVp+u52; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-57a292a3a4bso255175e87.3
        for <linux-wireless@vger.kernel.org>; Fri, 03 Oct 2025 05:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759495874; x=1760100674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mxQuA0+a8WwM5wGmsFx6bUU6ctiTtR6jNj+VSASu29g=;
        b=QPVp+u52MufJNQKSOdssJeJzcqOIHH8z5p7VDmMp/VOkaaUfsgh8r/gPQnGzQPRuM6
         JUnwzUAwD8qBbfqZyghO6AI3EVodHk8EaSLjP3xKg1VeuvfrzmGsbq3EFoEonk8siiEo
         F1DK6JxC50isMZfgchY9dUSwjkoS7o7P0rNwR/+wvETAO9ONVxd4jzQHMDfQS4fkwypl
         BsCFxQa3MI7TszZuPTxAZrimb/yyrNePWINijmRw7Bu3ZHH5ftFfiSUWt9hr7YTrButn
         G/iQ00UF1PG1SiRBzS24+YHOpGVypkChAd8blcy3gdUikx3sSyXJM/LyfEbtIBOtZ/BB
         70EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759495874; x=1760100674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mxQuA0+a8WwM5wGmsFx6bUU6ctiTtR6jNj+VSASu29g=;
        b=SWlxT0rcCC8PDrFHLk6WpVdJOXKHbflP4dWT/Vndk2pX5IwHuyzroCuRTiR/2z/rfP
         sxJEgKhR0jT7tu+eGmjYTQvm6cCxW6jMqBF5b0Rk4lVpCkxSqOXZwOXCrtOdARliZUVg
         NRnfjhcaZcwlf69LjMx5104N+rT+jvl6Y9z4cAKU+MtnA8akChP4jn8Kt4wLCu7mk28/
         8Ysi3AXs1uZA0itPbnC+ZZT10J0L+kW1289zJYKhHLLMoVk8FWcmqz0M1xHZJNRqvyp3
         pyzDjCKYw+aSA9tOhR0xt1TdCBngXh+odchIVjVwl4qlN+dmsvBJrpmv5diPtumkN5QX
         ZTnw==
X-Gm-Message-State: AOJu0YxCQzFzjgWAYgRoXzndzq93ZikRJWI0X376gk89pSlgW/HLnpbj
	5JTTmh0zbwZ9IWLatcPYMvok/wavZeSoSknlUFMqrHhUrTsz8J7QrCrt0XNajQ==
X-Gm-Gg: ASbGncuIwlhyVz6519OJUkR4wMBnYxjZpuyNuUjJhymu2EotWb5Fvy9U8duaykB6/F0
	cixSrCo9mCLkNXLetMlxK+4O2HxHURKWULO8n3FGKzeSieT32FlG1cuqjWTd2weC0JdiE065QEA
	k7Hni+uyWnPpzwWtxhlkVecn2+khJ5RCAMP3tf5OPTLGkbEd43N2iHZfwntZkVgo5PhJ+7/JMKz
	QHqKoUTogaoqDzWltMwZsvut+Y9y7IeA07t3CQqrlBkXuKg5Kx4T6FhyHEMdlIikKxZJR7TQPV+
	ZWQqJN0lASB/B3Yp33i219eUUvgKpnaWDV2c1+LxC98YW9VXKYOJFQLsJsXPybkwp7B/xcuIscM
	M85uJR7VlzVFUckLuK7IS+GYn9/H5zih9kPMHOf9jNIFo6xs/qUZHyXQ3
X-Google-Smtp-Source: AGHT+IGOkIiBxFS7sLKqdNCtuaLNaV5ILOMjEF/5BHH4PN6Le2G5tSzvYWzPfB5TcIQlAYpjPdpDHw==
X-Received: by 2002:a05:6512:3e11:b0:581:7695:a14c with SMTP id 2adb3069b0e04-58cb984e3c0mr792738e87.20.1759495873858;
        Fri, 03 Oct 2025 05:51:13 -0700 (PDT)
Received: from localhost.localdomain.pl ([89.151.31.85])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b011b0f0csm1802380e87.130.2025.10.03.05.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 05:51:13 -0700 (PDT)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] bcma: don't register devices disabled in OF
Date: Fri,  3 Oct 2025 14:51:26 +0200
Message-ID: <20251003125126.27950-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

Some bus devices can be marked as disabled for specific SoCs or models.
Those should not be registered to avoid probing them.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/bcma/main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bcma/main.c b/drivers/bcma/main.c
index 6ecfc821cf83..72f045e6ed51 100644
--- a/drivers/bcma/main.c
+++ b/drivers/bcma/main.c
@@ -294,6 +294,8 @@ static int bcma_register_devices(struct bcma_bus *bus)
 	int err;
 
 	list_for_each_entry(core, &bus->cores, list) {
+		struct device_node *np;
+
 		/* We support that core ourselves */
 		switch (core->id.id) {
 		case BCMA_CORE_4706_CHIPCOMMON:
@@ -311,6 +313,10 @@ static int bcma_register_devices(struct bcma_bus *bus)
 		if (bcma_is_core_needed_early(core->id.id))
 			continue;
 
+		np = core->dev.of_node;
+		if (np && !of_device_is_available(np))
+			continue;
+
 		/* Only first GMAC core on BCM4706 is connected and working */
 		if (core->id.id == BCMA_CORE_4706_MAC_GBIT &&
 		    core->core_unit > 0)
-- 
2.51.0


