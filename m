Return-Path: <linux-wireless+bounces-4174-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD24A86ABE9
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 11:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83FEE28A96F
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 10:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B50374CC;
	Wed, 28 Feb 2024 10:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jE9bnBwE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE1137143
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 10:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709115052; cv=none; b=ckUOL8Si/I/OKZSfK3Al7C/g5FgllUsukbm26d15IWc2YxoOQfk1YBmYp6j4h+Niz4AIL8pTAvbrosvAmZ1Ornt3FEHmiAQ67n4pmTnB/ouf2cF8tjYHIipxp8oVVsgu5G3MJgTU3g9aurjjcJ+icS1yS4bWL03H8ufq2RBTGaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709115052; c=relaxed/simple;
	bh=tdz0czbokXbZx8NoSb1bVuk3MM7myK0Cqgqnu3P9uqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u773IzCX23YY028ZcGwPTmuuGhwFdsDIHvA7wgxYqvH/M0sfullcKbiSkaRTHaJHNX91Dgkd9PHbhmQwwK5HVDTbRAW8/h1JuNZozlJq9UFX2JJPbMrFOEMwC8ZeLUli0J3tAVziZZcm3GQP0KDApPkOzamer0qmBS+OOHiI8sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jE9bnBwE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709115049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EDEC0vsrgcNRv6UvAcMAg7ZhZIrIeAEq54Sn/mnIp3o=;
	b=jE9bnBwEqRkOzPXuNoecXap5xf5GvkOqmolz4yT2Oi9b3t+nvF2RXQ3RLntF8/vzCy4B+z
	ZYvlpenEiHyRSaRPFpoiVWfHPzyJV/0uywd57FZQo71H15K8MwCW+QmAWTHaDBg694Nies
	4mzzqSvfTj+ZAZch5ZLfXIVR0b06YvM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-9bux0t8JMrCwLUL7NxhCSQ-1; Wed, 28 Feb 2024 05:10:46 -0500
X-MC-Unique: 9bux0t8JMrCwLUL7NxhCSQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40e40126031so28406345e9.0
        for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 02:10:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709115045; x=1709719845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EDEC0vsrgcNRv6UvAcMAg7ZhZIrIeAEq54Sn/mnIp3o=;
        b=MIj9iXygLeEcqhSiSeB1w9qcCqbwb2midlYbyNwjJpGEP/KJAQBboCy76xcTmFuPYd
         mIjZsSjY/luI/EibQtZnvXZlkSrBznZlZ9NwsHi+WXtUX67emNN2+Ee12siLSRL1kQfq
         tai1KCJqHust/fimi0cyUYYFRzGzWdWUWwG9I+AsAjN6EKl669Wc5cW9ndHkCz30hDBv
         o0mn7k9IYWDZBtf/4xiTFbNPyaC/UxwCJiaao46w5R0n1mMPwdbV+sPWGcP8uAxVDoB1
         xKFy0FkA5dKwLUiVtFJcmCnFUPevbReetXCJBVdlyEqK0oC/373l7xWA0HB2GavUe/OW
         CnlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGPHAm+yfFNFDcxXO+8/rid0d2WRBFKXav+pcyEm099PH0ECI2WkvWgP6PW34rHmM0yPE6aC49uvHubCnRsOkriHxcWO9xBJGYVbO+7vE=
X-Gm-Message-State: AOJu0Yxle4bVYu0xSuET+utv+t1i8E9f7B7H8e9n6ymuFG+/DyqLX7fM
	rkkcbEv4jz1JeZxvi/wqTuUd+YPeh56ka8Ps5ACIE291jL/PsX31v2Z6BpNzeDqpnaNeO18XV2n
	dVu5yARcie55YPfwS/xA4GpdiRNcMTXmaM83t1Kxm81/cR2TgIOh2f6jXfLsQ9Mrs
X-Received: by 2002:adf:e30e:0:b0:33d:6bd5:9f00 with SMTP id b14-20020adfe30e000000b0033d6bd59f00mr8878800wrj.41.1709115044908;
        Wed, 28 Feb 2024 02:10:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNBvyItDUcjcIv0Np/7pXiZKIT9CIiSDAQ+3HmvfjfhrAlJ9hPwCLMmeprtUdu0nI7lbpBTg==
X-Received: by 2002:adf:e30e:0:b0:33d:6bd5:9f00 with SMTP id b14-20020adfe30e000000b0033d6bd59f00mr8878785wrj.41.1709115044551;
        Wed, 28 Feb 2024 02:10:44 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bo28-20020a056000069c00b0033b406bc689sm14668667wrb.75.2024.02.28.02.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 02:10:44 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Breno Leitao <leitao@debian.org>,
	Kalle Valo <kvalo@kernel.org>,
	Li Zetao <lizetao1@huawei.com>,
	linux-wireless@vger.kernel.org
Subject: [PATCH v2] wlcore: sdio: Rate limit wl12xx_sdio_raw_{read,write}() failures warns
Date: Wed, 28 Feb 2024 11:10:32 +0100
Message-ID: <20240228101042.728881-1-javierm@redhat.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When these failures happen, the warning and call trace is printed which is
excessive. Instead, just print the error but rate limited to prevent warns
to unnecessarily pollute the kernel log buffer and make the serial console
practically unusable.

For example, on an AM625 BeaglePlay board where accessing a SDIO WiFi chip
fails with an -110 (ETIMEDOUT) error:

  $ dmesg | grep "sdio write\|read failed (-110)" | wc -l
  39

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Breno Leitao <leitao@debian.org>
---

Changes in v2:
- Add Reviewed-by tag by Breno Leitao.
- Drop warns which seems excesive and rate limit the error (Kalle Vallo).

 drivers/net/wireless/ti/wlcore/sdio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/sdio.c b/drivers/net/wireless/ti/wlcore/sdio.c
index eb5482ed76ae..70b9648acaaf 100644
--- a/drivers/net/wireless/ti/wlcore/sdio.c
+++ b/drivers/net/wireless/ti/wlcore/sdio.c
@@ -75,8 +75,8 @@ static int __must_check wl12xx_sdio_raw_read(struct device *child, int addr,
 
 	sdio_release_host(func);
 
-	if (WARN_ON(ret))
-		dev_err(child->parent, "sdio read failed (%d)\n", ret);
+	if (ret)
+		dev_err_ratelimited(child->parent, "sdio read failed (%d)\n", ret);
 
 	if (unlikely(dump)) {
 		printk(KERN_DEBUG "wlcore_sdio: READ from 0x%04x\n", addr);
@@ -120,8 +120,8 @@ static int __must_check wl12xx_sdio_raw_write(struct device *child, int addr,
 
 	sdio_release_host(func);
 
-	if (WARN_ON(ret))
-		dev_err(child->parent, "sdio write failed (%d)\n", ret);
+	if (ret)
+		dev_err_ratelimited(child->parent, "sdio write failed (%d)\n", ret);
 
 	return ret;
 }
-- 
2.43.2


