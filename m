Return-Path: <linux-wireless+bounces-12351-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0908969036
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 00:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 682511F23D8B
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 22:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6EA190693;
	Mon,  2 Sep 2024 22:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxJ2Tn/N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFFC18DF98;
	Mon,  2 Sep 2024 22:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725317754; cv=none; b=hHwObfEhteNz3bmLRDwslVBcQtS3taM8mlmbsnq9UtjxNxtXUNXIMFTfK/Ly4+M0qTT3tVBdBjzGiNmeTPQqzqvVA0aNMWt9GhtbW6nf5S2vMJGrnl53i6sfPZVCzaGVHUxB0UNMYEO5RUzbXx4fYsNCgZiXVYa0lI/iBl2znbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725317754; c=relaxed/simple;
	bh=aG0ldiriHfw927e+9EU0XgBJ1LEe6dToHI6YishVZBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OqQNf5Y+tYXEH061Qd0eW3MrtXl7hXIpXTnEFHC4YNc8bBLWYeY1usBVAwYyi+iufQxCe/wU4ocvAmB4hL9P4at7ZY+NpdOqKjgnxb01wEK7kPybkoaEa+wz4EYJVrwgjIzyS6L90ozlqvMLg9YB4oKR4oFZ36Vdy1wuMXYe9zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UxJ2Tn/N; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5bf01bdaff0so4327290a12.3;
        Mon, 02 Sep 2024 15:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725317750; x=1725922550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3M3zrQ4HRuBwzDNVnr3UQEv7suH9Jl1q9Q4EWJeNzEg=;
        b=UxJ2Tn/NwAB+5WxThqF1mRJ9kfoMMK1IrBlRTio4GEu6t2o3GL1Fy8EkZnmMbWZTrM
         QOUI1azePvQZ3sfReS2Lh3a3OlLjQzE8EddtCqxO6k0pPocDuc/rH+Ou/QbtCabEkz0p
         AdCKJH+tvoYK1yLsypTzgz/JFBehMkefjHa0szPY5trD/tXY2z1UNWcTeT+4/tNtkK5C
         Rr9EYSVh4I/Pm/Qb4sVHUN0scoUnVAAFrXNdIRP95bfpaJhfTVa58gql3HhhrLMG30eE
         pX2KRh5tbsVVEeEnD2906tPBuOalBnYwgF8pTum8greDVnHUe9CILUW3e0pAVECfPJws
         LorA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725317750; x=1725922550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3M3zrQ4HRuBwzDNVnr3UQEv7suH9Jl1q9Q4EWJeNzEg=;
        b=HmVYVaER1CTdXQnSnAzBaWoIWJpZ28biqd8KU7ij6BYGtdbNzL487zy652jBPYWo/Q
         UJxzQSt8EULwznhl3tKnQsJ1vVJSXbmZD2Kmsjwb3pLad/fnNAeXceOCQ1NNYqzXXZqJ
         YQebV95euQjRJrXMy7cNlfgdka0eABfSD4+c5NQZ0svAGN3RBtUEnb+LWXgcPNzbFI5q
         +kR+EmBTfoMbHY/McpZ3bYuzugefcAX6aJSiVV/kDCucVY3KF8hVRIwDYPkL1b+vGHL5
         hV36ffso2jz93uampb2LGt9oEGqSrMzpE+f8d+61gvg8C3/cAwbqjoFbl03MfbrX0/ug
         32iA==
X-Forwarded-Encrypted: i=1; AJvYcCUrS618NvNKUNCP/V6CmZPWwlyATFJUKb0KA8a0CxFRnPR2FZuhBiGxnz1lu1xnNbDO4PLWcGVh4CR6lrborrU=@vger.kernel.org, AJvYcCWVW/NWetxyHQS7vyYyFr6JpYAAkecEFqwuy+XeA7li93uqQHyEiSTZW0bMcbuVSTOSaocehMMk2a+u@vger.kernel.org, AJvYcCXj9cwOW2GRhnlfemlLP+Ger3TjFGTYvZ0dyf6w/IFtyNixVx5pkznGEXJxpK2LSJF9aOt6jF8R@vger.kernel.org
X-Gm-Message-State: AOJu0YyA651ZGdVOxmwaZ8E4HuJN+gwKACdIzKq0NksXLX9RJoJZigIa
	L9uP9cJcdFlVepp0790+THi69lg5tVPc83jMVkbNNOwxGW/lnmSA
X-Google-Smtp-Source: AGHT+IH90LXc7EwUasb8l0337BP8vUcyXOMkNHmERTlLixA2VuUgFhtFY6H5/0/XcuBxznM4NJTdXg==
X-Received: by 2002:a05:6402:5107:b0:5c2:4740:93ec with SMTP id 4fb4d7f45d1cf-5c247409981mr4161897a12.9.1725317749721;
        Mon, 02 Sep 2024 15:55:49 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:bc14:b544:1196:d1a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226c74184sm6040568a12.32.2024.09.02.15.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 15:55:49 -0700 (PDT)
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
Subject: [PATCH v1 7/7] of/irq: Make use of irq_get_trigger_type()
Date: Tue,  3 Sep 2024 00:55:34 +0200
Message-Id: <20240902225534.130383-8-vassilisamir@gmail.com>
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
 drivers/of/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 36351ad6115e..5d27b20634d3 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -430,7 +430,7 @@ int of_irq_to_resource(struct device_node *dev, int index, struct resource *r)
 					      &name);
 
 		r->start = r->end = irq;
-		r->flags = IORESOURCE_IRQ | irqd_get_trigger_type(irq_get_irq_data(irq));
+		r->flags = IORESOURCE_IRQ | irq_get_trigger_type(irq);
 		r->name = name ? name : of_node_full_name(dev);
 	}
 
-- 
2.25.1


