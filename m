Return-Path: <linux-wireless+bounces-15148-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 001959C251B
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 19:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC81C1F2405B
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 18:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAE5199385;
	Fri,  8 Nov 2024 18:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGkNLkxz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9566B233D96;
	Fri,  8 Nov 2024 18:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731091943; cv=none; b=osR7CVGBhVPuj6hKDSV7ZTg+fI7QGvjVOk3S6NeocUwE2qgPrcGvRjKdbdOIOT8Rx5nM2X9AReF9wNJjUcqi8DeDug8RJSv8ZGUh58RuY0cLIPOKE/anDOFw13LK1aw4R/jW9mxyx+C99oNmS0z8uo86TpVTgOgdiOYPuZJGPZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731091943; c=relaxed/simple;
	bh=A2hSK+sHXgxm3OEIytBivzn6hGIJD6/8WxFeB9ebGnI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FZxhZLTSCY+XLmxiIuJTCz/NEluAJ4G7z9CKtOM1iYhalDWOJrk2L3FQStjv8evxfr4uYiV4Hguy7Eb6a2GahcaoyGgiGWURTKufI8T26WLdK2fD3cPIgKVSrLDoV9wo6GDGNhIQzT2ah/KEVnScS5U0W0v4MK2PqGBJ3MDz1oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGkNLkxz; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a6ace3b6a5so8967185ab.1;
        Fri, 08 Nov 2024 10:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731091941; x=1731696741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lBssO/4mh3YLOsQWkyDKnQfteClw73MBYYg3Qpci+rU=;
        b=bGkNLkxz2hXHMPd+8MHkzXP7CGPbjwLZDiNTNr6J8IlzVgk0Kx+U1FUKW1roHk+NYh
         FnRCR9RXyRY39LTqhuWQmkdYQl7x0LG3VK/tyz7VXxvoCNzqmSlQ2D8STHBU5MUksBGH
         qQwGYbi+ytz9ri/HBxIBHReEUZfTU4/TrvsLVj61u17lC5UXs2m0nQj9p7O3uibPFqWO
         LJiBNPvJi7lT+m1Jt/ouqF7jAmF4X/1K0LGhTkIHclTTFHXVfAtRR2f/8tFc0Y914KZb
         gus4b+MssA9+nwFiPDxxJQyBOUuv8UBZbVNsJNQjvJsLf2flA5jkwpitB5dGsBKWTPM0
         ab3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731091941; x=1731696741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lBssO/4mh3YLOsQWkyDKnQfteClw73MBYYg3Qpci+rU=;
        b=bx9/LzbsAsqC9Z3SMNreL79XRs1PY2qtVm5qWFbaftrxfmm6x9Q47StznWZehrwXN+
         MOyDI+m3AZqI0IPE55afWxpWmhuGIqL0ocKFP4tWF5/+9zX8AgnWVHrV/8dnX6wLg9p5
         wMVociJW2Arq5sFLxqVoXupCRi9Bv7W6sWaCSpdipv4rJJZQu3jMkDidK+WIz/aWaxOD
         seqbp2jBlabzA6QLXsTzszOAhXzg3X+rbhs1Q9xZZUznlY8Ndh46pjbOPcvAezChB+pr
         3RnLSeCiYyL3NO88eNFiCQqfT4jJUrRAmf3o6tLlT+moy3fa+N4D7YwiiDmLH19ctaWq
         Qqhw==
X-Forwarded-Encrypted: i=1; AJvYcCW+6DQeYNW75QNBGP34h5RTiuWld2Vikzh01crikpksZUR73YtPUApesI89zHVpReTrwvKsK40nTYhzLmE=@vger.kernel.org, AJvYcCWW9KXAeB3MYpnjXBameUBCigwsreWINzQ1Qbp+0OjfVGfEULTXsSoEHtIuqb/zawTGZbRcg3HOnsVThYA64Og=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVFUU6AnovzaZVfTkDuTwv00BQoE70hSMNXBljhZt+MDiNtg4k
	I+4Cumh8XM5Rkm4onZ+nJ8ZP0Zif/SZZWuOSNUNkK+xlGzD4FGFr
X-Google-Smtp-Source: AGHT+IH7E9Tpdy+oYZSCJw+j/sq/o9JFvHAPDnz0UMIdvHx4z60xHlxbqw+kRFUgL5PIWkzNAVgibA==
X-Received: by 2002:a92:501:0:b0:3a6:b445:dc92 with SMTP id e9e14a558f8ab-3a6f19a0823mr38227315ab.10.1731091940650;
        Fri, 08 Nov 2024 10:52:20 -0800 (PST)
Received: from localhost.localdomain ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de5f7e3e81sm977715173.25.2024.11.08.10.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 10:52:19 -0800 (PST)
From: Mingwei Zheng <zmw12306@gmail.com>
To: johannes@sipsolutions.net
Cc: linville@tuxdriver.com,
	rklein@nvidia.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mingwei Zheng <zmw12306@gmail.com>,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>
Subject: [PATCH] net: rfkill: gpio: Add check for clk_enable()
Date: Fri,  8 Nov 2024 13:55:59 -0500
Message-Id: <20241108185559.1832652-1-zmw12306@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add check for the return value of clk_enable() to catch the potential
error.

Fixes: 7176ba23f8b5 ("net: rfkill: add generic gpio rfkill driver")
Signed-off-by: Mingwei Zheng <zmw12306@gmail.com>
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
---
Changelog:

v2 -> v3

1. Move int ret declaration into if.
2. Replace if (!ret) with if (ret).
---
Changelog:

v1 -> v2

1. Replace expection with error in commit msg.
---
 net/rfkill/rfkill-gpio.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/rfkill/rfkill-gpio.c b/net/rfkill/rfkill-gpio.c
index c268c2b011f4..a8e21060112f 100644
--- a/net/rfkill/rfkill-gpio.c
+++ b/net/rfkill/rfkill-gpio.c
@@ -32,8 +32,12 @@ static int rfkill_gpio_set_power(void *data, bool blocked)
 {
 	struct rfkill_gpio_data *rfkill = data;
 
-	if (!blocked && !IS_ERR(rfkill->clk) && !rfkill->clk_enabled)
-		clk_enable(rfkill->clk);
+	if (!blocked && !IS_ERR(rfkill->clk) && !rfkill->clk_enabled) {
+		int ret = clk_enable(rfkill->clk);
+
+		if (ret)
+			return ret;
+	}
 
 	gpiod_set_value_cansleep(rfkill->shutdown_gpio, !blocked);
 	gpiod_set_value_cansleep(rfkill->reset_gpio, !blocked);
-- 
2.34.1


