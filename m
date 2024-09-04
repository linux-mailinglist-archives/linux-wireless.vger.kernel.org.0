Return-Path: <linux-wireless+bounces-12493-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1E396C2D8
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 17:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 945F81F21D39
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 15:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CBB1DFE37;
	Wed,  4 Sep 2024 15:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEhk6MZQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFC31DA63A;
	Wed,  4 Sep 2024 15:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725464970; cv=none; b=ostF4OVe8Y7+DDLaV7DtWfD0JmmPy6TS6NrMZ/uf5GCmnprKSW0czaOSrCFt2TvFE6EXWN+0rPi1Q7s+81gSoq6TONPFjcmIvM2rnNcfH25rbgtYX3Gaz1STn/9QYhdtTDVznZW07qJbkgHMPxzTAWJ7c5nlMfvY/RkyFu/ySt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725464970; c=relaxed/simple;
	bh=uOyPjGt0jQt2rh9a/QIkYjsMGeW+O2UMFkZJfXzINs0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bXi6hLY8e4+8D2hZQD1HzMCugz9kRVRw+Z1hZUVctXnZXHysO/hj7TT1Kwo+3Lzwkb+R2W05EZdtGsyotMSMq6vT2fc+n3L4liM46aXxUSwqGI+m2gDb8K+zskEHevBBtfJxbXnjxX8PGKPdCtPw0CL9dMHLomMAQ29dCjh3JNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEhk6MZQ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8695cc91c8so701458366b.3;
        Wed, 04 Sep 2024 08:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725464967; x=1726069767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNOha94p1Pn6xGxE05olLPJMp0FKiE02MSaHBlDjyGc=;
        b=IEhk6MZQvJ+WFthuNcylPVNq/d5miFzn6NDkt+KnwGrGGtkScvaMSjHjWzhjyCfJTj
         wKRMi4kdq9neF073EHLw2Aw5gLU2eUSm/13Xf7DeI3owmUNtoHtd6+VEGgCzadrpwhV/
         86AkNWdomjxML450pq+vAYmWIIo4Z9F/QnIkpz6hWmyYeouW8LJU2EigUvYmQQyKDPQE
         OX/9kxtZ5ZqgwMK355IIMHQ4lI9RfaaEV9ws+d9NiSJnbXAZ57TqUkIEwADEZ2MQkmxT
         bJ5zSN3wOuVP6kioVbaXnZgzjj+jUKo2SEM+GCwZiwSrjaJEgvPFbDKPzNBAXx7nMFab
         f76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725464967; x=1726069767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNOha94p1Pn6xGxE05olLPJMp0FKiE02MSaHBlDjyGc=;
        b=R2f+3TmDnYRx/14wIN/nF9hBC2x5ZNJ91DBtHrO05/VbjVN7S77s/T9ifVrB64+Bb/
         I34LnbFyJmwEdMqyU8tWDmQ4OYK6YHtWykUy8CVS38uGOGne1+FHbdFaN1mTLrgFeAj3
         np2Ghdm/fzYuSHYXv/Woam5RZNIHyr5B/wdXi/dbPey1VOKjTVFNSC/tCGYJ5zJWX2XI
         5+n1xh6Z7vvG4LRIFZCWwCeKgcVLOlwPsCgTbMtRL3Kcr27QTTr/QgQp82BK+UhAfdxc
         mM6WaPyN7f5Ls470r4orjpn2rzTqEZk/7ubT2SLv9ZO19PYjybKzd+OmRXs5kGQG1en0
         xHdQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6iC8qhOU08B9z4l5E0KTRcbg0TYgXLr7R5aqz26itBG7Zc5ZK1QE7vgM4Qg7TJnrB6EBxUFYp2SI+5MQ=@vger.kernel.org, AJvYcCWabSDRSrkRgEcKHywbm0r3LUqN7DgV5aQVCUby1K9z4BJPSoZgKOmpsyY1yJedLJprOxg4Jb2LcN5TpJc26wk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5thZsKcAV9UTIKTzzaMzHo9sSn+VljA0bTZuca19apRjYs56o
	tC4sqQU97Ho/nkoGVJGKqRTAatjSRWNaqI4lRPJDSYyjY0oKyNUY
X-Google-Smtp-Source: AGHT+IF+lxhGwhoMZYoepfp3gDH24Pru7uRsX8Up7mCHlBWZAoA5jp5kJqxxNCQetwbSZCOVjPziUA==
X-Received: by 2002:a17:907:3d87:b0:a7a:ab8a:38a with SMTP id a640c23a62f3a-a897f8614c4mr1423708966b.27.1725464966572;
        Wed, 04 Sep 2024 08:49:26 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:2f85:317:e13:c18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a62038c0asm7825566b.62.2024.09.04.08.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 08:49:25 -0700 (PDT)
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
Subject: [PATCH wireless-next v2 1/3] wifi: brcmfmac: of: Make use of irq_get_trigger_type()
Date: Wed,  4 Sep 2024 17:49:17 +0200
Message-Id: <20240904154919.118513-2-vassilisamir@gmail.com>
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

Convert irqd_get_trigger_type(irq_get_irq_data(irq)) cases to the more
simple irq_get_trigger_type().

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
index fe4f65756105..e2611f164fa8 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
@@ -138,7 +138,7 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
 		brcmf_err("interrupt could not be mapped\n");
 		return;
 	}
-	irqf = irqd_get_trigger_type(irq_get_irq_data(irq));
+	irqf = irq_get_trigger_type(irq);
 
 	sdio->oob_irq_supported = true;
 	sdio->oob_irq_nr = irq;
-- 
2.25.1


