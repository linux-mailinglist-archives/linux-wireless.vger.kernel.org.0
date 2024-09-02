Return-Path: <linux-wireless+bounces-12344-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FEB96900F
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 00:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 633342845BB
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 22:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DF318787F;
	Mon,  2 Sep 2024 22:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4tZU5LE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF20813E023;
	Mon,  2 Sep 2024 22:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725317743; cv=none; b=L/twA/5YWPh57NhLs9gedIzZ9QMBKle8uPUKp3WLgbOd8bSqc0AA9AoG8/FLMFv+wXQLN9aRhF3Zl+a/9QHbOE6XMbRqAbJvHW5YtOT61cGdMfIAqpTCEcXMWEhrn6CfoemMeVtk0ZMxsrLUIWivKd0x4FSV4Qlu5XYFOtMlzb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725317743; c=relaxed/simple;
	bh=0yujmkWzIEBEbiPlXXYaWdyeb/4nfYm0KbRCPGu3xoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MvsFlanFKyRUwFbMwPYc61vguk2Sg3vcDOlyREJXEkblehiumAVu4I17+mAWOLdk7oylAoS90Ty4+Eek+t6mbpdPNZK2AJLntgpP5Ohnu6RngDu4rbuFacKAVog8hElqMGIlWsQeaGY9suC6sKrCX0tHNdW9kaCzQaQTRhKna1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4tZU5LE; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8683dc3b17so287684466b.3;
        Mon, 02 Sep 2024 15:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725317739; x=1725922539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xu5CM91Lk2oZ+OxbDGkmejn194UlhGYuczl7M1O5rRM=;
        b=O4tZU5LEExZGc0l5eDCPO6jvC6NrMIahnOcBPBU+ts8Jhl6LbvA/8GGnC6KgyNBNCa
         mU4ZvOpPr65bGmWLcmJFkawpU1CkVnwsx/KL9NOLBrPVCs8W5ZfNuN8l5EGcxnNaxRwF
         AKEP0SvjiiAS48su3yNNs25zyPCm+wU9RDHfyMNcutti7nGrDM9mN3+Ltbb7N/srwRGg
         lE5vv9lIDOhzzqoA9T3rP1FXkx4qOtPxK+gYMNaN8KdwI2JDI5K/A/KNwE/GuOW8QIx3
         BN54vQahDPe8bkyIJFo0wsWHEnIeHloby5tja1EP9DqPoB0CvI3oyalf7BsvRsRXiU5X
         rwRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725317739; x=1725922539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xu5CM91Lk2oZ+OxbDGkmejn194UlhGYuczl7M1O5rRM=;
        b=Id+gIOdORtLcNFNjVUWlUSHrVuPc4Ok5J/EL2t26G71bAeiQ2bRM7MhEfM5JqLk0Wm
         Kf0v1MpGRZ6qd/WuZtcVLtL4MbpBqV1qWhLkLTZaJIQ4AOlNrN6DTy4HE0xy8xWnN8wv
         uxkmC432tWN83porBDQbgjmWjv1sztGa74kUn96U/5Ldj3KHAehr11v/r0slePR85Ksn
         GuYuSyPu6E0WTuauvtNYLbRFbQQS5F2MbD1lkQjVj4PCTcRSYNW6xGRDmdCYoys2Hk7b
         0q7+RpCqflBlmaOsGDRDIg46yOOKZRX8b9sXUZLNYj2EmqIWirCsELHKBhE3d0wpO613
         ENTg==
X-Forwarded-Encrypted: i=1; AJvYcCUVW9XnrPYBA5mtg1WxnMCdQbYp0qkY9xypQl0IvFr7RHNMcrWC1/p2R0hJqXVyUF82r1juYHFWl6ha@vger.kernel.org, AJvYcCUs3C9dGbCA/b8PUlq9+DL59rC+7X+4mtBDE/tEAp8BH+uXnhIdl69IYVGGfea+dnViwFrawezPPfLyCvYCT9w=@vger.kernel.org, AJvYcCWzXELSXUs3b35D8/zIqh27l3tI7oDckju0Sqfl1PPRMimv0Xr90L3RfbNZ2x0HZhhDND6BdBkX@vger.kernel.org
X-Gm-Message-State: AOJu0YzDh5OQgXhMp5igj0n3n1Mh8+kJn5jHpG8Ed75Jc8OpKTuK8PZ1
	8KJ3S2MjolK6Hg+QC7dlALMAebwmEXtl4RhGbuCJBU0idPue1s+s
X-Google-Smtp-Source: AGHT+IEfE+c4/8xMLmmWu8kkZwnYE1HcqixXWH91x/35qPsp+687gR0j/immZ9Uoy4QrIFhv0iPBQQ==
X-Received: by 2002:a05:6402:268d:b0:5c2:6a73:d13b with SMTP id 4fb4d7f45d1cf-5c26a73d3c7mr1172896a12.34.1725317738594;
        Mon, 02 Sep 2024 15:55:38 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:bc14:b544:1196:d1a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226c74184sm6040568a12.32.2024.09.02.15.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 15:55:38 -0700 (PDT)
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
Subject: [PATCH v1 0/7] Use functionality of irq_get_trigger_type()
Date: Tue,  3 Sep 2024 00:55:27 +0200
Message-Id: <20240902225534.130383-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert irqd_get_trigger_type(irq_get_irq_data(irq)) cases to the more
simple irq_get_trigger_type(irq).

Inspired by: https://lore.kernel.org/linux-iio/20240901135950.797396-1-jic23@kernel.org/

Vasileios Amoiridis (7):
  drm/i2c: tda998x: Make use of irq_get_trigger_type()
  net: dsa: realtek: rtl8365mb: Make use of irq_get_trigger_type()
  net: dsa: realtek: rtl8366rb: Make use of irq_get_trigger_type()
  net: smc91x: Make use of irq_get_trigger_type()
  wifi: brcmfmac: of: Make use of irq_get_trigger_type()
  wifi: wlcore: sdio: Make use of irq_get_trigger_type()
  of/irq: Make use of irq_get_trigger_type()

 drivers/gpu/drm/i2c/tda998x_drv.c                     | 3 +--
 drivers/net/dsa/realtek/rtl8365mb.c                   | 2 +-
 drivers/net/dsa/realtek/rtl8366rb.c                   | 2 +-
 drivers/net/ethernet/smsc/smc91x.c                    | 2 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c | 2 +-
 drivers/net/wireless/ti/wlcore/sdio.c                 | 5 ++---
 drivers/of/irq.c                                      | 2 +-
 7 files changed, 8 insertions(+), 10 deletions(-)


base-commit: ecc768a84f0b8e631986f9ade3118fa37852fef0
-- 
2.25.1


