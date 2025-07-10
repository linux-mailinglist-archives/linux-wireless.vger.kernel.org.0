Return-Path: <linux-wireless+bounces-25223-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0EAB00CBF
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 22:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 078005C1E17
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 20:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAC2326247;
	Thu, 10 Jul 2025 20:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgZ5qPdM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA923196AF;
	Thu, 10 Jul 2025 20:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752178106; cv=none; b=AtQFa4+3i+Jx/rHtNIqBFu1aYzkfv1M/m3l7VqeI1WKkvagrLive68zwYrDw0meShJoywm6H8sDknFI1BsZa7gPRiHspHW6G2Xid6psPC8gRW3VZgZqyhVhJdCVY93BiyuG1MsIWLBAqUyUmD3pUAb6a4wNxeJEYeRNmz/Wqpeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752178106; c=relaxed/simple;
	bh=X3APSiAWL3Go+tUkn+KBsEhWZUZF0XELnyOttvravBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IwkyoRH0FHsPGkkxPbF98uY0wgdtnm89gWfr1HRoULfCtf4bc5IMbraosWmo+Is0yoJc0/WSIK1cg3F9MbwDB0+19yMUCDwJF7YOAtI4BoufusL/Lt5aeBifpnp/KwSOnA3innlBiLrqBOX2gzn9nHCKHEXnljYw1i26gBmKOPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YgZ5qPdM; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7424ccbef4eso1447104b3a.2;
        Thu, 10 Jul 2025 13:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752178104; x=1752782904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKAwUXOLwMRO+DlBAOVwR1oRm93Guv88/PxNLjpkT9I=;
        b=YgZ5qPdMrHy693l74vnQJiPrNh94PMjT7XpF9AAWFFleIGFC1J2HYkHgxkhUBLC3rS
         lcdoQyd09dvwu1APyP1kqeLsOEu9EBEtTpUuYOBoepAFwTjcQtue9PiDrYW2eEEl5Fjl
         nMBNIWesc8yad0i3Ewj9li9jZfwhQ5TMfN/Uml6URIvpjThz9RvEvPVERz4oDnwzkaBJ
         XtF85r+dVIBFfKJlyNZ1UBTGpLOoeJDCc7bKOfRsn8kAIq9esq1qO61XcM1LHLR8XYMg
         aosOSNJfGpM2OHGfRlHa4Li74H2CMuEgKz+aMVsUWndC0X1PvpZ5Ad4vU5gyjC5KUffS
         R8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752178104; x=1752782904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FKAwUXOLwMRO+DlBAOVwR1oRm93Guv88/PxNLjpkT9I=;
        b=tzTb4LxwAxxYVoWcZBhWSGUGmemq5YPqefv9sN+QgycCfKiaihBDYE6g/g0w+/WzuZ
         UAHrgQss6a8fRJGccxnjCuokruF/LxLbPboBv2pXc+n+YNEepSIarkqbyQmOiX4gPKON
         LmES7uUaO2ryGUy9fRYLcXGcUpUfjJQ4KLarwl9cJ2rsb/i07MeM2iPGWvpANppkwXcl
         hplRTYDNX2Snw4c0CrnFGqnbyHEy7+Cp0Bc+sP4vKFRg+RiiRcS11d4NRuxuDuoY/Z0I
         B3e2uO4hbhb8EXUUCJss9afisfcOuN1YVNPorICcAYEkHS+Ljvr90zPczzpabJ2IUoIG
         lgPQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8tuDQXQcLxbk0TpcdExQlGgml0i3UqzvBemmmF/MHnuWbD366iPg/pGtfXgjJVIzSvLS5fLVbUd2v@vger.kernel.org, AJvYcCUwK5/znpYqqujQiOkQdzSUpPeI8QYvFWAqequVwcW5jjifH10Sr6DB1PWPnDCwrawt/VDbSRZagP2ZjnNo@vger.kernel.org, AJvYcCVeu59eu2xFluJQOB8vnhkHTc/Pg0luS1A2ugM+PTR47DFsOse9ojo9mwXnmb9vEjzGgcvNhIvk2aCCgw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXstZRlZ3LVptqIhycQkqu88giwpIGH9OK5j+mppWrCVf6TgYc
	InN6CyeEmUqeGDklHpDUyrKAJUvOBLUKZpZvJHK8fsjNA+6I+v3xTGqZTtUJdsis
X-Gm-Gg: ASbGncuHa+qwEcsKG5zdszilYv92+tz4VxdSCCQ9hvjC/ZvL72bvhUoLmUnIhwhFOg3
	42RxyQP5ZPKM1a0bHOFkrPTz+KhWNYhuqwLgIOqWWNncC+q1uW+J0VNRz4Ev5Ck6pdo8t7fWCBR
	rJiug7v0PFbUAvvTcduiS5Wwkpp+5bGWxu8Jlgk0HhlwuEOW6Np77y8Mp8kyl0BqGr//iiwP5kc
	pWmtvWuNcCYxF4C20Y8HiIXgz1xctxDNkj76wtSnPB1aqh5QgUDr2M9BZlOGabo5HNu4yzplEQH
	avdG22Dl1cYD80HyBHiiGkzOhpqUhZrD0RiT/A2uhQ0=
X-Google-Smtp-Source: AGHT+IHIoyNrGJo/EIqzw1srVVXSz6Hg7IDYitZm1P+VMxLFLgoRFUVoV4IOf2xwEsG8pptxtDj/oA==
X-Received: by 2002:a05:6a00:b90:b0:73d:fa54:afb9 with SMTP id d2e1a72fcca58-74ee07a860amr530115b3a.7.1752178104580;
        Thu, 10 Jul 2025 13:08:24 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1b29asm2729453b3a.87.2025.07.10.13.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 13:08:24 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Stanislaw Gruszka <stf_xl@wp.pl>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	linux-mips@vger.kernel.org (open list:MIPS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
Subject: [PATCHv3 wireless-next 2/7] wifi: rt2x00: remove mod_name from platform_driver
Date: Thu, 10 Jul 2025 13:08:15 -0700
Message-ID: <20250710200820.262295-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250710200820.262295-1-rosenp@gmail.com>
References: <20250710200820.262295-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mod_name is a legacy debugging feature with no real modern use. An
analysis of the underlying MIPS setup code reveals it to also be unused.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/net/wireless/ralink/rt2x00/rt2800soc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800soc.c b/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
index 701ba54bf3e5..e73394cf6ea6 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
@@ -246,7 +246,6 @@ static int rt2800soc_probe(struct platform_device *pdev)
 static struct platform_driver rt2800soc_driver = {
 	.driver		= {
 		.name		= "rt2800_wmac",
-		.mod_name	= KBUILD_MODNAME,
 	},
 	.probe		= rt2800soc_probe,
 	.remove		= rt2x00soc_remove,
-- 
2.50.0


