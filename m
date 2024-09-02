Return-Path: <linux-wireless+bounces-12346-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F86969016
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 00:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0D9C28456F
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 22:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35D4188A0B;
	Mon,  2 Sep 2024 22:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATGJWT3i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C294188598;
	Mon,  2 Sep 2024 22:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725317745; cv=none; b=ADXn0108kCBCusTTc7TVcrbM6I8wiIZiuZN9fwD2EmLYUuWx+ZpskeHFZTZdq+d5bH0sydZMLwqQyLLqIFLbTvgCzc74o2q4EPFlbM2gB6rbiH02PVG7Ak7MuXen0SbK9BPZlMMoKNUIz330pThXqHCGf8yk/d5iv/vJfjQAsXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725317745; c=relaxed/simple;
	bh=QrUQcvnmZvtnPzZt8iGP4n9fjXwFPYGCz1cGar7E9G4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K2Zk8WFYhEXWIq3hTthjF5+WaHf2d56Nk0XxrGoxHugLV+QvailVtvNz2GEtm5H/YPoST/yyoULDzo7pj49OIW8JrokZmwotgRJf1apOXH/rFPSnjowz3JsFnVR5v1z+PQky/5sLo726n2m48Ccu7z2ctBPkOouDt2ESfWaamGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATGJWT3i; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5bf006f37daso636463a12.1;
        Mon, 02 Sep 2024 15:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725317742; x=1725922542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVYXpp6XlxrexNwfXvthb0cGeIQ6ry7hBWcPM5Sw6j4=;
        b=ATGJWT3imxcoFo8AZb9+UuetBOqGn53S2gq1ZQXsjkOk3qIGV+XnVJ4N3ZRrHnQyKE
         Xebv5yJBo6LT335BexNfB3AB9bQq2z9dpXT/jR1xV3CfoFpSayG4e7cc+H7fNRxnMKQE
         RlOSRcBMSrUzpbf4QUBkugrs939yrsQMx/yk5ivq2y8Zo5j10T/t5SZBuaNOUO/tLIgC
         Ow/NngeJkDAIsuFRgDa0GFmlmVmF/roQonYMtUV8GqEe+ianoAcQQjP7CkrAKMnr5FOo
         SZ55qBsG3748kKUs7/V0WNBcttUFSvLCZ26CfL8AsYP9XwE6K1NuId3ix3Z/gcmJHzYd
         0xpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725317742; x=1725922542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JVYXpp6XlxrexNwfXvthb0cGeIQ6ry7hBWcPM5Sw6j4=;
        b=lwpAzP61m9cKJKI84Z8shTBIcJkLengbvAux5dulVMFvRUUuLbYy+z33LR3gd5gPTL
         9/pbQSaOUl0Z5KKkYFszuvuu20n8J0JezHiaLX6PobwruH5/SdizPQ5DztPmCSdV9se9
         9js+TnFczG62C3u/en3esoXmoxiov0nGYU9kYLXHwE8/F0mE/RwrUHUNxCfsqkfkFMii
         iQHsKUTnI/EbqRFDpkCEClDvDGu+GOySFAfcuNQDm7EKMv6UQxQnMM6aJ+hj3I4ybQBI
         vE3NFen+1B/bqfwij1SKfVIk5kq/7PG50rvJKOQzE9j6V5X8WHTzZ3aDDIEhW8jT9L/Z
         dbkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjNm8ogZwA9Ww5fw9atfoZrb1WGxIRMNiQgDtymKP0XnfontA7g5VkikqZVSDqbaaGi/v7QbPMy5+TOacVrT8=@vger.kernel.org, AJvYcCWDV1fDTvt/eArxMYmWlliGRsWSUKBBtN3xI+puvauuwFlDdsN42Oc0CrmBcMbkBhTP3ORuIt0T5fHG@vger.kernel.org, AJvYcCXFWK/Ga9aguQdFhZq+OV3jsZg+Z/OnNywSxY+SPcaUWp0B8JQLr3P9t+xi3qGSvaBGyFne6qCd@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4vz7ZGRL4ac5/TPWtZY25YSgBx1jgROSLc+vSNkStXwJ3l1pH
	a7VvJ2Z49FZHcq7bO+7l6faPwiTxhqXcRwmPCPRHGZhxizPicXe/
X-Google-Smtp-Source: AGHT+IHbdygsiHgue6jnl1jaLVDHduB6XMrVTsWjFGMYu9OGTpHCFsbA7oouOyBeUFys2QcOOAL9YA==
X-Received: by 2002:a05:6402:2711:b0:5c2:6c75:4359 with SMTP id 4fb4d7f45d1cf-5c26c754480mr578287a12.9.1725317741625;
        Mon, 02 Sep 2024 15:55:41 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:bc14:b544:1196:d1a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226c74184sm6040568a12.32.2024.09.02.15.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 15:55:41 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: linux@armlinux.org.uk,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	linus.walleij@linaro.org,
	alsi@bang-olufsen.dk,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	nico@fluxnic.net,
	arend.vanspriel@broadcom.com,
	kvalo@kernel.org,
	robh@kernel.org,
	saravanak@google.com,
	andriy.shevchenko@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	devicetree@vger.kernel.org,
	vassilisamir@gmail.com
Subject: [PATCH v1 2/7] net: dsa: realtek: rtl8365mb: Make use of irq_get_trigger_type()
Date: Tue,  3 Sep 2024 00:55:29 +0200
Message-Id: <20240902225534.130383-3-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240902225534.130383-1-vassilisamir@gmail.com>
References: <20240902225534.130383-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert irqd_get_trigger_type(irq_get_irq_data(irq)) cases to the more
simple irq_get_trigger_type(irq).

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/net/dsa/realtek/rtl8365mb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index b9674f68b756..ad7044b295ec 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -1740,7 +1740,7 @@ static int rtl8365mb_irq_setup(struct realtek_priv *priv)
 	}
 
 	/* Configure chip interrupt signal polarity */
-	irq_trig = irqd_get_trigger_type(irq_get_irq_data(irq));
+	irq_trig = irq_get_trigger_type(irq);
 	switch (irq_trig) {
 	case IRQF_TRIGGER_RISING:
 	case IRQF_TRIGGER_HIGH:
-- 
2.25.1


