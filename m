Return-Path: <linux-wireless+bounces-25958-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF06CB0FDF4
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 02:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F57096434E
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 00:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE30DEEA6;
	Thu, 24 Jul 2025 00:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbdZDPGP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBEEA48;
	Thu, 24 Jul 2025 00:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753315957; cv=none; b=NiY/ILWJQkVUcJ4U9zare8S7kvSGtPYWfssB8VMH0EWTJv7UasB+pQEzAfSmrA/qL82kSDqxUD/lKIZycwuQzcn1fF89FcOjUD5wUUMpKMrDFVcYRBlERIb3J6FgWLFfp7ywAvVNjcsR1jTS7EHyGWMyotojSTlTs9VS6t+Javw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753315957; c=relaxed/simple;
	bh=nPYomd4+h/blVo2lH4iGrbILo1SmN9+qbw57ufi0CO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r7tYQkMT04zOAlpssZAyH9AH6fRrF2exXpewQP7et7DSlG5JhiF4GE0lZmhtPh35ugfm91dolcGXREXZhPK20nzjzciLTSjvgWHZsY8kq43/UfiMbRGqpKcSv4fu9Q9V6+7/yFoc9KL+62iz8bVsueCP2MiqxANOQCqzDWywNwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IbdZDPGP; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-236470b2dceso3131685ad.0;
        Wed, 23 Jul 2025 17:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753315955; x=1753920755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5L6Yw9qj+C+fk9cMl6gaUwf0SSDSeUHItDrsTR+grto=;
        b=IbdZDPGPSkGxp7x2G/myebp6mMsuPmaZgneiUiUYipDLh+AjNtYiJAsiXQLj1gnfaj
         CHBbdVfJyOPNk/xXRBtFYlLbzy9EThvTD2EJCv8Ol17M+0zNv/8ZLgi/YxeOhMxXCR9t
         E4YQm+Lj91yZPXfDgvWi+W/jbfTO00aNmH5/FGybt8N9BEgEtOKMmQoKmUOnHvqFwD69
         5NxxJx2OJvw8emirrK7VazVig2g9mfenMAt6AiHgmlO1s8NUFJ6Nl2sOUN6l/r22yDv4
         cR0O/jVwBXPBg8Q0oZf89R6wuhf9pmfCh3HPSCCCOor6WM1vHqdmJgnjIETT0wPnseWQ
         99MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753315955; x=1753920755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5L6Yw9qj+C+fk9cMl6gaUwf0SSDSeUHItDrsTR+grto=;
        b=geCAtZPUKXiFADWMM6Uft7rWfEWjOmHIDekbzHwApf/X31KFeFVJvZGn/jJHIUL2Hi
         NYzq/ocCtRkkD/mfD7FXn2lSwIGjdYsahgvLMzKQ4JctnPxhTX88f+CxNQhtNLa/5tY5
         0kmL5wCVmyLwacX7lRxJBxdMbE8IqZ1Os52/XW5XyBMx0zeTj8MLzX9Znt4OI7oOap4x
         pDaHTH3KPGNsThkC/4lTqdon73F4cb+n6X34lpPJtVhDpOHTI7fXzOMbtNv3gs+H/6+h
         L9N+FdsLhOs1K+xMYfipKu4exXpSWSTt8/0VrpmmuNUf854GM2dKS5RRIai7RkiQ+vP+
         8HAw==
X-Forwarded-Encrypted: i=1; AJvYcCUOQPQFFIZ5EXF+IWVVsmg8OYjsVIc0DNOGHeIRpDBpFvi8uoMsplpyFTgQFSSWvayO4fABFDnRrs6tPA==@vger.kernel.org, AJvYcCUf4zs9soPXIwYBRnPPBQGX2n+0ZUIq6R5cNRtbiAoZycWYtMqZpIB6wsqm8PwW3eRA0PGqTycJSY5P@vger.kernel.org, AJvYcCVqB2fYeH/RzB5WtJ8ZP0Dq9leP34C0zrQQVGKNHlDTxOZds1He3ytRZOF7u4gUZmq+Muy/uYa0HJfjqKNm@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj81oRYIETzNoPybixx+l8Pc22bwe4Go5cujCzLkX+L13i0VQH
	kSAA1BPbflxqM07ahuBUPnSLcddY6sPyYNIFGh7nq/RTP88fBCm9CU1s1JoHxMF/
X-Gm-Gg: ASbGnctmo4QCjwtHsy6u9xmnTuwWq9auPBiGcvFiE5goecOVqA14me+cctUgUv5KpCC
	isqqcg84FQR7ahwki043DUGJIjlNWxMPS/fStDZ0yGMJa3R08c5RSV9p8SJiBtKIbp6jw6VKdoP
	pTWaVumG4jtVxjQaHaV1vH05sozuY7UQfKHbMmROmn+3ifakLKKeK46J4CujgwVTIUoG8Ay5k8w
	e6tcSWHK9/kwROWmauu9X5zx3HcvBRrzg6fk3TiwJY2KAHYc04O4+Z82Tcs5OfbUJTxZDFygHrk
	VfS0VDztXV3w44MWVc1OYCwiTzfEeEovmAUTeSoDXRrzrLeW97uEKK1WcLT6NF1CvzS/7I6s7J2
	4lqA=
X-Google-Smtp-Source: AGHT+IH+ENFLH33+1T1wQ3ORvxI/s245nJcYnuJqXjCwexDbtRPk7xZm2WT0Tgl2ZpfXyPs5PwABTg==
X-Received: by 2002:a17:903:fab:b0:236:94ac:cc11 with SMTP id d9443c01a7336-23f981403afmr60364405ad.7.1753315955528;
        Wed, 23 Jul 2025 17:12:35 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa476c131sm1872265ad.45.2025.07.23.17.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 17:12:35 -0700 (PDT)
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
Subject: [PATCHv6 wireless-next 1/7] wifi: rt2x00: add COMPILE_TEST
Date: Wed, 23 Jul 2025 17:12:26 -0700
Message-ID: <20250724001232.2275-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250724001232.2275-1-rosenp@gmail.com>
References: <20250724001232.2275-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While this driver is for a specific arch, there is nothing preventing it
from being compiled on other platforms.

Allows the various bots to test compilation and complain if a patch is
bad.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/net/wireless/ralink/rt2x00/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/Kconfig b/drivers/net/wireless/ralink/rt2x00/Kconfig
index d1fd66d44a7e..3a32ceead54f 100644
--- a/drivers/net/wireless/ralink/rt2x00/Kconfig
+++ b/drivers/net/wireless/ralink/rt2x00/Kconfig
@@ -202,7 +202,7 @@ endif
 
 config RT2800SOC
 	tristate "Ralink WiSoC support"
-	depends on SOC_RT288X || SOC_RT305X || SOC_MT7620
+	depends on SOC_RT288X || SOC_RT305X || SOC_MT7620 || COMPILE_TEST
 	select RT2X00_LIB_SOC
 	select RT2X00_LIB_MMIO
 	select RT2X00_LIB_CRYPTO
-- 
2.50.1


