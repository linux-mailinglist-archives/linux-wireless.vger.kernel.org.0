Return-Path: <linux-wireless+bounces-9448-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A1991309C
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Jun 2024 00:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 065112846FA
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 22:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A4116F26B;
	Fri, 21 Jun 2024 22:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpnhcEiU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F28316F269;
	Fri, 21 Jun 2024 22:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719010565; cv=none; b=W9ZGcZ3GoujPgbX2jthg6/R+QgOopPTZMZI9lo8xSE0Zo8tJV/iO++N4WCmhBP1eGcjoGxL2WHrqoExOzCuTXE7uMFrgHYUUADKS7+soNmX6E3rpsxzxtLbeHNrY1XLaaqVtla8bwcQo7WvOQ3VSPS98eaOkXl/2jj1EodpWibM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719010565; c=relaxed/simple;
	bh=4oUdsvqCDrLiUkMVo03wVv5uUKw1KazsqU/cnfG6uhs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pxBesKO1X46HwiAklYuYAzT7VRMckip/obOrsnoApCJdj57tBtZNuA2Wi0N4t1sIqhUX2tAMLJEKXoLmfi60aAsY2+mNY3MHnCB9wLDvblrJH0IppCTrD7D+dg8fZDKjFSihxfjhRy/NFVtlTMmkR6V/oIVypWpI8YpbsLitya8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RpnhcEiU; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57d1012e52fso2878904a12.3;
        Fri, 21 Jun 2024 15:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719010562; x=1719615362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o6JyC8iY2Muk9y3RK0oBca3B3yHY25hFFfJVNqJVifY=;
        b=RpnhcEiUYYOJlE5qcJkpkGmIdXNALB06vtFzmr2A9aIT7DNwJUvQ5gWnxQyaz1iG6H
         jK2MEQ7EFNz8iN+fe9lhpNEXdFnCSWNaOUXiBoX9pFYE2jUzHe7wwYjQ98Gz150xbi83
         8H7rCiX5+lwNrjbemWUe9KOzG0Fjqn9Q4QtS9MXhldDC67LHZO2k4UeCEn+WRj4GO9Iz
         mqgWB2ovi4ypyFBqP7pacEq8GeRbmlp1qzxFFYsKvjmgehYgnm+to1rrzk0jZY+9o6Sb
         mNGLx6rGGzQasQU2Koxzq+PJJ0Mggw3KWE5tzaRrU93NC5MPKXS7CQiuXSmFlWS44qNw
         0PwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719010562; x=1719615362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o6JyC8iY2Muk9y3RK0oBca3B3yHY25hFFfJVNqJVifY=;
        b=NZjuro3UlziRHBKjiJZjQtP9/4Ha3X1i+gHZ/bsLpYoZTMrG0yV1+dgaMQeWtWep+l
         cGGqLYxuQO78aGuy35HA1rdcsJtmFQh0Oc2+dtj/wlZqgGLY/62EVSzUJDNEp5BLbJfZ
         J2tY0kBxYZ+kb9PFQxf6q4hXpBxHK9NwN0doFVci2VA4wEX5sy5DOE+i3TdK13q2w9DM
         eLndknlUzaxGbzx9MbkSReAmKTOhKff7skoGjFjE1w5CA5L0wVx2guJvBQSMdofneSJh
         e7Ymh5tkOzRqOKZWz5Sh5ZGzTDWcqdOGNpqYngE1xMNYcG6DYKriV+OnXBUnqJG/oX6P
         z0kA==
X-Forwarded-Encrypted: i=1; AJvYcCX3TRiDzikPHH07afKU43e+tRH02NoLhFaX54hD+pNvhTvqN9fsJPP7nsrcuPpGwCdDsNOcNrnH9DeedHu3rIq7CRq1ZF/H/1V3AmgsT5qLIrilFrpRRLXkNrhpbzLuurwZwzHfF4x4EWgV4VQ=
X-Gm-Message-State: AOJu0Yw6shbTA0IBKh49oEkQ2g4VulZoFRjv3Fce7kE5HlAMurflTDcC
	MFRGSGah8Ae/VbluhsRPqv732Ej7Acn90F2kuTQya/AUFlKHzv8=
X-Google-Smtp-Source: AGHT+IGMzl+xBQUL7dOvE+TEcJ/gGUJX9+zMX68SSdTV8Tvv2glRsSTXnvBMZenX9Rr13Y/oi/SAXA==
X-Received: by 2002:a50:d6d7:0:b0:57c:5f74:d8ff with SMTP id 4fb4d7f45d1cf-57d07e750c8mr5784439a12.21.1719010561093;
        Fri, 21 Jun 2024 15:56:01 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:aed6:1d20:313e:7dc1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d3042d421sm1537795a12.42.2024.06.21.15.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 15:56:00 -0700 (PDT)
From: Alex Bee <knaerzche@gmail.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org
Cc: Alex Bee <knaerzche@gmail.com>
Subject: [PATCH] wifi: brcmfmac: of: Support interrupts-extended
Date: Sat, 22 Jun 2024 00:55:58 +0200
Message-ID: <20240621225558.280462-1-knaerzche@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This "new" version of defining external interrupts is around for a very
long time now and supported and preferred by irq_of_parse_and_map
respectively of_irq_parse_one.

Support it in brcmfmac as well by checking if either "interrupts" or
"interrupts-extended" property exists as indication if irq_of_parse_and_map
should be called.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
index e406e11481a6..6cdc941552e3 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
@@ -129,7 +129,8 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
 		sdio->drive_strength = val;
 
 	/* make sure there are interrupts defined in the node */
-	if (!of_property_present(np, "interrupts"))
+	if (!of_property_present(np, "interrupts") &&
+	    !of_property_present(np, "interrupts-extended"))
 		return;
 
 	irq = irq_of_parse_and_map(np, 0);
-- 
2.45.2


