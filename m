Return-Path: <linux-wireless+bounces-12348-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D12A9969022
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 00:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FABA1C22F11
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 22:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80A918A6C0;
	Mon,  2 Sep 2024 22:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kX9qg+ZK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD156189532;
	Mon,  2 Sep 2024 22:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725317749; cv=none; b=kK37dlObRA+RgZSbZ7UvaI8Z0/sX2WK0H6My/DBVrRBnGP827Oy6yuWDvk2X9Z3JKipOYW+1isF6Rumo1eXXo/HQrxZf2Ns9hokw+e+85xH7WPTNEfigm9/VHHvCc+Yc7UWCYyfthoMY7e62AFaaTFh/nOj56dQVPBXqs6s+ZL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725317749; c=relaxed/simple;
	bh=PdsMdAs4i+1KnGUSIyj6Cvkto8ku+RF2Yz6vhnepAIY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dQW3CGXT1JLnLL/twhsaVGQjDpv2oF34OaKNiSfq2jfzmlwWlMo32znk6MJucRF2MTB8aWjWNzXOa7SIgX6wC+Lw0FRp+lkrRxWZJp3hsVkuH84lK4hP6NXQF7T2llwfUc4FR54PIi2lJQmzmLUknKayBsIFEjqllgjw4AAR91o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kX9qg+ZK; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c245c62362so2163742a12.0;
        Mon, 02 Sep 2024 15:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725317745; x=1725922545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQ3BMP71Ks39+pq7NwGF6/mq64FhkUT40nnjV/3W63M=;
        b=kX9qg+ZK/SVlb/Be/b7NCc7rl9fwmos6Uzzjmw9u2BM62/m1jEVW5826FOTnALmUHE
         IRLi4nKocwG5wEVZ78nJ6cE3gP5Ufz2cx8wwXw+Kws1ehx92/Aar7aEGVa40B8mZepSc
         udkYmSsrrLfEhDTn5LRCJNzkjKyJg+rrY15H0DMJQ/WVeGFbLvQ/bfpaT1rfQcIrR9bb
         ftQfVzPF75i47R1+aVGQMdvUZxLL4leEQfEDUlnHco0W6dNWLJChil+LUaXGFOIX0fQ0
         3Jv+HYvUnx1CMI25TRwJ6XviiPon+Prj8OfiQLiHpyKXwOcJzKwOUiRHLnz4Bo/+Qxop
         hjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725317745; x=1725922545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQ3BMP71Ks39+pq7NwGF6/mq64FhkUT40nnjV/3W63M=;
        b=sx4YaJvApc6IshZrwxawTb+N1Lxic/eMYq5rE0eUcBK04P2DvWhCco08zo58NMlzgo
         2/IxoQYBE3VwChT8BjRUlQH9KEq98eVDZ6R0EgA2TlEdV/7a7OVm0vFR2/zn4nJBUplD
         /KoR/Xk/NemwGpfw5aw9c9XHNNxjxGeH0HV3OFjOEl+C3tEcUnhV1/7IOUmRs/P2yJhc
         dWX4f4yWe+VHFHmY8Ftp9JPJTQ0NjD5dKgVfQlC3gr4todgegFyYNRaFSTslWhD+RowL
         G1e/P/zzjs+P1RPtr4A1a/epInij3CEV4QFQPed/bAzlO+JZubQtrwx3IAtKMco0nNDi
         Rm3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUT+FvvL/kCq01jJs+3nPDSOBumcwkDwS9XCYnJgkrp8acAYjhqwPZIsH2MlGXr5pyKauvyJewnzVQuG6i+3QA=@vger.kernel.org, AJvYcCW5gVpafQ4Z1LvUXnkuC7O89vxZMhbmiHQDtagwzmssm3smrS90oPu7Tky9GBXd7hydsQYMEvxG@vger.kernel.org, AJvYcCWJbeG3DmnX6hIdcyKzQFsTSso8EyXLBL9tBTBKpZz4U6kRKwqvWtu4IA2okp1RBIvQ3vSG1LQRiWlC@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu2UnQ1ALmGcrEq9NxHX5+9nCXhNu4vAGYcDSWDRDYWOYl6Yfp
	iiJkexUXQt9e1Dph7+aWyetNfJwAspfpEqN2lusN+h0FKy+tQJDB
X-Google-Smtp-Source: AGHT+IEf92UBwMibwLg2cnnlzn7tvqyZvwNE4RFPFPHR7sCqtNSQ5vwBs/tIcPGYoQk/X7Gw5PHdpg==
X-Received: by 2002:a05:6402:5249:b0:5c2:4c8a:a8ba with SMTP id 4fb4d7f45d1cf-5c24c8aac1amr5260276a12.8.1725317744621;
        Mon, 02 Sep 2024 15:55:44 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:bc14:b544:1196:d1a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226c74184sm6040568a12.32.2024.09.02.15.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 15:55:44 -0700 (PDT)
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
Subject: [PATCH v1 4/7] net: smc91x: Make use of irq_get_trigger_type()
Date: Tue,  3 Sep 2024 00:55:31 +0200
Message-Id: <20240902225534.130383-5-vassilisamir@gmail.com>
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
 drivers/net/ethernet/smsc/smc91x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/smsc/smc91x.c b/drivers/net/ethernet/smsc/smc91x.c
index 907498848028..a5e23e2da90f 100644
--- a/drivers/net/ethernet/smsc/smc91x.c
+++ b/drivers/net/ethernet/smsc/smc91x.c
@@ -2355,7 +2355,7 @@ static int smc_drv_probe(struct platform_device *pdev)
 	 * the resource supplies a trigger, override the irqflags with
 	 * the trigger flags from the resource.
 	 */
-	irq_resflags = irqd_get_trigger_type(irq_get_irq_data(ndev->irq));
+	irq_resflags = irq_get_trigger_type(ndev->irq);
 	if (irq_flags == -1 || irq_resflags & IRQF_TRIGGER_MASK)
 		irq_flags = irq_resflags & IRQF_TRIGGER_MASK;
 
-- 
2.25.1


