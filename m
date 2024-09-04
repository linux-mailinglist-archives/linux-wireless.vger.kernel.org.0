Return-Path: <linux-wireless+bounces-12495-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFF396C2DD
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 17:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F4EEB24FAF
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 15:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7962B1E0B62;
	Wed,  4 Sep 2024 15:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOzSRG26"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0741DFE1F;
	Wed,  4 Sep 2024 15:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725464972; cv=none; b=XBEQUVuET06jwjBI3TxvauTT4MoVwtZOVf2ronzFaTipKL7K2rl+jv+pa/333z6Uy6rIRa6olQw4hzn1teK5kGYR8yo8d2vsSHBehE4Rs5XBOALeuYejyPDbtyeEg6y1AQRBPj40UndM/WovBBg/La3YoLQ6Pv3B0/6dcwP1kAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725464972; c=relaxed/simple;
	bh=8TF0DZ64f28Pm8Phb6WrG+icgwirkNE86A0gihnv8N8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cDXW/1gO5iZhQz0v2tRdNklJxti6j398Kt7f+KyWPA3cOlf20OajDpsTC/XWO+wb+TrTGN3iV8IzsCG1ryxugoYcQzlakIfxvquaJv5THfz43QRGVvjZbUUXb/3zwE6pYPtifGh80Csn3NMV0GsPoXl4WegWncf8SNz5L0QQLDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOzSRG26; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8a16c53d3cso369394766b.1;
        Wed, 04 Sep 2024 08:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725464969; x=1726069769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=orsagbjZ9uOmxNFDLl+5N5H1lZ9l2qcANXdjwlXzT7g=;
        b=KOzSRG26LSP16tzA2sMyFogmunvcIGU+grMlU3O3kco2nhLkrCJhoc/d2xJKQVq4zz
         aByaPsVERRcarbyUhGohX+NHq3s+/JqmDn8+ObhdW4NQApctOUwycBa0pLZYFawSJ5Ev
         NR0pOdKEIJWY4eM6fWMRU3owhFpLY75y5vHo/lZ7rDECCi8wTkocbRyFHl9ERnNCiYUy
         8AMCczlKR99F8R2ZgMj7Rea36TBeNKaNe504PJn6e1AUoS6cyGe04qRO+O+h+xENcTun
         zpygoAxxJPc+/YIJOEv4UqXBxHASGQFXYT8eXG/LGfiP8HmX5X4bG7equ6oSA6PUtSBM
         GahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725464969; x=1726069769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=orsagbjZ9uOmxNFDLl+5N5H1lZ9l2qcANXdjwlXzT7g=;
        b=DiZunWAG1j3HEQX/spOgphDESD7orxX68BfJLOiwBx4te493HRLqB1NCVxTkB4OsQM
         nabwonTspign/xpJ6mHJxbtQzHW3uKuRzyoJz09sqzHZP8hx5uiH7mN/5K5D3WlvD/J7
         AM5XfRVxnc0GKYJuLVlDgVpdoCoBKSOpXMekv/HYZQgZ7fzrhxBBNdB0D3vLDEKq0wDV
         f1UYhES6SKvDKtX1L9/PCa2U5kg21SkceSvuKFhK6pdXMWImY4q31Or6ipEfTprHVG7z
         cy4c1K3r8B9fC3wSGBYTkcoKudGYbelj/3mDAuILqAG3+/it+c3gtXvB9zr25sWbcmIr
         ei7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUeVtWSxQlZFaDvAVZJTswAj5cpNRVHIWCYpIK/uzPW3TV/BsNaQ+f7AWqSnHTDbXcHPooWfJSe4JW8+tM=@vger.kernel.org, AJvYcCXeCpZozK+3ymeoF84Aqvx6KXc8fSLc4MTw3lrxw/G3gWI5SuZGf8ondzEi3qWv2JY6xwWYpRseWBaCpoiHVc8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Op7suahQvilN+BQA7TnY82bWs03o09nVcaO1kpI3youA+xh2
	nV9Y2I18dbxXvN5y/RCaPLfuSFqRtNieb0DTe3u19YXQ32FGIjfq
X-Google-Smtp-Source: AGHT+IEduDzuYeOIdwhKy2JI4JAwMT+sVJ7/2Sg7vQy7HKUWdU3nIBK/2msTZnrIU+IDAkfsh92wDQ==
X-Received: by 2002:a17:907:3f21:b0:a86:a694:aaf7 with SMTP id a640c23a62f3a-a897f77ed65mr1247603166b.10.1725464968841;
        Wed, 04 Sep 2024 08:49:28 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:2f85:317:e13:c18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a62038c0asm7825566b.62.2024.09.04.08.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 08:49:28 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: arend.vanspriel@broadcom.com,
	kvalo@kernel.org
Cc: knaerzche@gmail.com,
	leitao@debian.org,
	linus.walleij@linaro.org,
	javierm@redhat.com,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH wireless-next v2 3/3] wifi: wlcore: sdio: Use helper to define resources
Date: Wed,  4 Sep 2024 17:49:19 +0200
Message-Id: <20240904154919.118513-4-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240904154919.118513-1-vassilisamir@gmail.com>
References: <20240904154919.118513-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resources definition can become simpler and more organised by
using the dedicated helpers.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/net/wireless/ti/wlcore/sdio.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/sdio.c b/drivers/net/wireless/ti/wlcore/sdio.c
index 9e1b644beba9..a73207bbe5d7 100644
--- a/drivers/net/wireless/ti/wlcore/sdio.c
+++ b/drivers/net/wireless/ti/wlcore/sdio.c
@@ -323,15 +323,12 @@ static int wl1271_probe(struct sdio_func *func,
 
 	memset(res, 0x00, sizeof(res));
 
-	res[0].start = irq;
-	res[0].flags = IORESOURCE_IRQ | irq_get_trigger_type(irq);
-	res[0].name = "irq";
-
+	res[0] = DEFINE_RES_IRQ_NAMED(irq, "irq");
+	res[0].flags |= irq_get_trigger_type(irq);
 
 	if (wakeirq > 0) {
-		res[1].start = wakeirq;
-		res[1].flags = IORESOURCE_IRQ | irq_get_trigger_type(wakeirq);
-		res[1].name = "wakeirq";
+		res[1] = DEFINE_RES_IRQ_NAMED(wakeirq, "wakeirq");
+		res[1].flags |= irq_get_trigger_type(wakeirq);
 		num_irqs = 2;
 	} else {
 		num_irqs = 1;
-- 
2.25.1


